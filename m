Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AA19006B
	for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739626791; cv=none; b=Nnn7Qmlti2mgYfSGbw3WwR+svXpVdEAjCCIuTnQu/mZADbewH1v1Cy46Zf9ThD6D5dPOLQFTJqf/vcus3Yjb8nd3D2s2gBmXXjJ0L99Ig8hmZNtVc6jy2ztzayIoUsCVO1UNqv7sMT3HzZl2I9OgO/2msVJIgnz2X17LF0bRFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739626791; c=relaxed/simple;
	bh=/HjO99d9d4FF6KBejzCVCOkgbzTy1GYB8TrGHHDS3HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXpGKpDKlr9Gkeni3Y/m4ahw6aL0FyzO1CrgMVHkaBI/1dBryUWQA4cmVNh+L2C5IdLvQhKIa7CH2a2KDsMEaFxky0iiaqbaiadYDAvvQr/GZ74aUiOWY89acUXZCjkPaiKAAeNhJWPb5TU8Ww6c6gNhb2gUxfvd43iTbdxSmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I8b92C/f; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I8b92C/f"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso530534366b.3
        for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 05:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739626788; x=1740231588; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/HjO99d9d4FF6KBejzCVCOkgbzTy1GYB8TrGHHDS3HE=;
        b=I8b92C/fOMqW5XaTHEgxSTtE9lt8b0n3EiATedS1s/mkCTzRq7Af4ECkPp7aDRiURq
         87nlmCb6zLm+SFYCMP3X4EezDL5idKmfitI08CfkA0Tod2SqOcSaHMrJ9Ndi8pIXWuRX
         CmusaMcEmyXLeN4kHDNDl9IfTtPxQNApZNqUXy2iSYQKjcd/j9AP7E68UMrqIpJjxHm0
         XF7fb+WMOfh9B83TOFfx7HU8MtWcBhwXUq4WYP2HvehxxlHhPlrvE3tHN8v8mkGrAkjK
         SnagRd1beqS54QZG7abKfwdW2YYkAYsuYZApXj6SLIyev7ZMgQbOxZRAx4lIuhAzrvGQ
         BCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739626788; x=1740231588;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/HjO99d9d4FF6KBejzCVCOkgbzTy1GYB8TrGHHDS3HE=;
        b=rUJWNdPrGAW4soLU8mBKxOI/dDByKmO+aQO1yreY8WTpkSlDb01wND9ucwBMx+mBhE
         DbbLglJF3T3R09MQuikD0YHpNMONgwVQNmk2a2SNyEB2sRdrVVxw345gn7dAWdKrqxZN
         gRozkIvm0F5PrhkAITCffYaoBDcVzBrJcCifPCoFo+tpD7yxCmkez62cZ9511asNvgU4
         bZj4x7tUKeqhJrwmDg2VNz6Wdyg6OaFFE9H8Qkynf/lvWWkvKXdvYELffMmwSz8rmgDX
         88GT+gb59dBVnpFoAmunxupxKK1Aff7zRTYF8KjDM6deqSex1njqv/XyB7VfAnCQi+rd
         LNzA==
X-Forwarded-Encrypted: i=1; AJvYcCW+DE0ArCYT0lbIGdTe/Hdyg7xLdYVBAToNouCXZhlJLFgqI8/0O2L3DzKFCY1DC9+v7yaDqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8HBNGt8TNYT09HIca5+KE3Apr7LFGt7ClgVhE2U6KSGICWhHy
	hn46XaBhzurhJj3t3C7LXfNKGsSqeJvO7kyF2x/u2GizFZgbkquRyf0lKfdgFa/CGJUazTgDul8
	X6jxfrg==
X-Gm-Gg: ASbGnctUJMlDXeKNaDRBy12lQloFhy2UsXYm4x+5MPHgITvQfAbnVnJ6DAmNQ+1NFpP
	fUfbvemlGbi+Akxloq140n/PPLBfRdfnW89tbe1laB5AVhfb0zou2Vqdt6NOSno1nIBNVogMP7D
	8Xlh1SVdWbE0fWFxOxax8C+tUdf8P3grG2+HfAGO50vi3EDrgIri6rYwzfrd09dFDb4rYbQC9qQ
	Xiit4Vz5MgCEMjPYMTDtllvslcy2/JMhWFHq7fFKBpgIhK/v2orY0OgiEb5RbjaRz11URPpsSQb
	1LvKVmZ4Ig3MNRUMO63SuowbN6bXTUU8/FndIqZ3YjS59IsDmH9pAhdDgJaMQ6EKVuMKXQjNdIF
	XLTqOp87JfYMMsI+V8txs4Hg+ohud4KMFHS4XVw==
X-Google-Smtp-Source: AGHT+IGi3PRqyuYABsnP6lAed++WWnXZdOFn1qmCp8QMvkad/VYD8NVWu9cVXQTqlOrOCol4oqH6ZQ==
X-Received: by 2002:a17:906:4794:b0:ab7:e52a:1467 with SMTP id a640c23a62f3a-abb70dad218mr275447066b.30.1739626787747;
        Sat, 15 Feb 2025 05:39:47 -0800 (PST)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376953sm540479066b.101.2025.02.15.05.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 05:39:47 -0800 (PST)
Message-ID: <74e74dde-0703-4709-96b8-e1615d40f19c@suse.com>
Date: Sat, 15 Feb 2025 14:39:46 +0100
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Sasha Levin
 <sashal@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 =?UTF-8?Q?Radoslav_Bod=C3=B3?= <radoslav.bodo@igalileo.cz>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
 <Z6ukbNnyQVdw4kh0@eldamar.lan>
 <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
 <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>
 <2025021548-amiss-duffel-9dcf@gregkh>
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
In-Reply-To: <2025021548-amiss-duffel-9dcf@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ls6AIDBcoZHL08gcNLOiJrfG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ls6AIDBcoZHL08gcNLOiJrfG
Content-Type: multipart/mixed; boundary="------------lTGN4b9A8HyzQDmrmj3ffGkP";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Sasha Levin
 <sashal@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 =?UTF-8?Q?Radoslav_Bod=C3=B3?= <radoslav.bodo@igalileo.cz>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <74e74dde-0703-4709-96b8-e1615d40f19c@suse.com>
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add alignment
 check for dma buffers") when booting with Xen and mpt3sas_cm0 _scsih_probe
 failures
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
 <Z6ukbNnyQVdw4kh0@eldamar.lan>
 <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
 <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>
 <2025021548-amiss-duffel-9dcf@gregkh>
In-Reply-To: <2025021548-amiss-duffel-9dcf@gregkh>

--------------lTGN4b9A8HyzQDmrmj3ffGkP
Content-Type: multipart/mixed; boundary="------------ODYaakMO0X8VgXtiljW8Is0u"

--------------ODYaakMO0X8VgXtiljW8Is0u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDIuMjUgMTM6MzQsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIFNhdCwgRmViIDE1LCAy
MDI1IGF0IDEyOjQ3OjU3UE0gKzAxMDAsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+PiBPbiAx
Mi4wMi4yNSAxNjoxMiwgSGFyc2hpdCBNb2dhbGFwYWxsaSB3cm90ZToNCj4+PiBIaSBTYWx2
YXRvcmUsDQo+Pj4NCj4+PiBPbiAxMi8wMi8yNSAwMDo1NiwgU2FsdmF0b3JlIEJvbmFjY29y
c28gd3JvdGU6DQo+Pj4+IEhpIEhhcnNoaXQsDQo+Pj4+DQo+Pj4+IE9uIFN1biwgRmViIDA5
LCAyMDI1IGF0IDAxOjQ1OjM4QU0gKzA1MzAsIEhhcnNoaXQgTW9nYWxhcGFsbGkgd3JvdGU6
DQo+Pj4+PiBIaSBTYWx2YXRvcmUsDQo+Pj4+Pg0KPj4+Pj4gT24gMDgvMDIvMjUgMjE6MjYs
IFNhbHZhdG9yZSBCb25hY2NvcnNvIHdyb3RlOg0KPj4+Pj4+IEhpIEp1ZXJnZW4sIGhpIGFs
bCwNCj4+Pj4+Pg0KPj4+Pj4+IFJhZG9zbGF2IEJvZMOzIHJlcG9ydGVkIGluIERlYmlhbiBh
biBpc3N1ZSBhZnRlciB1cGRhdGluZyBvdXIga2VybmVsDQo+Pj4+Pj4gZnJvbSA2LjEuMTEy
IHRvIDYuMS4xMTUuIEhpcyByZXBvcnQgaW4gZnVsbCBpcyBhdDoNCj4+Pj4+Pg0KPj4+Pj4+
IGh0dHBzOi8vYnVncy5kZWJpYW4ub3JnLzEwODgxNTkNCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4+
IE5vdGU6DQo+Pj4+PiBXZSBoYXZlIHNlZW4gdGhpcyBvbiA1LjQueSBrZXJuZWw6IE1vcmUg
ZGV0YWlscyBoZXJlOg0KPj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzlkZDkx
ZjZlLTFjNjYtNDk2MS05OTRlLWRiZGE4N2Q2OWRhZEBvcmFjbGUuY29tLw0KPj4+Pg0KPj4+
PiBUaGFua3MgZm9yIHRoZSBwb2ludGVyLCBzbyBsb29raW5nIGF0IHRoYXQgdGhyZWFkIEkg
c3VzcGVjdCB0aGUgdGhyZWUNCj4+Pj4gcmVmZXJlbmNlZCBidWdzIGluIERlYmlhbiBhcmUg
aW4gdGhlIGVuZCBhbGwgcmVsZWF0ZWQuIFdlIGhhdmUgb25lIGFzDQo+Pj4+IHdlbGwgcmVs
YXRpbmcgdG8gdGhlIG1lZ2FzYXNfc2FzIGRyaXZlciwgdGhpcyBvbmUgZm9yIHRoZSBtcHQz
c2FzDQo+Pj4+IGRyaXZlciBhbmQgb25lIGZvciB0aGUgaTQwZSBkcml2ZXIpLg0KPj4+Pg0K
Pj4+PiBBRkFJQ1MsIHRoZXJlIGlzIG5vdCB5ZXQgYSBwYXRjaCB3aGljaCBoYXMgbGFuZGVk
IHVwc3RyZWFtIHdoaWNoIEkgY2FuDQo+Pj4+IHJlZGlyZWN0IHRvIGEgYWZmZWN0ZWQgdXNl
ciB0byB0ZXN0Pw0KPj4+Pg0KPj4+DQo+Pj4gS29ucmFkIHBvaW50ZWQgbWUgYXQgdGhpcyB0
aHJlYWQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnLw0KPj4+IGFsbC8yMDI1MDIxMTEyMDQz
Mi4yOTQ5My0xLWpncm9zc0BzdXNlLmNvbS8NCj4+Pg0KPj4+IFRoaXMgaGFzIHNvbWUgZml4
ZXMsIGJ1dCBub3QgbGFuZGVkIHVwc3RyZWFtIHlldC4NCj4+DQo+PiBQYXRjaGVzIGFyZSB1
cHN0cmVhbSBub3cuIEluIGNhc2UgeW91IHN0aWxsIGV4cGVyaWVuY2UgYW55IHByb2JsZW1z
LCBwbGVhc2UNCj4+IHNwZWFrIHVwLg0KPiANCj4gV2hhdCBzcGVjaWZpYyBjb21taXRzIHNo
b3VsZCBiZSBiYWNrcG9ydGVkIGhlcmU/DQoNClRob3NlIGFyZToNCg0KZTkzZWM4NzI4NmJk
MWZkMzBiNzM4OWU3YTM4N2NmYjI1OWYyOTdlMw0KODVmY2I1N2M5ODNmNDIzMTgwYmE2ZWM1
ZDAwMzQyNDJkYTA1Y2M1NA0KDQoNCkp1ZXJnZW4NCg0KPiANCj4gdGhhbmtzLA0KPiANCj4g
Z3JlZyBrLWgNCg0K
--------------ODYaakMO0X8VgXtiljW8Is0u
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ODYaakMO0X8VgXtiljW8Is0u--

--------------lTGN4b9A8HyzQDmrmj3ffGkP--

--------------ls6AIDBcoZHL08gcNLOiJrfG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmewmSIFAwAAAAAACgkQsN6d1ii/Ey+q
aQf/aYXytelSPX7A3LqOoN7OhhcZkbHXfctM13VICeRX4cL/JV+AZ2EWC0zYWz6asyRuSZ7H54tN
ZiTjryZxT3bdDu/vq3MClqGh3/Vgr6jG8hh/DZqRloRuM0Viq908Hfnh+QOYrN+V9J3cfwmN5DHi
Sl08HmN7QW5WsfiMJigiMJVnX3WTF/URF2aKNSf8fC/m5AkMN5SQ654tZQlxV6vVq0lrWgQc0zQm
XiEoEr1oDJc1B3SP2GcIe6DkpDlq6myM+2zArhIXLz7eyKeOTtDcYHmj6jXQumCnw/DCeQi9PgtK
zzfDVCxvyFkrXcTmxDn2zcM2vBI0AjAeffpLHBiNCQ==
=RyC/
-----END PGP SIGNATURE-----

--------------ls6AIDBcoZHL08gcNLOiJrfG--
