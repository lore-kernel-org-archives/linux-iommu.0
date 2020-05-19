Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF82C433E1
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 20:49:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C54D207E8
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 20:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DgLq9OSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C54D207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 26E1286E92;
	Tue, 19 May 2020 20:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4Vv5ijgkiqq; Tue, 19 May 2020 20:49:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 12D7286E56;
	Tue, 19 May 2020 20:49:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E70C0C0890;
	Tue, 19 May 2020 20:49:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F47BC0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 49D11866DD
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 71Jpcj-fkqWR for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 20:42:02 +0000 (UTC)
X-Greylist: delayed 00:07:13 by SQLgrey-1.7.6
Received: from rnd-relay.smtp.broadcom.com (rnd-relay.smtp.broadcom.com
 [192.19.229.170])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8909D86501
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:02 +0000 (UTC)
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net
 [10.75.242.48])
 by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 2758430D7A9;
 Tue, 19 May 2020 13:33:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 2758430D7A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1589920417;
 bh=ql15htmxWd+skJX12piE6V7RFns3X98Jlpcjg0U7D7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DgLq9OSUu4NoxecsafkoWouuM8+BkMmsFkWG/0w0Ad1IDjT5AHoKibOOA5tgHnGlo
 zbRy0GMUaK3dzx04Onsl5dPmvPVBdXNRff0X0TQDU90DPF3luT1SBreCfdBj/92Wxy
 1roMWrSiJpgofWsTg5Uh0CWY/TywvkiOTDNMknYc=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net
 [10.28.16.211])
 by mail-irv-17.broadcom.com (Postfix) with ESMTP id D3D82140069;
 Tue, 19 May 2020 13:34:57 -0700 (PDT)
To: james.quinlan@broadcom.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 09/15] device core: Add ability to handle multiple dma offsets
Date: Tue, 19 May 2020 16:34:07 -0400
Message-Id: <20200519203419.12369-10-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
X-Mailman-Approved-At: Tue, 19 May 2020 20:49:28 +0000
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Saravana Kannan <saravanak@google.com>, Frank Rowand <frowand.list@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The device variable 'dma_pfn_offset' is used to do a single
linear map between cpu addrs and dma addrs.  The variable
'dma_map' is added to struct device to point to an array
of multiple offsets which is required for some devices.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/of/address.c        | 50 ++++++++++++++++++++++++++++++++++---
 include/linux/device.h      |  9 ++++++-
 include/linux/dma-mapping.h | 44 ++++++++++++++++++++++++++++++++
 kernel/dma/Kconfig          | 12 +++++++++
 4 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 96d8cfb14a60..7dfff618af6a 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -947,6 +947,8 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 	struct of_range_parser parser;
 	struct of_range range;
 	u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
+	bool dma_multi_pfn_offset = false;
+	int num_ranges = 0;
 
 	while (node) {
 		ranges = of_get_property(node, "dma-ranges", &len);
@@ -977,10 +979,18 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
 			 range.bus_addr, range.cpu_addr, range.size);
 
+		num_ranges++;
 		if (dma_offset && range.cpu_addr - range.bus_addr != dma_offset) {
-			pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
-			/* Don't error out as we'd break some existing DTs */
-			continue;
+			dma_multi_pfn_offset = true;
+			if (!IS_ENABLED(CONFIG_DMA_PFN_OFFSET_MAP)) {
+				pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
+				/*
+				 * Don't error out as we'd break some
+				 * existing DTs that are using configs
+				 * w/o CONFIG_DMA_PFN_OFFSET_MAP set.
+				 */
+				continue;
+			}
 		}
 		dma_offset = range.cpu_addr - range.bus_addr;
 
@@ -991,6 +1001,40 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 			dma_end = range.bus_addr + range.size;
 	}
 
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	if (dma_multi_pfn_offset) {
+		size_t r_size = (num_ranges + 1)
+			* sizeof(struct dma_pfn_offset_region);
+		struct dma_pfn_offset_region *r;
+
+		if (!dev)
+			return -EINVAL;
+
+		dma_offset = 0;
+		r = devm_kcalloc(dev, 1, r_size, GFP_KERNEL);
+		if (!r)
+			return -ENOMEM;
+		dev->dma_offset_map = (const void *) r;
+		of_dma_range_parser_init(&parser, node);
+
+		/*
+		 * Record all info for DMA ranges array.  We could
+		 * just use the of_range struct, but if we did that it
+		 * would require more calculations for phys_to_dma and
+		 * dma_to_phys conversions.
+		 */
+		for_each_of_range(&parser, &range) {
+			r->cpu_beg = range.cpu_addr;
+			r->cpu_end = r->cpu_beg + range.size;
+			r->dma_beg = range.bus_addr;
+			r->dma_end = r->dma_beg + range.size;
+			r->pfn_offset = PFN_DOWN(range.cpu_addr)
+				- PFN_DOWN(range.bus_addr);
+			r++;
+		}
+	}
+#endif
+
 	if (dma_start >= dma_end) {
 		ret = -EINVAL;
 		pr_debug("Invalid DMA ranges configuration on node(%pOF)\n",
diff --git a/include/linux/device.h b/include/linux/device.h
index ac8e37cd716a..6cd916860b5f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -493,6 +493,8 @@ struct dev_links_info {
  * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
  *		DMA limit than the device itself supports.
  * @dma_pfn_offset: offset of DMA memory range relatively of RAM
+ * @dma_map:	Like dma_pfn_offset but used when there are multiple
+ *		pfn offsets for multiple dma-ranges.
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
  * @dma_pools:	Dma pools (if dma'ble device).
@@ -578,7 +580,12 @@ struct device {
 					     allocations such descriptors. */
 	u64		bus_dma_limit;	/* upstream dma constraint */
 	unsigned long	dma_pfn_offset;
-
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	const void *dma_offset_map;	/* Like dma_pfn_offset, but for
+					 * the unlikely case of multiple
+					 * offsets. If non-null, dma_pfn_offset
+					 * will be 0. */
+#endif
 	struct device_dma_parameters *dma_parms;
 
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 330ad58fbf4d..288d8089faf7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -256,6 +256,38 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #ifdef CONFIG_HAS_DMA
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+struct dma_pfn_offset_region {
+	phys_addr_t	cpu_beg;
+	phys_addr_t	cpu_end;
+	dma_addr_t	dma_beg;
+	dma_addr_t	dma_end;
+	unsigned long	pfn_offset;
+};
+
+static inline unsigned long dma_pfn_offset_frm_dma_addr(const void *arr,
+							dma_addr_t dma_addr)
+{
+	const struct dma_pfn_offset_region *m;
+
+	for (m = arr; m->cpu_end; m++)
+		if (dma_addr >= m->dma_beg && dma_addr < m->dma_end)
+			return m->pfn_offset;
+	return 0;
+}
+
+static inline unsigned long dma_pfn_offset_frm_phys_addr(const void *arr,
+							 phys_addr_t paddr)
+{
+	const struct dma_pfn_offset_region *m;
+
+	for (m = arr; m->cpu_end; m++)
+		if (paddr >= m->cpu_beg && paddr < m->cpu_end)
+			return m->pfn_offset;
+	return 0;
+}
+#endif /* CONFIG_DMA_PFN_OFFSET_MAP */
+
 #include <asm/dma-mapping.h>
 
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
@@ -575,6 +607,18 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 {
 	return 0;
 }
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+static inline unsigned long dma_pfn_offset_frm_dma_addr(const void *arr,
+							dma_addr_t dma_addr)
+{
+	return 0;
+}
+static inline unsigned long dma_pfn_offset_frm_phys_addr(const void *arr,
+							 phys_addr_t paddr)
+{
+	return 0;
+}
+#endif /* CONFIG_DMA_PFN_OFFSET_MAP */
 #endif /* CONFIG_HAS_DMA */
 
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c103a24e380..b4c3de521bf9 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -195,3 +195,15 @@ config DMA_API_DEBUG_SG
 	  is technically out-of-spec.
 
 	  If unsure, say N.
+
+config DMA_PFN_OFFSET_MAP
+	bool "Uses a DMA range map to calculate PFN offset"
+	default n
+	help
+	  Some devices have a dma-range that gets converted to
+	  a dev->dma_pfn_offset value.  This option is for the
+	  atypical case of there being multiple dma-ranges requiring
+	  multiple pfn offsets, which are selected from when
+	  converting to phys to dma and vice versa.
+
+	  If unsure, say N.
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
