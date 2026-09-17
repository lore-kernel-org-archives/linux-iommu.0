Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6B3F4829
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621327; cv=none; b=VX3lx0xVwtVPG8z0JC3zwyZBOFqYtTX4/7eRiIdUVkrOmUHLcqWF0VW/hhr5TWdkQiq32QRAM8fFCpl4GyZNI01feDIn6CQ/Mf83y2+Z/rvzVNrFNRVCRS6CAGsmHn1TnsDTX/5nV6ZwkdEGtrpYNVq3tPAqmxSQrMfRM3IAiqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621327; c=relaxed/simple;
	bh=UZNbS73oybmrDG7bGYlLhJz6xGFDS3+XV6hx4qTvcO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7lD5CMmrUUdaeRzYfVleP2lmmC7KqsUNdPL4YiwO2PY/PQmAb5/Wdhxiu/VzZIxzr+jXNefP48woFiwbom30lbipsNzUpABBPBPE1C+hUpi/nhDHl9TB6QEUef0hF+L77sEAf/F+wfrbZoySXnxClvSFxmy4TnAIv1ynzn8lxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A1kz/VOp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HCVSQKQ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A1kz/VOp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HCVSQKQ7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN4LZM3107233
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b8+vcGM6Pv9ziGSqm1+0G0Ejs7T9TPAZKmNqGArUBE0=; b=A1kz/VOphJFKz3J/
	2DGJjoNVZGN5LyEFaR5KxGab/ci+mgaN91frbUAl4joiu/CwEVOB2BB5gEHcIaWl
	Y+11qWprGjHBfrGNoNBAVe7TgWBNvsKMkd9C9NkkyfK9awrFoVSIkmFp+enj9066
	0zHOMlsWKXfrkXeqnMu/gooA5//74CncFbSKqO5eWdqQsAwCe0yKcpJ4J4S+dJC6
	X7R349w02/WeJUkANv2BpijI9SGWQBHLe8m9gBNt5XzFeZkSS3uqfVQjoWKgvgh0
	LJMVlOHIIbY5V5AVUvZXpXzMBlLOHEgRaeN4k/F9QsjzVuXYLUJu8Q4VRBcDmXaM
	y84diw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquw2ugu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:02:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so605724a12.1
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 22:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789621324; x=1790226124; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8+vcGM6Pv9ziGSqm1+0G0Ejs7T9TPAZKmNqGArUBE0=;
        b=HCVSQKQ7NTfvE9VeMaIrwFoYJa8cOUk3raT9yIt4+iR+Q2vQbdn/clEsH0uxiyf98D
         Y3EPBcE+0u+KQis3H+yJsl0WXof3yEbFAXIQOYo4lfDijaurEK64o9mkw0TpLZ1pv9Be
         j8aKqRrGlmanypmzigRWSGyDz/rzp2wbUF2whJfh9Tv04iEYH4kheWiSTm7OnInv0X4p
         04/SqMP/NoWm8kmVNoz3MFRyQCutrCTwgGvuBDPyO8iaTtEVWGqrmhJKj26bWPvr0BOp
         UzaGEfyZOGWNlpacSdGHcmb1S4lublbWZSUosihhCy+uVOkeC1iybqi+uD7HKVJhm8DO
         lQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621324; x=1790226124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8+vcGM6Pv9ziGSqm1+0G0Ejs7T9TPAZKmNqGArUBE0=;
        b=t3dRg4YD8pzmtLjIi/LIsqyMTBon/LjTxVDr/ZYtO0+H6O8M/pL1gBXGF/ckCeJ9xS
         b5Pv1UI8PIKTRJkW+wzufP0KFW7ch1BK0IC630I4+9T0csXT0B0F5zKEqNuxTRD2CKXX
         F+UsJsapOve+DXqFCrhGqQoO/QcMLDlqcIF/yPuhY2qvvyWPSnSGOppx1DUABHC51NLM
         amTnZHI03Pul8Ahnb9JBio88Mkegb3/GEovTbk4wFTaLrX+f7YuqZ1Jxja6Zn7EFGld7
         pHYKrhUfxleuk8BcydTucr9dRHn0luhJv38VVpyusjIdIEnGg8fPXv/e09V9L/fw/L3i
         fNLA==
X-Forwarded-Encrypted: i=1; AKwUvBw7FMPjLsS/cDvXp8Oaf26xEGehqHVVhotkdbv9dttCiJ2b9yI5bWr6gtGCRWXt6PnuUlnTkg==@lists.linux.dev
X-Gm-Message-State: AFuF++khGIl+0QVzAGGdXvg+78fM5IlCf/HgSUKUG9saPKNmkoWkGIrS
	33TPD75zDuiH3tTOVOZnJB6bAsG3XipBhLPTXjDCji9FO5G39ils2wJRvaVNeqTOeCN46p9fvmY
	f0VlXjSmx07zoGiNXyF9EPqVIKjPPMIcSuSwKhokj0+R/MZDepJ3UdGb9UA==
X-Gm-Gg: AYBFou0+ibRfHRtpevn/rzBN0DWA7Q4e1451cBV3ITAyFT9chHnM7G0dvsnFEyGkdr2
	fe8iU+bAkwJ8YmqX9Lzhz1d6+h4BqhTBJf4aPc+u7ngotfDtN/65r0P9p8q2TSV0/mVbR4sUo2Y
	pLrId4PrUX4pkLE6CNIVapAE99DN8m2HmIUQ6BWJGXH/f+gtUFsdCwJcy1OJ7/Jt6PakxBfdcVK
	0gyil4ddp9JziXdQ81eQr4OsPaAC33H20/JdUSBVcZf6+bvSBhDL72gaX+pCa1mmsr9WFf6+Sk4
	LgyBBhGHTkikd3va2mE4mAtgE4jqP2QGcN5fVde2CWTZFCfE/5tm5xOA4ae1fUq5zwOZy2xsfL1
	voulajeppL/CrY9mB1pAfNlx9Xen5/pVCxg==
X-Received: by 2002:a17:90b:4fcf:b0:39d:ecc8:73b1 with SMTP id 98e67ed59e1d1-39e1e2bd30emr18436725a91.7.1789621323715;
        Wed, 16 Sep 2026 22:02:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcf:b0:39d:ecc8:73b1 with SMTP id 98e67ed59e1d1-39e1e2bd30emr18436591a91.7.1789621323182;
        Wed, 16 Sep 2026 22:02:03 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm23544223eec.31.2026.09.16.22.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:02:02 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:30:26 +0530
Subject: [PATCH v11 7/9] media: iris: Add platform data for glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-glymur-v11-7-e0c8bc914742@oss.qualcomm.com>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
In-Reply-To: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789621265; l=8247;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=UZNbS73oybmrDG7bGYlLhJz6xGFDS3+XV6hx4qTvcO0=;
 b=U4z7kkjLpeB+x+VauwFnxdHI14IHW/zznLOl6oHbFhSncn84DIUhEjwipEdmtOmeVI/iUAIVJ
 4tQ94nnQkH5DIOfjahjxoAP1mapPP/2VwHN9pg0DyUZtD2BgFErOsWr
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfX9nQyWNA1RwSZ
 ktb0DZHQV0x+GH+zcziOIqlrs1Km1RhMtpWbVkQU+ELT8o6IC7KhLMSY3COls2U0039WvaU0YeQ
 5e28wlwYD7ZVZPOoj8tQ8u1yDfiX/mw=
X-Proofpoint-GUID: _Ipfvft_ZKLfL9Ia-nn_zojOmB3kYbMG
X-Authority-Analysis: v=2.4 cv=N4m8hG9B c=1 sm=1 tr=0 ts=6aab744d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=uD0unFxyaCLUJkKXN-EA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: _Ipfvft_ZKLfL9Ia-nn_zojOmB3kYbMG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfXzgFtlSUEu0Jo
 RPdrFC3LgtrpxOxHYkWycPzfO4LCMaUSbEiaqyFUHL+yYaqKCExJhnlpJrlNzqZQ0Or4Sp/vEog
 e4+8UY/PlMUH8Wm/sCsgMFZZNQmv+Vkfrw6UCwrO9lx/XTRdyztY+sTDCuE4slB8Qz+W3UrhtNk
 ZYt9fvlCzzpdszVoPGTQA038IKuA+NNS1CKcwRyFJEmH00UG3DK/wKzo0vX7f8CBdhL8RiB0ghE
 SX0f0n5HwnesA1JxrS9KohxOvKXFUxj0iNEAU7/jMMwhSn3klTUSCslDk2avpZmt0QJXpfcRk2u
 BDtf3+9srhjWwtEnC+jnakJXSI7uP/Z5bUiBaD62eSPiI2HptkST/+xBFppJS3mL2tPW/rtNivM
 48gZe+crdL+0Fpc6qNp0HxwZHQZJU8I355ChZidL/ReTfmWRyDc3laXdEA8so9CT/aYsh8UMSHR
 yWCX50ZLJvii6Wj0frA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170063

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
index d6b9e420be44..1024a2fd75a3 100644
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
@@ -54,6 +58,7 @@ extern const struct iris_firmware_data iris_hfi_gen1_data;
 extern const struct iris_firmware_data iris_hfi_gen2_data;
 extern const struct iris_firmware_data iris_hfi_milos_data;
 
+extern const struct iris_platform_data glymur_data;
 extern const struct iris_platform_data milos_data;
 extern const struct iris_platform_data qcs8300_data;
 extern const struct iris_platform_data sc7280_data;
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
index 9a62f5c5eb60..aa03f86d1945 100644
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
+	.firmware_desc_gen2 = &iris_vpu36_p4_s7_gen2_desc,
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
index b36d3d05dd3d..411ef7ef8dae 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -550,6 +550,10 @@ static const struct dev_pm_ops iris_pm_ops = {
 };
 
 static const struct of_device_id iris_dt_match[] = {
+	{
+		.compatible = "qcom,glymur-iris",
+		.data = &glymur_data,
+	},
 	{
 		.compatible = "qcom,milos-iris",
 		.data = &milos_data,

-- 
2.34.1

