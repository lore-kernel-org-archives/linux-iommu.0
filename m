Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCA377EDF
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126659; cv=none; b=F7OsYKzX/fqU6wdapsLoej1QNE5IoIhSc+MeT1zHbrCqycNf7YlGERn9redAAHyDmSKRe2wwLPJvRLXMWf6T7RQVZJ84sUcI4dWY+HeOsgVR5CrHiSiddC3z6eZt1Uq9SpeW1ahFspc9EJM5M+PP1lrASgktIKWS5SrdUql3INg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126659; c=relaxed/simple;
	bh=vYuhsqVfnils8lHaKOhZyiE9nWn3KAlEWV1RpdhLwUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAAU122i20FtvZJhot1p/7HifZapfsNJ8c0KUpC88cJ2ierj4RsgjUuvM1noDDH7r9okQ2o/0ec5aH0mJS4wRA08jAlSpTI1OE2351VdVrP7xbCzwLoHyvuEwhHV3hg6ydk2pW9apgGHwgVSfsB+stke1xJMAwDVbMtBzWXRap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M6TO2jHY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fbcw8I7s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M6TO2jHY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fbcw8I7s"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GbVwW1825881
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3W2bK0I72PE
	FqF/IzybkyckridGQhLhq7hDYw4GK5W8=; b=M6TO2jHYuo8yrhR5QJjZPBWlzuP
	YrdYfwnxXoR+a9RAIGPGUJ+9zRAaPzk64Hd5wP1BDodLkAehoYTZEzIBwz6y4x/k
	iozy6qfmLd+0et1ofNiO1FCDlUSMx4DSmpRBBLGrk7brT4EG17fuw8Y3ECFlqPw6
	KK6YGLZiD30zRTwTB068+QgkmwtA+guXsf2o81ANjPcEVOCtKRkk0S9FYxsjeYY4
	J41ZkxhxsnodwhWbLIiEvcFt0J8MnSGJrBT2bsn8KZzCof2Ev+SouAwzktvpwmDC
	g6fbH8qJa+gtx6jV3GiOCwXCKZWUw5m7BzNimWNdDWXgpMJcr5GDVW5jdUA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwk21gf08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8efe7db1c42so39377096d6.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126651; x=1786731451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3W2bK0I72PEFqF/IzybkyckridGQhLhq7hDYw4GK5W8=;
        b=Fbcw8I7sv9EtbezLYzonGlqcg/En4MMcsaCPhW0EEXED/8HlNq47rdLN926quKEgjc
         s18Enb8cANwghNg0Cc3+WdlFc56a/9TWZvOMhZAPXvC8H3La7KeJCrYUR+r1WE2DEpRU
         wMyQlpRJRWmOZlt9J2+zybJjRv4T5eOLtUHohN8H2BrCXi102Pq8bKEap6rvsQK7k5az
         SFIYV8Z4LF+wUDiaCLU/w22wbl+J/aPIwq8qRkONqrBmRVVJ6MGOMGju1cZppLORRWzA
         6T0pxLfUQznqoEsFVhyl6EDcFvU9QM6Q0yzcXv/0nmC4RqBpYTtjcmxPsuLvG1nKdwwc
         voHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126651; x=1786731451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3W2bK0I72PEFqF/IzybkyckridGQhLhq7hDYw4GK5W8=;
        b=XH/EzYGW2mkC/lgPj19NAn3Xo0qugmPUSx7qlP7bkkKVuwwTjxZImR8T45EE/kjNQj
         BnuTEAzm9vsvxWwW0vyEO4c8946iObv3IkYY28cxrTZaiFL/mLPQmp7s9biAbQ3uQHwK
         3aWsD5iTt0xJpJ59oRmUvhvCbW3tPP3+v0IjmEhAWSyvbwHy7ZEXvRzprbtJmqQGHn+p
         8Cp2a5AO4Ap6zsuNjVXNhmXg7HVYumL2NkXm+i+8wIvAWAcssDUXoRg+RV060XspvYC4
         8j26SnmHszqUOltTcsba6ThPg6SazGphg9VVr79IxzZDPFeJ/RTRlaCpRQ16u9PhtBLS
         8meA==
X-Forwarded-Encrypted: i=1; AHgh+RpN3ONYbt7jLrt+fT/IRedd/scYPy14qEwtREypu7Oud/rp8GY9Jc6IJrRZxqHsErN/BvoITg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu7Mmwd2jpgLJ5imUvxElEqYi/Ts1RQ01/QH+sO5dDbhMjM4Qc
	JhSSWXayvrrI/4NyOkSMeEZg3+ZB5r594rL5HnJnsTQLsOncxqNZn1r9XNwssrEGa9F6cBSb0t5
	uBTNicOe2/JQ3OKMZzgtWtNBVsS/EGEY0W6fE1WvEEiIRznrf7HrWJpFBrQ==
X-Gm-Gg: AR+sD101ooQQvtykpNXXunUh0luFMuftyr/lZ3n9fRjpG9Q1KhP9Ozhmw/tMhsnkwR/
	e1b3TyU4nGWAAJ/Db1NWuO4C6tdwIUA2qLn7yQEQEQSTkzKWDqjA1Sh6Jf6U+jYFRmFKACE9xhh
	+aRZUpidvg/CYvmspGPuAzp/SxYLOpXEr2yj90osiVu6W2AnGSMOo5cKAo8k3VKsvJwCqlq4rLJ
	dRRmbKu9lRIF8ex7ThfBYoWYw7bE5XuxMn5IcDZA3MVwQWZkjhgvrQtzHc/mViWY6b4Cu4MVcPg
	bEWQSPn3PF68Fo9bgN8tBuckDFNXm/WrSjqXd+8ctwJNg4+AQ17TGs3yE/VJW59W5LCC+72IyO5
	h4rdmm1ooG0GCJp1eag0Q8D+keknA2+X6A/1ZtM4=
X-Received: by 2002:ac8:5c8f:0:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-52ce61b4eecmr277226351cf.37.1786126651358;
        Fri, 07 Aug 2026 11:17:31 -0700 (PDT)
X-Received: by 2002:ac8:5c8f:0:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-52ce61b4eecmr277225761cf.37.1786126650858;
        Fri, 07 Aug 2026 11:17:30 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cf749fsm82183166b.58.2026.08.07.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:30 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 07/19] iommu/riscv: Add IRQ domain for interrupt remapping
Date: Fri,  7 Aug 2026 20:17:01 +0200
Message-ID: <20260807181713.228535-8-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9ME8IWMposHp3ohj-ozfvThkuvQuVOkl
X-Proofpoint-GUID: 9ME8IWMposHp3ohj-ozfvThkuvQuVOkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXxdKR/hp1QNbZ
 XpqWgK2Xc51IE4HKPckpLAB1XvmQ9LTWOFRsFT7miohEnVg1/qhMq9GAhrNUJFuTBBzgE96POR9
 Pg1mFbA3sskLrdbi2SoP68dKlCNAMmAnWPueDUT6D4x4vm4mHFcyUulaWtobXD/0uSbFq96lHjo
 A3IWuLuET4cVvC2Pgc8HVAT2oZt8hucVxWjXxqUz1bTc/aGcGz8Zvh3k0MDO9m56ZaHlzo7+kCJ
 36RMROnpTPh8/21RVP6+MqAnjrI1UwdEiQ4eCXX2YF/PSrnRvQaO2bMb/QVZgZBTluEjXe12WUO
 JXWxtxiqqHNxvqb/SdworiuXZk+JtUqYYz8DvxKGsaqO4mLgjGayWZ7Tq7LRiXMPiMDtjd4cXBN
 OVixxBpQiejcn2GaAaGuJW4xWfLhGu93bxwPD/4SCevJ3dEOscLyH2PI7guNoBkDx+lnow0TS40
 eRN1UzfaAqKtIKajQ1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX7EtPC0vpPby/
 EhT+z9stByTokkdzsoQsvCNqwM1OIFp6meYZqf/UsWX8qCGPi9SZU6+iJkfWtqPU4lQOkoUZJv+
 qYbQ4zo1oGuKNkGj1OECuA6ImWtX6bQ=
X-Authority-Analysis: v=2.4 cv=YJevDxGx c=1 sm=1 tr=0 ts=6a76213b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=qlKvAlJJmACmlsHknIYA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

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

