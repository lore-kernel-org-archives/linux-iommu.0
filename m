Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318F4219F2
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201532; cv=none; b=PyDV7wQlTTydK1MN8c9z+HZyx0F1EZhwEbB2Aziuuv518T5i+pH0WzP0vOMBgGWFLFkQDhP+nfMKJSoPEA6QflaFYkiTw+2ZqslkGsHgM9A+kfwyEmWAgNitopBhexJFIWHnaSPXQeaio6ov4bgu2iT6WIFF/fTE8q32bEAY1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201532; c=relaxed/simple;
	bh=U92x4HK8ifTfTc7KDp1LdFqO8zaCFAO9kJosDhnhP6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmZCaUrbiqwtFN7xdK3HXDnIWtg3OjhJForJxvimU4GGMxtAUp6yPJNWYKKAWoqMZQLdjLxB5kFNi5rxMj/ldnrxbaRFiHB9mus4VxbxutFJohPpyLlp+b0ApDzvqB28l9spNzcGN/dhu2y9R+tQp2bV9c1iACDnauxrsrf5r0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q65pcQVl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcnVZUXz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q65pcQVl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcnVZUXz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9kFZh3945848
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7evXDkp68Lk/Qex060cCqT9IdjlmfPgNN/jVLkSNYnk=; b=Q65pcQVljEviw5uM
	NE6OLn/BzQCgI4QfPM7Mg5EPISxiLeb7yIl8ZUmsF/BN9DXQhbk1VELYG+YEX/Z6
	ZE6vjX5J0zeWfr8Awf7vNv92LhBMImpNx64/jlOQFbZJEZMgXLs6VoJ10R3RUM5/
	W0TRYQdjh4LvgRwNOOnuA9tkuR992Ap9qhbh2R2WvPaxc1yFae6FqSlEynO3zrE1
	Hzw84cmAqsxvpPL5ipY8P6cWlbF6gqXaP3FbGH+ZXN51IxvU9CiBrr3JtlL5hHbM
	+VdxmKOEiw0chqw0tz+FOV6IW2p7xjh2tH+j7CjKdKfL1C8iMdlEnUJViIkx7Qy7
	qFrcww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck8x88t7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad5fec175so80898915ad.2
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 06:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201527; x=1772806327; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7evXDkp68Lk/Qex060cCqT9IdjlmfPgNN/jVLkSNYnk=;
        b=UcnVZUXzZBeRa1aV1AgMiE2DIbO1Hnk5tilzhCQlJY5poZ46ADhnokT5xvnUn3I7qp
         4DjeK/BsShDQ/4uo2QRYjPgu62PpnfeJyM2Gc+DbEByv6PvkW4C/O3HbqbsFB8FBexyo
         YQUx+NBCkzzrWCqbDwlaijgDCcAjIZH701PFqwgyXTkN6m/w12P+Afjt6krULDWFxxRE
         AlFIZLPtjHAxr9oEdwQoJmKu2PqGtpXTbFU80inyhhuo+5apY9LTuWJuMbv+jRYm3weh
         e5pjy1jou6oWyIBroqqDlKDbA3FSfYa0Kzs1GdG4tB+iYLqvx316Vlx2rtNS/0bKLKji
         UVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201527; x=1772806327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7evXDkp68Lk/Qex060cCqT9IdjlmfPgNN/jVLkSNYnk=;
        b=gI3LNsvkjbGGTEIWevInwJt7vPbcwYRGMoztDqAupmVJNhq3F80iZuKWGIUVOLyKnu
         f68cnQQCSpH2wEEaALgeREMQVIfqGS/czr++eRoLb4ArQTh4yEt8nRkMykQN6l1NGwWc
         ZMw9XTAuHVgyHKBcM8FgYN1XGNWKPkjNF2boTyDZkWzB7UXcINpGZtpvglD4DoXUEsPQ
         Fh7MO6kxJs9APr4FHymcBnQdYgWj/hIXN7lZQy6aze6VtRy69wFseG6WPxz65dzvCJfe
         FS5cSfRu5Er1uO5ccZod0Tv/qmsRTP6XkkEAURy1fCrRlQLO4LtZxMLrlJSy6yOkN39a
         CHXA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Qp2V9JzVOJl5Mjfb3spWsqSCfFV3pmlOA6mCafNW/XThX073SOaCTQ/56SK1sUjMLoOdGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ8mv1pxG6lJ5hUhl54g/x08vmBq9zWIc/ybpZ1kY7UXJ9UyxG
	B0VcM90LQUVND24Z8MnGwNipRv6EEfRYOzyPkyPpf/XOxOB7843zfrSrGCrf9UUbHCOf5Bqrd5G
	pVC1xaGUW9roRdvPJvkKQWHt/p4MIGI9eEIFBd3K446wknobao7BivYNqMw==
X-Gm-Gg: ATEYQzxwPEsKkj0hFii/o7Wtv0AKlcG6e8zgDTAL6DwBO9rE2JDaeYfhhzZ/pzXP25K
	J407jgWJVR7TN4pw+5wtg97vOKyDJv8UW0yIjmWp799Ynik006uBHoSTN8GvYyFw1U3AAEr1ten
	GBWvdMfcm+bUNN3y+uvTDFEF542uSGeLAGoHjGT2LQPIguVSzkzqwyOLaDjy8HD8Ymw9M8E1dYK
	Wrg5bTZ+aKrxiXRYWCpIFU4LK98ZzM+hTc3hEp/FC4KRuiRWYQGCr2RmUAvaUWEeIJyY9Uf/c57
	hX8W0pSYv9U7eJrhUm2RJw+aTa+596D3O1TbrNlZEtKaUvAcVo4SFLQ5FcPybB6VlriIhm/0RYC
	v314E6dlVnqItEytYVYC3ZqJ2lBuzMTP//VCpJj9VQTDWDo2a7z0YvmdO
X-Received: by 2002:a17:903:234e:b0:2aa:dbd6:605 with SMTP id d9443c01a7336-2ae2e4a6614mr29882185ad.28.1772201527059;
        Fri, 27 Feb 2026 06:12:07 -0800 (PST)
X-Received: by 2002:a17:903:234e:b0:2aa:dbd6:605 with SMTP id d9443c01a7336-2ae2e4a6614mr29881645ad.28.1772201526422;
        Fri, 27 Feb 2026 06:12:06 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm60960865ad.24.2026.02.27.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:12:05 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 19:41:19 +0530
Subject: [PATCH v2 3/7] media: iris: add iris vpu bus support and register
 it with iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
In-Reply-To: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772201499; l=3490;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=U92x4HK8ifTfTc7KDp1LdFqO8zaCFAO9kJosDhnhP6c=;
 b=jdoVUXk3ET+htylIX0X1XEbkBToNTf2jOc9KKhrCWMXdPhu3YPQv2BmUon/kkqdBROBOyEM7o
 qizaR1+CEbLA0+aQDi9/0NKs4UrPVKujei++EHWVa4ezUq5HPmKMb7t
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=WZwBqkhX c=1 sm=1 tr=0 ts=69a1a63a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kPm8v14ksbA5Et2Ge3oA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX+v+/Mi1skV4v
 P/IO4NBF2g3xFQidGzH5jIl3SknZzo8t0LDMM0koH56lVYkzxiLlP8EYNj6hxZ3GU07JfEh175e
 NO96Jsa/wXBx+PgWJL2vHOhV+DsN2OMuakqI/hrfAXyqyQ02XHJvXe/FKJGnXuo/Dv0MgIDUcOh
 tUnaZzachWrtQQ83jkRdiO9dYe9rEQ490BLTCC5ORaoHZeA2da5QY2tB6FXryWmIjfYwE4Z+Cb8
 YusH1dm2Xh5JtKalDizPGDNaF/ssD2bcpPVwPF2GGWQPMmrUF1W8gyvdSugoby9k0VCU0XRdcV4
 nGdzzIR3yxjaWfiizHWRSDv+fsvo122oQaq3ySXhZva1fmTjpimolh9yoYc38EXguiFVjth1ZeR
 q2bSodktK1iYKzWDaIY/iuorJKyS3dLpUCDDw4eystltHoab2greMlbrfMZIqridvKdzj/8qbGh
 TJbybCE7FkCTx5pO/4Q==
X-Proofpoint-ORIG-GUID: v3nDjBFpYmlCAG3PijByZCdl9C27pEcP
X-Proofpoint-GUID: v3nDjBFpYmlCAG3PijByZCdl9C27pEcP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125

Add iris vpu bus support and hooks the new bus into the iommu_buses
list. Iris devices need their own bus so that each iris device can run
its own dma_configure() logic.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/iommu.c                           |  4 ++++
 drivers/media/platform/qcom/iris/Makefile       |  4 ++++
 drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
 include/linux/iris_vpu_bus.h                    | 13 ++++++++++
 4 files changed, 53 insertions(+)

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
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
new file mode 100644
index 0000000000000000000000000000000000000000..34ce78d9b0ff1feda15ba4f060a56d02749a0858
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
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
index 0000000000000000000000000000000000000000..8aba472fcadd269e196b7243da5660deaff31abb
--- /dev/null
+++ b/include/linux/iris_vpu_bus.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
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

