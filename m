Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212D488D86
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262139; cv=none; b=jISkTGY4h50XLEppzgYZziKLOqTPCPfV3aCyAB1ibsnhOOdxq56Ch4Vyp3ea8s2JK6JUU3Z8YRzHQKrnciqrKzE/vwLocOe7C0ZbDLeE8m/u4l0oukb0yrJTbHxsgBl/lpo/S4nJk1f1zwVnorcrOLofGBkR2gpv2Ggi1Ivbjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262139; c=relaxed/simple;
	bh=0l35s/GNpPBouUtOy5donJGwk+OvGlC47+GwSIYkMDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WT/iN0kJe6iUTY7RaFRi1EJuWn5LenxQ67lVaP/qO1pFH+aaC8LnlNb37Vp21heu/XyzO1yyK5aNywHLxIVgqwbJ2yRsZ/VZNCOJclDy90YMD1t4tEumWHwT/H294/8ChZ9EZvC1xcgRf1uDodl9QDCrfOkPh0QG8C+70w3R1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inZUlJJ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EuvpuS7C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inZUlJJ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EuvpuS7C"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK87hF067150
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v+W5Am3bcCm
	JTpwvkJ3womLHwYPQWXVtn7goz0M95P8=; b=inZUlJJ/PibQYY8ge3i2QBPul4d
	pGlngLpBBEXRRFE9tl//RSQ/xIOAMXp4PzUF6IJjvLv1Mp3ALosH0aoMtdma/bsQ
	Pz3r+ETrNHhAf4wLsW61Q0auN6+zfW1pkpFRQ25A3Ux3ueutkMZRZ2NIBuoIpsv/
	yQ56oeeHtV8pWjsv5swn52Es7AwUVpj9mAsur3M4ZhksN332rA5RNTQDnW3Hv98B
	mAvE3yzqVvMq+htpfWvAOWTjGukeuG4ITROTPghSUDyXIzVduZk97jAJvGe9Wq+1
	qpsUHMH/VdVX7mAlq7IZiZoTO9oMDr3PZcNHP3jotgINs7KSRGBgyE4uCbQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0k1af-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52cd0374265so5211301cf.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262135; x=1787866935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+W5Am3bcCmJTpwvkJ3womLHwYPQWXVtn7goz0M95P8=;
        b=EuvpuS7CoOFx3JRZI+WTrvGIbbIBe1VTYskF2+5nwZOyYfv+zVuG+Yk4OjqM7qaB0c
         GPEo1+KQ1qkwtIoAA3MyNAzEE7I+goSwDFNa43ShobqXZT3GmqOVTrSkTLETjuOHvC4y
         dedknczBKpTZZUsD4gnNwxyyWQLLyXva/9Bg5xHG8I0Yi7Fo9uyE+BH0zmT8HhgTJFiM
         Ou98xLazY36KAnYx1D3jeGerOH6c7XcmdpfO85m+o/WKwCELyKiF8lhp/DwkxpV2G49w
         kSdwnvz813Y9k9JPywOhtQML6Jm0ahua6+HiGgaDpYUi3QkaEUmfLByXhzA7lTuzCFJw
         REAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262135; x=1787866935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v+W5Am3bcCmJTpwvkJ3womLHwYPQWXVtn7goz0M95P8=;
        b=kkgsMQX0HD2thysiwg740rpIdJWefaUYjYkuJf3tFRB6vg1VNq6R9j9gsPKDq8y61M
         p9yup8V/o0kXwFr94t8+etbnH/Bfve1q9O6yRhpFeWvU9xoCOYtYv3zYnm8lF8P7GLC1
         //ip3p1uytbhR1YUf6mpIyNikM1/W23l3pzjXFLBtmL0XqwowObxDdNfFYe13Otg2r9c
         v0NYYWIrWgut1aeDI12CAnVcZ2uaLQqA7FdlpdtU67xTt3jWRwjIYeZTEe9Y8mKK38Lx
         b8r1AIKYgtKr3/uNqPbkzk5EzwkYuZWUg2xQk4ie0YQac+H7q/VA1KQizWrPhrMzl7JP
         L+Ug==
X-Forwarded-Encrypted: i=1; AHgh+RqIpXOOq+2Tboqy3NjvXeY72GJeXltHGm9KMDFhU9PbGFdX800ACWvK2PbU0AezOW2GiAR9Rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwvXJqRrJu3A4vtxrePqe0YH/n+x0ryQhJXCvz88J2gAY2MYzy
	rR+5WsZdHqsa6/zC//shrvbuz7LYp/P9L0zrVUlJfixoO5SxEhwJuRw1tuJF9LAmsRUaRP275ZG
	sZoOCvniPLIFB9ENpX1KEiTYNGDblE69SoM0HQSAExo5Xbu/RSkwPv/o82A==
X-Gm-Gg: AR+sD12tqVisEYWDS8xTrHqJImK5IZWgJnEMzkYqBr3YDIS8aJLHNpsVu7W4jQNow4W
	X0FC9+nHrKrnIghigjibQscs1vFdo1gIY1SDZJnoOCBiA7AT13mMlIoZgMtGZHd6XYA5tDw2fdG
	01EvOSLqR0tO0dGC+S2hguG3ruPbQZZvF08nP9zRDZ58HUCgb0JCzG3ap7NnrH7huYyyIKEhEe9
	RERrREEjwRjHJu/eZ6ZunBafomGqAjXtbFK8xXFCIrvJ5ru6dH+lwbecuLDA4Hau1VQV+qnQd0+
	C+swqbCY1jlH8/EiyT2Zrx+6gCNX6atDUhS6FtKG9MEM26N313EAWA7ICxlyeQ0Uq/KKwCPMrqv
	yp/cr1aiO
X-Received: by 2002:a05:622a:349:b0:52b:71dd:c930 with SMTP id d75a77b69052e-52df5a3b63emr13938741cf.38.1787262135271;
        Thu, 20 Aug 2026 14:42:15 -0700 (PDT)
X-Received: by 2002:a05:622a:349:b0:52b:71dd:c930 with SMTP id d75a77b69052e-52df5a3b63emr13938181cf.38.1787262134877;
        Thu, 20 Aug 2026 14:42:14 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9b79b8bsm425815e9.4.2026.08.20.14.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:13 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 11/21] iommu/riscv: Reserve an MSI IOVA window for iommufd
Date: Thu, 20 Aug 2026 23:41:40 +0200
Message-ID: <20260820214150.545737-12-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: EyvMzGebjETSx2eN0KBuidwu37zz7yy7
X-Proofpoint-ORIG-GUID: EyvMzGebjETSx2eN0KBuidwu37zz7yy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX0rGyCtrwsumA
 drUxq71dv9sp90R7hxgvHONXBKjV4kfKCsCGyW52HETKQgzG0jLjkJr+s4bcn06RnHdryFi1jvx
 CkZC0uqxADqGFP8HIG4/s0imcrHggjXEXF8iTSCDq7jwP8BQCRH6Sq9wZfLz30Ouh4ObYU851I0
 Xpedx32RdIIkEo5upb/PMJGWjiIZsIJEZUYfkjps9wzSvBAxDwcY87nqsK9kyJAOkvFA3yYVRcd
 hfwOMpE+IOQYxoblyIDtmW0C/hQysm3xJMFKm01rASusUJzHAzhckBo+/73WB8arsWHYDFPTiw6
 l1PrAzabb+Y2ztc01Y18GvhZYdGh3+EyXoAyriZRhLTaVYaploZGs/VwZDXHmZcbtvIH4+qR22x
 Jz4BwcdQHwIImBSBFk2kDwuZ53jSfdYbxNKDWc1Hkc0UsNQTbPYQUKNMQ/VjqJhhA32/beseeV/
 7l/S68o3sB70zhe4vAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX1EAZ9Gc6QtPa
 3b7hUV/dsnLfAIKOlP/zdhRfId5RsJUeQTzv4RF5G7KYCudWq2yfgWGZrfFfZhXvAEyhcNCa5Dn
 AaMQ7d5QMpk53XI2d6o8IF+ZkHwETN4=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a8774b7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=DeYf1S9hlmi_p6CgitoA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

iommufd requires an IOMMU_RESV_SW_MSI region to allocate stable IOVAs
for MSI targets. Advertise such a region when the device uses an IMSIC
MSI hierarchy so interrupt remapping can map IMSIC pages instead of
falling back to physical addresses.

Reserve one page per possible CPU, sufficient for each supervisor IMSIC
page. Place the window at 128 MiB, matching the established ARM SMMU MSI
IOVA convention rather than introducing an architecture-specific choice.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 16 ++++++++++++++++
 drivers/iommu/riscv/iommu.c    |  8 ++++++++
 drivers/iommu/riscv/iommu.h    |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 3e08249015cd..de5e22ecbd63 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -140,3 +140,19 @@ int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struc
 void riscv_iommu_ir_free_paging_domain(struct iommu_domain *iommu_domain)
 {
 }
+
+void riscv_iommu_ir_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct iommu_resv_region *region;
+
+	if (!info || !info->irqdomain)
+		return;
+
+	region = iommu_alloc_resv_region(RISCV_IOMMU_MSI_IOVA_BASE,
+					 (size_t)num_possible_cpus() * PAGE_SIZE,
+					 IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
+					 IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	if (region)
+		list_add_tail(&region->list, head);
+}
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 4e14c8412abc..049ca1852d7b 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
+#include "../dma-iommu.h"
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
 #include "iommu.h"
@@ -1497,6 +1498,12 @@ static void riscv_iommu_release_device(struct device *dev)
 	kfree_rcu_mightsleep(info);
 }
 
+static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	riscv_iommu_ir_get_resv_regions(dev, head);
+	iommu_dma_get_resv_regions(dev, head);
+}
+
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
 	.identity_domain = &riscv_iommu_identity_domain,
@@ -1506,6 +1513,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
+	.get_resv_regions = riscv_iommu_get_resv_regions,
 };
 
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index ded18aec8010..16b3c9c4cf8c 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -16,10 +16,14 @@
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
 #include <linux/rcupdate.h>
+#include <linux/sizes.h>
 #include <linux/generic_pt/iommu.h>
 
 #include "iommu-bits.h"
 
+/* IOVA base for the SW MSI reservation; same convention as ARM SMMU. */
+#define RISCV_IOMMU_MSI_IOVA_BASE	SZ_128M
+
 /* This struct contains protection domain specific IOMMU driver data. */
 struct riscv_iommu_domain {
 	union {
@@ -93,6 +97,7 @@ void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_inf
 int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
 					struct iommu_domain *old);
 void riscv_iommu_ir_free_paging_domain(struct iommu_domain *iommu_domain);
+void riscv_iommu_ir_get_resv_regions(struct device *dev, struct list_head *head);
 
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
-- 
2.43.0

