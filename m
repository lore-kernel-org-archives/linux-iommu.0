Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434E143895
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932586; cv=none; b=GGT1JC4apD7GgxDyzcEBW8HBL43ny3yunE0lQKNh4nUWu+n728p66vfFg6LEtlBzxCNJOIdg4Bqp2JAdrcVECRmlXe+UPBAgS7mG/o4IOwHpz3rBD3VKhOAsnLbC7OWSPCG4CRiuWuQzS0/dR/fLHabHS+3u1jvvxKaGKrueNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932586; c=relaxed/simple;
	bh=+1no2bmgs6MuDDaz2UkyIJNIWjs3RXM03IY6VUWb8zE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfhaXiHAXlsnzvaS566vVqs3P5fIyZo4dMsHcYNwL3uzSqanZRcwpGZI9PLvFmd2LFEXht16ZlqY+u1fykSEo4UFft0B5BZDG1kn5sJjVKe5Atnvj5xpJeOtkX4gPGGa7FdVin9flVwiH+XrYCYsQ8FiOv4oNErVRU0uAXIWk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HgkCKrnR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HgkCKrnR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKD2Wp027243
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M3jJd3tpX3la7lvYFrEWmDfyU53nCPlZfvukoqDcIKc=; b=HgkCKrnRkEXVNI8s
	CHxAXl+4ndGbelDBH7FRvwMHOELZPsaghmVm3SvPdy3I7CveLo+0Uf5KV0WvCQYK
	Xw7fiIGgrc6JJWEq/5kyB2g8eQmlGM8JXOQTQpv4W6tTLjMK2AQFoIciUWJn+R8X
	4gZXU4a5/mZJ2sKiKqgMWAQjpffmQNqCbxOCI+Ym5NFrneCSCQYBp6l+iTvTCK1c
	yaaMzvRamw18Jn+m8Ni9/8qq2blYO7mGFBKnktYPuSfQVvtGUXF3d1NDRmKWJwa8
	/4AoLQmUQIV9iSubG/yF1ou7uAVQbe2T73WmKdGsKk3uW8NuL3fez4OZ9gATADxf
	zMCZWA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c67314s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f99a9524so58594706d6.1
        for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 23:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932582; x=1742537382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3jJd3tpX3la7lvYFrEWmDfyU53nCPlZfvukoqDcIKc=;
        b=nCASlVZlsQipEOn7WTW+KXokUs3oYwO0ep3SjhEqKbEW8Ak/R8rY7Qs+rW4wFK6EIc
         DJYXja7ZXTV3wURBLW849EFWJBsGLq2EGI+7kbjq7naO2nnE1Bii+pK0XKDrFGbfpQTY
         1REKkmem1K0bZWDhXM1yO4fKt07sT8V99zIvTXm6d9GxftaSceBUr8yPD78gW1O7y7ic
         BmY3hCxQw5RSKh6AL4tfTgbDNx7ffGzCUIkL2cVjklrn34tAwZlda8GCiBNA6AJMzGTA
         IrYmwNtpgd7ckZ5g/Om/n6il9a0JTyYtYdvtNATRVlhSKqzPTUZFnmqxvLD+fcnGNSF8
         vmmw==
X-Forwarded-Encrypted: i=1; AJvYcCW3C2T+e9736ztBy1LcRQmYewCDwFCPWYqGNLzRWhYxBmAk4TZld91mwiRx1DPHxquJUOo8cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8H1S4w4wXX07PzH78Bpl0iJgC7+1qud2Viat0bkj1s9eY4Hf4
	rTbc/Hwjb92D6nW5pyaIOCg0mOSE1OL9+zoJjqDlcN77tJvJJVrWVbHJ9m74vo2l6QCYQvNN30K
	Xf9riQwsgCvZdLiRThcHZ2Zk8y++WInDa3cVvK21gSnDWJwmqHnIanw==
X-Gm-Gg: ASbGncvR9W4Hjz+HHoad8dNsQ5opDH6mHOm349IUQQjcW/ohJG79Hsod/si8Jl5M/jb
	ANQhGbTjPEtZadF/aKdxKe1yNfh+bQxQk2ho0N9wxG1f1c24MUAnFG1mGRhMz8G9dEeWZ4seSJG
	ArS1iGNDDsTK9BFBrLbJM3tnL4+o3vFi79yHWynW2EbPL0cR6Z7gX5mtIIhfD5/iIyUMqQN32lK
	8UqhMtvzePmAJ8qzIbdslWMbDkaMIEro/L2VtxgFFwwTua/LXJ9GBtV6bg2OOwtREoRxjBlbmbE
	pqzdzxSXw76KQmON3OqkmwR38k+XqwjZB2DMju5LwmMdCQy3H92WTAw0tU0IjJ+N5JD0iWCiDZB
	tyHxTVzG0+FLXbfxcPrZPEvskL4o2
X-Received: by 2002:a05:6214:1c4c:b0:6e0:f451:2e22 with SMTP id 6a1803df08f44-6eaeaafa79bmr18386536d6.38.1741932582141;
        Thu, 13 Mar 2025 23:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdy85Az0BFFloM0U6HUBaZxntTOQKaC98HjD5Qejk7+ISkyOrH3J+3xA8fyW8pV5ZIOnXblg==
X-Received: by 2002:a05:6214:1c4c:b0:6e0:f451:2e22 with SMTP id 6a1803df08f44-6eaeaafa79bmr18386186d6.38.1741932581805;
        Thu, 13 Mar 2025 23:09:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864fc9sm416071e87.140.2025.03.13.23.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 23:09:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 08:09:11 +0200
Subject: [PATCH v2 07/10] drm/msm/dsi/phy: add configuration for SAR2130P
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sar2130p-display-v2-7-31fa4502a850@oss.qualcomm.com>
References: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
In-Reply-To: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VXFGPbLULr+xGELX+USGVkfaqafdytyi08lrC/x1doQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn08gHu7VUjIHtul+wxL2ybBPEIT8rQRZjEZQNI
 32ETlvPPXiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9PIBwAKCRCLPIo+Aiko
 1SaVB/4g7JEQIBeoQAy0cDDI5FulI03webpAvajYmd3kIOIMKR6sFGTSZa3yRsGN1kWJcJPbf1a
 XXI00xIGLQ+h2SGagLwcRCt+f8TB6e3V2DJhDmWCM6KDTfOTidQmaqGf2I0BQuiagdVmkkkG6el
 qrrznY732XARxFGFJfjtfh4VaOuUyVpeUB0cmOHYuhA4hM+56cKdc7FdPU8ZeZhD+52HmUf4mZZ
 eOk0UOui22lH+ymydH+uq4/+3X3EqE08vUWJHkKV8487ji+VABuCbrja91m8QwvlhaqiXxwIoH5
 5UcWHGg8o9DcQYbY7gl/COHri/PrRMVMfdI60xlFW72HFNsi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d3c827 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=WWvJJprN3eueWNfT7O0A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uyREBBslB9xcd_6qsUtajmaCl1TSGfrx
X-Proofpoint-ORIG-GUID: uyREBBslB9xcd_6qsUtajmaCl1TSGfrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

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

