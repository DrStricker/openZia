/*
** EPITECH PROJECT, 2020
** CPP_zia_2019
** File description:
** HTTP Base definitions
*/

#include <cinttypes>

namespace oZ::HTTP
{
    /**
     * @brief HTTP Version structure
     */
    struct Version { std::uint8_t major; std::uint8_t minor; };

    /**
     * @brief HTTP 1.1 Codes
     */
    enum class Code {
        Undefined                   = 0,

        Continue                     = 100,
        SwitchingProtocols           = 101,

        OK                           = 200,
        Created                      = 201,
        Accepted                     = 202,
        NonAuthoritativeInformation  = 203,
        NoContent                    = 204,
        ResetContent                 = 205,
        PartialContent               = 206,

        MultipleChoices              = 300,
        MovedPermanently             = 301,
        Found                        = 302,
        SeeOther                     = 303,
        NotModified                  = 304,
        UseProxy                     = 305,
        TemporaryRedirect            = 307,

        BadRequest                   = 400,
        Unauthorized                 = 401,
        PaymentRequired              = 402,
        Forbidden                    = 403,
        NotFound                     = 404,
        MethodNotAllowed             = 405,
        NotAcceptable                = 406,
        ProxyAuthenticationRequired  = 407,
        RequestTimeOut               = 408,
        Conflict                     = 409,
        Gone                         = 410,
        LengthRequired               = 411,
        PreconditionFailed           = 412,
        RequestEntityTooLarge        = 413,
        RequestURITooLarge           = 414,
        UnsupportedMediaType         = 415,
        RequestedRangeNotSatisfiable = 416,
        ExpectationFailed            = 417,

        InternalServerError          = 500,
        NotImplemented               = 501,
        BadGateway                   = 502,
        ServiceUnavailable           = 503,
        GatewayTimeOut               = 504,
        HTTPVersionNotSupported      = 505
    };

    /**
     * @brief HTTP 1.1 Methods
     */
    enum class Method {
        NullMethod = 0,
        Option,
        Get,
        Head,
        Post,
        Put,
        Delete,
        Trace,
        Connect,
        MethodCount
    };

    /**
     * @brief Converts a Method enum case to a HTTP method name
     */
    constexpr const char *MethodName(const Method method) noexcept {
        switch (method) {
        case Method::NullMethod:
            return "NULL_METHOD";
        case Method::Option:
            return "OPTION";
        case Method::Get:
            return "GET";
        case Method::Head:
            return "HEAD";
        case Method::Post:
            return "POST";
        case Method::Put:
            return "PUT";
        case Method::Delete:
            return "DELETE";
        case Method::Trace:
            return "TRACE";
        case Method::Connect:
            return "CONNECT";
        }
    }
}