Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5B19CC27
	for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739620082; cv=none; b=JqXHPht1vILJMMPoq+ISw2eZEVS15zjP/wjhOgq5aC+Y3jwWjZfOIpemliAx/Nnuvi2HOnAs3AAgYjwBUE1Vfjx8043MTZIwH2OQnHvLRL0gd6iPOGxj3DpsMYNpNS8TqY2aDrmF9f5AAPYRb7JShtXb0nkTW5oynSwZJV4lBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739620082; c=relaxed/simple;
	bh=Umszq55zr2ydVirX4cX0YyqP04V4YxVqeM14wzK7Gek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKxBs/nbgaF628qw3WqunFgSz09r1Plq6Z5WQHnubL9ZjKtDTJunzoJLyIdVWji/uoMLJaWRwnr94+GI7Ll7QLxftpMqVRUoiDBMOYtPqQDfUQzBSlXtfxFlCamfMGARUsvWlgrJC5QRRzsXlRqgYeXhgZl3M9hdEfUOUss6wdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MXs83VpD; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MXs83VpD"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-abb7f539c35so45387766b.1
        for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 03:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739620079; x=1740224879; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Umszq55zr2ydVirX4cX0YyqP04V4YxVqeM14wzK7Gek=;
        b=MXs83VpDlFy9mf+TY/zm4cNvkxaN/bblV87eHHpNWlgtxU0ml4h91Airuw/qfr80eF
         3+QvGB1WEor3Ac7hDoo25f9YrXopFIs1S3927zeUASyobyawthQM+Rh/EgrHubfo6PdJ
         no9dvLoysx6DTknxaNX5z5m5IMfTq4VxIzJ7JN1PI2DBr+p/T23/0jWaps14icjY3YUe
         Vom6sbe9OAcif04lHUStqSu/Vd8eQnLjdULDhETd30j3g0QFgI5QMA0+xqLlIGu1z4V+
         rSWB5dbTRNhE0HhZy4Ap3XKyrqejR5fCdlecpnvhsYd2vVzVpVbOAT/F1gmNdTUgIexj
         zNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739620079; x=1740224879;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Umszq55zr2ydVirX4cX0YyqP04V4YxVqeM14wzK7Gek=;
        b=nHExKJp1SJWez0Aw0f+flMjV2A451yvXLEEL2WbWFCddSwF+9riDIbOTk5eUV5z/xw
         qjNo12s7gtdk+j1C2EzoBJ5r+0kcem930jP6pfH2T/i7izYiTOWy+5+u02x4iJD+p+ot
         vKhxDwsIztKMV0Ss0pG9PP5qIBhNZ4hWZpfFy/acxhRlAUEiG7Na5DINU2PyGkR4LMq3
         /nUIC7Wf781Q/poZDi+J11B0dfdzuOE0HqvoiG4cngA+xt+1Lu30MdWvM86W4hV3IWcz
         rHtbByxa9x7nRdygJSvbfP0xNfkf3Cjzp0I3qCviw5k0j9jtesS0IYmMaXM6Oeg93D42
         1RbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5a8DzIHEQp55Xo7hzp2syG1YDEP8XE/7s2GdRfL7ZgS2lRT8bQ85e++RNxV0O7dqb2Rcn2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx32wuS485GaMIy+S/wqBiscJEtS54CO90cljdwzLoRJw4T8Qe3
	DYV8J+21Hh5pz8OzTY6jZOFcrnf7Z4ZxglLmfW0wSu2GQPTu/NVBM7/LLoAXCbo=
X-Gm-Gg: ASbGnctXJI3YCCT0Bf2vXXJJslc5bUgYQFfZK/QbU9dFcSJqPugKQ07+RPrcwYq7+AS
	XtFmnrti1QE6DChLw+2by52oIfobC+BuNKpPPjsYo3GXesOBC2PZjVVIo9uQLLmzkHw3LSXpzmu
	ElqE+kaMllY/FCvoCGX+kpnS8RTE5BJVg7dj8NszicoNB39fF9CnSMaEf6T02QXD26YbDEKnBMi
	KoiFO0p1Tt3kFMeae/jZZZn/jg9xYjobpT1Lprsfj81S1khXLqT9DBNqv+7DJrTM9MeU8fGzkYR
	hh2jPjRM/3ETafG+xDl0YL9sRn9Vecc6r9VTEBMjFYngah5KE5gn69p8tHam9f5+NnHoHXlN+Cc
	9+umjCp+8MUDb56aC5hc2sWdTy5ltcWwFoxj9Tg==
X-Google-Smtp-Source: AGHT+IEd2I18feoKFQrCBvveQW06kMqwctHtNYSHriGkIrfLXSIhQudwBxTKqAj1/APg/uw8ipTAyw==
X-Received: by 2002:a17:907:60d6:b0:aa6:84c3:70e2 with SMTP id a640c23a62f3a-abb70b65bbamr251214966b.20.1739620079016;
        Sat, 15 Feb 2025 03:47:59 -0800 (PST)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376ba4sm519803966b.106.2025.02.15.03.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 03:47:58 -0800 (PST)
Message-ID: <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>
Date: Sat, 15 Feb 2025 12:47:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add alignment
 check for dma buffers") when booting with Xen and mpt3sas_cm0 _scsih_probe
 failures
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Salvatore Bonaccorso <carnil@debian.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Sasha Levin <sashal@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 =?UTF-8?Q?Radoslav_Bod=C3=B3?= <radoslav.bodo@igalileo.cz>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
 <Z6ukbNnyQVdw4kh0@eldamar.lan>
 <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
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
In-Reply-To: <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------M6dSzVte7Sge1sXbnK1kLBUp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------M6dSzVte7Sge1sXbnK1kLBUp
Content-Type: multipart/mixed; boundary="------------iXeq0RGQhNDOwEfzNcf5fCRi";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Salvatore Bonaccorso <carnil@debian.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Sasha Levin <sashal@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 =?UTF-8?Q?Radoslav_Bod=C3=B3?= <radoslav.bodo@igalileo.cz>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add alignment
 check for dma buffers") when booting with Xen and mpt3sas_cm0 _scsih_probe
 failures
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
 <Z6ukbNnyQVdw4kh0@eldamar.lan>
 <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
In-Reply-To: <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>

--------------iXeq0RGQhNDOwEfzNcf5fCRi
Content-Type: multipart/mixed; boundary="------------6L5YPKZE0gGGfK25ofOIoDda"

--------------6L5YPKZE0gGGfK25ofOIoDda
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDIuMjUgMTY6MTIsIEhhcnNoaXQgTW9nYWxhcGFsbGkgd3JvdGU6DQo+IEhpIFNh
bHZhdG9yZSwNCj4gDQo+IE9uIDEyLzAyLzI1IDAwOjU2LCBTYWx2YXRvcmUgQm9uYWNjb3Jz
byB3cm90ZToNCj4+IEhpIEhhcnNoaXQsDQo+Pg0KPj4gT24gU3VuLCBGZWIgMDksIDIwMjUg
YXQgMDE6NDU6MzhBTSArMDUzMCwgSGFyc2hpdCBNb2dhbGFwYWxsaSB3cm90ZToNCj4+PiBI
aSBTYWx2YXRvcmUsDQo+Pj4NCj4+PiBPbiAwOC8wMi8yNSAyMToyNiwgU2FsdmF0b3JlIEJv
bmFjY29yc28gd3JvdGU6DQo+Pj4+IEhpIEp1ZXJnZW4sIGhpIGFsbCwNCj4+Pj4NCj4+Pj4g
UmFkb3NsYXYgQm9kw7MgcmVwb3J0ZWQgaW4gRGViaWFuIGFuIGlzc3VlIGFmdGVyIHVwZGF0
aW5nIG91ciBrZXJuZWwNCj4+Pj4gZnJvbSA2LjEuMTEyIHRvIDYuMS4xMTUuIEhpcyByZXBv
cnQgaW4gZnVsbCBpcyBhdDoNCj4+Pj4NCj4+Pj4gaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcv
MTA4ODE1OQ0KPj4+Pg0KPj4+DQo+Pj4gTm90ZToNCj4+PiBXZSBoYXZlIHNlZW4gdGhpcyBv
biA1LjQueSBrZXJuZWw6IE1vcmUgZGV0YWlscyBoZXJlOg0KPj4+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC85ZGQ5MWY2ZS0xYzY2LTQ5NjEtOTk0ZS1kYmRhODdkNjlkYWRAb3Jh
Y2xlLmNvbS8NCj4+DQo+PiBUaGFua3MgZm9yIHRoZSBwb2ludGVyLCBzbyBsb29raW5nIGF0
IHRoYXQgdGhyZWFkIEkgc3VzcGVjdCB0aGUgdGhyZWUNCj4+IHJlZmVyZW5jZWQgYnVncyBp
biBEZWJpYW4gYXJlIGluIHRoZSBlbmQgYWxsIHJlbGVhdGVkLiBXZSBoYXZlIG9uZSBhcw0K
Pj4gd2VsbCByZWxhdGluZyB0byB0aGUgbWVnYXNhc19zYXMgZHJpdmVyLCB0aGlzIG9uZSBm
b3IgdGhlIG1wdDNzYXMNCj4+IGRyaXZlciBhbmQgb25lIGZvciB0aGUgaTQwZSBkcml2ZXIp
Lg0KPj4NCj4+IEFGQUlDUywgdGhlcmUgaXMgbm90IHlldCBhIHBhdGNoIHdoaWNoIGhhcyBs
YW5kZWQgdXBzdHJlYW0gd2hpY2ggSSBjYW4NCj4+IHJlZGlyZWN0IHRvIGEgYWZmZWN0ZWQg
dXNlciB0byB0ZXN0Pw0KPj4NCj4gDQo+IEtvbnJhZCBwb2ludGVkIG1lIGF0IHRoaXMgdGhy
ZWFkOiBodHRwczovL2xvcmUua2VybmVsLm9yZy8gDQo+IGFsbC8yMDI1MDIxMTEyMDQzMi4y
OTQ5My0xLWpncm9zc0BzdXNlLmNvbS8NCj4gDQo+IFRoaXMgaGFzIHNvbWUgZml4ZXMsIGJ1
dCBub3QgbGFuZGVkIHVwc3RyZWFtIHlldC4NCg0KUGF0Y2hlcyBhcmUgdXBzdHJlYW0gbm93
LiBJbiBjYXNlIHlvdSBzdGlsbCBleHBlcmllbmNlIGFueSBwcm9ibGVtcywgcGxlYXNlDQpz
cGVhayB1cC4NCg0KDQpKdWVyZ2VuDQo=
--------------6L5YPKZE0gGGfK25ofOIoDda
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------6L5YPKZE0gGGfK25ofOIoDda--

--------------iXeq0RGQhNDOwEfzNcf5fCRi--

--------------M6dSzVte7Sge1sXbnK1kLBUp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmewfu0FAwAAAAAACgkQsN6d1ii/Ey9q
0Qf9HEPbsPcWoNpqW2D+wTQzWKLNPrmwEQRVmqxEzmP2+4hdRVEWrOXhE+0xmzmwC9HhULjztS3T
cHcWMc4QJqSEF2qv+BGmX5TpTklaA0vuGODL0t9uMTpeFAw2reWvLwB8b3hHmuSzUVTYH+jOAtDI
5wstz24Kt66fqmAKukyV5Om36DKwlydO0XCbYsHVa+iIa5AAPJlpuGJy5YIWGP69JLDn51u+Y/Rq
mAaQOk/6J+K5Is2IQWGpW7AuCeuqWpRubWkwgUmJzFKtLxlwgiFXyP6t1bJjMALUbXplgxr8yH8s
LVhtzCQlJ2dTve7vu82lOeoTnUrEbvF4odA+HqqvEQ==
=ODhc
-----END PGP SIGNATURE-----

--------------M6dSzVte7Sge1sXbnK1kLBUp--
