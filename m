Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDC4C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 19:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3A6A82F2D;
	Tue,  5 Apr 2022 19:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sv5aoSygPpvV; Tue,  5 Apr 2022 19:50:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5AB6C82718;
	Tue,  5 Apr 2022 19:50:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 243DCC0033;
	Tue,  5 Apr 2022 19:50:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12DF9C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8E73415BD
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3oY7J_VNpN_Q for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 19:50:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A023F416D5
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649188240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMvE598geYS7AsLGKolv801H0ecrutTt3W25tuDKPtk=;
 b=VNcgCIl5LJHJawXZznG2tNgYk2irfqbxlQBZFdqRpFDA0H59shSI7qoj5qlC1RD5j/+uKZ
 D3BlDj7mxDRTH53j23FhvdfUUkBsMgHnia9kco3Uf/i430/R0QzUsUhUSyIbjI+uuSHyip
 uUWkEjX2aqjQcoZTWb5gU9H3Iq11Bho=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-y5R1U4wsPeSqO1FUoSf6vg-1; Tue, 05 Apr 2022 15:50:39 -0400
X-MC-Unique: y5R1U4wsPeSqO1FUoSf6vg-1
Received: by mail-io1-f70.google.com with SMTP id
 a9-20020a5d89c9000000b0064cb68a9ba6so200057iot.11
 for <iommu@lists.linux-foundation.org>; Tue, 05 Apr 2022 12:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=BMvE598geYS7AsLGKolv801H0ecrutTt3W25tuDKPtk=;
 b=vgkmeLAmziVvFN9PLE2zowIh12YdpOiKtHs27+y4tVknXtfStJs9j4Zc89nUdnA+pa
 MB/UykJrcl/yR9q3mWKBQrRWH9TVGYa+XxphEWFa45vn1x92qFwZuFMISaFOSv0r9+Z1
 DLEqOxP72+8bfbW50mFrBU/CxHUDSitBmufK71W7gj2c5DfNBsj3VTfk1l6qVGXtV7EB
 v77aD4PGI4sJ5QA/6nw2hkfI8DWTz3LgIXN+eG091jl4gCUU+6yF+v9cF4axpa1iXQ7P
 gYQ+WOywI1RNN7q9hXSkAY6SUmEp7ljcXkVGLUhQYSN415om97z+k/93eI2ih2H0PgfM
 XusQ==
X-Gm-Message-State: AOAM532u7bWywBxcqKC3lSBOS+PtF0Yzp8vlvpnkepR3ftYMWmsybm6w
 Q8yndJTEE2lcnsm74T0YTTKxlM+Z55RNKiKPbJTA+ftFk7akznsbH99GenH/kPCKCuyig5YYXnC
 iLpsdMMVBT90Zzjp1r3XZZ3hHItiEAg==
X-Received: by 2002:a02:29c2:0:b0:323:a234:9df7 with SMTP id
 p185-20020a0229c2000000b00323a2349df7mr2968416jap.43.1649188238739; 
 Tue, 05 Apr 2022 12:50:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCZgg4vIZs3ezp1ecKFvBApBInnRyJCHzNn5JkctUv/g96VC+Jzbb1H1znHS07OnzGhGeLgw==
X-Received: by 2002:a02:29c2:0:b0:323:a234:9df7 with SMTP id
 p185-20020a0229c2000000b00323a2349df7mr2968392jap.43.1649188238422; 
 Tue, 05 Apr 2022 12:50:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 13-20020a056e0211ad00b002ca32cb7a18sm5029165ilj.49.2022.04.05.12.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Apr 2022 12:50:37 -0700 (PDT)
Date: Tue, 5 Apr 2022 13:50:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 3/5] iommu: Introduce the domain op
 enforce_cache_coherency()
Message-ID: <20220405135036.4812c51e.alex.williamson@redhat.com>
In-Reply-To: <3-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <3-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Nelson Escobar <neescoba@cisco.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Christian Benvenuti <benve@cisco.com>, Robin Murphy <robin.murphy@arm.com>
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

On Tue,  5 Apr 2022 13:16:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> This new mechanism will replace using IOMMU_CAP_CACHE_COHERENCY and
> IOMMU_CACHE to control the no-snoop blocking behavior of the IOMMU.
> 
> Currently only Intel and AMD IOMMUs are known to support this
> feature. They both implement it as an IOPTE bit, that when set, will cause
> PCIe TLPs to that IOVA with the no-snoop bit set to be treated as though
> the no-snoop bit was clear.
> 
> The new API is triggered by calling enforce_cache_coherency() before
> mapping any IOVA to the domain which globally switches on no-snoop
> blocking. This allows other implementations that might block no-snoop
> globally and outside the IOPTE - AMD also documents such an HW capability.
> 
> Leave AMD out of sync with Intel and have it block no-snoop even for
> in-kernel users. This can be trivially resolved in a follow up patch.
> 
> Only VFIO will call this new API.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/iommu.c   |  7 +++++++
>  drivers/iommu/intel/iommu.c | 14 +++++++++++++-
>  include/linux/intel-iommu.h |  1 +
>  include/linux/iommu.h       |  4 ++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a1ada7bff44e61..e500b487eb3429 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2271,6 +2271,12 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	return 0;
>  }
>  
> +static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
> +{
> +	/* IOMMU_PTE_FC is always set */
> +	return true;
> +}
> +
>  const struct iommu_ops amd_iommu_ops = {
>  	.capable = amd_iommu_capable,
>  	.domain_alloc = amd_iommu_domain_alloc,
> @@ -2293,6 +2299,7 @@ const struct iommu_ops amd_iommu_ops = {
>  		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
>  		.iotlb_sync	= amd_iommu_iotlb_sync,
>  		.free		= amd_iommu_domain_free,
> +		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
>  	}
>  };
>  
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index df5c62ecf942b8..f08611a6cc4799 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4422,7 +4422,8 @@ static int intel_iommu_map(struct iommu_domain *domain,
>  		prot |= DMA_PTE_READ;
>  	if (iommu_prot & IOMMU_WRITE)
>  		prot |= DMA_PTE_WRITE;
> -	if ((iommu_prot & IOMMU_CACHE) && dmar_domain->iommu_snooping)
> +	if (((iommu_prot & IOMMU_CACHE) && dmar_domain->iommu_snooping) ||
> +	    dmar_domain->enforce_no_snoop)
>  		prot |= DMA_PTE_SNP;
>  
>  	max_addr = iova + size;
> @@ -4545,6 +4546,16 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>  	return phys;
>  }
>  
> +static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +
> +	if (!dmar_domain->iommu_snooping)
> +		return false;
> +	dmar_domain->enforce_no_snoop = true;
> +	return true;
> +}

Don't we have issues if we try to set DMA_PTE_SNP on DMARs that don't
support it, ie. reserved register bit set in pte faults?  It seems
really inconsistent here that I could make a domain that supports
iommu_snooping, set enforce_no_snoop = true, then add another DMAR to
the domain that may not support iommu_snooping, I'd get false on the
subsequent enforcement test, but the dmar_domain is still trying to use
DMA_PTE_SNP.

There's also a disconnect, maybe just in the naming or documentation,
but if I call enforce_cache_coherency for a domain, that seems like the
domain should retain those semantics regardless of how it's modified,
ie. "enforced".  For example, if I tried to perform the above operation,
I should get a failure attaching the device that brings in the less
capable DMAR because the domain has been set to enforce this feature.

If the API is that I need to re-enforce_cache_coherency on every
modification of the domain, shouldn't dmar_domain->enforce_no_snoop
also return to a default value on domain changes?

Maybe this should be something like set_no_snoop_squashing with the
above semantics, it needs to be re-applied whenever the domain:device
composition changes?  Thanks,

Alex

> +
>  static bool intel_iommu_capable(enum iommu_cap cap)
>  {
>  	if (cap == IOMMU_CAP_CACHE_COHERENCY)
> @@ -4898,6 +4909,7 @@ const struct iommu_ops intel_iommu_ops = {
>  		.iotlb_sync		= intel_iommu_tlb_sync,
>  		.iova_to_phys		= intel_iommu_iova_to_phys,
>  		.free			= intel_iommu_domain_free,
> +		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
>  	}
>  };
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2f9891cb3d0014..1f930c0c225d94 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -540,6 +540,7 @@ struct dmar_domain {
>  	u8 has_iotlb_device: 1;
>  	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
>  	u8 iommu_snooping: 1;		/* indicate snooping control feature */
> +	u8 enforce_no_snoop : 1;        /* Create IOPTEs with snoop control */
>  
>  	struct list_head devices;	/* all devices' list */
>  	struct iova_domain iovad;	/* iova's that belong to this domain */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9208eca4b0d1ac..fe4f24c469c373 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -272,6 +272,9 @@ struct iommu_ops {
>   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
>   *            queue
>   * @iova_to_phys: translate iova to physical address
> + * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
> + *                           including no-snoop TLPs on PCIe or other platform
> + *                           specific mechanisms.
>   * @enable_nesting: Enable nesting
>   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>   * @free: Release the domain after use.
> @@ -300,6 +303,7 @@ struct iommu_domain_ops {
>  	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
>  				    dma_addr_t iova);
>  
> +	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
>  	int (*enable_nesting)(struct iommu_domain *domain);
>  	int (*set_pgtable_quirks)(struct iommu_domain *domain,
>  				  unsigned long quirks);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
