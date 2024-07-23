Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC5A15216C
	for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740124; cv=none; b=rR2t5DjwlBdBY7r0sEBQEYIj7OmjaDoTOeZoEr1tET8iV+U49+1svvAxo3ie9z4CASOjUEE/+/Fl6H49/A70GeCLf4rJa1KuNYYvTyeAQuFxYnwO2sCjQgKIcPglAQItJcK6978SFc5A12gbpSwQzLuYaUoDcwifwYmQ+gCrIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740124; c=relaxed/simple;
	bh=anpGqlaJTd/4YOCYRdZXnrrSVEHn+JR0BCZ71ULmuWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slj9yOCzvJxz6VhApvjzgZ0mom3jeABirB/iDGTUhwuPN9j8pU2Tx2dxnpm5plxtPdX8usdTo0d0u6GAThbYKeunI8puRezPNyI8TIAyYcSFU5PvJi018wpf7Tj6ZY/KPjsL5nAJFTdk9gVcrPHvYxDIaZKSEZ9ritTqFzV9NNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fZ0cOE4S; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fZ0cOE4S"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447e2d719afso37431031cf.0
        for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721740120; x=1722344920; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+axTqVsfgDHJ4ABgdOvxQq1+BYfsc3vDRLQbJOeOOAo=;
        b=fZ0cOE4SuQQpWXcsCA4os2pTO4andnzP+XAliwYe/rMcZycp5d1Rzo0TOLlaY2WAs9
         K19iM7DvopWLs3RtU6D/ozCq8zpOWATMBDTTye5+AsrxoXM/igs/daZkQypG9UVIuXMx
         psPT/6z5cjM3EGOJDsRyy26ib2AYIKwkx1mG9IRGwQoJMEUNCi+36cUTHEhzMTOD0foG
         KhsMjLevOFKisGWEPvEapGr13dg8GzGFpUw3CIvGZGkqQguXjpvqazv/f6Q69gq3Mdbd
         vqgxa97b35QMBvm4gXh3mcPrUlM0IV0cUYi42jWhZo1rltUbHTyHuv1i9CO4kP9OAkMZ
         JPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721740120; x=1722344920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+axTqVsfgDHJ4ABgdOvxQq1+BYfsc3vDRLQbJOeOOAo=;
        b=IDjUQr4aQ/85hSbbSz2Wf3eYW3rCapz/EQ3Qu0uZVN1CZqb/lg6qjo7fXCCNh/9wj+
         zD43HMJbrn2xNjLa+i15qvbO+NXT8660yPdvXBB24zusiZUGEdGoIfjDUbXS243zjvP1
         b0CHIqRSOAHt+PG1qa/lCNzUeT1vz8VKeq4gUuBWneSGwz0f8+xdESj1TgfIk0QLxKkC
         9CCEa4MYXIAQA7f/NBf4n2oCDLRQNwGOOtU1JieOWxMepjaydfzPGoRvwR2oHHRCc8l7
         7vu1su8ap3NLsV/fpasXLgAxgjznO1iK0L9M5PPfCW3IOFbpStfaPnoVftwEYzC2Kg21
         QL7g==
X-Forwarded-Encrypted: i=1; AJvYcCWe7y9xYe5fFn4a8FPQNzyuq0JMgTBgcagpx5SWZ+ZypmnuH2UcOYGe9jAx/7D7kORw7uTISDfG8nTIH5MAjGWDiX2m8EQ=
X-Gm-Message-State: AOJu0YyXooGHCmH8jBoLzgDdHRjOr4Sz7N2PULMksMdtDgJLG9xIydud
	2PXwaa7RqJ1UUy10jqQnfwLbivw9OJT/CXuqpItGlxK59/BbkbVv9CeTOSGXvEE=
X-Google-Smtp-Source: AGHT+IFdiAXbdFdhLaoPZtxacfRA4jPBGSoBhjNyXiB95amXvNCVw1j1puDQQ+mYwJ3alK8exv17nA==
X-Received: by 2002:a05:622a:ca:b0:43e:1231:1040 with SMTP id d75a77b69052e-44fc7fa8970mr35543231cf.20.1721740120332;
        Tue, 23 Jul 2024 06:08:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd3cfccsm44348711cf.54.2024.07.23.06.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:08:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWFFv-003hHI-CL;
	Tue, 23 Jul 2024 10:08:39 -0300
Date: Tue, 23 Jul 2024 10:08:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
Message-ID: <20240723130839.GL14050@ziepe.ca>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
 <CANXhq0rpX=+YZLfzLcBmHPUxBpo+xWPY9XaNkV0eQAX72KCFKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0rpX=+YZLfzLcBmHPUxBpo+xWPY9XaNkV0eQAX72KCFKw@mail.gmail.com>

On Fri, Jul 19, 2024 at 02:33:13PM +0800, Zong Li wrote:

> > +static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
> > +{
> > +       struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> > +       const unsigned long pfn = virt_to_pfn(domain->pgd_root);
> > +
> > +       WARN_ON(!list_empty(&domain->bonds));
> 
> Hi Tomasz,
> I recently hit the issue here when I removed a device. I think we need
> to unlink the device's bond in domain before releasing domain.
> Do you mind pick the following modification in this patch? Thanks.
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 859cdd455576..f0707147e706 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1541,6 +1541,8 @@ static void riscv_iommu_release_device(struct device *dev)
>  {
>         struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> 
> +       riscv_iommu_bond_unlink(info->domain, dev);
> +
>         synchronize_rcu();
>         kfree(info);
>  }

That does not seem the right place to put that, or something else has
gone wrong becuase:

> >  static const struct iommu_ops riscv_iommu_ops = {
> > +       .pgsize_bitmap = SZ_4K,
> >         .of_xlate = riscv_iommu_of_xlate,
> >         .identity_domain = &riscv_iommu_identity_domain,
> >         .blocked_domain = &riscv_iommu_blocking_domain,
> >         .release_domain = &riscv_iommu_blocking_domain,

The above use of release_domain will attach to the blocking domain
prior to calling release_device and when doing so everything about any
previous domain should have been fully cleaned up.

So info->domain should be the blocking domain during release_device
(if not that is another bug)

And attaching the blocking domain should have cleared the
domain->bonds of any prior paging domain.

Jason
