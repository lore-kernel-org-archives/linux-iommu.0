Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B78C4320E
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:09:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4EAF61040
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4EAF61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66C64400FD;
	Fri, 30 Jul 2021 06:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZ9RGYIRf46I; Fri, 30 Jul 2021 06:09:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16A54400F8;
	Fri, 30 Jul 2021 06:09:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEFF5C001A;
	Fri, 30 Jul 2021 06:09:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A019C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68E4D60685
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBeYNhrXPqcq for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:09:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39B9B600B6
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:09:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="200245455"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="200245455"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465344710"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:08:57 -0700
Subject: Re: [PATCH v2 01/24] iommu: Pull IOVA cookie management into the core
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <fcd58f6e0265b5339091cbabdea88151d437ad40.1627468309.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <19face6d-daae-fe36-5154-a1f6e409064d@linux.intel.com>
Date: Fri, 30 Jul 2021 14:06:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fcd58f6e0265b5339091cbabdea88151d437ad40.1627468309.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 dianders@chromium.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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

On 7/28/21 11:58 PM, Robin Murphy wrote:
> Now that everyone has converged on iommu-dma for IOMMU_DOMAIN_DMA
> support, we can abandon the notion of drivers being responsible for the
> cookie type, and consolidate all the management into the core code.
> 
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 7 +++++++
>   include/linux/iommu.h | 3 ++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2cda9950bd5..ea5a9ea8d431 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -7,6 +7,7 @@
>   #define pr_fmt(fmt)    "iommu: " fmt
>   
>   #include <linux/device.h>
> +#include <linux/dma-iommu.h>
>   #include <linux/kernel.h>
>   #include <linux/bits.h>
>   #include <linux/bug.h>
> @@ -1946,6 +1947,11 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   	/* Assume all sizes by default; the driver may override this later */
>   	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>   
> +	/* Temporarily ignore -EEXIST while drivers still get their own cookies */
> +	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain) == -ENOMEM) {
> +		iommu_domain_free(domain);
> +		domain = NULL;
> +	}
>   	return domain;
>   }
>   
> @@ -1957,6 +1963,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
>   void iommu_domain_free(struct iommu_domain *domain)
>   {
> +	iommu_put_dma_cookie(domain);
>   	domain->ops->domain_free(domain);
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_free);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4997c78e2670..141779d76035 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -40,6 +40,7 @@ struct iommu_domain;
>   struct notifier_block;
>   struct iommu_sva;
>   struct iommu_fault_event;
> +struct iommu_dma_cookie;
>   
>   /* iommu fault flags */
>   #define IOMMU_FAULT_READ	0x0
> @@ -86,7 +87,7 @@ struct iommu_domain {
>   	iommu_fault_handler_t handler;
>   	void *handler_token;
>   	struct iommu_domain_geometry geometry;
> -	void *iova_cookie;
> +	struct iommu_dma_cookie *iova_cookie;
>   };
>   
>   enum iommu_cap {
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
