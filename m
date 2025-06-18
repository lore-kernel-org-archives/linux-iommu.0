Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F22DF3CE
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253283; cv=none; b=rPxXe57RfAxB8y21POqmzdnT50QB5/oGpuQgG8h08E6hE+MH8fLBxtiURRRJQ9sUjSwyvYmk3e0IhC/W/Csv8N/FwHArwsVxvtgfqrPmzdX0YIKijuQG5eDnIyed/zTPBObuU8LDL75QuhvzrjRgwkx9XWJZznPdHL9tOX+7PaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253283; c=relaxed/simple;
	bh=spJmW3GP09NgivKGhFqMEC1dTy/Kkyfb4nxmgBOucEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3OCInPmpSvmnAA87zih67vLv4vjjY5BwYdraR8JhqwnXUK8w7tAFwkvesKRBgiWd+2BogJrAm0MaVv6y3prrcu9oRc4i3UUxsTaXv6tJDQcT/E3baXiCKyzcypis7ISyxOuVDWB8TPyu6aruKdtUovtB3+aL2E1bfdbCmy18j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BeKT657a; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BeKT657a"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a440a72584so67382681cf.2
        for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750253280; x=1750858080; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dAOqSpqCOL5vjgDSfWa7ZrwFL1vtEzIytDfSsqz8LEg=;
        b=BeKT657aPJBKXxCPjtQG+BP+vVLfUICXQafLcHB7X6WWTbpNRLvLDJttBDuAM78g+H
         xvpyaIqcDSFiNT5ekxcmR2HQlrgMn33R9ra0qpZP5nL1+vaNl+GusdRLTzaut2VGAcYR
         udDEbM2eDi9Ml1C/efo5ISG0Ecq5XBdFMP722kHFnuyZ9t2dp4Jd4UV1HL2h6FcxMwgv
         8eePrtfRlT7OFi2T4EB2EwpwcfIJl2y6QfQpnFnsdO+9O1FIzuu2rXGSPGBixYpiY0/Q
         iTfO5UhyV4/CeezbVNenOZ5ftitQQladjK5wSRwcvdPdAmOrf+cEC+eSt7sKa27MFleW
         lT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750253280; x=1750858080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAOqSpqCOL5vjgDSfWa7ZrwFL1vtEzIytDfSsqz8LEg=;
        b=gHfWE4Xm14F/Ret3BKIIoVbIXxbkNcT5Lp8MwPSJU+kb7VKTtxVJfer7YGQ4pKygZc
         eFkF9PXaWn7PmKY2iDAQWN03rYX2FqJuTcyJIO00j8aBz/Eh6bv38bHL6z8eILAnXGnr
         k2rFbqXTuJNiVEP+iDDenyMt6lciKw3ioVI7dXWNKL3J6dgph3nOJPz/hy6VNa6iDbCf
         bw3ialxw9KHQXGz4TOiS16ZfPzCNH6erkSPXDMk6ZzWlgiayJqZBk/B8OIfwJii7iLLt
         M2Q8mE46AUIl6x7iBIJ17f0aEy4mFpOy3nlaLK98M258bXnbrOx5gHvn5Ve3JViCedj6
         KS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK1n5NPpBvPHrwHz/NLyViW4hvVXEZm18dhd1pFEdkh7hbDddTqZvEqftoqHgQ20OMOnWO/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwunZlwN8YV5oTw6SCvg68fnO07w4W6q5gGrOlXlCqdd1t/ClUH
	ucPXnArkLntYS6x7MV0TYnJFiXqUNwbqxC+QYBRdthiAmbXsM59+dkQx9hjd0HzF4fI=
X-Gm-Gg: ASbGncuU7aG50mmnuJnaIQf+dea6dbL/KAO0Q1GnAxm190w+f0HD3HCk0s2EX28I5a6
	nVjrGPQvCg2gFFAQa8EAgZIi9Wkn7bg0TYc6S+JA/L4g5FKPI92isXO6pP00Qn/xpXx+xC1BThF
	3cIKfMDgKaZN78HnrJ6xB3fdI3zxAVxdQv0txJNMWCVKBsLQU/FLxYSEe62bB7eqiAakaJjdy8N
	SCalHBix+iKkPe2rSQ+KO0h+D5ZypUo76/gDDgA2qVCQS9Ld0cqfUE/F538+tMwfUrsiSwMjECp
	FsNMj3/Jb/wzqmBPRtDD3Zedqb1xbbhIgQznvMwRTYLe+NeM4dlYuuBffDSbht6Tgjal0Hv5rhU
	VeoDclyEY7i+ddEeCD4qV9FXO3cmhIYQThmC0Dg==
X-Google-Smtp-Source: AGHT+IG2fHMkumSLh5a7kRlQvfCzWqyNaNQCt2F7JGbyl37Cd1Kzlhrtl/JlBPjRFd8BrqzAM7ABWw==
X-Received: by 2002:a05:622a:1886:b0:4a7:2328:27dc with SMTP id d75a77b69052e-4a73c4fd24emr201270391cf.9.1750253280248;
        Wed, 18 Jun 2025 06:28:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a50f29dsm71636961cf.75.2025.06.18.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 06:27:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRspb-00000006mz5-0lhB;
	Wed, 18 Jun 2025 10:27:59 -0300
Date: Wed, 18 Jun 2025 10:27:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250618132759.GO1376515@ziepe.ca>
References: <20250616145607.116639-1-benjamin.gaignard@collabora.com>
 <20250616145607.116639-4-benjamin.gaignard@collabora.com>
 <20250617163219.GF1376515@ziepe.ca>
 <ff32d7c1-d811-46b8-8d3d-458dfebd14f8@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff32d7c1-d811-46b8-8d3d-458dfebd14f8@collabora.com>

On Wed, Jun 18, 2025 at 02:04:19PM +0200, Benjamin Gaignard wrote:
> 
> Le 17/06/2025 à 18:32, Jason Gunthorpe a écrit :
> > > +	vsi_domain->dt_dma = dma_map_single(dma_dev, vsi_domain->dt,
> > > +					    SPAGE_SIZE, DMA_TO_DEVICE);
> > > +	if (dma_mapping_error(dma_dev, vsi_domain->dt_dma)) {
> > > +		dev_err(dma_dev, "DMA map error for DT\n");
> > > +		goto err_free_dt;
> > > +	}
> > > +
> > > +	vsi_domain->pta = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
> > > +					       SPAGE_SIZE);
> > > +	if (!vsi_domain->pta)
> > > +		goto err_unmap_dt;
> > > +
> > > +	vsi_domain->pta_dma = dma_map_single(dma_dev, vsi_domain->pta,
> > > +					     SPAGE_SIZE, DMA_TO_DEVICE);
> > > +	if (dma_mapping_error(dma_dev, vsi_domain->pta_dma)) {
> > > +		dev_err(dma_dev, "DMA map error for PTA\n");
> > > +		goto err_free_pta;
> > > +	}
> > > +	vsi_domain->pta[0] = vsi_mk_pta(vsi_domain->dt_dma);
> > > +
> > > +	vsi_table_flush(vsi_domain, vsi_domain->pta_dma, 1024);
> > > +	vsi_table_flush(vsi_domain, vsi_domain->dt_dma, NUM_DT_ENTRIES);
> > dma_map_single already flushes, put things in the write order and no
> > need to double flush.
> 
> I don't get your point here, for me it flush two different pieces of memory.

dma_map_single() already flushes the cache, you don't need to do it
again.

Do your memory writes then call dma_map_signle().

> > > +	dte_index = vsi_iova_dte_index(iova);
> > > +	dte_addr = &vsi_domain->dt[dte_index];
> > > +	dte = *dte_addr;
> > > +	if (vsi_dte_is_pt_valid(dte))
> > > +		goto done;
> > > +
> > > +	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
> > > +	if (!page_table)
> > > +		return ERR_PTR(-ENOMEM);
> > Don't use get_zeroed_page for page table memory.
> 
> I will use kmem_cache in v2

I mean you are supposed to iommu-pages.h for page table memory.

> > > +	pt_dma = dma_map_single(dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
> > > +	if (dma_mapping_error(dma_dev, pt_dma)) {
> > > +		dev_err(dma_dev, "DMA mapping error while allocating page table\n");
> > > +		free_page((unsigned long)page_table);
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +
> > > +	dte = vsi_mk_dte(pt_dma);
> > > +	*dte_addr = dte;
> > > +
> > > +	vsi_table_flush(vsi_domain, pt_dma, NUM_PT_ENTRIES);
> > > +	vsi_table_flush(vsi_domain,
> > > +			vsi_domain->dt_dma + dte_index * sizeof(u32), 1);
> > Double flushing again.
>
> Same here, for me I flushing two different memory area.

write to the page-table, then call dma_map_single(), don't flush it again.

> > > +static int vsi_iommu_map_iova(struct vsi_iommu_domain *vsi_domain, u32 *pte_addr,
> > > +			      dma_addr_t pte_dma, dma_addr_t iova,
> > > +			      phys_addr_t paddr, size_t size, int prot)
> > > +{
> > > +	unsigned int pte_count;
> > > +	unsigned int pte_total = size / SPAGE_SIZE;
> > > +	phys_addr_t page_phys;
> > > +
> > > +	assert_spin_locked(&vsi_domain->dt_lock);
> > > +
> > > +	for (pte_count = 0; pte_count < pte_total; pte_count++) {
> > > +		u32 pte = pte_addr[pte_count];
> > > +
> > > +		if (vsi_pte_is_page_valid(pte))
> > > +			goto unwind;
> > > +
> > > +		pte_addr[pte_count] = vsi_mk_pte(paddr, prot);
> > So why is this:
> > 
> > #define VSI_IOMMU_PGSIZE_BITMAP 0x007ff000
> > 
> > If the sizes don't become encoded in the PTE? The bits beyond 4k
> > should reflect actual ability to store those sizes in PTEs, eg using
> > contiguous bits or something.
> 
> The iommu use arrays to store up to 1024 4k pages indexes so the size
> isn't coded in the PTE bits but the numbers of used indexes for each arrays.

That isn't how it works, if the PTE bits don't code the size then you
don't set the VSI_IOMMU_PGSIZE_BITMAP. You just want SZ_4K for the way
this driver is written.

Jason
