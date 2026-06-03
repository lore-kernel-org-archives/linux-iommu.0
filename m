Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D643AD52B
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498828; cv=none; b=KyCQ/Oo3NGLqUvPWNwnJsUWlBxxm1OVhOp56jam/aCfPhRaUnbyiALb1DDT7//GzCT9/aJ5bV6egEP26AwrkVZEyK6JoNzLeqms4JPZKe4ZtQYQaW9cG98OhvPJq7VuaPOo6EP4VU0lA18jHdNND9CyznZZORtjMNOK5MbInMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498828; c=relaxed/simple;
	bh=oR2yHxswddj6quJTdd+FGIgKIDMApsb7sGBB9OxVs9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5nqtm/nnIyHttY5nOYIqXO/1nOdy4DRLht9E7j/5+qHgEvWMloKsqRM2BuZAngGdyVk3zeCJMtv5xYVdXXFth9ZxRbVW9iH8USdeOIE68F7piXShEGR5OiY5ZQ5Csvw2DVmFMNDPoIgQepnUBC4aa1ac+NJOVzxvf6MVbt/vh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FR7PSlyO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UI3UNVpm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FR7PSlyO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UI3UNVpm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653DJnmx1957510
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 15:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uBhEfdW/m0+frpWlSOZbFsnd5JIPo2zwXhwrIyotka0=; b=FR7PSlyOJkWGIVkP
	s6K5xuZO8708Qske/MsZj0ohP7hQzcNJPNb20Hx54i3AeK6MWJ1LU6PTti3NXgDJ
	0R2wBcwfzbNy76tZjRzRkiIQMcmzPZDf3I+sDeMlabw9gVD4tPx0j53IFckySyXt
	9LljQR8atd5o24uTbjtFePW3cSKsUxJyDJ/mgF0fEvKo0a480VjSIljfHHeAC1Dn
	tJ0FskdFCcfF3usxaFdRegGWE0S/wZZj5q66dXsfm53CjicBEY6foMUh2NBPhUzx
	5wOpdzPs+EGPt/2x7FxbQO25m3SsQp0uN0vcOGpN9ObPB7K6S2VUQDExk4P2xfD8
	XWGtNA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc1unm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 15:00:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso3304962b3a.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780498826; x=1781103626; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBhEfdW/m0+frpWlSOZbFsnd5JIPo2zwXhwrIyotka0=;
        b=UI3UNVpmL+MlVFqi74wyrCLSqML6SrmhM2KKBBPmpUBfUDT4UaUPU9Orq1EPNqsYyK
         qWMEGTloG7yjlKtzp/CepyxtgENpVgUrITclkmwasTtmSeg5GRajWO+C69Ed9MqbEzuB
         bdiq1efz115C1aMX6VBN1Ab4c0WQzFXOzVOioqY5Nuwyf1H1Xzg088FMmf0/oNLl7exv
         KLPXxPDYIVGlPDSXusomJVRKG/KgMiJt4qCbDd0ZeOgOIF2uZe9kabu6Pq+YEw9RVLRf
         EyxoO5ja5jqpab0OMpUN9+0k4or4mPzfvLRJrBlAB/GzkCH/2QZfeovEQ3i8H6izIB4C
         jMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498826; x=1781103626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBhEfdW/m0+frpWlSOZbFsnd5JIPo2zwXhwrIyotka0=;
        b=q5ZGPd6ggzR2TTmcbOpZBadfLsKX4FlepaRpZ7zLCpWLkihBuwkGDhBoe/isyP3lto
         gqw58D/W1lAzBhg2hJr7GnQCXsLtOMeKfpmNAtSoAsjaEqrrN+p82sm7tZBduDh6rCM/
         aLDC4//6UlOofeCeGTY/9xj2/k3JC/fj+EX5GYDPTVV+yxjvgU2Ylbq8Ww97H6NgujX+
         kLdi5DP+Zmfa0l4v29PffwTVpZ5mnG3G2Wxu9RV2ddS/Csb2Zc0orOQ7Wu2TQqYGRdzf
         0DnOz0bki7y7h5t/AH4u3fuGoo4xzmEyTOucSWVufjT6e2sM6tLL08MNIQayGY6y1I6u
         MEAA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZS/iDXPLRla0X5ibL1nUuPsri40/4sZ5Evk/3/EZUkOV3fgGtLtxBZ6UXzeRwVhmSclMnKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9vSdVRBeJJrG+1o8sDE9DlmhkhY/2gf2bBSq9oi8vHhGDcXw2
	X0D3MO8ns/32zsMlzSgNmj4DAvPK5BlOvLsxcu6gt9+kFSY8OqpDBYQTdsjvr35IKXAwf1YYbRr
	aitpPfpqGvXl2eV3u1aU5fsshrj8FW7mQKitV4TbU5eYE2mB1iQ9vRnTirA==
X-Gm-Gg: Acq92OGuFaaExwaBaRSPTIoMCH3CeUCPMxvYY8f5nYrS9w8vNaqr3StGjmU86CpWhMW
	hoJEDbddk8odRJzK2zUaoiif1YYv8iwEqPlA+zemgnkrp9vFVA6kf4qvPjsUwPzZ6UE3qKjJ4S3
	bYeBT+Dg0ORGoqhtOmRdCG6eCtKAAwOorg/9EpAhw1ojJ5kB0XZmU4r7JFFImo5Wky+9IFbfC5b
	Cgz0OLQMV3ljBJhTEu6qogxD8yeGEpb/Q2qM7r5RvRvdsWXM/TC+Uc3d1yYshdGoRrBgK1URDER
	5y9vZwD2UzqpnBSJNT3ddk8Ti/JYV0Yn2EJCWKNjKFXPEluhjPixLrRe7ywrszOmiFkJIDXVorK
	rkQtsfbXozaYzBh7qJBht5xCaFz2MqgixLd8OQ/V2cf3iNsG9DS1lV8Y7mNw=
X-Received: by 2002:a05:6a00:c90:b0:83f:2568:d45f with SMTP id d2e1a72fcca58-84284f5f588mr3805635b3a.23.1780498821392;
        Wed, 03 Jun 2026 08:00:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:c90:b0:83f:2568:d45f with SMTP id d2e1a72fcca58-84284f5f588mr3805562b3a.23.1780498820755;
        Wed, 03 Jun 2026 08:00:20 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:00:20 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:30 +0530
Subject: [PATCH 5/5] iommu/arm-smmu: Add qcom,shikra-mdss to Qualcomm SMMU
 client tables
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-shikra-display-v1-5-aeac1b94faa7@oss.qualcomm.com>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
In-Reply-To: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
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
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=1873;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=oR2yHxswddj6quJTdd+FGIgKIDMApsb7sGBB9OxVs9c=;
 b=slT7W/f52dq5AGO2+1rwtTo0T6c9Jbsdja/oVrv6fulBjy7AdNAx6Ybfd6TtE7V8hPTZoRf2Z
 IBvqNqxSNY+BT8jWJynyp5mtqdDgum45kTsfs7dMaj99ai7z9uACjZl
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: KWJNFkxvBuPkIZH1g6muAqbonk-LxYec
X-Proofpoint-ORIG-GUID: KWJNFkxvBuPkIZH1g6muAqbonk-LxYec
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a20418a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WiTR6ph8kncRzgk6yhEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX/62dDemt3Hm1
 bbiN7SUKny7K75aMCTcMDOxkon63bqjUPhhKbtEB9W5GN1ei+yLFo/a/lqTAqTbZy4JALW12KMM
 b5K9M80Fwrb58xG4nZZi+HhIcDIG4lIR0Gsi22wURmfygzrs2eC0qVZLY8GPgIIpo+PhhsKztJH
 o9zjPQ+WkrzJZpcyRcn/ltNNgKtc1r7wQrMZq04HSeuOyNNBCzwf5bETbFHXqsdS8mZsd20A8JN
 zq0tmOvqEll6kXp5S8zqeeN96k3bXnJMoqr8B4FHBzaPw7Ev6wbatG/PET6b8t0XySTYP/Bo6YD
 I0lKFlfzmhu2UP9sBClO3o7Lbtjd57RXnY7ZmgvQR9aVNtNa1Eri70pXYurEWd1CwjLiV+fNV4a
 wgo5sjfoxuXyHDWIbC+wKZ2hthaVki7/pKqUbSDe+BusQnBFJUdY3jPKHVKWPxCuQhNfCmabgwJ
 C9868MBaqEHo2xLsTqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030144

Register the Shikra MDSS display subsystem in both the SMMU ACTLR
client table (for TLB prefetch tuning) and the SMMU client match table.

Shikra MDSS uses qcom,shikra-mdss as its sole compatible string, so
explicit entries are required — there is no fallback to qcom,qcm2290-mdss
to fall back on. The prefetch settings mirror qcm2290-mdss
(PREFETCH_SHALLOW | CPRE | CMTLB) as Shikra shares the same display
hardware block.

No entry is needed in qcom_smmu_impl_of_match: Shikra's apps_smmu
carries qcom,smmu-500 as a fallback and is covered by the catch-all
entry there.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index e2c914fccd6f..3dfee947e2c9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -45,6 +45,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ .compatible = "qcom,qcm2290-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,shikra-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
 	{ .compatible = "qcom,sa8775p-mdss",
 			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ .compatible = "qcom,sc7280-mdss",
@@ -410,6 +412,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,qcm2290-mdss" },
+	{ .compatible = "qcom,shikra-mdss" },
 	{ .compatible = "qcom,sar2130p-mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7180-mss-pil" },

-- 
2.34.1

