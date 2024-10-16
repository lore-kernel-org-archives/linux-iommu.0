Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6920493E
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071327; cv=none; b=qxt2waQHRbon7B8oaW9oyRAyWi150eLi06kMtnac1lbZo/+/qNZ2qGHg+vF4Y25iLn6gjEn0FEFKgt2lsPVxUCFKQaNcavGw09gjID3KKUcKurzdi54gpdKnlgVSFO7bm4v4LaciRdc2qQ9syw7wGgNVDckxqJovqzvLfws47Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071327; c=relaxed/simple;
	bh=Sv9GOdoP5tZ8KQ/1mrOY0QDCQ+2v3F4j9yqLbFtUipQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKS3MLQaLzCEw5TygYOgrSPwbrLkCQnU3jrK1PgISczd4DpKadVrCev114CLhaVZ7Ebt9rYTj8/HFUKfXg0Q6REnm1wv/tJGCv/BWIJ6RqEYc0JYmF0poIS/lvoiVNhBZzMQy0CHfB9+/54jXefmZGRU51vppPtoHrFQuzvUQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p/YR9Z1R; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p/YR9Z1R"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb51f39394so31015121fa.2
        for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729071324; x=1729676124; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icikz+noVT+A1IghOr2dEkNmSwULz+YkGpQA6euzKVk=;
        b=p/YR9Z1R9ACJcSyyf87P9pCVY10ZKHLZ/c4gzAiGe98vDq74rv4YOPjJkM6feYvk2T
         /SPH9UDqD/qol9g++zy3wO1VSoPxhX81QCpMwfEkm+JD/JCtO5EJidTz5o3c+equUTVE
         lSSApscmFqahL9CgK77PXe7MI9VA1eBHO8LiCw7jiqWastSbpUEJNyLNpoUch5qzPTnT
         jD6uupRXaTZT/DOWF7LsglzQRTg/QUR8OnDelXGnzr8K6vSU6sn6Cogft6Ai1n4tJoY5
         bGoV/z+2F8RITN5OGM7d+IzYOb9D2qcyDut6C2Y6inSroIzda3BVGSbICdvGvwbjx/1Q
         Gazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071324; x=1729676124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icikz+noVT+A1IghOr2dEkNmSwULz+YkGpQA6euzKVk=;
        b=gPIDZBy8JiWmnUIRjm68Ofrwlur7JmUQO/jA6u1IL7xGQpTWCKAZkOXTbnrT6RQz6v
         2/0d/Fpmg17dOktoKnpRMGSTA14qNv/7xAGVuEt6P7qCe1oe2OWB1c9hv7J6pM81GM84
         D+3weNf0JxNtMtk89s1T40H98jUIm92hUJbvHh+DePlRChPjanQDma9JWtyStBstXDS/
         JqvN7bsCoLW/MEoNz8Zzi5DiTzBlgn9weuPWUJHPclxkonfUSqRVBwXXn8YhXhN/LQJK
         T64PDNSFKhilXb6YRNprmLTIY9y0KUojGr5W3RfzUctT1UsSXhZEbnsTS0A45hHnJYXL
         88uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfWHKuxVeru1Dj4gal2WMpK/4yWWRIoMqtOhANh6VX7HeK6Zf2CgYaq8StZWqr4aG9PD+Yww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8APZgQFEdjmKBwSWw41AK4P+pCJc/GHyPLGEOcF1qFoU7L7RY
	XeN6OfOWEOenVnwvkuztXay1oDEGxrcd6Ad7Jf92TU6PpRvryvSTRlcxTXAhSVU=
X-Google-Smtp-Source: AGHT+IGdsTFBiZLsx7xeTyOWkTfBtsndYobtBU/I5Fi4D8Vk3Mbkp1GQJDuJHZgpcIfqpPb22hA7XQ==
X-Received: by 2002:a05:6512:3d23:b0:52c:dd3d:85af with SMTP id 2adb3069b0e04-53a03f2f1ccmr2175646e87.25.1729071323803;
        Wed, 16 Oct 2024 02:35:23 -0700 (PDT)
Received: from localhost (p200300f65f19e3002f38cf427133ca7b.dip0.t-ipconnect.de. [2003:f6:5f19:e300:2f38:cf42:7133:ca7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314bf60fc4sm26528075e9.38.2024.10.16.02.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:35:23 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:35:22 +0200
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
Message-ID: <lagj6ljulmfjogrzhfd3jrf5fnngev63q2g3bmvftwfzc3s6mb@gw6oz4yriyjf>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
 <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vc2emncsrj4cjb2"
Content-Disposition: inline
In-Reply-To: <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>


--3vc2emncsrj4cjb2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
MIME-Version: 1.0

Hello,

On Thu, Oct 10, 2024 at 12:48:05PM -0700, Tomasz Jeznach wrote:
> +static const struct of_device_id riscv_iommu_of_match[] = {
> +	{.compatible = "riscv,iommu",},

nitpick: Unusual indention:

uwe@taurus:~/gsrc/linux$ git grep -l '{.compatible =' | wc -l
192
uwe@taurus:~/gsrc/linux$ git grep -l '{ .compatible =' | wc -l
4197

(Hu, I expected the difference to be bigger than a factor of ~20.)

I'd go for a space before ".compatible" and one after the trailing
comma.

> +	{},
> +};
> +
> +static struct platform_driver riscv_iommu_platform_driver = {
> +	.probe = riscv_iommu_platform_probe,
> +	.remove_new = riscv_iommu_platform_remove,
> +	.driver = {
> +		.name = "riscv,iommu",
> +		.of_match_table = riscv_iommu_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers. Please just drop "_new".

Best regards
Uwe

--3vc2emncsrj4cjb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcPiNcACgkQj4D7WH0S
/k7leggAlsgDNwa3KOwBku5V/0eQ57YS6VqfeJom1rXbWx9kfuKXyA1X2FD5V6eH
DEc2IdXEIy1pM/AxZbbt5gNqs2UR6L9VfWToyK+unN62it0PTXxp21dUmdjRXH6e
1nb0PRAAknig82wzfc7EedPJZgp6E46w229pZbiIwOpDbgQOko+r7X3qBB/g9qUh
EHzEVCZ61ySvWWlo5n6mglBmMAiAOB1K/j13oLIp5Em2ym2r+J5/Tq4FmLhe3Evb
auslSx2a/QBlMF2jpdrxRBiCYjlDXbcU27NkVEimEgu/56llOuhZisOYCTlmnMYR
Cr+0vmUBG3jSXmSBeNr4sS9tAy0J6g==
=+mcI
-----END PGP SIGNATURE-----

--3vc2emncsrj4cjb2--
