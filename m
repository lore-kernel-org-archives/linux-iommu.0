Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA049BD71
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047174; cv=none; b=mL9mOF+6iSDISSEZ2+Z7XMoXtE9cL6m0x90uZNEDsqa1MfFNJLqOPiTb8+5PF8FZiKIoz9zAOIIbdyRcI06zcH26UO++vym0wKiwNHHtlVwx4oZeMOi5KG6/BBYxB2xdUT6vdizYtLPKUIqXAMLZcJFAoV8aTnz+4pqEud5o/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047174; c=relaxed/simple;
	bh=/JqqW7i0cNKn0rI90xuYJGoNPOR9ACUOHZDDtXSE4wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLl8i6p9rwogSGHxxTCpHGrVGKqqeyYGTgo25XhVU+D02v2dGQ1S6j8MOP5R26qjcnpm4PZzEkC0QlunSPMDgVYgGSOZw7+UQ34sto+gwWcdBqtRGR1LyoNBi67u4SV2cAcrUL/LdVGUNd1MGH5v6EEAtUCrKyMzQIqlEgtOoW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4zKS3B08z8XrrZ;
	Thu, 15 Oct 2026 14:52:44 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 69F6qaqI013845;
	Thu, 15 Oct 2026 14:52:36 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:38 +0800
X-Zmail-TransId: 3e816ad07836024-554b9
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Tomasz Jeznach <tomasz.jeznach@linux.dev>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>,
        Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>,
        Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 01/12] iommu/riscv: Use DC.tc.V as the device context valid bit
Date: Thu, 15 Oct 2026 14:52:21 +0800
Message-ID: <20261015065232.604503-2-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
References: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 69F6qaqI013845
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 15 Oct 2026 14:52:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD0783C.000/4j4zKS3B08z8XrrZ

riscv_iommu_iodir_update() used bit 0 of the translation attributes
argument as the "device context valid" flag. Now that it takes a full
device context, take the validity bit from DC.tc.V.

The defined bits of the caller's DC.tc are no longer dropped. This is
not a functional change for the existing callers: the paging and identity
domains set V, and the blocking domain leaves the context invalid. Nested
translation needs those bits to reach the hardware.

Use the DC prefixed field macros for device context fields while here,
instead of the PC (process context) ones.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu-bits.h |  6 ++++++
 drivers/iommu/riscv/iommu.c      | 26 ++++++++++++--------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 51a2e660b06a..2a8230a0c1bb 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -348,6 +348,12 @@ struct riscv_iommu_dc {
 #define RISCV_IOMMU_DC_TC_SBE		BIT_ULL(10)
 #define RISCV_IOMMU_DC_TC_SXL		BIT_ULL(11)
 
+/*
+ * All bits of dc.tc as defined by the spec. Bits 12-23 and 32-63
+ * are reserved for future standard use, bits 24-31 are for custom use.
+ */
+#define RISCV_IOMMU_DC_TC_DEFINED	GENMASK_ULL(11, 0)
+
 /* Second-stage (aka G-stage) context fields */
 #define RISCV_IOMMU_DC_IOHGATP_PPN	RISCV_IOMMU_ATP_PPN_FIELD
 #define RISCV_IOMMU_DC_IOHGATP_GSCID	GENMASK_ULL(59, 44)
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 55c167df2c2e..dd97c2731d95 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1218,7 +1218,6 @@ void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
 	riscv_iommu_iotlb_inval(domain, &gather);
 }
 
-#define RISCV_IOMMU_FSC_BARE 0
 /*
  * This function sends IOTINVAL commands as required by the RISC-V
  * IOMMU specification (Section 6.3.1 and 6.3.2 in 1.0 spec version)
@@ -1329,16 +1328,14 @@ static void riscv_iommu_iodir_update(struct device *dev, struct riscv_iommu_dc *
 		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
 
 	/*
-	 * For device context with DC_TC_PDTV = 0, translation attributes valid bit
-	 * is stored as DC_TC_V bit (both sharing the same location at BIT(0)).
+	 * Only defined bits are writable by the driver.
 	 */
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
-		tc = READ_ONCE(dc->tc);
-		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
+		tc = new_dc->tc & RISCV_IOMMU_DC_TC_DEFINED;
 
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
-		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_DC_TA_PSCID);
 		WRITE_ONCE(dc->iohgatp, new_dc->iohgatp);
 		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT) {
 			WRITE_ONCE(dc->msiptp, new_dc->msiptp);
@@ -1600,11 +1597,11 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
 			return -ENODEV;
 
-		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
-			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
+		dc.fsc = FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, pt_info.fsc_iosatp_mode) |
+			 FIELD_PREP(RISCV_IOMMU_DC_FSC_PPN, pt_info.ppn);
 	}
-	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
-	     RISCV_IOMMU_PC_TA_V;
+	dc.ta = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
+	dc.tc |= RISCV_IOMMU_DC_TC_V;
 
 	bond = kzalloc_obj(*bond);
 	if (!bond)
@@ -1773,9 +1770,10 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_dc dc = {0};
 	unsigned long flags;
 
-	dc.fsc = RISCV_IOMMU_FSC_BARE;
+	dc.fsc = RISCV_IOMMU_DC_FSC_MODE_BARE;
+	dc.tc = 0;
 
-	/* Make device context invalid, translation requests will fault w/ #258 */
+	/* Make device context invalid (DC.tc.V = 0), translation requests will fault w/ #258 */
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	info->dc = dc;
 	riscv_iommu_iodir_update(dev, &info->dc);
@@ -1801,8 +1799,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_dc dc = {0};
 	unsigned long flags;
 
-	dc.fsc = RISCV_IOMMU_FSC_BARE;
-	dc.ta = RISCV_IOMMU_PC_TA_V;
+	dc.fsc = RISCV_IOMMU_DC_FSC_MODE_BARE;
+	dc.tc = RISCV_IOMMU_DC_TC_V;
 
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	info->dc = dc;
-- 
2.53.0

