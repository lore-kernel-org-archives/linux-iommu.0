Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16A12CDA8
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563378; cv=none; b=V07Na4kvWSzZr9HGMFQdTBvSSxCBWzs18AcZql+Tayi6hvcBawx/6YHhwr8vrugyZCOBcxsFK8/1FAnVL3tL6iOWOW0qa/hRwiSNkl99AEjAgqC3NGhik1HbQtJO/Ly98U5f/VZPJhBNc6uDevrTpNmxw08+P68cEx3ujMPMcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563378; c=relaxed/simple;
	bh=ZHnaZHaZskD/xonYeSEZFFMg+YXeoBIVEBxcMi8GbMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEEsqZenzTZuvIQE5g8gIjnC/mHdINLdcITO/aXDL4bTJi/iNRMDR80IVZpInFfAQo8y/4ar1ZOBsmm925HQ7Nf+Wd6LNVVA/eg63/irDzcKDvln6TyF3PbYjOvNNWzsmviFJIX17+AG2lZgCmMgeHaxEMWTu68lNW2K3a5FXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZRsy+CN4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZRsy+CN4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-794b1052194so8819885a.1
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716563376; x=1717168176; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPPk9ZMB0Ku0hRWNSYQthiNRSt0noAUHxb8eADGB9tY=;
        b=ZRsy+CN4094JL6CqdNxUmsxgPALN1GEzI7ngdVZEle8/nkIrxvjDfsl+I+8/76Hgp/
         KpplnxwXlJF6kqMeQuh43PGLKy09NHWKzSHOy26yhVlMNq7k2iWCud9DHTN4ehnyVFPX
         iRPFtpyxqofsj1Jwepl3EIsRWn/WF1wNzbtvpIMS3Rjioqgqu094LmslCg7n9ugcy/I5
         jrKNaDbw2MNoZ2DLivEg4qRDJrduOdU0BUrjn9tU7wG77fjndk95GOVKV2mUPdELEb9I
         IJxKhpReejUp75D1Se+nY/AOpjlR1eR7m+0xr3NzitrUz3I8n+kXe8szom0Ly/2LuY6X
         B+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563376; x=1717168176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPPk9ZMB0Ku0hRWNSYQthiNRSt0noAUHxb8eADGB9tY=;
        b=Eb+NeW23obM36TJdiX2Jof9UbfkW9kDdwQWB0AL9Uxe6+5TqF1FWTxIGvlt9w+N4jj
         VV+W3J45uV3uzcWjmzbmscQFDTIP/eT0L/ZI+5Ee+ecAKHXoetvCQiTlvfibliIYxFHF
         G9/lIqX6XXz8Xz4hOKfsN64xMpNOAAyh4ReoR337QxVjvf+OTdDe+RAka0hJg4ev6iXV
         V1QzYllS2qEd8hdDoDPjH0rLfsYyp0mT1990eRGDA5be7etgws4vHxc5of3ZMtsjbpcY
         zM3zIxdHrfBIpikF6fcLh3w84J4J5l6vnK3Vj+s92vERq3nezp/L1P2E+QSRPZOwuTER
         vhtg==
X-Forwarded-Encrypted: i=1; AJvYcCUqw7kV/1foXhz6FzA3p0rJyLGu2V9VyBos5zFvqufS4idOWESrlCy4+FDaSWFyVolyNOD78YqEcrU/XSKg+mUJwXU1mt0=
X-Gm-Message-State: AOJu0YzN/68UzcgKpfq1we0b7q+2NHLiHPL8w++NxeSg+JurCvkZdBS9
	LnlZ+xX6WzeEQnr+WABcaLXq0aBZ2F2uBH+HHweJIcMnpNcNR4Ohj3FlX3iqAxw=
X-Google-Smtp-Source: AGHT+IF+iMK+Fk/kuTHFaJ9i9wXeJLcDfA5+fUTHGZpkoNnrMobEJ8vPGJL+mvQIBsyXRFWw9nLt/A==
X-Received: by 2002:a05:620a:2603:b0:790:d62a:da09 with SMTP id af79cd13be357-794ab08688dmr336194185a.5.1716563376237;
        Fri, 24 May 2024 08:09:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcc0f04sm71408585a.42.2024.05.24.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:09:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAWY2-001QzP-Mh;
	Fri, 24 May 2024 12:09:34 -0300
Date: Fri, 24 May 2024 12:09:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20240524150934.GR69273@ziepe.ca>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
 <4a1ac62b8b452f9face321c29502dee8ee88191c.1715708679.git.tjeznach@rivosinc.com>
 <CANXhq0os1R3kR7dCKWs1Yu1ZeaKoQ2b3Q7QbvyU9nRgbB8ZFmA@mail.gmail.com>
 <CAH2o1u4j9MS9Pq7d=4skq-nLM7c_x0Dwqy8WxVfO1FBSWqA0yg@mail.gmail.com>
 <CAK9=C2Wff07Q72LXrB9POz=91t4SNZ8AaLhQdjjjXhbqTYKCHA@mail.gmail.com>
 <CAH2o1u5N9ZdXePh=aJHkYOpLMXeuwQTzCuQJyLdgc3-FAKim2A@mail.gmail.com>
 <CAK9=C2VAWa4jzCW63q366rB60wk2KDUJmF86EtQkVcMYLyiPBg@mail.gmail.com>
 <CAH2o1u4jbObtXDAiXkedy_7P6VyRVTFj9OtmqwjgGYYfys1RmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u4jbObtXDAiXkedy_7P6VyRVTFj9OtmqwjgGYYfys1RmA@mail.gmail.com>

On Thu, May 23, 2024 at 09:13:43AM -0700, Tomasz Jeznach wrote:
> > > The activation of IOMMU_DMA for the RISC-V architecture will be
> > > feasible once the core components achieve compatibility with the DMA
> > > subsystem, which unfortunately is currently not the case. Without
> > > IOMMU_DMA enabled, driver will recognize RISC-V IOMMU hardware,
> > > register itself in the IOMMU core subsystem, and will provide basic
> > > IDENTITY protection domains for connected devices.
> >
> > I am not asking for IOMMU_DMA feature instead I am asking for
> > supporting device MSIs in this series.
> >
> 
> Ok. Makes sense.
> I've looked at the option to pull in / add small change to enable MSI
> bypass window for systems with IMSIC enabled. With that, MSIs will be
> supported, however without full interrupt remapping capabilities that
> could IOMMU provide. If that sounds as sufficient change I'll add it
> to this series.

Honestly I would prefer you keep that seperate as we really need to
discuss the irq window stuff in alot of detail. The current thing ARM
has done comes with alot of problems.

This series seems pretty good to me as is, let's get it merged.

Jason
