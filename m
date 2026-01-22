Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A52BE644
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092360; cv=none; b=TGJfdomaDmSqQyJQsSGNtsk8eaJIoQuwq+KLWDhv+V0jCSc5vUi7z48WuMzw0Hnbi7x3kTSch5GptrVm2tsSwriKhZOAX4thS0RFW2udr2J2KfT0+mnjrVH6X/2pQ7iV8PseU9v8DnE4HVxsY0ghH8rX7H/yKDB4fPdbKlhWqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092360; c=relaxed/simple;
	bh=JobbWyi35dBaTRlOiDrSW0ff78dEI0J9IcQnpnC8bXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kD5vmOJJ1u3bAoXx8S4U4V9LVcrnW720b9m6W5MnMy/8Enhua3bF97MS5aWoZ5yB0NO8SfV799L/U20LnKgjrJDAqH9X40wjN2ejMrlaF5OgFzYdrx3qL/2GD/LjgcEYbtlWPOxNCDWkbNXEpImUsHeM5awq6V2kjbbU8fgEMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bSaW7WNK; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bSaW7WNK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769092352; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z0T0NHnnLOBXCB1Q9RaOjVenK8UxFN8ICt7x482Hlzk=;
	b=bSaW7WNKKGPW9wt6OyuuShqFHNBVTdc0ReDV3QaBUkuoA/joYnDTRJvEYfIGWNSBcPu+eLULNhwU6HVJXQkRG8Z2KLr0RI/c73rx4ldeGflYh+i3bD5HpYccac1wwwQmLFoKz2v5u5JEs9IyPs1/S9a/r5rlQ0fdAOZs9WKz1h8=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0Wxcfz.h_1769092350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 22:32:32 +0800
From: fangyu.yu@linux.alibaba.com
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com
Cc: guoren@kernel.org,
	ajones@ventanamicro.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v2] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
Date: Thu, 22 Jan 2026 22:32:24 +0800
Message-Id: <20260122143224.25146-1-fangyu.yu@linux.alibaba.com>
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

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

---
    Changes in v2:
    - Reworked the patch formatting (per Drew).
    - Fixed the call site of riscv_iommu_iodir_iotinval() (per Drew).
    - Moved riscv_iommu_cmd_inval_vma() out of the conditional blocks to avoid
      duplication (per Guoren).
    - Dropped the #if 0-guarded code (per Guoren).
    - Updated the Fixes: tag (per Drew).
    - Link to v1:
      https://lore.kernel.org/linux-riscv/20260108134855.91341-1-fangyu.yu@linux.alibaba.com/
---
 drivers/iommu/riscv/iommu.c | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d9429097a2b5..c762b4f335d1 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -996,7 +996,67 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 }
 
 #define RISCV_IOMMU_FSC_BARE 0
+/*
+ * This function sends IOTINVAL commands as required by the RISC-V
+ * IOMMU specification (Section 6.3.1 and 6.3.2 in 1.0 spec version)
+ * after modifying DDT or PDT entries
+ */
+static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
+				       bool inval_pdt, unsigned long iohgatp,
+				       struct riscv_iommu_dc *dc,
+				       struct riscv_iommu_pc *pc)
+{
+	struct riscv_iommu_command cmd;
+
+	riscv_iommu_cmd_inval_vma(&cmd);
 
+	if (FIELD_GET(RISCV_IOMMU_DC_IOHGATP_MODE, iohgatp) ==
+	    RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+		if (inval_pdt) {
+			/*
+			 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
+			 * PSCID=PC.PSCID
+			 */
+			riscv_iommu_cmd_inval_set_pscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
+		} else {
+			if (!FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) &&
+			    FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc->fsc) !=
+			    RISCV_IOMMU_DC_FSC_MODE_BARE) {
+				/*
+				 * DC.tc.PDTV == 0 && DC.fsc.MODE != Bare
+				 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
+				 * PSCID=DC.ta.PSCID
+				 */
+				riscv_iommu_cmd_inval_set_pscid(&cmd,
+					FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, dc->ta));
+			}
+			/* else: IOTINVAL.VMA with GV=AV=PSCV=0 */
+		}
+	} else {
+		riscv_iommu_cmd_inval_set_gscid(&cmd,
+			FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
+
+		if (inval_pdt) {
+			/*
+			 * IOTINVAL.VMA with GV=1, AV=0, and PSCV=1, and
+			 * GSCID=DC.iohgatp.GSCID, PSCID=PC.PSCID
+			 */
+			riscv_iommu_cmd_inval_set_pscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
+		}
+		/*
+		 * else: IOTINVAL.VMA with GV=1,AV=PSCV=0,and
+		 * GSCID=DC.iohgatp.GSCID
+		 *
+		 * IOTINVAL.GVMA with GV=1,AV=0,and
+		 * GSCID=DC.iohgatp.GSCID
+		 * TODO: For now, the Second-Stage feature have not yet been merged,
+		 * also issue IOTINVAL.GVMA once second-stage support is merged.
+		 */
+	}
+	riscv_iommu_cmd_send(iommu, &cmd);
+}
 /*
  * Update IODIR for the device.
  *
@@ -1031,6 +1091,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
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
 
@@ -1056,6 +1121,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
 		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
 		riscv_iommu_cmd_send(iommu, &cmd);
+		/*
+		 * For now, the SVA and PASID features have not yet been merged, the
+		 * default configuration is inval_pdt=false and pc=NULL.
+		 */
+		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
 	}
 
 	riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
-- 
2.50.1

