Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EE2C41604
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 08:27:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2892078E
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 08:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2892078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A12A8854A7;
	Tue,  6 Oct 2020 08:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UPRh80abMXon; Tue,  6 Oct 2020 08:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8268C8531B;
	Tue,  6 Oct 2020 08:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 674D2C016F;
	Tue,  6 Oct 2020 08:27:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66A66C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 08:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5ADCE86BC1
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 08:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0tFJKAM6GPT for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 08:27:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6C2F7854D0
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 08:27:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B855868AFE; Tue,  6 Oct 2020 10:26:56 +0200 (CEST)
Date: Tue, 6 Oct 2020 10:26:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: xen-swiotlb vs phys_to_dma
Message-ID: <20201006082656.GB10243@lst.de>
References: <20201002123436.GA30329@lst.de>
 <alpine.DEB.2.21.2010021313010.10908@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010021313010.10908@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Fri, Oct 02, 2020 at 01:21:25PM -0700, Stefano Stabellini wrote:
> On Fri, 2 Oct 2020, Christoph Hellwig wrote:
> > Hi Stefano,
> > 
> > I've looked over xen-swiotlb in linux-next, that is with your recent
> > changes to take dma offsets into account.  One thing that puzzles me
> > is that xen_swiotlb_map_page passes virt_to_phys(xen_io_tlb_start) as
> > the tbl_dma_addr argument to swiotlb_tbl_map_single, despite the fact
> > that the argument is a dma_addr_t and both other callers translate
> > from a physical to the dma address.  Was this an oversight?
> 
> Hi Christoph,
> 
> It was not an oversight, it was done on purpose, although maybe I could
> have been wrong. There was a brief discussion on this topic here: 
> 
> https://marc.info/?l=linux-kernel&m=159011972107683&w=2
> https://marc.info/?l=linux-kernel&m=159018047129198&w=2
> 
> I'll repeat and summarize here for convenience. 
> 
> swiotlb_init_with_tbl is called by xen_swiotlb_init, passing a virtual
> address (xen_io_tlb_start), which gets converted to phys and stored in
> io_tlb_start as a physical address at the beginning of swiotlb_init_with_tbl.

Yes.

> Afterwards, xen_swiotlb_map_page calls swiotlb_tbl_map_single. The
> second parameter, dma_addr_t tbl_dma_addr, is used to calculate the
> right slot in the swiotlb buffer to use, comparing it against
> io_tlb_start.

It is not compared against io_tlb_start.  It is just used to pick
a slot that fits the dma_get_seg_boundary limitation in a somewhat
awkward way.

> Thus, I think it makes sense for xen_swiotlb_map_page to call
> swiotlb_tbl_map_single passing an address meant to be compared with
> io_tlb_start, which is __pa(xen_io_tlb_start), so
> virt_to_phys(xen_io_tlb_start) seems to be what we want.

No, it doesn't.  tlb_addr is used to ensure the picked slots satisfies
the segment boundary, and for that you need a dma_addr_t.

The index variable in swiotlb_tbl_map_single is derived from
io_tlb_index, not io_tlb_start.

> However, you are right that it is strange that tbl_dma_addr is a
> dma_addr_t, and maybe it shouldn't be? Maybe the tbl_dma_addr parameter
> to swiotlb_tbl_map_single should be a phys address instead?
> Or it could be swiotlb_init_with_tbl to be wrong and it should take a
> dma address to initialize the swiotlb buffer.

No, it must be a dma_addr_t so that the dma_get_seg_boundary check works.

I think we need something like this (against linux-next):

---
From 07b39a62b235ed2d4b2215700d99968998fbf6c0 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 6 Oct 2020 10:22:19 +0200
Subject: swiotlb: remove the tlb_addr argument to swiotlb_tbl_map_single

The tlb_addr always must be the dma view of io_tlb_start so that the
segment boundary checks work.  Remove the argument and do the right
thing inside swiotlb_tbl_map_single.  This fixes the swiotlb-xen case
that failed to take DMA offset into account.  The issue probably did
not show up very much in practice as the typical dma offsets are
large enough to not affect the segment boundaries for most devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel/iommu.c |  5 ++---
 drivers/xen/swiotlb-xen.c   |  3 +--
 include/linux/swiotlb.h     | 10 +++-------
 kernel/dma/swiotlb.c        | 16 ++++++----------
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5ee0b7921b0b37..d473811fcfacd5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3815,9 +3815,8 @@ bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
 	 * page aligned, we don't need to use a bounce page.
 	 */
 	if (!IS_ALIGNED(paddr | size, VTD_PAGE_SIZE)) {
-		tlb_addr = swiotlb_tbl_map_single(dev,
-				phys_to_dma_unencrypted(dev, io_tlb_start),
-				paddr, size, aligned_size, dir, attrs);
+		tlb_addr = swiotlb_tbl_map_single(dev, paddr, size,
+						  aligned_size, dir, attrs);
 		if (tlb_addr == DMA_MAPPING_ERROR) {
 			goto swiotlb_error;
 		} else {
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 030a225624b060..953186f6d7d222 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -395,8 +395,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
 
-	map = swiotlb_tbl_map_single(dev, virt_to_phys(xen_io_tlb_start),
-				     phys, size, size, dir, attrs);
+	map = swiotlb_tbl_map_single(dev, phys, size, size, dir, attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 513913ff748626..3bb72266a75a1d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -45,13 +45,9 @@ enum dma_sync_target {
 	SYNC_FOR_DEVICE = 1,
 };
 
-extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
-					  dma_addr_t tbl_dma_addr,
-					  phys_addr_t phys,
-					  size_t mapping_size,
-					  size_t alloc_size,
-					  enum dma_data_direction dir,
-					  unsigned long attrs);
+phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
+		size_t mapping_size, size_t alloc_size,
+		enum dma_data_direction dir, unsigned long attrs);
 
 extern void swiotlb_tbl_unmap_single(struct device *hwdev,
 				     phys_addr_t tlb_addr,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 995c1b4cb427ee..8d0b7c3971e81e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -441,14 +441,11 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
-phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
-				   dma_addr_t tbl_dma_addr,
-				   phys_addr_t orig_addr,
-				   size_t mapping_size,
-				   size_t alloc_size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
+phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
+		size_t mapping_size, size_t alloc_size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
+	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(dev, io_tlb_start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
 	unsigned int nslots, stride, index, wrap;
@@ -667,9 +664,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
 			      swiotlb_force);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev,
-			phys_to_dma_unencrypted(dev, io_tlb_start),
-			paddr, size, size, dir, attrs);
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, dir,
+					      attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
