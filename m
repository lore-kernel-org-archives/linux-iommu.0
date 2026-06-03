Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154739657A
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496427; cv=none; b=CwbhNoc5sW3QDtQQyg/Ts87EOr2THUZXofGinMIPHUjleqCUgIGuXvJJCA4xrNQRWutW9/AjO1OaYkH+ZR7SsEX1GkLc+Nmbdz+GZ3mX18V+K75d8DOjlPQooDAvS/Lvy99Gx6l7rLLdqlrho0YCN8zByOOZk1EzoWm9EZvxTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496427; c=relaxed/simple;
	bh=0F6NYH2vBOPGXFbInvg3unabFPXg6JrkTEoOs8NbdW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xw11iH0hg+Qn9hZ4mFQAErKSua5hl4Z2S4uinDWFguCgiUwF7Pyc0IyTpgLonf/uGAh9DN5Y5Nl49Fz5R7dEFErv3O+ItBltry8G/OVQ+rwwkDM/hf1D/DT5Wibxo4dYUPNQBvfX9QdrNp/EoFLDViMvJ3rW7RZ2ift0h2/fduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lkK6l5Zd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WrpMQzkx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lkK6l5Zd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WrpMQzkx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653DYUiq1956859
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kMD0vi07CEccdmp8qLavRITVcgt4Oz8v3SLZupcLXoA=; b=lkK6l5ZdrcjKz7W3
	z5DJ1oBqp14j55ForPBtXses8rXUFPXz03cv3BbIXiTSRzJcsy8PFZli+3nqghaY
	nbyLdjxAnOR8GBnR8ESvosZQZb/gwdOva5hBoV6mZSwv0XlM7BV2XrmAY4blWY1F
	mJE+a5dN+oWZVHofW+mwxFKMTDM7cJNmyKso1nH9wL70quhD6SpNydbl15PR5kfN
	6mamsxIMCRGqSf7vXCgk0ObSh7afbp6X6VKEqI5Iuox4dHjkrNC0akc8IJFVMG9X
	WenqWl2JjtTW4UTAYym/N2Gn9NecZ7YfSCI5qeAsAMvINJUxAMzLGclQ7mYVRCOm
	5nKaHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc1nqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:20:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so76029535ad.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496424; x=1781101224; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMD0vi07CEccdmp8qLavRITVcgt4Oz8v3SLZupcLXoA=;
        b=WrpMQzkxnzB+muBwuThicnBUi9zXdTWEz8ipojPEZxFhhslGWwCHktZKVCsEk9pb2P
         QNwapUtMTl3IkbPWWT682cPw5X+OmEecZNfSrYQvOQ8DE6CLVFaKM1swlTuk7+PUijQ3
         BSf4oPHrNMh9Md8o6WsYfBFk9q4meEN6Y6SbKtpD1H+HUbDzOUJNmtzaFpIE11ddYj+g
         R3ZvRWC5xYlguQLDidB8B0MBr93QAVYZsG9DxZqjQqzsUMlcA7KCm9othxYOeFfk21E1
         gNgnuDslpCOehX64r7Ex/wp3p+CJbOIT6lnVQ8GZ3QXkquHK6nfj2BtdoNi0ewx3Hf64
         VB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496424; x=1781101224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kMD0vi07CEccdmp8qLavRITVcgt4Oz8v3SLZupcLXoA=;
        b=L/t0/8xtlE3lJ7j3rVWo7EaSwF/sD0/YatBOsGcb+0U7EN/k8lkmKBnIGOm5qWqU6q
         oDZSm/CxEbkaLnLFNsHRgzubxJio0WXeA2QSTntg/orAoDdEamwAanj4+NTWyHT+A7Vc
         7uwHtzGb35Ky59RutH23IN6xlzb/iJuG2LqJ/d/jAikgNWlMMxj0B04MXZ3UvyxCs1vW
         Fh24xu3W3YU4DHvRvRsP0ke2wKdcGUPlarqRVL6JNH5UGsGtmfK8lHL5jTlmQUp/Bpm5
         nZBCgdVDTUoaNqa1uXoiQTEp4YLYLmCsD/h8BuXqthDowJ9KU3etQCEdWXHdf/3vlE9H
         5HnA==
X-Forwarded-Encrypted: i=1; AFNElJ/tCcfi3AJMf+7YpkJBi0IZFPXfaWj5Fbxwp9Viz/LvDPqrc9DEg5M+epfy4y7ZTAtIcZtHww==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaZlSnJuSPGO+/YvnhhZzj6P5jUL+xF51wi6EB+0+IQho6tBrO
	zoOnadV2qAvpeHUTykQcQN4b3XQOG1A6eJdHy+AsX5pNrxwnqnwoDs5hkoxDHjHJ9VipTzqjGvR
	G/54XvIeouHhWYKvW9AYqxhHHy4YNeSgnCjeYcCMaL9d2Xk7JaPjNHQ6W8Q==
X-Gm-Gg: Acq92OHeCzPngeps1lnrU4K+7Sxw3uQ5EqrRopE4XRPaUabzRHWU/BNEXuIrN8zUUxl
	WpVEQe0CIcABoV3QB3sAHJxMxjMdulxgQjhntappv+5MTLpxJkhm1crmQSTvGRNrh1l/wapB6XT
	Jtcyg6fELi6Y9HLSUPoMjN3i7y1OzxvaZS6XgU5vTE2BeMvrdGUq6UTakthDZsFbJ0vXK2aIf+c
	YW49VT4+Q3lWYF09Js5qZmu/fytxmFNjcdJf4rR0LV56aXKTIv3OSa5FzBdNXLK6bzS5roZKjgi
	yEGlVzgYATkAclLowBaFAjgkb0ukJAwk1YkkeM2ZX9uKyeImLw5dGqBfHo2e05GqCwm5/dCBEfO
	6aLoMTg6LEidfvYu021n/DsmuhIo7vWc52oRZkwxDJZYaYbTN55J44eCOalPxB36B9A==
X-Received: by 2002:a17:902:f787:b0:2c0:bb2d:a314 with SMTP id d9443c01a7336-2c1640ab375mr42523385ad.28.1780496424087;
        Wed, 03 Jun 2026 07:20:24 -0700 (PDT)
X-Received: by 2002:a17:902:f787:b0:2c0:bb2d:a314 with SMTP id d9443c01a7336-2c1640ab375mr42522565ad.28.1780496423356;
        Wed, 03 Jun 2026 07:20:23 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:20:23 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:39 +0530
Subject: [PATCH v7 01/12] media: iris: Add iris vpu bus support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-1-afaa55d11fe0@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=5398;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=lgs97ZMLfMsrUuRVQ2JpjplW6O7nx8Egm5QQ2cPQxEY=;
 b=UhBVV+0OiyAWuPE/lzW4Rta3udej9PFLi+yMOhT5AFGAvH2GsPTojUKXK7U0r61ZUAhraimM3
 /dFowAfO0cCBNr4M3NWexEKON1jnYZvh+BAE48lyN2wP086fG9jLVZs
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: sWzY81_yxvrwhQfjA4COsYXqvoqO0dua
X-Proofpoint-ORIG-GUID: sWzY81_yxvrwhQfjA4COsYXqvoqO0dua
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a203829 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=6cGehGV22KE80QuxIsQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNyBTYWx0ZWRfX+qz1+rNVZNgL
 V79m7M95TvwR3dW0H0h53OBA3uLWlDIsSDKhI/Dsnd6FTaW++91KPEDuM/xPdaR7Io6J3g0ufUT
 dpJYKsia4gYsv+NiwowppGIAgP+TWzDZwiQ7ZXG09cnPTRYNPTgFfM5hbyDsd+iOOTDP1VE4Vb6
 w+D/ppGozMyz4ZsYiP2eo/QTyBpyNSeLWzzZ4eaD43SfgfeCs6QEKc6g9klwrFICcx73Uz1tvxM
 SsTxzgm4lW1Yuxq8j86YWcmU1InktYvbCdD4QET2ljD1IakQCFW7dR3AgBmX2YNLCRp+iTGwtn/
 xuaTNRZOvAul5RYsmnaKZ7TBRbTPrCnkvXxWw3e+0vlbim5z47x6Al48vu750YVgfrjk9yFVtuT
 xI1LKtO9Uo7N+rw1vtMfC2Omh8eBCJ4WMwuSh7856xiuUGswPbkZrq/pGFJMXMqBdtOe7wjtyQk
 G2i7y+YTWzuG+qg0R2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030137

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
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 MAINTAINERS                                     |  1 +
 drivers/media/platform/qcom/iris/Kconfig        |  4 ++
 drivers/media/platform/qcom/iris/Makefile       |  1 +
 drivers/media/platform/qcom/iris/iris_vpu_bus.c | 61 +++++++++++++++++++++++++
 include/linux/iris_vpu_bus.h                    | 25 ++++++++++
 5 files changed, 92 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9f2780b2d31..508a1150ffad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22230,6 +22230,7 @@ L:	linux-arm-msm@vger.kernel.org
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

