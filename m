Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4765488DB6
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262143; cv=none; b=QZM8WwpybeaNudnYZ/RKfld0NbF+ExuJL4J9IeBva2chQehA4w2t76tBe4gJyX7ABOZ1H2zSrhTVIO4N/pNYOLjR4f+H35mRgMBbxgud3KvwqoAxa3huK6pBVdADRGX+qlv22pJoDrYa/tg4ckKOx+mYj8KDSIIKtov4ga3mCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262143; c=relaxed/simple;
	bh=EjnBcYdHMsuwVetuuIaySTt7eRy8PQL1ACgJ8jiGxUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiHpN5Hh7JiXYnqFoElu9qztoSQFTdT6qNRhyS/JO3xaTguZHJ5hAr9ai0pZC4ytN5tE+RxmK4kW8U0EoGZWfccKqNG7QqbX9VDtTZ68uiD6kxnQulQIojvAGdy114krR3qpMuP7LJPsuPnFJ15NWJqKqUHjX2he9NmseXRxek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bvDXAxT4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GBpK4GsK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bvDXAxT4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GBpK4GsK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7mRj807581
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aqBQ5NLxJjg
	wKgx5+nKXaga7O5VVsXHBqkNfr8KhktI=; b=bvDXAxT4yZsvFgbBh3B+pJABF05
	CEGciwskM2hsrESNkK75KdtcRh6eetPPXc1/W0wJXdqZ4CVZC2L29ZiO8/sWHJnE
	+oKx22EVz8XIymYfwDjLY+qaa/HaJ5j6pFNLo48wcwzkkplapBjCcKWVmJGUl8El
	oqeYGd50Fw2ZubXpGG47/OQ/20IHH8PgBrS60RkMJbtmUnyzMxPIy/PgYAO7U81b
	eX6PXKeXnN6rKfmaNnL3DtqGIHpXlqvZ6XU0PkoeRXG+g+a5SzqS4uE1DoFIf2ez
	N3uYqfiFE+HehPN7mJ3viczk1QWXCw5Lxy+1QuXoRR8sI11s3NBH7t7d/hQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgcbbuj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5fc4c7e9so39071285a.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262138; x=1787866938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aqBQ5NLxJjgwKgx5+nKXaga7O5VVsXHBqkNfr8KhktI=;
        b=GBpK4GsKxJvkrKHXjyNlnj/zQLDUexshyR9JGknLnsrgTsPFoco8RQhIfKvlcyzoX6
         0gCQrFfOxi3sCMU7brlwDrA8tTko3s9i92Y/4EBgM3AmvmwiepzFUljI905kVMHlrMVm
         0txUYxTm5olxqxDCfMZQVkkZq3Oa56GapWbfiUD+Vi31wQQlOCgLIJsAG3jOew0o8K+U
         rZQWU7M8KJ1ePrxKBakcKSbBYh1uxhco4ma04JPbYnEMYBDi/dReMLN2IGCGQk6xpp2L
         boA3P4Me0TaMogozyuf2inbw0skWSVk/hEFS2zptEycywwFPWobt2ovU68m72nDEz0/c
         omxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262138; x=1787866938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aqBQ5NLxJjgwKgx5+nKXaga7O5VVsXHBqkNfr8KhktI=;
        b=EnNvPCALXOWBDhYoMJ9Mvl9Mljwr+XqfHXMO/tJ8QRdvsjr/C7St6qw67X/O8nUUst
         VN7J9iUEgm7mESB/fc9rrK5+z1ZilWfRFEdsB83CKn2rxhO2ZWnFlZItE0UY+EjYDQB8
         GI+Lvvp6WiQvbO0xiqvxFkHy1KhJAozfRlZXfeLIcwk2bmpNEs9Izn54DkBoYZ+I/GYt
         NjEBCXWvddj318jqnpfoh2P3DVh6W0oGyO6F1aV8gDd5RA2b7HWdmx9EbtNJHv1jDdE6
         VkVqzK3bO8899E/aR+uZkLAYt0JlfwhdukkBoXtA91obztn4UkJAcCilL9Z4RcYOo+CE
         IC2A==
X-Forwarded-Encrypted: i=1; AHgh+RqW2rEzzTCgUHkkX+72ZtB97x2OyU9isdHlL6gzP21k+X+lyayoskZkU55nELqfezm5ArgOqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLY2Gc5SS00Z9Gqsau+CBd08fnftTLC7APhKwPnV6oSWG/9a/s
	dfu0P55ixxHiZtvqxPr3B6LqOnHJ+6BLQvbwMJ2mz7gkDoUDLBmaOJ06aMNODb992ehhpfRNLea
	upFa3LJjDheDaiLzEucuXa5H2iMkudAqXoN7PVQYrEP6AzDoGxRZ/VlS4HQ==
X-Gm-Gg: AR+sD12Bg6VzrdVXKTa7+juTR++ove24Ka2ucu8Iogxj2FnybQfgkrJL4YyOD1giLof
	PqAePz/MJxBYnPe20vPby0hYs+r4GIzbWeQBexHf8synrnNb4qi5q5WSqueF70G+MAhfkLa7WmQ
	mGbMr7aR0ojKotSMDKn8wQf3JxJNo8T+nZm46sUEMgvwLVqB8nuD9hILopQW4fr3yoOrAlkQfbL
	wlz4vQaBE4apzmA7JQ71Ar4Dcw0OddjaxWN+DM/aIrjS20xoXjtqJ08wDpiTw89atbnSat8Rzd7
	K6nTwYLXwh7BTpePtfCknpEIx4I+fXC4Yizgz2HLhzhrMPBuGP1haCUCxyINDL56c4Q2Pg0zOZA
	9RPcLNwk7
X-Received: by 2002:a05:620a:2b8a:b0:936:883f:e994 with SMTP id af79cd13be357-93739479385mr122859285a.20.1787262138177;
        Thu, 20 Aug 2026 14:42:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8a:b0:936:883f:e994 with SMTP id af79cd13be357-93739479385mr122854885a.20.1787262137716;
        Thu, 20 Aug 2026 14:42:17 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e7e20sm5654075e9.5.2026.08.20.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:16 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 12/21] iommu/riscv: Pre-map IMSIC MSI targets
Date: Thu, 20 Aug 2026 23:41:41 +0200
Message-ID: <20260820214150.545737-13-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a8774bb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=QoJ68i72MHRSmWybBfEA:9 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: vqnzPVGhGlxTztjaOmyExfGa-fBUtXYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX1BIlCxsKQe9Z
 whke2g502CfrgYKYxpCplIOA/WlJbKRzEkrc7l6weOx/LVDbOGhLCxqY7RUNSgzWvQi8v0wEKwu
 wEam4usjfLo0gwyB6X/abel67OLySVXzdmPRxilX/jNYHmd3xtjerbwsLxvxUWJeENg9RwgsMG2
 uacKv83yteqRZxRsgyhe+nIl9JLi2nFinjiqafZcJJLRjAc27+Vs9FmfoeqkvREr8piKWj+89pZ
 pmxpa8kA76Nq2mdtSztN0IduEjxbOlKuCDYVWEUDiqjplEhDp5VsKt8f3/SRXDeUjeKSnjcvtcG
 JULZsBOVQFuuEqAgWINs7USl20zYDK9LySwn8/dqHvElFefCakmAVTjvrwMz0qXi9mzwrJ0IBrh
 9XZS31BB8xLIIiqlRNi5nQIP0JOmrlqvC18qT/jWKRvAIEkvrYE4VIuADyxBjb8BP2zYDtFKZjv
 6lVc8XduL40OF2nuO7Q==
X-Proofpoint-GUID: vqnzPVGhGlxTztjaOmyExfGa-fBUtXYH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfXxIXdn5xP/qmC
 z+AOv3ollduKa2mXlj6R34QjSaUE/57gxcbF3bM/zhg2lshG1PiomYefSZsdR7lZAwFZMToe2a6
 3W45iQUjTx+wQ2qwsAa8ldKSlUgIUG8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

IMSIC target addresses change with interrupt affinity, which may be
updated in atomic context. Therefore, an interrupt-remapping domain
cannot create mappings on demand while composing an MSI message.

Pre-map the supervisor IMSIC page for each possible CPU when a paging
domain first allocates remapped interrupts. Also prepare the mappings
when attaching a paging domain to a device with allocated interrupts, so
an incoming domain is ready before the hardware switches to it. Reject
passthrough mapping results because interrupt remapping requires the
IMSIC page IOVA and its fixed page shift.

Store the resulting IOVAs in a domain-local table so message composition
only requires a lookup. Use the IMSIC group and hart fields as the table
index, matching the RISC-V IOMMU MSI address extraction scheme. These
topology fields do not necessarily produce dense CPU indices, so size
the table for their full encoded range and leave unused entries empty.

Create the per-device interrupt-remapping domain during IOMMU probe, but
publish it from probe_finalize() after the IOMMU core has assigned the
device to its group. This ensures the allocation callback can safely
lock the group.

Select IRQ_MSI_IOMMU for the generic MSI mapping API.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/Kconfig    |   1 +
 drivers/iommu/riscv/iommu-ir.c | 133 ++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.c    |  12 ++-
 drivers/iommu/riscv/iommu.h    |   7 ++
 4 files changed, 147 insertions(+), 6 deletions(-)

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
index de5e22ecbd63..4dc104c6d4b1 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -6,13 +6,108 @@
  */
 #include <linux/acpi.h>
 #include <linux/cleanup.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 
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
+	msi_iova = vcalloc(riscv_iommu_ir_msi_iova_count(), sizeof(*msi_iova));
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
+			goto err_free;
+		if (shift != IMSIC_MMIO_PAGE_SHIFT) {
+			ret = -EBUSY;
+			goto err_free;
+		}
+	}
+
+	domain->msi_iova = msi_iova;
+
+	return 0;
+
+err_free:
+	vfree(msi_iova);
+	return ret;
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
@@ -25,8 +120,24 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 						unsigned int irq_base, unsigned int nr_irqs,
 						void *arg)
 {
+	struct riscv_iommu_info *info = irqdomain->host_data;
 	int ret;
 
+	/*
+	 * MSI IOVAs are domain-local, just like DMA IOVAs. The device must be
+	 * quiesced, including MSI teardown, before switching away from or freeing
+	 * the domain. iommu_dma_map_msi() requires the group mutex to be held;
+	 * take it around the domain lookup too so info->domain can't change
+	 * out from under the build.
+	 */
+	scoped_guard(iommu_group, info->dev) {
+		struct riscv_iommu_domain *domain = rcu_dereference_protected(info->domain, true);
+
+		ret = domain ? riscv_iommu_ir_build_msi_iova(domain, info->dev) : 0;
+	}
+	if (ret)
+		return ret;
+
 	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
 	if (ret)
 		return ret;
@@ -112,11 +223,22 @@ struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
 	irqdomain->msi_parent_ops = &riscv_iommu_ir_msi_parent_ops;
 	irq_domain_update_bus_token(irqdomain, DOMAIN_BUS_MSI_REMAP);
 
-	dev_set_msi_domain(dev, irqdomain);
-
+	/*
+	 * Publication is deferred to riscv_iommu_ir_irq_domain_publish(),
+	 * called from probe_finalize() after the IOMMU core assigns
+	 * dev->iommu_group, because the allocation callback locks the group.
+	 */
 	return irqdomain;
 }
 
+void riscv_iommu_ir_irq_domain_publish(struct device *dev)
+{
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+
+	if (info->irqdomain)
+		dev_set_msi_domain(dev, info->irqdomain);
+}
+
 void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_info *info)
 {
 	struct fwnode_handle *fn;
@@ -124,7 +246,8 @@ void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_inf
 	if (!info->irqdomain)
 		return;
 
-	dev_set_msi_domain(dev, info->irqdomain->parent);
+	if (dev_get_msi_domain(dev) == info->irqdomain)
+		dev_set_msi_domain(dev, info->irqdomain->parent);
 	fn = info->irqdomain->fwnode;
 	irq_domain_remove(info->irqdomain);
 	info->irqdomain = NULL;
@@ -139,6 +262,10 @@ int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struc
 
 void riscv_iommu_ir_free_paging_domain(struct iommu_domain *iommu_domain)
 {
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	vfree(domain->msi_iova);
+	domain->msi_iova = NULL;
 }
 
 void riscv_iommu_ir_get_resv_regions(struct device *dev, struct list_head *head)
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 049ca1852d7b..1a30bac88101 100644
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
@@ -1341,6 +1338,8 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&domain->mutex);
+
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	spin_lock_init(&domain->lock);
 	/*
@@ -1467,6 +1466,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	 * any IMSICs or no MSI domain has been set up for the device.
 	 */
 	info->irqdomain = irqdomain;
+	info->dev = dev;
 
 	/*
 	 * Allocate and pre-configure device context entries in
@@ -1490,6 +1490,11 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	return &iommu->iommu;
 }
 
+static void riscv_iommu_probe_finalize(struct device *dev)
+{
+	riscv_iommu_ir_irq_domain_publish(dev);
+}
+
 static void riscv_iommu_release_device(struct device *dev)
 {
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
@@ -1512,6 +1517,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
+	.probe_finalize = riscv_iommu_probe_finalize,
 	.release_device	= riscv_iommu_release_device,
 	.get_resv_regions = riscv_iommu_get_resv_regions,
 };
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 16b3c9c4cf8c..59779aa9d380 100644
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
@@ -93,6 +99,7 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
 struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
 						    struct riscv_iommu_info *info);
+void riscv_iommu_ir_irq_domain_publish(struct device *dev);
 void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_info *info);
 int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
 					struct iommu_domain *old);
-- 
2.43.0

