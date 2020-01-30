Return-Path: <SRS0=QAIZ=3T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D46C33C9E
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 07:53:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921A52082E
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 07:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921A52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7827F88395;
	Thu, 30 Jan 2020 07:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjVXQK+HfdSV; Thu, 30 Jan 2020 07:53:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 45F9088338;
	Thu, 30 Jan 2020 07:53:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2853BC0881;
	Thu, 30 Jan 2020 07:53:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC647C0171
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 07:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CD9B022699
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 07:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LvoI-X1L8AEv for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jan 2020 07:53:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 3F9FE2268C
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 07:53:37 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 57B3C68B05; Thu, 30 Jan 2020 08:53:32 +0100 (CET)
Date: Thu, 30 Jan 2020 08:53:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when
 it is valid
Message-ID: <20200130075332.GA30735@lst.de>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
 <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
 <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: robh@kernel.org, vigneshr@ti.com, konrad.wilk@oracle.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 hch@lst.de, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
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

[skipping the DT bits, as I'm everything but an expert on that..]

On Mon, Jan 27, 2020 at 04:00:30PM +0200, Peter Ujfalusi wrote:
> I agree on the phys_to_dma(). It should fail for addresses which does
> not fall into any of the ranges.
> It is just a that we in Linux don't have the concept atm for ranges, we
> have only _one_ range which applies to every memory address.

what does atm here mean?

We have needed multi-range support for quite a while, as common broadcom
SOCs do need it.  So patches for that are welcome at least from the
DMA layer perspective (kinda similar to your pseudo code earlier)

> > Nobody's disputing that the current dma_direct_supported()
> > implementation is broken for the case where ZONE_DMA itself is offset
> > from PA 0; the more pressing question is why Christoph's diff, which was
> > trying to take that into account, still didn't work.
> 
> I understand that this is a bit more complex than I interpret it, but
> the k2g is broken and currently the simplest way to make it work is to
> use the arm dma_ops in case the pfn_offset is not 0.
> It will be easy to test dma-direct changes trying to address the issue
> in hand, but will allow k2g to be usable at the same time.

Well, using the legacy arm dma ops means we can't use swiotlb if there
is an offset, which is also wrong for lots of common cases, including
the Rpi 4.  I'm still curious why my patch didn't work, as I thought
it should.  We'll need to find the minimum change to make it work
for now without switching ops, even if it isn't the correct one, and
then work from there.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
