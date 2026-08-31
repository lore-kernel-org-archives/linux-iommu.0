Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21E4F798C
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188411; cv=none; b=lKFkGrssf4GaXMQFi1UiEm+iwe6it9Hpx19YcpRJQYAEuf7SztFcqgLAyxb6y8NI7NnoeyTzs2n7bv9wk96uEZWKHR0r0NcwHE4ujp37Nt4ZMnMcH6JwMbCOei14Ehe9gwaRYtPtO1qah+d5dweLtkTclnrwYfFJq9tG+Lep5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188411; c=relaxed/simple;
	bh=FxOkSusMwwgA57maJoZ5Tokkk4uc5SRbCD29XwvmPPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8gqiVv/DxSxtlPOmjP319DSNnwp8BH6ej2UFh4eQr43NQEcV32I/YjKg1a+5N/tHbM2lOHtGO3Romt8bFVWhB8ww7S9p3Ot+KW2VyLDqSIQF5sP0ut3XUT6oK1VprR7Vg4ehQV97M7Qy02TtMXAr8DiARuFmhJVO+RPEbMluA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cyfmv5fS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SWrddnZJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cyfmv5fS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SWrddnZJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEUOkg4052174
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=erJdfcvgU79
	8yKk0LLoInQNv2dnmFtm4EhSECQcyWlU=; b=Cyfmv5fSow5IUqamY5U95g/c2F8
	JMEWTvooENBKckR0xkuMuycoqLXuhI8oG7f1beDM/WUHpP8fngxw2hHb5TtONZ2S
	i1GNf4RSZcSrV0h59A9k6lSkzE/BH7r1AfoguySj6+tihPhBhzUsifmPH5iGv08F
	v1btixD+edIpLO9nclfapIOQnZIQALEx34W30GUEJ0Mswm+AqNR0HJcbY1n6QlYi
	ZlL4AmFXBDRZ+sGQqrGdif6rgSxexAAu8mJsmI1udBZ4HZH2yZCMfKPe7FflDhmN
	q3OYW1liQU4y4IB4odTOX1D4YEQrORcfQpjGFsOS5pjmKQrp1bucPLnhcIw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6jghfyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so552616185a.0
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188407; x=1788793207; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erJdfcvgU798yKk0LLoInQNv2dnmFtm4EhSECQcyWlU=;
        b=SWrddnZJPuP6yJVzO9g09ZLZH3wy3G0LZSaHLXKyzqR1TYXUtL8yfejdM8J8rEtwAh
         AaP0uTyxLSEXbUS0R+IZi/WJau+LLWYLgnBh99zC5e61r9YPHUWjAH3r2NjIBCFFOu1I
         +hjMRtWVEaUxQd7d+qqFlK7brxQrxOsyq4L2fcX0yWKIyWs8kh/yJwW2YMuMjbOBcr8c
         Cc3gho3o7fb73wSJkBoXjIzH/Y6Sehta3aMs79aIMTLqVDs7G+alIf48Z2u8Wd3PS1s2
         XBz8Zrvt66C4QGR1Aj2F579L4wd7M17G87+mB0MQdWyf099wckTEk/O740dARxzPruPY
         LynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188407; x=1788793207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=erJdfcvgU798yKk0LLoInQNv2dnmFtm4EhSECQcyWlU=;
        b=JyS5+v2eitABk9TrOVmgaZ/Pif44HItPj2HLeerJC6ZggvbiDiipy5cInVE/o4/02P
         Sjvje9z0DBSO+xOwg1Vayx2430qMD2QIXp4BUIchVpbk8LlxvrMKsmNhLFcg2cPwMg39
         GpTalmDZWMnUWbClvYH+EcENGZa3LBWoi127Bbz/sHpByQAqpE+dZyV1ksOLxgopCyIW
         Xt9jmGy346oH+DVQIOhdA5Staqbw8t0bJ4h0deWu4gfQOMby9xhtUlleFaHQxTHlg48M
         nVQqWOPNZaLbOVl2ISMRIxdrMcB7YtIUqQrMr29odAETrNDlWtSTy0g3Dm5PFWKLKZcu
         jmyA==
X-Forwarded-Encrypted: i=1; AHgh+RrIxuvxUZhetLOBHY3kSjUhe2V3C/eHaasW9CklBlVd6y88coTsPaTP0bjvuVAdA6Dj6uzBDg==@lists.linux.dev
X-Gm-Message-State: AFuF++lDJ3qxbSMaDVaC1vnmj8nzoH8GEWmTKwSNNExT0Jjb6Pm8yhdZ
	tptfGYXHYwJQsYL1nK+Xf/7eYlIg7H2funEmiC5Ve7Z/GvB+5zuuQ6bfwFuEmq/PnPT2T9SedR5
	ykBOk1p/Z4p0nr2gblLZU9jVP3jCY6nhs9+MtJa7sFATqr9GD00GUgy96zg==
X-Gm-Gg: AR+sD105u293CMKfNPt4Psog94oa7XCp7jzYSBMOrGwxFOsBBUFn/pmpME+h5/INCLj
	xJDIpPVlDKklEdCV0uDAfHrDrtTQWFn2mSHERIfR/vI+x7TvuvnskaZvAzxbQ9ujrQWdRDiCaJd
	aik4VRAW9tK6OQrwyk7n6gtmgwcTpjpnqV9HJH1h8fgzlgPjcLT6ekIe9q/e+AmUmX31dPwhavI
	1lv4kwXEZO9YaXaZYTfyGzrCcAxmM4HIj+qhr0osWWtm9aIJyii1XklnEh6NIeNICzM+7ObtuGV
	ddEb7ywbsqYdUECrDiv31fQrKJXvKKm88DENyPxV+F6FRjnIefJ9I/D4EvplGZmSgd0H1MXhgUZ
	XARptgr8m195LNaw8YZOm8wqk64tfTRPaRcw=
X-Received: by 2002:a05:620a:1a11:b0:936:9525:e952 with SMTP id af79cd13be357-939481360bfmr214547785a.41.1788188402184;
        Mon, 31 Aug 2026 08:00:02 -0700 (PDT)
X-Received: by 2002:a05:620a:1a11:b0:936:9525:e952 with SMTP id af79cd13be357-939481360bfmr214540385a.41.1788188401647;
        Mon, 31 Aug 2026 08:00:01 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd2e9d9fcsm219790525e9.1.2026.08.31.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:00 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 10/17] iommu/riscv: Reserve an MSI IOVA window for iommufd
Date: Mon, 31 Aug 2026 16:59:36 +0200
Message-ID: <20260831145943.313726-11-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 76x1BXPtXcFVr09V2m5tCHQHZsmHVSWu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXzIx37Gv5x/O6
 E2z0GewGRiS7iHGRZBqttu/q0+sc/x4QoElclIQ94i+/7BeI2wgygHsvyj6AhRnzZcXhDdgjnXR
 fZwn2oPzpsI3bUbVc8IUhdnBy5iFwVQ=
X-Proofpoint-ORIG-GUID: 76x1BXPtXcFVr09V2m5tCHQHZsmHVSWu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX/sjsYV/ze5ZR
 GAtJQVDJC3lplbKl+gY4tyhJoztXxS0v5r5DZ7EWP9rZjAy6Izt7Znc9SHRF//Ml/254odKAhYX
 +IXyn4Oe4GCzvj82hGChDavY5hIffVk5Uzcv/M/b5uFUPQ+aTg2ie+wo0LvHcr+niauU7GiQN4Q
 zmsRqPmFFEDfIeLkZbscu15EWikRf30mzfzydLUdRm8Xxzu0ItQHMXKl81nLa8T2hTvrL6Fxoi8
 LTMCIR9FPTL0IvugceUrx3It8LAszPp87gZlnZMOo3oz8vRggJjbkkoWTHzpaf6SkYrvoSrbfh/
 UsXaCSyqz8p9YGQ5NM/+GijEiN5f25gKVAJ1V1x7SgOCQctxfTU8XIfNHSNaWROprie7yNWjNep
 LK8LBAesZiu3bODhd1TBYbbuVSg6VosnEXtRo1I0ZuCuQyFEjIy0oC1jZgC3vI1Rjk/9chPiWBY
 9I1Y9fcQgjvCPvDqwGg==
X-Authority-Analysis: v=2.4 cv=YsY/gYYX c=1 sm=1 tr=0 ts=6a9596f7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=BnA8ekc9z0NdPsKvynsA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

iommufd requires an IOMMU_RESV_SW_MSI region to allocate stable IOVAs
for MSI targets. Advertise such a region when the device uses an IMSIC
MSI hierarchy so interrupt remapping can map IMSIC pages instead of
falling back to physical addresses.

Reserve one page per possible CPU, sufficient for each supervisor IMSIC
page. Place the window at 128 MiB, matching the established ARM SMMU MSI
IOVA convention rather than introducing an architecture-specific choice.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c             | 20 ++++++++++++++++++++
 drivers/iommu/riscv/iommu.h             |  4 ++++
 drivers/irqchip/irq-riscv-imsic-state.c | 22 ++++++++++++++++++++++
 include/linux/irqchip/riscv-imsic.h     |  6 ++++++
 4 files changed, 52 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e5818ce44515..7c4a250d61ca 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -20,10 +20,12 @@
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/generic_pt/iommu.h>
 
+#include "../dma-iommu.h"
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
 #include "iommu.h"
@@ -1492,6 +1494,23 @@ static void riscv_iommu_release_device(struct device *dev)
 	kfree_rcu_mightsleep(info);
 }
 
+static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct iommu_resv_region *region;
+
+	if (imsic_dev_has_imsic_msi_parent(dev)) {
+		/* Each hart has one S-mode IMSIC page, a.k.a MSI target page */
+		region = iommu_alloc_resv_region(RISCV_IOMMU_MSI_IOVA_BASE,
+						 (size_t)num_possible_cpus() * PAGE_SIZE,
+						 IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
+						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
+		if (region)
+			list_add_tail(&region->list, head);
+	}
+
+	iommu_dma_get_resv_regions(dev, head);
+}
+
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
 	.capable = riscv_iommu_capable,
@@ -1502,6 +1521,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
+	.get_resv_regions = riscv_iommu_get_resv_regions,
 };
 
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..078ed0ea65bc 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -14,9 +14,13 @@
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#include <linux/sizes.h>
 
 #include "iommu-bits.h"
 
+/* IOVA base for the SW MSI reservation; same convention as ARM SMMU. */
+#define RISCV_IOMMU_MSI_IOVA_BASE	SZ_128M
+
 struct riscv_iommu_device;
 
 struct riscv_iommu_queue {
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b8d1bbbf42f7..df38a7670a89 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -64,6 +64,28 @@ const struct imsic_global_config *imsic_get_global_config(void)
 }
 EXPORT_SYMBOL_GPL(imsic_get_global_config);
 
+/**
+ * imsic_dev_has_imsic_msi_parent - Check for an IMSIC MSI parent
+ * @dev: Device to check
+ *
+ * Return: true if @dev's MSI domain or any parent domain is the IMSIC base
+ * domain.
+ */
+bool imsic_dev_has_imsic_msi_parent(struct device *dev)
+{
+	struct irq_domain *domain;
+
+	if (!imsic || !imsic->base_domain)
+		return false;
+
+	for (domain = dev_get_msi_domain(dev); domain; domain = domain->parent)
+		if (domain == imsic->base_domain)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(imsic_dev_has_imsic_msi_parent);
+
 static bool __imsic_eix_read_clear(unsigned long id, bool pend)
 {
 	unsigned long isel, imask;
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 61af3a5bea09..662cb0442424 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -81,6 +81,7 @@ struct imsic_global_config {
 #ifdef CONFIG_RISCV_IMSIC
 
 const struct imsic_global_config *imsic_get_global_config(void);
+bool imsic_dev_has_imsic_msi_parent(struct device *dev);
 
 #else
 
@@ -89,6 +90,11 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
 	return NULL;
 }
 
+static inline bool imsic_dev_has_imsic_msi_parent(struct device *dev)
+{
+	return false;
+}
+
 #endif
 
 #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_RISCV_IMSIC)
-- 
2.43.0

