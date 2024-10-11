Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD461990C4
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664027; cv=none; b=LEDRatQYolfyWmsPMMb23usbWMXgd5mBDUEWQjfYEdGc1pAKKEs62Kbzsfx3d+opgc3NtxsVs6xy5A63AVO2n4/eC6KBWGII1ejm+l33KVb9KmwRFyKNFDFMGjoaBnkwnR5/kMhLtsQbc8DL7ZurW+ovB8hMPOoOyqtSa0BwYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664027; c=relaxed/simple;
	bh=j4vbPdAlY9hV+J4KUZ0fvDwUvocm8C+KS46LmplaExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIJO9VCLlrqss6ZGtAYI/3ekiMym+H5jncfDug6xYK5nlaFtLG4RmKGsu4wlNH5G9tP2UDylaL39TLZPDhKFRlCf7oYZPRCaCCpeu4iBMmjJorB7GvO1S9HjtZln+K+OvPmfV6c9rt6fYr0+yA7myG/Jr6v8OB6coxe2lTyoSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q99d2WBw; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q99d2WBw"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbce16d151so11591036d6.2
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664025; x=1729268825; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PekulykcbN+gb8fZx6BBcDe03TnC4iwq2raCf+a2g4=;
        b=Q99d2WBweltl/GxdBoCwxJ80AqrH8snpyMdBnHcLu+ZuJVxBSfOQ3aUniUsnIdAkNr
         UlGGG/n3xYVru3Wbj5IF7ArWmrJJkEkiTTQUsaTIPqliP/AJ6lA38Bp0wv7okJsH5bZk
         pFg0d8S1J+aUx7tfiP7Uc4rwOTAOFVs49dyaJMh0qMxwuQ3z9GzjUrIam6XJETfCYQOe
         5VIjQLmY8oOCWZNbykYR/s5VyUf44g59fhndYVAnJs95SQEJ8rNhDRlZpPu5Z+DtxAqr
         MhdRpzPnNAOYHnXkebCe+0iDquw6ryGp71HgZdW8rL/0p+RKf1Mo3AnGvdpxGVAen7Zz
         ry0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664025; x=1729268825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PekulykcbN+gb8fZx6BBcDe03TnC4iwq2raCf+a2g4=;
        b=HLZx+INQvWrLUWXZAx5zYg+VP1cidKXFa95USyM/6LY5LFAKdZ9zPi05ZPyOMjPhe2
         wGWc5awkWaAr4dyBKOsQwujV0pELAMoESIWDuCw+/q/9+rUpFuLMECO0zsk7dJpVbWoJ
         JLw3t3iv0fJrFtXt/wFZwznRt4eHKURWndl4YgFJasWePIaXalqJMPs7jJd6VmZ2xMCb
         8uomelKWsNQoIWREtklR+c1f2bISoAXa4sdQnRRocDkH9Oe52hOd3ULAZFo1D0Zkg3iD
         HXXxbl6zenQyFtYkXsht0+AB1gl6wVtrHNhC3WvztVqWsj4zOQ5eFCklYOG+XAc5Kv/S
         AfIQ==
X-Gm-Message-State: AOJu0YxwoN+UGDao7Ss7F/BJn922MJ6f4whfZ1WUVYWe3Ky67bhcIiQ9
	9W5l6GONQnwwPEWiwBdgu8pGufi73jtygsVVABXG7/AtUVkXDsUs3qiXtme9wHY=
X-Google-Smtp-Source: AGHT+IECAA99O9K/DGavVzcBDiJEt0Sio+U49ZIq/HhKSIk3/fbZT/m740AEMp/LNE2YV+t+Qv9gtg==
X-Received: by 2002:a05:6214:320b:b0:6c5:8a85:19fe with SMTP id 6a1803df08f44-6cbf00ef174mr36358106d6.51.1728664024598;
        Fri, 11 Oct 2024 09:27:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7597sm16987756d6.42.2024.10.11.09.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:27:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szITn-007dB9-Kl;
	Fri, 11 Oct 2024 13:27:03 -0300
Date: Fri, 11 Oct 2024 13:27:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
Message-ID: <20241011162703.GL762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-4-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:18PM +0800, Lu Baolu wrote:

> @@ -1623,27 +1623,15 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>  
>  	copied_context_tear_down(iommu, context, bus, devfn);
>  	context_clear_entry(context);
> -
>  	context_set_domain_id(context, did);
>  
> -	/*
> -	 * Skip top levels of page tables for iommu which has
> -	 * less agaw than default. Unnecessary for PT mode.
> -	 */
> -	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
> -		ret = -ENOMEM;
> -		pgd = phys_to_virt(dma_pte_addr(pgd));
> -		if (!dma_pte_present(pgd))
> -			goto out_unlock;
> -	}

Yikes, this is nasty racy stuff, glad to see it go

But should the agaw stuff be in its own patch?

> @@ -3506,27 +3483,26 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
>  	if (domain->dirty_ops && !ssads_supported(iommu))
>  		return -EINVAL;
>  
> -	/* check if this iommu agaw is sufficient for max mapped address */
> -	addr_width = agaw_to_width(iommu->agaw);
> -	if (addr_width > cap_mgaw(iommu->cap))
> -		addr_width = cap_mgaw(iommu->cap);
> -
> -	if (dmar_domain->max_addr > (1LL << addr_width))
> +	if (dmar_domain->iommu_coherency !=
> +			iommu_paging_structure_coherency(iommu))
>  		return -EINVAL;
> -	dmar_domain->gaw = addr_width;
> -
> -	/*
> -	 * Knock out extra levels of page tables if necessary
> -	 */
> -	while (iommu->agaw < dmar_domain->agaw) {
> -		struct dma_pte *pte;
> -
> -		pte = dmar_domain->pgd;
> -		if (dma_pte_present(pte)) {
> -			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
> -			iommu_free_page(pte);
> -		}
> -		dmar_domain->agaw--;
> +
> +	if (domain->type & __IOMMU_DOMAIN_PAGING) {

It looks like this entire function is already never called for
anything but paging?

The only three callers are:

	.default_domain_ops = &(const struct iommu_domain_ops) {
		.attach_dev		= intel_iommu_attach_device,
		.set_dev_pasid		= intel_iommu_set_dev_pasid,

and

static const struct iommu_domain_ops intel_nested_domain_ops = {
	.attach_dev		= intel_nested_attach_dev,

And none of those cases can be anything except a paging domain by
definition.

So this if should go away, or be turned into a WARN_ON.

Jason
