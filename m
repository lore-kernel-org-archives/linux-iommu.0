Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B52AC433E1
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 06:06:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BD420708
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 06:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BD420708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14F19887A7;
	Fri, 14 Aug 2020 06:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uu2TOrJo4UIm; Fri, 14 Aug 2020 06:06:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5ABC68864B;
	Fri, 14 Aug 2020 06:06:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C8BFC013C;
	Fri, 14 Aug 2020 06:06:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8A41C004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 06:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9E73B8879F
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 06:06:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DawxGc4lrTsY for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 06:06:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E38A78864B
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 06:06:46 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id CB6A068CEE; Fri, 14 Aug 2020 08:06:42 +0200 (CEST)
Date: Fri, 14 Aug 2020 08:06:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v3 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200814060642.GA1338@lst.de>
References: <20200806184756.32075-1-nsaenzjulienne@suse.de>
 <20200806184756.32075-3-nsaenzjulienne@suse.de> <20200807052116.GA584@lst.de>
 <aae9250e660339142e9390427a603c4cf4e282af.camel@suse.de>
 <20200808063354.GA17329@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200808063354.GA17329@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: amit.pundir@linaro.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 rientjes@google.com, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Sat, Aug 08, 2020 at 08:33:54AM +0200, Christoph Hellwig wrote:
> On Fri, Aug 07, 2020 at 10:50:19AM +0200, Nicolas Saenz Julienne wrote:
> > On Fri, 2020-08-07 at 07:21 +0200, Christoph Hellwig wrote:
> > > On Thu, Aug 06, 2020 at 08:47:55PM +0200, Nicolas Saenz Julienne wrote:
> > > > There is no guarantee to CMA's placement, so allocating a zone specific
> > > > atomic pool from CMA might return memory from a completely different
> > > > memory zone. To get around this double check CMA's placement before
> > > > allocating from it.
> > > 
> > > As the builtbot pointed out, memblock_start_of_DRAM can't be used from
> > > non-__init code.  But lookig at it I think throwing that in
> > > is bogus anyway, as cma_get_base returns a proper physical address
> > > already.
> > 
> > It does indeed, but I'm comparing CMA's base with bitmasks that don't take into
> > account where the memory starts. Say memory starts at 0x80000000, and CMA falls
> > into ZONE_DMA [0x80000000 0xC0000000], if you want to compare it with
> > DMA_BIT_MASK(zone_dma_bits) you're forced to unify the memory bases.
> > 
> > That said, I now realize that this doesn't work for ZONE_DMA32 which has a hard
> > limit on 32bit addresses reglardless of the memory base.
> > 
> > That said I still need to call memblock_start_of_DRAM() any suggestions WRT
> > that? I could save the value in dma_atomic_pool_init(), which is __init code.
> 
> The pool must be about a 32-bit physical address.  The offsets can be
> different for every device..

Do you plan to resend this one without the memblock_start_of_DRAM
thingy?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
