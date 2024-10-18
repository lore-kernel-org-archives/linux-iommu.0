Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD215381A
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229500; cv=none; b=lCSDBH14novv3+C6XKOan1AokWUqCSZKfnGl9Yqd5+fV4c3rdLdkvrEFQzIUCP1dWVaBN8Tlq/kxGKMEaY8oDSCx+VJCpfXjScXxvVMVza2Z68nQhrHC4s3DjCg1OGrTzUjAYLu0DWX1vxCtVzAPyDKel+8MKX0PMEairY4Ey8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229500; c=relaxed/simple;
	bh=c6pJR17Cx+vhBdPlKGr1glBzn0/Huh2wZWajDJPJL9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPBHpX/Z2fobwZ9gAbAxmsPKxvG6ELazJeb6TrAvTPMIFpQriV8fjEablloCaifMqTom+TPhuTFKQyIW5zzRv29QT+4KvWzk2VMxhnDxeN2B0irB8kQorhPyKeu0CrP8CDF0uWOQhTi5iBCSkrcd3ba7HqOIWS+RCN+1MclP7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cV/+umE6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cV/+umE6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so1289969f8f.3
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729229496; x=1729834296; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6pJR17Cx+vhBdPlKGr1glBzn0/Huh2wZWajDJPJL9g=;
        b=cV/+umE6YA/u3sH10navUnV59SKFq9UVSanR4plZ7F14nz9ydEA04RsUzLDiS8KK20
         0M+wAzFAj1ZHnPHv0LCbn7bdEP3spdog9pJ0LEKmA0x038ZbD5XoJCEC74bpuVnZryVf
         MDlBbW5/A3gNv4aGzcyBOzh/CdOVaqNx8k1ZqD2avOdq+OykQE6B3MwAM7wMmC70km14
         rRfLJKxQlidVtFlPmoT+HHKpz1Xxe96kptoXE0Nu2Cv/L9MLTihV0wh5eu8pEuOgj1Id
         ZNLYF0sSRFMBe+FrsD6lfG6Bl+2aQ0NjhrBBltJma0vyFrrN3jsjI1so3BV1tPkdeydR
         wQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729229496; x=1729834296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6pJR17Cx+vhBdPlKGr1glBzn0/Huh2wZWajDJPJL9g=;
        b=ocCYLN6bBVZ80YAQoqiFZdxpCewHNMLLjg2ROA2o2/LrP0nWqCW/GvMpNMl8ccFAAa
         z5ktJ2JuTZw5RDqCrDub+6j9NeWW66Aba/ZfeG+8+vsITzj05aqIQuQxEQwxaABei0eD
         RGEdMEGGhUY26basaLsrwd9ml3f0YOg3PLo8DpszMFikoOtBhSIL7ALlPPRxQ3rckDY5
         N1rBmqfVZdljOh4VZvoR15hfCYqfijIk7LdK33Sjy1TftZSiXlpfeTa+Zdst+HP50Fxr
         SBH4/8idOdtlUxXr6gfiOMipyu9WH7dt4hzodKfnzMNt6AC2Zp/BTjoN9DrrfK1t/lTd
         5M/A==
X-Forwarded-Encrypted: i=1; AJvYcCX8XeG8p9ewkAAS08moewTBMjiyJwUmAcauVQTw66C0mEZrQS6KiojP4+uiP9vcSmQ0GHMLGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YynJLi6Kr0wG57YzpIKTd2kOpEr8kttHSZ/sm2EedpoinxQ+206
	KHu+ORhGXX2f2GGfCZmPY9dn4RxFmSpJe54H+eArUzmXseCwXL7Uk2bPKVZaRPY=
X-Google-Smtp-Source: AGHT+IG8Ld3kpTB/rwLsIFn3KMclllCP6Lx/tf5/1/edc8B38j82iBjzH0rHnvWAB7r6efnRAWqU6A==
X-Received: by 2002:adf:e008:0:b0:37d:3735:8fe7 with SMTP id ffacd0b85a97d-37eab70bbf3mr720253f8f.32.1729229496469;
        Thu, 17 Oct 2024 22:31:36 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:c04e:758c:2eb5:eeda])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c29ddasm44973866b.211.2024.10.17.22.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:31:35 -0700 (PDT)
Date: Fri, 18 Oct 2024 07:31:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <5jxxlmvyyennvrg5w6l3ma5pg7ythzo6z65nhs3lhpscmcl5sc@w22emfmvf2rg>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
 <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
 <lagj6ljulmfjogrzhfd3jrf5fnngev63q2g3bmvftwfzc3s6mb@gw6oz4yriyjf>
 <CAH2o1u4BYyHhi3dVcBrB8T2JpXdxStsfYodmOT-6a8KMHAot8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbh7gyoiozliysgu"
Content-Disposition: inline
In-Reply-To: <CAH2o1u4BYyHhi3dVcBrB8T2JpXdxStsfYodmOT-6a8KMHAot8w@mail.gmail.com>


--fbh7gyoiozliysgu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
MIME-Version: 1.0

Hello Tomasz,

On Thu, Oct 17, 2024 at 09:45:14AM -0700, Tomasz Jeznach wrote:
> Thank you for those comments, they look reasonable.
> Can we postpone those changes after v10 is merged into the iommu
> subsystem tree?

If the patch is already scheduled to go in, that's fine.

My motivation to reply is the .remove_new thing and just pointed the
indention as I noticed it while replying to your patch. So I don't care
about the indention. Do as you please.

drivers/iommu is still on my todo list to convert from .remove_new to
.remove, so you can just wait until I come around. I'll push it a bit to
the end to be sure to have your patch in next already so it will get
converted in a catch-all patch for drivers/iommu.

Thanks
Uwe

--fbh7gyoiozliysgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcR8rIACgkQj4D7WH0S
/k54eQf/YHC2YibpwUipmuB41HqAHsAljGTGCjGvubnogU3Jg8+TQNsVCfGqZXiu
si3jNg2XK8hVkXTPzdSH0nIRx+Be7vhMJWMyKr894iU5YDrDDV2n1Y+isdYzrUal
rzz5N1eG26FaxM4czeRU064oACyOKuyPIYY10yrkQiko3A3sWVa5SMHS4fm4IWIV
2KXXGUkx5ctFSaCtJCseENcFdV/yAmQ/Y83sQrle/sqrou8wkm7WIegZHMEe22cT
nG3GMref6aC4I4kLjFhQKdUKEkqJuqkhcYzqhuq+TGSUGet/ZkN6AR8N0+QA3RDr
6iM6q7fDc1d3XirP6chF+olWVozGxQ==
=jEvi
-----END PGP SIGNATURE-----

--fbh7gyoiozliysgu--
