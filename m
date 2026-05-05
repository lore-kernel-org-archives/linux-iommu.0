Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34A3D16E9
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964515; cv=none; b=jC2wn/HEz1r9BnJtIPT6n5Yd6lXDxzYIsmPaYXqdMrhVRBHmIdykBxYP7zbIRY2o8rQJBrzyDOESB4fdhZYL19cHh3mJ2jR/M2+mzQmLsGUnFGivTW7L98m6dJmGRDiw+W/C2ZmZprmFl50hyuC+HQ/Cgt97TJY1jUQhAu9EPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964515; c=relaxed/simple;
	bh=GxPcM3D6fcOBB3Z1Td+dY6rhZmNKqLALfdcwQqF+Y6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ts1osKuCGflnCxKCXzL3FkXTYfTPFWMLPygy0DZ+UiExVgY4+9sCWSRzwlWCcLvEO0LFfqvGvSD357/bo8UvheRiLwWSv8hyKv+lZ0nTyfs4b7C9NkrBUCU93UKoE32NhC6CTX+XV/JI2XvcYqngGnPiiJZXqAA0LFoOyHsAM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c6EjMZj1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwurqMIx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c6EjMZj1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwurqMIx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64570Clj331106
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ncTxOLmgEHRNxr9Ra/M7hKec3vLSGGKsocfqCJZ4FKQ=; b=c6EjMZj11urnTpN+
	gJnvzh5d2UxNaM+w0CpimIzwFMWIJelcW5WfAtOCRCnqcAwTM+DZ4mMIsgoueTFh
	jOYkoP11Chbvc/yOo71diE9FaLR87vwvGEFRNEMIpKerAi8B8N4z3qtsk0Mk4kgR
	Ua7hRnalaqxzTCHZSGut1FyVyEawrBZ8GV+TQZX+DMAp0gmPRjXEms6wHr5Y0qXY
	FBUTeFoXaopJx/vlBWu4SKJAt4YIBdi6wuKvk1JTI+SZLD1usn3AdgzU2TjoaD+Y
	I7rlDKcxrLqcPqvkzE24e82NJclVZLHx48YL9+2NDB5uflrjuXuQhzYfEI5hStd0
	XayzwQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr1b8c2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:01:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35842aa350fso9355289a91.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964513; x=1778569313; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncTxOLmgEHRNxr9Ra/M7hKec3vLSGGKsocfqCJZ4FKQ=;
        b=iwurqMIxD1FRhnFhfPFAfZCmXVRqcMHuP5+DVQOsds5VD5SFtf81TmTjmuhx3OdImA
         4J3GG4KnD59JTUV3IYnp+rDQCaB2kncF7cO1GQsm10LaDcbeQMWDwdM27Wh5fLeDwlnt
         BrJriyAOh3BO8tPr8+L221qMkeAHcFyf/QkZYK8f8GWpH67GvCHHqW+3cA4IZwRn+TNY
         VZeDVMeU7praLWn2W4sJ/gk9wrIZAdqOCTszRmkmImFpz9Uw5JkvrAuGbNcBEGugC99f
         SbKz577ZZ/LquiC00TMwvSG9S73FXs9dfztKqbrZMw6aWoA3vO/tJ3ip0Tf9gJG+ZjId
         ZAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964513; x=1778569313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ncTxOLmgEHRNxr9Ra/M7hKec3vLSGGKsocfqCJZ4FKQ=;
        b=P2Gf/K+5/MzxubSa072zY+gz2NEXQvvUxwbgPI2impFfFy7g0G1LFsdR+eVhGgxgIn
         wHyY+2ykm4Y+DRL5sTx06rHeWNkCTeAoD0TrD7HbyJUXNKDzZk6gSm6S5T1mq28e96en
         DGtjBk57u6AINON5hPi+n8wyEPqbnSHmdrAGcH904yHCfis5ahzcKRfbjS+1G5fcw5Im
         pjn0eOl2tTiYkGILq2YmkSjrFSXulGPE1NoBqGIhogWq33VSJgyNB5uQggqAWgfpG+XE
         Jw2SdGIOw8RRquQPvk1asVDdbBvET7QLCLQZej9x57J7nPU5fXe+aQmieCq+IVTL/+wa
         /LKQ==
X-Forwarded-Encrypted: i=1; AFNElJ95h6rVFu/08Fgqwma3O/vIzFyr4TpOQPCeLbJzV6s5xptrdIT3rQ/FQGtP2W2mHb5/EuG84w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0FnWukCBYeTH/oioX4/SkS4PHs1WW9BSU8aMGWURQXCTUbs5b
	2ec2FbFXo+z58/4XuW4zlQc5MXtLLznM+khwBa8moPUeL9Zvtrt00NgO00gqpqpCdsXAprbserV
	BJSM7x163o5hc8ReVlHf3+x+zTNhz4V+5YB/AfN32MlyqRMY2HGivuPUm+w==
X-Gm-Gg: AeBDiesjglfUzL2sMOpXbhVzj73Ity4B4kZnIrLMNvHlzGYTkNQ4w4dYoBSd3KBPOjX
	dlZnabwipIn8bFWhgbrEuJZiUcyvmwrfWTwdALIuYVvL06ExY05xUK2rsiAz9GZ20mqnbbH+ANL
	6vS+bbpdR5NFXosl2+PENLC623nWt/6SVcuSq78/hSMF+YgVhEk5zUHdfg7uWmsdgE1kLs81aNs
	ogTo5/QHBUDwLR/cAI+MXVB68Dnq1JZQpICmqhxvyktdD6j0NaRUYZIE7deVBAeu14lwuEkAwxM
	MUuccICEstUwEc6WVLHDEh/jMtRxQKjuehs/u/HnHZH9oS4O7h+TeDG9pE7ABMeXc1faCMcBcRW
	wwlcH4VSzDU1lYtyII5+0tCMN8cKkeByKRKbwhwprkEiItZXaP4KaPXfFkOC2AYPmWw==
X-Received: by 2002:a17:90b:2b45:b0:35b:e56e:a17e with SMTP id 98e67ed59e1d1-3650ce86ae0mr11909000a91.17.1777964512615;
        Tue, 05 May 2026 00:01:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2b45:b0:35b:e56e:a17e with SMTP id 98e67ed59e1d1-3650ce86ae0mr11908963a91.17.1777964511948;
        Tue, 05 May 2026 00:01:51 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:01:51 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:33 +0530
Subject: [PATCH v4 12/13] media: iris: Add platform data for glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-12-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=11567;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=GxPcM3D6fcOBB3Z1Td+dY6rhZmNKqLALfdcwQqF+Y6E=;
 b=sYEFADXJ7Ibvb5q5Xm2hTg1/U1oQRmhbQ7H2gHMCgVPZpuLdY0qLkWNXAsq8uIS6emBHiKYPE
 iP2Sh4eSzkTCzocNNaGoBJuXYrDWmQv0ujcgyUdSboblzJmk9wy6LWa
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: 0ElfOAdj6x9N9Nw5FsTj5dva45MQUC2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MyBTYWx0ZWRfXzlIgc8bz9Dao
 q9EsRQNwJWJbesAa8BASuQmxHJMYpgjnz/EEBs0ruQzA4VTUhlZ7DECxuK2vSEUB33yXL9snUkx
 GPAn4hey0EoDvmyRU3+hcBynAeyVOGbD4Fst3Llw80gay9XJLDLJN5gixa/9Vc+h9vv1uLO9Z20
 iBgQU1/fomJVYq+ZfcyrPoSudg8w9i2vfNudCMa3CFi/F7CKaQG+Br35avhBqJR0Q2OQbWK/RBs
 4iDLTKPwoIKKrLTcQkskt/C3B3UU6/3daABiEbp0+bsfcQqFwJGobWSQhNE+Ffy4qpKB+ay6x11
 jHR106BAn3Cz7tK/PYqOdQoKg5lsa4U/dp9OOAYjn2P55HjWveiZhdGJYXcfJQu7RCGApAyTlje
 ncYhGhls7r6vvqr1BWLoTo15WRY+LpkkBtMpvGag6y7pZJ0Z10ajxD0hW2Dq7xZf2OrHK67Ayca
 45XZuGIiI4pnwc6EgEA==
X-Proofpoint-GUID: 0ElfOAdj6x9N9Nw5FsTj5dva45MQUC2r
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f995e1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=syK4oCsQgbaUnHKzOKsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050063

On glymur platform, the iris core shares most properties with the
iris core on the SM8550 platform. The major difference is that glymur
integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
one. Add glymur specific platform data, reusing SM8550 definitions
wherever applicable.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Makefile          |  1 +
 .../platform/qcom/iris/iris_platform_common.h      |  5 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 99 ++++++++++++++++++++++
 .../platform/qcom/iris/iris_platform_glymur.c      | 97 +++++++++++++++++++++
 .../platform/qcom/iris/iris_platform_glymur.h      | 17 ++++
 drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
 6 files changed, 223 insertions(+)

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
index 502d7099085c..2003b7186480 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -30,6 +30,10 @@ struct iris_inst;
 #define DEFAULT_QP				20
 #define BITRATE_DEFAULT			20000000
 
+#define VIDEO_REGION_SECURE_FW_REGION_ID	0
+#define VIDEO_REGION_VM0_SECURE_NP_ID		1
+#define VIDEO_REGION_VM0_NONSECURE_NP_ID	5
+
 enum stage_type {
 	STAGE_1 = 1,
 	STAGE_2 = 2,
@@ -41,6 +45,7 @@ enum pipe_type {
 	PIPE_4 = 4,
 };
 
+extern const struct iris_platform_data glymur_data;
 extern const struct iris_platform_data qcs8300_data;
 extern const struct iris_platform_data sc7280_data;
 extern const struct iris_platform_data sm8250_data;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 5862c89a4971..d11c9d1ce6b1 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -12,6 +12,7 @@
 #include "iris_vpu_buffer.h"
 #include "iris_vpu_common.h"
 
+#include "iris_platform_glymur.h"
 #include "iris_platform_qcs8300.h"
 #include "iris_platform_sm8650.h"
 #include "iris_platform_sm8750.h"
@@ -931,6 +932,104 @@ static const u32 sm8550_enc_op_int_buf_tbl[] = {
 	BUF_SCRATCH_2,
 };
 
+const struct iris_platform_data glymur_data = {
+	.get_instance = iris_hfi_gen2_get_instance,
+	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
+	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
+	.get_vpu_buffer_size = iris_vpu_buf_size,
+	.vpu_ops = &iris_vpu36_ops,
+	.set_preset_registers = iris_set_sm8550_preset_registers,
+	.init_cb_devs = iris_glymur_init_cb_devs,
+	.deinit_cb_devs = iris_glymur_deinit_cb_devs,
+	.icc_tbl = sm8550_icc_table,
+	.icc_tbl_size = ARRAY_SIZE(sm8550_icc_table),
+	.clk_rst_tbl = iris_glymur_clk_reset_table,
+	.clk_rst_tbl_size = ARRAY_SIZE(iris_glymur_clk_reset_table),
+	.bw_tbl_dec = sm8550_bw_table_dec,
+	.bw_tbl_dec_size = ARRAY_SIZE(sm8550_bw_table_dec),
+	.pmdomain_tbl = &iris_glymur_pmdomain_table,
+	.opp_pd_tbl = sm8550_opp_pd_table,
+	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
+	.clk_tbl = iris_glymur_clk_table,
+	.clk_tbl_size = ARRAY_SIZE(iris_glymur_clk_table),
+	.opp_clk_tbl = iris_glymur_opp_clk_table,
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
+	.tz_cp_config_data = iris_glymur_tz_cp_config,
+	.tz_cp_config_data_size = ARRAY_SIZE(iris_glymur_tz_cp_config),
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
index 000000000000..f16155b7dc99
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_platform_glymur.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/media/qcom,glymur-iris.h>
+#include <linux/iris_vpu_bus.h>
+#include "iris_core.h"
+#include "iris_platform_common.h"
+#include "iris_platform_glymur.h"
+
+const struct platform_clk_data iris_glymur_clk_table[] = {
+	{IRIS_AXI_VCODEC_CLK,		"iface"			},
+	{IRIS_CTRL_CLK,			"core"			},
+	{IRIS_VCODEC_CLK,		"vcodec0_core"		},
+	{IRIS_AXI_CTRL_CLK,		"iface1"		},
+	{IRIS_CTRL_FREERUN_CLK,		"core_freerun"		},
+	{IRIS_VCODEC_FREERUN_CLK,	"vcodec0_core_freerun"	},
+	{IRIS_AXI_VCODEC1_CLK,		"iface2"		},
+	{IRIS_VCODEC1_CLK,		"vcodec1_core"		},
+	{IRIS_VCODEC1_FREERUN_CLK,	"vcodec1_core_freerun"	},
+};
+
+const char * const iris_glymur_clk_reset_table[] = {
+	"bus0",
+	"bus1",
+	"core",
+	"vcodec0_core",
+	"bus2",
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
+const struct platform_pd_data iris_glymur_pmdomain_table = {
+	.pd_types = (enum platform_pm_domain_type []) {
+		IRIS_CTRL_POWER_DOMAIN,
+		IRIS_VCODEC_POWER_DOMAIN,
+		IRIS_VCODEC1_POWER_DOMAIN,
+	},
+	.pd_names = (const char *[]) {
+		"venus",
+		"vcodec0",
+		"vcodec1",
+	},
+	.pd_count = 3,
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
+
+int iris_glymur_init_cb_devs(struct iris_core *core)
+{
+	u64 dma_mask = core->iris_platform_data->dma_mask;
+	const u32 fw_fid = IOMMU_FID_IRIS_FIRMWARE;
+	struct device *dev;
+
+	dev = create_iris_vpu_bus_device(core->dev, "iris-firmware", dma_mask, &fw_fid);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	if (device_iommu_mapped(dev))
+		core->fw_dev = dev;
+	else
+		device_unregister(dev);
+
+	return 0;
+}
+
+void iris_glymur_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->fw_dev)
+		device_unregister(core->fw_dev);
+}
diff --git a/drivers/media/platform/qcom/iris/iris_platform_glymur.h b/drivers/media/platform/qcom/iris/iris_platform_glymur.h
new file mode 100644
index 000000000000..e0d07ccf658c
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
+extern const struct platform_clk_data iris_glymur_clk_table[9];
+extern const char * const iris_glymur_clk_reset_table[6];
+extern const char * const iris_glymur_opp_clk_table[4];
+extern const struct platform_pd_data iris_glymur_pmdomain_table;
+extern const struct tz_cp_config iris_glymur_tz_cp_config[3];
+int iris_glymur_init_cb_devs(struct iris_core *core);
+void iris_glymur_deinit_cb_devs(struct iris_core *core);
+
+#endif /* __IRIS_PLATFORM_GLYMUR_H__ */
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 34c981be9bc1..78e3627557e9 100644
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

