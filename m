Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788B369224
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880154; cv=none; b=TSq7fJQA3eBmcCHCvKSh1yecgCkcThlcaaY6b66l9zonKOduRbM6QI1ILAkritLOmVk/29Ocav4y+5GKEteTSzOyPpQOtpysCLc0tAAhbmImmkvsb3NRvlpsonxGqpWHKqv+iQs23sgAoLx7HrgkCvr7OuI04IF/+pYGHgmt4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880154; c=relaxed/simple;
	bh=IP6v91sqECvO+CLDQQ/CAC75x1XVtVY9Hf/auCzttIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y8eyRuXLPDkgfFc9TBXqXqSiNbzQ8vLmpEGGAMbtpLzAdEuTFgUG+fj5SpCB3eJ+M4tNMh5ErAvlcUk/FvYKEoBeU/96v4dKg/SgqQjAH+AWiUugro5Q5FUpx0tblu20mT247vqymxBKjjs2YNtawREnUp/nt2JP8btEkJh+2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o4yUi4yr; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o4yUi4yr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767880140; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/DggpkpQ+sZ9M+sA9W097wq5BtxSRcjoGTAICDIz5D0=;
	b=o4yUi4yrXQWsHv810+6ZMPMUgCulxN5Vm4cJ5Q2YK7Ilc+K3yzB6LAXw9/tZY8cbN4RseWcb4dU17KP5e6pjmkKZCddEWpDQzUhgaA4shUeJWk6awwwWRhjWdCGTrt76/XEt5MyeAxe4oZGf+9eyb8SXlmjEr5yfSL7xsgZNV88=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WwcviKM_1767880138 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 21:49:00 +0800
From: fangyu.yu@linux.alibaba.com
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: guoren@kernel.org,
	ajones@ventanamicro.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
Date: Thu,  8 Jan 2026 21:48:55 +0800
Message-Id: <20260108134855.91341-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Add riscv_iommu_iodir_iotinval() to perform required TLB and context cache
invalidations after updating DDT or PDT entries, as mandated by the RISC-V
IOMMU specification (Section 6.3.1 and 6.3.2).

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 85 +++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d9429097a2b5..2900170133fc 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -996,7 +996,82 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 }
 
 #define RISCV_IOMMU_FSC_BARE 0
+/*
+ * This function sends IOTINVAL commands as required by the RISC-V
+ * IOMMU specification (Section 6.3.1 and 6.3.2 in 1.0 spec version)
+ * after modifying DDT or PDT entries
+ */
+static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
+				    bool inval_pdt, unsigned long iohgatp,
+				    struct riscv_iommu_dc *dc, struct riscv_iommu_pc *pc)
+{
+	struct riscv_iommu_command cmd;
 
+	if (FIELD_GET(RISCV_IOMMU_DC_IOHGATP_MODE, iohgatp) ==
+		RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+		if (inval_pdt) {
+			/*
+			 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
+			 * PSCID=PC.PSCID
+			 */
+			riscv_iommu_cmd_inval_vma(&cmd);
+			riscv_iommu_cmd_inval_set_pscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
+		} else {
+			if (FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) || (
+				    FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc->fsc) ==
+				    RISCV_IOMMU_DC_FSC_MODE_BARE)) {
+				/* IOTINVAL.VMA with GV=AV=PSCV=0 */
+				riscv_iommu_cmd_inval_vma(&cmd);
+			} else {
+				/*
+				 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
+				 * PSCID=DC.ta.PSCID
+				 */
+				riscv_iommu_cmd_inval_vma(&cmd);
+				riscv_iommu_cmd_inval_set_pscid(&cmd,
+					FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, dc->ta));
+			}
+		}
+	} else {
+		if (inval_pdt) {
+			/*
+			 * IOTINVAL.VMA with GV=1, AV=0, and PSCV=1, and
+			 * GSCID=DC.iohgatp.GSCID, PSCID=PC.PSCID
+			 */
+			riscv_iommu_cmd_inval_vma(&cmd);
+			riscv_iommu_cmd_inval_set_gscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
+			riscv_iommu_cmd_inval_set_pscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
+		} else {
+			/*
+			 * IOTINVAL.VMA with GV=1,AV=PSCV=0,and
+			 * GSCID=DC.iohgatp.GSCID
+			 */
+			riscv_iommu_cmd_inval_vma(&cmd);
+			riscv_iommu_cmd_inval_set_gscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
+
+			/*
+			 * IOTINVAL.GVMA with GV=1,AV=0,and
+			 * GSCID=DC.iohgatp.GSCID
+			 */
+			/*
+			 * For now, the Second-Stage feature have not yet been merged, so
+			 * let's comment out the code first.
+			 */
+#if 0
+			riscv_iommu_cmd_send(iommu, &cmd);
+			memset(&cmd, 0, sizeof(cmd));
+			riscv_iommu_cmd_inval_gvma(&cmd);
+			riscv_iommu_cmd_inval_set_gscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
+#endif
+		}
+	}
+	riscv_iommu_cmd_send(iommu, &cmd);
+}
 /*
  * Update IODIR for the device.
  *
@@ -1031,6 +1106,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
 		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
 		riscv_iommu_cmd_send(iommu, &cmd);
+		/*
+		 * For now, the SVA and PASID features have not yet been merged, the
+		 * default configuration is inval_pdt=false and pc=NULL.
+		 */
+		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
 		sync_required = true;
 	}
 
@@ -1055,6 +1135,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		/* Invalidate device context after update */
 		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
 		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
+		/*
+		 * For now, the SVA and PASID features have not yet been merged, the
+		 * default configuration is inval_pdt=false and pc=NULL.
+		 */
+		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
 		riscv_iommu_cmd_send(iommu, &cmd);
 	}
 
-- 
2.50.1

