Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA7338906
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348623; cv=none; b=kcbQItbXVe8VwO1204HNMhDtjI4Gwscq8cpT/s68JFYifPE/xRR0IZioEVJREMWZG+xtXL4SE7tq0Zd19LaLlx3ezWexBvk8wB+LS9KPWmW+hNYCISkOFE7AEQcLm+yV/1DFCVNC/tpgA0gd/mpfstAceCQ1E9AKgGOdVIwXM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348623; c=relaxed/simple;
	bh=LCMjOJtIxtHep2v0soQ3sUv2MXiTZMrsIoi3l55k2cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCsU/C95t9xY586dvHDq4W1nqwtF5Re8blHabxM0gCYnDtoK45TD2I3dob961VE1sNyORKO16GaAYBwwoRJVdh9OXPZxRShq4bw6DneDNComZTnTUcinDjl9xHWf5kgo0IoNOlue0ushCVIahqVU/AzxUuKkS4vklz1/A54p+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J6S9AURY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RVwg9jyT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6S9AURY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RVwg9jyT"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RNrtLw440995
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nayjuY7g5QVFWHFlaeUOOsPyzRCe/yAlG6cR/ITXMU0=; b=J6S9AURYZUukv+Zr
	gyWrCPTdgcBCVMGUW/dKCj3a+BTfRkxT4PB/7JZwydxo5q4lKeJ/9yG+/8bBouqf
	C7c5uBYCs65Ni+BQlyB02uh5PeIVRPuwqK0iL2M1qca+s8qAp7gugAT8aJDzMfaK
	0wa5lZ0x0+BVgTYK2EQuC906ZBwV+ibG43FnZKCjFp+YREHv5Fa6hjNIdr5sCemt
	KHhc181lKEAUUVN47C9HSGcXGyY9grVDLMs+nlNpPfFxPxQKiciWvYyGVk5sJbGh
	hIiL9WiR88B4dU54V+6ZoTJvgM4luA7kOSfDvderK7fLc0egj9js8nYbjXtTb3+j
	egBXiw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac42ga4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:57:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so11965236a91.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 20:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777348620; x=1777953420; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nayjuY7g5QVFWHFlaeUOOsPyzRCe/yAlG6cR/ITXMU0=;
        b=RVwg9jyTxIFIGVKT3qy+16ZWvbcXNeGScXES3gnV3Gvr0LyzHNlNo0N7odiUjZyzzf
         GU/sFL400N2V5RS11CnrDiioUFtgVvNZEXPGW1MoCBKx4A/oxsXjXlPDcKxvm33QFzLV
         6Dfx9/6vrornY7Zx4+LKsbsmfqh6tW2Yo8HlhEZSVdh9siMtd916V780+n+6NLMhosSg
         +ZbIszjtgONFIppEe42mbHbMTFWNeyMSdLQhCBSV4kpAzyREQ5UooyNAhPLxGSy9Kn+S
         pPKIxMjKzO71LmmUtck+6v3NBUXRisEA6i2H7CitMvaMPQCPMHNmLqPEuVJwxY544S5V
         NM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777348620; x=1777953420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nayjuY7g5QVFWHFlaeUOOsPyzRCe/yAlG6cR/ITXMU0=;
        b=QS0q6WObmjkysHYBOr7FYfuiz2QNTvFXyGtls7stTvaFq7v+8rCWqWoRAUL2yVrYWx
         UksM8SAaUhP0IgSy6eFR3+rj8WP5dS04+AYGMEBUNJe4XML7ei/w21/PJwD2c2MvzRDe
         7t8VO/XInhOi2oLk8ydEGhgcKyB+5gINlYC0g+ott4FfsR5275aJ0uPJ12aoT8twWAw5
         e887S+6264kkoxx4Xr8emBHuPcLc3S13fhXZUqaowl7yOWsp5fGx1iyfebr/brVYg655
         m4obgoePB4dKCPmX8FUA0hzUH5ucypY5wKzUdBJAD021lWNCehggGxh1n+47cY6BLFG5
         JKyA==
X-Forwarded-Encrypted: i=1; AFNElJ+HpnKcIt2EtlNeJh9zKU9E5/o+VV84PSLcbx8MF6e0lojWWu2+rirbT+hTUpEyijuspGIA/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv627cFFxtg92XtxPq+eXJAhx2PJoFZJX5sBZNJsP6CRJAnHAx
	tjK6BGLfTXGyKk7pUZHHesh0J7HT6SP7mGbL/FsL+8n+SnO9yBOrompY1xW/x8QSeal1SH1qwij
	Aq+c34RLdyqRzWClHc9+blmemQUvwaJ1Hb3Mv/TF0fIAv3zwI/4p7NEpExg==
X-Gm-Gg: AeBDiet8+1ABVNaijqxujC815UtBlFjKY6jacAevGpKS1o7X5PNI10fVHe12UmiRVk5
	yXDT7eVrhSzi+va73lRL6Mm6ZfxvtSo6vvdQakXhl1LHg5/nTPd8cOIKLH0WM8SLvfNheS7wYu4
	R5G0rxiD/wtT/xm+C9OAWjlEzZAVUd3j59PG+ammx9sAwd71w3z9eFO2o/OspfpTzvhaeWpr1LI
	0l4OT7wK9p5QxITxEwF9aDLZ10RW2nJooGkWfzbpC2vqewJ9aHKzLU9rUCiCpxoMviq3mG7Dk9u
	fuKUvz3F2DnQar7+dUrB5/+ZkjPCkR+3jbOmWe9NPImdbXq6hUUUspEPPNkbFZTWpMILmu8k1Kx
	5jq1zrA5KToUxSgxXAQqs43WDl9YcnDvyjBN+jyDA1z8OhlUChNIymyDR9GZyhZrU5Q==
X-Received: by 2002:a17:90b:498d:b0:35f:b4c1:91ea with SMTP id 98e67ed59e1d1-36491f5c2cdmr1037686a91.13.1777348620135;
        Mon, 27 Apr 2026 20:57:00 -0700 (PDT)
X-Received: by 2002:a17:90b:498d:b0:35f:b4c1:91ea with SMTP id 98e67ed59e1d1-36491f5c2cdmr1037657a91.13.1777348619642;
        Mon, 27 Apr 2026 20:56:59 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490905648sm393888a91.4.2026.04.27.20.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:56:59 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:24:15 +0530
Subject: [PATCH v3 09/12] media: iris: Add power sequence for Glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-glymur-v3-9-8f28930f47d3@oss.qualcomm.com>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
In-Reply-To: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777348550; l=8487;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=LCMjOJtIxtHep2v0soQ3sUv2MXiTZMrsIoi3l55k2cY=;
 b=nfjm7b0evT/f9tkaR+ncTOk65SzCNldv27EHYSiOAFWi+CcZGjjlr0a/dEe7O6QIg4NO/KD2z
 CZlA/RgPIBiCh+Q/HGDIo2y7yORAcKaK9Qq59D6/UwaXwMfzHGSASt3
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: PjSiiRnYql7LP7ByY-5nyNiv3el2A5gu
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69f0300c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Js87xDwMZ--NYW6i2EgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: PjSiiRnYql7LP7ByY-5nyNiv3el2A5gu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAzMyBTYWx0ZWRfX/08RuwbPyosS
 RKCFMaTDl6Tt4ib2i2mH0NExEhlhUQiILTO8Bcj82OhsAFfNWu7+nikLfNAbvKEA6Ey7jBaxg9t
 4XfyNj+77U4dXmlDzzss0z0NCBWeosBSP5hDNkEgN61jcGnVyFLgAKaq13b79dYbWus1umHhwbw
 CjRq5sX5i0Rcc2Qxz4gBbFTcSH2UiCIcwWVqQ6k/TCXsUfi5zf8CVFVkA5HegS2WM3h14uV79bZ
 j3cgGmuey7Hx/PabJb4I9T9Y17VMp5FkM+pD1VHdk5BfSCHYdBiu3C5xJH/r0hGoZMGnODKmZ9s
 SpH2knku+2lrpVbGfeUQ2TWzhrrOmAcfTa86rBTr0OSB0esK3ANggTPtup07zyh8z+P/l8f3tkF
 /XbvivrJouWdH4xPD9qYNe/4S3uiPG1lOqEDCX3GqxdI3eJBAy7Brb5h2iLr+pTDVG2s9T6dYFt
 cptz+2HSfyHPxqh1I5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280033

Glymur has a secondary video codec core (vcodec1), equivalent to the
primary core (vcodec0), but with independent power domains, clocks,
and reset lines. Reuse the existing code wherever possible and add
power sequence for vcodec1.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |   4 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 122 +++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |   7 ++
 4 files changed, 134 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 7d59e6364e9d..8995136ad29e 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -61,6 +61,9 @@ enum platform_clk_type {
 	IRIS_VPP0_HW_CLK,
 	IRIS_VPP1_HW_CLK,
 	IRIS_APV_HW_CLK,
+	IRIS_AXI_VCODEC1_CLK,
+	IRIS_VCODEC1_CLK,
+	IRIS_VCODEC1_FREERUN_CLK,
 };
 
 struct platform_clk_data {
@@ -210,6 +213,7 @@ enum platform_pm_domain_type {
 	IRIS_VPP0_HW_POWER_DOMAIN,
 	IRIS_VPP1_HW_POWER_DOMAIN,
 	IRIS_APV_HW_POWER_DOMAIN,
+	IRIS_VCODEC1_POWER_DOMAIN,
 };
 
 struct platform_pd_data {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index a9f43dbfc695..bd70d1c0ea76 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -27,6 +27,16 @@ static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
 	return pwr_status ? false : true;
 }
 
+static bool iris_vpu36_hw1_power_collapsed(struct iris_core *core)
+{
+	u32 value, pwr_status;
+
+	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
+	pwr_status = value & BIT(4);
+
+	return !pwr_status;
+}
+
 static void iris_vpu3_power_off_hardware(struct iris_core *core)
 {
 	u32 reg_val = 0, value, i;
@@ -260,6 +270,110 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 }
 
+static int iris_vpu36_power_on_hw1(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_enable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
+	if (ret)
+		return ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC1_CLK);
+	if (ret)
+		goto err_disable_hw1_power;
+
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+	if (ret)
+		goto err_disable_axi1_clk;
+
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_CLK);
+	if (ret)
+		goto err_disable_hw1_free_clk;
+
+	ret = iris_genpd_set_hwmode(core, IRIS_VCODEC1_POWER_DOMAIN, true);
+	if (ret)
+		goto err_disable_hw1_clk;
+
+	return 0;
+
+err_disable_hw1_clk:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_CLK);
+err_disable_hw1_free_clk:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+err_disable_axi1_clk:
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
+err_disable_hw1_power:
+	iris_disable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
+
+	return ret;
+}
+
+static int iris_vpu36_power_on_hw(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_vpu35_power_on_hw(core);
+	if (ret)
+		return ret;
+
+	ret = iris_vpu36_power_on_hw1(core);
+	if (ret)
+		goto err_power_off_hw;
+
+	return 0;
+
+err_power_off_hw:
+	iris_vpu35_power_off_hw(core);
+
+	return ret;
+}
+
+static void iris_vpu36_power_off_hw1(struct iris_core *core)
+{
+	u32 value, i;
+	int ret;
+
+	if (iris_vpu36_hw1_power_collapsed(core))
+		goto disable_power;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+	if (value)
+		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
+		ret = readl_poll_timeout(core->reg_base + VCODEC1_SS_IDLE_STATUSN + 4 * i,
+					 value, value & DMA_NOC_IDLE, 2000, 20000);
+		if (ret)
+			goto disable_power;
+	}
+
+	writel(REQ_VCODEC1_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
+				 value, value & NOC_LPI_VCODEC1_STATUS_DONE, 2000, 20000);
+	if (ret)
+		goto disable_power;
+
+	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+
+	writel(VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
+disable_power:
+	iris_genpd_set_hwmode(core, IRIS_VCODEC1_POWER_DOMAIN, false);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
+	iris_disable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
+}
+
+static void iris_vpu36_power_off_hw(struct iris_core *core)
+{
+	iris_vpu35_power_off_hw(core);
+	iris_vpu36_power_off_hw1(core);
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -284,3 +398,11 @@ const struct vpu_ops iris_vpu35_ops = {
 	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 };
+
+const struct vpu_ops iris_vpu36_ops = {
+	.power_off_hw = iris_vpu36_power_off_hw,
+	.power_on_hw = iris_vpu36_power_on_hw,
+	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
+	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+};
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index f6dffc613b82..99e75fb4b10d 100644
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
index 72168b9ffa73..37f234484f1b 100644
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
@@ -52,11 +57,13 @@
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

-- 
2.34.1

