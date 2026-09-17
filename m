Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEF3E40FE
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621306; cv=none; b=Oc8Ksv7e7mMgvDLUM2WB9POt6Ug0R5a/luL1GiXWYjRzyHvf6/k5nBitz8dP0slOcJzfnVYMkOOppC5ObH1eWDqAuUNU5o7rVa4r/9p/FLfk912i2THsbJEX/IpFJP5e6jdo852ph4wMW29waj6mNygMpjjw6B5bxKGz3cfdJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621306; c=relaxed/simple;
	bh=AnqQ3dMMWwjfS1DZyYObOXrVudWl+j4L2KPuJCDobNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjuK5kOcYywMpsi7DGpgpj3iDbrOoKYV1jvKYsNGSKkzusXXXTKpwRoo3MAjWkY4OhfH0wXg35omS19h0PA6NaYswlkm5hU9JXXJxHfTgeByU9RfXXrykZ8hj2H/ZyI+MNKaZSPXUy9vEmI9GWmJFppjH4btgZxQlDK59ZXcefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HAfiTCU3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvYguzoU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HAfiTCU3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvYguzoU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H2sjwt3302587
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H4Js5Limpe9fDaU3+cneqpv0WTKfYeCktYQ1Y+hEgFk=; b=HAfiTCU3zD0BtAKM
	DWbomKrCvNrHSGE/0Ob7BfWF/xMC9c2dn9L4bha12p8JG4vlIi3D7qvMIFa4Xj5G
	dmxs5GHTM/gNvCn/ZCr4dYMoTgt4foFhoUBsUaJQbT8Y6mfShsyP41Mls/S/yC9W
	qMNExP4Z66J4RW1zPwR/YQnoemjvhw68nEYe1Z8v3FE8BK0FWbKKL8k4K+ZNmZLe
	2Xx4bZHMJM/VzElRum4N/MiumsWr3QP97aGt3ugJiPSWI55LRNwg212Qi6VuZq5H
	IuVNvesBB2DXSUo4Z9mmFh0KawSzyn6xD8GypUqw7Jej07Hymg5qEZ/v38Y/y6kg
	n32ZtQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr7uc8dmy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:43 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b28deb7ee3so724007b6e.0
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789621303; x=1790226103; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4Js5Limpe9fDaU3+cneqpv0WTKfYeCktYQ1Y+hEgFk=;
        b=cvYguzoUlzvH/FxlXPb8OBUqZLOIEKT5yLwplux9k0/VS2L1oE9t0KsNca4oqIpjOR
         U5FIB8ES+leJTKD6qFEuf7NLMhSRpxv0pRAKYYZkiYm2lP1PK9CYC5lO4WdVmgd8RHIC
         fAeiaBXoxRYykFTWNebGHRAN1sWSgRsqzdMIuMvCdNjmICSUgecnM4grL4GZ21p1fwX2
         wSvjpG3NZehO4V3xbp3s56Zd05lSRjvt1+0otz3TNqLrmVSg58jvluOOoMxMJbanI31Y
         6nlK12bXRm+mLJm7fYBeszskUkpH0EcPijNKF9XVdAA3frJuXfmPAYnELkczaLoKdH9c
         mAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621303; x=1790226103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4Js5Limpe9fDaU3+cneqpv0WTKfYeCktYQ1Y+hEgFk=;
        b=cninLJcsVBbT6pWeJ/BlVN+XOV9hNIPSzsCim+WslSzfEyDpXIRp7ECGBgrTmgSAuO
         Z1I19kRhWxC53V7X1PfDxtJO1xwMqr9dfu87dsZxP+frcM800lTTdIuU9oijOYOVdM6F
         bJEj+KlfoTzFkzia/SYFMQplb/XqKCsCJA6QY55YQir5/LswGfNle5OFLhc7qCJ3QpR1
         elL6QuZ496ND1wZHOrTMWADGaFi4R0kj36UCVtdxfLBsFm7lRL57454VkIh61aI6d1Ro
         9Op4MWokTtKc/+QQggT3V3xkgMLOfba0sElftFSW94EXw+DPO8up5OeDFDIdGgwqRZHN
         FCzg==
X-Forwarded-Encrypted: i=1; AKwUvBzbqK7r6PZmXM9pBLR7au8CrXVeFk0068s1vgDaseK/C37ksAkn9fUWwLmQxTGJvfLEWs5xWQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nwcQRKhxj+Kc+HYPmbnsvA2w8ft74CcSoKIU9j+FloaGkQqp/0
	YVy2S6Z3E1hwkbRT4iLn2elbiw5hVaiQEe9WfdYa8zl8UpfhmMgeGnA4gl5XS0TDF+DZHEGU04N
	gpbnfaEu+ScSmoP+oKSTpBm1E+Ak79fULlKlj7AXdC0TjmjP16B0i7k5sJQ==
X-Gm-Gg: AYBFou1OV+Avog5qooEsay8UByLzT3U+cs3j/7uI2uBv2rP1FUEiI/S2JgWkU3Dmr1/
	Bxdj7m9/w1H486dXgNTeHFlRj44af0WzewhnHtSDekxJeGSYAcUV/K41zbDHpqF5N9On5v8D3oP
	CqmK4JYkSwJHzX7sunY1mQ7DZT2DwkfiC8fRHeYpUwbRxiBUCbo1gx9vXMrSDsRyi64+H743TbN
	PPHYrHBK93WqFJBBQV+GBQ6861q6grngvgcT9YcIiznRPx085ZRyweD+jUz1cOvKDDHjxhhHgzB
	BmPYAIKWb3RgRvHE2XAsPRZQ+FAoiVe9pVyeOQWF9zHlatRkS0HWQGF6IqBfq3t+hJwVfiZVA9w
	93pjFn4aroyvnenYYokF9mrVCOB04bnlE5Q==
X-Received: by 2002:a05:6808:1921:b0:4b9:a8ac:480 with SMTP id 5614622812f47-4ca4c6bab9emr6269635b6e.30.1789621302557;
        Wed, 16 Sep 2026 22:01:42 -0700 (PDT)
X-Received: by 2002:a05:6808:1921:b0:4b9:a8ac:480 with SMTP id 5614622812f47-4ca4c6bab9emr6269610b6e.30.1789621302068;
        Wed, 16 Sep 2026 22:01:42 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm23544223eec.31.2026.09.16.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:01:41 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:30:23 +0530
Subject: [PATCH v11 4/9] media: iris: Add power sequence for glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-glymur-v11-4-e0c8bc914742@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789621265; l=9655;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=AnqQ3dMMWwjfS1DZyYObOXrVudWl+j4L2KPuJCDobNo=;
 b=UB6lXyyNLDOW2wpVeBUy/gkPzzw4bYAnz6RR+cW+uX/X+Klq5X1IZ3h8jVjJGPSQIZphuLMp2
 Lz6XJsonrdjBASosDcAN2Pmi08/Zky9TQrH03hg4j4TL5Ezg2VWMXUr
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfX9jJkbtL0b0Ww
 aLis9w3hIrRWBTGIVfm5K+cQUufdvdOyoVAsAT6KvHnS3A9K6PnEHqcp+0E91xbwvmsO1mQ6o5v
 upK1DhMK1HAdZoje/weimXjOugt9+46sibrruSAKPPbmxX7/nz9HUqYfKbNDFlqjYFPY6Uw/jbu
 BqoR3HK77NviKYJb5yLb6cbAPkevEwBvTULSlJX5iRlggAfRg4Nf+qnjfonk1Ddy8VG4sVK5kQ3
 HKutseo9siR6zTISn5Qj1AkRI6ByH8Q8LDOFZBZv74kJ/AaX/G4K+K/aH+Iha7AmvKOJraECY4/
 9X4ih2tD06PFz8usuXu31REfKQmfyJ/bVa0ibytKqo/oDik5tixFIKVha6kIAaXULPxEmTDZjS7
 xa9V3rnCJg9RKpOsdoUoHZ32CH2SpXfkGrDL+KSuoSg6lqWP7VZPG6l4QVcNLZo5g6tfJrvv7yR
 6s3z0eECKLtzOcHI+sQ==
X-Proofpoint-GUID: 02lw2bI2RCbv0m5aP8L7BOTJUseGKqkp
X-Proofpoint-ORIG-GUID: 02lw2bI2RCbv0m5aP8L7BOTJUseGKqkp
X-Authority-Analysis: v=2.4 cv=F9zC5ahN c=1 sm=1 tr=0 ts=6aab7437 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=j0zrPJlDeI9ZXVQ5fz0A:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfX8Vj+WdjCv3Tj
 HtfjiKe0/Yw3Ez96A+85LBBDJa6nDiVm0s6ZC05uRGbcxBFDq/mwOnDsp9Z84WJ2jNWX8ySSHaA
 +dKCM/R0ejUtiv+2lKJxyUz2Fy0+yfo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170063

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
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 127 ++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |  12 ++
 3 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 7cda94601555..7b07d33d6119 100644
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
@@ -221,6 +221,114 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 	iris_vpu33_power_off_hardware(core);
 }
 
+static void iris_vpu36_power_off_vcodec(struct iris_core *core, u32 core_id)
+{
+	u32 bridge_hw_reset[] = {CORE_BRIDGE_HW_RESET_DISABLE, VCODEC1_BRIDGE_HW_RESET_DISABLE};
+	u32 lpi_status_active[] = {NOC_LPI_STATUS_ACTIVE, NOC_LPI_VCODEC1_STATUS_ACTIVE};
+	u32 power_down_prep[] = {REQ_POWER_DOWN_PREP, REQ_VCODEC1_POWER_DOWN_PREP};
+	u32 lpi_status_done[] = {NOC_LPI_STATUS_DONE, NOC_LPI_VCODEC1_STATUS_DONE};
+	u32 lpi_status_deny[] = {NOC_LPI_STATUS_DENY, NOC_LPI_VCODEC1_STATUS_DENY};
+	u32 bridge_sw_reset[] = {CORE_BRIDGE_SW_RESET, VCODEC1_BRIDGE_SW_RESET};
+	u32 idle_status[] = {VCODEC_SS_IDLE_STATUSN, VCODEC1_SS_IDLE_STATUSN};
+	u32 power_status[] = {VCODEC0_POWER_STATUS, VCODEC1_POWER_STATUS};
+	bool handshake_done, handshake_busy;
+	u32 value, i, count = 0;
+	int ret;
+
+	if (iris_vpu3x_hw_power_collapsed(core, power_status[core_id]))
+		goto disable_power;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+	if (value)
+		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
+		ret = readl_poll_timeout(core->reg_base + idle_status[core_id] + 4 * i,
+					 value, value & DMA_NOC_IDLE, 2000, 20000);
+		if (ret)
+			goto disable_power;
+	}
+
+	do {
+		writel(power_down_prep[core_id], core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(15, 20);
+		value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
+
+		handshake_done = value & lpi_status_done[core_id];
+		handshake_busy = value & (lpi_status_deny[core_id] | lpi_status_active[core_id]);
+
+		if (handshake_done || !handshake_busy)
+			break;
+
+		writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(15, 20);
+	} while (++count < 1000);
+
+	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
+				 value, value & lpi_status_done[core_id], 200, 2000);
+	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+	if (ret)
+		goto disable_power;
+
+	writel(bridge_sw_reset[core_id] | bridge_hw_reset[core_id],
+	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(bridge_hw_reset[core_id], core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
+disable_power:
+	iris_genpd_set_hwmode(&core->vcodec[core_id], false);
+	iris_disable_power_domain_and_clocks(core, &core->vcodec[core_id]);
+}
+
+static void iris_vpu36_power_off_hw(struct iris_core *core)
+{
+	u32 num_cores = core->iris_platform_data->num_cores;
+	int i;
+
+	for (i = 0; i < num_cores; i++)
+		iris_vpu36_power_off_vcodec(core, i);
+}
+
+static int iris_vpu36_power_on_hw(struct iris_core *core)
+{
+	u32 num_cores = core->iris_platform_data->num_cores;
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
+	u32 num_cores = core->iris_platform_data->num_cores;
+	int i, ret;
+
+	for (i = 0; i < num_cores; i++) {
+		ret = iris_genpd_set_hwmode(&core->vcodec[i], true);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	while (--i >= 0)
+		iris_genpd_set_hwmode(&core->vcodec[i], false);
+
+	return ret;
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -248,3 +356,12 @@ const struct vpu_ops iris_vpu35_ops = {
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
index 09799a375c14..63bf0cec58e2 100644
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
index 72168b9ffa73..c44c85eac3b5 100644
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
@@ -52,14 +57,21 @@
 #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
 #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
 #define REQ_POWER_DOWN_PREP			BIT(0)
+#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
 
 #define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
 #define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
 #define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
 #define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
+#define NOC_LPI_VCODEC1_STATUS_DONE		BIT(8)
+#define NOC_LPI_VCODEC1_STATUS_DENY		BIT(9)
+#define NOC_LPI_VCODEC1_STATUS_ACTIVE		BIT(10)
 
 #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
 #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
+#define VCODEC0_POWER_STATUS			BIT(1)
+#define VCODEC1_POWER_STATUS			BIT(4)
+
 #define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
 #define CORE_CLK_RUN				0x0
 

-- 
2.34.1

