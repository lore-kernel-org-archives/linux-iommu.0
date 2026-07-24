Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA8447815
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905970; cv=none; b=X4OOMP5iRDZFS65yPsf3uAg7yf12bkPsUFV86gttHjHXdPZFsIJLWeAaCh5dN26RJGgpmZPOCmM8tE29WiTAjTAH4DwxvLB+WPWGx4/K9CUWd9Rxd6QWWC9nbIDPXoeEpEWYXhyY887jv6losDpcoTPwKn260XB6PMA/P8vmVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905970; c=relaxed/simple;
	bh=UUNrfXH7Fs1c0EGCieqzkOjlNB/2HqdhLntXG6PBkdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaye6dqUr30cwbbg+YCiJW4JiJ+atZD3UG3aIDkJEZ9QS+UqXDV2DfNkVawPNnv/NAO7Rs88Ar6cWMwdHqUu6vaQjqH2l3PkUV39JgiM6qaS4bJQZuHbb6weNGIMEW9G7DOva+heiTWjZul2H6bx6yYSpMdkpSegIjqOS5bjdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=audgQk8C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SD7jHrBV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="audgQk8C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SD7jHrBV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbZq53488490
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yDa0cSUYvzd
	lObAUgtdKmyhrtsbnB8uhf7mj+sQjD7w=; b=audgQk8C8HqbDLgb13UDsgXvSmN
	8HQoXuMBIHWwPvZiruZE7Y05TtCY/V14u4/Gm5sARevsyRIB1Q40ldmGkVvNYWX6
	WANDGUFBWbKumA4SiB60akU+bCfsBqaNqEgfaM1mxEP+A4ipoIQ8uU2IvAwg+dO2
	8atxxOobTU9SYJsdojOcK9SZ59DQ44s2X3tYlMrLOBVe5wpHxnZOHj1VOiIHYWZg
	XEu7NDo82Ic5/wNQSom1WgLRCH7HdrFj5fFEgkavzKbO4yruNXb1Y5LFDW8oxZWb
	ASUK/XFVjCtI7WgUOuZBfiMVa3fISc8L+qeEN2Q07iwSEflUmaYChzPYATg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0cb8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a23afcbso5913251cf.3
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905963; x=1785510763; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yDa0cSUYvzdlObAUgtdKmyhrtsbnB8uhf7mj+sQjD7w=;
        b=SD7jHrBVIHKlBv5waGXvd/L/+EcX0fiWx/mlRw/QPbTefRAGaTmNbSFZgkJnc4ejRJ
         rdy62LvmGz67s0RRgnOJ4lAfN9rBWU+aQZce4ZOnb4rQG03hosQUTqpS00rtQJupI58Z
         f32egYzOx7q3RIUxUjsOUCjeP6C3THjZEKWTLwGPlnli0Y5olo1kOJCC/fTMwY9xqV2E
         LlU/gSo/q2dDQdPrAsOxez7zXpcx8kBxUI6U0bQ2L4IxtMrZU7CKtpQNwuNO+KFgB8K8
         968dyzdd8N9rlKzCYXxIKPWWa7l/aaGAjxm01HcgeMzySp25eaSBYPJzMdUsdthB2k1J
         f44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905963; x=1785510763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yDa0cSUYvzdlObAUgtdKmyhrtsbnB8uhf7mj+sQjD7w=;
        b=IxxQ90EQegik7ZHd3XT81JYlK6IpDweStND9a9bNmo5FQlNO3uQPUAqz23HjXLyw7e
         Xm8U9mnUXM1P5eHaWGM0FKXnwysujty3SY/Iy6TUSPiavoqu87YUdHu4D5wolpal4FIu
         HEZWhpxUS+DbcDi4ZHb4xzS8AZmQkzyNBGRh6G7kqDotlMxIlt4Ph8Qq+cdg4HlTNkWJ
         znUG2I/rt0DLRJVOqQi4/dl5AXJQCAb9MnpS4RvVNwWM5dFWFoC49XUp3emZ4rs3Kc7j
         lE9UN0sANsF0GO37hpBMqbK2ioBhDs0L3NUrXQyzTEiGZWiOcM9ExqpcD7ir4yJkfIK2
         kKVQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCAsRT+QIhlv3Arlc9Gk6ugJ/cOK+/KetBz4QVCUDZWjx/n+lCo6AjGCOsClp2vgSw6scTkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxja1xV0cVoZzLENIRgI4oQ3csPscjIZ9A0d8CvuO6cgepNZi1q
	gZJLD86MRMKng6U+D9E5Lu7GoQ7R7/8u4mT8qZmzYslMaGwGdilsTIB542quUOOr4oX2vtfXZAU
	DoJWOM5QgTLkOGAnx2jTKiFJTqzeRkQ/cVGkgqTxFQBojV4dWc/ZFsvlpEA==
X-Gm-Gg: AR+sD13Dj3Cx/4IrRscbQ7e3QtgPyeK/u/IuH054bWere1uX1p8ZKSysOgkdLjIETQu
	WYeJ/d2rSlTqzyzykDvQJMNU2v3vhknvuTn7dHKdY192PdeV5XZdJoobXHewt+VJ5TyLNXQzAGe
	DlzmJTcmzA5QkUU09fE8XbcE+HYkmuTilnAg1kk9DRX6j1v21QU8VB64Uht8inMGhj306V4BVlR
	gGAjNZRdzfmbbMMsNWhik6VP4SquQ9jn0z1l11W98wru8bFKfL/INd4tU5FQhcEpL8S4ed2r9Xe
	fmf7D7RJVhC2YdKyy1XNHN2r/LrhaXTtBeG1Qm6olmxe/HwMPUNo9mcyojBpi3qIaGCfrxAyygx
	IKgNxFD6C+Hqh1GdIN3lVKFq3ueIi+u9eue21
X-Received: by 2002:ac8:7f0a:0:b0:51e:4f6a:b9b8 with SMTP id d75a77b69052e-5283dd94d1cmr75414031cf.1.1784905963185;
        Fri, 24 Jul 2026 08:12:43 -0700 (PDT)
X-Received: by 2002:ac8:7f0a:0:b0:51e:4f6a:b9b8 with SMTP id d75a77b69052e-5283dd94d1cmr75413451cf.1.1784905962655;
        Fri, 24 Jul 2026 08:12:42 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5746e98sm92883a12.22.2026.07.24.08.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:41 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 10/14] iommu/riscv: Pre-map IMSIC MSI targets
Date: Fri, 24 Jul 2026 17:12:14 +0200
Message-ID: <20260724151218.965929-11-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: T-OodlFe-oz5orUtKUKJR0cHGiJ3Faq3
X-Proofpoint-GUID: T-OodlFe-oz5orUtKUKJR0cHGiJ3Faq3
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a6380ec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=xZf72DcWP4T9vyFnQ2MA:9 a=O8hF6Hzn-FEA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX8kfSCTjQY7uJ
 Bul3OgXdv71xQEmXsXeCUyrR2PtSEedT6Kz7msRqsbphxZg7tSIXbZtBAZ1aVgmwG7rqpfZoyWl
 sy0VbIziLnVcW996c1QwK0SP/5lvwSKLbe7PZRzr/gu+mzzMYWfms3P+gQS4SWCW0yVRFTonQ4J
 HFLQpMkn3SP1Y1J0VGuwOkaVrwkt7CeIJrPWIxrdBYD9+iAX1JwDaoLqYqOW8+QM3gyqz4HBnMQ
 DW/0ZYJ/RJoIANktQ4RpwpbuUDGFTqk/ZCm+nTsIVDSXxSb2w6zWnw1cykCKPh8glnsjrOZm70Z
 OUAfVMiLqMkqg7jkk6OuJFAd5ouczS4A0lfXu4wOPSCwhH0gWTRcnKmavO/1lp2Qy14Mbkfu0FS
 7P3rdTe+JwVVLzFT8ymCtxV7tNIOlbCLIRwhTtgzuX5XkupQzyP9CXt2M/DslldQ/YS33bFi/k7
 CyG7r2Vp5WKWag6Yv7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX3JWianA3D6q6
 XoEHr56quGTWa7i8CFIX73+QLjx+BFJjRu7FK8jdtcqUjqQrw1bKTEsCfHlyMtbm1FS2QR+l/st
 fM/GsiXtmyv1DG6GDOmZ11on6U+5Cdw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240137

Prepare for irq_compose_msi_msg() to redirect IMSIC-targeted MSIs
through the IOMMU with an O(1) lookup. Unlike fixed-target MSI
controllers, IMSIC target PAs change on irq_set_affinity(), which
may run in atomic context, so compose cannot map the selected
target on demand.

Pre-map each populated IMSIC MSI target page into a domain-local
IOVA table when the device's paging domain first allocates
IMSIC-remapped IRQs, so every possible target IOVA is available at
lookup time. The table is indexed by a transformed IMSIC physical
address using the same transformation defined in the IOMMU
specification for the MSI table (and the function will be used for
the MSI table when that support is added later).

The table is sized by riscv_iommu_ir_msi_iova_count(), i.e.
BIT(group_index_bits + hart_index_bits), rather than
num_possible_cpus(). This is because riscv_iommu_ir_msi_iova_idx()
derives its index from hart_index_bits and group_index_bits, which
are sized for the group with the most harts, i.e. there may be a
sparse mapping.

Select IRQ_MSI_IOMMU so iommu_dma_map_msi() and iommufd_sw_map_msi()
are available to the driver.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/Kconfig    |   1 +
 drivers/iommu/riscv/iommu-ir.c | 108 +++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c    |  12 +++-
 drivers/iommu/riscv/iommu.h    |   6 ++
 4 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index b86e5ab94183..f557b55c2c14 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -10,6 +10,7 @@ config RISCV_IOMMU
 	select GENERIC_PT
 	select IOMMU_PT
 	select IOMMU_PT_RISCV64
+	select IRQ_MSI_IOMMU
 	help
 	  Support for implementations of the RISC-V IOMMU architecture that
 	  complements the RISC-V MMU capabilities, providing similar address
diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 5873addf2a1b..39ca4c89a2a3 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -5,11 +5,100 @@
  * Copyright (c) 2026 Qualcomm Technologies, Inc.
  */
 #include <linux/cleanup.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
 
 #include "iommu.h"
 
+/*
+ * Compute the MSI index for an MSI physical address using the
+ * IOMMU "extract" function (RISC-V IOMMU spec section 2.3.3).
+ */
+static size_t riscv_iommu_ir_extract_msi_idx(phys_addr_t pa)
+{
+	const struct imsic_global_config *global = imsic_get_global_config();
+	phys_addr_t mask, addr = pa >> 12;
+	size_t idx;
+
+	mask = BIT(global->hart_index_bits + global->guest_index_bits) - 1;
+	idx = addr & mask;
+
+	if (global->group_index_bits) {
+		phys_addr_t group_mask = BIT(global->group_index_bits) - 1;
+		phys_addr_t group_shift = global->group_index_shift - 12;
+		phys_addr_t group = (addr >> group_shift) & group_mask;
+
+		idx |= group << fls64(mask);
+	}
+
+	return idx;
+}
+
+static size_t riscv_iommu_ir_msi_iova_idx(phys_addr_t pa)
+{
+	const struct imsic_global_config *global = imsic_get_global_config();
+
+	/* msi_iova[] is only used for the host imsics */
+	return riscv_iommu_ir_extract_msi_idx(pa) >> global->guest_index_bits;
+}
+
+static size_t riscv_iommu_ir_msi_iova_count(void)
+{
+	const struct imsic_global_config *global = imsic_get_global_config();
+
+	return BIT(global->group_index_bits + global->hart_index_bits);
+}
+
+static int riscv_iommu_ir_build_msi_iova(struct riscv_iommu_domain *domain, struct device *dev)
+{
+	const struct imsic_global_config *global = imsic_get_global_config();
+	struct iommu_domain *d = &domain->domain;
+	dma_addr_t *msi_iova;
+	unsigned int cpu;
+	size_t idx;
+	int ret;
+
+	guard(mutex)(&domain->mutex);
+
+	if (domain->msi_iova)
+		return 0;
+
+	switch (d->cookie_type) {
+	case IOMMU_COOKIE_DMA_IOVA:
+	case IOMMU_COOKIE_DMA_MSI:
+	case IOMMU_COOKIE_IOMMUFD:
+		break;
+	default:
+		return 0;
+	}
+
+	msi_iova = kcalloc(riscv_iommu_ir_msi_iova_count(), sizeof(*msi_iova), GFP_KERNEL);
+	if (!msi_iova)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		const struct imsic_local_config *local = per_cpu_ptr(global->local, cpu);
+		phys_addr_t pa = local->msi_pa;
+		unsigned int shift;
+
+		if (!pa)
+			continue;
+
+		idx = riscv_iommu_ir_msi_iova_idx(pa);
+		ret = iommu_dma_map_msi(d, dev, pa, IMSIC_MMIO_PAGE_SZ, &msi_iova[idx], &shift);
+		if (ret)
+			goto err_free;
+	}
+
+	domain->msi_iova = msi_iova;
+	return 0;
+
+err_free:
+	kfree(msi_iova);
+	return ret;
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
@@ -22,9 +111,25 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 						unsigned int irq_base, unsigned int nr_irqs,
 						void *arg)
 {
+	struct riscv_iommu_info *info = irqdomain->host_data;
+	struct riscv_iommu_domain *domain;
 	struct irq_data *data;
 	int i, ret;
 
+	/*
+	 * MSI IOVAs are domain-local, just like DMA IOVAs. The device must be
+	 * quiesced, including MSI teardown, before switching away from or freeing
+	 * the domain. iommu_dma_map_msi() requires the group mutex to be held;
+	 * take it around the domain lookup too so info->domain can't change
+	 * out from under the build.
+	 */
+	iommu_group_mutex_lock(info->dev);
+	domain = rcu_access_pointer(info->domain);
+	ret = domain ? riscv_iommu_ir_build_msi_iova(domain, info->dev) : 0;
+	iommu_group_mutex_unlock(info->dev);
+	if (ret)
+		return ret;
+
 	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
 	if (ret)
 		return ret;
@@ -116,4 +221,7 @@ int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struc
 
 void riscv_iommu_ir_free_paging_domain(struct iommu_domain *iommu_domain)
 {
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	kfree(domain->msi_iova);
 }
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 98ce9ec50e65..5631af2c9ab1 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -810,9 +810,6 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	return 0;
 }
 
-#define iommu_domain_to_riscv(iommu_domain) \
-	container_of(iommu_domain, struct riscv_iommu_domain, domain)
-
 /*
  * Linkage between an iommu_domain and attached devices.
  *
@@ -1336,6 +1333,8 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&domain->mutex);
+
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	spin_lock_init(&domain->lock);
 	/*
@@ -1449,6 +1448,13 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * Set info->dev before creating the irqdomain: riscv_iommu_ir_irq_domain_create()
+	 * publishes the irqdomain via dev_set_msi_domain(), making the .alloc callback
+	 * (which dereferences info->dev) reachable.
+	 */
+	info->dev = dev;
+
 	if (imsic_enabled()) {
 		irqdomain = riscv_iommu_ir_irq_domain_create(dev, info);
 		if (IS_ERR(irqdomain)) {
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 9a8fd5300675..5f79e4cba375 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -31,14 +31,20 @@ struct riscv_iommu_domain {
 	};
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
+	struct mutex mutex;		/* serializes sleepable, domain-wide setups */
 	int pscid;
+	dma_addr_t *msi_iova;
 };
 PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 
+#define iommu_domain_to_riscv(iommu_domain) \
+	container_of(iommu_domain, struct riscv_iommu_domain, domain)
+
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain __rcu *domain;
 	struct irq_domain *irqdomain;
+	struct device *dev;
 };
 
 struct riscv_iommu_device;
-- 
2.43.0

