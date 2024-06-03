Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84412C52F
	for <iommu@lists.linux.dev>; Mon,  3 Jun 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419193; cv=none; b=OneIyZo2vN1lMZRDZjbXOOqCnlk5y3bv5xGTbw2YXbmEzpmC81JXCw20o24we7yL+ATn9hP0sjB1Zjo3krcfKnPML4HMTQWsL+n31TtC2cyTrZyHrQwrJGrt9KUoN+HMfe50jtE4KpzFN8Aq1LrtER6KqANDNuEXTgcfnp4nVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419193; c=relaxed/simple;
	bh=QX4iMKVssxoVyavrTllOasYtXwgAZT/oiXydBXbLzW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON8dSeKDhouPEquMbYOyx9LS/Ng1W3y5+L05CUAWWdABvs7+hTVeLdrCQG0vQj1+M70n5IzblW+PpFgYwb/bMfkeFXNAyG3ErwMsirukHelppoNYfo0iiotkxNvwEJk2LS/T57FFIyS7vc54ek7AdsyZGSPbGW4tr9i/jJpw7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EXoK47g+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EXoK47g+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4212e341818so26757435e9.2
        for <iommu@lists.linux.dev>; Mon, 03 Jun 2024 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717419191; x=1718023991; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bimdtL/8Yb4rbSFpMqz1UL6qiGEqUPhGsLy+D1hTls=;
        b=EXoK47g+RtRVn325eLoq37U8mFQpvop6QQG6cDAvhZLXwDK6+N/r+1HJu0SlyVdaVa
         zbMPQtVoYoaR1UgSSI7F3BDRVz1vc8qW62JRHHwR/GbKiTRfIzuyjsENQd+XT7cJtjOh
         IeUb87KPxkk+HIokcBPtvXau8jtCr9ggzndZcADSiuF39ESjTFKvYQ3typx+xC4qUJDO
         iCfdgW2nXNCNpPFgn3LZ9CfjrA5va6zbkEW8cJhYgA87kh5UbD9erki0+Xb+yDKOOupY
         3rlg+dQv/tkmortOkhHTc+NnqHCCzILYAwxr8pB99W6KId+RNDhdV/M7E8NhgPzNhAm8
         2a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419191; x=1718023991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bimdtL/8Yb4rbSFpMqz1UL6qiGEqUPhGsLy+D1hTls=;
        b=lqBZQ5fGE9j2wqF8jqLqfl9UVKKBM7vjOWTx1Dl1lP2uwUCC4IYBXdYhQ7HGk0RTz4
         SfE3kL8ho+k7X7ttkXucGqY2UdEt3/eYHYnOM2gVzRrkq711vxJ5o98ssi47vf5yip9u
         RdmkcpcB/f5vq/cw1GW46JGDKYFqwu+BJGHc961URzjITGHd0Q4KyNICFy/8hkAAcUi5
         +gL/HKE3cxBFHL89Q6hOn2918/aUSyRelkzbWe5x4UYKgYoJ1D9tpDsBV3+UxjcE73xo
         s8YDI+M5Gk6mfmb77g9XH8/qR5Oxmz/Ikq4HqGhnR4XUR5o0pQPHO6L0a7+4p4+cWSle
         7hSw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+oz4g59kkKQaEEJMa+RbrV4HSnHztBSoanSQSDHgfY77JEvL3lAdA8OZbrPJvp4i2GkHsBI4RsdPt7Yxdy0Cej9RY10=
X-Gm-Message-State: AOJu0YzJ9txwzJnIHauf3pd6SYeLrnPBxrXjl7kyw2ic3xmpw2jDcYIQ
	PAGUnWf4nSIlF3XgXHP/8sF/fTNfCqrbvUzjkibplgyw43o6brTY4UnYfFveQdg=
X-Google-Smtp-Source: AGHT+IGr2qULxcr2ltWgvnytabKWi1pfPCuyLwlDBqb6eNha2uciqvGkQ3OnCBvDSIF3/JuDzfDAZw==
X-Received: by 2002:a05:600c:3510:b0:421:3674:7933 with SMTP id 5b1f17b1804b1-421367479e1mr41938045e9.27.1717419190599;
        Mon, 03 Jun 2024 05:53:10 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5e3d1902sm1783031f8f.32.2024.06.03.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:53:10 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:53:09 +0200
From: Andrew Jones <ajones@ventanamicro.com>
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
Subject: Re: [PATCH v6 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20240603-c4a8257697f83cd3bace6ce5@orel>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
 <20240529-08fd52a8e703418142bdfa84@orel>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-08fd52a8e703418142bdfa84@orel>

...
> > +/* 5.19 Performance monitoring counter overflow status (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTOVF	0x0058
> > +#define RISCV_IOMMU_IOCOUNTOVF_CY	BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTOVF_HPM	GENMASK_ULL(31, 1)
> 
> RISCV_IOMMU_REG_IOCNTOVF* for all above. It looks like this
> got renamed and the header of the spec subsection still has
> the old name, but otherwise the new name is referenced.
> 
> > +
> > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTINH	0x005C
> > +#define RISCV_IOMMU_IOCOUNTINH_CY	BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTINH_HPM	GENMASK(31, 1)
> 
> RISCV_IOMMU_IOCNTINH* for all above. Same header with old
> name spec issue.
>

Scratch these suggestions. Based on IOMMU spec PR#243 ("Clarification
updates to IOMMU v1.0.0") it looks like the iocnt* names are getting
fixed up to be iocount* names.

Thanks,
drew
