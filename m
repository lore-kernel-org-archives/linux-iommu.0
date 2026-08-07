Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80537188A
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126661; cv=none; b=gdFU88hSoURkW3Gk0NZgC1d08yJ2mzMPl/N/ByEYHKAjgh/jvJJbJS78zotxSB8z1fkWMva2aJ3HZAcmvCjxiB75vQjSdoEw7cmzKOByjZgekggedVkQYXnraK8iJdSY66TtaNtW0o7Yr/njdRSf3lPK3MmSGyGRxuZSdTJtST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126661; c=relaxed/simple;
	bh=5cNUYnf1WdMrpIKTo1WOuVUcFAUZttru8K0HEwb8qg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5JloNMIs+/swxHg6vlXFMfDsa7xalpIH7oOVJxmFs6BjQnpfUuUlS0+v2gv4eR0z8ee025O7tGpKadZXxKaafds1y5v/ULa1ZHiSKvKdSTWpGFzRCu/5QtXS5G+aP4E3yIFyXIEVzPsLCZvwCx3RA0Zb4oxNLwrpQ5sYTRjv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/PARV62; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VVpnzOZQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/PARV62";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VVpnzOZQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOdDU1224947
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TgMmUWGbDaC
	ex8xfPE/JoPkiNGAlDlO6AUBWxsUjN0M=; b=F/PARV62TQBCDxYDY40B5DjDbjL
	1IjCGfCTNzOmJ9Y3b8uEnRLkg5Nm0AvwiUIWiebqaqfPvZbaTFbqvW5bOgRbTrH9
	lX7mqPw4kBQtxyrYB7R1YpLFNsxmRIvdX8d1kl3Ugt8Iu4ggsgaIniZ/zh2vBlXo
	ylOIHUZch5S0FHySHS3fkMlJ6zmk829RQGZhWCh7yF8YCKR067s8beDzQfuPXGLJ
	nfBfXF9XYYYrP+L4K9pGLycJ7p6BVLZ+LPFx0z0qpGULil79CEU1PbTBLoKueHXi
	sHS8PghFZI/Acfuq0YlK/rhNajxU//xLz8J6Z+APYlIfaUgalBgje36upRg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgem97sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so39350671cf.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126655; x=1786731455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgMmUWGbDaCex8xfPE/JoPkiNGAlDlO6AUBWxsUjN0M=;
        b=VVpnzOZQ8OCudgq1zjJ6Dz2m2JLTqm5k74YBBQp73lVjhSRGRcR+jJOBwuhwBQ6cZg
         rUwaZDs5+B/BgT5iSkanCYMVTMksExriC1Z486Ha5ldNBZ1fkaPQa+8BPH87mifPWAKt
         igsWCRDIEZJVjP4PLRU3trYeidXW9bTwlyVTq7+8gKS9MYeNTgF5wOJt9uyj2bkPf5n3
         gobE8J3ldjMqMYUXL1EEDrM4Iq4F0UcELo2ep6CchbcRR6r/fAtCW/nSOlTCr9sbpWkj
         h1aNkteF00bhwaKgZA6u8mIL5XXhATonnj/03N3aoJUsHMBOtPEZSo6v9GMt93HQpQL3
         66Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126655; x=1786731455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgMmUWGbDaCex8xfPE/JoPkiNGAlDlO6AUBWxsUjN0M=;
        b=rC8YauTuI5U4oUSxZH1ngs3KOqJ1Y9f7w20hvM763Ydgu9rzJm88DYhVgGaTd/34L/
         7CauZR5T81oyOp4kcsnLnbKmpuzDeSK3T1LIS2WMi3mmV3fWTOzkH8EiIZGVBPIQ95bD
         tTi9iO0B1Wwea375Qxj+ycbPZECAn4j6llUGBey9YHmLrG/PJDLjz24iSEdxsGk3xb/l
         njFxkSGzfZ6QU97GPXCdNQ8EpwPEPwfcpHy+oazr7J+cHaWxiFvKUpgddvwCJGnJdO7W
         BahfVfkudfV2+04/aGutT1zdFku36218IU0w3ArNnAQd9W/AHj/7l7ZT6/fiUwATBUdD
         LDfw==
X-Forwarded-Encrypted: i=1; AHgh+RrqnRnRnSIBNGLbE2Uu1niGRI0CK7DnRTn5jJwWdxdy4bKtGPHo+BbHclgC1dBBac3SyzxTgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkTK8sCB7+tlXFLFM1azsNRclVDCBq1lyMKaGw19np4gngG443
	UcljnpojHbSkMfdm0MDsRheuqd/hpvsG8qT5Y/RViW3MWK9Xce7DCJnYLz0t/xYWZUQVzPA0RZg
	HjaT5RWZYDu9V3kZGbmzJn43QEAbzB+0+OFAcqkzTm36y0Nyih7b3tP0d/Q==
X-Gm-Gg: AR+sD13rnBkwfextxN/PmlzgB+PZcHi/Da5EmguemMCXCdWW72i8WEDZlvOY+De/3xT
	7DZfRB+fvRO4F9a7lOE7V5GwllkFm/fDmIeZUnkTNUODRfv3W6vJqNkhcNzmYTev4TLz1ySPpih
	SuL88r8gEP7arNJS54UzuMuLyyytghuftQHMqMfqVYlsymittoBun618biv2rXnvTL/Aq9yIyrK
	6M+M3kS/gVt9oz+5uKBi/VOPVj8nmoKHSgnTMZin4zSY68KIWuGgpizGcVJMZuB+Ic3PieE6vkO
	BX4oWR7RGA7X3IykOJykcdbHFsxZNkKUNkuo7TfQrEfcIoXdMRIQomtzXVFWKSDU2Wdj/sgDWZA
	9hQC67rrrrqBB/x7Csfw2SLMYQSeMMWv3b2NKUxo=
X-Received: by 2002:ac8:5905:0:b0:51b:efbb:fbf with SMTP id d75a77b69052e-52d209830b2mr33956561cf.18.1786126654809;
        Fri, 07 Aug 2026 11:17:34 -0700 (PDT)
X-Received: by 2002:ac8:5905:0:b0:51b:efbb:fbf with SMTP id d75a77b69052e-52d209830b2mr33955871cf.18.1786126654302;
        Fri, 07 Aug 2026 11:17:34 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a41sm83503666b.5.2026.08.07.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:33 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 09/19] iommu/riscv: Publish IOMMU_RESV_SW_MSI region for iommufd MSI remapping
Date: Fri,  7 Aug 2026 20:17:03 +0200
Message-ID: <20260807181713.228535-10-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: EnpG-Jyn4b5Yb3fsPj7NbJFU1sza5Rd7
X-Proofpoint-GUID: EnpG-Jyn4b5Yb3fsPj7NbJFU1sza5Rd7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXwuGBSBCeWmT0
 OMKptv+3NN9/aeyXpd0LFuNGb97p5bUF3HmZKGg/jIe2YoiGPHsGTaYkk07Q4DVN16SxBoXgJiu
 xM7hz4fG1+jUeDiZx99NPN6ugcsloQ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX+5TqovLWD7n6
 XPB/3AtTjcnrS8iW7e18u+01CVUau9zR11yYDf/rp20gULkn/s9DHl3+LclkWKGVCp3Lunb4Hkf
 ZDBJ+oC0BWagt8gWL3MdMR1AEy6Oa82Jg3Ku//Yclvj6zsM8Vz46N2oa5/Y4CZ/gEGt3aUEQqG8
 lAaQlS1SffW0/gxDYSAaF4wAz3N8/uBwnOp9m64XHE50OgRbvUdihn77iwF24IC7k06c45xWlUo
 OUhunCRSTBUo2jkNZTPfgukEPRD2ZNiBRdiB6sff6ZHr6WBl0/nnOYDudIUOJBY6iBa6/hUSqHo
 GPGBbTRA5G6q0GhXdBD9bGv6qlW4ni4xZ5G/WctqsuYXtNOkk2+fOYmcr72miJxm6l1fUV+MQTN
 TvHS7/nmmTJbHxB9vIyBb8Hjf9Me5hqQuTxk5xkbQKq8K+t2kGIXH1cPfc6NwR4QwFg3uHC0GfF
 dawSUMi+ljTOwQFfUzA==
X-Authority-Analysis: v=2.4 cv=X9Ni7mTe c=1 sm=1 tr=0 ts=6a76213f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=yKliekd0n2ghiC2AktsA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

iommufd's SW MSI path (iommufd_sw_map_msi) requires an IOMMU_RESV_SW_MSI
reservation region to know the IOVA base (sw_msi_start) for MSI page
mappings. Without it, sw_msi_start stays at PHYS_ADDR_MAX and
iommufd_sw_map_msi silently returns passthrough.

Add a get_resv_regions callback that, when IMSIC-based MSI is in use,
reserves an IOVA range of num_possible_cpus() pages starting at
RISCV_IOMMU_MSI_IOVA_BASE. This is large enough to hold one 4 KiB
IMSIC supervisor page per hart.

RISCV_IOMMU_MSI_IOVA_BASE is set to 128 MiB, matching the ARM SMMU
convention. That value is arbitrary for ARM too; its introducing commit
(f3ebee80b313) calls it an "arbitrary MSI IOVA window", so there is
nothing riscv-specific lost by reusing it here.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 16 ++++++++++++++++
 drivers/iommu/riscv/iommu.c    |  8 ++++++++
 drivers/iommu/riscv/iommu.h    |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 5873addf2a1b..1e157faf7bbe 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -117,3 +117,19 @@ int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struc
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
index 27dfd60834ac..106cc8216942 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
+#include "../dma-iommu.h"
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
 #include "iommu.h"
@@ -1493,6 +1494,12 @@ static void riscv_iommu_release_device(struct device *dev)
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
@@ -1502,6 +1509,7 @@ static const struct iommu_ops riscv_iommu_ops = {
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

