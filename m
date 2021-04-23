Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E24C433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 13:31:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466AD61450
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 13:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466AD61450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF56E843F8;
	Fri, 23 Apr 2021 13:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XE4yI7oKrMvc; Fri, 23 Apr 2021 13:31:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5B82843F9;
	Fri, 23 Apr 2021 13:31:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89871C000F;
	Fri, 23 Apr 2021 13:31:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B75FC000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F49440618
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2QVOE9mKd973 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 13:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39B0D400DA
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:31:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DBFB1396;
 Fri, 23 Apr 2021 06:31:31 -0700 (PDT)
Received: from [10.57.62.63] (unknown [10.57.62.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B58A3F73B;
 Fri, 23 Apr 2021 06:31:22 -0700 (PDT)
Subject: Re: [PATCH v5 08/16] swiotlb: Update is_swiotlb_active to add a
 struct device argument
To: Claire Chang <tientzu@chromium.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210422081508.3942748-1-tientzu@chromium.org>
 <20210422081508.3942748-9-tientzu@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1f84aa4c-f966-0986-b5a4-eecbf3b454ec@arm.com>
Date: Fri, 23 Apr 2021 14:31:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422081508.3942748-9-tientzu@chromium.org>
Content-Language: en-GB
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 jani.nikula@linux.intel.com, Nicolas Boichat <drinkcat@chromium.org>,
 rodrigo.vivi@intel.com, bhelgaas@google.com,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 nouveau@lists.freedesktop.org, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-04-22 09:15, Claire Chang wrote:
> Update is_swiotlb_active to add a struct device argument. This will be
> useful later to allow for restricted DMA pool.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_internal.c | 2 +-
>   drivers/gpu/drm/nouveau/nouveau_ttm.c        | 2 +-
>   drivers/pci/xen-pcifront.c                   | 2 +-
>   include/linux/swiotlb.h                      | 4 ++--
>   kernel/dma/direct.c                          | 2 +-
>   kernel/dma/swiotlb.c                         | 4 ++--
>   6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> index ce6b664b10aa..7d48c433446b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> @@ -42,7 +42,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
>   
>   	max_order = MAX_ORDER;
>   #ifdef CONFIG_SWIOTLB
> -	if (is_swiotlb_active()) {
> +	if (is_swiotlb_active(NULL)) {
>   		unsigned int max_segment;
>   
>   		max_segment = swiotlb_max_segment();
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> index e8b506a6685b..2a2ae6d6cf6d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -321,7 +321,7 @@ nouveau_ttm_init(struct nouveau_drm *drm)
>   	}
>   
>   #if IS_ENABLED(CONFIG_SWIOTLB) && IS_ENABLED(CONFIG_X86)
> -	need_swiotlb = is_swiotlb_active();
> +	need_swiotlb = is_swiotlb_active(NULL);
>   #endif
>   
>   	ret = ttm_device_init(&drm->ttm.bdev, &nouveau_bo_driver, drm->dev->dev,
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index b7a8f3a1921f..6d548ce53ce7 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -693,7 +693,7 @@ static int pcifront_connect_and_init_dma(struct pcifront_device *pdev)
>   
>   	spin_unlock(&pcifront_dev_lock);
>   
> -	if (!err && !is_swiotlb_active()) {
> +	if (!err && !is_swiotlb_active(NULL)) {
>   		err = pci_xen_swiotlb_init_late();
>   		if (err)
>   			dev_err(&pdev->xdev->dev, "Could not setup SWIOTLB!\n");
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 2a6cca07540b..c530c976d18b 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -123,7 +123,7 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>   void __init swiotlb_exit(void);
>   unsigned int swiotlb_max_segment(void);
>   size_t swiotlb_max_mapping_size(struct device *dev);
> -bool is_swiotlb_active(void);
> +bool is_swiotlb_active(struct device *dev);
>   void __init swiotlb_adjust_size(unsigned long size);
>   #else
>   #define swiotlb_force SWIOTLB_NO_FORCE
> @@ -143,7 +143,7 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
>   	return SIZE_MAX;
>   }
>   
> -static inline bool is_swiotlb_active(void)
> +static inline bool is_swiotlb_active(struct device *dev)
>   {
>   	return false;
>   }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 84c9feb5474a..7a88c34d0867 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -495,7 +495,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>   size_t dma_direct_max_mapping_size(struct device *dev)
>   {
>   	/* If SWIOTLB is active, use its maximum mapping size */
> -	if (is_swiotlb_active() &&
> +	if (is_swiotlb_active(dev) &&
>   	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))

I wonder if it's worth trying to fold these other conditions into 
is_swiotlb_active() itself? I'm not entirely sure what matters for Xen, 
but for the other cases it seems like they probably only care about 
whether bouncing may occur for their particular device or not (possibly 
they want to be using dma_max_mapping_size() now anyway - TBH I'm 
struggling to make sense of what the swiotlb_max_segment business is 
supposed to mean).

Otherwise, patch #9 will need to touch here as well to make sure that 
per-device forced bouncing is reflected correctly.

Robin.

>   		return swiotlb_max_mapping_size(dev);
>   	return SIZE_MAX;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ffbb8724e06c..1d221343f1c8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -659,9 +659,9 @@ size_t swiotlb_max_mapping_size(struct device *dev)
>   	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
>   }
>   
> -bool is_swiotlb_active(void)
> +bool is_swiotlb_active(struct device *dev)
>   {
> -	return io_tlb_default_mem != NULL;
> +	return get_io_tlb_mem(dev) != NULL;
>   }
>   EXPORT_SYMBOL_GPL(is_swiotlb_active);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
