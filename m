Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E60379C22
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124694; cv=none; b=NcsT+A7WN6YZlJQZQbA4R1ye1jRgfD6fmPnZJ7nUa3rDsa0pnKD7ZQyD4uGdml1ej2w83sfmTcOA3bLDtozViIhqjDPxPJB69+pPjMBM1RuYwYzDX3RHvv+d72dkl1otw8p3gsV0vWM1Tz7gQ1Ftwf3J0px6MXbIGEqOWaxm7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124694; c=relaxed/simple;
	bh=1w4CgMY6hqW0RscoW+I4KpJUnvg/6sO9akTSyFxDnD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLb3rRbdzguf6tpKQH1Vv7IeNXA5PRuXDzfulYVcZoOQV1joNF+ePl0wVSEvTGqu+GkRD+K/2mBwVoS1cxeJYVsiS4+5jdYwW16A1y6QSWtHl+r/7dDAr+0tq4aZnsx5DRO8oGpPtecKFlkYaxtbRNRKCVjWDhqw/fOWlWjfIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WFGbFU5E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F93PzsD6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WFGbFU5E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F93PzsD6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FE3Pji4006731
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etB4FVaixj6pjK5WgAj9fa3+p1eiXpv7Kfpsfz5keYg=; b=WFGbFU5E/T6Vss8N
	ol1kJDo1d9jSMHvwYK7ICKd/2KfaCcxeU5idiOBSPXTt4evn6wS4EUyIjyFb4RLs
	eE7adkS/BRKfqjN3vkaXLQdv+1xkcfaxY/Cm7Ykh9K7T8YrkYz9hq+k7UhEAcaGX
	j3yzI9HWD+zKOjj/C+w9cSPU2gdZxJoOur8doP0gB0dIP3DfWNPWVvrbKbsloS5b
	qoUobmCxRZ0xkpU5fTh/ihvIu9xtifKeAxhsmX2/KA/o0t5f/D+ZYzyjpa9i7xPg
	A317YMqMloKZ98RWYiWvTh4cGQlvhUXSl68qgJXr3ssLfzJzOfQ32Cpe3TT50unT
	RhyPTg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe6529gh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce870a060so101628935ad.2
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124691; x=1784729491; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etB4FVaixj6pjK5WgAj9fa3+p1eiXpv7Kfpsfz5keYg=;
        b=F93PzsD67mx/qKvFYGB18Cu6A59y7romruv48PsZdTFB5R5l9vO39tUujbktx0bsmr
         RX7RxYuIS1Er7yBO3ZSUsC0D3JPCEicBxLCklGegWpqaoWOy+dK68UtWw6q3sCaS+Q9k
         VrcXlUcEGu6fwyBFxiAFZDuCVgHhei+fShP+e/ly+xNwq9IM3e9GQ5in0PNbPveRn3B0
         IL/otaCx1zl41rzON0D6wd50vC4m54Wy20E7uCr1fck5ZwPOkUwlLS/q2VPqsyY/dkyq
         lCrCSKV3eU44DMuAQ8VTqc8ga0D35yIcqw88prv4OenviuCUoeS76/r2NH4aEEvXe5a9
         N/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124691; x=1784729491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etB4FVaixj6pjK5WgAj9fa3+p1eiXpv7Kfpsfz5keYg=;
        b=MYst3uO8z+IVOvuFUTugCtr26bG2RurRFdCYwcactCBf3NV1kkUTDkZqTg/KnsUSx0
         kN1oTMfRLKbZygae2dVX4rARl7pJ/c5Q8eufyck1znCxYEzdPzahVeB0hiqaB+MABOwc
         Tlbk8xxPvrOy9StrpmZ3dhS4swqCrVK0TADesfDgTFRZIuOhBNssfJH+eRBVLRF9edrH
         CEolfqe2z6z5ShP3WAFU71DOO26+Ux8TUudcDISwz+kpU9t4HrD33AQJW3XJo5Gbg9xj
         A7o5+ySuFkn3bNRz3pC8ocRuRYAjDO7MUunSqCpsv1xYkpRx25EEG9j+cvF4Av7KgZs4
         9NXA==
X-Forwarded-Encrypted: i=1; AHgh+RrHfxfFCoG5wEyX2Fnt4CTxQpyTThv3+9gXmdDcCF//rVwF1NmiE3BEsgYadIgyKprTlpUGsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwF6s6bCkWAJJ7RIhrOpnBYXVg9/zG6Xhee5YN7CZTmg8aJaBEY
	g55ivIx4dIrQ8JWs3cBDhZinPEGS0DvpqaMxp34qVN0k6yuKHbFxEA2dri090UKiPOw0zNC/ODV
	TWPoltIg4dHrlH6HWSv0E853hkoJcdkJIgQKK8WJ9M7g16RNaWC0R0JQb3Q==
X-Gm-Gg: AfdE7clEjWEFhf+Qkn/PBoBIiB1gyzo2iGcuCD4hE+AzhyQFuFCYDdbZJfKSO4KJOeA
	pUkMH6V8Ph1tlenclnkPTRwZDrA/szQZMSsnCl9tDAd5/T2sEXtU8B0elDW5ZVu/itQy+1fkWm2
	MkJwYQAP7LCfHl3w/2LXtaSI1i2Eo72Oyi/dpF6G2QU1xUjQjAFhrWueI6GE7b5r3aN5hBi58qo
	j6yGypJZbsNPLQHJCong4MpwNmeikCLHrjGkCjeRHDgiyDkeYWodcQU5W9IBfKRqBJRaoF3D71r
	G2V5Y+2mS+cKAmMIeQngcjFkuvDPHlrWSOtw+kuvgy1pV9GJ+2Ww3i+OhQ93gHzgsq97z3JMnI2
	CGzJy6tVF94MGEZ8u++xNHKrMHSld+o1opI+unvDu8/au
X-Received: by 2002:a17:902:d48e:b0:2c6:8d95:fd6d with SMTP id d9443c01a7336-2cef136496amr67063365ad.21.1784124691202;
        Wed, 15 Jul 2026 07:11:31 -0700 (PDT)
X-Received: by 2002:a17:902:d48e:b0:2c6:8d95:fd6d with SMTP id d9443c01a7336-2cef136496amr67062995ad.21.1784124690562;
        Wed, 15 Jul 2026 07:11:30 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1070b68dsm2913215ad.79.2026.07.15.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:11:29 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:40:06 +0530
Subject: [PATCH v9 12/14] media: iris: Add platform data for glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-glymur-v9-12-8cf2cbe12a07@oss.qualcomm.com>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
In-Reply-To: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784124602; l=8204;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=1w4CgMY6hqW0RscoW+I4KpJUnvg/6sO9akTSyFxDnD0=;
 b=R5qk/6RNBdmvHYruD91KzWcpoIqOK2ct7dMvrRVi7BraHvG6bqrP5XrTV47f690jYHqUBGLLU
 LNlO9T7qsybB8gnZSDlWcFdCFr3PEw3A2O58UYHiv8BvHRz7Lqc0cGr
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX4aYJX4qnlTBb
 MrsC3oplpsU/B55ww7loXoXGsxNb3Q4x8b1Gwra8xVugHVVr50TTNnGJbtbSCwGOg5KuMu72mT/
 hZO8hZyKR3XvN509Fo9IxK9tGzyuxj/qcuVfEGCGFUCmx0ZAg/dgBvAA6BBWLsLEqcM2kBopOiP
 0kR0nVLmiYpFHP6vDgRr3OaaJ3vuD1A3JR/5j3hngnA2UbsOb3iYbXpPWaCmuuU14MWpwKaxEdE
 lHJDbQSKrT1mo466ULK9TIP4c15daRmqx6o+dUCvVcTZzYiYVdVW1brMnp9WYQi8CyH9JjOmXUi
 PTVcG282+D4Dy8Uu1ZNBR7F+uJ17ByxOQTZUmVyN39qhAlVgGGG+QJTgZcmkwJHTESLYao6Bkxh
 cTCx8RRtpjLgCYZvD5TB7hMvdLB6/BeSW/yvA46R8JkHqoe1SJN6XBbTt2mcRKBoZrDNR2qkyY7
 1DIpbU7J/xOmLYEgz4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfXxOnByF7eoipK
 uNSzMcHuRp4J1QUfSyDlPb7Ij5ejBHXsN6s8d60lJLZSt/Gw6FmQFZQsL8UIns+o2cx87i1n0jm
 NlELwDLnGttVBCxu9B7QxHUtCIWNX24=
X-Authority-Analysis: v=2.4 cv=bKcm5v+Z c=1 sm=1 tr=0 ts=6a579514 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0Xn_3AH55rwbdtokavwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: EdmizJX8Zome8hXHkovs1q_MpNxb1ttu
X-Proofpoint-GUID: EdmizJX8Zome8hXHkovs1q_MpNxb1ttu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150141

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

