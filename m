Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9FC3D9DB1
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266949; cv=none; b=mMfd93AUiLfDtpcMjJ+CI7MfkDC4AvyLnBqIt24Iw0200yyE2hBO5VY53IMVN2W82HLZ3HOk2QSy4M8QwCTQvT3Hzp9F4gt4Bvdu0oW05O25DWve8X8u3lWAQ6fywZ/uFLHwWC5xE+caoJ8DCbWZ3ac7nd3rYedM6lwp+lTO7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266949; c=relaxed/simple;
	bh=NJSdAXZkHYGiL5IiO5nzpmf3dRQxwMwMQ2OLeMaz0HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrhRAtscJlWOm4H/sP96oTSioMqwt5AJVThx8cyreAAdPpouWxxvhDpt7Kmus54M2sbOltSsWbYNktKiSxqg5s3PGE2O28piUjgUCR18EyiHXs4/Hies2Wi/v9/1j1w/MOOVuxPltuUH8qBWvt93MxWd/tnElq0vHO/6Rm0opeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LItmtSTD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CjzXgXpi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LItmtSTD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjzXgXpi"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648ClUWX257892
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9pLZcDc9inyNXkLcuhRnBSRa/7qynd2vanhOczFldBY=; b=LItmtSTDH+0pLeAu
	eKp7DqSIyfDN7oRyt4uFmIlZ5iF+inM+UQtcrCJ8rI3DB+AmP9qVPzLndaw6mjfa
	eyxrxzr0S7qx5wr9JM2k+XNVsSV3MY8zyTIEEbe2epgwueePxbWBA286+sQD3HRp
	qoX/IC0uILHBMmpySK3mgmjlQTeZFKUs1NhXbkDWuS51sO9k+jEoWWooKvEZuR04
	da9YyPYiR4JhWLKwDYgWRf88h9zw1kJgAYq6kyLLC1gLbmNa5IYj5RzaQW8EpDMT
	UO3TkFAut9eSvrcaJrH9r8ZXIHDJ0vgB38MAsrtlY9RZ4yxVbYD64cluPzFGT6zx
	MH/jVw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1auejskp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:02:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-836d0184333so2231763b3a.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266944; x=1778871744; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pLZcDc9inyNXkLcuhRnBSRa/7qynd2vanhOczFldBY=;
        b=CjzXgXpilF1E3H9NK9Hs99kRzjsDDz9czugMXb/03grdnTwA96axxbubKgoQ4VtPqX
         f7vrv/ALMJx+4V1eNenwn6TLImVLqX2ODxJM6LLD78o77Nrv9naXjs2Zxk0kwP0PTTBb
         dla8VKOpo+1hLhMIt/VPaO/wtG2q7uBL+UqR4sfEu+9X8LRh90qJU6XqK6A7DddtBs1p
         ZkkjfSK+QUO5lZSmGWf5oYGWWkpISi5CUijROOn5iIKOi0fJGok5vHg6ZH78njUS41Di
         lTaDU1/sRPjs5ex1TQ6xeOz7Wxggc/gcnwbcF6yUPNrISfC0oHlSsXpFhsY1BYZUsMST
         YfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266944; x=1778871744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9pLZcDc9inyNXkLcuhRnBSRa/7qynd2vanhOczFldBY=;
        b=VZDAj/I4almquml0QNmPgRLHWT8pMWB+Mkxn0nSpDOoT/aWURXrE9esRpqW14UBMtI
         9LCbsGG4o4MNj0rRBwJBRofShAbdLUZcwAYSxaCVhfmiLUsT6+JNFGuoqlsYvf6IpmW4
         L6/bbVUWcQ6Ingu3pa9q/iIs9x7n0yjdvZ1EbZY5cKjODDCGAnFLoz0FTg3qqUy6swIw
         s0e8Iy5TGHpThkfQ7EfHxR0JRHSWvfCQQYWoEQMy0TaW0ReeJUW0vEuCAK6nkpfRmCEr
         cshA+5o3zuc7jAM4APVSLeLFT0ywMLutLiNpF+2bU638eV556lP6QOBrtWN2CDJ46zyp
         IfGA==
X-Forwarded-Encrypted: i=1; AFNElJ9rmvR3Tuv4SO9Qhexa60oYb3SiutjrUxwnEiMgVsVj+xQrtoNAKkc8gyC5CEwiwAUuFQ8nhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXspYP1k1XNWZoWclGxH7BRSZ5w9qwsge6FEVNtlpUApJ2z+L0
	e95ZB7LviN7f0CgFSBb7B1nDDxyjqvL3/j5BU6slGwQP1MMxRI4v+TdAyNUHNs+vwVH+IPBBN1z
	qca9HApycTU5bNANDNlxJK3LNzC6oCtvs0Po+HGls6Sl4P485LCD2+u4Xmg==
X-Gm-Gg: AeBDiespJ1+W+b3qmv/g3t1qBG58o48+uLl7QL2Xk9L87Ano1FiLI2HE6cxy2HwTHYp
	6C8f+AKCnkqz+UAgknsW3ewp2CnBqBBgk7hnD5DwflItOndQSzUTFpc77thYz0uOIdXdfFL12Pm
	KiXBLzWLJqvQLmnkxj9DSKDbvbywUmsoBBNKvrw5snrBH7xHMv+x5WFEfkFsYHc1Ynm97AMuFpi
	2AqO2YIdsYfQo+Q1aA9VmhC4ctPAN/1Psfsp345cIAs+u9pVHDl9YQVbsv1w8tKv1YHpcF8+LWn
	KfpkjSJBzZxOLRCFhIuY5zb41mZURGGG5/Gt29gqWjAyXZi4seeNL189FEajngXxALT9k1KpxUE
	su6bs1jwBEDwnAZMwPALFQHaxX4sprvTGzqJuJbkGC94frTsKsqILAlw=
X-Received: by 2002:a05:6a00:b48:b0:82f:280a:d888 with SMTP id d2e1a72fcca58-83a5bbd5fd8mr13717634b3a.12.1778266944245;
        Fri, 08 May 2026 12:02:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:b48:b0:82f:280a:d888 with SMTP id d2e1a72fcca58-83a5bbd5fd8mr13717578b3a.12.1778266943701;
        Fri, 08 May 2026 12:02:23 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:02:23 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:30:01 +0530
Subject: [PATCH v5 12/14] media: iris: Add platform data for glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-12-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=11630;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=NJSdAXZkHYGiL5IiO5nzpmf3dRQxwMwMQ2OLeMaz0HA=;
 b=jYiEBswm/zLDEuiuajMGOj0+AOrnhnYJqk0fB1LIUJs7h+ydYyzSfHmSHFQHSslUF5WaHBQiB
 p8TNPmkexdGBs1d52jbMpnTdEwRFU8GWRqzHSkFTNBwiV42ZiCeS3in
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfXxPnXFC/umECy
 FWVHSZ5dpclwodvTp0y7jXTxK/kXOWONcS6vX4NNOWtA5p8c0JOFuB/QWqA0BqgZ0ga3z5ZpnTf
 qlhXArU5FWXjs/5/wngxukOHUJPJl6g+vuda8PWOUgU0++ETvFD+jyQwliLp+ZNIozoY+xLb750
 mZj1epxd6yszgvQe2QKvVCJojqImZYso6HYKQD81Np77lUfXSs13SxCqpgtbw+pNEacAi1gh/3d
 03fDnJQ0EIIJ4O8A5yoJcrwHtkx76zybOXZmwLQz8psRsm8LbJPukibomJJoVBzbh6DBJE4l3DV
 Rbl5mLGYeqtFph3fc/pvC71VbBjrSUimHa+55mXKguyI7fi4r+aavo6oZWKxBIWtGY44qVGQTCy
 DYP8EJAOr7gg59C/pJJj1k4sjyQm7XQpU1oaLFJLOtQ79qRCM2BWrMBFVdXyfap8F8NvD/wQQjW
 QSTmxdVBWI77hRl93Gw==
X-Proofpoint-GUID: YWI4v1GeFFEP5hNC24qboNWVNZC5xKxS
X-Proofpoint-ORIG-GUID: YWI4v1GeFFEP5hNC24qboNWVNZC5xKxS
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=69fe3341 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=syK4oCsQgbaUnHKzOKsA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

On glymur platform, the iris core shares most properties with the
iris core on the SM8550 platform. The major difference is that glymur
integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
one. Add glymur specific platform data, reusing SM8550 definitions
wherever applicable.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
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
index 79bc67980339..adb970b3a3af 100644
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

