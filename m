Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04EC47D930
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844215; cv=none; b=Nv94jAcFOk/FROpZH2cnkCHGMV++7WV11SjIiVVItP14v1mHkHWSjuF86CzEkCZAoy5DGfqcG5iSs02uNHQ1sChbcNngEUv11OWlzz7MSKKO1BGdzV5YzNLOFFKG49xIWCZ/UZ2kOgsf6jk8KF7XzFZI6TdPlJ0TB8MqbPr0Uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844215; c=relaxed/simple;
	bh=j0MWzPvgoLPGw6n8S8L+DpK+l56gsLOdQ6ijqkKlcaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lF0O+N0uyx43CzSvHzNFezNNyjfGIsIQuaATUMX5OOyZF3rTdOKHwNwz+3tSIderLBAnhnL/uNbDW1k7Fq7gIItIQ19vPH4082AgSpxo8nBN8d8eoZC0gT6EiiAYuJ2oe5ZpDDJ3MnwE9S5EP4atCQEJfwce+h2wryFf0P/OnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DE1yCxuz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FznKwyEh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DE1yCxuz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FznKwyEh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBK2EU3197594
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HLJq5uY1ZDp7/ijaCB204uGa/x909UxX1syJvDVWjDE=; b=DE1yCxuzCQlmubmL
	V3AtreGvA5kmrCbctl4ONQd4Hv99zpbZdPhqDHAHzE7wWUOXpo6Mk4x3OttiUnox
	dOwt2riXsdhnFEKCIagHez2OfQWmbWzzHfM4JcNrvhjuNu9szp26eTrzByqtecwT
	Q+gCN0J/xeGpUBEXBXewdbszX+6lo6iBf4VT7XS1V4ymn+lup6l8hgTgIne2zErL
	8Oe7BqUQB91wp8KWA26cHyp1q1BNG/pcOY21jZqo5wsXgaYP6mp87TkdekxS/lRL
	Z4WANSVf+DZlE4KgBOolQ+Cu25kV+eIWeZdOGEkLdfqjfT8JiY5tavhuh1XrP1v5
	rBqhSQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qb0yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36603ad6709so9581460a91.2
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844212; x=1779449012; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLJq5uY1ZDp7/ijaCB204uGa/x909UxX1syJvDVWjDE=;
        b=FznKwyEhyl4wAWdBIDwfKyNyBIct8SgOeStCsLo0J+abfHHWVj+VpYewJBjEXn2/US
         MAqifDVurvCXsyXOGvaD2W+m+oZztAytZZh7WuKbDNp57cgtqYPNO/4DDsqTLoh2jmZP
         JjcAjq9RQ7LPWO4NzKmcLG3h7Zz6WtU8Q4VgBw+9MgD4cNs9+noLHlEwK+o5xbla6TsI
         EVfl4A6bQ1L6nIHetXCyThiuRWBTx695kf1OblnVWesIpZf60ooXz56nXT6oXVSFxtnu
         NsaicOUFqC6vHvS+g05aaWxKvFvwHThay71MNBTsoXWvJOqm9uUivNwEqWB+Cupg0MPW
         Wtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844212; x=1779449012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HLJq5uY1ZDp7/ijaCB204uGa/x909UxX1syJvDVWjDE=;
        b=Gm9EaIDZ1e4GFxH9yJ4c1LNCTaWYIL0b9cKS+LJSyGrdGbnNN4wT5gOdElu84Y395u
         P2yOwtdL6EgMhLj3LP/Nq7o/lUwIviq6wWnwB3XzbuXB2xTjGTOLGlH5mK1NcsviMU3f
         9pWa/UObrawtWcbwxm91uhBLdmTxk37xhMzECYev9Kxr3M/Zgcp+NWPkyorcXYwnjT8S
         PvYltT/rHq4oW99RQfh/6UiJVpUEe7C90PXsL09m+qrqedFQ4QUYqIUQnpbFzVfjsi8o
         my4+1cMwALCJS34f9IrEKDiF/U0/LdHTqYzlQ61nyqsBvBx2L3XXdYuNgaFy2QPSvldf
         ijMg==
X-Forwarded-Encrypted: i=1; AFNElJ+QIn3JkJdv7lmbBZcY8WtUYtL3inQ80ku7Nrqr1KrpbiE8bR3OVREjycYPew0si5KQFES8bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzvFqvHvn1AYncWVmNraHk6pBglOCBvWSXuRDSiuwI/NHIJKC1
	x3ScVD2+hfbhZgaqZmWHFHGNcnWO2Wqmu32u5x29LejQvzVXs3uZ3yv3py9ymQBz7GLlueEXG5q
	Z4LmVNURb7wSEjxQNNcm1hzj++wW/SsaXjt58kLuiaRSAiUX4DjvLLKcvBA==
X-Gm-Gg: Acq92OGdUm6L/KC6cFrNYHGFzsdub5WRfPYbZgL95l5VHGwGe9UP7Q1gEz0KRCti/PQ
	LVdui3+Vw8brMZlcCjnOV7Ok5T3wBy2RQb1/4h8/QQBx0Vvnq5Hqv3wLVX69IESzjiIyMXYQZ/X
	Mc9RyXMgJgmku050esYe0MpkAqeW/Nv7kyTkFPEcdrNbuY2wOpy9ojHO9Z8PcPADmvMKC60zdlP
	mA4mAWwAiubWOnMUcfWpt+BJf/O8HGMIAgyK6edmhV3gineqPBjn1U0omrjt0YwNk27xFWt94+O
	xLRupwYsct3DQqwzVf1ouz4doaWnZGg2olUHg+7peJffBMBVtHtZ20EqCT9qedejVP0czCkKNXR
	uruGfpmQeksELUjDgR3M+voFN/fzzb8GoxE3E44t2SfygeoKW3jQpEuo=
X-Received: by 2002:a17:90b:1f8c:b0:35e:3103:d4d8 with SMTP id 98e67ed59e1d1-369518b2048mr3565596a91.6.1778844211641;
        Fri, 15 May 2026 04:23:31 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8c:b0:35e:3103:d4d8 with SMTP id 98e67ed59e1d1-369518b2048mr3565574a91.6.1778844211141;
        Fri, 15 May 2026 04:23:31 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:23:30 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:16 +0530
Subject: [PATCH v6 01/14] media: iris: Add iris vpu bus support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-1-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=5399;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=3STlk6tvEix+1H4qQRvpao3EQf0zCnIXrlwAJ17Tn1k=;
 b=i0pFyI/Xy2g3DshYTpkqE43Hm9w2B0URHMhKQCpyXlASJB5XLVb03c9Wv48D4C7dl75y83XIj
 YrGBuu+ZQt4B80BO6lFqEekM9fhjrybhqCUEmyv7XrCUx/ih/YU3Hbh
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: _F7MqjLoGfY0KBRdFUyhw1LD4C9mvHpx
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a070234 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=6cGehGV22KE80QuxIsQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX7+gek65GIKqG
 D0B8hfV6VNcSwa4aX7bRyHL6/VArTUoF60XthEFRXzGRQFQWPV6MyglDpNFl5+/jHA3b+UYoJMt
 LuCx+pSUqEllE+aS5roqfeVX/+lSKVZqV89j0tL8Z9dkwNzeet2JxChFsKOGryifoxcuoP4zhRD
 TlydJNuESJyuLBbK41BTAs5TZIT7l4orN2ShyHgy55fjVBO5ItPRMIKRG51FW6Yj7WU0s63UcR8
 4Ki8Re82VQMkiMwLtn61pURl0r1/YZlykCjfpCZppNFvo8o6bze5EAJ1NlLl/pH0MW2NCMcC82Q
 2iomCBQuYZc9a03td7eHXlw5neesAMFskPw2XmJMHeRNDY/5n2vDmCXbzglK+xBslMNTRzrOtf7
 3ow7dxSDG+Pnpglej1ZJUrQkqYawb81flRBoskspSTGOy6qZ4csZz6/LdACfJxkuoPhKClxe530
 W79Sw3tEDb/xtYjMwbQ==
X-Proofpoint-ORIG-GUID: _F7MqjLoGfY0KBRdFUyhw1LD4C9mvHpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

On glymur platform, firmware loading needs a separate IOMMU mapping with
its own stream ID. This stream ID is defined in the device tree with the
associated firmware function ID in the iommu-map property. To create this
mapping, a separate child device is needed so the firmware memory can be
isolated in its own IOMMU context.

Introduced a new bus called iris-vpu-bus. This creates a dynamic device,
and its dma_configure() callback calls of_dma_configure_id() with the
function ID provided by the client to map the corresponding stream ID.
This sets up a dedicated IOMMU context for the child device.

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 MAINTAINERS                                     |  1 +
 drivers/media/platform/qcom/iris/Kconfig        |  4 ++
 drivers/media/platform/qcom/iris/Makefile       |  1 +
 drivers/media/platform/qcom/iris/iris_vpu_bus.c | 61 +++++++++++++++++++++++++
 include/linux/iris_vpu_bus.h                    | 25 ++++++++++
 5 files changed, 92 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63389fea5d15..c53d94d7b153 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22017,6 +22017,7 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/qcom,*-iris.yaml
 F:	drivers/media/platform/qcom/iris/
+F:	include/linux/iris_vpu_bus.h
 
 QUALCOMM NAND CONTROLLER DRIVER
 M:	Manivannan Sadhasivam <mani@kernel.org>
diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
index af78a1775937..76c9fcd253df 100644
--- a/drivers/media/platform/qcom/iris/Kconfig
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -1,3 +1,6 @@
+config QCOM_IRIS_VPU_BUS
+        bool
+
 config VIDEO_QCOM_IRIS
         tristate "Qualcomm iris V4L2 decoder driver"
         depends on VIDEO_DEV
@@ -5,6 +8,7 @@ config VIDEO_QCOM_IRIS
         select V4L2_MEM2MEM_DEV
         select QCOM_MDT_LOADER
         select QCOM_SCM
+        select QCOM_IRIS_VPU_BUS
         select QCOM_UBWC_CONFIG
         select VIDEOBUF2_DMA_CONTIG
         help
diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 48e415cbc439..6deadd531c8e 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -30,3 +30,4 @@ qcom-iris-objs += iris_buffer.o \
              iris_vpu_common.o \
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
+obj-$(CONFIG_QCOM_IRIS_VPU_BUS) += iris_vpu_bus.o
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
new file mode 100644
index 000000000000..e3327b227332
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/iris_vpu_bus.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+
+static int iris_vpu_bus_dma_configure(struct device *dev)
+{
+	const u32 *iommu_fid = (const u32 *)dev_get_platdata(dev);
+
+	return of_dma_configure_id(dev, dev->parent->of_node, true, iommu_fid);
+}
+
+const struct bus_type iris_vpu_bus_type = {
+	.name = "iris-vpu-bus",
+	.dma_configure = iris_vpu_bus_dma_configure,
+};
+EXPORT_SYMBOL_GPL(iris_vpu_bus_type);
+
+static void iris_vpu_bus_release_device(struct device *dev)
+{
+	kfree(dev);
+}
+
+struct device *iris_vpu_bus_create_device(struct device *parent_device, const char *name,
+					  u64 dma_mask, const u32 *iommu_fid)
+{
+	struct device *dev;
+	int ret;
+
+	dev = kzalloc_obj(*dev);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->release = iris_vpu_bus_release_device;
+	dev->bus = &iris_vpu_bus_type;
+	dev->parent = parent_device;
+	dev->coherent_dma_mask = dma_mask;
+	dev->dma_mask = &dev->coherent_dma_mask;
+	dev->platform_data = (void *)iommu_fid;
+	dev_set_name(dev, "%s", name);
+
+	ret = device_register(dev);
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(iris_vpu_bus_create_device);
+
+static int __init iris_vpu_bus_init(void)
+{
+	return bus_register(&iris_vpu_bus_type);
+}
+postcore_initcall(iris_vpu_bus_init);
diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
new file mode 100644
index 000000000000..62af9ee7e288
--- /dev/null
+++ b/include/linux/iris_vpu_bus.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _LINUX_IRIS_VPU_BUS_H
+#define _LINUX_IRIS_VPU_BUS_H
+
+#include <linux/device.h>
+
+#ifdef CONFIG_QCOM_IRIS_VPU_BUS
+extern const struct bus_type iris_vpu_bus_type;
+
+struct device *iris_vpu_bus_create_device(struct device *parent_device, const char *name,
+					  u64 dma_mask, const u32 *iommu_fid);
+#else
+static inline struct device *iris_vpu_bus_create_device(struct device *parent_device,
+							const char *name, u64 dma_mask,
+							const u32 *iommu_fid)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
+#endif /* _LINUX_IRIS_VPU_BUS_H */

-- 
2.34.1

