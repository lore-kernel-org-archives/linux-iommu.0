Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4B1F9AAD
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128076; cv=none; b=VxRNi0iPiMdP/86MbNMqz77GovshzD1FipNv2BYSTgxRCxu1OVqSuJbnPtUmWrFH4tvdaWiQLW8C6jynpKx0r/y1KuLHQ0rYW+W4pjY+y3BX5XRV5GUThppjsJA7q7om2rPrYtV84hkOJlkCfI9cNulOTmIKh8z7t/Y/Tx5KGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128076; c=relaxed/simple;
	bh=rgmP7IRPapdyM00KytQd+l/oRf7Nj76V9zYC2A411XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdAq6C6VMZlw3JyKL7h/PWS8hkqYTKOfZ1jLoGpjiVuDVC0eiZdTsMFJw8eHY19Eb8LB8eU5ttag0KtYt5hOedGvQEGGkGTZzpoP9Kl7EzNuQw8wcWOA3Ybav9xnfUWF5H+2Q9iTBQ7gORAnxMX8pbufOSQG6Mh1wwcLGX2B5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Io6cMRJ6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Io6cMRJ6"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e1f12c82so2279198f8f.2
        for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 00:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733128072; x=1733732872; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rgmP7IRPapdyM00KytQd+l/oRf7Nj76V9zYC2A411XM=;
        b=Io6cMRJ6kgPER/TEx8cRvo06cNkLnpAM6se7fF5d/83FLxLUn7qhQ4Qpgxu7e7kOcx
         bkQ/81PzsJ2nQnP24hCHtImE7HYRCUoRH4+qsv5tK6NcS0QVL87esu1eVzNQVmKMq6ts
         FtE+jiP0iqwdCQQada+cP0oFttTFAVc5tV5yWKwdEv5aW6ea8IJ6Obh3+6BVoESEXhL+
         XLGm5Rlnp71LJz9nn1//STYTwnS8oN65usnCQ90p2kiO78Hy34A4RGGviZ25YKcgM8dT
         zRSsuOQqpmcjPZ9TToveH7BZjuCaxTGvIoSWAg5KxCGcEK5RxiGYB3toLntZD3kCDpJL
         lnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128072; x=1733732872;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgmP7IRPapdyM00KytQd+l/oRf7Nj76V9zYC2A411XM=;
        b=c02/PJjhwRuUTz6OAX3yzK1dToIsSlTmfpBytUm6AUHCSLT1GQ6sK706ZtKv1Qk87y
         WmO9GY5MHYzJwiAbgwTTE3PbmM/kzvKPVj14izVR2Vrh690BCtZgb4a6Oytqwb6eUXW7
         MvoxnaV3Tg3/55iIXAeHPmgXLzXwJjkTPhbkOQF0ecNiPdcUYW6eZwJ8lK4C9bbHFeXP
         Xr7QzNkDOJRnBaMWBh91IG0VsrHeOJp+DcaY6usIPuMucSFp7tDaPsYz94ZR+Q5YXFKM
         WB95R8b13Dc+3ncXpRHcZq+giL13Lb9TeN0c3AcP+PcAHbrQBLS/X16Qzs63h8Aen39x
         hTyw==
X-Forwarded-Encrypted: i=1; AJvYcCVZgfnygc0dZl9nbd5dpWNy/yM6x39QRunKXA4NbdoDoAWgkDKQm+din/mBtVl/2DoX4wb3ng==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSIH5OyJVqy2RLdn4dNKjRwFzZKCjN5msOtSIyAcuWuoews8Fx
	9pEitly+OIlL1ou8jtafSPnRuD2zc0RGaf1+7YpNjdf2Bzp2vuabjgZ2FQQ/b8s=
X-Gm-Gg: ASbGncsxyrvBpMEY5ZwCTBmTNPq6aI/PfgYAWZ+iub6N3JUNEEi83r4163GbEto4bvq
	wkhpuzkh+oaQb5fIwCrKysecGtEns+MMv+9a12/zONzvSFUMUX/g6DehevKPGtZC7kL3OGWM6Gz
	auwR1BS5VruYQxGhxyWnkgrWCpGgw74vDpuwn62gX8PW6zqozIayaBAQLEi3WQdQ0W922sKv4ka
	ocxrqQgwnv7ETBEndSWE6Mbrh/vI+j9fE3rtyjV/2B0s/aJ4lNbxMrU5y651aMYD+2ef+rR/YCE
	YrbT+7Ww/ZefcY31FbDiqJwTz/fsGhBuZd5EemT3/0RUSouV0wWKUHMG6EuWVEIi2auO6pG8Z6w
	=
X-Google-Smtp-Source: AGHT+IHCew4p32M0fnntOLTxvXn5rhPcZ/Oxoj8redCrFVYAiUiu7LZghywbN0mQOwwTkZ319CdZ2g==
X-Received: by 2002:a5d:5f43:0:b0:385:f66a:4271 with SMTP id ffacd0b85a97d-385f66a4481mr1226523f8f.4.1733128072319;
        Mon, 02 Dec 2024 00:27:52 -0800 (PST)
Received: from ?IPV6:2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c? (p200300e5872eb100d3c7e0c05e3baa1c.dip0.t-ipconnect.de. [2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ed8dee66sm3853882f8f.104.2024.12.02.00.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:27:51 -0800 (PST)
Message-ID: <2d4fd45a-2461-441e-a116-3b6cff18ee9e@suse.com>
Date: Mon, 2 Dec 2024 09:27:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
To: Thierry Escande <thierry.escande@vates.tech>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, jbeulich@suse.com
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
 <e6ceb22d-3fa7-430c-9410-3c5ffd9ded2d@vates.tech>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <e6ceb22d-3fa7-430c-9410-3c5ffd9ded2d@vates.tech>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cqzeUayVGoZI9y6WbVrHfeVr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cqzeUayVGoZI9y6WbVrHfeVr
Content-Type: multipart/mixed; boundary="------------YLCLZf9pp80BxTgr2PYG6yMv";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Thierry Escande <thierry.escande@vates.tech>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, jbeulich@suse.com
Message-ID: <2d4fd45a-2461-441e-a116-3b6cff18ee9e@suse.com>
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
 <e6ceb22d-3fa7-430c-9410-3c5ffd9ded2d@vates.tech>
In-Reply-To: <e6ceb22d-3fa7-430c-9410-3c5ffd9ded2d@vates.tech>
Autocrypt-Gossip: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJ3BBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AAIQkQoDSui/t3IH4WIQQ+pJkfkcoLMCa4X6CgNK6L+3cgfgn7AJ9DmMd0SMJE
 ePbc7/m22D2v04iu7ACffXTdZQhNl557tJuDXZSBxDmW/tLOwU0EWTecRBAIAIK5OMKMU5R2
 Lk2bbjgX7vyQuCFFyKf9rC/4itNwhYWFSlKzVj3WJBDsoi2KvPm7AI+XB6NIkNAkshL5C0kd
 pcNd5Xo0jRR5/WE/bT7LyrJ0OJWS/qUit5eNNvsO+SxGAk28KRa1ieVLeZi9D03NL0+HIAtZ
 tecfqwgl3Y72UpLUyt+r7LQhcI/XR5IUUaD4C/chB4Vq2QkDKO7Q8+2HJOrFIjiVli4lU+Sf
 OBp64m//Y1xys++Z4ODoKh7tkh5DxiO3QBHG7bHK0CSQsJ6XUvPVYubAuy1XfSDzSeSBl//C
 v78Fclb+gi9GWidSTG/4hsEzd1fY5XwCZG/XJJY9M/sAAwUH/09Ar9W2U1Qm+DwZeP2ii3Ou
 14Z9VlVVPhcEmR/AFykL9dw/OV2O/7cdi52+l00reUu6Nd4Dl8s4f5n8b1YFzmkVVIyhwjvU
 jxtPyUgDOt6DRa+RaDlXZZmxQyWcMv2anAgYWGVszeB8Myzsw8y7xhBEVV1S+1KloCzw4V8Z
 DSJrcsZlyMDoiTb7FyqxwQnM0f6qHxWbmOOnbzJmBqpNpFuDcz/4xNsymJylm6oXiucHQBAP
 Xb/cE1YNHpuaH4SRhIxwQilCYEznWowQphNAbJtEKOmcocY7EbSt8VjXTzmYENkIfkrHRyXQ
 dUm5AoL51XZljkCqNwrADGkTvkwsWSvCSQQYEQIACQUCWTecRAIbDAAKCRCgNK6L+3cgfuef
 AJ9wlZQNQUp0KwEf8Tl37RmcxCL4bQCcC5alCSMzUBJ5DBIcR4BY+CyQFAs=

--------------YLCLZf9pp80BxTgr2PYG6yMv
Content-Type: multipart/mixed; boundary="------------u48cR0db4DRmFDg6gYOPKEyz"

--------------u48cR0db4DRmFDg6gYOPKEyz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMTEuMjQgMTg6MzYsIFRoaWVycnkgRXNjYW5kZSB3cm90ZToNCj4gSGksDQo+IA0K
PiBPbiAxNi8wOS8yMDI0IDA4OjQ3LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMveGVuL3N3aW90bGIteGVuLmMgYi9kcml2ZXJzL3hlbi9zd2lvdGxi
LXhlbi5jDQo+PiBpbmRleCAzNTE1NTI1OGE3ZTIuLmRkZjViMWRmNjMyZSAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMveGVuL3N3aW90bGIteGVuLmMNCj4+ICsrKyBiL2RyaXZlcnMveGVu
L3N3aW90bGIteGVuLmMNCj4+IEBAIC03OCw5ICs3OCwxNSBAQCBzdGF0aWMgaW5saW5lIGlu
dCByYW5nZV9zdHJhZGRsZXNfcGFnZV9ib3VuZGFyeShwaHlzX2FkZHJfdCBwLCBzaXplX3Qg
c2l6ZSkNCj4+ICAgew0KPj4gICAJdW5zaWduZWQgbG9uZyBuZXh0X2JmbiwgeGVuX3BmbiA9
IFhFTl9QRk5fRE9XTihwKTsNCj4+ICAgCXVuc2lnbmVkIGludCBpLCBucl9wYWdlcyA9IFhF
Tl9QRk5fVVAoeGVuX29mZnNldF9pbl9wYWdlKHApICsgc2l6ZSk7DQo+PiArCXBoeXNfYWRk
cl90IGFsZ24gPSAxVUxMIDw8IChnZXRfb3JkZXIoc2l6ZSkgKyBQQUdFX1NISUZUKTsNCj4+
ICAgDQo+PiAgIAluZXh0X2JmbiA9IHBmbl90b19iZm4oeGVuX3Bmbik7DQo+PiAgIA0KPj4g
KwkvKiBJZiBidWZmZXIgaXMgcGh5c2ljYWxseSBhbGlnbmVkLCBlbnN1cmUgRE1BIGFsaWdu
bWVudC4gKi8NCj4+ICsJaWYgKElTX0FMSUdORUQocCwgYWxnbikgJiYNCj4+ICsJICAgICFJ
U19BTElHTkVEKG5leHRfYmZuIDw8IFhFTl9QQUdFX1NISUZULCBhbGduKSkNCj4+ICsJCXJl
dHVybiAxOw0KPiANCj4gVGhlcmUgaXMgYSByZWdyZXNzaW9uIGluIHRoZSBtcHQzc2FzIGRy
aXZlciBiZWNhdXNlIG9mIHRoaXMgY2hhbmdlLg0KPiBXaGVuLCBpbiBhIGRvbTAsIHRoaXMg
ZHJpdmVyIGNyZWF0ZXMgaXRzIERNQSBwb29sIGF0IHByb2JlIHRpbWUgYW5kDQo+IGNhbGxz
IGRtYV9wb29sX3phbGxvYygpIChzZWUgWzFdKSwgdGhlIGNhbGwgdG8NCj4gcmFuZ2Vfc3Ry
YWRkbGVzX3BhZ2VfYm91bmRhcnkoKSAoZnJvbSB4ZW5fc3dpb3RsYl9hbGxvY19jb2hlcmVu
dCgpKQ0KPiByZXR1cm5zIDEgYmVjYXVzZSBvZiB0aGUgYWxpZ25tZW50IGNoZWNrcyBhZGRl
ZCBieSB0aGlzIHBhdGNoLiBUaGVuIHRoZQ0KPiBjYWxsIHRvIHhlbl9jcmVhdGVfY29udGln
dW91c19yZWdpb24oKSBpbiB4ZW5fc3dpb3RsYl9hbGxvY19jb2hlcmVudCgpDQo+IGZhaWxz
IGJlY2F1c2UgdGhlIHBhc3NlZCBzaXplIG9yZGVyIGlzIHRvbyBiaWcgKD4gTUFYX0NPTlRJ
R19PUkRFUikuDQo+IFRoaXMgZHJpdmVyIHNldHMgdGhlIHBvb2wgYWxsb2NhdGlvbiBibG9j
ayBzaXplIHRvIDIuMysgTUJ5dGVzLg0KPiANCj4gIEZyb20gcHJldmlvdXMgZGlzY3Vzc2lv
bnMgb24gdGhlIHYxIHBhdGNoLCB0aGVzZSBjaGVja3MgYXJlIG5vdA0KPiBuZWNlc3Nhcnkg
ZnJvbSB4ZW5fc3dpb3RsYl9hbGxvY19jb2hlcmVudCgpIHRoYXQgYWxyZWFkeSBlbnN1cmVz
DQo+IGFsaWdubWVudCwgcmlnaHQ/DQoNCkl0IGVuc3VyZXMgYWxpZ25tZW50IHJlZ2FyZGlu
ZyBndWVzdCBwaHlzaWNhbCBtZW1vcnksIGJ1dCBpdCBkb2Vzbid0IGRvDQpzbyBmb3IgbWFj
aGluZSBtZW1vcnkuDQoNCkZvciBETUEgbWFjaGluZSBtZW1vcnkgcHJvcGVyIGFsaWdubWVu
dCBtaWdodCBiZSBuZWVkZWQsIHRvbywgc28gdGhlDQpjaGVjayBpcyByZXF1aXJlZC4gQXMg
YW4gZXhhbXBsZSwgc29tZSBjcnlwdG8gZHJpdmVycyBzZWVtIHRvIHJlbHkgb24NCnByb3Bl
ciBtYWNoaW5lIG1lbW9yeSBhbGlnbm1lbnQsIHdoaWNoIHdhcyB0aGUgcmVhc29uIGZvciB0
aG9zZSBjaGVja3MNCnRvIGJlIGFkZGVkLg0KDQpQb3NzaWJsZSBzb2x1dGlvbnMgaW5jbHVk
ZToNCg0KLSByaXNpbmcgdGhlIE1BWF9DT05USUdfT1JERVIgbGltaXQgKHRvIHdoaWNoIHZh
bHVlPykNCi0gYWRkaW5nIGEgd2F5IHRvIGFsbG9jYXRlIGxhcmdlIERNQSBidWZmZXJzIHdp
dGggcmVsYXhlZCBhbGlnbm1lbnQNCiAgIHJlcXVpcmVtZW50cyAodGhpcyB3aWxsIGltcGFj
dCB0aGUgd2hvbGUgRE1BIGluZnJhc3RydWN0dXJlIHBsdXMNCiAgIGRyaXZlcnMgbGlrZSBt
cDNzYXMgd2hpY2ggd291bGQgbmVlZCB0byB1c2UgdGhlIG5ldyBpbnRlcmZhY2UpDQotIG1v
ZGlmeSB0aGUgbXB0M3NhcyBkcml2ZXIgdG8gc3RheSB3aXRoaW4gdGhlIGN1cnJlbnQgbGlt
aXRzDQotIG9ubHkgZ3VhcmFudGVlIHByb3BlciBtYWNoaW5lIG1lbW9yeSBhbGlnbm1lbnQg
dXAgdG8gTUFYX0NPTlRJR19PUkRFUg0KICAgKHJpc2tpbmcgdG8gaW50cm9kdWNlIGhhcmQg
dG8gZGlhZ25vc2UgYnVncyBmb3IgdGhlIHJhcmUgdXNlIGNhc2VzIG9mDQogICBzdWNoIGxh
cmdlIGJ1ZmZlcnMpDQoNCg0KSnVlcmdlbg0K
--------------u48cR0db4DRmFDg6gYOPKEyz
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------u48cR0db4DRmFDg6gYOPKEyz--

--------------YLCLZf9pp80BxTgr2PYG6yMv--

--------------cqzeUayVGoZI9y6WbVrHfeVr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmdNb4YFAwAAAAAACgkQsN6d1ii/Ey8i
owf/TcDODvWNKhz2VeRgdGyE7HG1+otkteHBaLk+f4aNs23ObF6X7Eravdqcc39HkM7V+U1KRQba
j0VvZVkgmnrnvbWVNmvDXvlrcWfAurH+29rJUNHZWTtiPPpQ6Y+yYeCfhhvtweoKSY4wY//7sfSK
LdmmrXyQMhyFGF8VMhbcpXtp+3Ep7ChdpJnlQxo2TchCzYW75cV+SwkCOM3+F7MknUlcYIwPTmxD
2ODvXeNIWVZsOjeXB3pxsrn0szX4c0OVf4LnmbdE0ZfY42oRNtKB3pafJIBAk71wdgS7/Pf/tut5
fotoeuKAermUDfRksDgHxVMYeJgV0CXVXx24/bgpHA==
=A3ah
-----END PGP SIGNATURE-----

--------------cqzeUayVGoZI9y6WbVrHfeVr--
