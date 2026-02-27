Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E39410D3C
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201558; cv=none; b=gC72by/RZbnGuFRtCgFeuALdcRyOGlbCjHZpUrPQC6YEdrCo/uUFJl81fatzmP+YJRWTanV3zsPVe4Wazt0lTwml3LHWevbbtpnFLK0CXerT2gvhCBeXlAXxyBP+IhN6N+USP8RRanNnUJ9+WGL+tcOyr8WoRzAd/78vn97HJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201558; c=relaxed/simple;
	bh=S6hB6rVRgVI0Hmj5dE9jI+O0jSAIl9D9Qnmi+HTINNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXdMJTBoc6jKS9KKpJn/piOZH/CUIeIULqJazdjSAbCjS/ScpdMbr74Ba/Oda8sf/Nb4J79LsjwUzAtCh32M7WHeGPXkPHHa33fTqX8BJJU8m/s5QXh6yCZ4dy+OPZJ2rjpoNa8Gv5jgkfKz7WhSgwyhtC49rh10K8jQYRQs8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8WBAZNT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZvOeX9XL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8WBAZNT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZvOeX9XL"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9xFSK2403001
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yr5UXY2i70vz4eTQdEwJVsd2YfiJn6quXaEjXK0SlkQ=; b=f8WBAZNTECxM0GqK
	yEixhEXxJ1bqafRC2YJGIlzFM86ajVOf7NssXBFWB3jnaxPiL1t1a49gIC1KIq8t
	27TRxFGRI13VGBoC/Zxs3lZCms9YvBjkFoEn3PvykaATpItyF6slO3USgiOuv8Xs
	DYaBlKDerWSU1XYzNnTe7IRAz0jzzpLHnf06kf8vDIHFODGBrVmpl0M77aoSDIcx
	kxy/5TNQVyxV2nnLNx0iwrDHKObFp4UZRuUvrFo5i7yIYzs0APF/5QSSdXBDzPaY
	1FW0pueetAnB6zfjNF/qBaNmKoQ0ZxMGTGxv2wzi8wrJ4ovEvySLEFbhp2lSY07F
	uFcZ+Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23b1sv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ad7e454f38so122813465ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 06:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201555; x=1772806355; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yr5UXY2i70vz4eTQdEwJVsd2YfiJn6quXaEjXK0SlkQ=;
        b=ZvOeX9XLZA1FC3gwvuQbCPg7nZBw8DEVs4h6siEqP483f+9pVZZt7TDGIenAFmXRR6
         7xoR+F39klRPRewp0PFBJ0SXXoZXaDjZi4lnCuKdKj4qeyVKqVeuXi38sIbkFIRaW6dr
         AWsMSiiBp65truyRSS6A/q6mg1mdAMMOMgG3ZuiveYTcHLaceK2ZH5Caddwzz1S3J2Gk
         XkeJ1/RWZQRFjRChD7zJOhecomIuWUHoocThEqwVMjTkNglW8fTiXOlzUz6VmZG3XxDy
         hvSHVg/WzSO697Z7LMy0Cn55LvZvAKiaVv1VKGIz4A/saB0RWcNJJPMcT2lWR3DMsgv0
         19mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201555; x=1772806355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yr5UXY2i70vz4eTQdEwJVsd2YfiJn6quXaEjXK0SlkQ=;
        b=MzxWSxTL/VaHIsxg9qyBoybpHhDuXwXvoXHmwHZE7B8QlbNjLL3x4/oLZbruX6U3m5
         dFXaTW3uCWluLId1EqVgd3z6O8zbTSietMrY4q6MZXg2/Aek+uW8xk/vc57XTyHFkBrl
         lokwzwE5W0NeYzq9gGCpVzpP6rGynVOfMuOArINv6VqsYqtMki9+qrJROMKVMBpFmdY+
         NZ6mBK8XUIApyyD+usDNEq5eck0JSIckv/vcMsdW76M/27S0LRovU0KhpRzwBCuRRhBQ
         iOKUvP+yIxtGiuOPAEevz2mkw1sx1O/l0Lvp1Hr3+lR/HO4gD6KyU4cQgSYpyn5C3Kz2
         O4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW9sduNOIBbIsZTijLX/nMFmbfY8qPI/oePpus+kDxrTJi+DZrw5JHUOLE29cd9Fo59Yx9jkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSQeVhF1NUyTytXgtGXBuRCRlQfXvCCvH25+rDEbkYy9OHY/9w
	CxuC4LwoZTIr7V5ApHOKGuXXvVZzJf1ZA87a98uvjQyyQYB9iY8B3GQ36YmWHT6CxdfQtO4/jED
	QtNaxWaUBh0eu2KNVzsop2+eJSRvoyYQ8pF7gQOYZ3eIDpe42f/wAdCMt1A==
X-Gm-Gg: ATEYQzzFcbja04AJTj6ZMOmMDzAqQnPp/SmXqay8UnKulBUpBJC+D/3ktyZhzownpDC
	2Vbk17hDuxbMFF5LzYHyFVXNqTPdPPR3k8vUn9F1V3VRELU4YEmKJOCHelbKw/8NFmFTW7xkllc
	FKUQRkHjzO0B7Aaw0MupXQB9JFKWKSoc/Juw82nRM6iWtvgZ8/rOQkpraNNdzxKmZEC/W6RRyOM
	jWaYS/YsRVuRZCTAqAMOfeyihGbNCa8k9KunTjbYG2PpaQeaLP1az0U/SiFL8zBXVfoyL14SkWU
	sJHg8+/rVkkM2lqt/Dg7+5U4RbcZiSGbHn+1IwXvDGuqa9H8oLCU8yBGhH/xtE8YJgsJzPwbN44
	o5LmBlnPsqC4gLH/DeFaD2jvlNWgK29dcFZLcy0hBMvb2bcJ/IGSnaazY
X-Received: by 2002:a17:902:d4cb:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2ae2e3cca53mr37300365ad.3.1772201554888;
        Fri, 27 Feb 2026 06:12:34 -0800 (PST)
X-Received: by 2002:a17:902:d4cb:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2ae2e3cca53mr37300015ad.3.1772201554106;
        Fri, 27 Feb 2026 06:12:34 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm60960865ad.24.2026.02.27.06.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:12:32 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 19:41:23 +0530
Subject: [PATCH v2 7/7] media: iris: add platform data for kaanapali
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-kaanapali-iris-v2-7-850043ac3933@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772201499; l=9099;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=S6hB6rVRgVI0Hmj5dE9jI+O0jSAIl9D9Qnmi+HTINNI=;
 b=UJm/S/GxMA5WY37JL/qfcLy9B8/KY9WiGWOPoQBjvx9w3asSb/JHF7dt4aZCZATRZ2Y4CGDXr
 dxOvlnMpzTfACVHwtZ5zQLCAUzVijLtGmzaUuss6McbTpJeFRdEU+rX
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: AL7L75w8zaOhSa4V6eAx8Kz-fByiOnMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX+C9YF6ZgJxlt
 HmfQBvrpolJu6hlaMG+9SR4jOBlbvqIamGvPs7z9SMCX5q0iZIlIqzVpM08pTL7SjfDFmQ4U/1u
 qOnQNH8Bk06JL+J/KNNjAWZ5vssRf8L3YwW7twjcIsvqLubRVGaL1ERsjT0221cPjU9fXqlpWnV
 4XIXZqCHrBkIPN9UcdtVjxrhuykKujJCoZFttfhwoOoRjXyPP5aWCv12fHxLz+fIwZFH3+F6b55
 dEZXdx/n1fI1fJ3+bjLeuP7lfo0/MI4f6nybZ80+0ojodFg7aAPmTg3CEgFfcRGNr4ihUAgXi5x
 A+K/3a/VgZCKVH8i0T0P1xpGpRrsRrTvYGs6DbDKd1L5x2m/NYX/Um6f8FBsMXlmKvGhK1MRibM
 XrR2tn8EICfjS4W1E+ddKwOwkCvBzsPY8Ak0Kkr2KJyNFjfSrMUle49DzPG9YAQ0nPb4X+WnKUn
 vaZnqWEsCfiIpjgto0w==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1a654 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=oUDkSdWbjXKg0EQNC7QA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: AL7L75w8zaOhSa4V6eAx8Kz-fByiOnMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125

Add support for the kaanapali platform by re-using the SM8550
definitions and using the vpu4 ops.
Move the configurations that differs in a per-SoC platform header, that
will contain SoC specific data.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |  1 +
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 90 ++++++++++++++++++++++
 .../platform/qcom/iris/iris_platform_kaanapali.h   | 86 +++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
 4 files changed, 181 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 03c50d6e54853fca34d7d32f65d09eb80945fcdd..34c8ae7f9f957936b6219d8557ff3d86d309cb2a 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -41,6 +41,7 @@ enum pipe_type {
 	PIPE_4 = 4,
 };
 
+extern const struct iris_platform_data kaanapali_data;
 extern const struct iris_platform_data qcs8300_data;
 extern const struct iris_platform_data sc7280_data;
 extern const struct iris_platform_data sm8250_data;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 5da90d47f9c6eab4a7e6b17841fdc0e599397bf7..df906f6b9fcd80100872a12815036a3aad9e925b 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -12,6 +12,7 @@
 #include "iris_vpu_buffer.h"
 #include "iris_vpu_common.h"
 
+#include "iris_platform_kaanapali.h"
 #include "iris_platform_qcs8300.h"
 #include "iris_platform_sm8650.h"
 #include "iris_platform_sm8750.h"
@@ -921,6 +922,95 @@ static const u32 sm8550_enc_op_int_buf_tbl[] = {
 	BUF_SCRATCH_2,
 };
 
+const struct iris_platform_data kaanapali_data = {
+	.get_instance = iris_hfi_gen2_get_instance,
+	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
+	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
+	.get_vpu_buffer_size = iris_vpu4x_buf_size,
+	.vpu_ops = &iris_vpu4x_ops,
+	.set_preset_registers = iris_set_sm8550_preset_registers,
+	.icc_tbl = sm8550_icc_table,
+	.icc_tbl_size = ARRAY_SIZE(sm8550_icc_table),
+	.clk_rst_tbl = kaanapali_clk_reset_table,
+	.clk_rst_tbl_size = ARRAY_SIZE(kaanapali_clk_reset_table),
+	.bw_tbl_dec = sm8550_bw_table_dec,
+	.bw_tbl_dec_size = ARRAY_SIZE(sm8550_bw_table_dec),
+	.pmdomain_tbl = kaanapali_pmdomain_table,
+	.pmdomain_tbl_size = ARRAY_SIZE(kaanapali_pmdomain_table),
+	.opp_pd_tbl = sm8550_opp_pd_table,
+	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
+	.clk_tbl = kaanapali_clk_table,
+	.clk_tbl_size = ARRAY_SIZE(kaanapali_clk_table),
+	.opp_clk_tbl = kaanapali_opp_clk_table,
+	/* Upper bound of DMA address range */
+	.dma_mask = 0xffc00000 - 1,
+	.fwname = "qcom/vpu/vpu40_p2_s7.mbn",
+	.pas_id = IRIS_PAS_ID,
+	.inst_iris_fmts = platform_fmts_sm8550_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8550_dec),
+	.inst_caps = &platform_inst_cap_sm8550,
+	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
+	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
+	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
+	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
+	.tz_cp_config_data = tz_cp_config_kaanapali,
+	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_kaanapali),
+	.cb_data = kaanapali_cb_data,
+	.cb_data_size = ARRAY_SIZE(kaanapali_cb_data),
+	.core_arch = VIDEO_ARCH_LX,
+	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
+	.ubwc_config = &ubwc_config_sm8550,
+	.num_vpp_pipe = 2,
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
+
+	.dec_ip_int_buf_tbl = sm8550_dec_ip_int_buf_tbl,
+	.dec_ip_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_ip_int_buf_tbl),
+	.dec_op_int_buf_tbl = sm8550_dec_op_int_buf_tbl,
+	.dec_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_op_int_buf_tbl),
+
+	.enc_op_int_buf_tbl = sm8550_enc_op_int_buf_tbl,
+	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
+};
+
 const struct iris_platform_data sm8550_data = {
 	.get_instance = iris_hfi_gen2_get_instance,
 	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
new file mode 100644
index 0000000000000000000000000000000000000000..ecfebc898e727ccadd2ea5d7d2d43fcba476b779
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __IRIS_PLATFORM_KAANAPALI_H__
+#define __IRIS_PLATFORM_KAANAPALI_H__
+
+#include <dt-bindings/media/qcom,iris.h>
+
+#define VIDEO_REGION_VM0_SECURE_NP_ID		1
+#define VIDEO_REGION_VM0_NONSECURE_NP_ID	5
+
+static const char *const kaanapali_clk_reset_table[] = {
+	"bus0",
+	"bus1",
+	"core",
+	"vcodec0_core",
+};
+
+static const char *const kaanapali_pmdomain_table[] = {
+	"venus",
+	"vcodec0",
+	"vpp0",
+	"vpp1",
+	"apv",
+};
+
+static const struct platform_clk_data kaanapali_clk_table[] = {
+	{ IRIS_AXI_CLK, "iface" },
+	{ IRIS_CTRL_CLK, "core" },
+	{ IRIS_HW_CLK, "vcodec0_core" },
+	{ IRIS_AXI1_CLK, "iface1" },
+	{ IRIS_CTRL_FREERUN_CLK, "core_freerun" },
+	{ IRIS_HW_FREERUN_CLK, "vcodec0_core_freerun" },
+	{ IRIS_BSE_HW_CLK, "vcodec_bse" },
+	{ IRIS_VPP0_HW_CLK, "vcodec_vpp0" },
+	{ IRIS_VPP1_HW_CLK, "vcodec_vpp1" },
+	{ IRIS_APV_HW_CLK, "vcodec_apv" },
+};
+
+static const char *const kaanapali_opp_clk_table[] = {
+	"vcodec0_core",
+	"vcodec_apv",
+	"vcodec_bse",
+	"core",
+	NULL,
+};
+
+static struct tz_cp_config tz_cp_config_kaanapali[] = {
+	{
+		.cp_start = VIDEO_REGION_VM0_SECURE_NP_ID,
+		.cp_size = 0,
+		.cp_nonpixel_start = 0x01000000,
+		.cp_nonpixel_size = 0x24800000,
+	},
+	{
+		.cp_start = VIDEO_REGION_VM0_NONSECURE_NP_ID,
+		.cp_size = 0,
+		.cp_nonpixel_start = 0x25800000,
+		.cp_nonpixel_size = 0xda400000,
+	},
+};
+
+static struct iris_context_bank kaanapali_cb_data[] = {
+	{
+		.dev = NULL,
+		.name = "iris_bitstream",
+		.f_id = IRIS_BITSTREAM,
+		.region = IRIS_BITSTREAM_REGION,
+	},
+	{
+		.dev = NULL,
+		.name = "iris_non_pixel",
+		.f_id = IRIS_NON_PIXEL,
+		.region = IRIS_NON_PIXEL_REGION,
+	},
+	{
+		.dev = NULL,
+		.name = "iris_pixel",
+		.f_id = IRIS_PIXEL,
+		.region = IRIS_PIXEL_REGION,
+	},
+};
+
+#endif /* __IRIS_PLATFORM_KAANAPALI_H__ */
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 557adb038328a75510591d91569819abc0b7b1c9..e30b159b42c75b288ef02624480cd733f9cf6f50 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -400,6 +400,10 @@ static const struct dev_pm_ops iris_pm_ops = {
 };
 
 static const struct of_device_id iris_dt_match[] = {
+	{
+		.compatible = "qcom,kaanapali-iris",
+		.data = &kaanapali_data,
+	},
 	{
 		.compatible = "qcom,qcs8300-iris",
 		.data = &qcs8300_data,

-- 
2.34.1

