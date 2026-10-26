Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995947;
	b=LFFABC09D/DZSNjX28g+n6Y6yjXZ4BQ38USnfrL0AJFMy1KPIPVTvEOQFakRBGEOFka1
	 6JwJek6vHjgkt5Og3VcyVqqwH3b4mJ/d75rKAVUnWRUGeK6ffT8c797q0hU6KvjLgE1mG
	 AC5TST+43pa+NqCy0N5mvO028upMyuV9aeYAPO5IvAm3PqxsBN+iTVm88tOYxHarr6ys7
	 dnPsPkRidFpKh+0LVqkggaccYooO5P133xZcnFtdNyKuoaupmVlUwRALcAqR/NcT43p0y
	 99pAxOvkhdgZr/ZViDMeFgVgE678UnSNbhfZoRS31M5276QulHUpwxhPWSYCEssaPjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995947;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FCnvFyOtoxqBwa/Gstd7a10Uc74nGWW4NE9dwrU5Y1I=;
	b=eec06YIXgHTD+UqiGb5YgEa5lq7Yx2F9vQiEsKHtMs/SGWKSxT6pRZd+7th8KYc37Yug
	 IlPa3/ozfpQ8rZkl2c3f4AdpF6skMjZdq9/I6QsnYlLjX2IJmnnrtFeyvN+2KSd77Pa2k
	 ke2g2L5HuCDG49sBWD9qjRTmCO7ADkqLcaDtjr46WG+/2C1CcO37GaHju3Ad9e9ORifB0
	 dcKMBjjMS7YQP44otoJhnMS5WyMgIqdGMpzIlvc09bJHbDGeUg0/hoG+zPp2ZJovemiV9
	 6tKhvTZt+cxgsppwHe6RsNk2NckeeRbytEQEe8zw0IaQC+kieO1RuHhBl3tenxXy6Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AF2QO09t;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XA3SuI56;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02142606A31E
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02142606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AF2QO09t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XA3SuI56
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4bKup2255639
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FCnvFyOtoxqBwa/Gstd7a10Uc74nGWW4NE9dwrU5Y1I=; b=AF2QO09tuvUM3jqZ
	pSCUqmKrO4lnRGeBAuqNE4HoMghuuf9ANxMv2q8JOwcryBTLC9Rdf8xBqaJnQuD2
	GxzGJdBANbr4UO/monIXFFvfVL5AHC24jI1aFWk3VW46rDw58JNfR0rcj+EPlXRN
	eX+D/VAva651BTctxF+S3TAoiKqqevZaHryYBOLUUf2PMNqNVG2/MT9wGVifnsu5
	bAsE/AWM9z4BFjOP+UMzwbjTUK1qAIsVCcAkxym3FK2GwsDnT9h5QPpfgYR9vkK4
	YTl0r4uPspz5zb/WFIrbwBjxUNx2BBnbNRoQv9anEe7IewLpX16fg4kor6aj+mVp
	VEMIMg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3n1j9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e832c03576so52526785ad.1
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995946; x=1793600746; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCnvFyOtoxqBwa/Gstd7a10Uc74nGWW4NE9dwrU5Y1I=;
        b=XA3SuI56iUJsSgMizzk/5QaEakmEjFuncgNekPg/An3scDjeTmj73J7r5gWTl4M475
         F3ipomFmaTIkE2jKg0DkpNF7RFFodWTRhWNnp0Jo3uvvgnNJnSFHaP37x469GQN/5/P6
         CZ2KPsLp6n3s8ZSrq39JhYkr3jK2/cHq6HhGFsyVdVAAvgl47+NbO2gfR9Ffd93OLBLX
         dtz6WB/VB0XlnLlllWykZiK4EnzLAB/QCdl5uLCZv81XVe/ErtEXfxu98g+/Y56TT+8b
         e6VFgVKZrTzeoHGKiYSEfYhUHGEihX6L4ix1d/APhrQKdQ/Ww10RYGrb0cAcCgelfnMM
         7IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995946; x=1793600746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FCnvFyOtoxqBwa/Gstd7a10Uc74nGWW4NE9dwrU5Y1I=;
        b=BZSS9ucwq+aDfbPwDUWRU3LcFU7NBTxg3GGXCK9gt9jt7tRSBQ2UBmvmtXHBx14NX2
         FX+b4gV9sClUkzarf5gsx4S53O37OU8P/kywEldY+ttLgSirA6EfLNRKrXBgASItLoXH
         h/AMXwnP2LrKOqQWaaUXlCFY4MISQZm9BaGwGzew9Y+Z4S0BU2Fp2fI/EiYJ1vOpgLfj
         RLzRceGKmA9ylOVtm2j5UaMcSGzRoOQC15YG2eh3OfIfBJ0hqZES4kO43w3Y7MXU5yC/
         Iax7ePWv+HEUpxgwHv75VvmYWdmV/dmRPErPEgn3aCS7a7dYfkWRl5hF3TJX618Cf/gQ
         5sWw==
X-Forwarded-Encrypted: i=1; AKwUvBz59m77M9rqe8/D9r3K3niIAxagbKhraVaCOEuz0vdkfsjlvJmkcGaiXAUtxV05NvoG0JyaCg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIR3wnE8OexmmYPwOcHEHVJ3BZzvfoPKhmKBqBahOS/PP8TXI3W
	3vfv/6ERND7Lsr00SMYliJ0CUcETCXsinksgS21cF6EfuKhHsdyDHtCK2LGcYwSGBhDL+fzTPa2
	TCtpLNL31g6rPSiyeNbrdyANxZI8Xxhy7E144YOJIBiOWDozdQsuLfcyb+Q==
X-Gm-Gg: AYBFou3T8b0XGeT8iqCTLrXwpHWGpS16tKHj5+NyNxQAAE9brH03UuagNx8tmtA3/3a
	LHn5hH1v8UDmS6/mvi7sqcT4v5x9fOkI/LJrhpzvQKUrigUqEa7/XDQEok9AbE9JHPlA4DUiBAZ
	msKyRFSv4sinnh2EM1AHTDVmiti56BeMhC9TmBbWq6dyaHbcgp4iTiLhhoK1LeV142P6h5ehejz
	BHRMSl6csyl29Oh6B3oBJQ9cYv75G8erOt/NFz7Z9c2FExtmyO8Hb7IfqDFNSxTBIrV3dcH0uEi
	lpN56sF9x6zR+UmHbLEpt3DINW5TmXTRoMrsAQQBmw6jZGj65yS+ArnIifiy6DEDViSFg25XBth
	nvi+EIUCdi8xM2X5Rl9bASbH9LxVFkaozjg==
X-Received: by 2002:a17:902:cf12:b0:2e9:73db:3c78 with SMTP id d9443c01a7336-2ea9c63efcamr48839125ad.17.1792995945655;
        Sun, 25 Oct 2026 23:25:45 -0700 (PDT)
X-Received: by 2002:a17:902:cf12:b0:2e9:73db:3c78 with SMTP id d9443c01a7336-2ea9c63efcamr48838845ad.17.1792995945230;
        Sun, 25 Oct 2026 23:25:45 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:25:44 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:33 +0530
Subject: [PATCH v2 23/23] arm64: dts: qcom: hawi: Add DCP support
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-23-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=5616;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=JWax6SHxXqnSdz0sR52ZG2fr/5xHogt+xoHHZShHbR4=;
 b=3phvyPAWLpPk42PFcsZstSJQNZG3MKuNnHg2gCbX6SuTSkcshSlrsuGkDS29WnsFK2MrUgree
 GAjJ2fJdmXzC8b2UQG8TZFR1oKZzbT3VTflheMwfWxfPdFCg0+kVtOU
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: JWAwVYVuTfdEhyAkjVeKC6v2ps8GRA5W
X-Proofpoint-ORIG-GUID: JWAwVYVuTfdEhyAkjVeKC6v2ps8GRA5W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4ase9sZrOg8L
 1xGc/WwQyyacFJ5pQ/Qn2K4RdnRmRhEyaFvHEtuMGjq6JxGlIzQvY7t5oCmwq5RhjjvyBI94RMP
 wmbhBrFsIPzt2fUsF/aBmCarMmWp2ow=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adef26a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=cp69EZODLtjo7xmYzNYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXwikmZAA5Bnc1
 r72UU23LWl+WiI5ApvnXXFeIZTum/eMXRme1Qn4rqmVbSb7mlPqpwzqS1JPBO3oxcVb6fZn+/vb
 WpGjNfyp82yCj0LXP8RkyTcxffjtOLCuNyOWaxhQ4XHaelwYcl9PRyCnlB501Xg16qQAJLIkQwn
 aL9Lc8mzKthZ3h+I0hmEVFqXwhsyt679ebWJkWOlt3yD3yio0Jkrwv1omy7YHVnieMaNUxiPRAX
 3JveGIOsB8vfyI529dIpZFT6lCCrVrPLjFDDEb0ysC2wUgve3sQ+9FQMAHkgzQu3RNSddtlUoGj
 MTqufNLPlCrA0Do/mOSWgliUkaynhRXmlzEqibmQp3cAxD3MG7AQTCB/T954N9eyx395Lrxjl5n
 3aQsinXUjxhp/gekZWxwHDwwK6gL+NNQ9dJALu7TPVH3wqr+vDwU6pRcms7a2rZq8W0kkK/o8v5
 BQurO/v7oMMiJM5jTrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Hawi display hardware is owned by DCP firmware, so the platform device tree
must describe the Qualcomm transport wrapper, firmware display subsystem,
power-notify channel, IOMMU contexts, and display graph used by the MSM DRM
driver.

Describe the Qualcomm DCP transport and its VirtIO-MMIO child,
the IPCC power-notify channel, IOMMU assignments, firmware-visible IOVA
range, and DSI display endpoints on Hawi. Enable the DCP display device on
the Hawi MTP platform.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi-mtp.dts | 129 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hawi.dtsi    |  40 +++++++++++
 2 files changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
index c38e5fab7a2c..a27003f69d02 100644
--- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
@@ -34,6 +34,18 @@ chosen {
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
 		bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
 			compatible = "fixed-factor-clock";
@@ -142,6 +154,7 @@ sdcard_vdd_3p0: sdcard-vdd-3p0 {
 
 		vin-supply = <&vreg_bob1>;
 	};
+
 };
 
 &apps_rsc {
@@ -995,3 +1008,119 @@ &usb_dp_qmpphy {
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
+				remote-endpoint = <&dcp_intf0_out>;
+			};
+		};
+	};
+};
+
+&dcp_intf0_out {
+	remote-endpoint = <&panel_dcp_in>;
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
index 6b0a0ff0faa4..836970cdef71 100644
--- a/arch/arm64/boot/dts/qcom/hawi.dtsi
+++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
@@ -6841,4 +6841,44 @@ timer {
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	dcp: virtio@9be8000 {
+		compatible = "qcom,dcp-virtio";
+		reg = <0x0 0x09be8000 0x0 0x1000>;
+		interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
+					      <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
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
+				port@0 {
+					reg = <0>;
+					dcp_intf0_out: endpoint {
+
+					};
+				};
+
+			};
+
+			dcp_dsi0: dsi@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
 };

-- 
2.43.0

