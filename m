Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2974DC433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 05:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4D1940598;
	Thu, 24 Mar 2022 05:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iPsN4MPcUnVb; Thu, 24 Mar 2022 05:57:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2EC7D4058E;
	Thu, 24 Mar 2022 05:57:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2DB1C0012;
	Thu, 24 Mar 2022 05:57:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D06F8C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 05:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A982860EF5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 05:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WACfb4IM3TFb for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 05:57:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B75D660EF4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 05:57:39 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 320C868B05; Thu, 24 Mar 2022 06:57:33 +0100 (CET)
Date: Thu, 24 Mar 2022 06:57:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Message-ID: <20220324055732.GB12078@lst.de>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Mar 23, 2022 at 08:54:08PM +0000, Robin Murphy wrote:
> I'll admit I still never quite grasped the reason for also adding the 
> override to swiotlb_sync_single_for_device() in aa6f8dcbab47, but I think 
> by that point we were increasingly tired and confused and starting to 
> second-guess ourselves (well, I was, at least). I don't think it's wrong 
> per se, but as I said I do think it can bite anyone who's been doing 
> dma_sync_*() wrong but getting away with it until now. If ddbd89deb7d3 
> alone turns out to work OK then I'd be inclined to try a partial revert of 
> just that one hunk.

Agreed.  Let's try that first.

Oleksandr, can you try the patch below:


diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6db1c475ec827..6c350555e5a1c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -701,13 +701,10 @@ void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
 		size_t size, enum dma_data_direction dir)
 {
-	/*
-	 * Unconditional bounce is necessary to avoid corruption on
-	 * sync_*_for_cpu or dma_ummap_* when the device didn't overwrite
-	 * the whole lengt of the bounce buffer.
-	 */
-	swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
-	BUG_ON(!valid_dma_direction(dir));
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
+	else
+		BUG_ON(dir != DMA_FROM_DEVICE);
 }
 
 void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
