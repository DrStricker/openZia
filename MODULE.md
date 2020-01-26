# Module implementation
In this section we will take a closer look at the class IModule, and all its components.

```C++
// Module interface
class IModule;
// Module polymorphic instance
using ModulePtr = std::shared_ptr<IModule>
```
We use shared pointers to store instantiated modules. This allows holding a reference to a module while asserting its existence.

 ## Must have functions
 Each module have a set of virtual function to be override. Actually, only 2 of them are pure virtual :
 ```C++
// Get the raw string name of module instance
virtual const char *getName(void) const = 0;

// Register module's callbacks to the pipeline
virtual void onRegisterCallbacks(Pipeline &pipeline) = 0;
```

### HowTo: HTTP module
Let's see a simple example with an independent HTTP Module:
```C++
class HTTPModule : public oZ::IModule
{
public:
	// Get the raw string name of module instance
	virtual const char *getName(void) const { return "HTTPModule"; }

	// Register module's callbacks to the pipeline
	virtual void onRegisterCallbacks(oZ::Pipeline &pipeline) {
		pipeline.registerCallback(
			oZ::State::Parse, // Callback triggered when parsing the HTTP request
			oZ::Priority::ASAP, // As soon as possible
			this, &HTTPModule::onParseHeader // Actual function callback
		);
	}
	void onParseHeader(oZ::Context &context) {
		const auto &byteArray = context.getByteArray();
		auto &request = context.getRequest();
		auto &header = request.getHeader();
		// Parse 'byteArray' to fill 'header' and 'request' data
	}
};
```
And that's it ! You don't have to implement anything else to create an independent module.

## Optional functions
However, there are more virtual functions for more complex needs. These functions are default-implemented to let you the choice of using them or not.
```C++
// Get the list of dependencies (as a vector of raw string, see function getName above)
virtual Dependencies getDependencies(void) const noexcept;

// Given a pipeline reference, find each dependent module to store them internally
virtual void onRetreiveDependencies(Pipeline &pipeline);

// Given a directory path (where all configs are), load module's configuration file
virtual void onLoadConfigurationFile(const std::string &directory);
```

### HowTo: Dependencies
Let's first see how dependencies are handled given a short example:

```C++
class ChildModule : public oZ::IModule
{
public:
	virtual const char *getName(void) const { return "Child"; }
	virtual void onRegisterCallbacks(oZ::Pipeline &pipeline) { ... }
};

class RootModule : public oZ::IModule
{
public:
	virtual const char *getName(void) const { return "Root"; }
	virtual void onRegisterCallbacks(oZ::Pipeline &pipeline) { ... }

	// Return the list of dependencies
	virtual Dependencies getDependencies(void) const noexcept { return { "Child" }; }

	// Find dependencies and store them before any process for performance reasons
	virtual void onRetreiveDependencies(oZ::Pipeline &pipeline) {
		_child = pipeline.findModule<ChildModule>();
	}

private:
	std::shared_ptr<ChildModule> _child;
};
```

### HowTo: Configuration file
Let's see how simple it is to add a configuration file to setup a module.
Please note that the configuration file language is totally up to you, in this example it is named *MyCustomConfigLoader*.
```C++
// Import your own config loader
#include "MyCustomConfigLoader.hpp"

class MyModule : public oZ::IModule
{
public:
	static const auto *FileName = "MyModule.conf";

	virtual const char *getName(void) const { return "My" };
	virtual void onRegisterCallbacks(oZ::Pipeline &pipeline) { ... }

	// Open configuration file and load some properties using MyCustomConfigLoader
	virtual void onLoadConfigurationFile(const std::string &directory) {
		auto config = MyCustomConfigLoader::Parse(directory + FileName);
		_x = config["x"].toInt();
		_y = config["y"].toInt();
	}

private:
	int _x = 0, _y = 0;
};
```