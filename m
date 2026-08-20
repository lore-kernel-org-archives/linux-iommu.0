Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC69486B9A
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262133; cv=none; b=Qr0Bjs3LdP2hB/LGk0RY09wGutX2vUjxnGlpxGCMMEaH80N/0TEjSe/C9gkwhNhb3aUh+Fy1SeMoqTREM96MFlLANRdjW78WrReuMop0oV5zyAYbUqC2ZuzF+2jAa/15WCa5+rJOb2mFW39pFV3s5dZfDq6inazzPM4J5ubrnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262133; c=relaxed/simple;
	bh=fy5WGwh4E2P7eUfckWzVP/H1m5xPl7HRJA46CNE4JEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEHUsVB+7G/2lnnduNFoWuUEhkionorIBFqyJvGSIWjDJRUz7dke0ZFOvFGiwjkUcTdkDraelZNOKXo89WPI4RTeM7MyxERtpPzgk7uqfHppzYL8p3AjRU4rU1FrDbhTOWB6O9mhd7uilo/yAcjbArChzvO8L/MQGmMj9BGmBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Anv/o896; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lq3YXi58; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Anv/o896";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lq3YXi58"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK99S7068711
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OMcGDZhxVuc
	cNCru+kcpslo0rISnU/nhvZSrVpv+JVQ=; b=Anv/o896b7RDhMhhxl/Ae1A6gLz
	GGyA/zfRW+SYMHZE3kBG3o0CYq7YNe1rT0eIqfUNMGOwB0i4XeSX7bhHMqSNvN5q
	9A2hEA9OMMeaYMuOnndAzvUtW55WTbBnujrmnbwuCSj9kfeYlr13uhelIi2awbkV
	LMw4ELiJskPvIqJbqySVzbg+xek82w2H82eKYuWVVE8Fm2x4LHD8+E0LJM56K7HU
	id+OlcGXzLbxWOr/NvBCAcwhmLgqhJN7ESimcW17fkKH5U98OsJfDNn8lp2E9f/n
	fd24qoOBfLDIZVwUMUZ21+ZZAg54ZK0/6B0qqnhvuSJ6z4bZiSCK3gLp5eQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0k19q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d7b3b6aa2so3638591cf.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262129; x=1787866929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMcGDZhxVuccNCru+kcpslo0rISnU/nhvZSrVpv+JVQ=;
        b=Lq3YXi58AzMQsSwLZXcVvHHpIXfAmvzmA11TJxnJ+vxA5aVA1mn0H3mbwTf3YQprcS
         AE0plUI5wiHXHuqSb0+SeKcQQVE5kN4YgK+jMYON2dSoy7FyHgRRNpl+ogevFwEnI8lH
         oKblLB1mmyULOlsKT9cbuOLVNGEC2DWtnp+RKlNgEq13CIlkH7sdSVP0lDUB6w40EfJB
         dtR+EDa+ZhM5KJ2DglK1JUuVuKzNo6G6Qn41QdARbcM/we8z5O3SGxJp6D5AFnyGqrbU
         AAM5PsEmeus0+HRkSjA1E+dJ4tNO0tAZNlw2yQDjP6AQOJaqtU5UapsTgRGvVmO728Q2
         fuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262129; x=1787866929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMcGDZhxVuccNCru+kcpslo0rISnU/nhvZSrVpv+JVQ=;
        b=Xzx4nHOSoedgXSFvQmUTBpE7bNVYA4hdxqurcBZuypMLNrkPLqXrKOsAelAaYmigTz
         yeDJn9hkIM1wEbNfFMObTjTlrJI4D2tqUDfzzZN0NGJJlka9FAvvkznxdZ5HPF4zJp8g
         8P5wf13B3TKKIsr8e3Zz+o5mPpZ7a23WoeuBjyLzFHzM4XyAd9sJyVljLlPJW7mMONyO
         niH8xkwLISeB0HXCLq3JD/WlA4eZj1EGHdfKVXAVFRUQIMv57F+YdgRNPOUOXSEjSBwu
         v1Gygx7bGeuMSB/HvKDsKBNTT3+q72RZivCvV7NEXttkjGZjozVIVnJpYOBexwOd8O6U
         4dfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjZM7yiJ+Kkn6tTk6kOIMLXHAK0QqCGrIaz+gdC1qyrZB+OuasvLRkNMwy6HXJQzOqMh8iBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw77Zq4kxE2Bj3CpadEa3XFMvFVDKXC3fDq134H1IsSKwSzev1b
	ULStZiO36vQBr4TZ0z7ucfayLv073zsYbI5L6iStrW4gQBO2zX0Kpwa4t8YFimbUMQ2mUlCykKc
	eQ+6khrczcLgP5e13SggDcneYaNBLcJjA0exlxvSFwS+ahzu0N7AaiZBmpw==
X-Gm-Gg: AR+sD10uYTbUIxSfQ1/hOsB7WVBy5fZuJsYtdX6Jvje76NrKj9zrwBBJ92DqMUPJqlH
	ax5BlmTCMu1PdL1VZA2YKBx6CcG3/VLL8wm/0etlw9SctBD1BGtEFRjq4QlNCU+h2uOBhL8+Ajz
	63KoLq2NsRAQI3aMHVBygi5U81Oap+bQQBF+Enl0PZsf0snIK76TJhsDXkugi4C0nHh0AqpnJbT
	AWMBWlNNMGezgxQdK+i6w44UENNINyvbo7CY/Y2FO76bxr2768oWq1ExBi954gQ1UGsDvg3HEtg
	kMjiVnWRtQjJtUHoPWL2NCsBkpLNMBTjLAuEeUT8RrCSD8t+Z8SxBU1v+Ne5I3HdNwhwP2JZY3H
	fA4Pj+IpE
X-Received: by 2002:ac8:5a95:0:b0:52d:2e0a:8ca1 with SMTP id d75a77b69052e-52df5a75f81mr11674561cf.39.1787262129179;
        Thu, 20 Aug 2026 14:42:09 -0700 (PDT)
X-Received: by 2002:ac8:5a95:0:b0:52d:2e0a:8ca1 with SMTP id d75a77b69052e-52df5a75f81mr11673921cf.39.1787262128585;
        Thu, 20 Aug 2026 14:42:08 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9bb47b3sm294585e9.3.2026.08.20.14.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:07 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 08/21] iommu/riscv: Add IRQ domain for interrupt remapping
Date: Thu, 20 Aug 2026 23:41:37 +0200
Message-ID: <20260820214150.545737-9-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Uwr6sK4rldR7Rnpg-VtQmJPekfzFvVw0
X-Proofpoint-ORIG-GUID: Uwr6sK4rldR7Rnpg-VtQmJPekfzFvVw0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX51Z1Zw0EQ5Wp
 gWBYAIFgCYCku6I4BaBddEugJyKR8yV8ogW3fDwo2A2A+3+Dh3VPVKn9TyU13rLDBD2TW9rH2/8
 xMpLC4bj507oL71jLDOOq410AFhKXwLz/MBOgVW3J9acsK9xUKYjR3UUq7IpBYPKQiGzZ9yzBnk
 SLLbc3AV5y/zHwXkF1omemw4TiwuLdf1viMkXkm3d7uKN5BrmExSc1DxvDu4faMeuIU3HVM5dMr
 GFy5PNkyRWg3OOkWyppNbTQtgGPhAqL1IG8QDr8g2sffyDG7S/tKTB76I1hifyLHQEYh6KNHnLb
 xJBLfeEQWeIDYNUtO6DvuE9YGG5Ezm/1P5Xhp7YYqJEqxL/Bw2rGuRv+MFguzysFFm6Kq+p+qgk
 0CSgy9eA+uHRlJBSgudLx85R7lOMxtwoHoMpstgakGS/++VB1uiQnYRw6SlPNU/2q8yQ+bsnkG1
 ICXn0qkxGKEXjVAq8lQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX6dHUZZF4Q2Wa
 2LKPlbao65mkWnyNZWWUKjCcBNIHmgZCJG5mOoaV5JJoVgI0yfRQYDfIXhquRjf1Xa34i8+mkqx
 pDklXBRWTiq749lMzvxv9jALqdqOolY=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a8774b1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VB2jXpgF0Y-UNvywB1sA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

Create a per-device MSI parent domain as a hook for interrupt remapping.
Keep the remapping tables with the attached paging domain because MSI
IOVA mappings are part of its page tables.

Initially, the new domain only forwards operations to its parent. Later
commits add MSI target mappings for paging domains, while non-paging
domains continue to use physical IMSIC addresses.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/Makefile        |   2 +-
 drivers/iommu/riscv/iommu-ir.c      | 118 ++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c         |  46 ++++++-----
 drivers/iommu/riscv/iommu.h         |  27 +++++++
 include/linux/irqchip/riscv-imsic.h |   7 ++
 5 files changed, 181 insertions(+), 19 deletions(-)
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
index 000000000000..0aab0efeb70e
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -0,0 +1,118 @@
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
+	int ret;
+
+	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
+	if (ret)
+		return ret;
+
+	for (unsigned int i = 0; i < nr_irqs; i++) {
+		struct irq_data *data = irq_domain_get_irq_data(irqdomain, irq_base + i);
+
+		data->chip = &riscv_iommu_ir_irq_chip;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
+	.alloc			= riscv_iommu_ir_irq_domain_alloc_irqs,
+	.free			= irq_domain_free_irqs_parent,
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
+	char *fwname __free(kfree) = NULL;
+	struct irq_domain *irqdomain;
+	struct fwnode_handle *fn;
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
+						&riscv_iommu_ir_irq_domain_ops, info);
+	if (!irqdomain) {
+		irq_domain_free_fwnode(fn);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * The RISC-V IOMMU doesn't validate MSI data, so we can't set
+	 * IRQ_DOMAIN_FLAG_ISOLATED_MSI. This means VFIO requires its
+	 * allow_unsafe_interrupts module parameter.
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

