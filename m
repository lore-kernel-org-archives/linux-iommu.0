Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.101.131.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070318;
	b=YQwg8eWbkZs1IDFDjsIk2OC8lC2Czbrskucwv18ebhGQGK+3vUwKL7h21QHggM6HVNbx
	 Wlz7oxAKoD1CKsrZ9bmPxONtCbJmiqvEHa4ZfljuRb/XnmkSBQ9xj295eJEp9+zKxj12W
	 xhgFQoIHbMJBuchWPFkJUsd1mprue5g/jdMNSjQ29C4q+BeheaOc1swKZG+XYNT62U/ZG
	 AixZRTXrzQB3xRIj68Suij6oD6mfNUprQxhZ9AvryIxWpl6pqtXSnd2dkmBfmUOCGf8dF
	 Kdv+SUXc9f61OAY81076A3ZuwyTqbDHiqWJwR4fvgIeg2FeHQBa7j29pIolcngpmz9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070318;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+4Lm1j9czUDMGXfMKQZThbTqAaYkDXrh7VxBy05kOuI=;
	b=aMet/amQrqSfvzd02hZIjEBOG5dZwX45+9qKgMEvO2p+n6kpq6O5ih5bfzi+7sltkylv
	 Hhp4E0pX0Q6EcVLM2UKQO5wWMxIlIjoxMTre/TS++YzFGO2RuXCov0FJfNt0VVjgY7k2b
	 54MBc8OVNoPA7LKLyAxi0TbLYxN5EQ2jtsQYvoREqh+/rjvdC65QyU4VCt2Ext5PiFbZ4
	 cSjGVsSwrYp9rnLGWVNij44S+5+rjAMU6PB5HmjorDuoDwDp0zZr7Z7qTbtOOVgOUVtih
	 9nETkXF867H0dxmJTF1Rxq6/zQ50ufkJr1XYZwp/dIqwBo+2cwFw7AZFO5XuHXjlaxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	arc=none smtp.remote-ip=160.101.131.9
Received: from na1pdmzitismtp02.tibco.com (unknown [160.101.131.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C4606A325
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 06:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B7C4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: from cdev-nkg (unknown [10.113.40.46])
	by na1pdmzitismtp02.tibco.com (Postfix) with ESMTP id 35C12852CB0A;
	Thu, 19 Nov 2026 01:37:06 -0500 (EST)
From: Lin Liu <lin.liu01@citrix.com>
To: jgross@suse.com,
	sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com,
	andrew.cooper3@citrix.com,
	ross.lagerwall@citrix.com,
	xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] xen/swiotlb: Bounce mappings that cross the segment boundary
Date: Thu, 19 Nov 2026 06:38:32 +0000
Message-ID: <4a2d59f8d5a2b1399fc8bdf6e49202c9c2f394a7.1795069501.git.lin.liu01@citrix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
References: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The block layer applies a device's DMA segment boundary to
pseudo-physical addresses, but in a Xen PV domain the bus address is the
machine address.  A segment that is contiguous in both spaces can still
cross the boundary in machine space and reach the device.  AHCI declares
a 4 GiB boundary, and controllers that do not carry across it (e.g.
Marvell 88SE9230) then DMA the tail of the transfer 4 GiB too low.

Bounce such streaming mappings.  Coherent allocations need no check:
they are naturally aligned in bus space (range_requires_alignment()), so
they cannot cross a boundary they fit in.

Signed-off-by: Lin Liu <lin.liu01@citrix.com>
---
v2:
- Only check streaming mappings; coherent allocations are naturally
  aligned in bus space and cannot cross the boundary (Ross, Jürgen).
- Leave range_straddles_page_boundary() unchanged.
- Comment why alloc_coherent needs no boundary check (Jürgen).

 drivers/xen/swiotlb-xen.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index e2538824e..5041be7d3 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -96,6 +96,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 	return 0;
 }
 
+/* Bus-contiguous, but may still cross the device's segment boundary */
+static inline bool range_crosses_seg_boundary(struct device *dev,
+					      dma_addr_t dma, size_t size)
+{
+	unsigned long mask = dma_get_seg_boundary(dev);
+
+	return size && ((dma ^ (dma + size - 1)) & ~mask);
+}
+
 static struct io_tlb_pool *xen_swiotlb_find_pool(struct device *dev,
 						 dma_addr_t dma_addr)
 {
@@ -157,6 +166,7 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
 	phys = virt_to_phys(ret);
 
 	*dma_handle = xen_phys_to_dma(dev, phys);
+	/* No seg boundary check: __get_free_pages() is naturally aligned */
 	if (*dma_handle + size - 1 > dma_mask ||
 	    range_straddles_page_boundary(phys, size) ||
 	    range_requires_alignment(phys, size)) {
@@ -234,6 +244,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
 	if (dma_capable(dev, dev_addr, size, true, attrs) &&
 	    !dma_kmalloc_needs_bounce(dev, size, dir) &&
 	    !range_straddles_page_boundary(phys, size) &&
+	    !range_crosses_seg_boundary(dev, dev_addr, size) &&
 		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
 		!is_swiotlb_force_bounce(dev))
 		goto done;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.52.0

