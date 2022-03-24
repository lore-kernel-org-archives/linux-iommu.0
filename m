Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B2C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 17:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2019410E7;
	Thu, 24 Mar 2022 17:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TtfuW3QyzRSr; Thu, 24 Mar 2022 17:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 70EE641C6F;
	Thu, 24 Mar 2022 17:07:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 309FCC001A;
	Thu, 24 Mar 2022 17:07:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E81F4C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 17:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5DC24016D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 17:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=toke.dk
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7et9QnsoRxZW for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 17:07:34 +0000 (UTC)
X-Greylist: delayed 02:39:39 by SQLgrey-1.8.0
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 297AF4011A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
 t=1648141651; bh=fBBTep0fsFEy1SpGBxltwkhke+QjxK1XAYERNO2rihY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bhFRZWBsXOArjlqHIuob1rAQIRclaUsGXtG0oYMnqwucW0eBkVtBa836EE26AgPkP
 rDYnYVabCLw7xPJJZklieM6hKIXr4OOKDCxYIma89OF2kmdzdPfixk6LsMRH7/XpIt
 XoLz6iqw/Nel9vizNBhxFPAcqltsDSYj+nLrKAqu4dwFqA81LfGt1aBWoedpWXOH6J
 TNW9npCRFGqtmCp7jaAYTq7v1fDBmeIPIe6qntS+LTFQtOEYN7gPB7m6SWe7SuXTIy
 3+tCgwzG5AXbPni5j6XNyuq6vjIpvATiyCHA5Fg0gRLyJzJnOq1dioEQtcZ4hmYBua
 d42HhFVa3yW5w==
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
In-Reply-To: <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
Date: Thu, 24 Mar 2022 18:07:29 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871qyr9t4e.fsf@toke.dk>
MIME-Version: 1.0
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= via iommu
 <iommu@lists.linux-foundation.org>
Reply-To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Robin Murphy <robin.murphy@arm.com> writes:

> On 2022-03-24 16:31, Christoph Hellwig wrote:
>> On Thu, Mar 24, 2022 at 05:29:12PM +0100, Maxime Bizon wrote:
>>>> I'm looking into this; but in the interest of a speedy resolution of
>>>> the regression I would be in favour of merging that partial revert
>>>> and reinstating it if/when we identify (and fix) any bugs in ath9k :)
>>>
>>> This looks fishy:
>>>
>>> ath9k/recv.c
>>>
>>>                  /* We will now give hardware our shiny new allocated skb */
>>>                  new_buf_addr = dma_map_single(sc->dev, requeue_skb->data,
>>>                                                common->rx_bufsize, dma_type);
>>>                  if (unlikely(dma_mapping_error(sc->dev, new_buf_addr))) {
>>>                          dev_kfree_skb_any(requeue_skb);
>>>                          goto requeue_drop_frag;
>>>                  }
>>>
>>>                  /* Unmap the frame */
>>>                  dma_unmap_single(sc->dev, bf->bf_buf_addr,
>>>                                   common->rx_bufsize, dma_type);
>>>
>>>                  bf->bf_mpdu = requeue_skb;
>>>                  bf->bf_buf_addr = new_buf_addr;
>> 
>> Creating a new mapping for the same buffer before unmapping the
>> previous one does looks rather bogus.  But it does not fit the
>> pattern where revering the sync_single changes make the driver
>> work again.
>
> OK, you made me look :)
>
> Now that it's obvious what to look for, I can only conclude that during 
> the stanza in ath_edma_get_buffers(), the device is still writing to the 
> buffer while ownership has been transferred to the CPU, and whatever got 
> written while ath9k_hw_process_rxdesc_edma() was running then gets wiped 
> out by the subsequent sync_for_device, which currently resets the 
> SWIOTLB slot to the state that sync_for_cpu copied out. By the letter of 
> the DMA API that's not allowed, but on the other hand I'm not sure if we 
> even have a good idiom for "I can't tell if the device has finished with 
> this buffer or not unless I look at it" :/

Right, but is that sync_for_device call really needed? AFAICT, that
ath9k_hw_process_rxdesc_edma() invocation doesn't actually modify any of
the data when it returns EINPROGRESS, so could we just skip it? Like
the patch below? Or am I misunderstanding the semantics here?

-Toke


diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
index 0c0624a3b40d..19244d4c0ada 100644
--- a/drivers/net/wireless/ath/ath9k/recv.c
+++ b/drivers/net/wireless/ath/ath9k/recv.c
@@ -647,12 +647,8 @@ static bool ath_edma_get_buffers(struct ath_softc *sc,
                                common->rx_bufsize, DMA_FROM_DEVICE);
 
        ret = ath9k_hw_process_rxdesc_edma(ah, rs, skb->data);
-       if (ret == -EINPROGRESS) {
-               /*let device gain the buffer again*/
-               dma_sync_single_for_device(sc->dev, bf->bf_buf_addr,
-                               common->rx_bufsize, DMA_FROM_DEVICE);
+       if (ret == -EINPROGRESS)
                return false;
-       }
 
        __skb_unlink(skb, &rx_edma->rx_fifo);
        if (ret == -EINVAL) {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
