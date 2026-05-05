Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8F3DA7E6
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964458; cv=none; b=JFURkeGb0WyTUlDo17XrOcZmNfpbgIsNw/MPz5AkcO/Pqo78/O3jTKERIOcQsXbxvVHxzw69OFnoYi3ZNnKXHLalY5W3lFjhukGvT/ORosEpdG1O/rwVJY4G7uUBO0Pf/gupDaikEFUzKLCANsbJR1VuvTKFryE5KD/gd+Wtgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964458; c=relaxed/simple;
	bh=GBsVTS4l4F18YjaJ/58wFmxWqzuYLY1cBZgZWMYpxjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCGEgZgxoxVoitdsIzFRyJNfgr6nhZ/0C2fF3QcNxRQe8rlRhURgT9YKDlwrPiydUhf1B9HFAR6S1TfxzEvv6u5CKZU55Wy3qTqyLYk+rtSFY0ykPh650Qkq0V/yVR/K3AFTQL/kwtzqENgE1X9S4NMBBEL/0gFvwSEkJJypARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fAGChe7U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1Mh8L5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fAGChe7U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1Mh8L5t"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644NnfXD1346166
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4907GskeGPyGqTJtsNAB5xkShzE2fjp5lObjsv/s6Gg=; b=fAGChe7UVOMBRufp
	kgDdxbQCI6hbedldr9OdcJd2uYM0KMIBGgf2C+CTPePrGRAsm22D77DrE+XsE/0L
	DE9Ut5d5g7Uv7wi/L9/HkHQe07KGazcR5oDX99CiyeP9INItMmjj9EkswtiLLFyc
	++8wrdLl6r77RUa77anB7HrwgJpTHW2Qyet694PLHjS7TaTrMISX2VPSXQmDhvYx
	yRb8j9YdKnMJbThgd6Wxv3sYpeBnWn5OiptWHrxSZMHV9NI5vbOON1Nst11bjLA/
	7s9F7dsA5IarmKXXwkOVLVcz4Tco2OKO7QEhHGaGA1MUo9Fq3IPnanuFvlJXW4gv
	YP6lQw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2xauns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:00:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso4543185a91.3
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964456; x=1778569256; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4907GskeGPyGqTJtsNAB5xkShzE2fjp5lObjsv/s6Gg=;
        b=L1Mh8L5tyfqe6BqoqCG1GufSmttU3Slj3XHdxqgpjr884fn+OF0+ad4Bl71Zol08kk
         CJPyd4ML2sfFRZ0LEd6kDogiWtrcMRthJ1mnYiFzAydjjMoBJlNj6haz0s3Ere4ZYZ6z
         yUdtwYSMdXur/X3EewLL9CuUbleeUV3gxIzzbgAql+K+aHadeWFzIiv46Qd2cYGnjZmO
         ugfU32ljFZHtWgpT2lq+a5Ssw8+/84yjZSzc09x4JU1MVf9Xu78ktQ3tAE5aKUeJKQ5K
         NCimBwYRLA7+D+k/y6if8DndzD6Qo5D4/1af0uQ99qCrteL6NC7qCWWvvENlPjah0V9H
         jTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964456; x=1778569256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4907GskeGPyGqTJtsNAB5xkShzE2fjp5lObjsv/s6Gg=;
        b=innd5pFb3R9tLVW5nBxwtpSipS7x/O9nxuljXqds4dpbFOro7mtm5tNmZD6uL9SYym
         yHiUuP7AviMmug6vR+YeSvsLUTazPkusKBXX8lkf+xAdQWFdUsDhahBRQQpxBcV75z+U
         HTC/gVubaMB2DXv7Z+lzclSZD+B586ISAox04SWsocn+DXCV//bC6pj4aQcUjhXEpNho
         fcpdo3KnGDiJhYzEyGy9hAg34hmfxKUXvhsl0Ej9lDF71rG+JE3o5w4SKAf2ZhXkYF83
         wbr98dT69paXkJGc8tmTaB0JcPatystuaolSjkT18Lae88cHuH39m8LNrC7a3+z/qT69
         jquA==
X-Forwarded-Encrypted: i=1; AFNElJ/X1Z2OARqkBzJZ6iLFvBHo8QcIis/BAvnCyhD0kSsPlWdz5Z0Mq/y407DPs7wY/3i9Ej3LPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrgvsI+mri6XvTId0tLV5BZif+9VTay6lsADpT3qxR8/aPQG5Z
	o3BSP44cMVqQJ6/bxzC9cu5Is9c2KqpwY0VqikJjhpHGKJ4I/fIKStwMmKboqHSFpftd/s6bxAc
	9nXrKDb+QRtjNJWtVFnMpngHztFAoDHvSB3dUFC11lX3AvNT78XuFnh162w==
X-Gm-Gg: AeBDiesuLJ6a/+pwWYGPZiuSX4gugEkMGVIfR0gpQLUnwLBTHmBUfwwgMXRihsr1hXN
	3zDYtFUVKrDZZMKOiw91qAXHsUDyO8Dceb2n2jc1K0a4UvX+hoClsIDEracyDNlbju4WY1IoK1G
	8H/Gy/2rwLamBtw26WyTDuBn/mxaLjDsPGtA6jMfoM0uojfaTviAcEuV7V9Ko4v59Ghqq2eweK/
	VOVbZyB8WuQqfC2SdMdAi/5R5+IKPPo6zGza1wlVghkL5qDAyOILvDqfjZF6elPoQ0i+b+yEtWa
	rBbGVNQiB4iXMyNDJpWRPDHuJ8Jn77cKlKvXnyF4NMIssrWp1WkLsewG+iAdvQD/miKzyCbsHpH
	Vs4wbXCWQd2fBSZZJn5kVytwyIXvHB8PMzI7T8DM9ddfNURA4jtcjTPeIc66tYj3e8w==
X-Received: by 2002:a17:90b:3852:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-3650cd4b20bmr12478798a91.2.1777964455784;
        Tue, 05 May 2026 00:00:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3852:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-3650cd4b20bmr12478736a91.2.1777964455015;
        Tue, 05 May 2026 00:00:55 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:00:54 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:25 +0530
Subject: [PATCH v4 04/13] media: iris: Add iris vpu bus support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-4-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=4228;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=cziP+P95lYoSiLg+5MW5xEwescL6vgvBBGLLAvVvoEY=;
 b=z+TxP8+TZXII4YxwxLPEEiwyjbixnGpOF1iRrVP5dnfHNH7GveE3tEOR8baGkU0hjom6PxRZM
 XT2scITxFhZBiRhXAqziGcNG6vqtiYPOORJHYpuj9ehNh/ilSBrOQny
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f995a8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rZQGDrx4aKZhb0zF23kA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Pg1vQbsD3pDAQsZBqxsxmiqg1dRfwe30
X-Proofpoint-GUID: Pg1vQbsD3pDAQsZBqxsxmiqg1dRfwe30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MyBTYWx0ZWRfXwUQXUlVE9Pe8
 F09gwJkDX3D2iFfm90SFD/62owZwZ/DkCZXOvmM/fOBcSa6Fo9VIds96BD+y93M36CyhbJ2s6lj
 obvZrOBfAC1i7J4UEimjH6P/3hvvtWxHl2eqf1c0BuHmKcyp7ou6HZ6W/a1Cir73HR8H2pv64lu
 wMDz34FAVa1ogsNitQk54S9zHvxl6eRM5Snwmp0DgxwAIXyV2EtXXDXJOtxfgrCb5kbFh+UkjJT
 wqsOrqvSg+1mU3rw0+74kT8wYxzYfw37fPrTstBM/+blF8rSCBgPjqYk88MK99QHd9+nli0HmZ+
 VZhbZydCuiFeGrI3iGZUoMkOQ5diNdSFyYXGu60F1KT9/snC93JFDFxxCwDr/zBsvVCdWFyWcsx
 FzpEha4OBQrzIRsgfbrH6Vng3fHBXtcd7uK7Woh6rZAQJnr70H9auajxGWgkBjFps6uWaQldRpf
 g8jmhjvUKP3Rh/8O0fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050063

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

On glymur platform, firmware loading needs a separate IOMMU mapping with
its own stream ID. This stream ID is defined in the device tree with the
assosiated firmware function ID in the iommu-map property. To create this
mapping, a separate child device is needed so the firmware memory can be
isolated in its own IOMMU context.

Introduced a new bus called iris-vpu-bus. This creates a dynamic device,
and its dma_configure() callback calls of_dma_configure_id() with the
function ID provided by the client to map the corresponding stream ID.
This sets up a dedicated IOMMU context for the child device.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Makefile       |  4 ++
 drivers/media/platform/qcom/iris/iris_vpu_bus.c | 69 +++++++++++++++++++++++++
 include/linux/iris_vpu_bus.h                    | 25 +++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 2abbd3aeb4af..6f4052b98491 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
 endif
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
+
+ifdef CONFIG_VIDEO_QCOM_IRIS
+obj-y += iris_vpu_bus.o
+endif
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
new file mode 100644
index 000000000000..15ba4d9c563e
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/iris_vpu_bus.h>
+#include <linux/of_device.h>
+
+static int iris_vpu_bus_dma_configure(struct device *dev)
+{
+	const u32 *iommu_fid = dev_get_drvdata(dev);
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
+static void release_iris_vpu_bus_device(struct device *dev)
+{
+	kfree(dev);
+}
+
+struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
+					  u64 dma_mask, const u32 *iommu_fid)
+{
+	struct device *dev;
+	int ret;
+
+	dev = kzalloc_obj(*dev);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->release = release_iris_vpu_bus_device;
+	dev->bus = &iris_vpu_bus_type;
+	dev->parent = parent_device;
+	dev->coherent_dma_mask = dma_mask;
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	dev_set_name(dev, "%s", name);
+	dev_set_drvdata(dev, (void *)iommu_fid);
+
+	ret = device_register(dev);
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(create_iris_vpu_bus_device);
+
+static int __init iris_vpu_bus_init(void)
+{
+	int ret;
+
+	ret = bus_register(&iris_vpu_bus_type);
+	if (ret) {
+		pr_err("iris-vpu-bus registration failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+postcore_initcall(iris_vpu_bus_init);
diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
new file mode 100644
index 000000000000..750e878e489f
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
+#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
+extern const struct bus_type iris_vpu_bus_type;
+
+struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
+					  u64 dma_mask, const u32 *iommu_fid);
+#else
+static inline struct device *create_iris_vpu_bus_device(struct device *parent_device,
+							const char *name, u64 dma_mask,
+							const u32 *iommu_fid)
+{
+	return NULL;
+}
+#endif
+
+#endif /* _LINUX_IRIS_VPU_BUS_H */

-- 
2.34.1

