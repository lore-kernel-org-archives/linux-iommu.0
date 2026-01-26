Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9054337BB4
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430434; cv=none; b=YKHQGoxSlZBPlhojsLxAdBUztKvSP2f3PJefhzqX8hhk19iRJKobTYavgvVB8qjjaNgEmP3ZzWgPWngypXjpnI9eEx7UFbyNfG48xVb2Bhaf3WGomDURPHZ3aPTNt5VAK+3VKtDQneHQJMGy9mH8f+QRJkJHlzaSttfs0rOsfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430434; c=relaxed/simple;
	bh=QymC8z3UUtOylpthd2ikOcBCZz2Wy95X6t+kiN2oOTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQZdIVM0xo7EUrPKirxMJHERNXgviqnAqKm5NJcjdciZvn365OdeeYnJxjjDXUOLJHp3lkkXT10gBzd4cD+tBfBYBUZjlbMWxGoQ9DrKMf7E46I99GITQaH+s7/sWGp8cyENC3OQxXR9DDaowuAO5s5POK4T3TLE2BojrfboEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mIeZswn1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OD9rOscc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mIeZswn1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OD9rOscc"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q924X5432792
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o7L0eNHSIsEFa+dYyA9xV66YYL732g8MYKYkvB2DFeM=; b=mIeZswn1kADUvkGU
	pV470Ndb/loStmqFymW1UCTI6c6FtqVKfGlGs6y2JsdkUK3YKiw7YPyp9CPDQXAY
	omI8VdEXIr2Dj6ZBcW8koxwleePzWMc+JHvJJ/I2Cdnwbrnsn7valWmANNfncU3g
	2marsg3pyrpJN6Kai9cP7CJOXKTiyT4cLPOvrLYNshGXSMi6urEWVRD/zKjnS1yU
	JBdhL7u95Lb9BH5Hxe2l717oCmm+2KZvKNlwClnZBy2A+BKeZb6+FKMXTpQsdbYi
	uutZJ9PDLGY5A+2vmUrk8abdG2ypZ1nqYkrELG/hl4vcg4dMCATc+nk5GAri/3e1
	CbTcjg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9tves0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:27:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-823486f311bso465585b3a.0
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 04:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769430431; x=1770035231; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7L0eNHSIsEFa+dYyA9xV66YYL732g8MYKYkvB2DFeM=;
        b=OD9rOsccUQPsHYV5aSymrL2QvXQyOknpTmxcp/ndhMJ0ShD6jKwEekqtxUq2JPRHD+
         UokvynLRpc/Za6PoeZIY9FK7irhGg3hJU+oSTeQ4zuGm9UKjfu/OHQZPHMXqtdsAzq3D
         Tsx3oBaGNmXaDyqHc8t7K0xOAd2XTLXv5zKAfv9okJq7JOK/qlkXC/t1sqLXYVMQNyWr
         VgaiSte/xuZ+kaubc70NYcILldTkwyBGga9XnY+I0Ovq2viKon4z6OCU6y0zn62xotwJ
         wQU/SDg8U2fM3r6oDQpR1sodai97b2HpxGXteMB0fwcqLbwMuS6oxtDMK/cJ+C1tQM33
         iEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430431; x=1770035231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o7L0eNHSIsEFa+dYyA9xV66YYL732g8MYKYkvB2DFeM=;
        b=WObTPUovry07MbbSq9QVEWHKvhEh29d+v3tp61kBxedRqXRoUnTJ7KRtf4gfp7/d5k
         06udr4vfK6LBm13zkPqHrEnwTfdDAyV0Xay0j+n1rMGF0RVfLFy6z7NA/OWAE5sCA1PO
         edtFIsWJ03KuQWm+NnKpXRyXmGl9Q33oioY8qQHPlcOzC+p41F2j7KkW8uXatq14pOgA
         tcI5AAUFjKXY9WZds48tc2kBzdLsKMhqLETkDBx3UaX2sJDh9yIsB2BOme2/uIEtvqfA
         2A8scZOUjJ3EVV+IjiZPJGGkFHx5uuABK9pKj8KIIriUF36AR3X3omuQBoojQOgUsFIz
         1qfw==
X-Forwarded-Encrypted: i=1; AJvYcCVDpp9eziH72403wcBgaPo182/XQtiBGAK+Y1lHsWtHsWuALYxml98O6k2mRN4BJxWNQ73wJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuIL3aViTJaJ227M2pMhkD/UHeXPkhUYTyGDRxUFBXwvv7LKO0
	ilInmCI1QwAP2T0orrtgmNEo1vu7avczoxmR3S0sqI9Blp7Vd3AYdLmULpr6ntpqZw/gS+szwRj
	aSDjP364LA9zRMgAMQP/q+aU+PQ4o4VgMu8xu1+pU0D6U2rRuzBvAEJFzkA==
X-Gm-Gg: AZuq6aKz3oOLrdSRydm/mLFLET6VaC1ke+yuLIPKt4k3p6u0wK8p1+Yj8UPvACu4TJY
	h3gizmUyGLvL+Hjpoj3R7ewLm6BWoVlHaccm62qc6TQ3eBeoAnnGbtdyUW1WT2CCN2OsrtzGJoL
	cJcQFPq3wLNmiEh3P0hGcU0rRyP61+vijENSH8xN2PBoLcoEWRWxd+8QCD+OR1yaOqM7dGqLf4p
	x8MfpQbDJ+z4IEULNBUTWUZwDZIrSoFO8nU0CNeKFwMxaUXBFhOoO0bsbgXnF3TqHN+BGFnNus9
	RR46Cf/qqiPxYYB4494Nas8ckM77AqCDhMK42IyGboyqNkqaMhKK/ZTO5Q/kAWAB5O73QdZWtC0
	UgJC4yPHE2C0Cr6UD0sOLL9MB148on60mvN9iRs/4dkec
X-Received: by 2002:a05:6a00:1d95:b0:823:1511:530e with SMTP id d2e1a72fcca58-8234120bbbemr3307965b3a.25.1769430430652;
        Mon, 26 Jan 2026 04:27:10 -0800 (PST)
X-Received: by 2002:a05:6a00:1d95:b0:823:1511:530e with SMTP id d2e1a72fcca58-8234120bbbemr3307939b3a.25.1769430430136;
        Mon, 26 Jan 2026 04:27:10 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6366644379sm6076022a12.33.2026.01.26.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 04:27:09 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 17:55:50 +0530
Subject: [PATCH 7/7] media: iris: Add platform data for kaanapali
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-kaanapali-iris-v1-7-e2646246bfc1@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
In-Reply-To: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769430381; l=9062;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=QymC8z3UUtOylpthd2ikOcBCZz2Wy95X6t+kiN2oOTc=;
 b=P+2J2X/fydNpWqThBOpgshiwuYul6LgcRPJUt8+h87BsIb8AnLoHYLPSaDMFSF/T5TOCJ6KEx
 QqqnIMP8cldAuSRFNX8gA73XqhHILw6LtdENiP3RUcYE4AKSEeJP7x5
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNSBTYWx0ZWRfXyvYy7459CH7J
 GF+zqgT+GElewyAW5EZ+brWJjmtjB5sgnMoznENbnBwjZ/RwAZ8WHUMtbAF037ZToaS0J2VnuLK
 4pjCCvhOS+/NBnyms1O8DKDC1NtaA4F69YQ+URKnpfVIfsKqavzW7muNZ/NAQ/d/dxdzw2CX/FS
 /2U0uC1SNqgnaIVG23vlIt+/Rl1RghVEfs4mnZxEaoCLGrPDvY9ly4x9Nk7cgONhimXr4obpQUC
 9vzQE5PmADFvhyxwaAt+j1YPFU65E0CVrGs/NkVH1p7i4wJhwmZa0isSqiFqb8RdUGVyfisMrEB
 jDj+4dRhGWxh60cbYZVjszE0u/I1ptYh/LBhdQRXi+9Vsr+rbBr50pnxX4ahbXiwCOlYDocrNmR
 r2725s+SxtAZIvFW5dPPC+cl0CHgAY6nRLe7h56ux7fQsE+FnMguKIP6h6cmnxI5Nwn0a9R23Ui
 4KtkNd9KFlR8AtAImZQ==
X-Authority-Analysis: v=2.4 cv=QN5lhwLL c=1 sm=1 tr=0 ts=69775d9f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=oUDkSdWbjXKg0EQNC7QA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: PEza0YVQY3QXMmWsCIFAWoRe8HUG29-I
X-Proofpoint-ORIG-GUID: PEza0YVQY3QXMmWsCIFAWoRe8HUG29-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260105

Add support for the kaanapali platform by re-using the SM8550
definitions and using the vpu4 ops.
Move the configurations that differs in a per-SoC platform
header, that will contain SoC specific data.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |  1 +
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 90 ++++++++++++++++++++++
 .../platform/qcom/iris/iris_platform_kaanapali.h   | 80 +++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
 4 files changed, 175 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index d2d7c898fc8ef0de1b16aebd72681ea3c5b736ae..3f047bd495413494b9afbf6f4d12a8e06a9ac07a 100644
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
index 5da90d47f9c6eab4a7e6b17841fdc0e599397bf7..cefbe72b1475cb83281d01ef3828f095293e098f 100644
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
+	.dma_mask = 0xffe00000 - 1,
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
+	.max_core_mbps = ((8192 * 4352) / 256) * 60,
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
index 0000000000000000000000000000000000000000..d472e21fdac4c764169a3a8c35d175db29b06b5b
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __IRIS_PLATFORM_KAANAPALI_H__
+#define __IRIS_PLATFORM_KAANAPALI_H__
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
+		.name = "iris_cb_non_pixel",
+		.f_id = IRIS_CB_NON_SECURE_NON_PIXEL,
+		.region = IRIS_NON_SECURE_NON_PIXEL | IRIS_NON_SECURE_BITSTREAM,
+		.dma_mask = 0xffe00000 - 1,
+	},
+	{
+		.dev = NULL,
+		.name = "iris_cb_pixel",
+		.f_id = IRIS_CB_NON_SECURE_PIXEL,
+		.region = IRIS_NON_SECURE_PIXEL,
+		.dma_mask = 0xffe00000 - 1,
+	},
+};
+
+#endif /* __IRIS_PLATFORM_KAANAPALI_H__ */
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index c1a6aac5a3d65d980c5a34ba5fa1c1dbcf790ec5..9cc55f5e7be1701a14eedd06453ddb0b59844ffa 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -395,6 +395,10 @@ static const struct dev_pm_ops iris_pm_ops = {
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

