Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213E38E8D4
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415277; cv=none; b=gsfMXyG0elfzxB5DfuTHRMSszEFE48U/l3eTGUT9xeBORyP112o6PBjU+qED1BCuTq6w6cj81tISVon7i/3EQHWpSzC47mK0WLOuGOxhH4FyQIPbvJJk2Na54R0iumszHaMzxjIFtCcLUOamPA6TJOI9WKWJcQS0OZT/0ksEjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415277; c=relaxed/simple;
	bh=sI/lThfPPa6ZbQMicdFXAkGpuTpYP7bvsD6WMn+lQQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN2Ejs4Ny4c7gNVAh0S2XnZhN274PZn2RTvTG3cl4i6ajQc8vLPV9Xlg+LP/DyVnHPCkiYcv/LFzmF71IfD0hPzPZJzRVK1tp386chmwkukUh3L99ykgOk0hPwR/roL+pZh7XhQO9hlPry741yXn3v2e+xd8Pv2pZJ+PWjvlW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Y8PEE/bE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Y8PEE/bE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so34549885e9.1
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783415274; x=1784020074; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sI/lThfPPa6ZbQMicdFXAkGpuTpYP7bvsD6WMn+lQQs=;
        b=Y8PEE/bEnSRj8CuVUb11Tz0faNHrb45e3qKGl6cxmmhnNrwHDHcghHzn35NAE9docj
         yZOFbqFXO8CPWfJ31/kofHGGRb/c0ha9hhgtjFjl16DcDhEEWm8VvtPFU4UGG/7bO8ae
         j7fTBKu9ykcENe/xavxc4EuzLpcprOSXQNFGuFulN/OLXVX12GVYe1LNI3Im5mJ5oAfe
         Jio8G6UiRKxPFu+OpjAUj8oiTG42DWZWbcAZl/y14RiorMJsLoTD8l3MsPCSVta3aY3k
         XijcpBr2O0ePEjpwdFbDQ3r9mLoc94vsQBY2jY+jFGfO0Uo7212zO8y6mnLInAXP5S8X
         Ei0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415274; x=1784020074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sI/lThfPPa6ZbQMicdFXAkGpuTpYP7bvsD6WMn+lQQs=;
        b=l9t7lwvMhvQ1OxGS2TNcQdpybR4+0XPUph4T54dPUAIVtjbJJ5aPXJ2KMMFb74iig8
         YnX7qWZzxB4Rp/r4YZ28kRZwo+uf8rr3Z8tVTa6vPjlaLrdDCXvJZyFMydKveJjfk12H
         ke7ywy3ddpbhbG6nxgVugCbslaIi61XiCTy/Jr24P3+GBRPtNZfl8LxMIqcOiKCz3pRd
         7iYIhIR/68oitenUxNSfqJHpPx53Lpt7Hqyme1uQoA49JMVvwRIl/2BL9YvT5DoWEjzz
         WGyYWnMtR6VCGUXEG7BXuaUrhPMkxl6v/Zfcki8JOrs1rUFnL2qx0zI4P0G5Ga7H136r
         FGRA==
X-Forwarded-Encrypted: i=1; AHgh+RpEE+tRUZ/MzlBrmNgM4g8/LGchPCrw8wKdPTqwmjD1sSfQQBkPfypqDiDXZ76j3MbT+Qczew==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpM2CXHSpEtLd0Iv7ienPy9ww9+KFIHyRw6uiwsGSc8u3frY1o
	IR4mWoQtPGPhaHg68UAZNOEfv5vG72lQBktEhHX1zp8WszgLZmdoMD3TnaXx/s+qCL0=
X-Gm-Gg: AfdE7cm3bJIvSOCMalBDXm9z9xsDOjmZMmE3b/A8J9nMEne5rmXRH/73t0UhDeIsahG
	9i7GLGAUGBe9VnIwvvG4PGuW/WD3bhXo1S9Dwz/UUNSUpuHVsXCA9J6B+X31zDYU/6uxVJK8Hk+
	hY7H1P3yGXCyfC7wSzSEVYf+brznGhqzrx12LZ5okoO167Kzf96lbdGFS2RhiliZxmK6UvhtJib
	7UzW5PxzHJ9PA/51XjtTwgw76ndY7rshM8EL4WZ1x9EUVNgLIsh0pFoJUdsrsrgt+vf+kmfpISB
	QovpvTGVDsZPS5QmBvwF/hWwKkRtKaLBlL7DXvatV2NsWFDMdKOT5SaA0AZViLijFTQOqCc8Etg
	mGrYy+P+GzjbaKAgvo/Se9wNZtqOfs12xYGKfvGN1tQsF/UbcXgvpcbQuT1YAx8rCWgIllI6r8S
	RmmWzSkji5bfMH/nFCJl422UjjGZCMuOmaBurKGE1ePKefeVmIM1L1dk/v4vu1aD9W+/vlLLeBj
	RG1
X-Received: by 2002:a05:600c:a011:b0:493:a8eb:5145 with SMTP id 5b1f17b1804b1-493df063da1mr47094795e9.4.1783415273961;
        Tue, 07 Jul 2026 02:07:53 -0700 (PDT)
Received: from localhost (p200300f65f47db0437b4d928ee3eb6f8.dip0.t-ipconnect.de. [2003:f6:5f47:db04:37b4:d928:ee3e:b6f8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493e0fc1348sm41108005e9.14.2026.07.07.02.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:07:53 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:07:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/riscv: Drop superflous zeros in pci_device_id
 array
Message-ID: <akzBoIyLjEKZk-5j@monoceros>
References: <20260522145943.774344-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ey6zjmsvpt54p5f3"
Content-Disposition: inline
In-Reply-To: <20260522145943.774344-2-u.kleine-koenig@baylibre.com>


--ey6zjmsvpt54p5f3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] iommu/riscv: Drop superflous zeros in pci_device_id
 array
MIME-Version: 1.0

Hello,

On Fri, May 22, 2026 at 04:59:43PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The .driver_data member of the struct pci_device_id array were
> initialized by a list expressions to zero without making use of that
> value. In this case it's better to not specify a value at all and let
> the compiler fill in the zeros. Same for the list terminator that can
> better be completely empty.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

This patch was sent before v7.1-rc5 and missed the merge window leading
to v7.2-rc1. I wonder if it's still on someone's radar?

Best regards
Uwe

--ey6zjmsvpt54p5f3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpMweQACgkQj4D7WH0S
/k6rpAgAnTFyflMCkuo0PNYUPa4d10VpQnXa5capkEKkV/j9oJywGHlRsvrtBsWb
25TCYntEvTW5V/uH4ZmVVLRWgxMTghVqFxokevX/yKYlXE0u7Ud21v8/9oEOU79O
zAoRhsh3GQlz3TdWHwsrMqar1TJlSGc/ao7uI5oeMlzu/unWD5ki/j2JZJio+s5b
hqYRLYF8uCeYPjQVTkas5MyAgw9lVux54oILDGSjyOWMpXbXY1uRx6tDagP27KHK
lJulkKCBN3/v5axD66zYw4a14M1NzJPFsgdQeOt51nXbTpom2AQlJeX+dOMMrMzO
+2in5sBwtKDcJIPIoy/Y7H/yic2J1w==
=lib1
-----END PGP SIGNATURE-----

--ey6zjmsvpt54p5f3--
