Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCF3644C7
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780271920; cv=none; b=DMqTWg/NN/MWuWtTWQcOxo5bCgFbFEVM+XhUq9T9HlFSLyzcjMdOZ/rlh6Uu39K9heQlPmRA5gIGZ42oT2yqrPD6adEHohmipYfM+V22nB14HeACHMQg7sas87leOPiSVo4JnZyCrMg2OG7B+nSc0hfwfpeU5RWQj2QiJJVTKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780271920; c=relaxed/simple;
	bh=ooYjiyJ6bESeHmXTkdx8VEEz9XJkeLo2Rh6zUaPq15U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM0oYv2YffrYD/qfkljbbgWSj4+2/y2q1joj8ZhRvluD8MdOwNCMRDvHBnxTB6cCIOE0GGcVP3LL5vAdXXCYXBz1moWhool9yJKLPWofr3X2baGMiyNy4vSbMJt+nvljpDYze8MxXBUnyFeMSDjD+NpywZPu6K+AJnt44MU8A8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R//ONftX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R//ONftX"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91562bf6c12so19209485a.2
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 16:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780271917; x=1780876717; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTfGHM2qB3g/FLyvX8FCIrm9+eNCgSr89Naia4gruos=;
        b=R//ONftXcnat7loOmfeyS06bR23G575GxSByJvCruAglqqkhv1txjvFbwXj5I2zXuL
         sBQzZJklgX6vBDm9CXgHrAmMmci4MtfBu4AuWKRMZV0CrhIkQy54mGnGjM6/3NFgKNqi
         5izxrUOsuPToydAV1pI2RwfHTbmSQXej0Ndn+8GIkoEA5Wcbqr1FV3/ESiVVp4/Dlcuz
         U49Oqix+62mwyl/1WxU8+7qZV4aGvj93O4vbjpUNO5+8qcNePxjE0TWMvRwqM3T5qK/a
         uh0WSM/pOxfi4lri38UGhN/m/5yQK9w7VDyZVksNpz6fLxcWDhhI3vFNdPyqq9/fRdU3
         QRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780271917; x=1780876717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTfGHM2qB3g/FLyvX8FCIrm9+eNCgSr89Naia4gruos=;
        b=SW5XpsaRUvk7MIZZlGGUSTx0dV0gUj3gk1T2Z4lenwhzwqX2ExjNXZWoBzSrtHq/hU
         oGXYDPBk/ku998KMjWZhsXS2QJvsiVvc4erhowMx2+9F1xu+1j/g31pUm0wtmUD9gpZB
         RnNplKbm/iJoWteEkAM3zRKZyz/3UD21+KeVdoIBgdnwpDefAlC0fbDanGYkTDTfcCi8
         hoP9Rcm4h8F/6DremYcbd21P8Wh4Fk4ws9rnSDKsszv7VL07wifajXjHQ0YkteMTBuRv
         gAu1QrL2tZgMRx7Ahg/Hk/h7PKEo5yR7t6Sxi+Q0RSyojUa+Q6pJH7q6L/Ul8Ub+me/W
         sNIg==
X-Forwarded-Encrypted: i=1; AFNElJ8nMWshIJXCEMKeR1+IHmDOQimtQPNqpDrKJ1h8pH7sD7zwyXZId4GZiPrTV+54q/7jGwvkMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz41RWo5z6O5FHpgqoPKzWDJfR5p0mKVvtQZ2SZcFjNKbmf2B6+
	Ljskxb9vS23VebubGuONPlaDEwXck9KzBBvzTHOBZPZr6Gj3EyoWnAsjAl4T2AX+AndR3Hhy4OP
	+LxUH
X-Gm-Gg: Acq92OH6DQTj5R7MnDYtD3j3uK5PY0evmndCKzvBvg3i5PdaJOuy7YWOSGzHwCoC5uO
	PljtH6XdOgKIXkJT1gmiewD9vwON8NFU1ZzD23EjS9d9L5c8Ewja6xZShy+STDukXGn+GmBy0tT
	JUaoa6FwQSn19p4Ma6X/LIjgivSUlE3Fd0mhphwKKeXKlNDOk1uaaI/5J1lAhpb1M0AvXOb02tq
	4EgUxDLbFF5pHpkcex5Os0OA+ld9DinaLLWVon80yeIGb2b2P+XaUvBBfDejgxBDISu7wJQkmxm
	0b49Hb2F+0MkzaVd6LYgE0VMa6yqB234dkjjZLxGDZZUL0h1HcXLw64+6eXQuDrxhg8Rb4BdSx1
	SLI5CY1VSibHt/IQjExaJ8SuCc6G3TfxTWn4gvwIdnx6GVp8oxophYF/36UA0vduiKwnQ73g3ka
	19RB4U0RYseqaeKPUnOFSRtb3LtfWLhbpiukGF8JvNeYd0ENehkjPgE84tNTgpX722xnZvfE+wH
	G6VukNL4hM3CGWq
X-Received: by 2002:a05:620a:bc8:b0:8cd:97de:bb52 with SMTP id af79cd13be357-9153d9703b8mr1495082185a.22.1780271916895;
        Sun, 31 May 2026 16:58:36 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153262e2a6sm837284285a.40.2026.05.31.16.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:58:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wTq39-00000001Lt5-3GHA;
	Sun, 31 May 2026 20:58:35 -0300
Date: Sun, 31 May 2026 20:58:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: Re: [PATCH 7/9] vfio/iommufd: use iova_to_phys_length for efficient
 unmap
Message-ID: <20260531235835.GX2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>

On Sun, May 31, 2026 at 05:36:35PM +0800, Guanghui Feng wrote:
>  		/*
> -		 * This is pretty slow, it would be nice to get the page size
> -		 * back from the driver, or have the driver directly fill the
> -		 * batch.
> +		 * Use iova_to_phys_length to get both the physical address
> +		 * and the PTE page size in a single page table walk, allowing
> +		 * us to skip ahead by the contiguous region size instead of
> +		 * walking the page tables for every PAGE_SIZE step.
>  		 */
> -		phys = iommu_iova_to_phys(domain, iova) - page_offset;
> -		if (!batch_add_pfn(batch, PHYS_PFN(phys)))
> -			return;
> -		iova += PAGE_SIZE - page_offset;
> +		phys = iommu_iova_to_phys_length(domain, iova, &pgsize) -
> +		       page_offset;
> +		if (!pgsize || pgsize < PAGE_SIZE)
> +			pgsize = PAGE_SIZE;

It is actually a bug if it returns something < PAGE_SIZE, it should
WARN_ON and try to continue.

> @@ -1177,25 +1177,41 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  
>  	iommu_iotlb_gather_init(&iotlb_gather);
>  	while (pos < dma->size) {
> -		size_t unmapped, len;
> +		size_t unmapped, len, pgsize;
>  		phys_addr_t phys, next;
>  		dma_addr_t iova = dma->iova + pos;
>  
> -		phys = iommu_iova_to_phys(domain->domain, iova);
> +		/* Single page table walk returns both phys and PTE size */
> +		phys = iommu_iova_to_phys_length(domain->domain, iova,
> +						  &pgsize);
>  		if (WARN_ON(!phys)) {
>  			pos += PAGE_SIZE;
>  			continue;
>  		}
> +		if (!pgsize || pgsize < PAGE_SIZE)
> +			pgsize = PAGE_SIZE;
>  
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * Calculate remaining contiguous bytes within this PTE from
> +		 * our position, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
> -			next = iommu_iova_to_phys(domain->domain, iova + len);
> +		len = pgsize - (iova & (pgsize - 1));
> +		for (; pos + len < dma->size; ) {
> +			size_t next_pgsize;

Things should be arranged so the iommu_iova_to_phys_length() always
returns the best length, either because it called into iommupt to get
it or because it accumulated internally on an old driver.

Probably to make this work well the API should include the last
address to reach so it can stop iterating at the right point.

Jason
