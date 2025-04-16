Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0824C073
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845406; cv=none; b=RYtpC5FTjnmyapxjSToul3BJEjXeWlhyX8OJRx3ooFJEH7KOIW6wFGgdK0U2CFpuIAF56ZgiLC2MhGbDtE7vs4EQwRKj/9AOAiNV/UvqYXeboXszunETohvw2cnQGaoIiVV6pLS+8bva+erguaYD/vQBdTy4/yOWi0GSzIQfKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845406; c=relaxed/simple;
	bh=WwCvGbKN1UfpAvbEF24uDaZkMcpdSei4ppmMTFjiumY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDqoAvWbjuJ4HmRuQNUy3++2YGi9D8j7VP88d7BuKLFwmp52yqLSNTLQeedQV+Nm9exnWsXwUuTbDtarpHvugErOScO8QxmwbbylKY8JaNd2ALlTUmo8Cv7lUpotzwgBmdZx9EMBnd928IiJUZq3al8lHk7YLAN7qMNyuWHQPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CUFuv9n6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CUFuv9n6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GM5FcW020882
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	boXGEJ9vm7laFVs45kpF+i7DaEsEXFuWOHSJOklGi48=; b=CUFuv9n6cu9dJ6RA
	JIEgzi9FgUs3jeH+iS/ZP3QIRRa2bL6rZT1mBLBMivucrzsHDBMYkouke1qaaCwX
	C5LwYCgJc23IMmSCzERCLiCpKKBmhUeOaJ8fHaSKemslHpUVVK4FNr/xPuiLORfF
	fC2EvPotuPLM5xUSbuu5GIthziqknKMWjQXSnzwFgYmieJcj8i8lr6uL8OWvCC3I
	7iwnJso5A3m9rDJfZx6GA7XKM8ArZHfKh6B2UIuzIgibMOLxV+5L/0dLLjExe8GB
	SeMeJKopCs6XqTIsNJYUUBcCL1GGfsntO4jeYwIYQilYAQ/UWno5bgfKqUu0CQ9w
	LOJ8zg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69w15u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 23:16:44 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ed0526b507so4040876d6.0
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 16:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744845403; x=1745450203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boXGEJ9vm7laFVs45kpF+i7DaEsEXFuWOHSJOklGi48=;
        b=lKuJpBHviQq3PoWTSMYFHENHjWx5VSdIhFbR/s1Y1kvBugMJspgmyX2fBY2zDa1jEP
         1LXnxC2v2V8weFD4dW+ADJ9DKWGEETPodWiF4Io9zld2K7F5iHzzDIzCOXsrUnWFRk3x
         oBp1WuxK0sdeuvoPkYQr+uSwFv50NH+7ubFHCQ5PJ3Ap+4ZY7GbfLfz1wkQHYNlMfHb7
         mQXrCE+lbU2Gd31h3eRi/AieA9QdrzmZp+EHQJFkT0i4TWwkYBgCFoXrZMlakLEfyzEY
         AB+sE5RchGw2lFpaShAteFqfKgpW7Ylt4O1RQ9enDI5f/119O61yhiff3mmNpdPY6JCU
         d9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwZ+SNdRRiptb3wc5bQ0GHfRLyi/CeYqJR67wkJ++m/I3HnIyZec9Ltj4oLkENFg5dKzovvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YywuYNrnGC5fv3umTbwyjaY9asC03O+u3Krs3ngRFq12G5FopDT
	B/nlc3ZZlatmziCVUgXeho1V2VYICbE2jsGkhEbxYNBBrdr+iIfGvBK9KuIPgMdSVAFfGQVGC1Z
	7bgVOfI8etTKcnedKd5FepoMbHkv6okjXrTgp5Z78iKaE0VE4SKdscg==
X-Gm-Gg: ASbGncvLgv8CPcO59N6pzXFRIQiOrD1yvKZUhqrFAWSbT8hMBzeJkO4+mGvg4RENw4S
	6djQm09Xl/Ef8DoYqtB3+z6ylBKCbXTi8kfQP2Kueqea8fOFra4obudo9iY7vcsE3Yv8fB8WGd0
	Zsm17NNZHmtTv2BVpzFPQ8NsPaNBkr4c1SgIJyux2wHs6mrKf6LfweZUfPURCuaMHcPco/mtH0z
	X97vZIUKuE2GZ6WarXcnPq2SWxU3plCvp6NUOMwqTpkuMZ2Zmf5jAY/2N2RWHSWmfpMYQrPRA4n
	WHPvtfDK6BCy5Bne0WaXu3oriDRCRjMY7VLLiTqb6tTqGvvbLPQSMoryhqPHjRbKfAy6Zt1pEY7
	c3On8WB2lK9Z3qi9xjSd0H4TV
X-Received: by 2002:a05:6214:1bc7:b0:6e8:ad15:e0b9 with SMTP id 6a1803df08f44-6f2b2f93f11mr62673606d6.20.1744845403271;
        Wed, 16 Apr 2025 16:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrCA/KParNAT/BTiVkOPGzVpXZDtDs1mXEDaoU5nQ2DaTF35AM6o6LLomN2aXrq0eD1fuNmA==
X-Received: by 2002:a05:6214:1bc7:b0:6e8:ad15:e0b9 with SMTP id 6a1803df08f44-6f2b2f93f11mr62673186d6.20.1744845402926;
        Wed, 16 Apr 2025 16:16:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d79esm26062181fa.15.2025.04.16.16.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:16:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 02:16:34 +0300
Subject: [PATCH v4 04/10] dt-bindings: display/msm: qcom,sc7280-dpu:
 describe SAR2130P
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-sar2130p-display-v4-4-b91dd8a21b1a@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IJ0quqH+dI7r+sJavUIADWzzAqD1L2X/CIVzw9kCDtE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoADpREQ+V7HPJ8Torzzts6HtQRTIhAKzsZTV1i
 6mzzSWqJhSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAA6UQAKCRCLPIo+Aiko
 1TGhB/90c4LcuO7eAM0tlDSCT0Wt9jESwJSN8QH2OFqAKMujsiEdY37WSv8L/DM+BixUIfPBTj2
 31qmCQGMszanECSZ4FTb1zxAEhZOiY4qAoRR+GnrhdBEhRoPY7FkfX4KLOgnZLSG6kpF1YOrjuy
 NbcW7bv4lHopOvGtTXtjf8/DOv8m7UyKkst5z5s74ugy9sAu5yGgPIOeOlYJV1gGwJkaqFSxSQ7
 qYbd5PaLxQ7zdj+Weyf3x6JPiLsqOZlb4AW1WwqrYVxvv6Djqhk43/YxnlWVg1S7ROHu7fhXI1H
 zQy3Zdtn+yHPOtf8wBpnd5uGKVdFL2WD/SnOJz7C7Ttz973T
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: vx3dYf6kHd0ILKXl_QOVdUNIF9XB2Fmr
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=68003a5c cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=P0d4iQPpJQof_2lRNe4A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vx3dYf6kHd0ILKXl_QOVdUNIF9XB2Fmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=957 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160186

From: Dmitry Baryshkov <lumag@kernel.org>

Describe DPU controller present on Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
index 6902795b4e2c249c2b543c1c5350f739a30553f2..df9ec15ad6c3ca1f77bebaab19ffa3adb985733d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
@@ -17,6 +17,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 properties:
   compatible:
     enum:
+      - qcom,sar2130p-dpu
       - qcom,sc7280-dpu
       - qcom,sc8280xp-dpu
       - qcom,sm8350-dpu

-- 
2.39.5

