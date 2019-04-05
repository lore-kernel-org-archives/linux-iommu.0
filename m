Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F523C282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 17:43:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8A9206BA
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 17:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8A9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BDBB92575;
	Fri,  5 Apr 2019 17:43:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AFC862533
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 17:43:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5F80682C
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 17:43:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262FA168F;
	Fri,  5 Apr 2019 10:43:00 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C30FA3F557;
	Fri,  5 Apr 2019 10:42:58 -0700 (PDT)
Subject: Re: [PATCH 04/21] dma-iommu: cleanup dma-iommu.h
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-5-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7d7efc03-75b2-58c7-f744-d7bc3de6a771@arm.com>
Date: Fri, 5 Apr 2019 18:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-5-hch@lst.de>
Content-Language: en-GB
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190405174257.ZESxCKWFS6_-K9qT55HLNvuyz0soNcBXBiX5i-dfugY@z>

On 27/03/2019 08:04, Christoph Hellwig wrote:
> No need for a __KERNEL__ guard outside uapi and add a missing comment
> describing the #else cpp statement.  Last but not least include
> <linux/errno.h> instead of the asm version, which is frowned upon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-iommu.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index e760dc5d1fa8..3e206f4ee173 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -16,14 +16,14 @@
>   #ifndef __DMA_IOMMU_H
>   #define __DMA_IOMMU_H
>   
> -#ifdef __KERNEL__
> +#include <linux/errno.h>
>   #include <linux/types.h>
> -#include <asm/errno.h>
>   
>   #ifdef CONFIG_IOMMU_DMA
>   #include <linux/dma-mapping.h>
>   #include <linux/iommu.h>
>   #include <linux/msi.h>
> +#include <linux/types.h>

Other than introducing this unnecessary dupe,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   int iommu_dma_init(void);
>   
> @@ -74,7 +74,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> -#else
> +#else /* CONFIG_IOMMU_DMA */
>   
>   struct iommu_domain;
>   struct msi_msg;
> @@ -108,5 +108,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   }
>   
>   #endif	/* CONFIG_IOMMU_DMA */
> -#endif	/* __KERNEL__ */
>   #endif	/* __DMA_IOMMU_H */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
