Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FB2C326B
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892682; cv=none; b=rp+1kmd+KAcH4lUkl1EQD4NNqw0fSnUSDhJpePotFMx65tinBVHS+dOSn8p7JmwuU6Bm1nJSy/oaP//HMsYoTDAY+hDT0LJZ3EaY7ZchU26HLQ0lJ3tRNq+uKJ3dYjYUmk5mILmSlgHasIBlppDb0Lkxot+hpcuUqmZwpVX84Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892682; c=relaxed/simple;
	bh=TfxPrKWVIK1V6hQzQuQJmaaZGOTAE6KC8lUXCNnwxR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxtQC2T0sLE0E8JFCWLDt4kMovuPdyQoyJ0KFNQeWvvvd5JKlydVhRyS5QyJYYPmrfMKc4EkuC/Owv0x1sI+3oddPMKbtsn9qb7hAWnkHkrj4WSdbbCSCRBiBhEYnBoU+WpGghMD1f1b07KVsq8FylI+jII1IcQLvh3f6FGDRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p7F1FiQj; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p7F1FiQj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754892677; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oqEUcnbYtVuGUfumL17PGMuD/BWybgobKSLXaGVbfnQ=;
	b=p7F1FiQjFVOhBjmJ6tW7ChyiSOJa5ZbWE4VfKrON2zuONDiW2jM4qGc3Ta3Te0NKl7f5y/M+wx5T9oa35PzTdH9LmxViwrIuB/WH1WF+VN3q3Xkwsn2bYerv3+JdvRyMHUQtw4O/VgOFJa4tSwAKSZ/+wo7rYe7OmawYaKEceWk=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WlP-vAP_1754892675 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 14:11:16 +0800
From: fangyu.yu@linux.alibaba.com
To: anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	atishp@atishpatra.org,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	sunilvl@ventanamicro.com,
	rafael.j.wysocki@intel.com,
	tglx@linutronix.de,
	ajones@ventanamicro.com
Cc: guoren@linux.alibaba.com,
	guoren@kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH 4/6] iommu/riscv: Add irq_mask and irq_ack configure for iommu-ir
Date: Mon, 11 Aug 2025 14:11:02 +0800
Message-Id: <20250811061104.10326-5-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

The irq_mask and irq_ack are required for host irq to be triggered
under the host system.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu-ir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 5461dbe18159..73f552ed5b65 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -208,6 +208,7 @@ static struct irq_chip riscv_iommu_irq_chip = {
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_vcpu_affinity	= riscv_iommu_irq_set_vcpu_affinity,
+	.irq_ack		= irq_chip_ack_parent,
 };
 
 static int riscv_iommu_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
@@ -239,7 +240,9 @@ static const struct msi_parent_ops riscv_iommu_msi_parent_ops = {
 	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
 				  MSI_FLAG_PCI_MSIX,
 	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
-				  MSI_FLAG_USE_DEF_CHIP_OPS,
+				  MSI_FLAG_USE_DEF_CHIP_OPS |
+				  MSI_FLAG_PCI_MSI_MASK_PARENT,
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
-- 
2.49.0

