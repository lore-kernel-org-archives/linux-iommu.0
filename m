Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A0FC43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 12:55:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AD6207DE
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 12:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AD6207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 51E5E204B9;
	Thu, 10 Sep 2020 12:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qd2gluabI6xH; Thu, 10 Sep 2020 12:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3DC1620488;
	Thu, 10 Sep 2020 12:55:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20CB5C0859;
	Thu, 10 Sep 2020 12:55:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A5ECC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 12:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 838CD868DA
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 12:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EBtjIPDtOF+9 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 12:55:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 954588543A
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 12:55:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF2C01063;
 Thu, 10 Sep 2020 05:55:44 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 141203F66E;
 Thu, 10 Sep 2020 05:55:40 -0700 (PDT)
Subject: Re: [PATCH 04/12] dma-mapping: fix DMA_OPS dependencies
To: Christoph Hellwig <hch@lst.de>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 iommu@lists.linux-foundation.org
References: <20200908164758.3177341-1-hch@lst.de>
 <20200908164758.3177341-5-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1e3c7094-62da-6e8c-0a41-0bc63dd3db68@arm.com>
Date: Thu, 10 Sep 2020 13:55:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908164758.3177341-5-hch@lst.de>
Content-Language: en-GB
Cc: linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
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

On 2020-09-08 17:47, Christoph Hellwig wrote:
> Driver that select DMA_OPS need to depend on HAS_DMA support to
> work.  The vop driver was missing that dependency, so add it, and also
> add a nother depends in DMA_OPS itself.  That won't fix the issue due
> to how the Kconfig dependencies work, but at least produce a warning
> about unmet dependencies.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/misc/mic/Kconfig | 1 +
>   kernel/dma/Kconfig       | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
> index b9bb086785db48..8a7c2c5711d5f4 100644
> --- a/drivers/misc/mic/Kconfig
> +++ b/drivers/misc/mic/Kconfig
> @@ -35,6 +35,7 @@ config SCIF_BUS
>   
>   config VOP_BUS
>   	tristate "VOP Bus Driver"
> +	depends on HAS_DMA
>   	select DMA_OPS

AFAICS all three of these bus drivers are only proxying a struct 
dma_map_ops * pointer around, so if they used the set_dma_ops() helper 
they shouldn't even need these selects at all. Only INTEL_MIC_HOST 
appears to have a logical dependency on DMA_OPS for actual functionality.

However, I have a vague feeling you might not be fond of those dma_ops 
helpers, and I have no great objection to this one-liner as-is, so 
(modulo the couple of commit message typos),

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

(of course the hunk below is unquestionably OK)

Robin.

>   	help
>   	  This option is selected by any driver which registers a
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 0ddfb5510fe45f..e7b801649f6574 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -9,6 +9,7 @@ config HAS_DMA
>   	default y
>   
>   config DMA_OPS
> +	depends on HAS_DMA
>   	bool
>   
>   #
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
