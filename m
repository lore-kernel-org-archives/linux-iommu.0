Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9742459DE
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845411; cv=none; b=f1yFWtCBwWVY6rrCJgPu/sp4EayxuMwDc/INfmSfgSmYSPPApXJnfXN48PyKuOKNE4oG/QwK162bppzJhDngk+LRGXiDh80Vbvl8JeRqKe2352IfqURU8wI+VemQjf0g3XMzliWjWzfbxXg+wf6zix4eh85FSztjDg1EcrdevLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845411; c=relaxed/simple;
	bh=lQQh8ylJrHtWLQoXqKNrrnmkQhqGnX3390KtwvC0ink=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwbkwQz41Fri5H8VSFV95NUbN4awiyQEtLs+FjHcYt0+DL8XhWKT4URdMmD6A2e2pqPh+sy+8IxhghoO9I4O2KGwVaNJOsakRchIXbtD34iPtBe7OZMfoFdrQarJ3lX5mSQsbdXgzaKYJkwCQ0WXkn0V8hXuEFWsl2ipuxdbaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=psYFKSGa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="psYFKSGa"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GKpWpi007009
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9AgmbDCtg5twjkdaU8ecsDLSo+5QAUYUantq6/JrfI=; b=psYFKSGa8IWf0Zdp
	gDl5yrvUGgl+n5i4lA+2AhKm2kA4ySvUuSAgqjRWvppFWDYJHxE88BhqFuf5k8zr
	GfjtPsz9ibtgxKZCKck28o5FyL0XFKzuCVy9HFvfICtbWjQXtvRsrIzgo7SM5RtR
	CAl2nkTLjdQQfstkx8mCrBEC9PrDoGqb+5KN6TXwCOEeBPv5BYJSOq0Lk44Hc1e9
	IIn7CjJUT8dd09seAiKjQ6/zR7nXqShamY80liNUapEnZWC4OqnKrV988S4hlD5L
	bhspYnInVltf8mKSoB6IlvucsDuVjCuEgriyYbCZDk1W6Syh2hvnfiE0pkxQDiv+
	ce+7Ug==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6n401-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f0e2d30ab4so4565696d6.1
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 16:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744845407; x=1745450207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9AgmbDCtg5twjkdaU8ecsDLSo+5QAUYUantq6/JrfI=;
        b=Ph1oAFrjidzr2NiqfoHMVsVq6NUWx/gU1QUOtLQF0aqIhfWANmsdQkSOWPxmbWM8nM
         ehH9KGYI851y6Q4BJYd9sGNO2CMVfko/1RMwNw7lPGMCNrD8/MovRqg1sa8Pn9lZrBiT
         vDnFzeyIpz9cxkIa3kyrncT7s0vF+DoiTWJvvxvYu5z+NhdSdAjpy2psj/ZyNaBfFkEv
         SDCASZXabLiEN95cIVOpCoRnfR8bcEHPRcKa3iMr7EMOBJ/HthA7cEAjFUIq1ADK8a5H
         w3df4N1DbNLKJ/5iVK35PCR+Ku0Xu2RHqze1nfTOIyCkiBlwo0FkL02bEDu/owJIiE7B
         NJJA==
X-Forwarded-Encrypted: i=1; AJvYcCU7+/PVI45LHv1dNe48lsV7D0PjzsD2lXVS5OSUh6BofhBXEJAkixvZNrhKmNi+8L+9ikn7Wg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5gfccHAB5ZBTNlV4uyG7gOpHhP8kq4pn29kYRDB08pvReKY/o
	r1h3+MoYHRhsRI+Vmp2h4vVZgJN8LaufY273nBVICZl6lXDlplCsytdP2AVYX2UMMcXqIzzcLCH
	ChqH7/s8IOD6c/E6d1FpENVpdM333oSouYNCgd8xMlI1zV/KFW8iwvei+rkAJIg==
X-Gm-Gg: ASbGncvFnl8qygRPAe+myMjoS1KYgiA5LbtQ3E5GK3psrrmBPKiovXoDjEPlwiHVe/Z
	p44wRWghUGylsOOml/h7kpJn4FkNXdKEuX4H9O/k04RErLt+gzFglMrkA0j8lzFU1f4Tv0qzQoU
	YWbv3VDqjExngjH91NudEP5Wmm8ocOLsEMud3yWMYOk2wQ9Pwnr7qdmT9W8Ct39hVMWz2x/0yEX
	Aq82hp/VUZj4m/LFxaCU2nf4wYetHbMKP2qMmvGUwhKsL+M7KRW+UUWC62RkWxPi8muhbjGK/0K
	vxD4CQhEU2Mv4c9tmwEtxIbCDRqsOCyxqp2V88DxzOdrZMMUynWb25eqY/R44/D/Uwod12TZG+K
	2obXKKt7IXt2kxma1NWTTLLrt
X-Received: by 2002:a05:6214:258b:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6f2b2f1f463mr61447556d6.4.1744845407002;
        Wed, 16 Apr 2025 16:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEExfurjoRk0XXDux2AeafmWDRteWsUt3LSo3MCvlJ+i86Yzmt6OO1ISBEL9kuOhXHGem09Dw==
X-Received: by 2002:a05:6214:258b:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6f2b2f1f463mr61447246d6.4.1744845406624;
        Wed, 16 Apr 2025 16:16:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d79esm26062181fa.15.2025.04.16.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:16:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 02:16:36 +0300
Subject: [PATCH v4 06/10] drm/msm/mdss: add SAR2130P device configuration
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-sar2130p-display-v4-6-b91dd8a21b1a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/w/74iYrKtAn6Ezwjelu2gFTZwiy2nDMAwTnc7sQiaY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoADpRzs8G5GSR/kripA/Mt++az/kf9tb4wkRPT
 zWUR/sY9OGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAA6UQAKCRCLPIo+Aiko
 1fs/CACvhyvRY1vFiTBxUDkPDV+CWAFVRYLGp1bsq6je6dejKFJ625SQEvvJNEoKLoiVZi8sd2B
 x6vGq9TKEEr3pWUjSQd9IueqBGVmicfKCOIeuigoBHBD4ZCEStqXzalR7sICRWJ0SxLM2vtsAhD
 4HvX5gv906hJNctsQ8kL7EIhXViOAOUKlGAWtU53NwpDIfY9sIXDWkoLCcnQWbgWzzxzTgy7pI2
 10qdApZGoSEU8WGwRkKmUjRILwA47wPakWx5Z/+nUEM1xmiMZTM5IBR0hfVNDR5Thg2dStbhlA5
 1I37aM5lUJPKktaB1k1ozoMAREvTjaj2sdmftXkzVA9Bjueu
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: IIav7uQGTz9x0mmZBxBJOIG9CebLBTdl
X-Proofpoint-GUID: IIav7uQGTz9x0mmZBxBJOIG9CebLBTdl
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=68003a60 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=Zo32ic80xGYl86IK4a4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160186

From: Dmitry Baryshkov <lumag@kernel.org>

Add compatible and device configuration for the Qualcomm SAR2130P
platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index dcb49fd30402b80edd2cb5971f95a78eaad6081f..f706e44231a9c360ac4abe26e4050e416d8c3940 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -592,6 +592,16 @@ static const struct msm_mdss_data sa8775p_data = {
 	.reg_bus_bw = 74000,
 };
 
+static const struct msm_mdss_data sar2130p_data = {
+	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
+	.ubwc_dec_version = UBWC_4_3,
+	.ubwc_swizzle = 6,
+	.ubwc_bank_spread = true,
+	.highest_bank_bit = 0,
+	.macrotile_mode = 1,
+	.reg_bus_bw = 74000,
+};
+
 static const struct msm_mdss_data sc7180_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
@@ -738,6 +748,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,msm8998-mdss", .data = &msm8998_data },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &qcm2290_data },
 	{ .compatible = "qcom,sa8775p-mdss", .data = &sa8775p_data },
+	{ .compatible = "qcom,sar2130p-mdss", .data = &sar2130p_data },
 	{ .compatible = "qcom,sdm670-mdss", .data = &sdm670_data },
 	{ .compatible = "qcom,sdm845-mdss", .data = &sdm845_data },
 	{ .compatible = "qcom,sc7180-mdss", .data = &sc7180_data },

-- 
2.39.5

