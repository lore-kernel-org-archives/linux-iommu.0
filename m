Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68983C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 15:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A9861ABE
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 15:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10A9861ABE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9053605F6;
	Fri,  1 Oct 2021 15:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hZoCPiYE3qvq; Fri,  1 Oct 2021 15:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D65C60603;
	Fri,  1 Oct 2021 15:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74D0FC000F;
	Fri,  1 Oct 2021 15:13:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B6CC000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 15:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81C9C4041C
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 15:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tMo52CtU1ldm for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 15:13:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 836494041F
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 15:13:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81639101E;
 Fri,  1 Oct 2021 08:13:46 -0700 (PDT)
Received: from [10.1.27.18] (e122027.cambridge.arm.com [10.1.27.18])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B7C83F766;
 Fri,  1 Oct 2021 08:13:44 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] drm/panfrost: Add a PANFROST_BO_GPUONLY flag
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20211001143427.1564786-1-boris.brezillon@collabora.com>
 <20211001143427.1564786-5-boris.brezillon@collabora.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <02cb188d-e77d-3dd6-ad62-fe56d42724ae@arm.com>
Date: Fri, 1 Oct 2021 16:13:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001143427.1564786-5-boris.brezillon@collabora.com>
Content-Language: en-GB
Cc: dri-devel@lists.freedesktop.org
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

On 01/10/2021 15:34, Boris Brezillon wrote:
> This lets the driver reduce shareability domain of the MMU mapping,
> which can in turn reduce access time and save power on cache-coherent
> systems.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

This seems reasonable to me - it matches the kbase
BASE_MEM_COHERENT_SYSTEM (only backwards obviously) and it worked
reasonably well for the blob.

But I'm wondering if we need to do anything special to deal with the
fact we will now have some non-coherent mappings on an otherwise
coherent device.

There are certainly some oddities around how these buffers will be
mapped into user space if requested, e.g. panfrost_gem_create_object()
sets 'map_wc' based on pfdev->coherent which is arguably wrong for
GPUONLY. So there are two things we could consider:

a) Actually prevent user space mapping GPUONLY flagged buffers. Which
matches the intention of the name.

b) Attempt to provide user space with the tools to safely interact with
the buffers (this is the kbase approach). This does have the benefit of
allowing *mostly* GPU access. An example here is the tiler heap where
the CPU could zero out as necessary but mostly the GPU has ownership and
the CPU never reads the contents. GPUONLY/DEVONLY might not be the best
name in that case.

Any thoughts?

Thanks,

Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 1 +
>  drivers/gpu/drm/panfrost/panfrost_gem.h | 1 +
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 3 +++
>  include/uapi/drm/panfrost_drm.h         | 1 +
>  5 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index b29ac942ae2d..b176921b9392 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -77,7 +77,8 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
>  
>  #define PANFROST_BO_FLAGS \
>  	(PANFROST_BO_NOEXEC | PANFROST_BO_HEAP | \
> -	 PANFROST_BO_NOREAD | PANFROST_BO_NOWRITE)
> +	 PANFROST_BO_NOREAD | PANFROST_BO_NOWRITE | \
> +	 PANFROST_BO_GPUONLY)
>  
>  static int panfrost_ioctl_create_bo(struct drm_device *dev, void *data,
>  		struct drm_file *file)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index d6c1bb1445f2..4b1f85c0b98f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -254,6 +254,7 @@ panfrost_gem_create_with_handle(struct drm_file *file_priv,
>  	bo->noread = !!(flags & PANFROST_BO_NOREAD);
>  	bo->nowrite = !!(flags & PANFROST_BO_NOWRITE);
>  	bo->is_heap = !!(flags & PANFROST_BO_HEAP);
> +	bo->gpuonly = !!(flags & PANFROST_BO_GPUONLY);
>  
>  	/*
>  	 * Allocate an id of idr table where the obj is registered
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
> index 6246b5fef446..e332d5a4c24f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> @@ -40,6 +40,7 @@ struct panfrost_gem_object {
>  	bool noread		:1;
>  	bool nowrite		:1;
>  	bool is_heap		:1;
> +	bool gpuonly		:1;
>  };
>  
>  struct panfrost_gem_mapping {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 6a5c9d94d6f2..89eee8e80aa5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -321,6 +321,9 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>  	if (!bo->noread)
>  		prot |= IOMMU_READ;
>  
> +	if (bo->gpuonly)
> +		prot |= IOMMU_DEVONLY;
> +
>  	sgt = drm_gem_shmem_get_pages_sgt(obj);
>  	if (WARN_ON(IS_ERR(sgt)))
>  		return PTR_ERR(sgt);
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> index a2de81225125..538b58b2d095 100644
> --- a/include/uapi/drm/panfrost_drm.h
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -88,6 +88,7 @@ struct drm_panfrost_wait_bo {
>  #define PANFROST_BO_HEAP	2
>  #define PANFROST_BO_NOREAD	4
>  #define PANFROST_BO_NOWRITE	8
> +#define PANFROST_BO_GPUONLY	0x10
>  
>  /**
>   * struct drm_panfrost_create_bo - ioctl argument for creating Panfrost BOs.
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
