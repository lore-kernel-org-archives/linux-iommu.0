Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070697;
	b=v4v6DnRPeS+sgGrbs2dNHp8bmOyFyHipsFiNun/lJk406NNkJ1/JxUY+Ckpn+1aY2ttQ
	 /Ad5o2S2HkvIDDAkJfS83rBEeRny3VMT2N4V3gt2VQQpZp7yub/MgFOiPNotE792TvPWm
	 JH+qpGZ5FY+yBlaPrV3gehiCXLeFGEVYZ9QKjpqRZPbfsMxRI0wrzZouvakwUmHJTVj9o
	 xX1yRTCYU1evpsUMBb9dkB38/0ifo9smzVM4y0pQUmrX2ncR91epUxiKYovUTBJC/Dvx/
	 BVA78c0s9St4Ds2LjEDPGK2GRFFVHyGyZHKiw07BMo7+IVJCEli9xGdB4sbPxsXZTKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=gx3IKd3H/J7FeV0UbqNeO9FYoO/jP2uhAsiBT/hJXZs=;
	b=wJt7FmwIWSd/K3RFebmw4I/uahz5mXYt6f/XeGI2a6iOCPCbNdwkkUC6LP0ELNDDbunp
	 VoUMQ0+ytIxGAJWaoLWdfIEPjnNIElIQpmMmw0IYXvtyanvZFy5pZjm8vvDyVKfvyh1EF
	 NXoCHNSQW7E46ZL0V0Bz97iyE49hGdpiBGHKfA4KIapLSeeuBrnjFjnRpq/0laGodVElc
	 9Wa/AyQBFDjPXJ9+DweO1678I8on8dalB/rrSnB2HGvzjHbChrQYEK160SziPQG4gq5f7
	 EXYgaFcuaDiMa2mDsPKiBGSloS1mvoGiS6H5WfvQFfZ8DNJpdq5EhZYgNlAGXsHhTLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NgZNkzMm;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D8606A320
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 06:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E94D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NgZNkzMm
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a42b34e930so1494558f8f.2
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 22:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795070695; x=1795675495; darn=lists.linux.dev;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gx3IKd3H/J7FeV0UbqNeO9FYoO/jP2uhAsiBT/hJXZs=;
        b=NgZNkzMmt8eqvMctapHd+dJ0njgQZWZYjbIhMXHULqdoQjNcI2nG+ANPg2g2ACe8rz
         VsEmguzNbATbi3Qna2Yuz/SrTw1nA0V0gl2Ca/j6shVItTvy1OlWe+1f6VhX9leUK51H
         CC3EWPaz1M8CI3S5r6/rTRR1T75VT6P+MKjVdbo0zjZ5MPcRujclCEHRgatvFQnH3ruN
         cHRyv7fvUgqejpOHPzkAMZGR/8FvUM0fiWNmqFEFHkzQWk+FdK4vG12+RWbRBhpN9n9O
         FFjShGHFO/o5wsX6gEG+H+VXATOaKdNglboUV9xXK2lnTbCe3Re+A01MNAw6l3ZCRmwu
         waXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070695; x=1795675495;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gx3IKd3H/J7FeV0UbqNeO9FYoO/jP2uhAsiBT/hJXZs=;
        b=Zdn4gmqYsA4O/5DSZDEbvA8okKddKkmDfiiGh28s6vi0kKR/yHeErRmA9h7+hbYAOS
         8Z1VTM4lAxtq2KjNCLzvrrAyaq21HaqStmOu+UTITgxKTgWG3vuiz1ElDnug6Aqv1Rf5
         QENvk/jRhssdUA43pxtxXv+YxT77R4g7Qk4f9FPSKCAH3wyKzXiRNbasEdqYVjgHH4R/
         0ZArDr6YSl4g8dEVRxKnQO9KKoYCVwp256yJIaovObIjieySQnqhT6pC4dGBPxxxoZO2
         3uMfBLRzeFAOUGA8RVgwAEjfYM8wFseIzcdtnuCEJj6vaWQWZOwFxXbQlE4226cMWdgx
         uJrw==
X-Forwarded-Encrypted: i=1; AL+hErHD/l9L8MK1Vcmqbbqa6B5OJEV61DyzU8YtnsO2vZkbXtjMyaYaP3l2iz9tDj0hs3uJWJPWLA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/EsgrWxjWpSy5RG4WQQtgVRV+7hqs+7ogpxRvrBvZA59FW1G0h
	NVh/a4CLK+oxkMRW29NvbjAZUR7K0CWoo/QaelofKSK/TSAwMM3UzeYmAzb5NhjBLDU=
X-Gm-Gg: AZFdTZeDKUcX4jQB6kvGFJfkLyY3YRkdZHdIzSif+QgN3vWhcb5rJnYivRu0UmBt0RM
	vGzt8bBmo5scbOWZ7BKGfP0Y+glwpRHdR5QZCak8I0Ddyr1JLy1M8X8EIdb2BMIlUmypbEg8oGJ
	+0e+tDjubrX/ePUeka4dgmDugn+HKwcvQVfew8zhI/bP8s84ZmpBSYsjEXxFH/Tff1E5VUv7esG
	ZrJ63HN7l1ckliEodBIp9E6ufiSi5u15WcaVd22eTc7iwsl/YcgPzHPs5Rsb/ETrB2eiNysUpA6
	bKNGk99aEauVu5d+FyQlPUc/P7x1AjHe0k+K2IEpTaPwfAtmwqLpFSpdNNc6WZ1wCYaE3pt19Wz
	yRTa/YP2A7O04F+nWYZSfa7itv8qcTkpmvcoVBNu8MqruE171+RUNMuLNnmwCEDJvkrxlKnRU+9
	1CD7NmISx939sArUQ3LqRCCV0batsxWSOVgXC7CbIK0yrNYzt+M5ixvRXnjg6g5dvqIQpbQqpmu
	EpNRz6f/Uw5P/mOFGI/72JWOanRkEhikUdAwFbS9b/k+z1G2ppgYuHdZZkoy58ApnzvAiBa/iXb
	Nx5ZLx3QnVBrUmL9YyFncyG9yQS6OEwHvJe39dPxVkNN5B9IV1ZJLhAPMOlIyM5saWwP4k9ZGSL
	RzIjtSRoFK1axucxSZJOV57/tGs3mBJTlZJHcevNAMLKIGBJzcY50
X-Received: by 2002:a05:6000:4617:b0:487:27f9:840 with SMTP id ffacd0b85a97d-4a63d6a459fmr9772581f8f.53.1795070695314;
        Wed, 18 Nov 2026 22:44:55 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c11f1csm9437350f8f.53.2026.11.18.22.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 22:44:55 -0800 (PST)
Message-ID: <c906fcbd-8671-4257-8250-9c09d38f6b53@suse.com>
Date: Thu, 19 Nov 2026 07:44:54 +0100
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
Subject: Re: [PATCH v2] xen/swiotlb: Bounce mappings that cross the segment
 boundary
To: Lin Liu <lin.liu01@citrix.com>, sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com, andrew.cooper3@citrix.com,
 ross.lagerwall@citrix.com, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
 <4a2d59f8d5a2b1399fc8bdf6e49202c9c2f394a7.1795069501.git.lin.liu01@citrix.com>
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
In-Reply-To: <4a2d59f8d5a2b1399fc8bdf6e49202c9c2f394a7.1795069501.git.lin.liu01@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LIGiRNSFugMGqSq0b2MFddW7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LIGiRNSFugMGqSq0b2MFddW7
Content-Type: multipart/mixed; boundary="------------Xemoc0Pv264QPqL109RvJbGz";
 protected-headers="v1"; hp="clear"
Message-ID: <c906fcbd-8671-4257-8250-9c09d38f6b53@suse.com>
Date: Thu, 19 Nov 2026 07:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xen/swiotlb: Bounce mappings that cross the segment
 boundary
To: Lin Liu <lin.liu01@citrix.com>, sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com, andrew.cooper3@citrix.com,
 ross.lagerwall@citrix.com, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
 <4a2d59f8d5a2b1399fc8bdf6e49202c9c2f394a7.1795069501.git.lin.liu01@citrix.com>
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
In-Reply-To: <4a2d59f8d5a2b1399fc8bdf6e49202c9c2f394a7.1795069501.git.lin.liu01@citrix.com>

--------------Xemoc0Pv264QPqL109RvJbGz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMTEuMjYgMDc6MzgsIExpbiBMaXUgd3JvdGU6DQo+IFRoZSBibG9jayBsYXllciBh
cHBsaWVzIGEgZGV2aWNlJ3MgRE1BIHNlZ21lbnQgYm91bmRhcnkgdG8NCj4gcHNldWRvLXBo
eXNpY2FsIGFkZHJlc3NlcywgYnV0IGluIGEgWGVuIFBWIGRvbWFpbiB0aGUgYnVzIGFkZHJl
c3MgaXMgdGhlDQo+IG1hY2hpbmUgYWRkcmVzcy4gIEEgc2VnbWVudCB0aGF0IGlzIGNvbnRp
Z3VvdXMgaW4gYm90aCBzcGFjZXMgY2FuIHN0aWxsDQo+IGNyb3NzIHRoZSBib3VuZGFyeSBp
biBtYWNoaW5lIHNwYWNlIGFuZCByZWFjaCB0aGUgZGV2aWNlLiAgQUhDSSBkZWNsYXJlcw0K
PiBhIDQgR2lCIGJvdW5kYXJ5LCBhbmQgY29udHJvbGxlcnMgdGhhdCBkbyBub3QgY2Fycnkg
YWNyb3NzIGl0IChlLmcuDQo+IE1hcnZlbGwgODhTRTkyMzApIHRoZW4gRE1BIHRoZSB0YWls
IG9mIHRoZSB0cmFuc2ZlciA0IEdpQiB0b28gbG93Lg0KPiANCj4gQm91bmNlIHN1Y2ggc3Ry
ZWFtaW5nIG1hcHBpbmdzLiAgQ29oZXJlbnQgYWxsb2NhdGlvbnMgbmVlZCBubyBjaGVjazoN
Cj4gdGhleSBhcmUgbmF0dXJhbGx5IGFsaWduZWQgaW4gYnVzIHNwYWNlIChyYW5nZV9yZXF1
aXJlc19hbGlnbm1lbnQoKSksIHNvDQo+IHRoZXkgY2Fubm90IGNyb3NzIGEgYm91bmRhcnkg
dGhleSBmaXQgaW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaW4gTGl1IDxsaW4ubGl1MDFA
Y2l0cml4LmNvbT4NClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5j
b20+DQoNCg0KSnVlcmdlbg0K

--------------Xemoc0Pv264QPqL109RvJbGz--

--------------LIGiRNSFugMGqSq0b2MFddW7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmr+muYFAwAAAAAACgkQsN6d1ii/Ey9L
HAf/X0Pm4J7+wBBKEjrIufQWB6suG5g7l9JkTCLi7GWNeLxMhwGj/TklDgnzrB+Ob2euHI5rLASO
g//lwldmRx37r1spQYDFdcgdYmWwvCmEbiBCFaffMZln2/u1G0rkEX/aNTagnomlkblqnQRYZADJ
9UwPjzh+DvvOEP6epdxoUK9n9YHQEMeRO67SBL8bhStv1HTfzdknZGC87RVxxcPkt2maPCi+oDcB
fsRMJaTF0SR+Ng71IdBN5Emke0k39vp7R+W2Na8bDmLnY642R5OCVvZ7cw1JT/JL+l2F1WG/dIUd
ncfCfbUfFbuxu9W69Rn945V8vvcVVj2UOWNqa8WyHQ==
=+1hD
-----END PGP SIGNATURE-----

--------------LIGiRNSFugMGqSq0b2MFddW7--
