Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE3FC10F29
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 13:56:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B45521927
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 13:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B45521927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3768D2578F;
	Mon,  9 Mar 2020 13:56:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7uGhdgDlbS7; Mon,  9 Mar 2020 13:56:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F11D820468;
	Mon,  9 Mar 2020 13:56:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2806C1D74;
	Mon,  9 Mar 2020 13:56:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92D7CC0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 13:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7CCC28841A
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 13:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PUFX-jCIWT+3 for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 13:56:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7E1CD88415
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 13:56:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8827A30E;
 Mon,  9 Mar 2020 06:56:53 -0700 (PDT)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDFD63F67D;
 Mon,  9 Mar 2020 06:56:52 -0700 (PDT)
Subject: Re: [PATCH] [dma-coherent] Fix integer overflow in the
 reserved-memory dma allocation
To: Kevin Grandemange <kevin.grandemange@allegrodvt.com>,
 Christoph Hellwig <hch@lst.de>
References: <20200309110134.7672-1-kevin.grandemange@allegrodvt.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b2b656c-33ee-4e02-e687-c71ff43de584@arm.com>
Date: Mon, 9 Mar 2020 13:56:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200309110134.7672-1-kevin.grandemange@allegrodvt.com>
Content-Language: en-GB
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On 09/03/2020 11:02 am, Kevin Grandemange wrote:
> pageno is an int and the PAGE_SHIFT shift is done on an int,
> overflowing if the memory is bigger than 2G
> 
> This can be reproduced using for example a reserved-memory of 4G

Nit: the example shows 16GB, not 4.

> reserved-memory {
> 		    #address-cells = <2>;
> 		    #size-cells = <2>;
> 		    ranges;
> 
> 		    reserved_dma: buffer@0 {
> 		        compatible = "shared-dma-pool";
> 		        no-map;
> 		        reg = <0x5 0x00000000 0x4 0x0>;
>          };
> };
> 
> Signed-off-by: Kevin Grandemange <kevin.grandemange@allegrodvt.com>
> ---
>   kernel/dma/coherent.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 551b0eb7028a..c20c6c0635b7 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -130,6 +130,7 @@ static void *__dma_alloc_from_coherent(struct device *dev,
>   	int order = get_order(size);
>   	unsigned long flags;
>   	int pageno;
> +	ssize_t mem_offset;
>   	void *ret;
>   
>   	spin_lock_irqsave(&mem->spinlock, flags);
> @@ -144,8 +145,9 @@ static void *__dma_alloc_from_coherent(struct device *dev,
>   	/*
>   	 * Memory was found in the coherent area.
>   	 */
> -	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
> -	ret = mem->virt_base + (pageno << PAGE_SHIFT);
> +	mem_offset = (ssize_t)pageno << PAGE_SHIFT;

Isn't this still capable of overflowing for 32-bit architectures where 
ssize_t is most likely to be long and LONG_MAX == INT_MAX (before we 
even get to PAE and friends)? Logically, dma_addr_t would be the most 
appropriate type here.

FWIW since you have to have an explicit cast either way, I don't see 
much point in introducing the local variable vs. just adding the cast 
into the existing expression.

Thanks,
Robin.

> +	*dma_handle = dma_get_device_base(dev, mem) + mem_offset;
> +	ret = mem->virt_base + mem_offset;
>   	spin_unlock_irqrestore(&mem->spinlock, flags);
>   	memset(ret, 0, size);
>   	return ret;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
