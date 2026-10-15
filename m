Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA51499F0E
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050068; cv=none; b=KTvzWkr7cDcDpymsE1LcvSidmHm6nrbvPrXeujl9pST6bJsfGHZ78+phq2NCdoobmIbSLLGGAzyYFMwwhvnjlyMfYocZH8UNAdhKcZDrxKAuSwL6W9cz9s52K0R7VD88d+HmSqlF+0pyBjJVZdT3Jvg0dacYh8VjOUy3hfS5cWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050068; c=relaxed/simple;
	bh=QfsW7p+EnqCrkp5VxF7nJpn3yBDQp8WAB3SXDfvEA80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1l2Y3qWeWOO1602FI3f+oxyDUkb0xMqAjt5pWStNvT/p3ePM7vzC+hjIHKJEoCQmeYutOk5/HcwUU30CqW5TLO8GljdslXargknn8DWjIb1I9oLeBQ7yrdLdgScYdlNVJcqXp1dtg2w9oenEfk832aIwCOvCdsJ5+82S6z/OVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TgTPp/fi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vh3O38Az; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TgTPp/fi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vh3O38Az"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F7CSHg1672218
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZMJcSwYy1VxSlOobjS03qaCfSpehSXjZPpHWNlF8RAI=; b=TgTPp/fiRJ02OnRu
	K6sP8iGeHpxZs7FtrEExFRzxz2OvdVxz7HKeaEOG5e++i4RD8tRD/diWI4ydxkp/
	I4nGpFcSIj1e9UZeVtRQDYDAO6aeLHweGR90tTUY20TbcYh8XIeTFwwPsysK2SIu
	k9xiLQYll0k+VsVISRPultioYj1jE9mLbrMLffAPRWWUu4ic2WMPqhcoME79hrTe
	KLb9Ze6YupQ0TzCJyh7AL4eoen95eHVI/Lk/22GMC/HJrhPWRbMtQBibHLXJ4CRR
	qULsSlnZo/UNM2Przc1S2/JE0obAq/1zDbIlKAtR6qxHBb6enil/2OEDXFxK1jKT
	07BrkA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrhb68a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:41:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e954d87b48so14229405ad.2
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792050061; x=1792654861; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMJcSwYy1VxSlOobjS03qaCfSpehSXjZPpHWNlF8RAI=;
        b=Vh3O38Azl+UcoaWh8id12dc+TlYIgkniu1PcSdEtTQsWuo40aojNnqirz9aVfFlkx7
         bMT3QT0A89qNOkULdTipI8tZJgk9mkUS8bTMqbu6OIIvvYEuosF6qfiohXD6Z/IbCeF3
         5+wA7+RwOtHtuY1p2A8dlfTYrb0PwW65u4meLjU8lFDEykj34fK7Wy6B1a+Qkj1XE2q6
         ZsiqrAChPF1XOKX7WlUoOe8ntjBh5rCT+5UNpTulcA7ht6a3rb1uoUcm1jYbFbPU4vmD
         ybWuXdkldGs5j/G0HeN7Z0wU6jyE7lSr6uqzakHU1rCuSlnKxwJUnwggbGzpqbiGw6Bb
         4pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050061; x=1792654861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMJcSwYy1VxSlOobjS03qaCfSpehSXjZPpHWNlF8RAI=;
        b=MWhs/31hHgUAHAaHWAfVTd5aGIWJTbGZfqC8vo8hqX0SrFEVaRTn7TtWmgoFxMCpMa
         Y7Cnwcelbtuq48q4L0CUXDgaCwnUkbXheL55IkMJ1z2oQ0990AUR2cjL8R7Hqi+/5INu
         +vpiicHy2jMSu5Q54UdUDk+c7s+2usSbCCRqyh5eH4wSyb2q78fpxYH3veDda9bmqH1F
         QoFH74xqQ+kZeYOeoiLgvuBW5a2dNKzasDFvl86pKyGx8za8q1dvijKiF5XIcFalr3qX
         GYQJNjABCFXTqg4lZBjC+knTain4KEDgWALvPRxRUUfWlMyvBHvsr4o6SgLiSGzm8eG8
         8Tvw==
X-Forwarded-Encrypted: i=1; AKwUvBwCd0k2zhQ1uOMDABCpGevhVyGap0V8iYA2cw26ZlYFhcCl6Nz/Q7INu/M2zwj+6c3j30eg5A==@lists.linux.dev
X-Gm-Message-State: AFq9FYIDf8kaQ/V6TTP10zMpSAGT4bGofHXhMaFNeB9b99uRU5Nv3CFE
	ngUMcuV1rAYr3/mafTaw1NqknM2y7FqANUCfV+2k679bRMRNhtpgM37gi6ZPW8OfAWSTeSlv67d
	FMJWFMm0MbfgMPkWl1Ta2swaGaNGwertOc7c9FcCsuaZ1S5Frk+5Evku8pg==
X-Gm-Gg: AYBFou0fsAbiSH65HeAbgrI4tk/i7FlHya+LXanjA9XdYO149RAihLEV4cyOy2cFBI4
	kcfHq5Ecm5NTAXJyCugionsbQS/Ard2F4g94h+daFoYKstVeYleWjUGV0zzBO7692fUOWuZP1tA
	Ik7KzdCTIGevdQYYHcs88OU2+n0iP5JGDhvcpr/OSbQlrbMYDbxYr44aYYO/5o2gzGdtw3i1hHd
	2bRKKJp9ECZH7OZT+NpFuSHjjyId48t7Wh8JLlHCfFbPMHitD253IPgToRNCttkYHf8MYMR0WT1
	qIYwbMeMJWolxA6ExWT0pMksAEU8Zrz5dMceY4hNyjWt+G+9+d/4zFpuioNpWbgnmXNDgnwwg0G
	weTwlwl/2+ix0C00YnRFQeh2jkG6kEIQz6n8=
X-Received: by 2002:a17:903:230c:b0:2df:4876:50d9 with SMTP id d9443c01a7336-2e8429a58b9mr173469145ad.18.1792050060828;
        Thu, 15 Oct 2026 00:41:00 -0700 (PDT)
X-Received: by 2002:a17:903:230c:b0:2df:4876:50d9 with SMTP id d9443c01a7336-2e8429a58b9mr173468885ad.18.1792050060272;
        Thu, 15 Oct 2026 00:41:00 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:40:59 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:33 +0530
Subject: [PATCH 13/13] arm64: dts: qcom: hawi: Add DCP support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-13-48aad0fe4f72@oss.qualcomm.com>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=6156;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=QfsW7p+EnqCrkp5VxF7nJpn3yBDQp8WAB3SXDfvEA80=;
 b=JxMeN+DmWGewFKBEVzcKUqFUkqoSyxqpGwErK350VoQIwFKd+fbhLmrtRxjrT83vph7NHMhD/
 kefG95krZ7aB85pcavRl2PIXjyPSamuyWWB5KyY+6SVKlJroQsTCpRq
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: LdWN2g2gOAxMkBXXxPpG60FlUVrp8_3-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX7o/u2XVWFiAq
 hJ+Lnk9To/RrxO4lQUiZCxgq8c8EGoVOlzFbeTvlo9BTRwHfGqCDoy9rLatZAr1bnSoFtOI/MTm
 PELOHEe8eeV1tEWEEhfHwQ8drqy1SSU=
X-Proofpoint-GUID: LdWN2g2gOAxMkBXXxPpG60FlUVrp8_3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX0E6vE6fl0cGb
 kDC1WqLTZqwrbD29kuu3Jp2Bs+wpnZtsCG2bpjgVTslXo2jVknqOiHuc4KH8lgyKnBJV2Er5tzr
 TzBpwN9/xFsXodt+wH2q829jWkx4eDTE8Qe1WeFbP5MFBLU/jj3qPycn9GvWEW0Mi7J0TixGkvc
 v3GCbJdCn2c8V2cctF/+SAQjPaqfArar5CTOwcBnpKKhhIrf6nC+XfSpx6sEUDxI9V/1kXMTHwV
 u4+E3at6n9eIrJ+UxIiChIKrCIcJN8J6Nl3ScgPDIaexJl2VrSMOHsinODdh69cSSNQ3jCaIzJY
 qT/DAwwVUdAl+Wjt6f6Qi6PtyAZRKT59DACZ0X0vxBvRKWYbdftMKdEy1B0T7PFgZzyFY8pHiu1
 Z2KEg9Ts20dhu2LrVAtLQwLohSs1j7W2VhkXB6ppIkbCdY8zg35lpWdoY9KLPiEqnR5f+LTH53Z
 1xfIcMJhGmJyDXPu+ng==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6ad0838d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_CzEFU3RdQMONSqgxRIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150030

Hawi display hardware is owned by DCP firmware, so the platform device tree
must describe the VirtIO transport, firmware display function, power-notify
channel, IOMMU contexts, and display graph used by the MSM DRM driver.

Describe the DCP VirtIO transport and function, IPCC channel, IOMMU
assignments, firmware-visible IOVA range, and DSI display endpoints on
Hawi. Enable the DCP display device on the Hawi MTP platform.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 arch/arm64/boot/dts/qcom/hawi-mtp.dts | 131 +++++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/hawi.dtsi    |  59 +++++++++++++++
 2 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
index 9c86e0477053..03e4cc117109 100644
--- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
@@ -36,6 +36,18 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	display_panel_vdd: regulator-display-panel-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "display-panel-vdd";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		gpio = <&pmd8028_e1_gpios 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+		pinctrl-0 = <&sde_disp0_vdd_active>;
+		pinctrl-names = "default";
+	};
+
 	clocks {
 		xo_board: xo_board {
 			compatible = "fixed-clock";
@@ -261,6 +273,7 @@ sdcard_vdd_3p0: sdcard-vdd-3p0 {
 
 		vin-supply = <&vreg_bob1>;
 	};
+
 };
 
 &lpass_vamacro {
@@ -271,7 +284,6 @@ &lpass_vamacro {
 	qcom,dmic-sample-rate = <4800000>;
 };
 
-
 &q6apmbedai {
 	dai@40 {
 		reg = <SECONDARY_TDM_RX_0>;
@@ -1277,3 +1289,120 @@ &usb_1_dwc3_hs {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
+
+&dcp_dsi0 {
+	panel@0 {
+		compatible = "novatek,nt37801";
+		reg = <0>;
+
+		pinctrl-0 = <&sde_dsi_active &sde_te_active &sde_esync0_suspend
+			     &sde_mdp_vsync_p_1p2_active &sde_mdp_vsync_p_1p8_active
+			     &sde_disp0_rst_1p2_active &sde_disp0_rst_1p8_active>;
+		pinctrl-1 = <&sde_dsi_suspend &sde_te_suspend &sde_esync0_suspend
+			     &sde_mdp_vsync_p_1p2_active &sde_mdp_vsync_p_1p8_active
+			     &sde_disp0_rst_1p2_active &sde_disp0_rst_1p8_active>;
+		pinctrl-names = "default", "sleep";
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&display_panel_vdd>;
+
+		reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel_dcp_in: endpoint {
+				remote-endpoint = <&dcp_dsi0_out>;
+			};
+		};
+	};
+};
+
+&dcp_dsi0_out {
+	remote-endpoint = <&panel_dcp_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&pmd8028_e1_gpios {
+	sde_disp0_vdd_active: sde_disp0_vdd_active {
+		pins = "gpio2";
+		function = "normal";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <2>;
+		qcom,drive-strength = <2>;
+	};
+};
+
+&pmh0110_d_e0_gpios {
+	sde_mdp_vsync_p_1p2_active: sde-mdp-vsync-p-1p2-active-state {
+		pins = "gpio9";
+		function = "paired";
+		input-disable;
+		output-enable;
+		power-source = <2>; /* 1.2v */
+	};
+
+	sde_mdp_vsync_p_1p8_active: sde-mdp-vsync-p-1p8-active-state {
+		pins = "gpio10";
+		function = "paired";
+		input-enable;
+		output-disable;
+		power-source = <1>; /* 1.8v */
+	};
+};
+
+&pmh0110_f_e0_gpios {
+	sde_disp0_rst_1p2_active: sde-disp0-rst-1p2-active-state {
+		pins = "gpio9";
+		function = "paired";
+		input-enable;
+		output-disable;
+		power-source = <2>; /* 1.2v */
+	};
+
+	sde_disp0_rst_1p8_active: sde-disp0-rst-1p8-active-state {
+		pins = "gpio10";
+		function = "paired";
+		input-disable;
+		output-enable;
+		power-source = <1>; /* 1.8v */
+	};
+};
+
+&tlmm {
+	sde_te_active: sde-te-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_suspend: sde-te-suspend-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_esync0_suspend: sde-esync0-suspend-state {
+		pins = "gpio88";
+		function = "mdp_esync0";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio211";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_suspend: sde-dsi-suspend-state {
+		pins = "gpio211";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
index 0926d880cb0c..58fcf42cbaba 100644
--- a/arch/arm64/boot/dts/qcom/hawi.dtsi
+++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
@@ -8235,4 +8235,63 @@ timer {
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	dcp: virtio@9be8000 {
+		compatible = "qcom,dcp-virtio", "virtio,mmio";
+		reg = <0x0 0x09be8000 0x0 0x1000>;
+		interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
+				      <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "virtio", "dcp_power_notify_irq";
+		iommus = <&apps_smmu 0x15a3 0x0>;
+		iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
+		dma-coherent;
+		mboxes = <&ipcc 13 5>;
+		mbox-names = "dcp-power-tx";
+
+		dcp-subsystem {
+			compatible = "virtio,device34";
+
+			iommus = <&apps_smmu 0x400 0x2>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+					dcp_intf1_out: endpoint {
+
+						remote-endpoint = <&dcp_dsi0_in>;
+					};
+				};
+
+			};
+
+			dcp_dsi0: dsi@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dcp_dsi0_in: endpoint {
+							remote-endpoint = <&dcp_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dcp_dsi0_out: endpoint { };
+					};
+				};
+			};
+		};
+	};
 };

-- 
2.43.0

