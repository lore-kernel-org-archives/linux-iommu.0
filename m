Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29318CC02
	for <iommu@lists.linux.dev>; Thu,  8 Aug 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122877; cv=none; b=ohzdxFLh8gC5C98UXfh0cPp9U2b9Jr5OkPMhoeplmOH1B7gkEIiA7hErZ1OLN328ERbRiWmwfwesHwziDjuDVRe4RaM4+5hFd2gSbDlXBk9J+/j7yvILt2o7jmLqsJrdmJZIp3EstNOLWAzvjvSwB9hmyX5Yi2ZpBTKbAu+Vy78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122877; c=relaxed/simple;
	bh=9BcU6Etuy+F9fzT7V09q69yexo+bi/TCqSACAPExzgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWrSJKgXo8MWlowZihD5nqFIB8mkbYgvQVCiBFeeUoJS9ioyDz84ibNZZoPYJMUBEyL0zoCx91MClQ7U443g2fQmhwmViAM2gi03WQutGe/PSu7i8MJWavzm1DzWxlESkgZFBCivPFpeJWd0JFLWZv81hGtMe0eoBht3LooCNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XC3DS91k; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XC3DS91k"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d3959ad5so81722185a.0
        for <iommu@lists.linux.dev>; Thu, 08 Aug 2024 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723122874; x=1723727674; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dgXGNnW/b5f9t+CKB4b5Vyo8s9dDJsUrC85u/qccVjs=;
        b=XC3DS91k9wqX2qPrZP0QUAoFMNVqiOHZgF+7uHgnCIitrqThLHkDqGTaPfiNK84Zl6
         4G3WcRkJI1LRySGiawzPGRgnZhB/FYsblXHgaGxEEuQOytULeOvlWzvFEFXiDggd0Rsb
         Z9NvLKRH70OOkXJLLO7TZK8Q/X3toIK5k9WI/vpjfOpTMBDXdVTibtWTK+UuIapki6hU
         ojEgDYkgIfaU1OvPv9J5h/OMk3wDf9CVIjRg4BWGjpm7heTeKTSNBD48MC2G4W0tKyHp
         a9wJYa3SPhtN6xGD79lQ/TUqqj38xKA62lie5eUMcbDtbsvaa4oNyJq34a1r6eoLCkTU
         CCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723122874; x=1723727674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgXGNnW/b5f9t+CKB4b5Vyo8s9dDJsUrC85u/qccVjs=;
        b=JtbyFc/pMq5VmMMOCdvhU34y/BWVB3T/y3YxrEW24a8AdSCH52LYuSwPFHMjCMRUSy
         a/dolVsVFS8M6Q/EhwFHIPuTIkq6byOarjYYk+zrls0X8F1otbvOcX+xYhpu3vlxAPRJ
         mEjGOBf+6J4JeqVXlMtBuclguywKctOK7J6ldMVyEXlIkBIewQva0rZw9kMr6+XU3cJw
         0orSPqWaR3F4JPylGwZe03QgZszQg5EOyODHLn14tD/clM/50qsc6M3kRvHbkmygLrev
         2QABn0SgulAfaopXkAjY5/PYs96HLD7A4LlgrRNJkf2oX29ITeLYqfIB5qKDgkwrkjZE
         lwNg==
X-Forwarded-Encrypted: i=1; AJvYcCUkdJt9zuY5lMmoKUrVgKBRB0m6A3cxXSo7gDZ4CfTZQW/SR0nYMPv/7LoD5v96Coi6LPw+g824I/78RRXkRE8TecH2YMA=
X-Gm-Message-State: AOJu0YxtlLp/JGQOEZ69GDa7zVLzXu8N1M7gJhds2qWj+81CDNShHHLl
	rLa4RSFOabsFlCTlZG1jobYqpHWnvb2UE5CSM6Y9KcF5xK3NIVbg4rcAd+U5Cto=
X-Google-Smtp-Source: AGHT+IHnezL7bVQyZ4vj2ahY4vzl5lMTpzGek5s6d8TdzvnwI8VOuUhjJYFi4WFfdbdI8ZW2URnzyQ==
X-Received: by 2002:a05:620a:4612:b0:79e:fec7:d6e9 with SMTP id af79cd13be357-7a38278a9a4mr249030285a.32.1723122874374;
        Thu, 08 Aug 2024 06:14:34 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e5744sm156520485a.51.2024.08.08.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 06:14:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sc2yO-008v8L-5V;
	Thu, 08 Aug 2024 10:14:32 -0300
Date: Thu, 8 Aug 2024 10:14:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
Message-ID: <20240808131432.GB1985367@ziepe.ca>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
 <389da90e-df78-4ea4-8453-ae2080a68956@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <389da90e-df78-4ea4-8453-ae2080a68956@linux.microsoft.com>

On Tue, Aug 06, 2024 at 12:24:40PM -0700, Easwar Hariharan wrote:
> On 6/14/2024 10:27 PM, Tomasz Jeznach wrote:
> > Introduce first-stage address translation support.
> > 
> > Page table configured by the IOMMU driver will use the highest mode
> > implemented by the hardware, unless not known at the domain allocation
> > time falling back to the CPU’s MMU page mode.
> > 
> > This change introduces IOTINVAL.VMA command, required to invalidate
> > any cached IOATC entries after mapping is updated and/or removed from
> > the paging domain.  Invalidations for the non-leaf page entries use
> > IOTINVAL for all addresses assigned to the protection domain for
> > hardware not supporting more granular non-leaf page table cache
> > invalidations.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 642 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 639 insertions(+), 3 deletions(-)
> > 
> 
> > @@ -856,7 +1473,7 @@ static struct iommu_domain riscv_iommu_identity_domain = {
> >  
> >  static int riscv_iommu_device_domain_type(struct device *dev)
> >  {
> > -	return IOMMU_DOMAIN_IDENTITY;
> > +	return 0;
> >  }
> 
> <snip>
> Sorry for the drive by comment, I just happen to be in the nearby code
> context.
> 
> Nit: It may be better to use IOMMU_DOMAIN_BLOCKED here for readability
> rather than the bare value.

It is weird and confusing, but 0 means "I have nothing to add" not
BLOCKED.

You can't return BLOCKED from this op right now..

Jason
