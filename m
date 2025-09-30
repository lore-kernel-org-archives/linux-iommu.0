Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147519F43A
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211398; cv=none; b=IA5jUN2HwFADWjG74B7ZCLUTs/cIthsV+2xVLNT4jXtxvezh5r6pR8BtqCfQO84t5p0siayXCMoxEXfSaJZObhF4VjGrrnnQn5G6kMvOhKsGxq4LW7xXVqYzq8iU3067OCCiuTXibTbGWPDGJmEzTxFaH2tg0udSyNSSGLY8Nv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211398; c=relaxed/simple;
	bh=rhJzPiPQh5PalUiLaJWP+g6zLitXs96Hl2pwoOg/lyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCtNEe5PIuoXDkW+PdVrhZcP8T8+noX6hfOLjGpYIkK3jVAssk5vh664mwGJq7PqIAZYGlPpUibBnJF12F22I1GJUOX8jzg/7+1G+B4kgCQjQVONSYbb4IcOe9URWWKChA9tHSMwZuWm1O6K7h3HbG19hkf0tKymi348JrYTKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ikP0pt55; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ikP0pt55"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HjAo015093
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ThoA6YgpQiOg8S6pzAMpUUDGjl1Y3c4vNGfbI/06aRg=; b=ikP0pt55wblcGL3v
	pJdyHoy3ltPtPgHrg7x5YK6wk3DZnBbZtbTCsNBUpJASn4/yOXv0dSU+AyjANCxU
	nj/aqmoiwRw9ENISV+v+QDdK+bU3eR9KNmDaVc7DD/RdkfShJVCcO9nipftiHsXm
	13INjcakMMRUtBMqP1DgqeI9+kZATrrlKxc9Ra3u45YCrE8nYExt84+ffuE+tLe/
	X7E2eKsBvYJa+KW/BAJc8QYEGkRtHAMSvTSOYNiZUWyW/UTCPlPriDvG5C6JE6/l
	XlbrlmdTY4P2JwqySqHhWcCr9I+vZD20L41kvtGuFP3H6xqCpeva2QCG0BzFBBw2
	wTh+ww==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vqysup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:49:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b59682541d5so5157443a12.0
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 22:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211395; x=1759816195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThoA6YgpQiOg8S6pzAMpUUDGjl1Y3c4vNGfbI/06aRg=;
        b=fQBP2bLLUkJLAdE4Qcmm5c34WgsNSY4RV8B+2OKa+QAzyhSDWsg8s+RUdsfArskedv
         3Dv0nYYBtx+nc0yd/RVbP1+W8I1vV76RFrGxmyfpR5q7mT6WLsiSLKFssZjtAUQ7Mrkr
         tx5b5ty0uX1nIk4oisDlQhswrXyai7zMe10wgFPYYBEG89FSO/iazRWWfPyafL4a5WxS
         HtfWBJF9E4l+8r78WT774ZxGO4Rr4c0cg3ycxP9M1vY5B5K4aAYBP/g1OTLHAv0MSg5v
         dsp5xM3Hchto0zfIG0eH5H8yHv/W1tEys6zRFSecZll4l7crq0Nm+Cls5nomZwKyrZyQ
         o+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk8RMSqBbCkY6Db/oKkSZuIyhvbxuK/Z5bMPcaF4A2R9Nul1xaQI+zjCN7bWUhFXYY7tnSZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxS/uLaaifLchdYHelJusmgFPRZ6m+l7wCPBm02gYQX34fOlGk4
	NCE3Tf9Zs6sIbgUcwGu3w9nbiVVBzw2iUw1VAyauGCnlMBxDd2vxeZ5Q69KzkBoIGAVxhdnvqE3
	4esFE5E4XbZr1/+W2PtjLsJcpQ70vjOeCjECTY7kd3bKoXpDbUT0b9POv1w==
X-Gm-Gg: ASbGncsPa0glo2jFxuOWphHgADBFfSU3CXcEdY+4Nf4tIVzGnMjSjbWIrLlRHuIjY96
	1QVR/zKEqzDRlr00X/4kSKKNFU5y7c+8/qVcDz3H2aviXV6nCHHd7echcgbgwkfudBRrQB7DcyC
	xShqcbQEHPMQi9iQYYubWWndDMBUyRAKOd/hPb3OgXj6rkKTx+HAk3PagqCWH92XWisnv2p+utZ
	h+r4/G7A8gYTDPV4CxSFsCnoaJ724COz/I1DWL+ceqCmMJeDf/EjQz0Nl0gbvFkMQhc7l2Nqjpt
	yFBl5C+5pNFhv3sNqHzO8wDmTL/QGZ5hYcJph22/1ufHNd8q8DbtGcLbPD70CdWiLr6HJA==
X-Received: by 2002:a17:90b:1c8b:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-3383cea6105mr3192197a91.31.1759211395343;
        Mon, 29 Sep 2025 22:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9p/WsjalDYjqqBpbBM4tMRq/jOyQCCf1RPlU4hhSKxmGGZ3ERYmjP7ysuZxVehRilUdsXhA==
X-Received: by 2002:a17:90b:1c8b:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-3383cea6105mr3192176a91.31.1759211394945;
        Mon, 29 Sep 2025 22:49:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:49:54 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:06 +0530
Subject: [PATCH 01/17] soc: qcom: ubwc: Add config for Kaanapali
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=2182;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=rhJzPiPQh5PalUiLaJWP+g6zLitXs96Hl2pwoOg/lyo=;
 b=xbW+/WfyGkVXE9qGR4vL2rV53p7Zg5bR2EqsFaz4PwejCII1l2bWl8VOPhhZuVJqksSfryW49
 6muGlSfGBPvAAZf7W+0AB1ZWW4WLIyqkaz4FRTNyzyZnC7VOG5a7jD3
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: BiUyTTqVbqEFgQnV246uxDqQGJAWWGQi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX2G3vuv+ykdq3
 mkXRP3hZmpod3mGZ1e4D6hL2yhJWij6rf45XVUVBB5r9p8OtWn3d2ojGpyi4pu2NfXn95yq6kbO
 A49vSl7SqwfC3sv3WQy+BnffgVaic+dyzsT0n6tTca5mqIRekY27xmQjVTBmSAw6/7m0vv4LXVh
 duVeBPjAwwb/svIu//b5hMUfT8yt5PJfV6mH6lhg15r6NTqEu/pIE+XmBf4JDPVdKtYuvfS08Qu
 +V+QRmz3OEs9ROJaoVt++Ye9lCuqcKN1EZLZl1JiJCXRIjcGq57iDO+kWI0J4rdqLMugYSAcuWa
 omksx84og/MmYURfwrf9rtFYKiszaNIapA1a/fYCCm05h3fhiz1TFnq3zk+RVzcDDx9eqlcMfpb
 y3cDQVCApgZZOhNLnKJIW/SpdsXwrg==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68db6f84 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HBDVfrJ52KAmvMVrQVYA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: BiUyTTqVbqEFgQnV246uxDqQGJAWWGQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

Add the ubwc configuration for Kaanapali chipset. This chipset brings
support for UBWC v6 version. The rest of the configurations remains
as usual.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 11 +++++++++++
 include/linux/soc/qcom/ubwc.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 15d373bff231d770e00fe0aee1b5a95c7b8a6305..48dfd76efb34319b3cee29894ee4977f105d890a 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -16,6 +16,16 @@ static const struct qcom_ubwc_cfg_data no_ubwc_data = {
 	/* no UBWC, no HBB */
 };
 
+static const struct qcom_ubwc_cfg_data kaanapali_data = {
+	.ubwc_enc_version = UBWC_6_0,
+	.ubwc_dec_version = UBWC_6_0,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
+	.ubwc_bank_spread = true,
+	.highest_bank_bit = 16,
+	.macrotile_mode = true,
+};
+
 static const struct qcom_ubwc_cfg_data msm8937_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_1_0,
@@ -223,6 +233,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,apq8026", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8074", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
+	{ .compatible = "qcom,kaanapali", .data = &kaanapali_data, },
 	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8917", .data = &no_ubwc_data },
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 1ed8b1b16bc90bea2ed54586edfe21beb2db04d4..0a4edfe3d96d4face2ef98622984c66939a68c53 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -52,6 +52,7 @@ struct qcom_ubwc_cfg_data {
 #define UBWC_4_0 0x40000000
 #define UBWC_4_3 0x40030000
 #define UBWC_5_0 0x50000000
+#define UBWC_6_0 0x60000000
 
 #if IS_ENABLED(CONFIG_QCOM_UBWC_CONFIG)
 const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void);

-- 
2.51.0

