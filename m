Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4CC11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 13:50:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EAD61374
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 13:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EAD61374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AF1140613;
	Wed, 30 Jun 2021 13:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EifJhT8nPbTa; Wed, 30 Jun 2021 13:50:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A73104049C;
	Wed, 30 Jun 2021 13:50:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 628F1C0010;
	Wed, 30 Jun 2021 13:50:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB44C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26C8783B2A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDF7gbKInriy for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 13:50:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C32F834C6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:50:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66FB26D;
 Wed, 30 Jun 2021 06:50:00 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C08BC3F718;
 Wed, 30 Jun 2021 06:49:58 -0700 (PDT)
Subject: Re: [PATCH v3] swiotlb: fix implicit debugfs_create_dir declaration
To: Claire Chang <tientzu@chromium.org>, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, Will Deacon <will@kernel.org>,
 sstabellini@kernel.org
References: <20210630040616.3914990-1-tientzu@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0ed2f689-2593-5387-dccb-96a82243910f@arm.com>
Date: Wed, 30 Jun 2021 14:49:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630040616.3914990-1-tientzu@chromium.org>
Content-Language: en-GB
Cc: kernel test robot <lkp@intel.com>, iommu@lists.linux-foundation.org,
 Nicolas Boichat <drinkcat@chromium.org>, linux-kernel@vger.kernel.org
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

On 2021-06-30 05:06, Claire Chang wrote:
> Factor out the debugfs bits from rmem_swiotlb_device_init() into a separate
> rmem_swiotlb_debugfs_init().
> 
> Fixes: 461021875c50 ("swiotlb: Add restricted DMA pool initialization")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>   kernel/dma/swiotlb.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 0ffbaae9fba2..355dc98d381c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -709,6 +709,16 @@ static int __init swiotlb_create_default_debugfs(void)
>   
>   late_initcall(swiotlb_create_default_debugfs);
>   
> +static void rmem_swiotlb_debugfs_init(const char *name, struct io_tlb_mem *mem)

Nit: maybe just pass in the reserved_mem, then dereference rmem->name 
and rmem->priv inside here?

> +{
> +	mem->debugfs = debugfs_create_dir(name, debugfs_dir);
> +	swiotlb_create_debugfs_files(mem);
> +}
> +#else
> +__maybe_unused static void rmem_swiotlb_debugfs_init(const char *name,
> +						     struct io_tlb_mem *mem)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
> @@ -766,11 +776,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>   
>   		rmem->priv = mem;
>   
> -		if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> -			mem->debugfs =
> -				debugfs_create_dir(rmem->name, debugfs_dir);
> -			swiotlb_create_debugfs_files(mem);
> -		}
> +		if (IS_ENABLED(CONFIG_DEBUG_FS))
> +			rmem_swiotlb_debugfs_init(rmem->name, mem);

Just make the call unconditional (and drop the __maybe_unused annotation 
above) - the stub already does nothing for the DEBUG_FS=n case, so the 
IS_ENABLED() is pointless.

Robin.

>   	}
>   
>   	dev->dma_io_tlb_mem = mem;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
