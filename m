Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40E1A683C
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126660; cv=none; b=EmtJdCMpRh0OAxY2IoL38begvAwtUH6Xbq0qnTYliJpSlr3IqvT7a090YmN1k+KgyCzUT3r9C1F/R8t5VO4BtiZJA7NUyGD9S3NwZzK/1UlNggdjU1VBgGbKOSHaWPejC5te9/e/KoWT9KOLvmfDyixqs/8RIGpxI3SZtc1gb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126660; c=relaxed/simple;
	bh=xWmrfNdw8CGmCI8/zQC7PPTOUVObnFPMx125OR1+F5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGLdZ2Aa5WMtlznOjZohzFqmCVaii8sweiROtDCGJ2tDfNrKcYlTltOJYCudOpERf/oC11kEYzf3SToEilaKL+AZEGvFt/oVrXSpe6bzJfy9Aj5jedGL0tNEVABYtSDrTPBftwTVTrWaZFZiLAVmOs0EcBdTQPiEjvb/l9ka+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JVl9ZjMx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ANdJMjL6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JVl9ZjMx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ANdJMjL6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GbWFv1826026
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CF89onSK303
	YBEmO0lv7kpxdFdjR7obOW+RzB6t3qF0=; b=JVl9ZjMxfHHXG5s5cn1wj+001ZR
	HGMCj89gaiB95QWCZ6D+yGbQZmCBxYTg8z02AMAzHj7yRNt2MFF9w15L7s5hYXkR
	++Pq7zPpuFuLf0lpHdfTzjg5WnsZvxhs8eSU3yV2yCudXL4IQn8qMbTV4et+RcGO
	lC1kr+MP5uvFCXOsue9FbDUSU0z0Ep9P/dssgQB/mSySoDqxfDZcxDnYc27H1lXa
	8HGrKCy++nlr75I7xgiqkN6D9nOo/rFIlnwG3sxZZ6X9SVagShst3zsCOeBd05IZ
	b6jLDu9ZpCPr37ut5n4FqJogu10tVob73W41TogG4uQmTBGWnkqxY8FWyqw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwk21gf0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso62640591cf.1
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126656; x=1786731456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CF89onSK303YBEmO0lv7kpxdFdjR7obOW+RzB6t3qF0=;
        b=ANdJMjL6gTaPOM7CF2p1QroMgLcGRxohPXc0iB37yAKRyb4JT47LgLTknGDt4UUSul
         JfqzU1GDan07d7IZ39xX15EAODcoK31+4QUJgpX7SQ6DfgSePMb47LJYTaSXL9r56HdA
         uA+DoLGE+elTdSlBTJkX9khFzKknsOtiRObBC+1YPgZFYpdt20cnd595kQBu60h8Pg43
         D9rTsUcjpZZt9rR8/EJwI4fTTvdxxQDo+UOEdryuHdeGEzIeXaehkrwRAS8ZA2AvQ7i0
         7cG4oDViO3et3E+Q5Es7582vGom4d/2pvbOw7Bv+XTGM4M8lwiweO3S5sZjKt3QYf9VU
         RuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126656; x=1786731456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CF89onSK303YBEmO0lv7kpxdFdjR7obOW+RzB6t3qF0=;
        b=C9t5GocXD/Zw4D2bjojs2gmib3/i28XZrZIhWwO/mWO7eeabphcJ9sI4/NVYKdKJJ1
         5pbXEA1gGkGYsxR13Lf8Ajov7iVP5JAyaqFGpBP0z0henOdadus0gEPn/qG2ITGFA6UD
         qeZKMeU3R5Un17D/k825MCL+Mi8u+Bc7rdr/shdp5hNxg0DI5FLaRq9VWU/uDorJ9OKq
         hiAoVTOWW/eEe+R8/nERcNk6GtxK4NaObTWVmy9XPuCSVr9GDbj4BsX2MHNaReFvyzSK
         jhQydv31/tmeXsnhdfS5LU85zv/wGvFnDlzBcffr1EiocHGIe5An9LGOxN9sz9R1Ci80
         2N7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpenTae1xnQAPYEGcFD+bysTZZ54dgW0p8WVXcDsCZoMEud7v893ycKYufkQ0Yn8WXUhX6aNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywwcm5UiRBmGqX5Ljmw2n2jpQSJdLNTfh+opHR0eQ2NFgVeC+M7
	cOTJ1pTCY/3hliSlogKWnJfdC4SiTh8jN5/7jzQJQWyQt7AQad+Kwz94dAtZKLG0BjSysLBYRTK
	FHS+19JHcKaiC2hJlqnTNwfUIteF9pVuP3MSk0Fv3kQ0kgUkM5bJ/V2aY6w==
X-Gm-Gg: AR+sD13iszNl5lcmkahIZcu0+myH42XsQt3U40UL7qd5xEFJq3KksUNS9McRlRO6CoD
	jpsJt4aPvyyGZvhx/8YKq9DtTMrqFQSfpbag/S947dUomd/Dnn2h3RdXCYklLas2ppBZo7FNgjU
	bh9H5wwUB80O2fBZbMWA+mhaU2gG1LYJl6ABryFirSfX/h2FJg+KYgc/5uoHVLhichnmgSgHAI5
	aiqaMZB2Kd2x6rvmbO3ZArPD1gxKW9j04VuUxSa4xWEH4qO69+CbfRk7T1B7fhOSZLsMKyCRnm1
	LPDEWk+uZMy6h2ly29f0GAkYX+sBSTKIdXknm3Yx5unsJFiC07GC8RxXtjyaBYhGno8V/K15Xt1
	BgyBXFITn0whYnAz6ywkI0bjPnPJMIPkpeN6exMo=
X-Received: by 2002:ac8:5f89:0:b0:517:9095:c31b with SMTP id d75a77b69052e-52ce61fe07dmr261971181cf.42.1786126656356;
        Fri, 07 Aug 2026 11:17:36 -0700 (PDT)
X-Received: by 2002:ac8:5f89:0:b0:517:9095:c31b with SMTP id d75a77b69052e-52ce61fe07dmr261970551cf.42.1786126655930;
        Fri, 07 Aug 2026 11:17:35 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cf5da5sm80900866b.53.2026.08.07.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:35 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 10/19] iommu/riscv: Pre-map IMSIC MSI targets
Date: Fri,  7 Aug 2026 20:17:04 +0200
Message-ID: <20260807181713.228535-11-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: F1DUrmAfbsWFSv76GvJVwy1VI0AJM2GI
X-Proofpoint-GUID: F1DUrmAfbsWFSv76GvJVwy1VI0AJM2GI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX5jwHG2GEsSe6
 +1/RLreTczyez9/0zcTa2ack1zvWe5r4xBCqetYcoL6C/7u9RxqBJng5M5y6Jc4AatHoigaIvs/
 FXWNaC0fWgS4DcZFjUDxtKPkxPk88IGloF5EhwWAFuWwyHiirGlD2vSq2W8Uih4EqhD4eB8rs8X
 2fG/5eSfqj2AKs3oYSHDtyjMnnTTDCm62bMVUAvUQl+DsidUBg8Wy8soGDCyMbeJIYdiI7E2P7o
 ctARJIw5okzBLtPaSl0tsLkZXj1Q/MzlTnbrPGZoBG5RTt5/nwNccGQdukZemew50agrYEBIAaR
 +h9cRX9nvLtcs2ZapIZ3PqeuXK++b2YEqUpkw2eXK/U5q0+WaRV2puF/0y0LybDvnjof0eCP+yM
 Decl4cjbVekzRgAt1aETLK+kVE9tq6hE7a4KD77f3aiK9bZVWfdWkmDFi1AzC/mneOGdumplY+5
 jyqwaXA9c5R9czz5DUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX1OtMGzFuwjEq
 3rDer3Po5yNf7qnUbEPUlq8C7eW9QUCHNn7oHKjECE7UndgR5G5udyykiG+CNF1LEek3+ngYn8L
 1jI08hbmDE3CdnsFQQMmNeMzlJupbnA=
X-Authority-Analysis: v=2.4 cv=YJevDxGx c=1 sm=1 tr=0 ts=6a762140 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=JmVyJN48mWrVe0T4eXUA:9 a=O8hF6Hzn-FEA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

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
 drivers/iommu/riscv/iommu-ir.c | 105 +++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c    |  12 +++-
 drivers/iommu/riscv/iommu.h    |   6 ++
 4 files changed, 121 insertions(+), 3 deletions(-)

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
index 1e157faf7bbe..0dff74aa9b18 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -5,11 +5,97 @@
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
+	dma_addr_t *msi_iova __free(kfree) = NULL;
+	unsigned int cpu;
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
+		size_t idx;
+
+		if (!pa)
+			continue;
+
+		idx = riscv_iommu_ir_msi_iova_idx(pa);
+		ret = iommu_dma_map_msi(d, dev, pa, IMSIC_MMIO_PAGE_SZ, &msi_iova[idx], &shift);
+		if (ret)
+			return ret;
+	}
+
+	domain->msi_iova = no_free_ptr(msi_iova);
+
+	return 0;
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
@@ -22,9 +108,25 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
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
+	scoped_guard(iommu_group, info->dev) {
+		domain = rcu_dereference_protected(info->domain, true);
+		ret = domain ? riscv_iommu_ir_build_msi_iova(domain, info->dev) : 0;
+	}
+	if (ret)
+		return ret;
+
 	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
 	if (ret)
 		return ret;
@@ -116,6 +218,9 @@ int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struc
 
 void riscv_iommu_ir_free_paging_domain(struct iommu_domain *iommu_domain)
 {
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	kfree(domain->msi_iova);
 }
 
 void riscv_iommu_ir_get_resv_regions(struct device *dev, struct list_head *head)
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 106cc8216942..07287c0e72e7 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -811,9 +811,6 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	return 0;
 }
 
-#define iommu_domain_to_riscv(iommu_domain) \
-	container_of(iommu_domain, struct riscv_iommu_domain, domain)
-
 /*
  * Linkage between an iommu_domain and attached devices.
  *
@@ -1337,6 +1334,8 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&domain->mutex);
+
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	spin_lock_init(&domain->lock);
 	/*
@@ -1450,6 +1449,13 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
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
index 16b3c9c4cf8c..8bd41dd63f0e 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -32,14 +32,20 @@ struct riscv_iommu_domain {
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

