Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC8C2BBD1
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 10:37:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F52D2072E
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 10:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F52D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D6C2486FE7;
	Thu, 17 Sep 2020 10:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XBx_4jDb5eJZ; Thu, 17 Sep 2020 10:37:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C91A8447F;
	Thu, 17 Sep 2020 10:37:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F1F5C0864;
	Thu, 17 Sep 2020 10:37:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48A47C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 10:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 39C1986FDE
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 10:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDLTksPuue4D for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 10:37:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5137E8447F
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 10:37:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AF6930E;
 Thu, 17 Sep 2020 03:37:24 -0700 (PDT)
Received: from [192.168.1.79] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EE013F68F;
 Thu, 17 Sep 2020 03:37:22 -0700 (PDT)
Subject: Re: [PATCH 2/3] drm/panfrost: Support cache-coherent integrations
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, robh@kernel.org,
 tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
 khilman@baylibre.com, narmstrong@baylibre.com, jbrunet@baylibre.com
References: <cover.1600213517.git.robin.murphy@arm.com>
 <52dbcdfd15d804f35ba8c984c650144782f762da.1600213517.git.robin.murphy@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <03eb19ef-4535-59c8-994c-15adfe3b75ca@arm.com>
Date: Thu, 17 Sep 2020 11:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <52dbcdfd15d804f35ba8c984c650144782f762da.1600213517.git.robin.murphy@arm.com>
Content-Language: en-GB
Cc: linux-amlogic@lists.infradead.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

On 16/09/2020 00:51, Robin Murphy wrote:
> When the GPU's ACE-Lite interface is fully wired up and capable of
> snooping CPU caches, it may be described as "dma-coherent" in
> devicetree, which will already inform the DMA layer not to perform
> unnecessary cache maintenance. However, we still need to ensure that
> the GPU uses the appropriate cacheable outer-shareable attributes in
> order to generate the requisite snoop signals, and that CPU mappings
> don't create a mismatch by using a non-cacheable type either.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

LGTM

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
>   drivers/gpu/drm/panfrost/panfrost_drv.c    | 2 ++
>   drivers/gpu/drm/panfrost/panfrost_gem.c    | 2 ++
>   drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 +
>   4 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index c30c719a8059..b31f45315e96 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -84,6 +84,7 @@ struct panfrost_device {
>   	/* pm_domains for devices with more than one. */
>   	struct device *pm_domain_devs[MAX_PM_DOMAINS];
>   	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
> +	bool coherent;
>   
>   	struct panfrost_features features;
>   	const struct panfrost_compatible *comp;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index ada51df9a7a3..2a6f2f716b2f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -588,6 +588,8 @@ static int panfrost_probe(struct platform_device *pdev)
>   	if (!pfdev->comp)
>   		return -ENODEV;
>   
> +	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
> +
>   	/* Allocate and initialze the DRM device. */
>   	ddev = drm_dev_alloc(&panfrost_drm_driver, &pdev->dev);
>   	if (IS_ERR(ddev))
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 33355dd302f1..cdf1a8754eba 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -220,6 +220,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
>    */
>   struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t size)
>   {
> +	struct panfrost_device *pfdev = dev->dev_private;
>   	struct panfrost_gem_object *obj;
>   
>   	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> @@ -229,6 +230,7 @@ struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t
>   	INIT_LIST_HEAD(&obj->mappings.list);
>   	mutex_init(&obj->mappings.lock);
>   	obj->base.base.funcs = &panfrost_gem_funcs;
> +	obj->base.map_cached = pfdev->coherent;
>   
>   	return &obj->base.base;
>   }
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index e8f7b11352d2..8852fd378f7a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -371,6 +371,7 @@ int panfrost_mmu_pgtable_alloc(struct panfrost_file_priv *priv)
>   		.pgsize_bitmap	= SZ_4K | SZ_2M,
>   		.ias		= FIELD_GET(0xff, pfdev->features.mmu_features),
>   		.oas		= FIELD_GET(0xff00, pfdev->features.mmu_features),
> +		.coherent_walk	= pfdev->coherent,
>   		.tlb		= &mmu_tlb_ops,
>   		.iommu_dev	= pfdev->dev,
>   	};
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
