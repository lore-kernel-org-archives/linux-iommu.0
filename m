Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164C481A8A
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496466; cv=none; b=lq2hP89IVxp6AyTvxh+pcZi6iWuD/pti5FsVzSt7l/7vEseITb732moPlxqlsR5D8Ej0QOWD/bOJs6999a57trsNGccVfm4q3Aqg58wmmHp6i9SsIZmtBUURiuxbN0wZykJ88K511daPnuVidl6XaNU5hr4ZAdRpgCALgkJ9+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496466; c=relaxed/simple;
	bh=T44iln6MFzLVgbvm7DVSVtF1Q5v53ZId90DxgqJqvdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChBnqUSoQ8fA/V2CTKcmchSzyYQHIJuK2EXiJf2TvRtfA+AoXVIIUTzFw0QYbRJBnWmuw1r1scT761wiL5pkIflPx7yNfcM7oPsBC4tPCbazhGljQSmSHZIh0mMi+dAk8m66Zdv8ZeIZDea9O75y17GOyNHJIoGsiNGuPy4SXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=acB8ma66; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fxHlHWd8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="acB8ma66";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fxHlHWd8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CWcTm873897
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SBl9PUGFBYjnx4RI+fyG46o5B94Upc7xiysH7QXL+FE=; b=acB8ma662CClmjCX
	VmCFCOqAlMSMbdxmS5jvETfqHCyeqx62R9ByJ66TTqPORviN7SsPT2OLKla5tou+
	OWEXLYfj3JSFrKd7tzWIzjZeODdMokeYTMGfKpI6ktwvkguTgJIrTtyEAKWLzcuk
	jm35AQV+tZozGWcspU84Jt9UdquGvy8qyY4gu9skvDTLbR8y6jgudKnKrgv2kSiv
	/2n/sOBepJPq47vq3+aGYsc9/ef+JNMV2KUqNJSWOokHc2p87faUTgCvWFUYAkld
	6VrCvJxEmn3t+F26oy/sXZgnfAv/MNv6Z3YIfN7DlM+r+JK8BFxudQFIMN3QrS3W
	C45mwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ej6a9kv0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:21:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c331eda3so48015095ad.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496462; x=1781101262; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBl9PUGFBYjnx4RI+fyG46o5B94Upc7xiysH7QXL+FE=;
        b=fxHlHWd8miTgtmoa28nECawGZoOl4x3j9Wp+5ssURZOW0dydHbO4/cHsYWWOM8YeFj
         2l+IqPHbaYYhxlrQSkjQU9G/YihdHQCEeEb78GAiSk0xg9B8kLRTyR7ZvNEXB/EKVuop
         zgi0UJUm3rRw6KNnjpUOjsygwDLOk1hd4z37ngvKpR/2F3+NKN5KVeN/JeoebbOtaDcS
         FFmfVk21toDO6b+ZjbCQkySBp7kYACKB3+jI5X0drMgo3tkRcFo+kK4a4iZs0GYQnfeP
         VIxYRlt+RLyNoPIN6LBxstvf3u2jyVOPxFplEvDnDU+QFFasiF0UovQv8gTgNB73T4m9
         4Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496462; x=1781101262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SBl9PUGFBYjnx4RI+fyG46o5B94Upc7xiysH7QXL+FE=;
        b=K68K2UN8ze5A/SaqysaZKbUm/IXQP2srswZWpOX834P5/1pyi9RafdF7Q7liyhqv+d
         GlDazc6yHtR21RtamjeF52DN2eFDuvcBqARafLXj/mfX0ArAF8pqvJI9K0DL3dQSUUqd
         h6GiC4mH2xNaHb5faOa6yRogz2Zk4mbNG45aUQN6nHD3tNwpnzXUJ+RC7AQIShiNBAMz
         4e118jMtxt5Bc1l8PsjBml18q3XN6GaUtj0P6IsXel/FmFeBkvTuN49edXkDLmo/H0BA
         /NyqENgjP/wPr5A2GpuI2Xo6bOTWsHBW+SVeQuvFje5VmSh+QYS9JzYDZOeMmeAo0V7U
         Oveg==
X-Forwarded-Encrypted: i=1; AFNElJ8pIcZTZBJkOqURX0ORhvqFLZU+orU00N/azmAMg0skpjd/LzCk68R2Jb9OZYWlotsrmyQaMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjE8YZ5YPlel71YCQEW/M8R6Fa87gd7utB055jYc6Pei0gJhmg
	snm2fvjy0n2O4IN6qZ8bixCdHWBgLlDluanA9V3SbE62Ge3hIQ9Gnwu4d+rICt0pHxKqFHkKdT0
	Qc8FZpzFVGSrWKAyl0bf4DR7aGtt1/OcY+IMxv7204k5LJ96CMdOmHNZseA==
X-Gm-Gg: Acq92OHRKZoTIdnlE9cK6w6gVX6+lqhf3laYdMOqieE7uqzzQtPFq+xgtfB1hD4c7Nk
	9uW0zVJqhqikrYV8X+Hl4snlYs0jK73EdemHCcQQ57+LuHUxQep9D7fdprbqEhvRlvkoYd3ILFt
	57VN+mwlQB/J6jYT4KG10hfzKN4k1PJ47omgC8rCZzKhGwrGxKqrwXbFZjEriyT7jimJ10lGBvh
	or4pdFyQKn9i12JlJSkt433ILE61TCHzbbmC9zr0szyZNc/4TJIbayMAnCOXeCUB5ubrTJd2dD0
	4tDBtdquLNhRC8b+Ty8GpVLFjFhuya5imRySB2ZvpmEqX3kDZgfKlAaE+Y+BHao61Hv6fVOX1Un
	lbX9DJlmZFpIBJM/U2uTYUAc/2jMErJGwBRACGKcOCxgoXpYZl44vorzVRf1a7mk42w==
X-Received: by 2002:a17:902:c602:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2c163a14eb7mr23796345ad.2.1780496461622;
        Wed, 03 Jun 2026 07:21:01 -0700 (PDT)
X-Received: by 2002:a17:902:c602:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2c163a14eb7mr23795845ad.2.1780496460914;
        Wed, 03 Jun 2026 07:21:00 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:21:00 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:45 +0530
Subject: [PATCH v7 07/12] media: iris: Add power sequence for glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-7-afaa55d11fe0@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=8811;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=T44iln6MFzLVgbvm7DVSVtF1Q5v53ZId90DxgqJqvdw=;
 b=GbQFWWNNjalr/EaDedTOKJQS+UGK8uAddkZMmYMN1pdm3up/Jv8w91lEV9fh4EccShNPDtkV9
 npvBDmV4arLALWMjT9eQcu5YOZENN8RF74tbB1CTIrK9xAQ7FxO5W/P
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: 0Y4HqyD2oTFnUdoy1GKe7VvxEZReDK_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNyBTYWx0ZWRfX+2UjW1r6J5TW
 ux09SB0qshr1SgJzOl9Rp+6VSNCGCYuLWpedHT0b4UYJcttfgr1SXbSgMCDX3ODDeqbLk+aAxPm
 TmjViahnyFodb+YZpJXQE42pFxa67qpCgyyhbAPoIIrdxr082qTZv3rBIhtXV/SINA3kejm3Qvm
 dyOoB3mUlTja5ahFGjbqs4Xyxeoxp2aZAiI+7JiK9U3paYKAwg4F2q9yij6Rqs6XhbFvcE6miZJ
 GKxNlMcSO14lEr9dqxqqtW4kaOx3IIihoCxIZkmfReKTVqbi73Vbkf7LjRUonItognQ+1g6Cn+d
 s/I66FtmxsPE7rangOBsUw+7Yxp8nmLFryYnMvdMU5C11Fjl55Mc6uj2ifcNG0SGnU9v9jluawu
 8i/hX8EJi1jOasSkvJqoL8K0N3UqKhwqmT/Sya9IxPxF0ChglUgbb/LGjreL8zKfO/UTkXpkcEG
 ctxg6PKdvVzPbVqDCeg==
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a20384e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=on-tpLi9NVdX0ogc7TgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 0Y4HqyD2oTFnUdoy1GKe7VvxEZReDK_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030137

Glymur platform has two video codec cores: vcodec0 and vcodec1.

Both cores share a common clock source (video_cc_mvs0_clk_src) and the
same power rails. The clock dividers between the source and the branch
clocks are fixed. So when both cores are running, the source clock always
runs at the highest frequency requested by either core.

Since both cores share the same power rails, the power corner cannot be
voted independently. Scaling one core's power corner up or down would
directly affect the other, leading to under or over-voting.

For these reasons, both cores should voted the clock and power rail must
be based on the workload of both cores.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 111 ++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |  10 ++
 3 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 7cda94601555..f07eaf4b3be2 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -17,14 +17,14 @@
 #define NOC_HALT				BIT(0)
 #define AON_WRAPPER_SPARE			(AON_BASE_OFFS + 0x28)
 
-static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
+static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core, u32 pwr_status_bit)
 {
 	u32 value, pwr_status;
 
 	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
-	pwr_status = value & BIT(1);
+	pwr_status = value & pwr_status_bit;
 
-	return pwr_status ? false : true;
+	return !pwr_status;
 }
 
 static void iris_vpu3_power_off_hardware(struct iris_core *core)
@@ -32,7 +32,7 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
 	u32 reg_val = 0, value, i;
 	int ret;
 
-	if (iris_vpu3x_hw_power_collapsed(core))
+	if (iris_vpu3x_hw_power_collapsed(core, VCODEC0_POWER_STATUS))
 		goto disable_power;
 
 	dev_err(core->dev, "video hw is power on\n");
@@ -78,7 +78,7 @@ static void iris_vpu33_power_off_hardware(struct iris_core *core)
 	u32 count = 0;
 	int ret;
 
-	if (iris_vpu3x_hw_power_collapsed(core))
+	if (iris_vpu3x_hw_power_collapsed(core, VCODEC0_POWER_STATUS))
 		goto disable_power;
 
 	dev_err(core->dev, "video hw is power on\n");
@@ -221,6 +221,98 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 	iris_vpu33_power_off_hardware(core);
 }
 
+static void iris_vpu36_power_off_vcodec(struct iris_core *core, u32 core_id)
+{
+	u32 value, i;
+	int ret;
+
+	if (iris_vpu3x_hw_power_collapsed(core,
+					  core_id ? VCODEC1_POWER_STATUS : VCODEC0_POWER_STATUS))
+		goto disable_power;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+	if (value)
+		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
+		ret = readl_poll_timeout(core->reg_base + (core_id ? VCODEC1_SS_IDLE_STATUSN :
+					 VCODEC_SS_IDLE_STATUSN) + 4 * i, value,
+					 value & DMA_NOC_IDLE, 2000, 20000);
+		if (ret)
+			goto disable_power;
+	}
+
+	writel(core_id ? REQ_VCODEC1_POWER_DOWN_PREP : REQ_POWER_DOWN_PREP,
+	       core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS, value,
+				 value & (core_id ? NOC_LPI_VCODEC1_STATUS_DONE :
+				 NOC_LPI_STATUS_DONE), 2000, 20000);
+	if (ret)
+		goto disable_power;
+
+	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+
+	writel((core_id ? VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE :
+	       CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE),
+	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(core_id ? VCODEC1_BRIDGE_HW_RESET_DISABLE : CORE_BRIDGE_HW_RESET_DISABLE,
+	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
+disable_power:
+	dev_pm_genpd_set_hwmode(core->vcodec[core_id].dev, false);
+	iris_disable_power_domain_and_clocks(core, &core->vcodec[core_id]);
+}
+
+static void iris_vpu36_power_off_hw(struct iris_core *core)
+{
+	u32 num_cores = max(core->iris_platform_data->num_cores, 1);
+	int i;
+
+	for (i = 0; i < num_cores; i++)
+		iris_vpu36_power_off_vcodec(core, i);
+}
+
+static int iris_vpu36_power_on_hw(struct iris_core *core)
+{
+	u32 num_cores = max(core->iris_platform_data->num_cores, 1);
+	int i, ret;
+
+	for (i = 0; i < num_cores; i++) {
+		ret = iris_enable_power_domain_and_clocks(core, &core->vcodec[i]);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	while (--i >= 0)
+		iris_vpu36_power_off_vcodec(core, i);
+
+	return ret;
+}
+
+static int iris_vpu36_set_hwmode(struct iris_core *core)
+{
+	u32 num_cores = max(core->iris_platform_data->num_cores, 1);
+	int i, ret;
+
+	for (i = 0; i < num_cores; i++) {
+		ret = dev_pm_genpd_set_hwmode(core->vcodec[i].dev, true);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	while (--i >= 0)
+		dev_pm_genpd_set_hwmode(core->vcodec[i].dev, false);
+
+	return ret;
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -248,3 +340,12 @@ const struct vpu_ops iris_vpu35_ops = {
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 	.set_hwmode = iris_vpu_set_hwmode,
 };
+
+const struct vpu_ops iris_vpu36_ops = {
+	.power_off_hw = iris_vpu36_power_off_hw,
+	.power_on_hw = iris_vpu36_power_on_hw,
+	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
+	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu36_set_hwmode,
+};
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index e0dc109bbe6a..e2e3e66574fa 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -12,6 +12,7 @@ extern const struct vpu_ops iris_vpu2_ops;
 extern const struct vpu_ops iris_vpu3_ops;
 extern const struct vpu_ops iris_vpu33_ops;
 extern const struct vpu_ops iris_vpu35_ops;
+extern const struct vpu_ops iris_vpu36_ops;
 extern const struct vpu_ops iris_vpu4x_ops;
 
 struct vpu_ops {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
index 72168b9ffa73..e67d98b8c91e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
@@ -7,6 +7,7 @@
 #define __IRIS_VPU_REGISTER_DEFINES_H__
 
 #define VCODEC_BASE_OFFS			0x00000000
+#define VCODEC1_BASE_OFFS			0x00040000
 #define AON_MVP_NOC_RESET			0x0001F000
 #define CPU_BASE_OFFS				0x000A0000
 #define WRAPPER_BASE_OFFS			0x000B0000
@@ -14,6 +15,8 @@
 #define AON_BASE_OFFS				0x000E0000
 
 #define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
+#define VCODEC1_SS_IDLE_STATUSN			(VCODEC1_BASE_OFFS + 0x70)
+#define DMA_NOC_IDLE				BIT(22)
 
 #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
 #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
@@ -35,6 +38,8 @@
 #define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
 #define CORE_BRIDGE_SW_RESET			BIT(0)
 #define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
+#define VCODEC1_BRIDGE_SW_RESET			BIT(2)
+#define VCODEC1_BRIDGE_HW_RESET_DISABLE		BIT(3)
 
 #define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
 #define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
@@ -52,14 +57,19 @@
 #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
 #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
 #define REQ_POWER_DOWN_PREP			BIT(0)
+#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
 
 #define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
 #define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
 #define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
 #define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
+#define NOC_LPI_VCODEC1_STATUS_DONE		BIT(8)
 
 #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
 #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
+#define VCODEC0_POWER_STATUS			BIT(1)
+#define VCODEC1_POWER_STATUS			BIT(4)
+
 #define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
 #define CORE_CLK_RUN				0x0
 

-- 
2.34.1

