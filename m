Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139827F4F5
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142848; cv=none; b=tSjLNrQIZA/KHmTf55s2rYvQRPwwuuUkZt7Hehb5p3xV1+a8n0p83v8FF13k9tRFLo6HBJC4FFdqmlA+Lm39hek4pbgNJcRgKuGGfA2ZVPwaxmnQcf8mgVWirNnFahvCSl+aMch4RYEjKRccVQ+YvweOOOAqf4wLoSW7uJ5TGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142848; c=relaxed/simple;
	bh=O/+LYBNLdxSQKzsqIETsJYp7ERapNlu6dOUA1n/zY1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWHYCSTVAu0If7aGWgj2p7PDnkc0N2NXlYSry+OTVF9gD7gKBnTHwPVic382jRndkZU1rymPLDW+xD8NypIUJYOH0H8ex83DmSHxzMNFRq0XRxJSFqFhCxhzlt1YjkfFgJB7e9riGI/RsZHybvWKVc2QoSY3YKj9uhZnMJK8XZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aTER+EvD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eecOq2nE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aTER+EvD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eecOq2nE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLCeKT3505309
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aMuxr0+9TcjyPSsVh1aKRVut6k2RFbAyhAme7P42Vtk=; b=aTER+EvDjXvlAJW5
	TlY5GnyLlKiAQsaeWrVAVP9RxVQZfv11bAGqCoh3DCxVVZjzaW8tvnWyMhIKwMnC
	oGDB3RtMERTZG4jB8MIB6gl9o35WJveIkbNvJyUOk0zLrVl2j8UlP/0MO77tqzOH
	3m6G1dLimpXTSileapV3ClkdmbdF+kvMCsQ+lN1l09FmIc5/twjboYrQs0dQyPlg
	YDouvOnq5DMS+97jSK7hCW3kqgXh+wTyLr46C1mZpzhIs1Cc92dvWvx2DALgzmQy
	DLXciOipw+pwHhmzDvdgDIlfdFSvpWDYmsiVL5RIJU68Yz3vUSCdjVwr0rjKhbTT
	AoOtMA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870h2dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2523e0299so126036525ad.3
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142846; x=1776747646; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMuxr0+9TcjyPSsVh1aKRVut6k2RFbAyhAme7P42Vtk=;
        b=eecOq2nEazQLRaCGtJmvp8riCWZMauLl1jnVd2jcOOoTxbhGBdG8vDruWnWg6XbqVP
         pgR47PH3nHK9/N/EpudlY9PWbJxIPmLxd59iA4NBUtbZ/n/OzRyBILid4EBTnsx/ta83
         f327A5MqSC9DlGHmNUtWMTkF096po4du4NV7gArIrqThKKUyG59xBH+pYSte/OL2JY6Q
         +AV8vk/0m0p5WbbxWToXSlpApIVkUQyfyWQya2b/8dF4FLTqeL8fUY5mYHDDh8wW1U9p
         r2XOGELzN0M3bH+rRVsTsmDoG9lDlxBdDTddanrI6DSTd4k5jb2DWDihusrAjtxmBvop
         eItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142846; x=1776747646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMuxr0+9TcjyPSsVh1aKRVut6k2RFbAyhAme7P42Vtk=;
        b=hoVK6uiquk2sSbrzsCeN8BMYfy5ZiOXtWoM0kR0rtzyxA+gthplGreQYTiRKBvObIF
         1Xh6dUb0d3CDutLPh1TrcteJ1cH+lwC70a/bEqSvYDBh477OB8Y1wtII3SIQMWSEO30L
         IT3WKBAKJTRMUz/gPxWjBjNWH/WGc5pFWbsuhXwtkYX08KCy4GqkM/0CVaeGRMApSQs3
         C1RjpTNP+gi9uzJmh9iVXwz72oqgKXRKxF2ciaAh+LEHmlU2nqT6NxBMEv8IQftTj43O
         QRQoP8QGFi/eycA3PZueRRW7O9EAFf6HTvrgUfDhhXJXr9LUEFaer//N1RPktcYrBFcM
         WAhQ==
X-Forwarded-Encrypted: i=1; AFNElJ964vKaSbzusHp8OwwdrBWK06tRn+2+z2OKwIOH/9ohGQy9NPOoWan+YaTsS7I5EKM812InIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOd4AcpclgfV/GDC6UuvauFmBE22beOo07e4Nn/YFCVjxn2JEw
	/v67Jehvy1JtnuXtGw/dqQmW+x71pe52sUvx96gC0krKKmqMReg5GwHoTJmY4tDPpl0FiwlLXRp
	Owj0Z5+N2Sf9WCyLPb8TRIQMu2tlHoW+CB3mnPlxe74Dckn1AclN4iisz2A==
X-Gm-Gg: AeBDievSMLlyPEp7p2bvo7GFgLEV8NvZ/bFdC0tcjMDTFV0p4ZMubbSmXa0cJSCWm/k
	UuHbtVEoWGDu9d7fAWqXviYpbQ5TSjvm99OMCz+ILbUkLPERw8+rpGcxIuDuVNE0wBsV2BxmrPM
	XdvYKrp/zpU5DE9Ve43ZS64FIaA8rrdr4kwqDFKZ5TRDJwWgLt8Z1R9U4x7HzXbxy5+xjIl1Lly
	73p4oAkqjFr3ABOtXjHdcReE2Smqh6dWAUaMrSphvEw5qxh4R4uVxCCvgCpmKFxQVFr3WRQVVK3
	L0giGUa5O+3HUkHDaITkNcxn66suCJgQaXqjwMo5W8N8Qcw77K92ezXflm9k3YjyeU9uRcUwRQs
	easbIKQoz7E8+UxCAc4pYl8GMPqhONlQGvVhODNJHJnpuGRbmoLUSC+c=
X-Received: by 2002:a17:903:1a8f:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2b2d5a64f08mr163149385ad.41.1776142841079;
        Mon, 13 Apr 2026 22:00:41 -0700 (PDT)
X-Received: by 2002:a17:903:1a8f:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2b2d5a64f08mr163149055ad.41.1776142840556;
        Mon, 13 Apr 2026 22:00:40 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:00:40 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:29:58 +0530
Subject: [PATCH 02/11] media: iris: Add iris vpu bus support and register
 it with iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-2-7d3d1cf57b16@oss.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=3184;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=BLj6gT5dri/81+O7yZmqLEqPFKVnYkph8y79xh/glKQ=;
 b=CoGStrTZzo2YY89yPHj3q/r7F4MIOhu+D9erCHhYmDQtaV1B3scc6o2IWeu9zxPQyPiT3+/xc
 h1eQmTmUADyDR0dF+fULi7AeeXpqUSCxBO8lK/QAXPRHgt9Zaxy9Tes
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfXzL9blcL2tPq8
 YOyMq+7FzsGLonYeS6rK67853WGd1LT7Lz6Bt3Osi7iZIrfV0lRMRsMIcZfbPTzBSs48njAtYcS
 6mYuZedMQpJ8xzS5fEreb0OrM+jzHURvpPsV2QJzHm0C8qbYDlXIO1NqkP3ku7Ad3FDMTeIoNib
 b9sw1FA2lbOjGF6FKBMX4RwlmkfzVxNTprP79FuD0mLHEqDk6LV7eWkbch5YzgUzfB9IevpeGUQ
 DHly6aHQS8pOFFVDGiT8gKqSjky1FfzE+epEietA/6hLENTKT8sGtx8SQPIwakJW3O5OQ8XEEOX
 01xqmEqhNDkdkWFPz2gdWcdyjC9TvEWCPgiXd3iq4J82koicOUP5VP/QsbMt2f0YLTwklygXzgX
 EQ6uoqAi3LiAHckR+ZOz+Ie41A/t4MT3iFGMFNSzi9tXMzgoBFtEbK6nNcmOcatwUtDdZwqeMY6
 mxv9NOrg5BYYAkJpNMQ==
X-Proofpoint-ORIG-GUID: 4Ls6a6D1WrtZBdu31HVeH2US8Ip6sFto
X-Proofpoint-GUID: 4Ls6a6D1WrtZBdu31HVeH2US8Ip6sFto
X-Authority-Analysis: v=2.4 cv=btZ8wkai c=1 sm=1 tr=0 ts=69ddc9fe cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Liwi-oTqB0IuMEU3Zn0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140045

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add a dedicated iris VPU bus type and register it into the iommu_buses
list. Iris devices require their own bus so that each device can run its
own dma_configure() logic.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/iommu/iommu.c                           |  4 ++++
 drivers/media/platform/qcom/iris/Makefile       |  4 ++++
 drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
 include/linux/iris_vpu_bus.h                    | 13 ++++++++++
 4 files changed, 53 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..d8ed6ef70ecd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/iris_vpu_bus.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
+	&iris_vpu_bus_type,
+#endif
 };
 
 /*
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
index 000000000000..b51bb4b82b0e
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/of_device.h>
+
+#include "iris_platform_common.h"
+
+static int iris_vpu_bus_dma_configure(struct device *dev)
+{
+	const u32 *f_id = dev_get_drvdata(dev);
+
+	if (!f_id)
+		return -ENODEV;
+
+	return of_dma_configure_id(dev, dev->parent->of_node, true, f_id);
+}
+
+const struct bus_type iris_vpu_bus_type = {
+	.name = "iris-vpu-bus",
+	.dma_configure = iris_vpu_bus_dma_configure,
+};
+EXPORT_SYMBOL_GPL(iris_vpu_bus_type);
+
+static int __init iris_vpu_bus_init(void)
+{
+	return bus_register(&iris_vpu_bus_type);
+}
+
+postcore_initcall(iris_vpu_bus_init);
diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
new file mode 100644
index 000000000000..5704b226f7d6
--- /dev/null
+++ b/include/linux/iris_vpu_bus.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __IRIS_VPU_BUS_H__
+#define __IRIS_VPU_BUS_H__
+
+#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
+extern const struct bus_type iris_vpu_bus_type;
+#endif
+
+#endif /* __IRIS_VPU_BUS_H__ */

-- 
2.34.1

