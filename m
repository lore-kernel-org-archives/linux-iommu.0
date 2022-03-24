Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F9DC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 16:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 439EA8443D;
	Thu, 24 Mar 2022 16:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GnT3ustyKCM8; Thu, 24 Mar 2022 16:31:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E3768443C;
	Thu, 24 Mar 2022 16:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2969C0012;
	Thu, 24 Mar 2022 16:31:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DB0FC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 16:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 462D860BB1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 16:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9vmE2C8H9I7 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 16:31:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06B2460ADC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 16:31:37 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 364BB68B05; Thu, 24 Mar 2022 17:31:32 +0100 (CET)
Date: Thu, 24 Mar 2022 17:31:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Message-ID: <20220324163132.GB26098@lst.de>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Netdev <netdev@vger.kernel.org>,
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

On Thu, Mar 24, 2022 at 05:29:12PM +0100, Maxime Bizon wrote:
> > I'm looking into this; but in the interest of a speedy resolution of
> > the regression I would be in favour of merging that partial revert
> > and reinstating it if/when we identify (and fix) any bugs in ath9k :)
> 
> This looks fishy:
> 
> ath9k/recv.c
> 
>                 /* We will now give hardware our shiny new allocated skb */
>                 new_buf_addr = dma_map_single(sc->dev, requeue_skb->data,
>                                               common->rx_bufsize, dma_type);
>                 if (unlikely(dma_mapping_error(sc->dev, new_buf_addr))) {
>                         dev_kfree_skb_any(requeue_skb);
>                         goto requeue_drop_frag;
>                 }
> 
>                 /* Unmap the frame */
>                 dma_unmap_single(sc->dev, bf->bf_buf_addr,
>                                  common->rx_bufsize, dma_type);
> 
>                 bf->bf_mpdu = requeue_skb;
>                 bf->bf_buf_addr = new_buf_addr;

Creating a new mapping for the same buffer before unmapping the
previous one does looks rather bogus.  But it does not fit the
pattern where revering the sync_single changes make the driver
work again.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
