Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E046A5E8
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842766; cv=none; b=cdkQy4YfISYORBC9zWBZMCeh4PxOR7TStP4RXQhzwaO13e7lCQF7kuRGFGE4TaCpSGeQm+2bsLtZ2DRP7ssDlXSjnZUZifAukOUohGgWq8NsN6cxyFdjZXeZhWo33aixvQHUPLn4FO3FFpXxQlI6JX/w55CeD9mHEa1xIRwvjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842766; c=relaxed/simple;
	bh=paociO8MAvUZdGp2ol9uT1lVS8i5ldAFG/8g/i2XTKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avxKL830qFiWdtpKhtM7+PNu6nPsp6Z5iWqFZIB9JNIfhAJreeyzZGwGwyiUUaVaLLZyM9IseBl97xSLFzQJ8tgwMVwUZkw1h4TAKcDOPMDIQSfYqPilnlScdULGV5KNdOg2Fkwk0cYqSZHyOPJT5AXdoktgiRmoSYaVgGamGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UUbcVHLw; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UUbcVHLw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787842758; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZKantfH/lQ8ahGeUH8Ydg3ebRGPbt0DV15/kwiMuxw8=;
	b=UUbcVHLw5duRZS7wQ13hlrnDpa215kPIakOrdgj7eHxgEwJ++8JIeCW7zLxDF2+zgJn/mGCGVfExhyLVJqrc0waXBnDTtWpMXY8NyA+MPs+jhFgYijtgdzfjzicHeGLGwExk25y502F/YKjQbXW2v10wLzMdqp1IRB8553w1jbk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X9jzaFF_1787842750;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9jzaFF_1787842750 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 22:59:15 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: joro@8bytes.org,
	will@kernel.org,
	jgg@ziepe.ca
Cc: robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	smostafa@google.com,
	praan@google.com,
	skhawaja@google.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH 1/2] iommu: Add __iommu_debug_unmap_phys() to drop refs by physical address
Date: Thu, 27 Aug 2026 22:58:54 +0800
Message-ID: <20260827145855.1616223-2-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU_DEBUG_PAGEALLOC sanitizer takes a reference on each page at
iommu_map() time, keyed by physical address, and the only way to drop
them is the IOVA based iommu_debug_unmap_begin()/end().  A path that
tears down a page table with mappings still installed has no IOVA to
unmap with, so add a physical address based counterpart of
__iommu_debug_map() for those paths, sharing the counting loop through
__iommu_debug_update_phys().

Export the iommu_debug_initialized static key, as the generic_pt format
code using these helpers can be built as a module.

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
Build tested as built-in and as a module (AMD_IOMMU=n,
CONFIG_IOMMU_PT_AMDV1=m).

 drivers/iommu/iommu-debug-pagealloc.c | 30 ++++++++++++++++++++++++---
 drivers/iommu/iommu-priv.h            | 24 +++++++++++++++++++++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index 80164df5bab1..a2e55164e6a4 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -15,6 +15,8 @@
 
 static bool needed;
 DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
+/* The generic_pt format code using the key can be built as a module */
+EXPORT_SYMBOL_GPL(iommu_debug_initialized);
 
 struct iommu_debug_metadata {
 	atomic_t ref;
@@ -96,7 +98,8 @@ void __iommu_debug_check_unmapped(const struct page *page, int numpages)
 	}
 }
 
-void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
+static void __iommu_debug_update_phys(struct iommu_domain *domain,
+				      phys_addr_t phys, size_t size, bool inc)
 {
 	size_t off, end;
 	size_t page_size = iommu_debug_page_size(domain);
@@ -104,9 +107,30 @@ void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t siz
 	if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
 		return;
 
-	for (off = 0 ; off < size ; off += page_size)
-		iommu_debug_inc_page(phys + off);
+	for (off = 0 ; off < size ; off += page_size) {
+		if (inc)
+			iommu_debug_inc_page(phys + off);
+		else
+			iommu_debug_dec_page(phys + off);
+	}
+}
+
+void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
+{
+	__iommu_debug_update_phys(domain, phys, size, true);
+}
+
+/*
+ * Physical address counterpart of __iommu_debug_map(), for teardown paths
+ * that destroy mapped entries without an IOVA.  The OAs must have been
+ * accounted by a prior iommu_map().
+ */
+void __iommu_debug_unmap_phys(struct iommu_domain *domain, phys_addr_t phys,
+			      size_t size)
+{
+	__iommu_debug_update_phys(domain, phys, size, false);
 }
+EXPORT_SYMBOL_GPL(__iommu_debug_unmap_phys);
 
 static void __iommu_debug_update_iova(struct iommu_domain *domain,
 				      unsigned long iova, size_t size, bool inc)
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..12528a40bcd8 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -71,11 +71,18 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 
 void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
 		       size_t size);
+void __iommu_debug_unmap_phys(struct iommu_domain *domain, phys_addr_t phys,
+			      size_t size);
 void __iommu_debug_unmap_begin(struct iommu_domain *domain,
 			       unsigned long iova, size_t size);
 void __iommu_debug_unmap_end(struct iommu_domain *domain,
 			     unsigned long iova, size_t size, size_t unmapped);
 
+static inline bool iommu_debug_pagealloc_enabled(void)
+{
+	return static_branch_unlikely(&iommu_debug_initialized);
+}
+
 static inline void iommu_debug_map(struct iommu_domain *domain,
 				   phys_addr_t phys, size_t size)
 {
@@ -83,6 +90,13 @@ static inline void iommu_debug_map(struct iommu_domain *domain,
 		__iommu_debug_map(domain, phys, size);
 }
 
+static inline void iommu_debug_unmap_phys(struct iommu_domain *domain,
+					  phys_addr_t phys, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_unmap_phys(domain, phys, size);
+}
+
 static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
 					   unsigned long iova, size_t size)
 {
@@ -101,11 +115,21 @@ static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
 void iommu_debug_init(void);
 
 #else
+static inline bool iommu_debug_pagealloc_enabled(void)
+{
+	return false;
+}
+
 static inline void iommu_debug_map(struct iommu_domain *domain,
 				   phys_addr_t phys, size_t size)
 {
 }
 
+static inline void iommu_debug_unmap_phys(struct iommu_domain *domain,
+					  phys_addr_t phys, size_t size)
+{
+}
+
 static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
 					   unsigned long iova, size_t size)
 {
-- 
2.43.5

