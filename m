Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6D455629
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468031; cv=none; b=JCDoM+PD7RFHRtPxIXsu4jVuPySKnPXvusI2d/f9StKK5Ek6x6BioMK26yaRkCcp02GNilOt013kcn27dvU1ieiz/bXgSDkt11j8faOOumF7bjAeSgndcfMLhEjL2P7GBLJjxcszKPZdfZss4aDH7zteWhZG8Zg1ZyADSeAqtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468031; c=relaxed/simple;
	bh=rsbOrAGpRXjwwIzZpnFKQ88x6EzMGUEiU6TMUWBTNRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FA8JrJauePrHcH3f7Lc0RWbsJKcPOOuJ+hbZxoIhc4RueWFgZKkBU5UqH9gnrY97RviPHqvJAS6Dc8iI1p40csgsa8rL6Cuf5tSCQPTy/CntKcurtEkqHjJWtO0PvFDiaWm5YrqdIInVjRnUBPy4oLEQr5OREatyIyeeT9OSD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ev0mUcAu; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ev0mUcAu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791468025; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=93BVwpudh4+6W0qoTe/2j6yMDK/FgOj3lLkwHPIbyr4=;
	b=Ev0mUcAuGUkkJHF4h0IFVQJpWiY/7DxdZv41uiY6oG/2J+uOxdE1ukVqEssJM8C+p89rAiQ+htCW5V9+KbPo2aecQt234hR8X9D4vMJjv2CFShuEitYpC4hrk/pvuOnIXVcYicfKE+x0LEZBgCalNSzTNxjOGCpklYq23TS0j7s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XCQTvmZ_1791468023;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XCQTvmZ_1791468023 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 22:00:24 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com,
	jgg@nvidia.com,
	jgg@ziepe.ca
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH 3/3] iommu/riscv: Support IRQ forwarding without MSI page tables
Date: Thu,  8 Oct 2026 22:00:01 +0800
Message-Id: <20261008140001.94508-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261008140001.94508-1-fangyu.yu@linux.alibaba.com>
References: <20261008140001.94508-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

IOMMU implementations without the MSI_FLAT capability have no MSI page
table, and their MSI writes are translated by the second-stage page
table. Forward interrupts there by mapping the guest IMSIC GPA to the
host IMSIC HPA in the second-stage domain, so device MSI writes reach
the vCPU's interrupt file directly.

Dispatch on the IOMMU capabilities in the IRQ forwarding entry: with
MSI_FLAT nothing changes; without it, validate that every target is an
IMSIC page in the guest MSI address window, install the GPA mappings,
and replace the leaf PTE when a vCPU migration moves the VS-file host
page. Mappings persist for the lifetime of the domain; disabling
forwarding or a failed operation only drops the per-IRQ state so the
IRQ falls back to host delivery.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu-ir.c | 157 ++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index b96baff9986d..5f3a909c2206 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -271,14 +271,160 @@ static int riscv_iommu_ir_update_target(struct riscv_iommu_msi_table *msi_table,
 	return 0;
 }
 
-static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
+static int riscv_iommu_ir_validate_noflat_target(const struct riscv_iommu_ir_vcpu_info *vcpu_info,
+						 const struct riscv_iommu_ir_target *target)
+{
+	u64 addr = target->gpa >> IMSIC_MMIO_PAGE_SHIFT;
+
+	if (!IS_ALIGNED(target->gpa, IMSIC_MMIO_PAGE_SZ) ||
+	    (addr & ~vcpu_info->msi_addr_mask) != vcpu_info->msi_addr_pattern)
+		return -EINVAL;
+
+	/* Without MSI_FLAT there is no MSI page table, so only IMSIC targets work. */
+	if (target->type != RISCV_IOMMU_IR_TARGET_IMSIC)
+		return -EOPNOTSUPP;
+
+	if (!IS_ALIGNED(target->hpa, IMSIC_MMIO_PAGE_SZ) ||
+	    (target->hpa >> IMSIC_MMIO_PAGE_SHIFT) > FIELD_MAX(RISCV_IOMMU_MSIPTE_PPN))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Caller must hold msi_table->lock. */
+static int riscv_iommu_ir_map_guest_imsic(struct riscv_iommu_msi_table *msi_table,
+					  const struct riscv_iommu_ir_target *target)
+{
+	unsigned long index = target->gpa >> IMSIC_MMIO_PAGE_SHIFT;
+	struct riscv_iommu_noflat_imsic *imsic;
+	int ret;
+
+	imsic = xa_load(&msi_table->noflat_imsics, index);
+	if (imsic) {
+		if (imsic->hpa == target->hpa)
+			return 0;
+
+		ret = riscv_iommu_msi_table_replace_gpa_leaf(msi_table, target->gpa,
+							     imsic->hpa, target->hpa);
+		if (ret)
+			return ret;
+	} else {
+		imsic = kzalloc_obj(*imsic, GFP_ATOMIC);
+		if (!imsic)
+			return -ENOMEM;
+
+		ret = xa_err(xa_store(&msi_table->noflat_imsics, index, imsic,
+				      GFP_ATOMIC));
+		if (ret) {
+			kfree(imsic);
+			return ret;
+		}
+
+		ret = riscv_iommu_msi_table_map_gpa(msi_table, target->gpa, target->hpa);
+		if (ret) {
+			xa_erase(&msi_table->noflat_imsics, index);
+			kfree(imsic);
+			return ret;
+		}
+	}
+
+	imsic->hpa = target->hpa;
+	riscv_iommu_msi_table_inval(msi_table, target->gpa);
+	return 0;
+}
+
+static int riscv_iommu_ir_activate_noflat(struct riscv_iommu_msi_table *msi_table,
+					  struct riscv_iommu_ir_vcpu_info *vcpu_info)
+{
+	int ret;
+
+	ret = riscv_iommu_ir_validate_vcpu_info(vcpu_info);
+	if (ret)
+		return ret;
+
+	if (!vcpu_info->targets || !vcpu_info->nr_targets)
+		return -EINVAL;
+
+	for (unsigned int i = 0; i < vcpu_info->nr_targets; i++) {
+		ret = riscv_iommu_ir_validate_noflat_target(vcpu_info, &vcpu_info->targets[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (unsigned int i = 0; i < vcpu_info->nr_targets; i++) {
+		ret = riscv_iommu_ir_map_guest_imsic(msi_table, &vcpu_info->targets[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int riscv_iommu_ir_update_target_noflat(struct riscv_iommu_msi_table *msi_table,
+					       struct riscv_iommu_ir_vcpu_info *vcpu_info)
+{
+	const struct riscv_iommu_ir_target *target = &vcpu_info->target;
+	int ret;
+
+	ret = riscv_iommu_ir_validate_vcpu_info(vcpu_info);
+	if (ret)
+		return ret;
+
+	ret = riscv_iommu_ir_validate_noflat_target(vcpu_info, target);
+	if (ret)
+		return ret;
+
+	if (!xa_load(&msi_table->noflat_imsics, target->gpa >> IMSIC_MMIO_PAGE_SHIFT))
+		return -EINVAL;
+
+	return riscv_iommu_ir_map_guest_imsic(msi_table, target);
+}
+
+static int riscv_iommu_ir_irq_set_vcpu_affinity_noflat(struct irq_data *data,
 						       struct riscv_iommu_info *info,
 						       struct riscv_iommu_ir_vcpu_info *vcpu_info,
 						       struct riscv_iommu_msi_table *msi_table)
+{
+	int ret;
+
+	if (!vcpu_info) {
+		/* Mappings persist; only the per-IRQ forwarding state is dropped. */
+		if (irqd_is_forwarded_to_vcpu(data)) {
+			irqd_clr_forwarded_to_vcpu(data);
+			info->nr_forwarded_irqs--;
+		}
+		return 0;
+	}
+
+	ret = vcpu_info->cmd == RISCV_IOMMU_IR_FORWARD ?
+		riscv_iommu_ir_activate_noflat(msi_table, vcpu_info) :
+		riscv_iommu_ir_update_target_noflat(msi_table, vcpu_info);
+	if (!ret) {
+		if (!irqd_is_forwarded_to_vcpu(data)) {
+			irqd_set_forwarded_to_vcpu(data);
+			info->nr_forwarded_irqs++;
+		}
+	} else if (irqd_is_forwarded_to_vcpu(data)) {
+		irqd_clr_forwarded_to_vcpu(data);
+		info->nr_forwarded_irqs--;
+	}
+
+	return ret;
+}
+
+static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
+						       struct riscv_iommu_info *info,
+						       struct riscv_iommu_ir_vcpu_info *vcpu_info,
+						       struct riscv_iommu_msi_table *msi_table,
+						       bool noflat)
 {
 	struct riscv_iommu_device *iommu = data->domain->host_data;
 	int ret;
 
+	if (noflat)
+		return riscv_iommu_ir_irq_set_vcpu_affinity_noflat(data, info,
+								    vcpu_info, msi_table);
+
 	if (!vcpu_info) {
 		if (WARN_ON_ONCE(!msi_table->nr_forwarded_irqs || !info->nr_forwarded_irqs))
 			return -EINVAL;
@@ -332,10 +478,12 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
 static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg)
 {
 	struct riscv_iommu_ir_vcpu_info *vcpu_info = arg;
+	struct riscv_iommu_device *iommu = data->domain->host_data;
 	struct riscv_iommu_msi_table *msi_table;
 	struct riscv_iommu_info *info;
 	struct msi_desc *desc;
 	struct device *dev;
+	bool noflat;
 	int ret;
 
 	if (!vcpu_info && !irqd_is_forwarded_to_vcpu(data))
@@ -354,6 +502,8 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 	if (WARN_ON_ONCE(!info))
 		return -EINVAL;
 
+	noflat = !(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT);
+
 	scoped_guard(rcu) {
 		/*
 		 * RCU keeps the table alive, but the device may switch domains before
@@ -361,7 +511,7 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 		 */
 		for (;;) {
 			msi_table = riscv_iommu_msi_table_rcu(info);
-			if (!msi_table || !msi_table->root)
+			if (!msi_table || (!noflat && !msi_table->root))
 				return -EOPNOTSUPP;
 
 			raw_spin_lock(&msi_table->lock);
@@ -371,7 +521,8 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 		}
 	}
 
-	ret = riscv_iommu_ir_irq_set_vcpu_affinity_locked(data, info, vcpu_info, msi_table);
+	ret = riscv_iommu_ir_irq_set_vcpu_affinity_locked(data, info, vcpu_info,
+							  msi_table, noflat);
 	raw_spin_unlock(&msi_table->lock);
 
 	return ret;
-- 
2.50.1

