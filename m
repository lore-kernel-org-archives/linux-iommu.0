Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C3149DF4
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932592; cv=none; b=ILxvm7UEGvFKBRHCKBA/0dku1PfT1DdsI/vHBs+gmaImxIF5EHzXIT7o0fe6qLHxwTfYTVvL8IudSiiWBPdEKS5YrIQoPeQm30oB899MUoEIGji6l5AfPsLGsMBRT4tnOYOstGDOD8gQGsmzs0sZ7crKi/I/HQf+g4yo/XfnhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932592; c=relaxed/simple;
	bh=OG5d4gY7vmYN/Ho4ZXDwy54ckaj7MCjmkwbMaApZrvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKAq+tRKuoWFbaRgFAzHk5se3QbYpKIK0BYFkDNKDz/q+WB78CMbxzYr94YJu1hm7dY0DboZkgThC6nR9sZ6Tk82i63C23S9pDxeIXBX0/p/g1Uux6BL1zTy1NFRFUe2OrSbLi72wvAQMOD/K973oGAXKtXbgVCayr0ACm0thV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VyHDBwxo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VyHDBwxo"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNQwsn003492
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mjSoUBvhcQw/y04Nu5LFvXZ5AJDuaSz5Df8S6I6vgwI=; b=VyHDBwxoPudWArcF
	UM3K3KFFTk72GNi5BAMt0MnLiTd2Vh6iG5b+ioI8UOWbekNFYAWJ8QWpyeADE9p3
	SuKBMSoe7hDmY9Z09m3M+02Xv75jHFz28sXy/tgO4WEgT9SfQknLAimjKyct+ezo
	+oCklyYEdvTLiz5XgJEGoR3LSog+QjUSSAyPKmPTj/USLQPQcgAepmGOBy6tHL5I
	VZ1uH45WZ6wRJG70muXas5SfZYun9GXV213k4E6dj1hyVKWW+vrHmKDZLvGhdAD5
	0v0GNh+7y4MLJVhvSA6hSQKcQYMwNspkJ9UuClIaqJ98AM1WcSkICqJ4/GGsXzTI
	6pRAJw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45b96ye4p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4765f7bbe1bso30041771cf.1
        for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 23:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932589; x=1742537389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjSoUBvhcQw/y04Nu5LFvXZ5AJDuaSz5Df8S6I6vgwI=;
        b=WblVPqmS1cofIT8CTLakwCuiAdAfzwXZ6EwMPrtxEHjJpvwb0N1EMqLso2onJxSBOM
         7O5zF7YAVm5LYN1h+3Ner3MCxcFmg9Vct0GX8hs8U7EKWncGmHeAeQ4PljFlcz4gxqCb
         rWoY//iigsuUzT+H89CKkLGGazhPIubM+RGGtMWx6hzJnCG7IXW1GSjjfio1AfEHtEGu
         hrxL777jqkH5Z7bNXeYXvaEgb/IdVrdSTDErvdYovkmNRGFMpvOYAk8C3GA9HbdzfKAI
         Ouejca9QESf+mZFrdmkVvjNj6XiwCTXEB/uonM3izMu2eYqDLGDkcw99GMZ862cBcYUr
         Ganw==
X-Forwarded-Encrypted: i=1; AJvYcCVWyWpJEy2XTmgM6FqPtmxKCbqiR39C6vAietR+RNJ9jT/+g4bVCXYRn5MzMwKsJRADO7EVAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcHyTeVzE6bia3HHeaZTWwsSNMt1L1/XBvr+3Jy41pptOVoPNI
	uYyVNR575rPN1f6WTACgW9M1HiK0rjqpofb2WBsjxry1ATPxAjpcrjYDHGxw3dMG07C17nFfePn
	sfkv2urbGlZLGiY4PZzlcM7RsQCcE2NM+rmIC88gtogS5+ZHX/HzWcg==
X-Gm-Gg: ASbGncsFVNOeyP3WumLSkRKltt4Wy9prAm5kfCLacxoPhMH0ZWlJMOux7Xmwqgsi1YE
	YDQxhw8GKKAUehKkzPNRhkjfv9xjptTXsLixQoHK8kOVlCErf8H2RMCh3TR+7LmfSIn7I6T9d0V
	UPy07pd86WSbBRjOQw7jHFm3CbqMtra+2q0knuUvA/1iV2mrrfA+myU+M7dxnkU2OqH1XWrUe4G
	+dvXb1i1SylzGFEq/x2o4B4qULeqoSH2Q2oncRxZFroVyiqyxMac/50IR1O92HywpdiDobe1woI
	bCB0GrHDs4ImI9UBpa/b53Mrk9BPfuvNCxVLzq56bINfMV/UbDi85Ptv4vgYbt8cCdr4Xn9lQFW
	w6vOOncV5W+N+QLw2vxUtLVU7Wvmv
X-Received: by 2002:a05:622a:3d2:b0:475:287:12fb with SMTP id d75a77b69052e-476c81c3e7amr15418561cf.36.1741932589547;
        Thu, 13 Mar 2025 23:09:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf5nv3MOYAkMmnz2OsAe+o9/z+buMZfQX7OZ04tCBLdd/CA2XLrJH4hX+ODMGN8nRL1Az0fg==
X-Received: by 2002:a05:622a:3d2:b0:475:287:12fb with SMTP id d75a77b69052e-476c81c3e7amr15418421cf.36.1741932589241;
        Thu, 13 Mar 2025 23:09:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864fc9sm416071e87.140.2025.03.13.23.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 23:09:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 08:09:13 +0200
Subject: [PATCH v2 09/10] iommu/arm-smmu-qcom: Add SAR2130P MDSS compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sar2130p-display-v2-9-31fa4502a850@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=j/LGXpgnuRffqJSRqVOkk/ZdY8s1uzD2F9Jjdwztl/s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn08gHRNb3rAw/1YzOCHHQbVo9K1tLhPyYm7yys
 7MIo6TQOkqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9PIBwAKCRCLPIo+Aiko
 1bIAB/9iefWNNYwh+AhEoS9fi7fnc0aFhfEWmt/qtY1iAeShQna7KTXKAzo3SbUNBaZo9tErN2L
 WCk6iLtrFQ5WyPlwV3u9SbBQewc4Fjz37eeV/q8ulhrbHssaXkX3cIEixP9xNeJCqb+NjPkosVf
 A3zYjGvP76y9p1LANOqxkChYYGCbSXMzgzFmBKlByz0ULTZ5uI1BdRO+dC2bbmYbPjDJF8gLuZZ
 K2MgUIW/9IVltX03bTJup8BOkeGWi9Sc/EMDPB2ksIdCcSG/B3KjVWgFgpqCWyG3ZAJvlR3DzxH
 EQqc3RLVcZi6JctqZ0QcvA8vEwLzq399AIjKshNLNRCk10U5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 1DEFUDk205Uux1T4P52TFkMTIlzaK0H0
X-Authority-Analysis: v=2.4 cv=I+llRMgg c=1 sm=1 tr=0 ts=67d3c82e cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=VUTEsYOwyNIbN2ghz4EA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 1DEFUDk205Uux1T4P52TFkMTIlzaK0H0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Add the SAR2130P compatible to clients compatible list, the device
require identity domain.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 59d02687280e8d37b5e944619fcfe4ebd1bd6926..ecc4a1bc9477b766f317a58ef8b5dbcfe448afa9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -356,6 +356,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,qcm2290-mdss" },
+	{ .compatible = "qcom,sar2130p-mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7180-mss-pil" },
 	{ .compatible = "qcom,sc7280-mdss" },

-- 
2.39.5

