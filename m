Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B41C433E2
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 12:06:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80AC2087C
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 12:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80AC2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 65BA586B50;
	Wed,  9 Sep 2020 12:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RcclfRgo6ur2; Wed,  9 Sep 2020 12:05:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D34E87211;
	Wed,  9 Sep 2020 12:05:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D909C0859;
	Wed,  9 Sep 2020 12:05:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C199C0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 12:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0778A874A0
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 12:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zgutu10QPA42 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 12:05:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 172E787487
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 12:05:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86F7C31B;
 Wed,  9 Sep 2020 05:05:54 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4743F68F;
 Wed,  9 Sep 2020 05:05:52 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Fix IOVA reserve dma ranges
To: Srinath Mannam <srinath.mannam@broadcom.com>,
 Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 poza@codeaurora.org
References: <20200909053234.17027-1-srinath.mannam@broadcom.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1996b772-774c-3475-05cc-77ae87176c3f@arm.com>
Date: Wed, 9 Sep 2020 13:05:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909053234.17027-1-srinath.mannam@broadcom.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org
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

On 2020-09-09 06:32, Srinath Mannam wrote:
> Fix IOVA reserve failure for memory regions listed in dma-ranges in the
> following cases.
> 
> - start address of memory region is 0x0.

That's fair enough, and in fact generalises to the case of zero-sized 
gaps between regions, which is indeed an oversight.

> - end address of a memory region is equal to start address of next memory
>    region.

This part doesn't make much sense, however - if the regions described in 
bridge->dma_ranges overlap, that's a bug in whoever created a malformed 
list to begin with. Possibly it's just poor wording, and you're using 
"memory regions" to refer to any or all of the dma_ranges, the reserved 
IOVA ranges, and what "start" and "end" in this function represent which 
isn't quite either of those.

> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>   drivers/iommu/dma-iommu.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 5141d49a046b..0a3f67a4f9ae 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -213,14 +213,21 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>   	resource_list_for_each_entry(window, &bridge->dma_ranges) {
>   		end = window->res->start - window->offset;
>   resv_iova:
> +		if (end < start) {
> +			/* dma_ranges list should be sorted */
> +			dev_err(&dev->dev, "Failed to reserve IOVA\n");
> +			return -EINVAL;
> +		}
> +		/*
> +		 * Skip the cases when start address of first memory region is
> +		 * 0x0 and end address of one memory region and start address
> +		 * of next memory region are equal. Reserve IOVA for rest of
> +		 * addresses fall in between given memory ranges.
> +		 */
>   		if (end > start) {
>   			lo = iova_pfn(iovad, start);
>   			hi = iova_pfn(iovad, end);
>   			reserve_iova(iovad, lo, hi);
> -		} else {

Surely this only needs to be a one-liner?

-		} else {
+		} else if (end < start) {

(or possibly "end != start"; I can't quite decide which expresses the 
semantic intent better)

The rest just looks like unnecessary churn - I don't think it needs 
commenting that a sorted list may simply not have gaps between entries, 
and as above I think the wording of that comment is actively misleading.

Robin.

> -			/* dma_ranges list should be sorted */
> -			dev_err(&dev->dev, "Failed to reserve IOVA\n");
> -			return -EINVAL;
>   		}
>   
>   		start = window->res->end - window->offset + 1;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
