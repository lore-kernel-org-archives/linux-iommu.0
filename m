Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFD24BBE3
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845412; cv=none; b=etzFjft64sbMerJCAaDS8DITJ+RpWvooGmAw9g1zzr9OjDYowBaD5LFofJvKzBgyLjQQQJUdo7b6JUP+GQDgWvZWfA44BRAxNnxAX4vh5/Ga0LSljUT1Oai16ysSIS2OoTkRk0i9MOkqBWK/BukSwte/rx30HnU14R+z3okxj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845412; c=relaxed/simple;
	bh=uyn6rjWTDHITUowJs0zdqs419FlfeMOd6EA+lSArPGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g177C+EcHi/aFqYX341JDl1q1yPSCJ1R/iVhpnx/8cvCOaoxtF6y7y8f8jEDlg/ah6XDzYi+xzyvT++wRuW8TRyckhldZ4OIb5XVxNgd7UZOjS2nMUGE0bMRcATEW0UAb7ysBg3KdBNdr1c3Sby/T1UC5SZqGXosDhCcb7AaLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N593PHj7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N593PHj7"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GL4rlE003388
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YjXjlNJQjaowHbkG3YqM6O2XdQTkytP/jZ3dM3LDh3o=; b=N593PHj7lb9uaoSn
	2yDmFNMqk3kHsQHYP5RrxmAJ5SQtex5q1rsiJbwA9VXKwY1SKAl0TmoRfeesylxh
	JOZdFnfMDRCICHFhY1XT1/I8GT92FX3quHTE98hW+Mti2LCEqL6uRzwfU1B5b2wd
	sgDP9U9nuoGaZZs9VcAvLDBMhlEsf/GuMlTdxfGwrAvnW+Jva4fQ47sq2c00nJlj
	m2YzY+9jq7gSrR23en9j7OtLJk1xy4sIX71bQI389LxGHWkQKb2i9JcRpTTP7EDA
	6GUNX4l52/B1EI8yR3/tc9K6HK2N/5HHA3UyniB9yOlTzvxZFL56PRVOXPoOkEQK
	ETznbQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rva9ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f2b3e4c176so5127746d6.2
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 16:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744845409; x=1745450209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjXjlNJQjaowHbkG3YqM6O2XdQTkytP/jZ3dM3LDh3o=;
        b=a3ivigeNN6m6g0Ru3tSg5HSct5IPA9JxL7dkogcTW5z99Jyl0T9vUjjCwzYwNpcE/z
         FyeRHGjfYrDnj9zH1qhxkHyWWtq5DVu5fdwffs0S0jUldEPOUqYGbs06wDJBSxKlYQcf
         ltZ0mntwocUa/fddjNTTAaEN2QtD1b8jTMoanCReMIF5rKLSf4uGNUe/M+NMLByyMbpz
         unEMVz7+UsX6JfUWRsYasiXGiKuSnOPayRWP15r7WBjLgkhlZPkGdrsH4c67gWFSO7LN
         7zCUw/R7ZzX4HUeAK23FWpCDdG46JeD5cYPER9dN2aa/wd4yo4tqF4ooKVkyxd/dtttu
         MX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoZxS5LIYIpPZaNc/Y7VWx1FfKq7i3KkNLmytZfvMjJfu+HKcY1DoMxKjL/sRQZH2mFmOyfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqNZJM2IC9Yr2uMFVSgZh4/snWkmYOYYornfT6xSENy0mgRQuZ
	XLKM4XP4kcfyVWcT5sERndP8G4/Prh4zMwZGZU/d8UhgC6BRNUIFsDIYK+oHzVp1OzPF+bsBqgv
	wESEraae+femUNa5ua6JzrDEFsYvAOgmmWvhyTk9GzsoF5Jv5bzI4/A==
X-Gm-Gg: ASbGnct2wiuM8CbSFxTH3z5pCPnkAVp10sLlRIlTXjG67kBaZNc3eY7oUeG8rcZW6I3
	/abgtgmz4/A2URpVyJalsDPtar6rs9FjgJNMGtF6S08TWI7rOHJA32DAYsnXUYk/rRW7eq1hs7H
	hNin/pu4Xl4ztJkUlj0bz0cSS1/nqwgTA66EbHIRAcNOdSWgozCnsBaMrkGV3lwrc8lI95655Ir
	kUZPt+JfG+Pr5u25uZRze79hltjKBh/CPl2VH5cdneLgXHQMg/HmZygTF25VsJXuEUQw1CRtV1a
	RHJxSbeqmShslctMGtM7E8WCEupnoncR8eQ0vd9TyNCAIGBWdDZAABp++UKPMnuWcJLQqW0NOmz
	m7HY3Oq7QDnrf+8kPX/X7jnFc
X-Received: by 2002:a05:6214:4004:b0:6ea:d629:f48b with SMTP id 6a1803df08f44-6f2b2f8c036mr56999796d6.19.1744845408668;
        Wed, 16 Apr 2025 16:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHACeGihzRrlQwNhgr+NzzEELD/m0ZYzeMkwi6/AvAx3C4eMF+fzQjS55rUXH+D65GGTaEONA==
X-Received: by 2002:a05:6214:4004:b0:6ea:d629:f48b with SMTP id 6a1803df08f44-6f2b2f8c036mr56999416d6.19.1744845408162;
        Wed, 16 Apr 2025 16:16:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d79esm26062181fa.15.2025.04.16.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:16:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 02:16:37 +0300
Subject: [PATCH v4 07/10] drm/msm/dsi/phy: add configuration for SAR2130P
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-sar2130p-display-v4-7-b91dd8a21b1a@oss.qualcomm.com>
References: <20250417-sar2130p-display-v4-0-b91dd8a21b1a@oss.qualcomm.com>
In-Reply-To: <20250417-sar2130p-display-v4-0-b91dd8a21b1a@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VXFGPbLULr+xGELX+USGVkfaqafdytyi08lrC/x1doQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoADpRbItKtOvfBgA3iE+kocG+C9CBRrGEAri6h
 fYYQb1K3SiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAA6UQAKCRCLPIo+Aiko
 1VPLB/445ZF5iNl17cW8stRwyZhPMmPvoKLFrsYido7LywPAtey9Ia5Vku10J3mQdQS3x4PhhEW
 qMbE5RI/ypjDkjrRed1nlZNqj0uHydm/sKSrQHQ+Nk90Ow29IAZS4XsY30SZ/o3Bn2b3mRgvbAj
 jG5P9jz3gIJJkJx2LlSVgzT3NXSUNQJcSm3LsS/lm5vbk6CZfQ58EpxdoXS+4sZyOnPcSfVSBAN
 +QswoNLYkt0UMqbIQlZzn6ecXV9FGlLunbZzYUBVUzdxARTI3HWbJEP0Rv0Pkf/1/mTDuoNoOM7
 6nzfVxqRWTYbcMDuvUXVdXYhYYwMHI4v/LzTUXQ4qGBOeyQD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 4pmXotAUQBFWgER9_FL4GnoiKZT32Fuj
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=68003a62 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=WWvJJprN3eueWNfT7O0A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4pmXotAUQBFWgER9_FL4GnoiKZT32Fuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160186

From: Dmitry Baryshkov <lumag@kernel.org>

Qualcomm SAR2130P requires slightly different setup for the DSI PHY. It
is a 5nm PHY (like SM8450), so supplies are the same, but the rest of
the configuration is the same as SM8550 DSI PHY.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 23 +++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index c0bcc68289633fd7506ce4f1f963655d862e8f08..a58bafe9fe8635730cb82e8c82ec1ded394988cd 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -581,6 +581,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
 	  .data = &dsi_phy_7nm_cfgs },
 	{ .compatible = "qcom,dsi-phy-7nm-8150",
 	  .data = &dsi_phy_7nm_8150_cfgs },
+	{ .compatible = "qcom,sar2130p-dsi-phy-5nm",
+	  .data = &dsi_phy_5nm_sar2130p_cfgs },
 	{ .compatible = "qcom,sc7280-dsi-phy-7nm",
 	  .data = &dsi_phy_7nm_7280_cfgs },
 	{ .compatible = "qcom,sm6375-dsi-phy-7nm",
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index 1925418d9999a24263d6621299cae78f1fb9455c..1ed08b56e056094bc0096d07d4470b89d9824060 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -59,6 +59,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs;
+extern const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8650_cfgs;
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index a92decbee5b5433853ed973747f7705d9079068d..cad55702746b8d35949d22090796cca60f03b9e1 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -1289,6 +1289,29 @@ const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs = {
 	.quirks = DSI_PHY_7NM_QUIRK_V4_3,
 };
 
+const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs = {
+	.has_phy_lane = true,
+	.regulator_data = dsi_phy_7nm_97800uA_regulators,
+	.num_regulators = ARRAY_SIZE(dsi_phy_7nm_97800uA_regulators),
+	.ops = {
+		.enable = dsi_7nm_phy_enable,
+		.disable = dsi_7nm_phy_disable,
+		.pll_init = dsi_pll_7nm_init,
+		.save_pll_state = dsi_7nm_pll_save_state,
+		.restore_pll_state = dsi_7nm_pll_restore_state,
+		.set_continuous_clock = dsi_7nm_set_continuous_clock,
+	},
+	.min_pll_rate = 600000000UL,
+#ifdef CONFIG_64BIT
+	.max_pll_rate = 5000000000UL,
+#else
+	.max_pll_rate = ULONG_MAX,
+#endif
+	.io_start = { 0xae95000, 0xae97000 },
+	.num_dsi_phy = 2,
+	.quirks = DSI_PHY_7NM_QUIRK_V5_2,
+};
+
 const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs = {
 	.has_phy_lane = true,
 	.regulator_data = dsi_phy_7nm_98400uA_regulators,

-- 
2.39.5

