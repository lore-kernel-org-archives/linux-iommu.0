Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067956;
	b=JXh3n8AZmZptm63ToWhvkpOgDG75b0aF6B5xoq+6Vy3d79rDj2BgejJKeP2vMOo7Qpyo
	 zIwC1V1GZ5hMnfPqVfEnGqjISFSx0IbjUbAsexHhFR/mf5CAQT9rx2NFqQ+/IhoKNPTaJ
	 DlnBV4eDMOpWszlzD/Gt5TXdW2/uVxXzpdJrQICB7llhB7y3ql8vPgQhEjlXnjXuGuPcd
	 +v/D0QzbrC+4xPKy6n0UtYNoUZasxBD1/ktshXN+owEhkTalfGVOiX8QIVfaE8saqZz2j
	 PKYRMnRdqdkXmMm7y/UoFZT16Ahk5brEW2tRRxiGgk3+9mPGZNfsR7MFWxZh9vTfK5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=JXGZAzH5Q6BDWaB8lmmtrGajWsCwEXdO5JvWO2ccqEg=;
	b=35mzEWRPFYmHKdiLkkKJukELKrK8iHbrA9aHlmIUqmjvsaNDPNTOEaPNdF5wMy+SpJ5i
	 Fqy3HAJ53DPpTMD3T60jMtcft2SkEyF3epHUYu0dPa0s6zjvhjF/rSfXAmVKMRvM53cVf
	 pfNc/9Z3rZKgI/Hz4nEgp3ViEhtcaVNdXboNAinB09ENaxtkX60ej9N20atmRregk7W36
	 f0iavDPYDgj8HEV5B5fJAJvLgou3hkdomGfRPnV0gXZTRU1Wug5bgadMAEmjLRFoDA9xZ
	 AA95Z3xeaj3ziz90TtDuSqQ1SFwLqy1Gi/Zn2/WNhZA4Zghqr4XCCxWK4MVm0FLnihw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=J2sdjRwQ;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0F606A320
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 05:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43D0F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=J2sdjRwQ
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so941965f8f.0
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 21:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795067954; x=1795672754; darn=lists.linux.dev;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JXGZAzH5Q6BDWaB8lmmtrGajWsCwEXdO5JvWO2ccqEg=;
        b=J2sdjRwQMX9G0ew4GXgNCkhgsbBOvFLaJEwlfV+CbCoLAjqwHU+03X4cn+BgdYWOr1
         +zrYpEiqWyfyAojl50f1uUoXyKjay+R8fN+7U/9d2ifKa7L8yfQ3/+U5wRR+JEwem/5a
         ixu3U0sPx++DcjIkmPeAQtCrb5xV2GaX5iobAO8w1lQpSkgQwoQt66ERzcvufZnFJIYh
         Nz2nrzibZs//05RneUs6UjQuWCGNyJ2LF1Jz8hQgUFUfnZ6z3tYgZHXUjYk46xIJ0nTc
         RYer4ziADZTVSQ+HBDslpC+Y1F1gDhImMEYiChT69xUZHuvhxSNd5XLQC7sgfD8ADsyR
         d4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067954; x=1795672754;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JXGZAzH5Q6BDWaB8lmmtrGajWsCwEXdO5JvWO2ccqEg=;
        b=cxPFN5zSb/+jKPMzDwII3rCx2gbsTVotDRMmJwNlkpH6sX/cV9+Z41LyGQP9IZuiC3
         QvGhhoklCTYxvFw/ctdPNxXdvb4NlPWxYxZR+eS8necdVMy8ABMi+lOVC8+4lG9y4APm
         nDHkhOSSbQlKfcN4Kew4fsAkel2fXmjb4nEYPf1qh+m/eiUCv00liDR3p8ta2BvOi3XO
         gY3AetaPpZ1DBm2wVj/1sydfXlsAZsdg29jKFSOUBvc0Axb/G8HndSJSMRBUZzzF2one
         iffjwJ861+dKhMLKH0b54AacYYOQB3+qQXSCtGiXOylCJmXHoGhAq6rfy6sn81thfMCo
         /CHg==
X-Forwarded-Encrypted: i=1; AL+hErEu5gqrFiwt5jOrmaKjBM7/p3Klcphmr1pXbHWchf7d0/8A4jEMuqGpSQoA3Pj8R6Fb4drI5A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/xA3RDuT48qql7CN9VVQCI8cIp+hV3OjnqH2/rQfS5Tr8HYrDM
	MIUhA8FJplP0inVy4ohDC3+UPOsuKNymTjf4D5BGiyJdvomY9E8MoLoiaeCN7apehYU=
X-Gm-Gg: AZFdTZcGpf/pQuc86QN39eRe+A2Em3JupuwEHt9HDjIk0RFL77KVSYrj45FWvi1wTxT
	CM3VrygB/iDb5PWMw1+bPmNdwgVeEI74WHeeVtPj4zn+jboWNbWGcn+m77xt9ZN2fZy0VmiqE8E
	amYdDP24ss8JZ4NkcJlTnxJ1WN/kZyBaIhX/ZlamrPDrZMVJOHX27/ro/vCNywaAKk65C2Grdle
	BCzXl6xbZuebDHDUMjJR3srnvUQ02D9Sm2Dz2OqbrdQljOEfQ8sLjSQgy9CVVanTtElvMH306Fy
	AAUTZRR+R7xr4cYZVpOv78WcyTiYiTfsfOAyUYckZA/kihGG2zp+9Q5g9T2Uu6EJVK20Q0RNHcQ
	Jg26oEpcg1bii41CuLDt3MWHc4jrIJgYhevYTBPtCvnF10MmSuA3uEFdDLQcIELfoE1ULNx7OzH
	w7SvRCH3ND8NbN1tulmb7Gia9LCZv6zVwfgd3kHucZcdllQYi/L6vrYD81ZE8WBDW3wuFSp2LgH
	9VPkH+5p8xXklyL3qulLgeC1SIGLczUfqZglF0jVmiHu/qHXC6s0n8ogsfiy5Emv0hkE42zn+bR
	n8JIG39TcKjVdh50gPjbqpTCbeUFqwa6aLbNjeipiXhowIfXnV/SZHK3jh9w+RUJcKWDZxKJdUd
	vyuYzHVUWp02T1al4IzEt+5Z92sDe+NXgIRzD3Ex+XBWYa/zZuVw=
X-Received: by 2002:a05:6000:41cd:b0:490:71a7:6f51 with SMTP id ffacd0b85a97d-4a63eac9ebemr10067708f8f.45.1795067954538;
        Wed, 18 Nov 2026 21:59:14 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c11f1csm9214991f8f.53.2026.11.18.21.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 21:59:14 -0800 (PST)
Message-ID: <8262d7e0-75e8-4bc0-932d-1d4e40b716de@suse.com>
Date: Thu, 19 Nov 2026 06:59:13 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/swiotlb: Check the segment boundary in
 range_straddles_page_boundary()
To: Lin Liu <lin.liu01@citrix.com>, ross.lagerwall@citrix.com
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 andrew.cooper3@citrix.com, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
 <75f37608-f3ef-48db-8e7b-4a1ba13a9ee0@citrix.com>
 <8a57f3f6-c649-4be0-8e14-2cc16dd41f8f@suse.com>
 <20261119043504.2013850-1-lin.liu01@citrix.com>
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
In-Reply-To: <20261119043504.2013850-1-lin.liu01@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------L0WTVrEmB4Otjz5cYuy30BLV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------L0WTVrEmB4Otjz5cYuy30BLV
Content-Type: multipart/mixed; boundary="------------npmCfGmSUuxvj35nuWE2jBLJ";
 protected-headers="v1"; hp="clear"
Message-ID: <8262d7e0-75e8-4bc0-932d-1d4e40b716de@suse.com>
Date: Thu, 19 Nov 2026 06:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/swiotlb: Check the segment boundary in
 range_straddles_page_boundary()
To: Lin Liu <lin.liu01@citrix.com>, ross.lagerwall@citrix.com
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 andrew.cooper3@citrix.com, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
 <75f37608-f3ef-48db-8e7b-4a1ba13a9ee0@citrix.com>
 <8a57f3f6-c649-4be0-8e14-2cc16dd41f8f@suse.com>
 <20261119043504.2013850-1-lin.liu01@citrix.com>
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
In-Reply-To: <20261119043504.2013850-1-lin.liu01@citrix.com>

--------------npmCfGmSUuxvj35nuWE2jBLJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMTEuMjYgMDU6MzUsIExpbiBMaXUgd3JvdGU6DQo+IE9uIDE4LzExLzIwMjYgMTI6
MjQsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+PiBPbiAxOC4xMS4yNiAxMjoyNSwgUm9zcyBM
YWdlcndhbGwgd3JvdGU6DQo+Pj4gSXMgdGhlIGNoYW5nZSBhY3R1YWxseSBuZWVkZWQgZm9y
IGFsbG9jX2NvaGVyZW50IC8gZnJlZV9jb2hlcmVudD8NCj4+PiBUaGUgYWxsb2NhdGlvbiBm
cm9tIF9fZ2V0X2ZyZWVfcGFnZXMoKSBpcyBuYXR1cmFsbHkgYWxpZ25lZCBhbmQNCj4+PiBy
YW5nZV9yZXF1aXJlc19hbGlnbm1lbnQoKSByZXF1aXJlcyBpdCBoYXMgdGhlIHNhbWUgYWxp
Z25tZW50IHNvIGl0IGlzDQo+Pj4gbmF0dXJhbGx5IGFsaWduZWQgaW4gYnVzIHNwYWNlLiBJ
IGRvbid0IHRoaW5rIHRoYXQgaXQgY2FuIGNyb3NzIGENCj4+PiBzZWdtZW50IGJvdW5kYXJ5
IHRoZW4uDQo+Pg0KPj4gSG1tLCBhZ3JlZWQuDQo+IA0KPiBUaGFua3MgYm90aC4gIEFncmVl
ZCwgdGhlIGNoZWNrIGlzIHVubmVjZXNzYXJ5IGZvciB0aGUgY29oZXJlbnQgcGF0aHMuDQo+
IEkgaGFkIG5vdGVkIHRoaXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlICgiY29oZXJlbnQgYWxs
b2NhdGlvbnMgYXJlIGFscmVhZHkNCj4gbmF0dXJhbGx5IGFsaWduZWQgdmlhIHJhbmdlX3Jl
cXVpcmVzX2FsaWdubWVudCgpIiksIGJ1dCB0aGUgY29kZSBzdGlsbA0KPiBjaGFuZ2VkIHRo
ZW0uDQo+IA0KPiBGb3IgdjIgSSBwbGFuIHRvIGxlYXZlIHJhbmdlX3N0cmFkZGxlc19wYWdl
X2JvdW5kYXJ5KCkgYW5kIHRoZSBjb2hlcmVudA0KPiBwYXRocyB1bnRvdWNoZWQsIGFuZCBj
aGVjayBvbmx5IHN0cmVhbWluZyBtYXBwaW5ncywgd2l0aCBhIHNtYWxsIGhlbHBlcg0KPiBu
ZXh0IHRvIHJhbmdlX3N0cmFkZGxlc19wYWdlX2JvdW5kYXJ5KCk6DQo+IA0KPiAvKiBCdXMt
Y29udGlndW91cywgYnV0IG1heSBzdGlsbCBjcm9zcyB0aGUgZGV2aWNlJ3Mgc2VnbWVudCBi
b3VuZGFyeSAqLw0KPiBzdGF0aWMgaW5saW5lIGJvb2wgcmFuZ2VfY3Jvc3Nlc19zZWdfYm91
bmRhcnkoc3RydWN0IGRldmljZSAqZGV2LA0KPiAJCQkJCSAgICAgIGRtYV9hZGRyX3QgZG1h
LCBzaXplX3Qgc2l6ZSkNCj4gew0KPiAJdW5zaWduZWQgbG9uZyBtYXNrID0gZG1hX2dldF9z
ZWdfYm91bmRhcnkoZGV2KTsNCj4gDQo+IAlyZXR1cm4gc2l6ZSAmJiAoKGRtYSBeIChkbWEg
KyBzaXplIC0gMSkpICYgfm1hc2spOw0KPiB9DQo+IA0KPiB1c2VkIGluIHhlbl9zd2lvdGxi
X21hcF9waHlzKCk6DQo+IA0KPiAJaWYgKGRtYV9jYXBhYmxlKGRldiwgZGV2X2FkZHIsIHNp
emUsIHRydWUsIGF0dHJzKSAmJg0KPiAJICAgICFkbWFfa21hbGxvY19uZWVkc19ib3VuY2Uo
ZGV2LCBzaXplLCBkaXIpICYmDQo+IAkgICAgIXJhbmdlX3N0cmFkZGxlc19wYWdlX2JvdW5k
YXJ5KHBoeXMsIHNpemUpICYmDQo+IAkgICAgIXJhbmdlX2Nyb3NzZXNfc2VnX2JvdW5kYXJ5
KGRldiwgZGV2X2FkZHIsIHNpemUpICYmDQo+IAkJIXhlbl9hcmNoX25lZWRfc3dpb3RsYihk
ZXYsIHBoeXMsIGRldl9hZGRyKSAmJg0KPiAJCSFpc19zd2lvdGxiX2ZvcmNlX2JvdW5jZShk
ZXYpKQ0KPiAJCWdvdG8gZG9uZTsNCj4gDQo+IEEgbWFwcGluZyBsYXJnZXIgdGhhbiB0aGUg
Ym91bmRhcnkgd2luZG93IGFsc28gdGFrZXMgdGhlIGJvdW5jZSBwYXRoOg0KPiBzd2lvdGxi
IGNhbm5vdCBmaW5kIHNsb3RzIHRoYXQgZG8gbm90IHNwYW4gdGhlIGJvdW5kYXJ5LCBzbyB0
aGUgbWFwcGluZw0KPiBmYWlscyBpbnN0ZWFkIG9mIHRoZSBkZXZpY2UgYmVpbmcgaGFuZGVk
IGEgY3Jvc3NpbmcgcmFuZ2UuDQo+IA0KPiBUaGlzIGlzIHRoZSBzaGFwZSBvZiB0aGUgdmVy
c2lvbiBKw7xyZ2VuIGZpcnN0IGxvb2tlZCBhdCwgYmVmb3JlIHRoZSBjaGVjaw0KPiB3YXMg
bW92ZWQgaW50byB0aGUgaGVscGVyLg0KPiANCj4gSSdsbCBzZW5kIHYyIGlmIHlvdSBhcmUg
Ym90aCBoYXBweSB3aXRoIHRoYXQuDQpDb3VsZCB5b3UgcGxlYXNlIGFkZCBhIGNvbW1lbnQg
dG8gdGhlIGFsbG9jX2NvaGVyZW50IHBhdGggdGhhdCB0aGUgY2hlY2sNCmlzbid0IG5lZWRl
ZCB0aGVyZSBkdWUgdG8gdGhlIGFsaWdubWVudCBndWFyYW50ZWVkIGJ5IF9fZ2V0X2ZyZWVf
cGFnZXMoKT8NCg0KDQpKdWVyZ2VuDQo=

--------------npmCfGmSUuxvj35nuWE2jBLJ--

--------------L0WTVrEmB4Otjz5cYuy30BLV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmr+kDEFAwAAAAAACgkQsN6d1ii/Ey9F
eAf7BdZsUW9h4xEFfkcJiLydnpOUWfxRLDQsqpi2SEbCoQ9LxVD2XpeUw0jPdj8Vn+7mugy4MJqd
WwJkVR/g8BMCRyQorHTQaiwqyWFLgSzQQ1y3dhnm5WzRsDfT7x2svxAAAq7kEvnTulGZ5oR0Jlyl
3FUW5nP6hyCrSrGGa64DBMJaMv0IGCR5nnd6zRw4G1Xhx+Qi3ZRXnRXUpd3z5zXjhGgOcYS5zzQQ
hOU39gE4Zj0OYNlDEG1YTaIgS4S2Sr1gs6gqV1G5RId5Qc6FfM0uu2bLNXg4AAuiJuPTvggsUooY
Hu9dlt/JqYC/x+ZHPEEIINT665IinNQWr4mr1GG2ZA==
=c3iy
-----END PGP SIGNATURE-----

--------------L0WTVrEmB4Otjz5cYuy30BLV--
