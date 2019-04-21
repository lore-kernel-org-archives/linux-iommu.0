Return-Path: <SRS0=OYPK=SX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFBAC282DD
	for <iommu@archiver.kernel.org>; Sun, 21 Apr 2019 01:25:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483AC20651
	for <iommu@archiver.kernel.org>; Sun, 21 Apr 2019 01:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483AC20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5BD722C9E;
	Sun, 21 Apr 2019 01:24:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DBF462BE9
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Apr 2019 01:24:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D04A314D
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Apr 2019 01:24:01 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 Apr 2019 18:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,376,1549958400"; d="scan'208";a="136008152"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 20 Apr 2019 18:23:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 05/10] iommu: Add bounce page APIs
Date: Sun, 21 Apr 2019 09:17:14 +0800
Message-Id: <20190421011719.14909-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190421011719.14909-1-baolu.lu@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, Alan Cox <alan@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Mika Westerberg <mika.westerberg@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	pengfei.xu@intel.com, jacob.jun.pan@intel.com,
	mika.westerberg@linux.intel.com, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190421011714.sJAyaJ0lcJwpohE7wL2tspYOzW2zwaqF47yJbAgyiKA@z>

IOMMU hardware always use paging for DMA remapping.  The
minimum mapped window is a page size. The device drivers
may map buffers not filling whole IOMMU window. It allows
device to access to possibly unrelated memory and various
malicious devices can exploit this to perform DMA attack.

This introduces the bouce buffer mechanism for DMA buffers
which doesn't fill a minimal IOMMU page. It could be used
by various vendor specific IOMMU drivers as long as the
DMA domain is managed by the generic IOMMU layer. Below
APIs are added:

* iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
  - Map a buffer start at DMA address @addr in bounce page
    manner. For buffer parts that doesn't cross a whole
    minimal IOMMU page, the bounce page policy is applied.
    A bounce page mapped by swiotlb will be used as the DMA
    target in the IOMMU page table. Otherwise, the physical
    address @paddr is mapped instead.

* iommu_bounce_unmap(dev, addr, size, dir, attrs)
  - Unmap the buffer mapped with iommu_bounce_map(). The bounce
    page will be torn down after the bounced data get synced.

* iommu_bounce_sync_single(dev, addr, size, dir, target)
  - Synce the bounced data in case the bounce mapped buffer is
    reused.

The whole APIs are included within a kernel option IOMMU_BOUNCE_PAGE.
It's useful for cases where bounce page doesn't needed, for example,
embedded cases.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/Kconfig |  14 +++
 drivers/iommu/iommu.c | 275 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  37 ++++++
 3 files changed, 326 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b21816..b918c22ca25b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -85,6 +85,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
 
 	  If unsure, say N here.
 
+config IOMMU_BOUNCE_PAGE
+	bool "Use bounce page for untrusted devices"
+	depends on IOMMU_API
+	select SWIOTLB
+	help
+	  IOMMU hardware always use paging for DMA remapping. The minimum
+	  mapped window is a page size. The device drivers may map buffers
+	  not filling whole IOMMU window. This allows device to access to
+	  possibly unrelated memory and malicious device can exploit this
+	  to perform a DMA attack. Select this to use a bounce page for the
+	  buffer which doesn't fill a whole IOMU page.
+
+	  If unsure, say N here.
+
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 516e4d8995c2..f199d0addbf1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -34,6 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
+#include <linux/dma-direct.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -2043,3 +2044,277 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
+
+#ifdef CONFIG_IOMMU_BOUNCE_PAGE
+
+/*
+ * Bounce buffer support for external devices:
+ *
+ * IOMMU hardware always use paging for DMA remapping. The minimum mapped
+ * window is a page size. The device drivers may map buffers not filling
+ * whole IOMMU window. This allows device to access to possibly unrelated
+ * memory and malicious device can exploit this to perform a DMA attack.
+ * Use a bounce page for the buffer which doesn't fill a whole IOMU page.
+ */
+
+struct addr_walk {
+	int (*low)(struct device *dev, struct iommu_domain *domain,
+			dma_addr_t addr, phys_addr_t paddr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs, void *data);
+	int (*middle)(struct device *dev, struct iommu_domain *domain,
+			dma_addr_t addr, phys_addr_t paddr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs, void *data);
+	int (*high)(struct device *dev, struct iommu_domain *domain,
+			dma_addr_t addr, phys_addr_t paddr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs, void *data);
+};
+
+/* Calculate how many pages does a range of [addr, addr + size) cross. */
+static inline unsigned long
+range_nrpages(dma_addr_t addr, size_t size, unsigned long page_size)
+{
+	unsigned long offset = page_size - 1;
+
+	return ALIGN((addr & offset) + size, page_size) >> __ffs(page_size);
+}
+
+static int nobounce_map(struct device *dev, struct iommu_domain *domain,
+			dma_addr_t addr, phys_addr_t paddr, size_t size,
+			enum dma_data_direction dir, unsigned long attrs,
+			void *data)
+{
+	const struct iommu_ops *ops = domain->ops;
+	int prot = 0;
+
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= IOMMU_READ;
+
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= IOMMU_WRITE;
+
+	if (unlikely(!ops->map || domain->pgsize_bitmap == 0UL))
+		return -ENODEV;
+
+	return ops->map(domain, addr, paddr, size, prot);
+}
+
+static int nobounce_unmap(struct device *dev, struct iommu_domain *domain,
+			  dma_addr_t addr, phys_addr_t paddr, size_t size,
+			  enum dma_data_direction dir, unsigned long attrs,
+			  void *data)
+{
+	const struct iommu_ops *ops = domain->ops;
+
+	if (unlikely(!ops->unmap))
+		return -ENODEV;
+	ops->unmap(domain, addr, size);
+
+	return 0;
+}
+
+static phys_addr_t
+iova_to_tlb_addr(struct iommu_domain *domain, dma_addr_t addr)
+{
+	unsigned long page_size = domain_minimal_pgsize(domain);
+	const struct iommu_ops *ops = domain->ops;
+	phys_addr_t tlb_addr;
+
+	if (unlikely(!ops->iova_to_phys))
+		return 0;
+
+	tlb_addr = ops->iova_to_phys(domain, addr);
+	if (!tlb_addr)
+		return 0;
+
+	return tlb_addr + (addr & (page_size - 1));
+}
+
+static int
+bounce_sync_single(struct device *dev, struct iommu_domain *domain,
+		   dma_addr_t addr, phys_addr_t paddr, size_t size,
+		   enum dma_data_direction dir, unsigned long attrs,
+		   void *data)
+{
+	enum dma_sync_target *target = data;
+	phys_addr_t tlb_addr;
+
+	tlb_addr = iova_to_tlb_addr(domain, addr);
+	if (tlb_addr)
+		swiotlb_tbl_sync_single(dev, tlb_addr,
+					size, dir, *target);
+
+	return 0;
+}
+
+static int bounce_map(struct device *dev, struct iommu_domain *domain,
+		      dma_addr_t addr, phys_addr_t paddr, size_t size,
+		      enum dma_data_direction dir, unsigned long attrs,
+		      void *data)
+{
+	const struct iommu_ops *ops = domain->ops;
+	phys_addr_t tlb_addr;
+	int prot = 0;
+	int ret;
+
+	if (unlikely(!ops->map || domain->pgsize_bitmap == 0UL))
+		return -ENODEV;
+
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= IOMMU_READ;
+
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= IOMMU_WRITE;
+
+	tlb_addr = phys_to_dma(dev, paddr);
+	if (!swiotlb_map(dev, &paddr, &tlb_addr, size,
+			 dir, attrs | DMA_ATTR_BOUNCE_PAGE))
+		return -ENOMEM;
+
+	ret = ops->map(domain, addr, tlb_addr, size, prot);
+	if (ret)
+		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
+					 dir, attrs | DMA_ATTR_BOUNCE_PAGE);
+
+	return ret;
+}
+
+static const struct addr_walk walk_bounce_map = {
+	.low = bounce_map,
+	.middle = nobounce_map,
+	.high = bounce_map,
+};
+
+static int bounce_unmap(struct device *dev, struct iommu_domain *domain,
+			dma_addr_t addr, phys_addr_t paddr, size_t size,
+			enum dma_data_direction dir, unsigned long attrs,
+			void *data)
+{
+	unsigned long page_size = domain_minimal_pgsize(domain);
+	phys_addr_t tlb_addr = iova_to_tlb_addr(domain, addr);
+	const struct iommu_ops *ops = domain->ops;
+
+	if (unlikely(!ops->unmap))
+		return -ENODEV;
+	ops->unmap(domain, ALIGN_DOWN(addr, page_size), page_size);
+
+	if (tlb_addr)
+		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
+					 dir, attrs | DMA_ATTR_BOUNCE_PAGE);
+
+	return 0;
+}
+
+static const struct addr_walk walk_bounce_unmap = {
+	.low = bounce_unmap,
+	.middle = nobounce_unmap,
+	.high = bounce_unmap,
+};
+
+static const struct addr_walk walk_bounce_sync_single = {
+	.low = bounce_sync_single,
+	.high = bounce_sync_single,
+};
+
+static int
+domain_walk_addr_range(const struct addr_walk *walk, struct device *dev,
+		       struct iommu_domain *domain, dma_addr_t addr,
+		       phys_addr_t paddr, size_t size,
+		       enum dma_data_direction dir,
+		       unsigned long attrs,
+		       void *data)
+{
+	u64 page_size = domain_minimal_pgsize(domain);
+	u64 page_offset = page_size - 1;
+	u64 page_mask = ~page_offset;
+	u64 length = 0;
+	int ret;
+
+	/*
+	 * The first vt-d page is partial. Use bounce buffer for
+	 * security concern if necessary.
+	 */
+	if (addr & page_offset) {
+		length = ALIGN(addr, page_size) - addr;
+		if (length > size)
+			length = size;
+		if (walk->low) {
+			ret = walk->low(dev, domain, addr, paddr,
+					length, dir, attrs, data);
+			if (ret)
+				return ret;
+		}
+
+		/* The buffer only covers on page. */
+		if (range_nrpages(addr, size, page_size) <= 1)
+			return 0;
+
+		size -= length;
+		addr = ALIGN(addr, page_size);
+		paddr = ALIGN(paddr, page_size);
+	}
+
+	/*
+	 * There might be several pages which could totally accessed
+	 * by a device in the middle. It's unnecessary to use bounce
+	 * buffer against these pages.
+	 */
+	if (size & page_mask) {
+		length = size & page_mask;
+		if (walk->middle) {
+			ret = walk->middle(dev, domain, addr, paddr,
+					   length, dir, attrs, data);
+			if (ret)
+				return ret;
+		}
+
+		addr += size & page_mask;
+		paddr += size & page_mask;
+		size &= page_offset;
+	}
+
+	/*
+	 * Okay, last page might be partial. Use bounce buffer if necessary.
+	 */
+	if (size && walk->high)
+		return walk->high(dev, domain, addr, paddr,
+				  size, dir, attrs, data);
+
+	return 0;
+}
+
+int iommu_bounce_map(struct device *dev, dma_addr_t addr, phys_addr_t paddr,
+		     size_t size, enum dma_data_direction dir,
+		     unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	return domain_walk_addr_range(&walk_bounce_map, dev, domain,
+				      addr, paddr, size, dir, attrs, NULL);
+}
+EXPORT_SYMBOL_GPL(iommu_bounce_map);
+
+int iommu_bounce_unmap(struct device *dev, dma_addr_t addr,
+		       size_t size, enum dma_data_direction dir,
+		       unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	return domain_walk_addr_range(&walk_bounce_unmap, dev, domain,
+				      addr, 0, size, dir, attrs, NULL);
+}
+EXPORT_SYMBOL_GPL(iommu_bounce_unmap);
+
+int iommu_bounce_sync_single(struct device *dev, dma_addr_t addr,
+			     size_t size, enum dma_data_direction dir,
+			     enum dma_sync_target target)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	return domain_walk_addr_range(&walk_bounce_sync_single, dev,
+				      domain, addr, 0, size, dir, 0, &target);
+}
+EXPORT_SYMBOL_GPL(iommu_bounce_sync_single);
+#endif /* CONFIG_IOMMU_BOUNCE_PAGE */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46679ef19b7e..93a4837dfe43 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/swiotlb.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -428,6 +429,42 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
+#ifdef CONFIG_IOMMU_BOUNCE_PAGE
+int iommu_bounce_map(struct device *dev, dma_addr_t addr, phys_addr_t paddr,
+		     size_t size, enum dma_data_direction dir,
+		     unsigned long attrs);
+int iommu_bounce_unmap(struct device *dev, dma_addr_t addr,
+		       size_t size, enum dma_data_direction dir,
+		       unsigned long attrs);
+int iommu_bounce_sync_single(struct device *dev, dma_addr_t addr,
+			     size_t size, enum dma_data_direction dir,
+			     enum dma_sync_target target);
+#else
+static inline int
+iommu_bounce_map(struct device *dev, dma_addr_t addr, phys_addr_t paddr,
+		 size_t size, enum dma_data_direction dir,
+		 unsigned long attrs)
+{
+	return -ENODEV;
+}
+
+static inline int
+iommu_bounce_unmap(struct device *dev, dma_addr_t addr,
+		   size_t size, enum dma_data_direction dir,
+		   unsigned long attrs)
+{
+	return -ENODEV;
+}
+
+static inline int
+iommu_bounce_sync_single(struct device *dev, dma_addr_t addr,
+			 size_t size, enum dma_data_direction dir,
+			 enum dma_sync_target target)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_IOMMU_BOUNCE_PAGE */
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
