Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5750A77
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573240; cv=none; b=LG6E83BHQTEXLvVNVu/RuycWMw1m//UD2y9cJyCMju1t5Kh8NPRf5awLElPvlo5yBR0hgGSs4l269g14YEdlCP7ZNnQkg2B7XruFwNaPvvpdiPwUjHmsxUVs6nCDXxQtfOdXZMgqbCj+bPhNtKrWEaas0HdueEtNmc3WlL5s78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573240; c=relaxed/simple;
	bh=3R83bnsQbN94HbZn0B0mPqNXN6cnqVI3A+Obu8DuNRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fek1xwWIIzhzzW4ypS+YUVDRvgD829bMTd9872pj3gWoljw5YY45Eu3fBT5tXwOnEPaD9xpFw1jbgexMOUPi/D+Xt3124YSmdg91i6nYXdAN5UcTzs4aqcS5QbGFiIz3SbadsitEmJp6S8Vt5jrBdXzlpvD87K0yOoyEjb7gji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JxP20XHV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JxP20XHV"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-790f91b834cso271830985a.0
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714573238; x=1715178038; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OZdviol793TFl9mjb+jCdq8bdDZ0SVd44kIwXS0lLc=;
        b=JxP20XHVCQYYyiVDm9V0xP6PPnKZZPzZ7U7dmyjW4QTTP9oq61SWjXheSioIgn7QaJ
         4VaJ3t4u3agf7cKwyl52v0s9C3wwdmfXC01u+MxNc7Dyr66LcQOEKlFBrcfj/j6BvKWi
         r9q/mfTYqarT9kpCtj4hyRlcjL3mDQfFZqzqKY8ktd3SRQXORUvE3mI4e5AHxlhs0n44
         puJKIP+kp2F/0ojGcj2osKgFdJM1IoA4GZ0j+9wWBGigFkUzvKUkGSFEXDd/7/pOzDQ4
         OhLpEeRwqDRaVGfNv2igM/LYXS9S9up9jPTqsnwuUmnsh8ev00S6xYG6Gb91pwcw/3lt
         uACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714573238; x=1715178038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OZdviol793TFl9mjb+jCdq8bdDZ0SVd44kIwXS0lLc=;
        b=o0KRJprAK/ZBusi97FpJgsR3ZS1M5k/fY4r40c8Ir8nBzhLMLkN+nyABgj5m4bnldi
         jjzBx7dTLPZTOnqff2qUj6dZEoFJBPLxLM/SrmF/Vq+HBnD2qfbShPKru9by8WkJ6Hfl
         nAUVO4rjgYR61NTOL0jxjoIJ8Nj6+6LRhJR7m4usNk2H0Izv35L/lj/SlIle0Ndbi/o9
         /g6orR7iUDAOQHTKM8sQY7G4lTosetpELOqWXwMu8Tmle8rPVwMcaE3aDF6XJAgLettP
         w64G+FB+DWDqpx/V2NHt0oHZjPW+05oUCxpT+gdhWBQKPPy6MwSxukKK5e1UnDCFCeJF
         /nuA==
X-Forwarded-Encrypted: i=1; AJvYcCU3w+rH43SXH1wCktU1WjBZYg2DRZ+he0OCXUpLQ0Z9LJbjKmntcVTL3pxzhI32QaOMgFCGl9V8kXiv89QGz3tbhIufBL4=
X-Gm-Message-State: AOJu0YzImzcce43GsmdweMtiutVX9kMmSielVsGT0LfNOogb/VtZgwzm
	oEdMjOFScBQCkTjMbKisSOvXJ1Kd+XhJWSiZHmv2JNFyudPX1mMT9wnjvdRfJ3Q=
X-Google-Smtp-Source: AGHT+IFiJIn1eBd9gVbe/49MW98HCOu6t3+umtKOrKsFADYGs/1ovi0cAzILGroi/jB4gcqE/mL69A==
X-Received: by 2002:a05:620a:2719:b0:78d:67de:50a0 with SMTP id b25-20020a05620a271900b0078d67de50a0mr3265589qkp.44.1714573238426;
        Wed, 01 May 2024 07:20:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id q24-20020a05620a0c9800b0078d677e72f3sm12388656qki.118.2024.05.01.07.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:20:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2Ap3-00DSge-F2;
	Wed, 01 May 2024 11:20:37 -0300
Date: Wed, 1 May 2024 11:20:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
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
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20240501142037.GC1723318@ziepe.ca>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <aa5592da66fe72acd4d4730f544882042e7b5293.1714494653.git.tjeznach@rivosinc.com>
 <6b4a4dc0-ac9e-43cd-bd84-447df2370dde@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4a4dc0-ac9e-43cd-bd84-447df2370dde@linux.intel.com>

On Wed, May 01, 2024 at 06:26:20PM +0800, Baolu Lu wrote:
> On 2024/5/1 4:01, Tomasz Jeznach wrote:
> > +static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> > +{
> > +	u64 ddtp;
> > +
> > +	/*
> > +	 * Make sure the IOMMU is switched off or in pass-through mode during regular
> > +	 * boot flow and disable translation when we boot into a kexec kernel and the
> > +	 * previous kernel left them enabled.
> > +	 */
> > +	ddtp = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> > +	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > +		return -EBUSY;
> > +
> > +	if (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp) > RISCV_IOMMU_DDTP_MODE_BARE) {
> > +		if (!is_kdump_kernel())
> 
> Is kdump supported for RISC-V architectures?  If so, the documentation
> in Documentation/admin-guide/kdump/kdump.rst might need an update.
> 
> There is a possibility of ongoing DMAs during the boot process of the
> kdump capture kernel because there's a small chance of legacy DMA setups
> targeting any memory location. Kdump typically allows these ongoing DMA
> transfers to complete, assuming they were intended for valid memory
> regions.
> 
> The IOMMU subsystem implements a default domain deferred attachment
> mechanism for this. In the kdump capture kernel, the whole device
> context tables are copied from the original kernel and will be
> overridden once the device driver calls the kernel DMA interface for the
> first time. This assumes that all old DMA transfers are completed after
> the driver's takeover.
> 
> Will you consider this for RISC-V architecture as well?

It seems we decided not to do that mess in ARM..

New architectures doing kdump should put the iommu in a full blocking
state before handing over the next kernel, and this implies that
devices drivers need to cleanly suspend their DMAs before going into
the next kernel.

Jason
