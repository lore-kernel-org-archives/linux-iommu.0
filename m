Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692C4A2A72
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047187; cv=none; b=AXhygyliRKga29OdYU8ohjrcnhRXlZ0F2Rne5w/hEu5xe0kjQQi2LH5x2D/vI8dbrgl/T8uENbR2sEHB6SHLJ39fATDFbq1ViDJMmxwzmCS4cSjrfNGy3R95mE8Ioc1XsJOZamzCpVDGBNQB0vovXhT1xaAGnt/vuCUC3xao6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047187; c=relaxed/simple;
	bh=bnQZBmPqb2gVIFMuYl1TCmL/8dsJ9MatQerVGaTX/Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqCgrv5HzT7Y+tbJ79Ns0VlanjUJlEFl74rgxcWYC1Hv4dMvI+Jzaq2FKp8FECZFgTV4lBnHjMMQTaPpEWuNcEcE8CV3P2UgQ4xkvF1C1YLvNTd1iEhwSAO3iu5/7tRY1cPGrcPlMkUAnb2qtOVbNEc/tXutLthavQnIGTd/0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4zKl2GgNz5B15S;
	Thu, 15 Oct 2026 14:52:59 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 69F6qkRW013978;
	Thu, 15 Oct 2026 14:52:46 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:48 +0800
X-Zmail-TransId: 3e816ad0783f024-555d7
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
Subject: [RFC PATCH 12/12] RISC-V: KVM: Forward MSIs for guests with a vIOMMU
Date: Thu, 15 Oct 2026 14:52:32 +0800
Message-ID: <20261015065232.604503-13-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 69F6qkRW013978
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 15 Oct 2026 14:52:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD0784B.001/4j4zKl2GgNz5B15S

The IRQ bypass names the target vCPU by matching the device MSI address
against the guest IMSIC addresses of the vCPUs, so it only works when the
guest programs the device with those addresses directly. A guest with a
vIOMMU programs an address from its own IOVA space instead, which the
IOMMU resolves through the guest stage-1 page tables before it looks the
address up in the MSI table, so no vCPU can be named at that point.

Falling back to host delivery is not an option either. The device would
keep the host IMSIC address composed at vector activation, and the
guest's own stage-1 page tables do not map it, so its MSIs fault instead
of reaching an interrupt file.

The MSI table already holds the VM-wide IMSIC topology, so the hardware
finds the target vCPU by itself once the address is translated. Forward
such IRQs for the whole VM and program the device with the MSI message
composed by the guest.

Such a producer can reach any vCPU of the VM, so unforward it whenever a
VS-file is released and retarget it whenever a vCPU migrates.

Co-developed-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 arch/riscv/kvm/aia_imsic.c | 67 +++++++++++++++++++++++++++-----------
 include/linux/kvm_irqfd.h  |  2 ++
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 010f9a90f107..862db53c66a5 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -758,7 +758,7 @@ int kvm_riscv_irqfd_unforward(struct kvm_kernel_irqfd *irqfd)
 
 	lockdep_assert_held(&kvm->irqfds.lock);
 
-	if (!irqfd->irq_bypass_vcpu)
+	if (!irqfd->irq_bypass_vcpu && !irqfd->irq_bypass_nested)
 		return 0;
 
 	irq_data = irq_get_irq_data(irqfd->producer->irq);
@@ -775,6 +775,7 @@ int kvm_riscv_irqfd_unforward(struct kvm_kernel_irqfd *irqfd)
 		return ret;
 
 	irqfd->irq_bypass_vcpu = NULL;
+	irqfd->irq_bypass_nested = false;
 	return 0;
 }
 
@@ -788,7 +789,11 @@ static int imsic_vcpu_unforward(struct kvm_vcpu *vcpu)
 	guard(spinlock_irqsave)(&kvm->irqfds.lock);
 
 	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
-		if (irqfd->irq_bypass_vcpu != vcpu)
+		/*
+		 * Nested-forwarded producers can target any vCPU of the VM,
+		 * unforward them on any VS-file release.
+		 */
+		if (!irqfd->irq_bypass_nested && irqfd->irq_bypass_vcpu != vcpu)
 			continue;
 
 		ret = kvm_riscv_irqfd_unforward(irqfd);
@@ -902,7 +907,7 @@ static int imsic_vsfile_target_replace(struct kvm_vcpu *vcpu, phys_addr_t vsfile
 	vcpu_info.target.type = RISCV_IOMMU_IR_TARGET_IMSIC;
 	vcpu_info.target.hpa = vsfile_pa;
 	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
-		if (!irqfd->irq_bypass_vcpu)
+		if (!irqfd->irq_bypass_vcpu && !irqfd->irq_bypass_nested)
 			continue;
 
 		ret = irq_set_vcpu_affinity(irqfd->producer->irq, &vcpu_info);
@@ -931,16 +936,10 @@ static bool imsic_targets_valid(struct kvm_aia *aia)
 	return true;
 }
 
-static struct kvm_vcpu *imsic_irqfd_route_vcpu(struct kvm *kvm,
-					       struct kvm_kernel_irq_routing_entry *irq_entry)
+static struct kvm_vcpu *imsic_irqfd_route_vcpu(struct kvm *kvm, gpa_t target)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long index;
-	gpa_t target;
-
-	target = ((gpa_t)irq_entry->msi.address_hi << 32) | irq_entry->msi.address_lo;
-	if (target & (IMSIC_MMIO_PAGE_SZ - 1))
-		return NULL;
 
 	kvm_for_each_vcpu(index, vcpu, kvm) {
 		if (target == vcpu->arch.aia_context.imsic_addr)
@@ -968,6 +967,9 @@ static int imsic_irqfd_forward(struct kvm_kernel_irqfd *irqfd,
 		.data = irq_entry->msi.data,
 	};
 	struct kvm_vcpu *vcpu;
+	gpa_t target, gpa;
+	unsigned int i;
+	bool nested = false;
 	int ret;
 
 	lockdep_assert_held(&kvm->irqfds.lock);
@@ -988,24 +990,51 @@ static int imsic_irqfd_forward(struct kvm_kernel_irqfd *irqfd,
 	 * The IOMMU writes MSIs straight into the VS-file, so bypass is
 	 * gated by the hardware backing checks below, not the AIA mode.
 	 */
-	if (!imsic_targets_valid(&kvm->arch.aia)) {
-		pr_debug("KVM: IMSIC IRQ bypass requires all VS-files\n");
+	target = ((gpa_t)irq_entry->msi.address_hi << 32) | irq_entry->msi.address_lo;
+	if (target & (IMSIC_MMIO_PAGE_SZ - 1))
 		return -EOPNOTSUPP;
-	}
 
-	/* Leave guest messages that name no vIMSIC to software injection. */
-	vcpu = imsic_irqfd_route_vcpu(kvm, irq_entry);
-	if (!vcpu)
-		return -EOPNOTSUPP;
+	vcpu = imsic_irqfd_route_vcpu(kvm, target);
+	if (vcpu) {
+		/*
+		 * The guest programmed a guest interrupt file address, so every
+		 * vCPU of the VM must be hardware backed for the complete
+		 * topology to be installable.
+		 */
+		if (!imsic_targets_valid(aia)) {
+			pr_debug("KVM: IMSIC IRQ bypass requires all VS-files\n");
+			return -EOPNOTSUPP;
+		}
+		gpa = vcpu->arch.aia_context.imsic_addr;
+	} else {
+		/*
+		 * A vIOMMU guest programs the device with an IOVA-space MSI
+		 * address, which names no vCPU until the IOMMU translates it
+		 * and resolves the target through its MSI table of published
+		 * VS-files. Forward such IRQs for the whole VM. The address
+		 * pattern comes from any published target, as only the
+		 * mask-covered index bits differ between them.
+		 */
+		for (i = 0; i < aia->nr_targets; i++)
+			if (aia->targets[i].type == RISCV_IOMMU_IR_TARGET_IMSIC)
+				break;
+		if (i == aia->nr_targets)
+			return -EOPNOTSUPP;
+		gpa = aia->targets[i].gpa;
+		nested = true;
+	}
 
-	vcpu_info.msi_addr_pattern = (vcpu->arch.aia_context.imsic_addr >> IMSIC_MMIO_PAGE_SHIFT) &
+	vcpu_info.msi_addr_pattern = (gpa >> IMSIC_MMIO_PAGE_SHIFT) &
 				     ~vcpu_info.msi_addr_mask;
 	ret = irq_set_vcpu_affinity(irqfd->producer->irq, &vcpu_info);
 	if (ret)
 		return ret;
 
 	pci_write_msi_msg(irqfd->producer->irq, &msg);
-	irqfd->irq_bypass_vcpu = vcpu;
+	if (nested)
+		irqfd->irq_bypass_nested = true;
+	else
+		irqfd->irq_bypass_vcpu = vcpu;
 
 	return 0;
 }
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index ef8c134ded8a..39c73157e086 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -60,6 +60,8 @@ struct kvm_kernel_irqfd {
 	struct irq_bypass_producer *producer;
 
 	struct kvm_vcpu *irq_bypass_vcpu;
+	/* Forwarded to any vCPU of the VM (guest-controlled MSI target) */
+	bool irq_bypass_nested;
 	struct list_head vcpu_list;
 	void *irq_bypass_data;
 };
-- 
2.53.0

