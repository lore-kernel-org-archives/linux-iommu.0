Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87312F36F
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575454; cv=none; b=nREFaZpsNUmLMvJuGlxwSNrdvXKUKTkOZI+9FWh6iHUbK3Be6sk/EmN8Vs0AsvNBvs4PUd/rKhLvmtKU+mhu2/qpyn+V7b30aaRHHVzz3EJVOX8uMCi+EwN0dkq7U2Ikr4NfycT4eGPW683FWRpNuwElvOJV1UBwkduPb4L3AxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575454; c=relaxed/simple;
	bh=ap3BJox/MGVOgxqCNy7fpIJSXCiWokvcBZnrVfJZjT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQbKgoCO3c/paFaXzYST4MUptTGXk50O5oIIcknvqOhR5MCI8LzKx42hMaZZWzm/p1QesqVfqWA06X9S1Z1anMLT5J6seeAnvZ1m/AZqoQelaAA2MRj0Be6iCF1uKc1LE2SJDRU68T2EXZs62JViZRA9up/QbBVjMas2+AT0cjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YI4FsW6y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YI4FsW6y"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43a8246b51dso34542021cf.1
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714575452; x=1715180252; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMDuFgQIFZusBttFcIEeiK3dO+QLC27z5ORAgCsbWKI=;
        b=YI4FsW6ynmPEQpPjNYNO/dSQtdp0PR0MK9h8QtxTquwKI4NliM2/mev7LIrEIM3FSA
         Xdffae4Oo17ZyZZmZsSgdcFyimruOG8teKA0kqjP+Cro81P3XJi6dhBu8yzaVmkxCZyN
         BcRc4gO0EoxulcrLaDODs+Tfaxqjmuz8zZY5rk/Pixx+BjZj0E3pnllBJl19E0AXPvXc
         v4yw/tWI3Xe/4wTJdCxuFJA8bEo/rRsjgb+qlPdDnc2DHCMvaZvl6DlbpLVbBlN5TNoL
         0l9HyIj69G2uLIwlSwufAIqjPI1ugkQjt5Bj5msSBx8evGGealHzQA4nWReLRO0hJoIa
         x22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575452; x=1715180252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMDuFgQIFZusBttFcIEeiK3dO+QLC27z5ORAgCsbWKI=;
        b=KuSiZZMkfTqbVA2YlJjHQUWFizU2jpX97d3A56YayGpKyJyXI+Y7qxdDgGpec0lUXv
         IEAQPi21dyf005oP80HwtQKsTa+g5BZ14qfORPFFpYfOayvPGV6rTAf1tM93IJx0krnL
         Lq4ua2B6erFKLP+5kG3wGMkY0eOOs1R1OBgAPHAxQHarNWzFs+1Unq/7FO3soOA36nD5
         jdt97LxSxJgBRkoCesS3Fym3im1vLFxyrN23BIi1QfSy3qjGsyk+HOwJA28ni8FZgoED
         oVEajSLyLoHOUHwjn6vHK5ZzHFkMM4Ym3/cKSLCdAKgflSMWHM68OCxPsCU3rKJMSG78
         heFg==
X-Forwarded-Encrypted: i=1; AJvYcCUVjrt2mJ91w6vTcdjhXpNXl+WPT55e8c47dfg4F1EpCm2RYgBmzzVHeJGBBQhCgE8tWhu7VvBmfOpMiSI3f4/yN5Shrvs=
X-Gm-Message-State: AOJu0Yyi9td5DEGFSNPsJnsRQOAEGx0O0+5jGpt864ZgBhBa9YaADXqN
	XiqM2VyML8zKWy3JX3HEOusahwaIgdRF5+dk26BL+f/plkeJvVW0SYcK3C+wOjo=
X-Google-Smtp-Source: AGHT+IHmOIDK/Mldt2hAVSSoxj1UCLR3AUkPhDiQrlj4ZsACrgmp5YSJE5CUYE4eJ91yhllDRNrddw==
X-Received: by 2002:a05:6214:2486:b0:6a0:cb42:993d with SMTP id gi6-20020a056214248600b006a0cb42993dmr3978427qvb.23.1714575452398;
        Wed, 01 May 2024 07:57:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g18-20020ad45152000000b006a0af6e25c2sm5039912qvq.94.2024.05.01.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2BOl-00DcLt-Fb;
	Wed, 01 May 2024 11:57:31 -0300
Date: Wed, 1 May 2024 11:57:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 5/7] iommu/riscv: Device directory management.
Message-ID: <20240501145731.GE1723318@ziepe.ca>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>

On Tue, Apr 30, 2024 at 01:01:55PM -0700, Tomasz Jeznach wrote:
> Introduce device context allocation and device directory tree
> management including capabilities discovery sequence, as described
> in Chapter 2.1 of the RISC-V IOMMU Architecture Specification.
> 
> Device directory mode will be auto detected using DDTP WARL property,
> using highest mode supported by the driver and hardware. If none
> supported can be configured, driver will fall back to global pass-through.
> 
> First level DDTP page can be located in I/O (detected using DDTP WARL)
> and system memory.
> 
> Only simple identity and release (blocking) protection domains are
> supported by this implementation.

Why rename the concept? We call it a BLOCKING domain, just use that
name please.

> +static int riscv_iommu_attach_release_domain(struct iommu_domain *iommu_domain,
> +					     struct device *dev)
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +
> +	if (iommu->ddt_mode > RISCV_IOMMU_DDTP_MODE_BARE)
> +		riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
> +
> +	return 0;
> +}
> +
> +static struct iommu_domain riscv_iommu_release_domain = {
> +	.type = IOMMU_DOMAIN_BLOCKED,
> +	.ops = &(const struct iommu_domain_ops) {
> +		.attach_dev = riscv_iommu_attach_release_domain,
> +	}
> +};

'riscv_iommu_release_domain' doesn't make sense..

Jason
