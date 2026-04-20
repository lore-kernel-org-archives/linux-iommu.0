Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18D39DBF1
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687579; cv=none; b=LQt04mepkvZX1QRNwuhJBpyPRddFh6yyY5RW08gH1pZKEY52lSii41vKMw20drtvEFeOPqqQa6mm+vcmA1p4VhOMW6XS/gp0cb39nLEc6FexWnVJ+S5rFIj5oLOjwYL2FIJi1aFop7g8QsEqI3CrEcWLIec7a/bDP4/cNqmKjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687579; c=relaxed/simple;
	bh=MHRIw34ZrmzU/Sj1GJ2quPOQCirKAg0tT1ITdGCo6pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivOlArebQ+GVML5Yl9dFhSNwnViYnrhIkhk7WrNk/48Qdt3obarg9VFRUBieHaKMueNaGkt7isMYB7rz9V561h/M/XLb0SuWqhDsgUtq2oyRZeHX649T/z9Pdrahzpg8jZRwtPLOZ6rYteW+Z+creBjYOc4wZzpcaSueVQRrF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RIR1g/VV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RIR1g/VV"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so4070981a12.1
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776687576; x=1777292376; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MHRIw34ZrmzU/Sj1GJ2quPOQCirKAg0tT1ITdGCo6pY=;
        b=RIR1g/VVl71zj7VLBVYAt05uGFG7LCJOx08/tjZTZrAolmq/ELnWNqHwsD60PkgOlt
         Wb3R3FYIYNsqNKjQexC7jM47lA0+vYwo/LLWn5v+WXwc9ePmfHaDuhENRovIbs43eOGM
         hrg3QoW6uQNYOghl08SCtG67z5ZmNtVZ0jcSvPCSLqH5KE8MZkL9Jhlw1NeRss4QPrww
         BvadWLVQcHtzsVkL8+kqmxfKFl5JpL/ZH7TkAQgMLV4v/3mphlMy1hR5GpFYTeLGxG84
         h7ALvuA96LbwUmKCavlbpNXua69N1igAOe7xdGzeLOMFLvX0tcQzgwKrbhVYwp6tAAAA
         JYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776687576; x=1777292376;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHRIw34ZrmzU/Sj1GJ2quPOQCirKAg0tT1ITdGCo6pY=;
        b=kHHzSNrRYUu/t1rxXs+WfE8A1EgFbWjPHAXz2XYocqmjMbRu5nz4145tW1833oQ0qD
         HBaO4MT0B8rvZXoJA63zbeboCzSlwx4mI0e3sEItRav7qbdCbgR74rwXQcGdSMzDozRd
         ITgG1MySjWA4sFPfuCrn8i7OMPoWua0s4604jOwsc+bDLXyi5I5soXNmViDHeifbx5E/
         V+sX+iEJp8BFJ9ONTjyHbCLNETXvwWqbutPhMOZV0BMtxIw50jk1QX1lcULaOBVP25IE
         KypUBg79X0S6iQe8+SNX88jlW2buZK2n5oyEL7m+VIQv8ScwgQRQ+XR2JYlVDUkBsGjr
         PYLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wA7paS9jbGrvpGxN8J1QFOozSANTbe9srWx11e3bsAQgGGc1uK58GQ4CyAcHkbCD+eBlY5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgFBie5j7QVgZmR8qSP7MZt8kk2h8e/nbxRj75bOHknf5i0tPI
	uRZDzqwDTOfzPO644TimlzM1aoeYSYd57OHZK1KICtrU35xa/xBTsgSYhbmbq+rGYcU=
X-Gm-Gg: AeBDieuIW63GoO81LAFR8pDq7hMRlzzscxSET3k1hZCtm3YpMSogNopTYhE9r4LbKhW
	ZE8FK0RP+iWgyytbJPeUBhzpaD+iIJ+k3TKVpPSI7owaoU1/blJGUf1Sq4d/YqYCpkCKyMG+eBE
	gJl1id3Re/dnEVrdyehl0A2QcdFv3J+tafQeCRybAqAmYHavURH4hvV6XkJEDxs8SfTqceKIfvb
	e9gZThqNm0zxnen41vS0wmPcAqVx9SrSHNvwiuDo7NHdwbjU3aPhkiw4mgnO8zALwNhskz/WP4/
	3J0ogucNR98JBJ5TpE8uYc/fu+wGJZ3lTVQpdPxpb+1CUWrT7f1sT6+TTj18mXiuc+q+rOXzDNG
	fd9mREOVeMwzWUJ74yMGuFlgGnY5V+N4uFJ2XLQ4oGAMnDjODrJWIUuRx8AqFWTuMit+y9G8ijW
	+JoHHmO6ntQyjwSpX5sVUmqCGGkYq9TlldmUfGFuCKp7sIU6kekOcKzMvD6sFH4xbvp4vXpNl+D
	tv4cM8ef3HYmCB8fzVzupQPehcPqmCeIoVg/YYItEwsWnX9pW17cnK+Dz7dFHyt
X-Received: by 2002:a05:6402:24a2:b0:670:8d90:e861 with SMTP id 4fb4d7f45d1cf-672bfd82177mr5622166a12.6.1776687575858;
        Mon, 20 Apr 2026 05:19:35 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d5babcsm2026949a12.23.2026.04.20.05.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 05:19:35 -0700 (PDT)
Message-ID: <f6cf1d46-9d2e-4b52-a6b9-fb45d01b874f@suse.com>
Date: Mon, 20 Apr 2026 14:19:34 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] xen/swiotlb: avoid arch_sync_dma_* on per-device DMA
 memory
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>
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
In-Reply-To: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------034tgJUdS8obTrCAMQuKOO5H"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------034tgJUdS8obTrCAMQuKOO5H
Content-Type: multipart/mixed; boundary="------------xAm466dmUFDzKs0FzPVhHxO0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Message-ID: <f6cf1d46-9d2e-4b52-a6b9-fb45d01b874f@suse.com>
Subject: Re: [PATCH RFC] xen/swiotlb: avoid arch_sync_dma_* on per-device DMA
 memory
References: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>
In-Reply-To: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>

--------------xAm466dmUFDzKs0FzPVhHxO0
Content-Type: multipart/mixed; boundary="------------y5RAGzWBaBlt2a08ULXbC0V9"

--------------y5RAGzWBaBlt2a08ULXbC0V9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDQuMjYgMTc6MDgsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiBGcm9tOiBQZW5n
IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IE9uIEFSTTY0LCBhcmNoX3N5bmNfZG1h
X2Zvcl97Y3B1LGRldmljZX0oKSBhc3N1bWVzIHRoYXQgdGhlDQo+IHBoeXNpY2FsIGFkZHJl
c3MgcGFzc2VkIGluIHJlZmVycyB0byBub3JtYWwgUkFNIHRoYXQgaXMgcGFydCBvZiB0aGUN
Cj4ga2VybmVsIGxpbmVhcihkaXJlY3QpIG1hcHBpbmcsIGFzIGl0IHVuY29uZGl0aW9uYWxs
eSBkZXJpdmVzIGEgQ1BVDQo+IHZpcnR1YWwgYWRkcmVzcyB2aWEgcGh5c190b192aXJ0KCku
DQo+IA0KPiBXaXRoIFhlbiBzd2lvdGxiLCBkZXZpY2VzIG1heSB1c2UgcGVyLWRldmljZSBj
b2hlcmVudCBETUEgbWVtb3J5LA0KPiBzdWNoIGFzIHJlc2VydmVkLW1lbW9yeSByZWdpb25z
IGRlc2NyaWJlZCBieSAnc2hhcmVkLWRtYS1wb29sJywNCj4gd2hpY2ggYXJlIGFzc2lnbmVk
IHRvIGRldi0+ZG1hX21lbS4gVGhlc2UgcmVnaW9ucyBtYXkgYmUgbWFya2VkDQo+IG5vLW1h
cCBpbiBEVCBhbmQgdGhlcmVmb3JlIGFyZSBub3QgcGFydCBvZiB0aGUga2VybmVsIGxpbmVh
ciBtYXAuDQo+IEluIHN1Y2ggY2FzZXMsIHBmbl92YWxpZCgpIHN0aWxsIHJldHVybnMgdHJ1
ZSwgYnV0IHBoeXNfdG9fdmlydCgpDQo+IGlzIG5vdCB2YWxpZCBhbmQgY2FjaGUgbWFpbnRl
bmFuY2UgdmlhIGFyY2hfc3luY19kbWFfKiB3aWxsIGZhdWx0Lg0KPiANCj4gUHJldmVudCB0
aGlzIGJ5IGV4Y2x1ZGluZyBkZXZpY2VzIHdpdGggYSBwcml2YXRlIERNQSBtZW1vcnkgcG9v
bA0KPiAoZGV2LT5kbWFfbWVtKSBmcm9tIHRoZSBhcmNoX3N5bmNfZG1hXyogZmFzdCBwYXRo
LCBhbmQgYWx3YXlzDQo+IGZhbGwgYmFjayB0byB4ZW5fZG1hX3N5bmNfKiBmb3IgdGhvc2Ug
ZGV2aWNlcyB0byBhdm9pZCBpbnZhbGlkDQo+IHBoeXNfdG9fdmlydCgpIGNvbnZlcnNpb25z
IGZvciBuby1tYXAgRE1BIG1lbW9yeSB3aGlsZSBwcmVzZXJ2aW5nIHRoZQ0KPiBleGlzdGlu
ZyBmYXN0IHBhdGggZm9yIG5vcm1hbCwgbGluZWFyLW1hcHBlZCBSQU0uDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+ICAgZHJp
dmVycy94ZW4vc3dpb3RsYi14ZW4uYyB8IDE3ICsrKysrKysrKysrKystLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vc3dpb3RsYi14ZW4uYyBiL2RyaXZlcnMveGVuL3N3
aW90bGIteGVuLmMNCj4gaW5kZXggMmNiZjJiNTg4ZjViMjBjZmJmOWU4M2E4MzM5ZGMyMjA5
MmM5NTU5YS4uYjE0NDVkZjk5ZDlhOGYxZDE4YTgzYjhjNDEzYmFkYTZlNTU3OTIwOSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4vc3dpb3RsYi14ZW4uYw0KPiArKysgYi9kcml2ZXJz
L3hlbi9zd2lvdGxiLXhlbi5jDQo+IEBAIC0xOTUsNiArMTk1LDExIEBAIHhlbl9zd2lvdGxi
X2ZyZWVfY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBzaXplX3Qgc2l6ZSwgdm9pZCAq
dmFkZHIsDQo+ICAgfQ0KPiAgICNlbmRpZiAvKiBDT05GSUdfWDg2ICovDQo+ICAgDQo+ICtz
dGF0aWMgaW5saW5lIGJvb2wgZGV2X2hhc19wcml2YXRlX2RtYV9wb29sKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gK3sNCj4gKwlyZXR1cm4gZGV2ICYmIGRldi0+ZG1hX21lbTsNCj4gK30N
Cj4gKw0KDQpJIGRvbid0IHRoaW5rIHRoaXMgd2lsbCBjb21waWxlIG9uIHg4Ni4NCg0KDQpK
dWVyZ2VuDQo=
--------------y5RAGzWBaBlt2a08ULXbC0V9
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

--------------y5RAGzWBaBlt2a08ULXbC0V9--

--------------xAm466dmUFDzKs0FzPVhHxO0--

--------------034tgJUdS8obTrCAMQuKOO5H
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnmGdYFAwAAAAAACgkQsN6d1ii/Ey/8
Agf/YSSbznJg1CLAGP+RXd36++PsFDci/UUxCHrYwPyRzg9pDXHXnJ2KRuxP9wsrQdywHFkHNY7j
DU7Z6yVyIfrJHr6jnWVHi0IgJ4GReVR7BsRVoRKjFq+CkF7kEUceeuWMp0lFAaAtu5avoVAEXApN
l06NqUBNO1GWqeBt6NYDKUvW6dmEotsuXghWtc8u+YVcr1n8ZbmWRP+kyZyqLDu7pWHOdH1qYjro
SkU+aznBm1eVntwX2skc5Z9sjr71hdYYNRLyis9B1X+TIy57Z+R5TOG1dPH7oRUpq7tQ464KZHkC
92FKMGAK3twb5YcG0ENBxOlUAQKsOB7mt6hXrhi5Ww==
=UOv5
-----END PGP SIGNATURE-----

--------------034tgJUdS8obTrCAMQuKOO5H--
