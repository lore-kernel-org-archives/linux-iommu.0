Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1216DC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 18:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A626760D4C;
	Wed,  1 Jun 2022 18:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WGm0W-yYa9W2; Wed,  1 Jun 2022 18:12:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B32660D77;
	Wed,  1 Jun 2022 18:12:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72EEFC0039;
	Wed,  1 Jun 2022 18:12:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A65F3C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 18:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C51360D4C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 18:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2NaSpG88r85D for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 18:12:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86F6760BF7
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 18:12:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9BED2CE1D21;
 Wed,  1 Jun 2022 18:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA63C385A5;
 Wed,  1 Jun 2022 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654107120;
 bh=XyRtnaG4f6v1X+0b1Icwpx1CnomvwrWKo4GYEBNHb+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kBs/HAWx4uM3HDoEzXU7+T8V9lyNwNqn4zd6Uh/AJGNo4QD8EzwUXHg8SF5aQu/eR
 anmAddXVYpYTPQXJYiVXSgAM6oeXwkinLakcGmSyuAZtpT4Gg5dXcDILW5BYrqp6yC
 vfOgfDXfoYgyw9l9+lVWSvldxx5jHryrGn/d5UzcJCJjQVQvAnn5PGnRbongr5jgLY
 JziHqqThI4bmA2WwIpuZHilJdJjc4uSPMPWYG0WUdO4ZhUny70sDURv0RtrDDn5Tm8
 XZjMRYHCt4Yp4VSnSP3UbNmDy1oSOc8nqKRVMKzHpT2VEuCPCTYpdk41t0XRp7VTN5
 o4MHC+cQamxCw==
Date: Wed, 1 Jun 2022 11:11:57 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/15] swiotlb: make the swiotlb_init interface more useful
Message-ID: <Yper7agk7XfCCQNa@dev-arch.thelio-3990X>
References: <20220404050559.132378-1-hch@lst.de>
 <20220404050559.132378-10-hch@lst.de>
 <YpehC7BwBlnuxplF@dev-arch.thelio-3990X>
 <20220601173441.GB27582@lst.de> <YpemDuzdoaO3rijX@Ryzen-9-3900X.>
 <20220601175743.GA28082@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220601175743.GA28082@lst.de>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 tboot-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Jun 01, 2022 at 07:57:43PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 01, 2022 at 10:46:54AM -0700, Nathan Chancellor wrote:
> > On Wed, Jun 01, 2022 at 07:34:41PM +0200, Christoph Hellwig wrote:
> > > Can you send me the full dmesg and the content of
> > > /sys/kernel/debug/swiotlb/io_tlb_nslabs for a good and a bad boot?
> > 
> > Sure thing, they are attached! If there is anything else I can provide
> > or test, I am more than happy to do so.
> 
> Nothing interesting.  But the performance numbers almost look like
> swiotlb=force got ignored before (even if I can't explain why).

I was able to get my performance back with this diff but I don't know if
this is a hack or a proper fix in the context of the series.

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dfa1de89dc94..0bfb2fe3d8c5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -276,7 +276,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		      __func__, alloc_size, PAGE_SIZE);
 
 	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
-	mem->force_bounce = flags & SWIOTLB_FORCE;
+	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
 
 	if (flags & SWIOTLB_VERBOSE)
 		swiotlb_print_info();

> Do you get a similar performance with the new kernel without
> swiotlb=force as the old one with that argument by any chance?

I'll see if I can test that, as I am not sure I have control over those
cmdline arguments.

Cheers,
Nathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
