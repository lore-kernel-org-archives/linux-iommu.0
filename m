Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E435A937
	for <iommu@lists.linux.dev>; Sun,  8 Feb 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561752; cv=none; b=m40mtmVzV6Nf3NMKXxLR/uSVRNzFgHAKN4hODMLM35NRjDvkAMdhntXVR1fiQoAmWP3W5+/3cUNf/9VYWZUUeLHpfZxjAKzpeBFM2zghNiNooS/yAxetfTvuoBEhnBznR0r9EJSam2sTcAkw918s6m7SxMdmDA36qWn7Z/ukGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561752; c=relaxed/simple;
	bh=Df6xI1i0LwF6dItD+EnIg+S7lMjydVSa2v73XfQ3nrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TP41R1BZ0Iy/9FWqRYcaUYv6+BugUBrijVftisWlKAzJhiSrh24Qnmcx+wlh+w1ny0RkdA06VhGsIoXigByLucNTUiq4idUK2i+8JY+gB72ObTRSoMp/3qaab+6WpjMX53+yDLSpwuHapPg2Z5lxzsxkz9XHLwK+XBngi0rrMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gHydBux5; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gHydBux5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770561748; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=a7cRGNrOwnSEMVTnWHlQkoIS4hluf6bSkDbchWo+rq0=;
	b=gHydBux5u8/R67wp2ecCInIHy0rUHM1GQ69n99USloKo4du+QKEbBjd3DH4KfONIXPtA+A64K80HOC4rbjiy1oTgc0Wv3VDuw8nnXT/bG9GxTuavTHwibI3KaESrZPFBw8I+5V/IdbeGjRaYNA5J/MmSSSOCYw4UPIooBqm5Xo4=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WylHpD3_1770561745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 08 Feb 2026 22:42:27 +0800
From: fangyu.yu@linux.alibaba.com
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com
Cc: guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH 2/2] iommu/riscv: Add non-leaf invalidation support
Date: Sun,  8 Feb 2026 22:42:13 +0800
Message-Id: <20260208144213.94856-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260208144213.94856-1-fangyu.yu@linux.alibaba.com>
References: <20260208144213.94856-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

The RISC-V IOMMU v1.0.1 spec adds the Non-leaf PTE Invalidation extension
(capabilities.NL) which allows IOTINVAL.VMA to invalidate cached non-leaf
PTE information when performing address-specific invalidations.

Add the NL capability bit definition and the IOTINVAL.VMA NL operand bit,
and provide a helper to set NL in an invalidation command.

Extend the internal IOTLB invalidation helpers to optionally request non-
leaf invalidation and, when mapping replaces non-leaf page-table entries
(freelist is not empty), invalidate the affected IOVA range with non-leaf
semantics instead of falling back to invalidate-all.

This reduces the scope of invalidations while keeping compatibility with
implementations that do not support the NL extension.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu-bits.h |  7 +++++++
 drivers/iommu/riscv/iommu.c      | 29 +++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 0d1f8813ae31..35bb9eaa5214 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -62,6 +62,7 @@
 #define RISCV_IOMMU_CAPABILITIES_PD8		BIT_ULL(38)
 #define RISCV_IOMMU_CAPABILITIES_PD17		BIT_ULL(39)
 #define RISCV_IOMMU_CAPABILITIES_PD20		BIT_ULL(40)
+#define RISCV_IOMMU_CAPABILITIES_NL		BIT_ULL(42)
 #define RISCV_IOMMU_CAPABILITIES_S		BIT_ULL(43)
 
 /**
@@ -473,6 +474,7 @@ struct riscv_iommu_command {
 #define RISCV_IOMMU_CMD_IOTINVAL_PSCV		BIT_ULL(32)
 #define RISCV_IOMMU_CMD_IOTINVAL_GV		BIT_ULL(33)
 #define RISCV_IOMMU_CMD_IOTINVAL_GSCID		GENMASK_ULL(59, 44)
+#define RISCV_IOMMU_CMD_IOTINVAL_NL		BIT_ULL(34)
 #define RISCV_IOMMU_CMD_IOTINVAL_S		BIT_ULL(9)
 /* dword1[61:10] is the 4K-aligned page address */
 #define RISCV_IOMMU_CMD_IOTINVAL_ADDR		GENMASK_ULL(61, 10)
@@ -732,6 +734,11 @@ static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cm
 	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_AV;
 }
 
+static inline void riscv_iommu_cmd_inval_set_nonleaf(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_NL;
+}
+
 static inline void riscv_iommu_cmd_inval_set_pscid(struct riscv_iommu_command *cmd,
 						   int pscid)
 {
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index ae48409a052a..acc82c8626ce 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -933,7 +933,8 @@ static unsigned long range_encode(unsigned long start, unsigned long size)
 }
 static void riscv_iommu_iotlb_inval_range(struct riscv_iommu_domain *domain,
 					  struct riscv_iommu_device *iommu,
-					  unsigned long start, unsigned long end)
+					  unsigned long start, unsigned long end,
+					  bool non_leaf)
 {
 	struct riscv_iommu_command cmd;
 	unsigned long len = end - start + 1;
@@ -962,6 +963,16 @@ static void riscv_iommu_iotlb_inval_range(struct riscv_iommu_domain *domain,
 	limit = PAGE_ALIGN(end + 1);
 	cur = page_start;
 
+	if (non_leaf) {
+		if (!!(iommu->caps & RISCV_IOMMU_CAPABILITIES_NL)) {
+			riscv_iommu_cmd_inval_set_nonleaf(&cmd);
+		} else {
+			/* Falls back to whole address space invalidation */
+			riscv_iommu_cmd_send(iommu, &cmd);
+			return;
+		}
+	}
+
 	while (cur < limit) {
 		max_range = 0;
 
@@ -1004,7 +1015,8 @@ static void riscv_iommu_iotlb_inval_range(struct riscv_iommu_domain *domain,
 #define RISCV_IOMMU_IOTLB_INVAL_LIMIT	(2 << 20)
 
 static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
-				    unsigned long start, unsigned long end)
+				    unsigned long start, unsigned long end,
+				    bool non_leaf)
 {
 	struct riscv_iommu_bond *bond;
 	struct riscv_iommu_device *iommu, *prev;
@@ -1052,8 +1064,11 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 			continue;
 
 		if (!!(iommu->caps & RISCV_IOMMU_CAPABILITIES_S)) {
-			riscv_iommu_iotlb_inval_range(domain, iommu, start, end);
+			riscv_iommu_iotlb_inval_range(domain, iommu, start, end, non_leaf);
 			continue;
+		} else if (non_leaf) {
+			/* Falls back to whole address space invalidation */
+			len = ULONG_MAX;
 		}
 
 		riscv_iommu_cmd_inval_vma(&cmd);
@@ -1155,7 +1170,7 @@ static void riscv_iommu_iotlb_flush_all(struct iommu_domain *iommu_domain)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 
-	riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
+	riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX, false);
 }
 
 static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
@@ -1163,7 +1178,7 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 
-	riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
+	riscv_iommu_iotlb_inval(domain, gather->start, gather->end, false);
 }
 
 #define PT_SHIFT (PAGE_SHIFT - ilog2(sizeof(pte_t)))
@@ -1284,6 +1299,7 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 	unsigned long pte, old, pte_prot;
 	int rc = 0;
 	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
+	unsigned long inval_start = iova;
 
 	if (!(prot & IOMMU_WRITE))
 		pte_prot = _PAGE_BASE | _PAGE_READ;
@@ -1322,7 +1338,8 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 		 * This will be updated with hardware support for
 		 * capability.NL (non-leaf) IOTINVAL command.
 		 */
-		riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
+		riscv_iommu_iotlb_inval(domain, inval_start,
+					inval_start + size - 1, true);
 		iommu_put_pages_list(&freelist);
 	}
 
-- 
2.50.1

