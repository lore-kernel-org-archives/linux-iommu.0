Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.101.131.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574067;
	b=PxktRieJRd5EBb8zyxd4R5mBwGiW/9b9hKAfEWLlHHoUv9VCBdcJ1ma8LFBfxTMUk4kl
	 zafO/0KduiT7M4MRSgsin2CM4VcM4tUxNSMEZ/+arEc1ZitapWS43Oqsf8uDPxz31JF0/
	 nlLlKg0rqSRUcdXSXVE4nSXrPvWiIMwImc6mUcaSfXupa9bdJAn0VGOiGmlYMKpISQrO1
	 +0Ly+/R5Vd4gzAtvTL391OMB9CAtUahv4KSqTLZr89/cTZzuzWYKocL1R9SdwimICoMd/
	 uTtsVDX9L9BiYhY+eWL2qUaCMhrZf3bDvWl4DaufRmvFW8WhqwAAIP7qNLI+IEV+9ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574067;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aq2QzJLVV9eUJO5O17ZZjwaZ305bR1/x2gKMJRPrhRQ=;
	b=4A1KHBsRFtilBhd11Z5vOBFNzHQftzSXi0ZPOYpfxVl2iYiVsfMiRbYhVWcTIjKklr4q
	 D6c9QIf+5WauMz855SSbP9zVPWFpGD1kNRYfVxakMbCJ8X9OQsBsZHDRznf5VtdbMgv2/
	 fnkGmd7G1/EGSKhLkJ5x24xfXECS5d/+Cz/E6FhcIcDpCzw3v7ZaK5NCnSgO7+MCTSJdk
	 1NcSUbMoaVieea7asM6yqRzSxUNksBEcRo3//2mLYj0A33lFM363sMHESj7fyIFjujgyv
	 kvldrXbushwmuVvi4+fSB5VCCT9CXJ1gianOHWRXCW4sZd22IQnbkpl2koSUBgN4YNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	arc=none smtp.remote-ip=160.101.131.9
Received: from na1pdmzitismtp02.tibco.com (na1pdmzitismtp02.tibco.com [160.101.131.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02185606A323
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 12:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02185606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: from cdev-nkg (unknown [10.113.40.46])
	by na1pdmzitismtp02.tibco.com (Postfix) with ESMTP id BED5D8510DB9;
	Fri, 13 Nov 2026 07:46:18 -0500 (EST)
From: Lin Liu <lin.liu01@citrix.com>
To: jgross@suse.com,
	sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com,
	andrew.cooper3@citrix.com,
	xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lin Liu <lin.liu01@citrix.com>
Subject: [PATCH] xen/swiotlb: Check the segment boundary in range_straddles_page_boundary()
Date: Fri, 13 Nov 2026 12:47:33 +0000
Message-ID: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block layer applies a device's DMA segment boundary to
pseudo-physical addresses, but in a Xen PV domain the bus address is the
machine address.  A range that is contiguous in both spaces can still
cross the boundary in machine space and reach the device.  AHCI declares
a 4 GiB boundary, and controllers that do not carry across it (e.g.
Marvell 88SE9230) then DMA the tail of the transfer 4 GiB too low.

Make range_straddles_page_boundary() also reject a contiguous range that
crosses the device's segment boundary in bus space, so all its callers
cover it.  Streaming mappings are bounced; coherent allocations are
already naturally aligned via range_requires_alignment().

Signed-off-by: Lin Liu <lin.liu01@citrix.com>
---
 drivers/xen/swiotlb-xen.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index e2538824e..181f8cef2 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -82,10 +82,13 @@ static inline bool range_requires_alignment(phys_addr_t p, size_t size)
 	return IS_ALIGNED(p, algn) && !IS_ALIGNED(bus_addr, algn);
 }
 
-static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
+static inline int range_straddles_page_boundary(struct device *dev,
+						phys_addr_t p, size_t size)
 {
 	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
 	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
+	unsigned long mask;
+	dma_addr_t dma;
 
 	next_bfn = pfn_to_bfn(xen_pfn);
 
@@ -93,7 +96,10 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
 			return 1;
 
-	return 0;
+	/* Contiguous, but may cross the segment boundary in bus space */
+	mask = dma_get_seg_boundary(dev);
+	dma = xen_phys_to_dma(dev, p);
+	return size - 1 <= mask && ((dma ^ (dma + size - 1)) & ~mask);
 }
 
 static struct io_tlb_pool *xen_swiotlb_find_pool(struct device *dev,
@@ -158,7 +164,7 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_handle = xen_phys_to_dma(dev, phys);
 	if (*dma_handle + size - 1 > dma_mask ||
-	    range_straddles_page_boundary(phys, size) ||
+	    range_straddles_page_boundary(dev, phys, size) ||
 	    range_requires_alignment(phys, size)) {
 		if (xen_create_contiguous_region(phys, order, fls64(dma_mask),
 				dma_handle) != 0)
@@ -185,7 +191,7 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
 	size = ALIGN(size, XEN_PAGE_SIZE);
 
 	if (WARN_ON_ONCE(dma_handle + size - 1 > dev->coherent_dma_mask) ||
-	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size) ||
+	    WARN_ON_ONCE(range_straddles_page_boundary(dev, phys, size) ||
 			 range_requires_alignment(phys, size)))
 	    	return;
 
@@ -233,7 +239,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
 	 */
 	if (dma_capable(dev, dev_addr, size, true, attrs) &&
 	    !dma_kmalloc_needs_bounce(dev, size, dir) &&
-	    !range_straddles_page_boundary(phys, size) &&
+	    !range_straddles_page_boundary(dev, phys, size) &&
 		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
 		!is_swiotlb_force_bounce(dev))
 		goto done;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.52.0

