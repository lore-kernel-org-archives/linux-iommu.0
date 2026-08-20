Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94ED486E43
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262135; cv=none; b=AgFSGUZ7zRgWQ39UNk127OQ7JMJjMFLGkZ5Ea3bhZvjB5JlZ72WVztEHolm5DLepa1/f2NkPd1px9f0tKlRL+ACyvL0F4krISIKo5Ub8z1hgao+Cyjhp/R/71c/KMH3IDv74iKwtP3mLuB+4m+iYNXQDOJR2oE8CUGzIz9GZoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262135; c=relaxed/simple;
	bh=3A9lZ3VNdw/l5skukjj/31dqk3pdpFsV4s142EYW0NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4dyQfI5rtuz6MRM2yL0I9RFtTYn4V0GIcIWTOG8BjSu06/hhqt7wHnwup07dPQ5rH4IV6Lb1yQnNsBrqR07fIGjAWhUUp3II2H7x7kfPHXSJkFeCDsjCNl144k0048OH+I0Be1s/jubWM3PJG7+P/etAVn36moB+zj19nD/6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JvBqKBBp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OVh5hfNs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvBqKBBp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVh5hfNs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7RHo1298358
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PqI0T7aNqdu
	73yqm0QgvvFNxKg2cPPoGg0lQ1xGoiRI=; b=JvBqKBBpB5lJ6gDftkR4DjhYHyu
	itnXLW8xtDQlmyLU1lOl+r6iz3vGH8QPXzGbwGJKwVyc9I+ebuXFv7evmY9vdjkB
	twtSZOhCL0SYf8lzItaW1ndP9miz2GJku0Lk+ZxoabaiC+19nB0dvrUG/9csEaIi
	DguWL9Ie7lGrFzqS1h1xO82s7eww1tscueKU3Eu551bC3w3gu81jXAz/JRiZWvAM
	ezDjQWP8XqOozlpGH44eXpO139hfym96kG2pSGx17zsIaGnvkk54W8oL961fhZ92
	09vWQDRz4/HJTIHq5Ef+RiAL29WZMh3Sqq8mkM/rDDD934KxK9NkwEpLXvg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vn8btbp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso4904971cf.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262131; x=1787866931; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PqI0T7aNqdu73yqm0QgvvFNxKg2cPPoGg0lQ1xGoiRI=;
        b=OVh5hfNs7ajZ2NhBezWtTdGOICvI+dcJHuX5EtYo31zjMcihRKXd0435i03wF8lVJJ
         hi3fLKs+tLQ3gWjRWNXK6nI7iSIHoooqIsURQOXN9y4slNxxRie6MxwLlQOwBJjThpVL
         EVWY4ZqXAP8yS68XfH8CAymkwBnS1sotH1kHLYgavVWflVrnyczIENzUcVrQbfK8F52l
         8hiQxPPBD50R4SMnC8HtDxarlo3xB5ab7ynuTxj5TXVgUuw5GeM7XV5GiQ8eU6GqWVXs
         MQbIlXZWM3vzxo7M+8oeGwvpXOK3Owcy/wAhxAq7XzEP5miRHUvfQXY474BtcviwoUtj
         qHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262131; x=1787866931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PqI0T7aNqdu73yqm0QgvvFNxKg2cPPoGg0lQ1xGoiRI=;
        b=Yvqf06+GlasXy6i14KmkLEt5mdLdU6GJQbSyXbb4skKMs7oEjOGOPup0plJQ6mTKe1
         jJH1KFgmdK6C1DhBg7ab/9VoissEsB86ofWzVPkuPvNkPN2+Vi2XYryhxTGO6504QlVq
         IA16pb5yKBGtps1pBEFfl6r/20j+5g8BiqNMccATpWoW/O2jfZnbfLIy0tTuiQeHfG5g
         j3vUXDwnXBjlrp8gtoxl22racXqWGLtoLfysWmwPhWSe3EwPZ/iyp6AG5yq7ImA62hNy
         v4erKlZDd1Wexulh9tDLi5fIZHZc1P2uTRGy+CUEtRAr1JqAHtrptrEx+D0yW7IvjHZ+
         XbAw==
X-Forwarded-Encrypted: i=1; AHgh+Ro34yyWXGQHsvJWTfE3nKV29UVrQrk6z/ATZlhzv60Lc79GO0V/tyZAMkTllj5OlO5ROq1uTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/yEo5UCMruoZQNWl7R7Eq3Q16mHGGNNG+PbFIp+Fk6B0wHc0O
	MkAmOLRZfvSer+2B0RTpE+xPm1EP6V1uaoq5mPiaMd9rhP+H8rIxznsTIWrb2EMjjLu78qiHbKG
	t+sLdchKkl025As1MNFpN82ro7NJvpPM7TdUEAVrWRcSg7HUsCjDzmiktMcEqF62+Zg==
X-Gm-Gg: AR+sD11aEon4UgODEGdqviOmZ/Z7U4ub0fWlKTiX3a09zhaGaz4xfImQpMYaEn2exMJ
	Ib/zCQKTm2EG9h9xJ5x64vEzCfnepXYaQXP3EUXTqIaTk5DJlIC5Bt5ifgCw+1Xm+bkHvqq+K6I
	R/prwkTCStRCMxMQsKJYzb6SlEerS6F8bVpMNEqjTgok0C9rGbUsmslOnafcBoNv30Z9Z35lvP7
	vbuL/EorpaQvgJtpS508GpRIbb+EksIiGPmBmhJwWMh/s7INgQWL4Z07Lx1NU2R00XBrxRyZNDl
	rnpzF1/1x59le4PV6mckOmkl+6paag/2DaaGo46kBz/DKFTXzj54qwlDfCUGxziCigXrPIKEKzD
	HpMrnDLNR
X-Received: by 2002:a05:620a:2556:b0:936:901b:2187 with SMTP id af79cd13be357-9373945cd97mr143200685a.12.1787262130753;
        Thu, 20 Aug 2026 14:42:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2556:b0:936:901b:2187 with SMTP id af79cd13be357-9373945cd97mr143195485a.12.1787262130315;
        Thu, 20 Aug 2026 14:42:10 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8038sm13693642f8f.20.2026.08.20.14.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:09 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 09/21] iommu/riscv: Refresh platform MSI domain before IR setup
Date: Thu, 20 Aug 2026 23:41:38 +0200
Message-ID: <20260820214150.545737-10-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX8Jmpx1GDCQFt
 F4uLD94x0CeVyuc5rHF10EkL+uwuTH+OT5to/vws8t5NIQl5OZQomSuF7ljQ/rgsM0BsQo/vtpH
 NwvGggMwsLwNVKeO3qynmP4Qwh7E4FndUPctRBHZFcs8clY0scmHfFiR0vVn6gXk7YrdUnn5GEf
 3/Wx2XE+ajKEpTUVwV5Qh+OHLzy82btpXK4Pl+6Q5prRt/hjxlVSuYANoGmgGTNTujMbMndXfq3
 0OiKCV+g1xXwnqrbnuFT+ZX1I/N2ErRkyrxu76M40DDR8EzL8LrvtIJbYgRyeyblYAK5Uym+5F2
 3ZEHZe7l/yTsPlJS3xZTle6ZWCmEDp8T+cYJwI+kOWZnUJXnbABX41luyYo3XipEAv8/mtgPt/X
 Emy3knOhQrzwJjrMrbUHO5Er9cmqE7jihcXmrW66bNd7JpIWolLdlMvtvhgWQnjemMMEYNRFhzG
 xiGjmgPhEHWtkC/2wfA==
X-Authority-Analysis: v=2.4 cv=KpJ9H2WN c=1 sm=1 tr=0 ts=6a8774b3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=lUV-CE40vsJ_jsYSlhAA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfXzdPfoSLUC0lc
 psgaguhlaC+lqVp/doJvA6/fZsYOniQ4BWnrdxihN9/VPH5x0Ya71kOhURz6uLcO3etDnDw9xct
 6uNYImZ7BsSPDDEaqd+khxzRp41waK0=
X-Proofpoint-ORIG-GUID: 9IUkZsFi84Mxho3eORkC9Z0zZncX4lt3
X-Proofpoint-GUID: 9IUkZsFi84Mxho3eORkC9Z0zZncX4lt3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200162

Platform devices receive their MSI domain when they are created. On
RISC-V, the IMSIC is itself a platform device, so consumer devices may
be created before the IMSIC driver registers its MSI domain. fw_devlink
delays consumer driver probing but does not refresh dev->msi.domain,
leaving it NULL when the IOMMU probe_device callback runs.

Refresh the OF or ACPI platform MSI domain before creating the
per-device interrupt-remapping domain. Leave PCI devices alone because
PCI establishes their MSI domain during device setup.

This mirrors the workaround currently used by other RISC-V platform MSI
consumers. A proposed driver-core change would perform the refresh from
platform_dma_configure(), but until that is merged the local refresh
avoids silently skipping interrupt-remapping setup.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 0aab0efeb70e..3e08249015cd 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -4,8 +4,11 @@
  *
  * Copyright (c) 2026 Qualcomm Technologies, Inc.
  */
+#include <linux/acpi.h>
 #include <linux/cleanup.h>
 #include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "iommu.h"
@@ -53,14 +56,35 @@ static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
+static void riscv_iommu_ir_refresh_msi_domain(struct device *dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct irq_domain *irqdomain;
+
+	if (dev_get_msi_domain(dev) || !dev_is_platform(dev))
+		return;
+
+	if (is_of_node(fwnode)) {
+		of_msi_configure(dev, to_of_node(fwnode));
+	} else if (is_acpi_device_node(fwnode)) {
+		fwnode = imsic_acpi_get_fwnode(dev);
+		irqdomain = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PLATFORM_MSI);
+		if (irqdomain)
+			dev_set_msi_domain(dev, irqdomain);
+	}
+}
+
 struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
 						    struct riscv_iommu_info *info)
 {
-	struct irq_domain *irqparent = dev_get_msi_domain(dev);
+	struct irq_domain *irqparent;
 	char *fwname __free(kfree) = NULL;
 	struct irq_domain *irqdomain;
 	struct fwnode_handle *fn;
 
+	riscv_iommu_ir_refresh_msi_domain(dev);
+	irqparent = dev_get_msi_domain(dev);
+
 	if (!irqparent)
 		return NULL;
 
-- 
2.43.0

