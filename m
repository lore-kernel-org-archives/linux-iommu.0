Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A795AC433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 19:59:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A76C207D0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 19:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A76C207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3824A26632;
	Mon,  6 Jul 2020 19:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g+8RDSEVpCht; Mon,  6 Jul 2020 19:59:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EA57D25A3A;
	Mon,  6 Jul 2020 19:59:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D378FC0893;
	Mon,  6 Jul 2020 19:59:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C234C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 19:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 68B2286ADB
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 19:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVbFDlV2ouzg for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 19:59:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from smtp4.emailarray.com (smtp4.emailarray.com [65.39.216.22])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4B82386B6B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 19:59:29 +0000 (UTC)
Received: (qmail 2396 invoked by uid 89); 6 Jul 2020 19:59:27 -0000
Received: from unknown (HELO localhost)
 (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuMw==) (POLARISLOCAL) 
 by smtp4.emailarray.com with SMTP; 6 Jul 2020 19:59:27 -0000
Date: Mon, 6 Jul 2020 12:59:25 -0700
From: Jonathan Lemon <jonathan.lemon@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: the XSK buffer pool needs be to reverted
Message-ID: <20200706195925.w7mcfnc5qyryx3sa@bsd-mbp.dhcp.thefacebook.com>
References: <20200626074725.GA21790@lst.de>
 <20200626205412.xfe4lywdbmh3kmri@bsd-mbp>
 <20200627070236.GA11854@lst.de>
 <e43ab7b9-22f5-75c3-c9e6-f1eb18d57148@arm.com>
 <20200630190832.vvirrpkmyev2inlh@bsd-mbp.dhcp.thefacebook.com>
 <d47d08a1-fb9f-d02a-a4a2-fe5fbe0d3b52@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d47d08a1-fb9f-d02a-a4a2-fe5fbe0d3b52@arm.com>
Cc: netdev@vger.kernel.org, iommu@lists.linux-foundation.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
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

On Wed, Jul 01, 2020 at 10:46:40AM +0100, Robin Murphy wrote:
> On 2020-06-30 20:08, Jonathan Lemon wrote:
> > On Mon, Jun 29, 2020 at 02:15:16PM +0100, Robin Murphy wrote:
> > > On 2020-06-27 08:02, Christoph Hellwig wrote:
> > > > On Fri, Jun 26, 2020 at 01:54:12PM -0700, Jonathan Lemon wrote:
> > > > > On Fri, Jun 26, 2020 at 09:47:25AM +0200, Christoph Hellwig wrote:
> > > > > > 
> > > > > > Note that this is somewhat urgent, as various of the APIs that the code
> > > > > > is abusing are slated to go away for Linux 5.9, so this addition comes
> > > > > > at a really bad time.
> > > > > 
> > > > > Could you elaborate on what is upcoming here?
> > > > 
> > > > Moving all these calls out of line, and adding a bypass flag to avoid
> > > > the indirect function call for IOMMUs in direct mapped mode.
> > > > 
> > > > > Also, on a semi-related note, are there limitations on how many pages
> > > > > can be left mapped by the iommu?  Some of the page pool work involves
> > > > > leaving the pages mapped instead of constantly mapping/unmapping them.
> > > > 
> > > > There are, but I think for all modern IOMMUs they are so big that they
> > > > don't matter.  Maintaines of the individual IOMMU drivers might know
> > > > more.
> > > 
> > > Right - I don't know too much about older and more esoteric stuff like POWER
> > > TCE, but for modern pagetable-based stuff like Intel VT-d, AMD-Vi, and Arm
> > > SMMU, the only "limits" are such that legitimate DMA API use should never
> > > get anywhere near them (you'd run out of RAM for actual buffers long
> > > beforehand). The most vaguely-realistic concern might be a pathological
> > > system topology where some old 32-bit PCI device doesn't have ACS isolation
> > > from your high-performance NIC such that they have to share an address
> > > space, where the NIC might happen to steal all the low addresses and prevent
> > > the soundcard or whatever from being able to map a usable buffer.
> > > 
> > > With an IOMMU, you typically really *want* to keep a full working set's
> > > worth of pages mapped, since dma_map/unmap are expensive while dma_sync is
> > > somewhere between relatively cheap and free. With no IOMMU it makes no real
> > > difference from the DMA API perspective since map/unmap are effectively no
> > > more than the equivalent sync operations anyway (I'm assuming we're not
> > > talking about the kind of constrained hardware that might need SWIOTLB).
> > > 
> > > > > On a heavily loaded box with iommu enabled, it seems that quite often
> > > > > there is contention on the iova_lock.  Are there known issues in this
> > > > > area?
> > > > 
> > > > I'll have to defer to the IOMMU maintainers, and for that you'll need
> > > > to say what code you are using.  Current mainlaine doesn't even have
> > > > an iova_lock anywhere.
> > > 
> > > Again I can't speak for non-mainstream stuff outside drivers/iommu, but it's
> > > been over 4 years now since merging the initial scalability work for the
> > > generic IOVA allocator there that focused on minimising lock contention, and
> > > it's had considerable evaluation and tweaking since. But if we can achieve
> > > the goal of efficiently recycling mapped buffers then we shouldn't need to
> > > go anywhere near IOVA allocation either way except when expanding the pool.
> > 
> > 
> > I'm running a set of patches which uses the page pool to try and keep
> > all the RX buffers mapped as the skb goes up the stack, returning the
> > pages to the pool when the skb is freed.
> > 
> > On a dual-socket 12-core Intel machine (48 processors), and 256G of
> > memory, when iommu is enabled, I see the following from 'perf top -U',
> > as the hottest function being run:
> > 
> > -   43.42%  worker      [k] queued_spin_lock_slowpath
> >     - 43.42% queued_spin_lock_slowpath
> >        - 41.69% _raw_spin_lock_irqsave
> >           + 41.39% alloc_iova
> >           + 0.28% iova_magazine_free_pfns
> >        + 1.07% lock_sock_nested
> > 
> > Which likely is heavy contention on the iovad->iova_rbtree_lock.
> > (This is on a 5.6 based system, BTW).  More scripts and data are below.
> > Is there a way to reduce the contention here?
> 
> Hmm, how big are your DMA mappings? If you're still hitting the rbtree a
> lot, that most likely implies that either you're making giant IOVA
> allocations that are too big to be cached, or you're allocating/freeing
> IOVAs in a pathological pattern that defeats the whole magazine cache
> mechanism (It's optimised for relatively-balanced allocation and freeing of
> sizes up order 6). On a further hunch, does the "intel_iommu=forcedac"
> option make any difference at all?

The allocations are only 4K in size (packet memory) but there are a lot
of them.  I tried running with "forcedac" over the weekend, and that
seems to have made a huge difference.  Why the name of 'forcedac'?  It
would seem this should be the default for a system with a sane 64-bit PCI
device.

 
> Either way if this persists after some initial warm-up period, it further
> implies that the page pool is not doing its job properly (or at least in the
> way I would have expected). The alloc_iova() call is part of the dma_map_*()
> overhead, and if the aim is to keep pages mapped then that should only be
> called relatively infrequently. The optimal behaviour would be to dma_map()
> new clean pages as they are added to the pool, use dma_sync() when they are
> claimed and returned by the driver, and only dma_unmap() if they're actually
> freed back to the page allocator. And if you're still seeing a lot of
> dma_map/unmap time after that, then the pool itself is churning pages and
> clearly needs its size/thresholds tuning.

Most of the dma_map() overhead is coming from the TX path, which isn't
using the page_pool.

With the RX datapath I'm using, pages are returned to the pool in a
non-napi context (so they enter the ring), then the driver refills the
cache from the ring.  I'm seeing a 1% overflow (ring_full), so the
default size seems appropriate.  The single ring lock is likely a
problem, but can be addressed now that things aren't blowing up in
alloc_iova().

From a box with the mlx4 driver + persistent page pool:

     rx_alloc_pages: 35239524767
     cache_hit: 34381377143
     cache_full: 19935
     cache_empty: 859266494
     ring_consume: 31665993135
     ring_produce: 31666119491
     ring_full: 353805844

-- 
Jonathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
