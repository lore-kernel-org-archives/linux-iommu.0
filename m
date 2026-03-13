Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8044A3932C5
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408028; cv=none; b=FI1usMRHPuGmFVl6TQ9xBh/ErFnDsWtiy34Yv32Qaq5mQyCyt17ZL6xti1FRMrJdAZlBYGe6EnlNxQHeasqVsGMAcFPPuyBl6U37Mb7qI+TmF7hH4+Aki2sBnU7ySVNVPf5L5HWDgSsPlqb/zc3I0AnvFqQFggG/yv7MuL295xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408028; c=relaxed/simple;
	bh=wWAWxa+zvQUMOm9MC7nJeUbKuYl5szXsHWj4/y4OmFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgOPUGNm/CCRYDXUWs1aCL1xOGzhHjr9WldCF85XVv/mW6PIiFYOi4eKOtarw7FNJBquVhjQRddyd7FIy2J0nIZOdSlunF+kSnogiugd/uPZFLLuKTNLbYEz7fIS/gC4g3k4X/YSUEH8ywaP9c30acDCYZ5go3WL1pbB7kOUxeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NVLgfB0Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cDgONaxu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NVLgfB0Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cDgONaxu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAmsmC2390601
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	78U34vjJm32V0mthUVg9KTTl0e12pM8pLb615+vj5PU=; b=NVLgfB0Ql0Ov2eIR
	TH1I4+IGiCTNTDjm3qtFsJ95ZNLjOassi8nrABjUSaXkvWKoYpv9jxBnfoo/rjaX
	v1CorF80A73hZ648GaHtVPEwPV6t3EG0w3AjZa1uaNCKiKG+Hw3owUQZIBAO2nF8
	PXgXgPS8gnPtCyEzwMnKOyT0iOwZo+30zzWMPq3X8XV8IrTPORyvq0AFSkE3eqKc
	4jhE9m0nswq4jjuuQ5BWQqVZ1PGVbr20KXDM8afTDTkTY0lWT73c0aiKLTEeWXVm
	uO7kfu6fj8onAha6oVCpzWzxLAMiVUCsOO4L6IBt73DsjDPPuVGZI0nex/tDd1Dc
	0dorkQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh5m8e9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829fe177bbbso1121366b3a.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773408024; x=1774012824; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78U34vjJm32V0mthUVg9KTTl0e12pM8pLb615+vj5PU=;
        b=cDgONaxu9xV7e4KNQrebNxRXDx6/SGfkUxBVuhuvb1zpokKC/+pCu/kTpnc4QKcIPo
         19OUMcUkK+TgNf5zA1jpaiIyi/QYtMSvUimJla0iGifSEMZkn1L9AORdQJJBTj7q8nkG
         LB2LrDilHPHCAQDeYwyCSzok1bwsvDxBcJV2z2CCnWU3UBmW1JB6BXUsXEF48HQ/k5Xr
         K6DdxnHAZqCeEwP3QNTtr+z6e1LcVQ739C7JDCYYySr9LqSCgyFoSvVmVGK8vATYM/Us
         3eQawcGoMtMdcF6QC9RZ5GCVg5sUi4cA6fOKJnr5zaIba0JPUcHGg8g2etDhdDjbHklO
         ubJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408024; x=1774012824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=78U34vjJm32V0mthUVg9KTTl0e12pM8pLb615+vj5PU=;
        b=PGm2qfaUfgUjB1s5Roq9HkA3Lq1nN7WTKdLfkZhIGIHB0xBobl1kw7XDuciz9+2bv9
         aXGIbJGwT6v57CszWmmQT9bFd1MjQTk2ZI6gquRiOjBB39JSs1cwB3b1I9ViED3trSZ6
         TV9GRcaetuuyZbiWAsRBQH3unz8UlaQAd5DLYLAORzIhGpjazxCOhMF5d17qz9zUd2jh
         WkeeuQaKQUayorKNEENc8V9aFrqnsaEYEd3oCSgocpVb4u+ucTpwX/qmO4S62Cd0+Axc
         WzhGwC1Qh/kKIbVmXYAisIqmsdUVe4FYk55oUoJqcAFwHTK2RgKNKikc3jB/AZ8dlg5w
         gSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLs5ZKMFTZuZsZtHgKnc9q0DHtiECIl7rqZLHyYL5iwsJsaW4h+vHUduTqtxPKA4fCedBEFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmDvmywsNgvvRu3IadzqfDK9GMPsQsGHi/CiEU8VU0W5/xU51H
	/T4eZF4H5ZCu9gIVNVi9w4iUu6ZWmW8Z9UNYyRDMhhKKKkY/yEoU0uVCU7dY5UI7l4sFs69yj6T
	FrXQTHgIJ8LxgpI73XGFxcZiGDsn7rlwahVVyAMqV1QCV+SEOMYZnvxDyOfoFWmynOg==
X-Gm-Gg: ATEYQzyaZg3djzVZhARUIDDsShsS7wrkKdUVpvV3FhlU9ge//HSyh6k8hrI5IQnlKUv
	sNnqVKFrxBbcvDN6798nXahMEQ9I/A3d/TqUtettOEVN07RPO0P1TtB5DJ5sArjNtEHVYIXazhK
	YL9hcmyiBTaaPLHFHy1iGu3jMYDv3LA+hROjDlnP62+WlOD/3OYDB6zZsHkfIsbga34DVgqWdMW
	/OEM8HcH+ee1Y/G3Fw0zvDsyTA9SiU17LHHqIgFb/iNrlpyamlveKY5wvLDAjlIfJi4mDsNCTbX
	hQSt5RYgE2UnL+yWvQGWbGJ1lHOVphfdPPbzjKeDfBRvji1UHBUXhyCfjq28Gvq90206O5OWgKk
	Vx0zPTUgZusj8ZQtHlHM1th6upSy0y0QxFK+sAPkj38aGUtCq+nSmUy9R
X-Received: by 2002:a05:6a00:368b:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-82a19703e4fmr2544376b3a.9.1773408024073;
        Fri, 13 Mar 2026 06:20:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:368b:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-82a19703e4fmr2544326b3a.9.1773408023414;
        Fri, 13 Mar 2026 06:20:23 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm5775254b3a.8.2026.03.13.06.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:20:23 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 18:49:37 +0530
Subject: [PATCH v3 3/7] media: iris: add iris vpu bus support and register
 it with iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-kaanapali-iris-v3-3-9c0d1a67af4b@oss.qualcomm.com>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
In-Reply-To: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773407994; l=4125;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=wWAWxa+zvQUMOm9MC7nJeUbKuYl5szXsHWj4/y4OmFE=;
 b=SqUxLVUKMivw1MUUvqwiRt9NY5AHMtKwGvn4xnwnuMUqvHBHdJ41Zo0Qsq4ulv48Pk/4VS7lp
 DFGja+GF+9aAQ5ru7BE3cxRxbhi56F34zFu5U0ozbzSgbSTFsEJA/l4
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: OeMhX-HzoYipgR8vWQkNDoe7TjUaS1W_
X-Proofpoint-GUID: OeMhX-HzoYipgR8vWQkNDoe7TjUaS1W_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwNiBTYWx0ZWRfXw6CMflVBOg5U
 5JzlxYnS5fqeSXikgFdLpJPDu4CWFIghAcit1GaxF7MNpMCPEclWAZjrYfvxnjHfhNs+G7TqGtw
 4hcciqk/c6KkZOrRubqsmJc02cgN2KDgFS2JLH+lOgxTb8OXRjDgQKd0abJxcChUPAamoacC6wV
 twYCsX5dWGncaGJAvk6ibWAMuNZpTNc0+HNLjxS3Rgfepb0nqRMKwGZBssha++7cXn0/6TojwoL
 qeByovljtd6hunzxH6eUH5iZPTokzxxDyVkjQDAQbVhyL/c/VGDPiDw5IgpEVvTp+DRU6iz1qjS
 o81oKSgVi6JbPQauYWmQihw1vAUF1yyuWCCptaNBhR6VPVPh0vKZIVRm8YAt/qcKelLJh9y47iM
 OJiWQCh9Qy68o4d5szS+1PSL3MTQEK5TUqPhYZ+iQTpdmuxJpZBcRPTHpVWZ8eWr6CTm+l311MM
 Jd/ac2qVAxDzsX/l6VQ==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=69b40f1a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=rA3BtQNSaToOiFj8iVsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130106

Add iris vpu bus support and hooks the new bus into the iommu_buses
list. Iris devices need their own bus so that they can run their own
dma_configure() logic.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/iommu.c                              |  4 +++
 drivers/media/platform/qcom/iris/Makefile          |  4 +++
 .../platform/qcom/iris/iris_platform_common.h      |  6 ++++
 drivers/media/platform/qcom/iris/iris_vpu_bus.c    | 32 ++++++++++++++++++++++
 include/linux/iris_vpu_bus.h                       | 13 +++++++++
 5 files changed, 59 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db5178095404fec87cd0f18e44ea97cf354e78..fd5fb7c10da22ab548d359ca1f44504acc3d646c 100644
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
@@ -178,6 +179,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
+	&iris_vpu_bus_type,
+#endif
 };
 
 /*
diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 2abbd3aeb4af07e52bf372a4b2f352463529c92c..6f4052b98491aeddc299669334d4c93e9a3420e4 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
 endif
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
+
+ifdef CONFIG_VIDEO_QCOM_IRIS
+obj-y += iris_vpu_bus.o
+endif
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5a489917580eb10022fdcb52f7321a915e8b239d..2273243d1a80446233dd82dcd77444aa043ad064 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -204,6 +204,12 @@ struct icc_vote_data {
 	u32 fps;
 };
 
+struct iris_context_bank {
+	char *name;
+	u32 f_id;
+	u32 region_mask;
+};
+
 enum platform_pm_domain_type {
 	IRIS_CTRL_POWER_DOMAIN,
 	IRIS_HW_POWER_DOMAIN,
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
new file mode 100644
index 0000000000000000000000000000000000000000..9e9fdeb6e405aab26ecf5e57ca91fca6b8eda2c5
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
+	struct iris_context_bank *cb = dev_get_drvdata(dev);
+
+	if (!cb)
+		return -ENODEV;
+
+	return of_dma_configure_id(dev, dev->parent->of_node, true, &cb->f_id);
+}
+
+const struct bus_type iris_vpu_bus_type = {
+	.name = "iris-bus",
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
index 0000000000000000000000000000000000000000..422898cdf2f62eb7f4583d970a01c8776dd12164
--- /dev/null
+++ b/include/linux/iris_vpu_bus.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
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

