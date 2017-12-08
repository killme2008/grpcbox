-module(grpc_testing_test_service).

-behaviour(grpc_testing_test_service_bhvr).

-export([empty_call/2,
         unary_call/2,
         cacheable_unary_call/2,
         streaming_output_call/2,
         streaming_input_call/2,
         full_duplex_call/2,
         half_duplex_call/2,
         unimplemented_call/2]).

-spec empty_call(ctx:ctx(), test_pb:'grpc.testing.Empty'()) ->
                        {ok, test_pb:'grpc.testing.Empty'()} | grpcbox_stream:grpc_error_response().
empty_call(Ctx, _Empty) ->
    {ok, #{}, Ctx}.

-spec unary_call(ctx:ctx(), test_pb:'grpc.testing.SimpleRequest'()) ->
                        {ok, test_pb:'grpc.testing.SimpleResponse'()} | grpcbox_stream:grpc_error_response().
unary_call(Ctx, #{response_size := Size}) ->
    Body = << <<0>> || _ <- lists:seq(1, Size) >>,
    {ok, #{payload => #{type => 'COMPRESSABLE',
                        body => Body
                       },
           username => <<"tsloughter">>,
           oauth_scope => <<"some-scope">>
          }, Ctx}.

-spec cacheable_unary_call(ctx:ctx(), test_pb:'grpc.testing.SimpleRequest'()) ->
    {ok, test_pb:'grpc.testing.SimpleResponse'()} | grpcbox_stream:grpc_error_response().
cacheable_unary_call(Ctx, _SimpleRequest) ->
    {ok, #{}, Ctx}.

-spec streaming_output_call(test_pb:'grpc.testing.StreamingOutputCallRequest'(), grpcbox_stream:t()) ->
                                   ok | grpcbox_stream:grpc_error_response().
streaming_output_call(_StreamingOutputCallRequest, _Stream) ->
    ok.

-spec streaming_input_call(reference(), grpcbox_stream:t()) ->
                                  {ok, test_pb:'grpc.testing.StreamingInputCallResponse'()} |
                                  grpcbox_stream:grpc_error_response().
streaming_input_call(_Ref, _Stream) ->
    {ok, #{}}.

-spec full_duplex_call(reference(), grpcbox_stream:t()) ->
                              ok | grpcbox_stream:grpc_error_response().
full_duplex_call(_Ref, _Stream) ->
    ok.

-spec half_duplex_call(reference(), grpcbox_stream:t()) ->
    ok | grpcbox_stream:grpc_error_response().
half_duplex_call(_Ref, _Stream) ->
    ok.

-spec unimplemented_call(ctx:ctx(), test_pb:'grpc.testing.Empty'()) ->
    {ok, test_pb:'grpc.testing.Empty'()} | grpcbox_stream:grpc_error_response().
unimplemented_call(Ctx, _Empty) ->
    {ok, #{}, Ctx}.
