Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8134404B
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045119; cv=none; b=OGpJ7xKrDpdfMA+FDdaTVh9C3SKxOZ0PYnRHiOnOOGuW/+n89qSUQWvZ1o46D2dJB/FNxm9FDeogmaZkII9kqL/DbLD7n9yNn+dKMW0acBOpNFC9oKi6IbUWaYHEOKWLNhXQFnaXbfRry3snGC6ivuq5p2L2OT0g89hv+uo9Jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045119; c=relaxed/simple;
	bh=1w4CgMY6hqW0RscoW+I4KpJUnvg/6sO9akTSyFxDnD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFLIE5h62U+noM7lmplUAPc+lNa8C/ekxunRk4T+2GowMJzdPszQeOB/aDsS9YIM55f8aZGePGziAqfzKAk0h2TLD7c5+agR213lAKUBvPhXOZbMZRGVRWlUQIkS/jULxlSfF4ECgj4KpIzRm5pMemVg1o9h5LRmqTSpKkoyuvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=et8My78g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gX6X8lAy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="et8My78g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gX6X8lAy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5SKOW4181436
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etB4FVaixj6pjK5WgAj9fa3+p1eiXpv7Kfpsfz5keYg=; b=et8My78gyoSp4MGr
	Bw2qpiWsFCinpTt4wYYApXTbfrtplBIyofelI3nFcQcdUQWKzsrmPKi4O/tjrkap
	vutJ31bLFrqsQZQ+geVhwomWbhx8xHsgf4cR7Gdn8FXP7iJ35wMzLBFElgqZpRRR
	QRRClg0aZD6ADpAeqgcS8LUqPYTQVXcE6iuucwJOQRBtTEnq5qzw7m0tGFPun66a
	XX6IIVvVG85j4LZD4PlzPKoNzUjulAMQnpG5iljsh7cmyls2GH6GeIWdJTLNJP+Y
	YabNckdeYCw9HPVwiilLtmpQ+OvpKE1Tmq4gjXNeBd77FIQ+gHFJ2fi45x57/2PE
	k28y1g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm572g1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso2158875a12.0
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045116; x=1785649916; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etB4FVaixj6pjK5WgAj9fa3+p1eiXpv7Kfpsfz5keYg=;
        b=gX6X8lAy5T8AjoPbMH0v3rkJZcQ+qc1TRYY7upxQcToJnNc+H9IAyr11OpZDBhcpOl
         8xkT/btyBAgqtGaWK5fxVtdxPxdp8B+9uK4sj7ckYVjtrTHSpk/M6b48DipfvGE+XuSj
         EXGE5CsS98LMZT8RAQJ054hX0yq6by9zI3pcAu2bN2QPM1KkbnpItH/pJRqYgNobJrYw
         3Rb7Ar2MzPkaMXQLm4SiLvYbcUiIEEuV3U5d5fO8xTmvjHNp28MfiojfmN/tJrXWqBHX
         a0HY5ZOBcTfHwxm0H0Wlf8b+q8oEw8Wv6+06UEMOVf+zxZ/p5RmIgRm/e21YYw/kOc3j
         WzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045116; x=1785649916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etB4FVaixj6pjK5WgAj9fa3+p1eiXpv7Kfpsfz5keYg=;
        b=AiNGK0w5qB4AZQ3XEzb3vEtLuS/eR05kMNVD+qM0NUNzLPnLSVadAFE7b5bFJ+2qmr
         7qxxh2ajSkjHzUrntroKGeI5/oGpvCSvlUgyjU2DsX6CRD7aJ2KuYlY2SKGUb4DFs7eQ
         GdWesdWw68aTxbfQVhA3LL2MYgo2Q1WIU68c2qzcnkUuPh/TNI5+UI0Y8xhQ8Wld02g5
         MRNUSccpf6Ta+Ww/rl6OZwMG0HfKEUppnIUQJ96Ygo9d31L2TzuP5MWq2puPkvMfnT8m
         vqGCpESrwPBiiZjwp9xvtnTIIyhnT7eNkXjJZ7CqzK3QYea+6pd1Q4UQaey2+LG4vAPw
         9cdw==
X-Forwarded-Encrypted: i=1; AHgh+RpBmap8/zel8DhvgsusO2mxHroaPR2cTjZ1Ofbulnjv9EibCSI2PY5Mbacu814OwzKL1IZPZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEntwuPlRM5Wd7+swtkpw+P8PSNlNqZ04mQtGCCyctfPLZnuZk
	ESxdVQsA8Fyo/v8u4J1tKZeKri59yEhz8tb263EfwcoviqX9yXxv7xpSEiRHXdjyQCYDq5nUbCc
	KChC8bZhIcW1vTsnt+jYJgPH48Wh6AD3cPTwaLxImJFe3Gv+XyJ+u8jP4TQ==
X-Gm-Gg: AR+sD11M61tX6chrXMZzXqlm7heaBLBqYKYciB4vEKpT5VW6w8D90gyAB7JGetdpiMm
	KODaXZD+cRZEQJCwCubl3qQnbCVM3ePh5bAwQNHoTYpmVyYs2kYX5/ZTc935NNW4h5dtLsTl9GD
	vxCu6sXtdDwyGQpZ7H+1cpQ/4I+N8O8Y8Wnpkr52XNy3DRZrYzhAzZDOwlC7O19thbLt3pMFxWy
	GcTfVV7pKP+1Rhl/xub7F+xpJStjhNHIeZobYAvwxJDn3vACo73PJf73AIvvRV/RA+TgRY5FPpZ
	bg+NWSzkajxqZL2cTDnRozmInlCLypXmV7pZFGkIUmbCCYheJC8PR5UdSf7OVHMYLn8t6n0QZCo
	d2vNRA4SnwbmH3ycG14sI9Jy5Fpvez1ZBUw==
X-Received: by 2002:a05:6a21:730a:b0:3c4:511e:26ab with SMTP id adf61e73a8af0-3c67dab5eaemr4046470637.3.1785045115818;
        Sat, 25 Jul 2026 22:51:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:730a:b0:3c4:511e:26ab with SMTP id adf61e73a8af0-3c67dab5eaemr4046444637.3.1785045115377;
        Sat, 25 Jul 2026 22:51:55 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:51:54 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:42 +0530
Subject: [PATCH v10 12/14] media: iris: Add platform data for glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-12-de451559e88b@oss.qualcomm.com>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
In-Reply-To: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045024; l=8204;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=1w4CgMY6hqW0RscoW+I4KpJUnvg/6sO9akTSyFxDnD0=;
 b=DPjdGJfWzEqB6Vqf77ZHBdXB3a/hKJhWHmTmnPlBb6Cp/uBybKHtQYAzOXI1ylzbNMJ9vezPa
 WU+7TIL2LR7D5vJSFXpfdjYE4BuPGTS/bWcs33MBEHD5xGKPqgfztK4
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfXw9V+WINUdYVZ
 E439NFd1wgHfvFmkqj2wtHyp6HlLIUO/axxqdstczjZuLDZFHIsoS4/oRLRERbCEBfuaEbg7ILd
 gVUcaddhi13qm34WGK70gXks4fFI+qI=
X-Proofpoint-GUID: -vFNV77srVeucCgf1FPXwF0tIc7qEfkE
X-Authority-Analysis: v=2.4 cv=FOErAeos c=1 sm=1 tr=0 ts=6a65a07c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0Xn_3AH55rwbdtokavwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: -vFNV77srVeucCgf1FPXwF0tIc7qEfkE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfXxW8J55XnGRml
 x3RSSR7yoQI1Wu7Q0CY0t9GeZFOVrLus44oYLSipqMOMiUMt0eqqMRgIZC/DRidNeEbZZ38lF9O
 kAhqVUCmhYMR1hR0ry/09onAFhca8OxKKM8kjw6eHNgLW7lPxVkTBLU72/rBGrfnYSOiPc1KeUN
 gbqyHBvbvDLy/IaHSJl9bUQvIgmv1C7bUlNZx3HpqUqmEYFbAzNdhe9GiXKNGxWzFaGbFBudum+
 P7KMeSFGobhvNHq22BISUZZ3njsrhUeq8tMh10UO6MHmcf/tdi/JoOUp+CeP7z0uhYtCRGELpfE
 RFnU8bm+bU5b47QcEkuAuMzVdNkmnkcGUSajiSkWu8Rp5opIh+jIddBnkhq5cB5K5c65S3JV+nK
 Dk/PpWCyXHGo6n+uFAhkMukTbV53iZi2jvJOvWga3tfJKM7fPEAbhW7qVHf0lHzZ1XUW1sqb1Qu
 kbHvyuIepX020VzqspA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260055

On glymur platform, the iris core shares most properties with the
iris core on the SM8550 platform. The major difference is that glymur
integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
one. Add glymur specific platform data, reusing SM8550 definitions
wherever applicable.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Makefile          |  1 +
 .../platform/qcom/iris/iris_platform_common.h      |  5 ++
 .../platform/qcom/iris/iris_platform_glymur.c      | 78 ++++++++++++++++++++++
 .../platform/qcom/iris/iris_platform_glymur.h      | 15 +++++
 .../media/platform/qcom/iris/iris_platform_vpu3x.c | 35 ++++++++++
 drivers/media/platform/qcom/iris/iris_probe.c      |  4 ++
 6 files changed, 138 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 48e415cbc439..48570da56aa0 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -12,6 +12,7 @@ qcom-iris-objs += iris_buffer.o \
              iris_hfi_gen2_packet.o \
              iris_hfi_gen2_response.o \
              iris_hfi_queue.o \
+             iris_platform_glymur.o \
              iris_platform_vpu2.o \
              iris_platform_vpu3x.o \
              iris_power.o \
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 99f59b64f853..e182030bd537 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -39,6 +39,10 @@ struct iris_inst;
 #define MAX_HEVC_VBR_LAYER_HP_SLIDING_WINDOW	5
 #define MAX_HIER_CODING_LAYER_GEN1		6
 
+#define VIDEO_REGION_SECURE_FW_REGION_ID	0
+#define VIDEO_REGION_VM0_SECURE_NP_ID		1
+#define VIDEO_REGION_VM0_NONSECURE_NP_ID	5
+
 enum stage_type {
 	STAGE_1 = 1,
 	STAGE_2 = 2,
@@ -53,6 +57,7 @@ enum pipe_type {
 extern const struct iris_firmware_data iris_hfi_gen1_data;
 extern const struct iris_firmware_data iris_hfi_gen2_data;
 
+extern const struct iris_platform_data glymur_data;
 extern const struct iris_platform_data qcs8300_data;
 extern const struct iris_platform_data sc7280_data;
 extern const struct iris_platform_data sm8250_data;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_glymur.c b/drivers/media/platform/qcom/iris/iris_platform_glymur.c
new file mode 100644
index 000000000000..49edae8120fe
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_platform_glymur.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_core.h"
+#include "iris_platform_common.h"
+
+const struct iris_power_domain_data iris_glymur_ctrl_data = {
+	.pd_names = (const char *[]) {
+		"venus",
+	},
+	.pd_cnt = 1,
+	.clk_names = (const char *[]) {
+		"core_iface", "core_freerun", "core",
+	},
+	.clk_cnt = 3,
+};
+
+const struct iris_power_domain_data iris_glymur_vcodec_data[] = {
+	{
+		.pd_names = (const char *[]) {
+			"vcodec0",
+		},
+		.pd_cnt = 1,
+		.clk_names = (const char *[]) {
+			"vcodec0_iface", "vcodec0_core_freerun", "vcodec0_core",
+		},
+		.clk_cnt = 3,
+	},
+	{
+		.pd_names = (const char *[]) {
+			"vcodec1",
+		},
+		.pd_cnt = 1,
+		.clk_names = (const char *[]) {
+			"vcodec1_iface", "vcodec1_core_freerun", "vcodec1_core",
+		},
+		.clk_cnt = 3,
+	},
+};
+
+const char * const iris_glymur_clk_reset_table[] = {
+	"core_bus",
+	"vcodec0_bus",
+	"core",
+	"vcodec0_core",
+	"vcodec1_bus",
+	"vcodec1_core",
+};
+
+const char * const iris_glymur_opp_clk_table[] = {
+	"vcodec0_core",
+	"vcodec1_core",
+	"core",
+	NULL,
+};
+
+const struct tz_cp_config iris_glymur_tz_cp_config[] = {
+	{
+		.cp_start = VIDEO_REGION_SECURE_FW_REGION_ID,
+		.cp_size = 0,
+		.cp_nonpixel_start = 0,
+		.cp_nonpixel_size = 0x1000000,
+	},
+	{
+		.cp_start = VIDEO_REGION_VM0_SECURE_NP_ID,
+		.cp_size = 0,
+		.cp_nonpixel_start = 0x1000000,
+		.cp_nonpixel_size = 0x24800000,
+	},
+	{
+		.cp_start = VIDEO_REGION_VM0_NONSECURE_NP_ID,
+		.cp_size = 0,
+		.cp_nonpixel_start = 0x25800000,
+		.cp_nonpixel_size = 0xda600000,
+	},
+};
diff --git a/drivers/media/platform/qcom/iris/iris_platform_glymur.h b/drivers/media/platform/qcom/iris/iris_platform_glymur.h
new file mode 100644
index 000000000000..9f2877ec9901
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_platform_glymur.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __IRIS_PLATFORM_GLYMUR_H__
+#define __IRIS_PLATFORM_GLYMUR_H__
+
+extern const struct iris_power_domain_data iris_glymur_ctrl_data;
+extern const struct iris_power_domain_data iris_glymur_vcodec_data[2];
+extern const char * const iris_glymur_clk_reset_table[6];
+extern const char * const iris_glymur_opp_clk_table[4];
+extern const struct tz_cp_config iris_glymur_tz_cp_config[3];
+
+#endif /* __IRIS_PLATFORM_GLYMUR_H__ */
diff --git a/drivers/media/platform/qcom/iris/iris_platform_vpu3x.c b/drivers/media/platform/qcom/iris/iris_platform_vpu3x.c
index 72dd23dbe02a..4049e134c3f0 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_vpu3x.c
@@ -12,6 +12,7 @@
 #include "iris_vpu_buffer.h"
 #include "iris_vpu_common.h"
 
+#include "iris_platform_glymur.h"
 #include "iris_platform_qcs8300.h"
 #include "iris_platform_sm8550.h"
 #include "iris_platform_sm8650.h"
@@ -48,6 +49,12 @@ static const struct iris_firmware_desc iris_vpu35_p4_gen2_desc = {
 	.fwname = "qcom/vpu/vpu35_p4.mbn",
 };
 
+static const struct iris_firmware_desc iris_vpu36_p4_s7_gen2_desc = {
+	.firmware_data = &iris_hfi_gen2_data,
+	.get_vpu_buffer_size = iris_vpu_buf_size,
+	.fwname = "qcom/vpu/vpu36_p4_s7.mbn",
+};
+
 static const u32 iris_fmts_vpu3x_dec[] = {
 	[IRIS_FMT_H264] = V4L2_PIX_FMT_H264,
 	[IRIS_FMT_HEVC] = V4L2_PIX_FMT_HEVC,
@@ -83,6 +90,34 @@ static const struct tz_cp_config tz_cp_config_vpu3[] = {
 	},
 };
 
+const struct iris_platform_data glymur_data = {
+	.firmware_desc = &iris_vpu36_p4_s7_gen2_desc,
+	.vpu_ops = &iris_vpu36_ops,
+	.icc_tbl = iris_icc_info_vpu3x,
+	.icc_tbl_size = ARRAY_SIZE(iris_icc_info_vpu3x),
+	.clk_rst_tbl = iris_glymur_clk_reset_table,
+	.clk_rst_tbl_size = ARRAY_SIZE(iris_glymur_clk_reset_table),
+	.bw_tbl_dec = iris_bw_table_dec_vpu3x,
+	.bw_tbl_dec_size = ARRAY_SIZE(iris_bw_table_dec_vpu3x),
+	.ctrl_data = &iris_glymur_ctrl_data,
+	.vcodec_data = iris_glymur_vcodec_data,
+	.opp_pd_tbl = iris_opp_pd_table_vpu3x,
+	.opp_pd_tbl_size = ARRAY_SIZE(iris_opp_pd_table_vpu3x),
+	.opp_clk_tbl = iris_glymur_opp_clk_table,
+	/* Upper bound of DMA address range */
+	.dma_mask = 0xffe00000 - 1,
+	.inst_iris_fmts = iris_fmts_vpu3x_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(iris_fmts_vpu3x_dec),
+	.inst_caps = &platform_inst_cap_sm8550,
+	.tz_cp_config_data = iris_glymur_tz_cp_config,
+	.tz_cp_config_data_size = ARRAY_SIZE(iris_glymur_tz_cp_config),
+	.num_vpp_pipe = 4,
+	.max_session_count = 16,
+	.num_cores = 2,
+	.max_core_mbpf = NUM_MBS_8K * 2,
+	.max_core_mbps = ((8192 * 4320) / 256) * 60,
+};
+
 /*
  * Shares most of SM8550 data except:
  * - inst_caps to platform_inst_cap_qcs8300
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 9e96fa218dea..6ad553990c89 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -493,6 +493,10 @@ static const struct dev_pm_ops iris_pm_ops = {
 };
 
 static const struct of_device_id iris_dt_match[] = {
+	{
+		.compatible = "qcom,glymur-iris",
+		.data = &glymur_data,
+	},
 	{
 		.compatible = "qcom,qcs8300-iris",
 		.data = &qcs8300_data,

-- 
2.34.1

