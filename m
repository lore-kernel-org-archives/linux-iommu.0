Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254311;
	b=XJTGBgozmrzqlj1AxROaxfnh/SOeC/1RCebmMpFLC0wAYeGLzwSxtwNc9oVWcEcgXrMg
	 RopVvPCwzh2B6jwCFXy79qdvtL3AyrmPvnD+xaWognLd5rJrAtPAU4sToSz54vYW3+0xh
	 EJoaPq8iYwAsllYfzPo7LXWB/8WpgRCQBhjIxBn53VyU7pugOneI3u62DAKiEMBotEtED
	 GABxB849O/9uav6HXMCoGeWkb1c4CpHoloY2d8FEmI9Z3G2NjIPMHHVYOAMB3G835cloO
	 OVtCVRXqAtPIYdlDnhaviIKeqNO6Vdo2Bbkm9fIrqDjhmmShd9xMUdALEKwLv1i36BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254311;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=vJabha16XjqVKoBM+M5VzlBDy3ANP3Gdyed/2wde958=;
	b=0GX/hC/17yMV/ER7yGOuM4JPyo1gjHJMYVpDXf0apjLBa65Vxs2iTtRxVvkODGzcJ6RJ
	 ZnOd4ISlLboZ6kOLr9kyN/c1Zh2qzyF04D1MqvSdYpkTQ3EiBeBPp/T4AEiPyF8mQQvi/
	 4zuIkmDbik+knuKLWGI8RJoeIxXCSo6tt31D0XesDKVQnBAjtLfN0CNn72sUpPd1G0b0H
	 ePXp2nstuITNIgyKIH68OPxSShEiQNle9YCX55URzxG9B0EAUR/EustSS9bYo+1iGtICW
	 HjyTcVakc8j2THK7W1r8wWtefD0CKNxPOXCCeoSVFKRyuGt6FWxUn4sZWa3fCy2brWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C3606A330
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 761C3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYld6S2sz8Xrrh;
	Thu, 29 Oct 2026 14:11:41 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl2.zte.com.cn with SMTP id 69T6BWnN044396;
	Thu, 29 Oct 2026 14:11:32 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:34 +0800
X-Zmail-TransId: 3e816ae2e395027-e7ca8
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
Subject: [RFC PATCH v2 1/9] iommu/riscv: Use DC.tc.V as the device context valid bit
Date: Thu, 29 Oct 2026 14:11:23 +0800
Message-ID: <20261029061131.584453-2-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
References: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 69T6BWnN044396
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 29 Oct 2026 14:11:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E39D.001/4jFYld6S2sz8Xrrh

Previously, riscv_iommu_iodir_update() accepted only a partial device
context and used bit 0 of the translation attributes as the valid
flag. It also kept only GADE in DC.tc and dropped the other fields
needed to pass guest translation settings for nested domains.

Now that the function accepts a complete device context, take the
valid bit from DC.tc.V and copy all defined TC fields so the guest
configuration reaches the hardware.

Use the DC field macros for the remaining device context updates as
well.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu-bits.h |  6 ++++++
 drivers/iommu/riscv/iommu.c      | 28 ++++++++++++----------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 65d1f2250011..80c32f00ee5e 100644
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
index ca24d1b836d9..554361dd3159 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1132,7 +1132,6 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	rcu_read_unlock();
 }
 
-#define RISCV_IOMMU_FSC_BARE 0
 /*
  * This function sends IOTINVAL commands as required by the RISC-V
  * IOMMU specification (Section 6.3.1 and 6.3.2 in 1.0 spec version)
@@ -1243,18 +1242,14 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
 
 	/*
-	 * For device context with DC_TC_PDTV = 0, translation attributes valid bit
-	 * is stored as DC_TC_V bit (both sharing the same location at BIT(0)).
+	 * Only defined bits are writable by the driver.
 	 */
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
-		tc = READ_ONCE(dc->tc);
-		tc &= ~RISCV_IOMMU_DC_TC_GADE;
-		tc |= new_dc->tc & RISCV_IOMMU_DC_TC_GADE;
-		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
+		tc = new_dc->tc & RISCV_IOMMU_DC_TC_DEFINED;
 
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
-		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_DC_TA_PSCID);
 		WRITE_ONCE(dc->iohgatp, new_dc->iohgatp);
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
@@ -1373,11 +1368,11 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
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
 
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
@@ -1520,9 +1515,10 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
 
-	dc.fsc = RISCV_IOMMU_FSC_BARE;
+	dc.fsc = RISCV_IOMMU_DC_FSC_MODE_BARE;
+	dc.tc = 0;
 
-	/* Make device context invalid, translation requests will fault w/ #258 */
+	/* Make device context invalid (DC.tc.V = 0), translation requests will fault w/ #258 */
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
@@ -1545,8 +1541,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
 
-	dc.fsc = RISCV_IOMMU_FSC_BARE;
-	dc.ta = RISCV_IOMMU_PC_TA_V;
+	dc.fsc = RISCV_IOMMU_DC_FSC_MODE_BARE;
+	dc.tc = RISCV_IOMMU_DC_TC_V;
 
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
-- 
2.53.0

