Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90849CF5E
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047179; cv=none; b=QZk+0AylhmN3q0x9K5tHtIcZXIkk+xZR9tPIp/cvcHtLVh1mznfhZ1fzdnjndo4Lt3scFQ90xah0Z3m2vI+SF9jn2rL2exRcih9aIeIcdTail8ekZCwcVcQFcEYP9MNR3KhQf9rtiFDehQO1qXr0oHaTU1ImycJAsyW+y/dWykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047179; c=relaxed/simple;
	bh=xj7tEyWsDh0qOMU0cT+sYjEgExjch6qY6SM8S+w1YG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5B3LuqbTi3XqhDtJRjN0x527HUjBEWt/1lqKXW3wOHenzSa3KVuz0p9G6mHqTSVMIwrc5JcZbnhtB4/nV3JC/8UIc09K0VQG/drZJ5yZRFwJCc2gotFjIo0R2oZsqGsmVDTo6k/G/Kh181SEVF1eJjVYugfRjKUSyQ9NHZAxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4zKW6xnbz5B150;
	Thu, 15 Oct 2026 14:52:47 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl1.zte.com.cn with SMTP id 69F6qhI5013949;
	Thu, 15 Oct 2026 14:52:43 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:46 +0800
X-Zmail-TransId: 3e816ad0783d024-5558a
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
Subject: [RFC PATCH 09/12] iommu/riscv: Add riscv_iommu_attach_dev_nested
Date: Thu, 15 Oct 2026 14:52:29 +0800
Message-ID: <20261015065232.604503-10-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 69F6qhI5013949
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 15 Oct 2026 14:52:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD0783F.000/4j4zKW6xnbz5B150

From: Wu Fei <wu.fei9@sanechips.com.cn>

Attach a device to a nested domain by combining the guest-provided
stage-1 context (tc, iosatp) with the host-owned second-stage context
in the device directory entry.

The device is bonded to the stage-2 parent domain so that it shares the
parent's invalidation and interrupt-remapping state: the guest MSI page
table is allocated when missing, and an active table's MSI configuration
is preserved across the device context update. Since the iommu core
passes the nested domain object as the old domain while the bond lives
on the parent, resolve the bond-holding domain before unlinking.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 89 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e59a6a97589e..a484bf97c2f5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -871,6 +871,13 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 #define iommu_domain_to_riscv(iommu_domain) \
 	container_of(iommu_domain, struct riscv_iommu_domain, domain)
 
+/*
+ * Resolve the domain holding the device bond: when the previously attached
+ * domain is a nested domain, the device is bonded to its stage-2 parent,
+ * which also owns the MSI table.
+ */
+static struct iommu_domain *riscv_iommu_old_bond_domain(struct iommu_domain *old);
+
 struct riscv_iommu_msi_table *riscv_iommu_msi_table_rcu(struct riscv_iommu_info *info)
 {
 	struct riscv_iommu_domain *domain;
@@ -1593,6 +1600,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	unsigned long flags;
 	int ret;
 
+	old = riscv_iommu_old_bond_domain(old);
+
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
 	if (domain->gscid) {
@@ -1787,6 +1796,8 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_dc dc = {0};
 	unsigned long flags;
 
+	old = riscv_iommu_old_bond_domain(old);
+
 	dc.fsc = RISCV_IOMMU_DC_FSC_MODE_BARE;
 	dc.tc = 0;
 
@@ -1816,6 +1827,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_dc dc = {0};
 	unsigned long flags;
 
+	old = riscv_iommu_old_bond_domain(old);
+
 	dc.fsc = RISCV_IOMMU_DC_FSC_MODE_BARE;
 	dc.tc = RISCV_IOMMU_DC_TC_V;
 
@@ -1938,8 +1951,79 @@ struct riscv_iommu_nested_domain {
 	u64 iosatp;
 };
 
-#define to_riscv_iommu_nested_domain(domain) \
-	container_of(domain, struct riscv_iommu_nested_domain, domain)
+#define to_riscv_iommu_nested_domain(domain_ptr) \
+	container_of(domain_ptr, struct riscv_iommu_nested_domain, domain)
+
+static struct iommu_domain *riscv_iommu_old_bond_domain(struct iommu_domain *old)
+{
+	if (old && old->type == IOMMU_DOMAIN_NESTED)
+		return &to_riscv_iommu_nested_domain(old)->viommu->s2_parent->domain;
+	return old;
+}
+
+static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain,
+					 struct device *dev,
+					 struct iommu_domain *old_domain)
+{
+	struct riscv_iommu_nested_domain *nested_domain =
+		to_riscv_iommu_nested_domain(domain);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_domain *s2_parent = nested_domain->viommu->s2_parent;
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct pt_iommu_riscv_64_hw_info pt_info;
+	struct iommu_domain *old = riscv_iommu_old_bond_domain(old_domain);
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_dc dc = {0};
+	unsigned long flags;
+	int ret;
+
+	if (nested_domain->viommu->iommu != iommu)
+		return -EINVAL;
+
+	if (!s2_parent->nest_parent)
+		return -EINVAL;
+
+	pt_iommu_riscv_64_hw_info(&s2_parent->riscvpt, &pt_info);
+
+	dc.tc = nested_domain->tc;
+	dc.fsc = nested_domain->iosatp;
+
+	dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
+		     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn) |
+		     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, s2_parent->gscid);
+
+	/* SVA/PASID are not supported now, keep PSCID at 0. */
+	dc.ta = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, 0);
+
+	ret = riscv_iommu_msi_table_alloc(s2_parent, iommu, info);
+	if (ret)
+		return ret;
+
+	bond = kzalloc_obj(*bond);
+	if (!bond)
+		return -ENOMEM;
+	bond->dev = dev;
+
+	flags = riscv_iommu_msi_tables_lock(old, &s2_parent->domain);
+	if (!riscv_iommu_can_attach_paging_domain(&s2_parent->domain, dev, old)) {
+		riscv_iommu_msi_tables_unlock(old, &s2_parent->domain, flags);
+		kfree(bond);
+		return -EBUSY;
+	}
+
+	/* Keep an active guest MSI table published across the DC update. */
+	if (s2_parent->msi_table.nr_forwarded_irqs)
+		riscv_iommu_msi_table_set_dc(&s2_parent->msi_table, &dc, true);
+
+	info->dc = dc;
+	riscv_iommu_bond_link(s2_parent, bond);
+	riscv_iommu_iodir_update(dev, &info->dc);
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, s2_parent);
+	riscv_iommu_msi_tables_unlock(old, &s2_parent->domain, flags);
+
+	return 0;
+}
 
 static void riscv_iommu_domain_nested_free(struct iommu_domain *domain)
 {
@@ -1947,6 +2031,7 @@ static void riscv_iommu_domain_nested_free(struct iommu_domain *domain)
 }
 
 static const struct iommu_domain_ops riscv_iommu_nested_ops = {
+	.attach_dev = riscv_iommu_attach_dev_nested,
 	.free = riscv_iommu_domain_nested_free,
 };
 
-- 
2.53.0

