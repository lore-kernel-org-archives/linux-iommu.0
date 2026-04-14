Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C22EBB8C
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142895; cv=none; b=HcuQsx9MCWxG6a7sOcET3lhmbnPyvrgk6wEm8Xog8YfKkunhx95U7e8ON9UBtJODGarT92G2nGAeHIFJhSJSDh+vEjCUIhFyV9olv79SZpfzwvomaUAgxe+llCP5Tq+wKUvQjZMVWSG2Z30jYz8930TlodKkwTb3nnTJ1Ca66xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142895; c=relaxed/simple;
	bh=fWGxEoonf/oo9WtQdDfbe3IkEedzcHjEPcoyRgZE6vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wcmjva6qF7sx+T/lze4VVqKZZdsILR1LTtE5FcVYVvXicXIlA4qar/Vqg6D2W7OAKuEm8ZQTNcHY40qEH8FFqol8mXCbzpzm+IXiE87DcKwukDge5vXLZEgyGS+kQw9OLzzAsC5+7ydJ9UHSiPBEPEOfD6rhHk8Kg7mW789mNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pdkByIx/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GG5PVXQM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pdkByIx/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GG5PVXQM"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLCZjf280927
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ervXzOVwYOXbrB/9/dp4G7nXAxNkEjjJ29YUopnTZBY=; b=pdkByIx/movL9uYT
	nsF288VLaTfac0bMaztN2OEb0uRZA8VJYR60fsOJU8ZgZEAIZy0ttJNqHFbt2Vuv
	P81NWGmkPLQNjXJxp5MIdZ/CXGS8OI8WsDKoBTRBOJ10IWmJQA4usoTBL1ryDX/M
	tiQxbmj7uex2ZFj/Ih4dDPfd1Vl5pxVu8Es3CkKrokbhwbEVnqD0mPKe/zDY6FC4
	78M7eMbJBMxb+gONBUIJimKY1DHAD7O8f6BZ62YKf0cK+rkRMyLjRia9GrOOJy8j
	nIShspZghp4uAHt/yDPVB4wdQtsdYuqgxphwm9lee606nQOhqbeBbWk0x6KFd7DI
	r0idvw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vh23d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2adc527eaf5so37080415ad.0
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142891; x=1776747691; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ervXzOVwYOXbrB/9/dp4G7nXAxNkEjjJ29YUopnTZBY=;
        b=GG5PVXQMW7GRHkgzlYP4MByrLnxAoMXdaLld8mhFuVx5VTO5YY+zqSTUHTqybZr6i6
         wN1ok+C5Y7BeRiKfTTJc9UzzFf/vx8x3+bf3dQDuslCEcMM0paXjJcURH95Yx/SrPQfx
         WEqcei9GwCmsn11lK/qSWFax8toqX7ryZHvk9gHGOgIGUvOVYw5zfo+Jjtlu/qaxQbry
         Y0AoR/hXG5ncNyAsIgAVNMn1427CC3kCvsBQSO5LzL+j7VszJ3ko6cVkVak+6uOi8EZ8
         HJzT04k+LWnQ16pyGIuDGhmaVGchGupvVtabNzuV1cyKutazxCPSilCgTVXBeFJww/KZ
         u8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142891; x=1776747691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ervXzOVwYOXbrB/9/dp4G7nXAxNkEjjJ29YUopnTZBY=;
        b=Zo5/c8F3Zj7pGYu/8dGSHOSjWZ7ycxt8ct5YB7xPCyX62NVtVxCsxxndMSvEFHJDVW
         0jJdcnYLelGEnPFp2a7yg1dj4IpP0tVHSR/mr5f90zI72MOQdsIxG329kxCV+IrbcVfD
         pNJi342hf/lrepQENpdHssG2LnWPnACSMwmkQCNbOY2dZvbG6vfUhQzx38NMbGPLP0/s
         jwFHmoko9C22qUNUQinMbKxIJVWUkUbj+cOi9ADxPLwIL7mfm+lF7dAKy2DcVZZ5CfYD
         PwuP+QKMAcuCLZcR57oQnOR1XqnEjTKaVmHPGXzYM52Ue9ZYAxOx17iHo5mW9JUKGe1Z
         /nxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/miDBcnkYWG7sX/qabAFBIQBPbe2p6YyiU75GCcPUpYrn4YZoQNaQjii8f273Non51TNkkKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUkX6ncf8yo6w66EdjSIVsDQ/UGmnff/6DYxLAmMvNm7FNG1b+
	3lM4wCTj1sWE53bb1Ufbhu3zrzoC9pDLP/60E5sFm4u+RUzLaK0q0k6ugn/zimPLrmsGxhJSTC/
	7B9FD+4lClawh7RvtDI5jVradv9mMLshVboERUDxuOheuR4lBwsWbWZ6ZqA==
X-Gm-Gg: AeBDieswbFgGcwYPGb1IFwuqgMFP+v2IifLqgOK6iVhxw3dhAsjWDu8uR8jXmF8lP0A
	C4LYaVwa+UNYO9pDZbrj9mMwZUSvgnLvcL3GU3K7tmald557Tgy2HuzYO3xihcLRgnWQ+WxG89H
	7SSZLXwRv7vFKAE7bQLOhfAWa5JM37JW6Ew/pVge3tJSBDUd9cNAifxB4Y3EnYPU+ag4pIIt/43
	5ijpTq97NLZ5ty0T7qlV87GXUe25lIKaoZtgd9aok9dGaBDIHlLCzPyfGVLF84ZjBm0D+ZHgCKa
	CedsSBMu57jj5I6HGShWfYyJ7AmWrhjzpQDr9MnDD2h/0cqDJclTvYOCuG03rpQxT6gMWDlBFFU
	og4dxL82JByaYnlAlJqPLzs1IdnSECDJwtSY8dmrg3mLgqqH1L3wVhVQ=
X-Received: by 2002:a17:903:2ac3:b0:2b4:5df2:ebd8 with SMTP id d9443c01a7336-2b45df2fa77mr59231925ad.45.1776142890843;
        Mon, 13 Apr 2026 22:01:30 -0700 (PDT)
X-Received: by 2002:a17:903:2ac3:b0:2b4:5df2:ebd8 with SMTP id d9443c01a7336-2b45df2fa77mr59231435ad.45.1776142890206;
        Mon, 13 Apr 2026 22:01:30 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:01:29 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:30:06 +0530
Subject: [PATCH 10/11] media: iris: Add platform data for glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-10-7d3d1cf57b16@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=10841;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=fWGxEoonf/oo9WtQdDfbe3IkEedzcHjEPcoyRgZE6vo=;
 b=d6TBcL83D0DGOMbaiuPmG9KQm9zbTGL/nlcXhPvGS8N85FMcfXNSX0Yifk+BwnNpIixnSwOiW
 jN2S8t65aSPAX2NcvK0K/viK3Ok9kW6ZS5/+OlQpiAoVhoMMXSc8fEC
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: iC4nBQpAJaDoMBr_pVca461SDQegzy7j
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69ddca2c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5whlBFqpPk_D0xcr0aUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: iC4nBQpAJaDoMBr_pVca461SDQegzy7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfXyiVwkGpVJI3E
 ye0sFcnopKmWYtV6n0CvWDHfUI5b+dVOMnMRzE8ArodbZcFsYwij2UTtBRsEJhXn1nzxdqVozeX
 6OjB1tXqiOuB46hIXnL9XvaGgeiv24EKdTLoBol85hirCqkOHi+3/a3cZfnexDvxtxlEFL7uWYB
 oUFWWJ8irDALBGPMIlT+F/SoiQAivy14lqV0CPhB9meRHEBqmUhw5iygf52NvcHdZaxfWCVyZos
 eSm5wVeNZ+OWz5raSWYXwPrUBU4GRAv7X1hyEsAtZoPp0+3aAlaKGefhl277BSN7YHp+9mxGapF
 TvZGxbClugsJ0PXR97O6M8XqW1fRy82Uv/WTyUnxUQ38aTQHzvCTaQDnKetld+LPJEEbesdAENr
 SwXWulUgPt2r60rKU0N2st0l/8TafH7zqHPd6gkwqATh48A9fMNsst3ASoZ437adPQGcGlRw6by
 ox6qbBLVOGCNqv3jePw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140045

Add glymur platform data by reusing most of the SM8550 definitions.
Move configuration that differs in a per-SoC platform specific data.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Makefile          |   1 +
 .../platform/qcom/iris/iris_platform_common.h      |   1 +
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 100 +++++++++++++++++++++
 .../platform/qcom/iris/iris_platform_glymur.c      |  93 +++++++++++++++++++
 .../platform/qcom/iris/iris_platform_glymur.h      |  17 ++++
 drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
 6 files changed, 216 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 6f4052b98491..677513c7c045 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -11,6 +11,7 @@ qcom-iris-objs += iris_buffer.o \
              iris_hfi_gen2_response.o \
              iris_hfi_queue.o \
              iris_platform_gen2.o \
+             iris_platform_glymur.o \
              iris_power.o \
              iris_probe.o \
              iris_resources.o \
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index aeb70f54be10..a279ea462ee6 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -41,6 +41,7 @@ enum pipe_type {
 	PIPE_4 = 4,
 };
 
+extern const struct iris_platform_data glymur_data;
 extern const struct iris_platform_data qcs8300_data;
 extern const struct iris_platform_data sc7280_data;
 extern const struct iris_platform_data sm8250_data;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 47c6b650f0b4..fa2115092be8 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -12,6 +12,7 @@
 #include "iris_vpu_buffer.h"
 #include "iris_vpu_common.h"
 
+#include "iris_platform_glymur.h"
 #include "iris_platform_qcs8300.h"
 #include "iris_platform_sm8650.h"
 #include "iris_platform_sm8750.h"
@@ -921,6 +922,105 @@ static const u32 sm8550_enc_op_int_buf_tbl[] = {
 	BUF_SCRATCH_2,
 };
 
+const struct iris_platform_data glymur_data = {
+	.get_instance = iris_hfi_gen2_get_instance,
+	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
+	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
+	.get_vpu_buffer_size = iris_vpu_buf_size,
+	.vpu_ops = &iris_vpu36_ops,
+	.set_preset_registers = iris_set_sm8550_preset_registers,
+	.init_cb_devs = glymur_init_cb_devs,
+	.deinit_cb_devs = glymur_deinit_cb_devs,
+	.icc_tbl = sm8550_icc_table,
+	.icc_tbl_size = ARRAY_SIZE(sm8550_icc_table),
+	.clk_rst_tbl = glymur_clk_reset_table,
+	.clk_rst_tbl_size = ARRAY_SIZE(glymur_clk_reset_table),
+	.bw_tbl_dec = sm8550_bw_table_dec,
+	.bw_tbl_dec_size = ARRAY_SIZE(sm8550_bw_table_dec),
+	.pmdomain_tbl = glymur_pmdomain_table,
+	.pmdomain_tbl_size = ARRAY_SIZE(glymur_pmdomain_table),
+	.opp_pd_tbl = sm8550_opp_pd_table,
+	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
+	.clk_tbl = glymur_clk_table,
+	.clk_tbl_size = ARRAY_SIZE(glymur_clk_table),
+	.opp_clk_tbl = glymur_opp_clk_table,
+	/* Upper bound of DMA address range */
+	.dma_mask = 0xffe00000 - 1,
+	.fwname = "qcom/vpu/vpu36_p4_s7.mbn",
+	.pas_id = IRIS_PAS_ID,
+	.dual_core = true,
+	.inst_iris_fmts = platform_fmts_sm8550_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8550_dec),
+	.inst_caps = &platform_inst_cap_sm8550,
+	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
+	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
+	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
+	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
+	.tz_cp_config_data = tz_cp_config_glymur,
+	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_glymur),
+	.core_arch = VIDEO_ARCH_LX,
+	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
+	.ubwc_config = &ubwc_config_sm8550,
+	.num_vpp_pipe = 4,
+	.max_session_count = 16,
+	.max_core_mbpf = NUM_MBS_8K * 2,
+	.max_core_mbps = ((8192 * 4320) / 256) * 60,
+	.dec_input_config_params_default =
+		sm8550_vdec_input_config_params_default,
+	.dec_input_config_params_default_size =
+		ARRAY_SIZE(sm8550_vdec_input_config_params_default),
+	.dec_input_config_params_hevc =
+		sm8550_vdec_input_config_param_hevc,
+	.dec_input_config_params_hevc_size =
+		ARRAY_SIZE(sm8550_vdec_input_config_param_hevc),
+	.dec_input_config_params_vp9 =
+		sm8550_vdec_input_config_param_vp9,
+	.dec_input_config_params_vp9_size =
+		ARRAY_SIZE(sm8550_vdec_input_config_param_vp9),
+	.dec_input_config_params_av1 =
+		sm8550_vdec_input_config_param_av1,
+	.dec_input_config_params_av1_size =
+		ARRAY_SIZE(sm8550_vdec_input_config_param_av1),
+	.dec_output_config_params =
+		sm8550_vdec_output_config_params,
+	.dec_output_config_params_size =
+		ARRAY_SIZE(sm8550_vdec_output_config_params),
+
+	.enc_input_config_params =
+		sm8550_venc_input_config_params,
+	.enc_input_config_params_size =
+		ARRAY_SIZE(sm8550_venc_input_config_params),
+	.enc_output_config_params =
+		sm8550_venc_output_config_params,
+	.enc_output_config_params_size =
+		ARRAY_SIZE(sm8550_venc_output_config_params),
+
+	.dec_input_prop = sm8550_vdec_subscribe_input_properties,
+	.dec_input_prop_size = ARRAY_SIZE(sm8550_vdec_subscribe_input_properties),
+	.dec_output_prop_avc = sm8550_vdec_subscribe_output_properties_avc,
+	.dec_output_prop_avc_size =
+		ARRAY_SIZE(sm8550_vdec_subscribe_output_properties_avc),
+	.dec_output_prop_hevc = sm8550_vdec_subscribe_output_properties_hevc,
+	.dec_output_prop_hevc_size =
+		ARRAY_SIZE(sm8550_vdec_subscribe_output_properties_hevc),
+	.dec_output_prop_vp9 = sm8550_vdec_subscribe_output_properties_vp9,
+	.dec_output_prop_vp9_size =
+		ARRAY_SIZE(sm8550_vdec_subscribe_output_properties_vp9),
+	.dec_output_prop_av1 = sm8550_vdec_subscribe_output_properties_av1,
+	.dec_output_prop_av1_size =
+		ARRAY_SIZE(sm8550_vdec_subscribe_output_properties_av1),
+
+	.dec_ip_int_buf_tbl = sm8550_dec_ip_int_buf_tbl,
+	.dec_ip_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_ip_int_buf_tbl),
+	.dec_op_int_buf_tbl = sm8550_dec_op_int_buf_tbl,
+	.dec_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_op_int_buf_tbl),
+
+	.enc_ip_int_buf_tbl = sm8550_enc_ip_int_buf_tbl,
+	.enc_ip_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_ip_int_buf_tbl),
+	.enc_op_int_buf_tbl = sm8550_enc_op_int_buf_tbl,
+	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
+};
+
 const struct iris_platform_data sm8550_data = {
 	.get_instance = iris_hfi_gen2_get_instance,
 	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_glymur.c b/drivers/media/platform/qcom/iris/iris_platform_glymur.c
new file mode 100644
index 000000000000..64b150db9f73
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_platform_glymur.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/media/qcom,glymur-iris.h>
+#include "iris_core.h"
+#include "iris_platform_common.h"
+#include "iris_platform_glymur.h"
+
+#define VIDEO_REGION_SECURE_FW_REGION_ID	0
+#define VIDEO_REGION_VM0_SECURE_NP_ID		1
+#define VIDEO_REGION_VM0_NONSECURE_NP_ID	5
+
+const struct platform_clk_data glymur_clk_table[] = {
+	{IRIS_AXI_VCODEC_CLK,		"iface"			},
+	{IRIS_CTRL_CLK,			"core"			},
+	{IRIS_VCODEC_CLK,		"vcodec0_core"		},
+	{IRIS_AXI_CTRL_CLK,		"iface_ctrl"		},
+	{IRIS_CTRL_FREERUN_CLK,		"core_freerun"		},
+	{IRIS_VCODEC_FREERUN_CLK,	"vcodec0_core_freerun"	},
+	{IRIS_AXI_VCODEC1_CLK,		"iface1"		},
+	{IRIS_VCODEC1_CLK,		"vcodec1_core"		},
+	{IRIS_VCODEC1_FREERUN_CLK,	"vcodec1_core_freerun"	},
+};
+
+const char * const glymur_clk_reset_table[] = {
+	"bus0",
+	"bus_ctrl",
+	"core",
+	"vcodec0_core",
+	"bus1",
+	"vcodec1_core",
+};
+
+const char * const glymur_opp_clk_table[] = {
+	"vcodec0_core",
+	"vcodec1_core",
+	"core",
+	NULL,
+};
+
+const char * const glymur_pmdomain_table[] = {
+	"venus",
+	"vcodec0",
+	"vcodec1",
+};
+
+const struct tz_cp_config tz_cp_config_glymur[] = {
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
+
+int glymur_init_cb_devs(struct iris_core *core)
+{
+	const u32 f_id = IRIS_FIRMWARE;
+	struct device *dev;
+
+	dev = iris_create_cb_dev(core, "iris_firmware", &f_id);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	if (device_iommu_mapped(dev))
+		core->dev_fw = dev;
+	else
+		device_unregister(dev);
+
+	return 0;
+}
+
+void glymur_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->dev_fw)
+		device_unregister(core->dev_fw);
+
+	core->dev_fw = NULL;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_platform_glymur.h b/drivers/media/platform/qcom/iris/iris_platform_glymur.h
new file mode 100644
index 000000000000..03c83922f0d9
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_platform_glymur.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __IRIS_PLATFORM_GLYMUR_H__
+#define __IRIS_PLATFORM_GLYMUR_H__
+
+extern const struct platform_clk_data glymur_clk_table[9];
+extern const char * const glymur_clk_reset_table[6];
+extern const char * const glymur_opp_clk_table[4];
+extern const char * const glymur_pmdomain_table[3];
+extern const struct tz_cp_config tz_cp_config_glymur[3];
+int glymur_init_cb_devs(struct iris_core *core);
+void glymur_deinit_cb_devs(struct iris_core *core);
+
+#endif
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 34751912f871..53869d9113d5 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -369,6 +369,10 @@ static const struct dev_pm_ops iris_pm_ops = {
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

