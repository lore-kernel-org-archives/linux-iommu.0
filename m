Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E330AADB
	for <iommu@lists.linux.dev>; Sun,  8 Feb 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561750; cv=none; b=su+CT5ACAq4wcuhmh6dgHZtgcnCX7KSKkyibI2YWSCvXcOA4GuLvYz3D6zPGSbl/QB+bX6BzxAoMSAg+LZYIPGuHl2gpG0G7rOr6XEoxKR0K07dvIZP768PpTyNHpRbK3uDoVqikkrLL79QIO4QjBIzSsDkDP9iRGAtqvkCex3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561750; c=relaxed/simple;
	bh=GTDJ3eRWXllECRowh3xafSUPTWf9JfmHXQtT+67Tpk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxJVEWbM8ER609DHvjE+DQWpiLz5LS8EXNqvkQegiwF8iU/e/oR2onP7O0lJOmf1n6fkeHvWMoyGXdn6g+dn7kyrYw7VJlWu6oWgiyEpLehGgemEPkz+BQb06eD0NOeaR28kNRnJI2bFhoy98Uz5zW3AvmdfTp+I029YePxlMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QntMVIhc; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QntMVIhc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770561745; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=832YTHZrK3Pyq+HUnUx8cNLTvYiKXNSGu9dxfufivbw=;
	b=QntMVIhc8yfz4YcBB8NB/4WzlUGJzuhMIO1o08QydNPur+82ntotSMAiEpJUIpeAd1sY+0Sgomd8L+0q0Bg8SFkqETIgMRmmdiuyxFpYtz1pvlazoXWh6gt43bA2ijepl9fzw6XcxAC0mzlY9PRFH72Nt2cmiEVBST8YL0VH5h0=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WylHpCX_1770561742 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 08 Feb 2026 22:42:25 +0800
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
Subject: [PATCH 1/2] iommu/riscv: Add NAPOT range invalidation support for IOTINVAL
Date: Sun,  8 Feb 2026 22:42:12 +0800
Message-Id: <20260208144213.94856-2-fangyu.yu@linux.alibaba.com>
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

RISC-V IOMMU v1.0.1 defines an Address Range Invalidation extension
(capabilities.S) which allows encoding the invalidation size as a
NAPOT range in the ADDR operand when issuing IOTINVAL.VMA/GVMA with
the S bit set. This can significantly reduce the number of invalidation
commands, especially when superpages are used.

Add the missing capabilities.S definition, introduce the IOTINVAL.S bit
and a helper to program NAPOT-encoded ranges, and switch the IOTLB
invalidation path to use range invalidations when it is available. The
implementation splits the requested interval into the largest aligned
NAPOT ranges and falls back to whole address space invalidation for larger
ranges.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu-bits.h | 10 ++++
 drivers/iommu/riscv/iommu.c      | 86 ++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 98daf0e1a306..0d1f8813ae31 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -62,6 +62,7 @@
 #define RISCV_IOMMU_CAPABILITIES_PD8		BIT_ULL(38)
 #define RISCV_IOMMU_CAPABILITIES_PD17		BIT_ULL(39)
 #define RISCV_IOMMU_CAPABILITIES_PD20		BIT_ULL(40)
+#define RISCV_IOMMU_CAPABILITIES_S		BIT_ULL(43)
 
 /**
  * enum riscv_iommu_igs_settings - Interrupt Generation Support Settings
@@ -472,6 +473,7 @@ struct riscv_iommu_command {
 #define RISCV_IOMMU_CMD_IOTINVAL_PSCV		BIT_ULL(32)
 #define RISCV_IOMMU_CMD_IOTINVAL_GV		BIT_ULL(33)
 #define RISCV_IOMMU_CMD_IOTINVAL_GSCID		GENMASK_ULL(59, 44)
+#define RISCV_IOMMU_CMD_IOTINVAL_S		BIT_ULL(9)
 /* dword1[61:10] is the 4K-aligned page address */
 #define RISCV_IOMMU_CMD_IOTINVAL_ADDR		GENMASK_ULL(61, 10)
 
@@ -715,6 +717,14 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
 	cmd->dword1 = 0;
 }
 
+static inline void riscv_iommu_cmd_inval_set_range(struct riscv_iommu_command *cmd,
+						   u64 addr)
+{
+	cmd->dword1 = FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, addr) |
+		      RISCV_IOMMU_CMD_IOTINVAL_S;
+	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_AV;
+}
+
 static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
 						  u64 addr)
 {
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d9429097a2b5..ae48409a052a 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -913,7 +913,88 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
 	}
 }
+/*
+ * Encode a NAPOT range for IOTINVAL.{VMA,GVMA} when the S bit is set.
+ *
+ * Per RISC-V IOMMU Address Range Invalidation Extension:
+ *   - The ADDR operand is NAPOT encoded in 4KiB units.
+ *   - Scanning ADDR from bit 0 upwards, if the first 0 bit is at position X,
+ *     the invalidation range size is 2^(X+1) * 4KiB (X=0 => 8KiB).
+ *   - Thus, for a range of size = 4KiB * 2^k (k >= 1), the encoded ADDR has
+ *     its low (k-1) bits set to 1, and bit (k-1) cleared (by alignment).
+ *
+ */
+static unsigned long range_encode(unsigned long start, unsigned long size)
+{
+	unsigned long blocks = size >> PAGE_SHIFT;
+	unsigned long x = ilog2(blocks) - 1;
+
+	return (start >> PAGE_SHIFT) | ((1ULL << x) - 1);
+}
+static void riscv_iommu_iotlb_inval_range(struct riscv_iommu_domain *domain,
+					  struct riscv_iommu_device *iommu,
+					  unsigned long start, unsigned long end)
+{
+	struct riscv_iommu_command cmd;
+	unsigned long len = end - start + 1;
+	unsigned long page_start, limit, cur, max_range, size, range_addr;
+	int order;
+
+	riscv_iommu_cmd_inval_vma(&cmd);
+	riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+
+	/*
+	 * Using NAPOT range invalidations may still require multiple commands
+	 * to cover a large interval (e.g. when the range is poorly aligned and
+	 * needs to be split into many smaller NAPOT blocks).
+	 *
+	 * To keep the number of queued IOTINVAL commands bounded and avoid
+	 * excessive invalidation overhead, treat very large invalidation
+	 * requests as a global flush for the address space (AV=0, PSCV=1).
+	 *
+	 */
+	if (len > SZ_1G) {
+		riscv_iommu_cmd_send(iommu, &cmd);
+		return;
+	}
 
+	page_start = start & PAGE_MASK;
+	limit = PAGE_ALIGN(end + 1);
+	cur = page_start;
+
+	while (cur < limit) {
+		max_range = 0;
+
+		/*
+		 * We cap the maximum NAPOT range to 1GiB (order=18, i.e. 2^18 * 4KiB) and
+		 * fall back to a whole-address-space invalidation for larger ranges. This
+		 * keeps the command generation bounded and aligns with the existing policy
+		 * of treating very large invalidations as global flushes.
+		 */
+		for (order = 18; order >= 1; order--) {
+			/* 1GB, ... , 16KB, 8KB */
+			size = (1ULL << order) * SZ_4K;
+			if (cur + size <= limit && IS_ALIGNED(cur, size)) {
+				max_range = size;
+				break;
+			}
+		}
+
+		if (max_range) {
+			range_addr = range_encode(cur, max_range);
+
+			riscv_iommu_cmd_inval_set_range(&cmd, range_addr);
+			riscv_iommu_cmd_send(iommu, &cmd);
+			cur += max_range;
+			continue;
+		}
+
+		/* Fall back to single-page invalidation */
+		riscv_iommu_cmd_inval_set_addr(&cmd, cur);
+		riscv_iommu_cmd_send(iommu, &cmd);
+		cur += PAGE_SIZE;
+	}
+}
 /*
  * Send IOTLB.INVAL for whole address space for ranges larger than 2MB.
  * This limit will be replaced with range invalidations, if supported by
@@ -970,6 +1051,11 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 		if (iommu == prev)
 			continue;
 
+		if (!!(iommu->caps & RISCV_IOMMU_CAPABILITIES_S)) {
+			riscv_iommu_iotlb_inval_range(domain, iommu, start, end);
+			continue;
+		}
+
 		riscv_iommu_cmd_inval_vma(&cmd);
 		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
 		if (len && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
-- 
2.50.1

