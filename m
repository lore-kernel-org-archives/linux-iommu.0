Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100549CF5C
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047180; cv=none; b=OuQAkos8sM9tYJBD1+vQ++qvILW1JMIY+pe1hhmx/xyqPgvP3CQinfWof8nGA1TdV93Aknm1RjwPcmwko3cm9QHDn1VWU1YRPsFeHxkvp2NMvEbY9arWs/Pf7NvFvT/kyzLG7OkgNlwNTZ8bi/FMkJIuZ0KHrDi4tAaI3a+mQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047180; c=relaxed/simple;
	bh=+zKUNQj1OKpciozmBueicc9XhcAq8pJQcYxaDC6Alkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuxVglnq49LqBLwgWqb7Kw/RvhiOykyV9ewJ05MBLQTXLJZFzRgyeeWoLlNMaHuvCbgmiBqUcUZcn0QyY9EHwxuerAqbUbPAHfKA8ihCQswAUNnLICpfDcYSu22DHYSN1XpixyNgGMZVVvuL+tMRjZE8/3PhbxwISY8zTUeuHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4zKZ6Nw9z5B15M;
	Thu, 15 Oct 2026 14:52:50 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 69F6qjj2019179;
	Thu, 15 Oct 2026 14:52:45 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:47 +0800
X-Zmail-TransId: 3e816ad0783e024-555bd
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
Subject: [RFC PATCH 11/12] iommu/riscv: Accept unpublished interrupt files in IRQ forwarding
Date: Thu, 15 Oct 2026 14:52:31 +0800
Message-ID: <20261015065232.604503-12-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 69F6qjj2019179
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 15 Oct 2026 14:52:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD07842.000/4j4zKZ6Nw9z5B15M

A guest with a vIOMMU needs the complete IMSIC topology of the VM in the
MSI table, since the hardware resolves the target vCPU from the MSI
address on its own. That table is installed when the first device MSI is
forwarded, which can happen before every vCPU has its interrupt file
published, so a request for the whole VM cannot require all of them.

Skip the unpublished ones instead of rejecting the whole request. An MSI
that resolves to one of them faults only for that vCPU and is reported
in the fault queue, whereas a failed request would take IRQ bypass away
from the entire virtual machine.

Co-developed-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu-ir.c      | 25 +++++++++++++++++++++----
 include/linux/irqchip/riscv-imsic.h | 14 ++++++++------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index b3f0a56475ed..94971959a581 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -78,18 +78,28 @@ static int riscv_iommu_ir_validate_target(const struct riscv_iommu_ir_vcpu_info
 static int riscv_iommu_ir_validate_targets(const struct riscv_iommu_ir_vcpu_info *vcpu_info,
 					   size_t nr_ptes, u64 *required_caps)
 {
+	unsigned int nr_valid = 0;
 	int ret;
 
-	if (!vcpu_info->targets || !vcpu_info->nr_targets || vcpu_info->nr_targets > nr_ptes)
+	if (!vcpu_info->targets || !vcpu_info->nr_targets)
 		return -EINVAL;
 
 	for (unsigned int i = 0; i < vcpu_info->nr_targets; i++) {
+		/* Interrupt files the host has not published yet are skipped. */
+		if (vcpu_info->targets[i].type == RISCV_IOMMU_IR_TARGET_INVALID)
+			continue;
+
 		ret = riscv_iommu_ir_validate_target(vcpu_info, &vcpu_info->targets[i],
 						     required_caps);
 		if (ret)
 			return ret;
+		nr_valid++;
 	}
 
+	/* The table only has to be able to deliver some interrupt file. */
+	if (!nr_valid || nr_valid > nr_ptes)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -147,9 +157,16 @@ static int riscv_iommu_ir_activate(struct riscv_iommu_msi_table *msi_table,
 
 	for (unsigned int i = 0; i < vcpu_info->nr_targets; i++) {
 		const struct riscv_iommu_ir_target *target = &vcpu_info->targets[i];
-		size_t idx = riscv_iommu_ir_extract(target->gpa >> IMSIC_MMIO_PAGE_SHIFT,
-						    vcpu_info->msi_addr_mask);
-		struct riscv_iommu_msipte *msipte = &msi_table->root[idx];
+		size_t idx;
+		struct riscv_iommu_msipte *msipte;
+
+		/* Interrupt files the host has not published yet are skipped. */
+		if (target->type == RISCV_IOMMU_IR_TARGET_INVALID)
+			continue;
+
+		idx = riscv_iommu_ir_extract(target->gpa >> IMSIC_MMIO_PAGE_SHIFT,
+					     vcpu_info->msi_addr_mask);
+		msipte = &msi_table->root[idx];
 
 		/* A populated entry in the initially clear table indicates duplicate targets. */
 		if (msipte->pte || msipte->mrif_info) {
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 02a836ce03b4..947c406d512b 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -138,12 +138,14 @@ struct riscv_iommu_ir_target {
 };
 
 /*
- * FORWARD enables forwarding for one IRQ and provides the complete target array
- * so the first forwarded IRQ can initialize the domain MSI table. UPDATE_TARGET
- * replaces one target without changing per-IRQ forwarding state. The caller
- * must quiesce all MSI producers using the table when changing both words of a
- * live MRIF PTE because the update temporarily invalidates the entry. A NULL
- * vcpu_info disables forwarding for the IRQ.
+ * FORWARD enables forwarding for one IRQ and provides the target array so the
+ * first forwarded IRQ can initialize the domain MSI table. Entries of type
+ * RISCV_IOMMU_IR_TARGET_INVALID are skipped, so a caller may forward the whole
+ * virtual machine topology while only some of its interrupt files are hardware
+ * backed. UPDATE_TARGET replaces one target without changing per-IRQ forwarding
+ * state. The caller must quiesce all MSI producers using the table when
+ * changing both words of a live MRIF PTE because the update temporarily
+ * invalidates the entry. A NULL vcpu_info disables forwarding for the IRQ.
  *
  * A well-formed request which is incompatible with the producer or current
  * domain configuration returns -EOPNOTSUPP, allowing the caller to fall back
-- 
2.53.0

