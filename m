Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6843B3E6
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905966; cv=none; b=ckiG5oXsOVcRQnkEon874pf/T75cnP6ZUoKp2PboMO9vH/YDspmUXx8f8CKqEKXfDu/JmW0pLtaLHplDQV6UbVJ2F1YaV7AyI2xHafMytBqazYTJeuqy5AgwYoaaQ7z8d/D7EvvTvZroBqLRNJl4PLu6/ygOMd8Ga16gbGy+kN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905966; c=relaxed/simple;
	bh=vYuhsqVfnils8lHaKOhZyiE9nWn3KAlEWV1RpdhLwUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv0GlYjlU/sc4/3h7G7wRFZYKpKMN6s+hPHqzil0fRneIqNE0KYNErmu9KP02dYQR6tPvErfWdKsDRO2HCYHgXP+NmahGxwCyHzana6NB5Qh8vDVhNtgUulh4JSmdb2P3h/kXD1yOFsfqSEwbijGYhdPo9qkDa2MbHvRbf2VJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QduG0StX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BURkIR+f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QduG0StX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BURkIR+f"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODb8EA3344390
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3W2bK0I72PE
	FqF/IzybkyckridGQhLhq7hDYw4GK5W8=; b=QduG0StX9XwjoN7bhuKRIpNvWH7
	cxkPyIkULnk0xjH87URIHvwhP39/OGTTAXRTN4Fd67I7r9LE5Xvxh3ixTCkOOL/y
	HM2Cy1YolO40knUhnwlq8bd2ZVYzBW80KjVxQYek19TKGz8lyRPcy8fQ3uThhHOi
	Wk9oKmXI1gDmejGV3VEnOGKLWZMtoa7HUpupz8iohvU77Xv9TqH+/anTBzblUBnL
	qcqskKIUSbXRfvnGdf+nMUPeLgXN7b9Rg++GiofPIEKn/e8gjIsv0hbG1ExBYXm9
	ebO/vBZ6w59YM1jfQFQWEtdrA2HghBVU+FklkOqi+Of4mZ5IP68MiAKIAuA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cf0jj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a236220so8706681cf.3
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905957; x=1785510757; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3W2bK0I72PEFqF/IzybkyckridGQhLhq7hDYw4GK5W8=;
        b=BURkIR+fEk1DSSHbh3ZfOgOjQ43W2TCLbosOL0GOKWTPzIvq7cjM/0/29yiz20g+PK
         kgDvdMwhMomPlfN1gMBLHb6SSHehqFNENTkcqjISnV0ltpuV+6BQWnBeneLYrcN9gwqp
         b2y4JfSGpTzKTfBLBPGFXIz7Hig9U3LfQBqsSRXW9TJzmnNOAU6IrQJsNZlgmEB+Pj/D
         7xKFtS0t5Wes5oLQuprnpRomr6MyKj9Zw6g6WTBXwRcnpx0m1Mvz7hZhMZNzEUe+wrI1
         S8GLDmCMN0Af3GTh6q3VsRJ0OqO6arZKW8fuweJjz5bF78zFYekncA8HyL7dD3F1qxqp
         S6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905957; x=1785510757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3W2bK0I72PEFqF/IzybkyckridGQhLhq7hDYw4GK5W8=;
        b=Bv/tCn7OggPpGRptuCN7c4XRXQAKVjRKJqFTEybQWoRfRgJ7wSmI8l3IyP+UA5a7VO
         T+hIwK1ugaddL7H53yaq6oyDV6Bbgkm6NlQEs5eH4u5DuTu2vHaZm1V/vayxeJs/Wrpd
         W0WrMPctS7IS6d5HlPr8HJGIBcFEPp9Ol1kA86LPTWteAJ+wIYMBllwTMLaTxPOUn80F
         n3WUD/LZJycWQJTGHJuK6InvdY729mDEXlqpmgiBSSrMCOQ0jmwx07ebBWK2n2qtKLBM
         2a/Z7HVO0Qwof0BN8J+ILdg7g8nT4VRvtsgzvazmL9qBZVIO034t71z4i9y8lk0DDWFC
         a3tA==
X-Forwarded-Encrypted: i=1; AHgh+Rq75NjT481RY5eEbN3wBN3NUUVjDZNFSBA8xDctEVQf5ibno+qN0ObO9VZ/k3k3YWM86P/ywg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDYCNyS00rAAJq+jtkrs+3bgRdfamOWUsQbqUT3iJU/Y9dJ2z5
	HYr2Y+o9GOZ+BCF46FbchRt7VrHoaB2qlgUIRSVW/lr4R7Ay6vmZGaNj8km5yZeTa9cVa0jw3Dq
	dhThlq2gkgaobP68aWYwEQTHf4WJDfgqnQZ1LfJr/GlSxHYMri5xBA8vBng==
X-Gm-Gg: AR+sD10X3GXmYFCL1lRX0c5wcC4chaGi+PzylLAeJdX3aOjXwqPXK5cEO9CD2YsHA6t
	ym0wduwG/K18PBywCzYznb9r86iRokCn2+pMHl0X7W6KIccqDyd7o+ow8PzN0aolQWaGwVDNcNy
	9gpj8uAwl0PBrJh1TfKzsRq7S/8eUfTVqxJ+h1AcELV8VS/ekq6gTlPvulrJ8ya/L8CZn48tpwU
	yJXls/dEz7qhvXCebDuVTbbfvKYN0WxScUHroB6iZVV7eFkDayKP0i3vcmjP8feyzB2MxuW6XNV
	iVfQPkgR/kmxRsQbVvaiO+N9j0C4D6MGA0HjW9Nx72bAzcnT0GM1v5gWVuGee3zQOxl4nGjOH+J
	WugOl9+MsIG9kYDKAkgny2K6UpzPJDhw4NHVU
X-Received: by 2002:a05:622a:4c11:b0:51c:7b13:62fb with SMTP id d75a77b69052e-5283dff3e41mr80642341cf.81.1784905957019;
        Fri, 24 Jul 2026 08:12:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4c11:b0:51c:7b13:62fb with SMTP id d75a77b69052e-5283dff3e41mr80641641cf.81.1784905956486;
        Fri, 24 Jul 2026 08:12:36 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5543aacsm101916a12.14.2026.07.24.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:35 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 07/14] iommu/riscv: Add IRQ domain for interrupt remapping
Date: Fri, 24 Jul 2026 17:12:11 +0200
Message-ID: <20260724151218.965929-8-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
References: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX+M6KzEehKMFy
 lG8BnLjUzOEhysxUM1NcSzKSAeEIvNnZpJfzgtYUAA1mXdCXfn0FGo1lUoAJ58M3untrLpdwJCu
 Vh1QD5pc1ra9OcMPz6VEXQBA2UO2kbQ=
X-Proofpoint-GUID: 4TnhbIUGM9k5-ReS_NwzoKZk3_KN0EG9
X-Proofpoint-ORIG-GUID: 4TnhbIUGM9k5-ReS_NwzoKZk3_KN0EG9
X-Authority-Analysis: v=2.4 cv=er/vCIpX c=1 sm=1 tr=0 ts=6a6380e6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qlKvAlJJmACmlsHknIYA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXwH8vru9teMW+
 JCxJaIx5Kto9UE5jDAy5Al1OEEBMHcw31hKFuy3ECY55FeZDrEuv5oZVwiNk0n/dwZpNhCSoJ8h
 YifdGJpOukrPDqu733EUaxk9LC32zNZg23NNTXWuNzi9pQu/AhkgUMDTTSedOtRBoy/yF9fZA0N
 N65DkrXv2gIXAzr2snjqiLJ+Jc3Di7ampIa6A64XA1nklFT0gp9fSChqlbD/zavt5Ml6AblG1qS
 1WS9Zz8tsjcEXHYO0dqyC4o6uu/UXLDJ/pkwUQVv6/+OiCQDkRSYuBV2s4+4/hEHD5gzKxY9+oM
 fi3geTFcQBp889LwmydJUiluyJ1DFXSpPpqLVVwwzEYVjhlZkk6x3bVRFW/wjQCwii0cKfXzHTG
 jmygWy/WgZTdQJuQJ8O3uIpfaIwL7/8Zpave2WjIQm6W7KmTgWzi+sIrKWlpEQtgTVSnD5XL2Pz
 WAQufH0m+a+T5c5vpaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

Create a per-device MSI parent irqdomain as the hierarchy hook for
future interrupt remapping. The remapping tables will be owned by the
attached paging domain since the MSI IOVA mappings live in its page
tables.

The domain is installed from probe_device() and removed from
release_device(). This is only the initial skeleton: it does not
remap interrupts yet, and non-paging IOMMU domains will fall back to
the raw IMSIC physical address when remapping is added.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/Makefile        |   2 +-
 drivers/iommu/riscv/iommu-ir.c      | 119 ++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c         |  46 ++++++-----
 drivers/iommu/riscv/iommu.h         |  27 +++++++
 include/linux/irqchip/riscv-imsic.h |   7 ++
 5 files changed, 182 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index b5929f9f23e6..9c83f877d50f 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += iommu.o iommu-platform.o
+obj-y += iommu.o iommu-ir.o iommu-platform.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
new file mode 100644
index 000000000000..5873addf2a1b
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IOMMU Interrupt Remapping
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+#include <linux/cleanup.h>
+#include <linux/msi.h>
+#include <linux/slab.h>
+
+#include "iommu.h"
+
+static struct irq_chip riscv_iommu_ir_irq_chip = {
+	.name			= "IOMMU-IR",
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
+						unsigned int irq_base, unsigned int nr_irqs,
+						void *arg)
+{
+	struct irq_data *data;
+	int i, ret;
+
+	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
+		data->chip = &riscv_iommu_ir_irq_chip;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
+	.alloc = riscv_iommu_ir_irq_domain_alloc_irqs,
+	.free = irq_domain_free_irqs_parent,
+};
+
+static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
+	.prefix			= "IR-",
+	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
+				  MSI_FLAG_PCI_MSIX,
+	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
+				  MSI_FLAG_USE_DEF_CHIP_OPS |
+				  MSI_FLAG_PCI_MSI_MASK_PARENT,
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
+struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
+						    struct riscv_iommu_info *info)
+{
+	struct irq_domain *irqparent = dev_get_msi_domain(dev);
+	struct irq_domain *irqdomain;
+	struct fwnode_handle *fn;
+	char *fwname __free(kfree) = NULL;
+
+	if (!irqparent)
+		return NULL;
+
+	fwname = kasprintf(GFP_KERNEL, "IOMMU-IR-%s", dev_name(dev));
+	if (!fwname)
+		return ERR_PTR(-ENOMEM);
+
+	fn = irq_domain_alloc_named_fwnode(fwname);
+	if (!fn)
+		return ERR_PTR(-ENOMEM);
+
+	irqdomain = irq_domain_create_hierarchy(irqparent, 0, 0, fn,
+						&riscv_iommu_ir_irq_domain_ops,
+						info);
+	if (!irqdomain) {
+		irq_domain_free_fwnode(fn);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * The RISC-V IOMMU doesn't validate MSI data, so we can't set
+	 * IRQ_DOMAIN_FLAG_ISOLATED_MSI. This means VFIO requires
+	 * allow_unsafe_interrupts.
+	 */
+	irqdomain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	irqdomain->msi_parent_ops = &riscv_iommu_ir_msi_parent_ops;
+	irq_domain_update_bus_token(irqdomain, DOMAIN_BUS_MSI_REMAP);
+
+	dev_set_msi_domain(dev, irqdomain);
+
+	return irqdomain;
+}
+
+void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_info *info)
+{
+	struct fwnode_handle *fn;
+
+	if (!info->irqdomain)
+		return;
+
+	dev_set_msi_domain(dev, info->irqdomain->parent);
+	fn = info->irqdomain->fwnode;
+	irq_domain_remove(info->irqdomain);
+	info->irqdomain = NULL;
+	irq_domain_free_fwnode(fn);
+}
+
+int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
+					struct iommu_domain *old)
+{
+	return 0;
+}
+
+void riscv_iommu_ir_free_paging_domain(struct iommu_domain *iommu_domain)
+{
+}
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..bfe606a0cb9a 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -19,9 +19,9 @@
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/generic_pt/iommu.h>
 
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
@@ -810,26 +810,9 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	return 0;
 }
 
-/* This struct contains protection domain specific IOMMU driver data. */
-struct riscv_iommu_domain {
-	union {
-		struct iommu_domain domain;
-		struct pt_iommu_riscv_64 riscvpt;
-	};
-	struct list_head bonds;
-	spinlock_t lock;		/* protect bonds list updates. */
-	int pscid;
-};
-PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
-
 #define iommu_domain_to_riscv(iommu_domain) \
 	container_of(iommu_domain, struct riscv_iommu_domain, domain)
 
-/* Private IOMMU data for managed devices, dev_iommu_priv_* */
-struct riscv_iommu_info {
-	struct riscv_iommu_domain *domain;
-};
-
 /*
  * Linkage between an iommu_domain and attached devices.
  *
@@ -1258,6 +1241,8 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
+	riscv_iommu_ir_free_paging_domain(iommu_domain);
+
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 
@@ -1289,6 +1274,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	u64 fsc, ta;
+	int ret;
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
@@ -1303,6 +1289,12 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
 
+	ret = riscv_iommu_ir_attach_paging_domain(iommu_domain, dev, old);
+	if (ret) {
+		riscv_iommu_bond_unlink(domain, dev);
+		return ret;
+	}
+
 	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
@@ -1430,6 +1422,7 @@ static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args
 static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct irq_domain *irqdomain = NULL;
 	struct riscv_iommu_device *iommu;
 	struct riscv_iommu_info *info;
 	struct riscv_iommu_dc *dc;
@@ -1453,6 +1446,21 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	info = kzalloc_obj(*info);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
+
+	if (imsic_enabled()) {
+		irqdomain = riscv_iommu_ir_irq_domain_create(dev, info);
+		if (IS_ERR(irqdomain)) {
+			kfree(info);
+			return ERR_CAST(irqdomain);
+		}
+	}
+
+	/*
+	 * irqdomain is NULL when it's not necessary; either there aren't
+	 * any IMSICs or no MSI domain has been set up for the device.
+	 */
+	info->irqdomain = irqdomain;
+
 	/*
 	 * Allocate and pre-configure device context entries in
 	 * the device directory. Do not mark the context valid yet.
@@ -1461,6 +1469,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		if (!dc) {
+			riscv_iommu_ir_irq_domain_remove(dev, info);
 			kfree(info);
 			return ERR_PTR(-ENODEV);
 		}
@@ -1478,6 +1487,7 @@ static void riscv_iommu_release_device(struct device *dev)
 {
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
+	riscv_iommu_ir_irq_domain_remove(dev, info);
 	kfree_rcu_mightsleep(info);
 }
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..5d83537911b6 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -14,9 +14,29 @@
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#include <linux/irqdomain.h>
+#include <linux/generic_pt/iommu.h>
 
 #include "iommu-bits.h"
 
+/* This struct contains protection domain specific IOMMU driver data. */
+struct riscv_iommu_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu_riscv_64 riscvpt;
+	};
+	struct list_head bonds;
+	spinlock_t lock;		/* protect bonds list updates. */
+	int pscid;
+};
+PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
+
+/* Private IOMMU data for managed devices, dev_iommu_priv_* */
+struct riscv_iommu_info {
+	struct riscv_iommu_domain *domain;
+	struct irq_domain *irqdomain;
+};
+
 struct riscv_iommu_device;
 
 struct riscv_iommu_queue {
@@ -66,6 +86,13 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
+struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
+						    struct riscv_iommu_info *info);
+void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_info *info);
+int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
+					struct iommu_domain *old);
+void riscv_iommu_ir_free_paging_domain(struct iommu_domain *iommu_domain);
+
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 61af3a5bea09..ce8fe1ead7a0 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -91,6 +91,13 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
 
 #endif
 
+static inline bool imsic_enabled(void)
+{
+	const struct imsic_global_config *imsic_global = imsic_get_global_config();
+
+	return imsic_global && imsic_global->nr_ids;
+}
+
 #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_RISCV_IMSIC)
 int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
 struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
-- 
2.43.0

