Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A387BC433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 15:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28FB540B56;
	Fri,  8 Apr 2022 15:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p90SnXzOlXt5; Fri,  8 Apr 2022 15:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C373A40432;
	Fri,  8 Apr 2022 15:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB37C0084;
	Fri,  8 Apr 2022 15:48:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43145C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B08E41738
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:48:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10RcF8P0E6Ht for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 15:48:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DEC05416EE
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649432884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fNy7kMvRJUEZpOy6RUvT8af/zjCT8c11ZzleUx9H8E=;
 b=GVw4FdQXl3RRcwSAaJvBdIDFO1W+T/5Ia3myq4b9i4pyGq5SFfCyzb6Bqx0pnWi6SaTt6k
 4vEVFZqZXxF2c/BDi4DhePvVWXpj9tDTU2wPtXkm2YSRzNgZBGQWFY0BC2sP19JdOC1CMD
 MtkkWjM4j/kOnu0PIaSeMyxWGyWgmhg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-v4IKtARjMv2tghz0imwwZA-1; Fri, 08 Apr 2022 11:48:01 -0400
X-MC-Unique: v4IKtARjMv2tghz0imwwZA-1
Received: by mail-io1-f72.google.com with SMTP id
 b15-20020a05660214cf00b00648a910b964so5964535iow.19
 for <iommu@lists.linux-foundation.org>; Fri, 08 Apr 2022 08:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=1fNy7kMvRJUEZpOy6RUvT8af/zjCT8c11ZzleUx9H8E=;
 b=WEalQNjoM4d8zW/6CqmIN26JsHd7R20H9fGZetTepYUYcHW8yB5DfcQc6dwdnDXuf9
 kT1PjtBAEMxGF7NT68XFw/9p9BSyiRuujWK39wVabdCuKKL+pCTNT+pdKO2OBuclHq4O
 lPsz56la2mEq+VHKpVdj3BT2iC7sjs0C+j5eeyfHSW0vWvjKYy+AxalFQxgHNQHz7qvF
 LmWZ0WSSiM7vFiHKCi708gVn4w5DA6B4kNXPYUwEoaMYTW/klE4NAZ+rgxgKKXyQKmXG
 c80VZywzFTsFrVl6DxxMSrLGnkvQzMpwMOBiz4+R10AHg9fLznFqEalU1RCfk8lpUmOV
 8ivA==
X-Gm-Message-State: AOAM531HTUvp3nyGLpqZee3Clsw817l9+2LkVbXoy0G6/u6KHxCJ42V8
 Z9DvXOP3OO99ZZSpfckokhqhb381EdK3ldrPJ1pXpeQ5PLCBn2g6fRYTPe0ZtyJPI0VoMZnva8k
 pXGVtVGSF+G/ozeqGOd/OlNJ+bsu/KA==
X-Received: by 2002:a6b:3c08:0:b0:64d:1af2:8ebb with SMTP id
 k8-20020a6b3c08000000b0064d1af28ebbmr3800125iob.95.1649432880674; 
 Fri, 08 Apr 2022 08:48:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF5LvhWwH702+DQY0rh5qZCZuznV1E+Lj3o+ML2iD43l4sXNHSX441Op+XgClKeCefpPxmHg==
X-Received: by 2002:a6b:3c08:0:b0:64d:1af2:8ebb with SMTP id
 k8-20020a6b3c08000000b0064d1af28ebbmr3800112iob.95.1649432880363; 
 Fri, 08 Apr 2022 08:48:00 -0700 (PDT)
Received: from redhat.com ([98.55.18.59]) by smtp.gmail.com with ESMTPSA id
 m4-20020a056e020de400b002ca34a50db8sm10026653ilj.33.2022.04.08.08.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Apr 2022 08:48:00 -0700 (PDT)
Date: Fri, 8 Apr 2022 09:47:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/4] vfio: Move the Intel no-snoop control off of
 IOMMU_CACHE
Message-ID: <20220408094757.4f5765c8.alex.williamson@redhat.com>
In-Reply-To: <2-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <2-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu,  7 Apr 2022 12:23:45 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> IOMMU_CACHE means "normal DMA to this iommu_domain's IOVA should be cache
> coherent" and is used by the DMA API. The definition allows for special
> non-coherent DMA to exist - ie processing of the no-snoop flag in PCIe
> TLPs - so long as this behavior is opt-in by the device driver.
> 
> The flag is mainly used by the DMA API to synchronize the IOMMU setting
> with the expected cache behavior of the DMA master. eg based on
> dev_is_dma_coherent() in some case.
> 
> For Intel IOMMU IOMMU_CACHE was redefined to mean 'force all DMA to be
> cache coherent' which has the practical effect of causing the IOMMU to
> ignore the no-snoop bit in a PCIe TLP.
> 
> x86 platforms are always IOMMU_CACHE, so Intel should ignore this flag.
> 
> Instead use the new domain op enforce_cache_coherency() which causes every
> IOPTE created in the domain to have the no-snoop blocking behavior.
> 
> Reconfigure VFIO to always use IOMMU_CACHE and call
> enforce_cache_coherency() to operate the special Intel behavior.
> 
> Remove the IOMMU_CACHE test from Intel IOMMU.
> 
> Ultimately VFIO plumbs the result of enforce_cache_coherency() back into
> the x86 platform code through kvm_arch_register_noncoherent_dma() which
> controls if the WBINVD instruction is available in the guest. No other
> arch implements kvm_arch_register_noncoherent_dma().

I think this last sentence is alluding to it, but I wish the user
visible change to VFIO_DMA_CC_IOMMU on non-x86 were more explicit.
Perhaps for the last sentence:

  No other archs implement kvm_arch_register_noncoherent_dma() nor are
  there any other known consumers of VFIO_DMA_CC_IOMMU that might be
  affected by the user visible result change on non-x86 archs.

Otherwise,

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/intel/iommu.c     |  7 ++-----
>  drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++++++++++-----------
>  include/linux/intel-iommu.h     |  1 -
>  3 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f08611a6cc4799..8f3674e997df06 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -641,7 +641,6 @@ static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
>  static void domain_update_iommu_cap(struct dmar_domain *domain)
>  {
>  	domain_update_iommu_coherency(domain);
> -	domain->iommu_snooping = domain_update_iommu_snooping(NULL);
>  	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
>  
>  	/*
> @@ -4283,7 +4282,6 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
>  	domain->agaw = width_to_agaw(adjust_width);
>  
>  	domain->iommu_coherency = false;
> -	domain->iommu_snooping = false;
>  	domain->iommu_superpage = 0;
>  	domain->max_addr = 0;
>  
> @@ -4422,8 +4420,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
>  		prot |= DMA_PTE_READ;
>  	if (iommu_prot & IOMMU_WRITE)
>  		prot |= DMA_PTE_WRITE;
> -	if (((iommu_prot & IOMMU_CACHE) && dmar_domain->iommu_snooping) ||
> -	    dmar_domain->enforce_no_snoop)
> +	if (dmar_domain->enforce_no_snoop)
>  		prot |= DMA_PTE_SNP;
>  
>  	max_addr = iova + size;
> @@ -4550,7 +4547,7 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>  {
>  	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>  
> -	if (!dmar_domain->iommu_snooping)
> +	if (!domain_update_iommu_snooping(NULL))
>  		return false;
>  	dmar_domain->enforce_no_snoop = true;
>  	return true;
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 9394aa9444c10c..c13b9290e35759 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -84,8 +84,8 @@ struct vfio_domain {
>  	struct iommu_domain	*domain;
>  	struct list_head	next;
>  	struct list_head	group_list;
> -	int			prot;		/* IOMMU_CACHE */
> -	bool			fgsp;		/* Fine-grained super pages */
> +	bool			fgsp : 1;	/* Fine-grained super pages */
> +	bool			enforce_cache_coherency : 1;
>  };
>  
>  struct vfio_dma {
> @@ -1461,7 +1461,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
>  
>  	list_for_each_entry(d, &iommu->domain_list, next) {
>  		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
> -				npage << PAGE_SHIFT, prot | d->prot);
> +				npage << PAGE_SHIFT, prot | IOMMU_CACHE);
>  		if (ret)
>  			goto unwind;
>  
> @@ -1771,7 +1771,7 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  			}
>  
>  			ret = iommu_map(domain->domain, iova, phys,
> -					size, dma->prot | domain->prot);
> +					size, dma->prot | IOMMU_CACHE);
>  			if (ret) {
>  				if (!dma->iommu_mapped) {
>  					vfio_unpin_pages_remote(dma, iova,
> @@ -1859,7 +1859,7 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain)
>  		return;
>  
>  	ret = iommu_map(domain->domain, 0, page_to_phys(pages), PAGE_SIZE * 2,
> -			IOMMU_READ | IOMMU_WRITE | domain->prot);
> +			IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>  	if (!ret) {
>  		size_t unmapped = iommu_unmap(domain->domain, 0, PAGE_SIZE);
>  
> @@ -2267,8 +2267,15 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		goto out_detach;
>  	}
>  
> -	if (iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
> -		domain->prot |= IOMMU_CACHE;
> +	/*
> +	 * If the IOMMU can block non-coherent operations (ie PCIe TLPs with
> +	 * no-snoop set) then VFIO always turns this feature on because on Intel
> +	 * platforms it optimizes KVM to disable wbinvd emulation.
> +	 */
> +	if (domain->domain->ops->enforce_cache_coherency)
> +		domain->enforce_cache_coherency =
> +			domain->domain->ops->enforce_cache_coherency(
> +				domain->domain);
>  
>  	/*
>  	 * Try to match an existing compatible domain.  We don't want to
> @@ -2279,7 +2286,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	 */
>  	list_for_each_entry(d, &iommu->domain_list, next) {
>  		if (d->domain->ops == domain->domain->ops &&
> -		    d->prot == domain->prot) {
> +		    d->enforce_cache_coherency ==
> +			    domain->enforce_cache_coherency) {
>  			iommu_detach_group(domain->domain, group->iommu_group);
>  			if (!iommu_attach_group(d->domain,
>  						group->iommu_group)) {
> @@ -2611,14 +2619,14 @@ static void vfio_iommu_type1_release(void *iommu_data)
>  	kfree(iommu);
>  }
>  
> -static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
> +static int vfio_domains_have_enforce_cache_coherency(struct vfio_iommu *iommu)
>  {
>  	struct vfio_domain *domain;
>  	int ret = 1;
>  
>  	mutex_lock(&iommu->lock);
>  	list_for_each_entry(domain, &iommu->domain_list, next) {
> -		if (!(domain->prot & IOMMU_CACHE)) {
> +		if (!(domain->enforce_cache_coherency)) {
>  			ret = 0;
>  			break;
>  		}
> @@ -2641,7 +2649,7 @@ static int vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
>  	case VFIO_DMA_CC_IOMMU:
>  		if (!iommu)
>  			return 0;
> -		return vfio_domains_have_iommu_cache(iommu);
> +		return vfio_domains_have_enforce_cache_coherency(iommu);
>  	default:
>  		return 0;
>  	}
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 1f930c0c225d94..bc39f633efdf03 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -539,7 +539,6 @@ struct dmar_domain {
>  
>  	u8 has_iotlb_device: 1;
>  	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
> -	u8 iommu_snooping: 1;		/* indicate snooping control feature */
>  	u8 enforce_no_snoop : 1;        /* Create IOPTEs with snoop control */
>  
>  	struct list_head devices;	/* all devices' list */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
