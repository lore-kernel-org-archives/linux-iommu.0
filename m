Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436988;
	b=qInsVwCPKxxUSM3oRD+mUvB6bGZQKuVrJ/58tkCNhTuyxMdEBFs+WHrQUwaOddRbIdK6
	 N0ig/UPTQTAAzBqKC9vqoG5pbUnBnTXY9Ag1IS16f+EbqdDg3E7227v72iO6hUN0nHRTi
	 qCLBQpqJLILiTxWSRB8y7V+JnbFC2kLq5FihEgXsGj1JRhO5ZBeNI+xqQ/q5PyvWcrxUG
	 Gs9sFTN4fTpUOtEBLi11zyzbKKxQigDoYgptotg3pMA0kb1kP7kNVXNpY3XYfuKqysyY6
	 Pzta8TwjqFLi9ljEo4EttUL9uz02s+bzqOCniJFg7iZrtybIqlZ3A9ZDh7rCXjmx5wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436988;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=RBoTs6r5wYqfFVcu6Z9h9kAjCr3YDmQNMbyd7fcbAzM=;
	b=X8bMOyGuAY+6LgRKIG5j9eCxjeEVx7xdVkmHje8VZEsF+X0jLDABeW8WB219EfbuZ/+4
	 zCve3lTmPq3EHnNa5zwk96YAeR6K1xYQ7n3RHOqdlnIk2O9Cqz/PUUtLJ3SPNIpEnhGxo
	 XTGtrpNIvxQvJV4waebNHII8ix9pu/OKqfXyHczgz1mlLCgmIcZq53fH97LlZMd1oIssN
	 xpZ75hOz4RiTytPAN/e/ra5chQju4V4VMkNsHP7i7UExqXapJvgeRRcb9WCbb8l5zP+PC
	 iLXgLa2+lBbr/HERP47xjqd25pECuqoHiNJWOz/9P3ZErCEWfOxJwVX875MyEhVEiWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=tcF+cbuL;
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B821606A332
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B821606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=tcF+cbuL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794436987; x=1825972987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RBoTs6r5wYqfFVcu6Z9h9kAjCr3YDmQNMbyd7fcbAzM=;
  b=tcF+cbuL+pXX6pnp1JOFtZEOAjdI7RgU3w9aT59Qlc/BIYfdQ9517XJJ
   1UGmkgz980K2cWnGE96tI8aZTHemTtt/qH5XHUy/ebdPbiieVdtni9OLj
   fI8mZNOnzizUQTUAS0nhUC6/+QX3xCs3j3QWrzaiNFjNtOJbwQs73L4ym
   +mgGKRirzoGb06EE+kGhodXPrGasiTqvn4lB0wtacVswm7BxioecMlNgc
   VFQbch3SpZc7QffsfvxjNV9HLTrPJIEauryqm+aT+M3yGvDWn6USLEMA2
   O63htuqgtJObYcArRRrTB9nPoy7T2+OHTmpB02C2315Hhl+WzlIQnYL4h
   w==;
X-CSE-ConnectionGUID: Rso91KE1TdiVCucbxbm6og==
X-CSE-MsgGUID: B0cPfbwwSJiu+2CdqbxQQg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33769022"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:43:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:29544]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.250:2525] with esmtp (Farcaster)
 id ae4ac7d1-cb28-48b7-a577-32d39a81e1a6; Wed, 11 Nov 2026 22:43:04 +0000 (UTC)
X-Farcaster-Flow-ID: ae4ac7d1-cb28-48b7-a577-32d39a81e1a6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:04 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:01 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	<nh-open-source@amazon.com>, <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: [PATCH 05/40] dma-contiguous: add dma_get_numa_cma_area() accessor
Date: Wed, 11 Nov 2026 22:41:50 +0000
Message-ID: <a1294df95fbe0a2ef5cc3585824d396854c7242c.1794393490.git.graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1794300002.git.graf@amazon.com>
References: <cover.1794300002.git.graf@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

With Nitro Sandboxes, we want to allocate per-NUMA memory from the DMA
contiguous allocator, but have no per-NUMA struct device to pass in.
dma_alloc_contiguous() takes the node from dev_to_node(dev), and the
per-node areas sit in dma_contiguous_numa_area[], which is static.

So instead, introduce dma_get_numa_cma_area(), which returns the generic
per-NUMA DMA CMA area that cma_alloc() would use. This way, the
nitro_enclaves driver can build its own generic CMA pool per-node
allocation logic on top of those pools.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/dma-map-ops.h |  7 +++++++
 kernel/dma/contiguous.c     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index afaf2c12189b8..5f7138ea6899a 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -93,6 +93,7 @@ static inline void set_dma_ops(struct device *dev,
 #ifdef CONFIG_DMA_CMA
 struct cma *dev_get_cma_area(struct device *dev);
 struct cma *dma_contiguous_get_area_by_idx(unsigned int idx);
+struct cma *dma_get_numa_cma_area(int nid);
 
 void dma_contiguous_reserve(phys_addr_t addr_limit);
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
@@ -115,6 +116,12 @@ static inline struct cma *dma_contiguous_get_area_by_idx(unsigned int idx)
 {
 	return NULL;
 }
+
+static inline struct cma *dma_get_numa_cma_area(int nid)
+{
+	return NULL;
+}
+
 static inline void dma_contiguous_reserve(phys_addr_t limit)
 {
 }
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627d..363b84284d087 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -443,6 +443,42 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);
 }
 
+/**
+ * dma_get_numa_cma_area() - get the CMA area a NUMA node can allocate from
+ * @nid: NUMA node id
+ *
+ * dma_alloc_contiguous() picks a per-node CMA area from dev_to_node(dev),
+ * which a caller cannot override on a per-request basis. This accessor
+ * returns the area a specific node can allocate from, so a caller can
+ * cma_alloc() from the node it wants.
+ *
+ * A per-node area comes from numa_cma= or cma_pernuma=, or from
+ * CONFIG_CMA_SIZE_PERNUMA, which reserves the default area's size on every
+ * online node on top of the default area itself, all three of which are
+ * CONFIG_DMA_NUMA_CMA. Where there is one online node this returns the default
+ * area, so a host that reserved only cma= reaches its reservation through this
+ * accessor as well, and that holds however CONFIG_DMA_NUMA_CMA is set.
+ *
+ * Return: the area @nid can allocate from, or NULL if @nid has none or is not
+ * a valid node (including NUMA_NO_NODE).
+ */
+struct cma *dma_get_numa_cma_area(int nid)
+{
+	if ((unsigned int)nid >= MAX_NUMNODES)
+		return NULL;
+
+#ifdef CONFIG_DMA_NUMA_CMA
+	if (dma_contiguous_numa_area[nid])
+		return dma_contiguous_numa_area[nid];
+#endif
+
+	if (nr_online_nodes == 1 && node_online(nid))
+		return dma_contiguous_default_area;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(dma_get_numa_cma_area);
+
 /**
  * dma_free_contiguous() - release allocated pages
  * @dev:   Pointer to device for which the pages were allocated.
-- 
2.47.1

