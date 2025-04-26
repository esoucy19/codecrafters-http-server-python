import cchttp


class TestSocket(cchttp.Socket): ...


def test_curl_returns_http200():
    expected = "HTTP/1.1 200 OK\r\n\r\n"
    with TestSocket(host="localhost", port=4221) as soc:
        soc.buffer.append("")
        srv = cchttp.Server(soc)
        with srv.listen() as con:
            while True:
                try:
                    data = con.recv()
                    assert(data == expected)
                except ConnectionClosedError:
                    break
