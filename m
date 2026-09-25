Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F8175A88
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349455; cv=none; b=FVbQVB+tYm9SQbhAFK6v31xNZRX90B/QNUYUB0B70TiecjtrqeJDcVPW/yJT9tjAVcdTBxz46heCSZBGK/OfA/KmvsgMNSwzxV5P0p8rio1ll8NZlfAg5TsHkv0hDJfPdRWlz8wB+yQeUVhAPln23qTOCdIzRnmpqfJK2NUenlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349455; c=relaxed/simple;
	bh=vCiGoeve7/m5DzRJKRKVqLe6Bc0vLfbKZfQYlwbn3cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Frxs/uiTV1GEZt1ZJ2hUL4iim8fnbG9x004PRnOeO21EgZU3mJjuHGEoOlHexj4n6Xz3RJd3cuUCuMm70HEqkTQ7I3yTWcfLgiSMfeB5xnXmXvfNIWpyJUyyjKWeWncvzfWr0FGu+WuNmJHcPXGs9jvEGpJZ649YLI4nW1zqszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BpDScuyJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CxPfslng; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BpDScuyJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxPfslng"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PD80CR289464
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PmN9t9ymHRy
	FP8JsM12YSqld9fh7hnA5QJjnse58yeI=; b=BpDScuyJtM1lrAVqbIJCth4xhvG
	JizM97Mz/bfWWayP8qsOsbW7ct7pqyadQpoRQOsWMvjaBZUQRsWlia6xIl8ZU1uy
	HguR7Yp5ND65cJ64Z+vk1IdVZ68JrH7bKpWbmFAc+HowkeAAP3o1Jj/ycSACQpJe
	p8yjRuf02181L/EohWq/4jM3ZZnjOmtam/zDtcrGI4QCs0qTEHYRPncSDjBzkVel
	ejj1kQLy80OQog9AKxcQmw7PO95en7Fnz8JN0t2kasBPOsDVygCbTNWt3Io6MC2M
	mnan8Wfg01UtlmauqExY7JL6C6DG7WhGOR/FK0Ci1Sx4nyYsn1xZI02G4Pw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881v4tk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:21 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78a58df134aso247107137.2
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349440; x=1790954240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmN9t9ymHRyFP8JsM12YSqld9fh7hnA5QJjnse58yeI=;
        b=CxPfslngnwTWUKuQONUqBGuw6YpLnmSzw4cQ7/8w+nO3UkpQluHju2ltMdgyviKSvU
         tZPsGS3thF19fXeic8/Pfaxcg9ql/j0PkOlsgxGfFtsaxJqNXNzNoqKG7nYM3qVf1i8O
         JohaKxxfVaQ+KiwlHrKbkpyycmitrKRhYwvbL20ihWyy2bn97SHA88YKNJ46aKfGM/eB
         QoefNDs2jw+V0dI2OGa9urbEaYBpY7f96jGQaCW1Ch7IjLHZEDAduF37QLkDizR7sGWh
         H6cmmMvS3fchrWYPFzqaBdgPf7f13avFQutWL+3vQuC1Ykr3eULK+/ilHubmrPk3MYC4
         V0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349440; x=1790954240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PmN9t9ymHRyFP8JsM12YSqld9fh7hnA5QJjnse58yeI=;
        b=euri/FtXah+NW3bBA2vYiAYAqF6urU7fFwJR4jRrRpExmvyPts70RKGyPRF7Rh1p3P
         pBt66JXA0WJzCh8yMoYfeL6x5ZhX4/VkZiRnbi9FhEWY6/TpGe7UBut45IBT7Dg9jAUm
         R0OZ7bmlw/N8dn+kEuZWs4hyqcVI4RdbMJ02pMYR7mDG5Fw7qaVjT7FebSDqIzzzDiXa
         IETDtMhdEzwJ/C6kpTdQYfnYvyksYuKaH0mbFpRYxCBFn7LKzLDRvUfCW7xchDQNOLCk
         t6m1/l3CgwnWyVNFc1a6FydZTFUQToj7vjP4u/tuou3y+miIKWTE2tLYIUanp6WcMzYO
         b0xw==
X-Forwarded-Encrypted: i=1; AKwUvBxmy0/ZNCj30ozTtwjaTsCvcSzggP5ko8zK4ltnUM50yegsqf39b6rSfjPxLI1DZasWVcxdUg==@lists.linux.dev
X-Gm-Message-State: AFuF++mgOYZADlo3hGVPZPM6NHQKSNTi+0kMGywIAs44lvlkkbeSJZJh
	laDQfVJlA3mjTqCScDyyqwjjwE1a9+oRBVo6Tetfq5D7xHBVYp6qZ7yyYo0Hq2hTsKpk79j1BZF
	sMguTOrfjAeSe6Zok/UyFsX8/Jux7QMDNlaNTjw7RtJBYQdnGnNcVPQa2gg==
X-Gm-Gg: AYBFou29ekZ9QKlWsvhGFHeLecgUNrZ7YnW7FEApaY5XS7x04UrOvc0prSnAv+Vo+yd
	c3zN089CwGQ8ZG/fYhyV1wiWVDcdHRpcdLf6PWoyWbIkOUHoTA85swuD0khkaluDwNL8ld7lmda
	RWfYTA8/ASRwLgW1JMB0Xdt8K7o3JZso4LI4H7CJCcqlTHVIwGnbTrYGCm46ZUaFdymUfyX8NRs
	NIsQAbiX/9d1vk8x9lblnSKS1JQ2i3F73+fU4i4PZN23Keac98Ev/KRMukCcdrHh0UDAAB07L73
	Vtl1AFNLbf48XSBTn1kll60IvYcHnV0WzfdbO/fC2HdN4Hzem5gktiLJDz0V+F2gG6X9+h/sn5w
	bLKkpvh/zzeU/1UzYyLtycxaOIJjfnr9yjTlhNQ==
X-Received: by 2002:a05:6102:508e:b0:7a3:833c:49a4 with SMTP id ada2fe7eead31-7af1eff6910mr2510078137.26.1790349440510;
        Fri, 25 Sep 2026 08:17:20 -0700 (PDT)
X-Received: by 2002:a05:6102:508e:b0:7a3:833c:49a4 with SMTP id ada2fe7eead31-7af1eff6910mr2510055137.26.1790349439971;
        Fri, 25 Sep 2026 08:17:19 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a4e9sm6689080f8f.11.2026.09.25.08.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:19 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 09/16] iommu/riscv: Reserve an MSI IOVA window for iommufd
Date: Fri, 25 Sep 2026 17:16:52 +0200
Message-ID: <20260925151659.419512-10-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab69081 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=hTxnoE90eIxTBplCLnYA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX0E7aF6VuPjS0
 aUHN+wPWXVzViYxuK/VjAsA7zSGsuUPq6giittpEAftMu5SwYJSslRDfIeq/McdBeHGFUU6/D4p
 EJVPi/iH9kD6sQzyFCddR3AmoMoB/i9cy/NWPIY82oPNCEn3mkUGmRGwh8psN+N1Uy48h2g5u13
 HwXFopNe7reacen1rpf4L0SSR1VarOtiPZHX3dv20RQ2j/Po+oRnvurruf3izl1y4Cf+fhKrXY9
 YLeoKEfE1iSl1D0O9MgCUxA+EoNcaN8ziPiWvxDSKQI8qo3SDlZiUS0wgWn3ZY0C2tDdrMK1bF/
 2ZRbW1qwlnAhJNzUWPyanR0KBRTgWYpaEc5b/0d+hw5Kaz5M3l0jlOLfOGGDruElp4tj4b9ie+e
 rtfRXBWYgNLfz4AYGV/EUDMF6apMOthwBoa9uO5wusx9r2KGxxIglBiG51wcAw3f7UeozbFA9+x
 WqS8thZ1odGJmx5O1lg==
X-Proofpoint-ORIG-GUID: bGEVXg2mCIOX5rKc6cksVblT_9LBcGvm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX23TIp09GBZQJ
 6dnNfrAbhDU+d79r2gF+qNzNIlqgKXJIepPym3WzQ+tlkRgi+i2dJxzjjzoT6GdPBTvowXseMFA
 oAeV8ogacH55FwWgLkq+eQ/jEIwQBGc=
X-Proofpoint-GUID: bGEVXg2mCIOX5rKc6cksVblT_9LBcGvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

iommufd requires an IOMMU_RESV_SW_MSI region to allocate stable IOVAs
for MSI targets. Advertise such a region when the device uses an IMSIC
MSI hierarchy so interrupt remapping can map IMSIC pages instead of
falling back to physical addresses.

Reserve one page per possible CPU, sufficient for each supervisor IMSIC
page. Use a 16 MiB base instead of the 128 MiB convention used by ARM
SMMU. kvmtool places its guest IMSIC at 128 MiB, so with IRQ bypass the
domain-wide guest MSI address match can also capture host-delivered
MSI writes to the SW MSI window and misdeliver them to the guest.

16 MiB falls in a hole in the current kvmtool and QEMU virt memory maps,
away from their guest IMSIC windows and RAM. Keep the window below
4 GiB so devices with 32-bit MSI address registers can use it.

This only avoids known conflicts. A VMM can place a guest's IMSIC at
any valid address, including the chosen SW MSI range. As long as a
fixed SW MSI window is required, changing its base cannot solve this
in general or guarantee disjoint host and guest MSI address spaces.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c             | 20 ++++++++++++++++++++
 drivers/iommu/riscv/iommu.h             |  4 ++++
 drivers/irqchip/irq-riscv-imsic-state.c | 22 ++++++++++++++++++++++
 include/linux/irqchip/riscv-imsic.h     |  6 ++++++
 4 files changed, 52 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index fbdca69c436e..dcad99131670 100644
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
@@ -1514,6 +1516,23 @@ static void riscv_iommu_release_device(struct device *dev)
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
@@ -1524,6 +1543,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
+	.get_resv_regions = riscv_iommu_get_resv_regions,
 };
 
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 5676001548cc..6d5c70e9ac6d 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -15,9 +15,13 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#include <linux/sizes.h>
 
 #include "iommu-bits.h"
 
+/* IOVA base for the SW MSI reservation */
+#define RISCV_IOMMU_MSI_IOVA_BASE	SZ_16M
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

