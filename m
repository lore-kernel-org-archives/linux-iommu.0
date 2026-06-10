Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3024376A02
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073026; cv=none; b=ADGMpmXnx2A+n9Ov88Rr0TTQx7UI2tRSSCDnCnIhRrztpY7KbNg5fFVGcunjR/dpRhfrYU6som9llgWMGpOv83FkEiHAwSFg4qFfZNykpXX+0CUTfq7VpLzsOCX8CBm9H5pV1EyTbKxIEuoyE1+ktnPH0wVQ37ohE7DLYHBE+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073026; c=relaxed/simple;
	bh=g5QnDYNLCUXkrvTnyRg/wjaqw3cIxeOy+tSozwdFA3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbb6B8lsn4/8SC9TPJT37NnfryspH7dbFLflitfU188xAYrTzhEVBD9R1/DMiZ2K2rN7xKHmuxd6TfvhZWYmTFzuZzhV9HxvPYlJlk/PYy8fm0Qc03r4I9ZDeq3Z1UsOL9Acs5fImHd49yiXbgxulAbRxUkGubcsMqEvFjljQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I1ZVaHne; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j+zkyEeb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1ZVaHne";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+zkyEeb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A45IMx387503
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l9xkdvPWvw9OpNaumZA+ItB8MxYfFys7ZfCRfS7YrK0=; b=I1ZVaHneBmjqy8sc
	4Ok5hiKYahZ/rIeGhz4/gM213hD5RrO3n2wV3IaN4a2dmLav/bW3SJOmO1RCWPpZ
	mjZ5yiyZC2Ha70f2aDIC3gGeWOoPwegHZm+T9Z8d6eLNbRgKZpB2pXS50Brd2b68
	D9IZ/EYqxA97Fz7gtKySXJRm/v0d5WqXInVNvjVJx53J9uBlSi41wgqlkoZ2Xs1h
	DNBITic5gkiJEym7eQ9lZTP9jQKzrY3OvsKWCNu3okWf/cvz3NY/A36BAlqlI/N6
	6ys2gVMSzzEhAtEhU4IYemT7g0xY8vsrJauoWuxaMX2FFJ99WKfFziYNQO7T2ib1
	zj5efA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kd8efv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso5991966a91.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073021; x=1781677821; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9xkdvPWvw9OpNaumZA+ItB8MxYfFys7ZfCRfS7YrK0=;
        b=j+zkyEebNXgbDyAmijnE7a7GuRxBhXWB1lJLoqFps0Kova57+Tmw2VgDPah09hZcvy
         mdBi/a4IeGtf1SddmUEiiVGphbvDyNryWua3vVAsIUAOr2ikNA2bRvYpwG9Q4ZGgsPWM
         xHsDIQZ36KzHFP5xXTYAY2Xggbo93THAadDxi2es5S3SntIBOFG+3dA0plXghKzIwzGZ
         uset4y59VJTAH5oqQzrCOCbmBxb1kMkG9XH2rwVO+zwokW0S0dSrUUEqa+R73QPuy//v
         fZE62spR3NCJ9pQgiymhyadf7sH7qDfCcTSjAJhuDu2bWda4e9e5TvUmku8hXHRuuxDW
         t85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073021; x=1781677821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9xkdvPWvw9OpNaumZA+ItB8MxYfFys7ZfCRfS7YrK0=;
        b=iwIEZGJ+G9EIxY0XUr0uAyfgP6KqeZH8OVuCqDjTFkF35L+DmMMjCDcxhRy27eiOK5
         JbbTQlbSH7O0hdZbc/BEO1W6vgl/c1Y+3pAiRqolhCZigeSTK7YrNwoW7bMTM89Atacl
         XS8NL6rwq99dNkqOqau93iaU3copad3lTAvHpgpeJYAaYPp2kMCMhjdD+dTeJ9Fn09B+
         eXe1k5eh+TKRBIYfMGQ1TIKj4SvdycEMsduPR9+eJFnw22RpWYQOiMNmaYIr+DIf8zP8
         ks3SAcCo7LCFwxKHVuxPtNZwcekKaXeRoibSpOxFNL0Y1uoxsga6o2w/+F3gkzSF+5RH
         R26Q==
X-Forwarded-Encrypted: i=1; AFNElJ93VETKeNMU5OG41waFbpmqmeZZ6UA9rxw90ZSDcL+H73FIMBz8euaH+lpJvzW5GJXAL0uCtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYuwF963mOYDH0Cx/DEd8rjnjrevqXO339PcQia1vU0nQmHBra
	Wi7IPnSAiKZF9FP8d2s50YOo3FkAStgWQrj5TyFokOuL7wjQYaE9AHOABa4fxdA4OLV+EzE45q4
	n/jauM+obBNaUOW6zY1QVI8cN+2Wcj3YUQimfq78Q3MVxGOAKW5HgVzZaUA==
X-Gm-Gg: Acq92OFK8KNthsyJ3uCNdkYmHHz5nnCXy69RltSC/8qnKGfp9rEIj13+rmx+BpUe6b2
	NV0aT7IRLTcNz5wva8jqnDBOgCqqR4OhN6NixAsri2gDtJFBPwyrSCOTiKMFnjzMUCexjsGLyKJ
	VC6Ec3RSSG/48muuqv6ae7dXF8OlfoiJG1yr4JOI4yxM3sBA1D2ThL1ZnHygkyOCjetpjshQP1q
	nRrl5u/GevorK/rreGZiCaGykEMEFsiKhzxrxWx/WhJHN+nquHBueqa40meKV8hdjU+1JSJ17M6
	4cKPW0OaTSDJ6Yj5h5a8LdkFXpH4YSgfRyCUHpiE9chUbzfBEUQoaRlne8n6tFkIoFEjVRArM+p
	+yJnnzTxq8cJVWQBMyJyEisxKX2Pq/T8yhXgswRjBXdKdf3s8x2S37z5klRaKp3o1EA==
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr23696807a91.8.1781073021162;
        Tue, 09 Jun 2026 23:30:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr23696398a91.8.1781073015866;
        Tue, 09 Jun 2026 23:30:15 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:30:15 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:37 +0530
Subject: [PATCH v8 01/12] media: iris: Add iris vpu bus support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-1-1c79b9d51fc0@oss.qualcomm.com>
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=5465;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=rdDaZJ2JpJP/hvRtkYjsfyvO0PZdU0ZWU+/yGYP+wUA=;
 b=YlKMKStuh+NVFiFAmn04eX0qlxviZreZXgdBWOfPpAx9Fl3ixQVxZbpnRkQ0wKZi7Oz69QHDe
 mtb9UcCUan/D4VE8KOzXwbdwVQpJ5HB9jmo3XWOh6gB9AS7rLotVfYu
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a29047e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=6cGehGV22KE80QuxIsQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: j-I-sufR-Bq4wBBipnK03WYCl5j6rL5g
X-Proofpoint-ORIG-GUID: j-I-sufR-Bq4wBBipnK03WYCl5j6rL5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX9UC2nGq2x1o/
 cYTmoYkJIKGr20zTYKNq+ZFpNKjmaHbTq3abv79Pk8ucfHLZyE6nKzA4vJXcQb/ed6saqsiq/+k
 C+mCgx0jXLrJCnPR4QayUzPXTEpdD9CrnusC/X7ciaDMqJfxFyQTG5ZveLBcGTn++wnKkkEgdUy
 06fU3O4XjaAkqwBtPmia9i+7oEAaH0dc/5un8O7Mr2iaS3mVI6K2fdnKrVRFzXzSNus8qDYs1/U
 pahfnDeYH82zMpRFOZZMw1HaOIyBok4er1ReiA7u/jT+7lsSINjrRn9E5O/tNm7hNpJgfdZq8u1
 DNTbxtrGZadifeZwZGNqqCFPPGo4cLZOULvmcYMBs5TWAAaC94FVfL/0DgnmHoBbDY1f8xxv2qA
 nAMw3EJQjlQnNF6y2qSM8N50pWAHASQViDGiUN117EBiIjWzvG1fFU7R0ON26dvq3dyL71Y/OCb
 6WI3Z5STJ7+corum9ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100059

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

On glymur platform, firmware loading needs a separate IOMMU mapping with
its own stream ID. This stream ID is defined in the device tree with the
associated firmware function ID in the iommu-map property. To create this
mapping, a separate child device is needed so the firmware memory can be
isolated in its own IOMMU context.

Introduce a new bus called iris-vpu-bus. This creates a dynamic device,
and its dma_configure() callback calls of_dma_configure_id() with the
function ID provided by the client to map the corresponding stream ID.
This sets up a dedicated IOMMU context for the child device.

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 MAINTAINERS                                     |  1 +
 drivers/media/platform/qcom/iris/Kconfig        |  4 ++
 drivers/media/platform/qcom/iris/Makefile       |  1 +
 drivers/media/platform/qcom/iris/iris_vpu_bus.c | 61 +++++++++++++++++++++++++
 include/linux/iris_vpu_bus.h                    | 25 ++++++++++
 5 files changed, 92 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a727d4920fae..92d26cf491b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22262,6 +22262,7 @@ L:	linux-arm-msm@vger.kernel.org
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

