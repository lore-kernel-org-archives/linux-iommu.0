Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D613FB7F1
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266865; cv=none; b=YWnWHjR0CqEUO5qkasBjyqwlMi3+FMZ+CSqo0zE+38SJJatCAn1Z3hDbSggtr79x8HD3f3me6gumweW4Y7AWtHE5R5VY1ihjA+B3InFb0wCt9SsA/vp4Klwa/gqJK0DQ9T/FyiwOYvIbDrtcx8mJ1CkHrjAgSk4SLh4+9QAAxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266865; c=relaxed/simple;
	bh=KiXuVUk8f5ROMtDUgjaTz7+prNR9bmBTgAeAT+6V4KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjoajWWakwduRyU2CGsFIPFgOm9ezWjbC841odHcY3p3b9hm+I3MvKwm7aetixAtmLb2wI11MQee8RpPy8mb4TLBljjZmMiUeW0qHA6ojCTsjvjxs3VuhGQ5Cj5H7wPfDFk0nhr4D3/AW8JkYI/sJMr/ltysYhlroZppoGVXndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H30PgFuI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hIQIrSVj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H30PgFuI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hIQIrSVj"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648DZQUV317490
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nSH30GGE8av6HezR9dT6kdpTEbioXtP5Ir1fDXax7/U=; b=H30PgFuIOWFar7PT
	rgcH6ReOZdJ/nusVsZIu95k087ZykWalSLacMrjPmXk/pu7srtTEFu426vARX/9t
	HVwJEHDATJmo4wxGOf8pGPIEcrxHcRMNv9HLIApfe7+HFioPLiGug2eyK9CH5DI2
	kSLPus2tRm4esB7Uka81cGuHX1VHa3LAEpKev/37/AEiLOf4tW1lzqIbAFHohuo0
	sKIV90kmoieQHaDakQu40Vcd88RCeeChYnwhJpxbJoXhpwAhYYYpEpcYX4+OQJn+
	Fi1fjCpe6tmgF++ZHzqKa9KoBFKMCDvWbpS8EVf7bBQCIGffz6wgs7MwJ7yZi78O
	m9PTDA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1bc02ta0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:01:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso1269312b3a.3
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266862; x=1778871662; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSH30GGE8av6HezR9dT6kdpTEbioXtP5Ir1fDXax7/U=;
        b=hIQIrSVjtZbt/AcVv6lzrifQwAhN9YL2AbfFVPP1PkmtDu8t2GCd+F2pTtLjwH1kED
         6GYu7VgVbSFlTuCprtfy5pes6ZFP/llrYaWqoipG97dJT2pcOOoaAYd8lou2l1VAicet
         e57U4bFKW9QwQsYr3RCU4ZgwXI9HquFmxo7UrV8r60lUFwv9Hfz3MG/GbeGwkLQIZWrL
         tnlrk5Kmws7pOalR69yeCU7/L05qtsCg3ShUJOLk2zKM/cqAqADn+ckJGG8dhOy/rbG7
         6xkpBwybvOX8DwMSXatvgMDl3wx4DBX0VbkWetloYroSxz0GTNKhwFWZGpAvu2HipK7U
         RWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266862; x=1778871662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nSH30GGE8av6HezR9dT6kdpTEbioXtP5Ir1fDXax7/U=;
        b=XjWA9IHd5wt/APWSpfB3Td4OkzPh4HCtQOK3b4hpQ4EKTdXtQGTQq3mBIG3vnCQG6P
         J9tZxGYwgVUKb3j7wDDFc4cEsDQNdcBNcDUjFW1abptDrArsWDuJY6ldh7phoI6MetB3
         gcRGVYpBZkrJ1ujFSlz4k6j+qf7K2NXy86PNxxawmWDL+IbRw5/TmE86SEwbAt7iiQqw
         tgfGEc3kz96ru5KZhsOfuto4uaPlwBukID8kmiPCbpqxix8YKaFLNdW/g0lb1pkZjnaV
         a6z6xI5Ivk1p0V0fViESUcX7Agd64mL4Fh+j9YYAOUStZdiBjpz43nEv3HDyUmIQzZFx
         UZQw==
X-Forwarded-Encrypted: i=1; AFNElJ9EQd5jVyOEm9rKIbrbb0+vWDh0dNOrbiHvd8483nijVcB75KrLioDx3c9V3be5h8ogUTnhDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjPKL5EU5NC9/z4Xh/oQqzhI9lIhbyNJE7G513mzMvDBa9IItr
	kJV45gLQUt3LyIl0HXm5gZH12atMaQzvQcbUuNMR+IXks9NnkFTNsLJuJtU1KKHijZQmtse16sq
	99iDkF0sFyOw4a6HGY+DNCpafLd3afh337NxwrWb+g/IIXC1HCd/qXZbvJA==
X-Gm-Gg: AeBDieuECB+q+iXTI5dmZBgm8ZXGi06LRhKRlxGGDbUXOHL7jtyCCJdig4P5cWqlYBL
	ioKNbT6RybWg59S+j1eYnb0tJCs7TZRARuKL+jWkvk8atqggY8T935S9Io0uy6mfiinB7NI4uXX
	3CjLZ4uta3k8SHH+E9kN0nANDaERKTNAwzVFy6GNvsxsQV27IGzS+zRhG9xZ/Ql2Pu1sGdjDADY
	d0OPPFJdTAzn6E5DsHTX1ToAUZsLt8ZuR6U0V9DnBhMTxvpXlw1z6HfqMtG7sAUvo5Lzv5nb19X
	OK2yI843IUzCB0+FCx6fEZdHouReFX5RpAaiyUv1XzHrBmIM8XLQvqLBB6mUD4CbLBed9Me71Px
	jd/kcutJg6g/zlSLm+OC+AR5GEA3hiNCsQwzr6NCk2zu1VRiVhLAqeUs=
X-Received: by 2002:a05:6a00:1248:b0:82c:d9d0:f482 with SMTP id d2e1a72fcca58-83a5e34c689mr14024565b3a.46.1778266861478;
        Fri, 08 May 2026 12:01:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:1248:b0:82c:d9d0:f482 with SMTP id d2e1a72fcca58-83a5e34c689mr14024480b3a.46.1778266860675;
        Fri, 08 May 2026 12:01:00 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:01:00 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:29:50 +0530
Subject: [PATCH v5 01/14] media: iris: Add iris vpu bus support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-1-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
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
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=5067;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=52EKURZCx0iONFkZ6Gam+KM/I7Qv+TkHOEbMgjnm0ZY=;
 b=xwNOosr4zZSY/kkC5jN4RuFPftj3txidBOZKTYPPLpEYuELOnegY0moCnT47NsBKdFtrRqbmG
 duF8LGNX3JWAZZl4vn4aGwr69PnXTk0XzamqgquN1CLNXLrLMafUxSg
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfXwgicXtY/UVdJ
 tDT9EtPQxoJ6V7OVuxYIifCXImJWmtg001Trya2+JyEPVWs75z4vBKDKZElmear73/VKNGJYUeJ
 JJ85RuwT/FAi9fOuGI3uWkm9jttOpauWGFCDKTEzho5SYSUMSqfegoQnqeoAkbR28sBCtWLBzHQ
 IiDeTXz+V/9QE1PQnymtSrNg2whRS016lFvl7Lgm13vkvXuqeXEi6i4TMtoFj9jEle5+r8mgJqY
 znBpGdfPe25TG9U3eO2pQPUI3YQ64XEmcGXHXM2zwYpM5FJW9Fa/1lmOEw13mkrASjDlb4l1BqN
 CcAs+a6XiiTz48cWLBM7VsFH/ZMtCFEJpBO423jIlVr0O8NhJ/Y8mf+lEevE2s+Jaz2GW5bj2WG
 dA08enZ2+X8R7MTzIiiqshJv+fFj2FlfeKm5lS1dWD0buDMgO8f0xO/tavluPOrQfDIZ6jaWceZ
 yanCbxd9YvXN6eLAXVQ==
X-Proofpoint-GUID: YhXW3SD0qtXYQuGtLX97lW1XHCaj4RYj
X-Authority-Analysis: v=2.4 cv=JJQLdcKb c=1 sm=1 tr=0 ts=69fe32ee cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ZVWlKI4yLptaSbO15nIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: YhXW3SD0qtXYQuGtLX97lW1XHCaj4RYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

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

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Kconfig        |  4 ++
 drivers/media/platform/qcom/iris/Makefile       |  1 +
 drivers/media/platform/qcom/iris/iris_vpu_bus.c | 69 +++++++++++++++++++++++++
 include/linux/iris_vpu_bus.h                    | 25 +++++++++
 4 files changed, 99 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
index 5498f48362d1..025280ef1221 100644
--- a/drivers/media/platform/qcom/iris/Kconfig
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -1,3 +1,6 @@
+config QCOM_IRIS_VPU_BUS
+        bool
+
 config VIDEO_QCOM_IRIS
         tristate "Qualcomm iris V4L2 decoder driver"
         depends on VIDEO_DEV
@@ -6,6 +9,7 @@ config VIDEO_QCOM_IRIS
         select QCOM_MDT_LOADER
         select QCOM_SCM
         select VIDEOBUF2_DMA_CONTIG
+        select QCOM_IRIS_VPU_BUS
         help
           This is a V4L2 driver for Qualcomm iris video accelerator
           hardware. It accelerates decoding operations on various
diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 2abbd3aeb4af..79bc67980339 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -31,3 +31,4 @@ qcom-iris-objs += iris_platform_gen1.o
 endif
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
+obj-$(CONFIG_QCOM_IRIS_VPU_BUS) += iris_vpu_bus.o
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
index 000000000000..7437a2ba411c
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
+struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
+					  u64 dma_mask, const u32 *iommu_fid);
+#else
+static inline struct device *create_iris_vpu_bus_device(struct device *parent_device,
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

