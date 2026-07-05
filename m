Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70736C0AC
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239312; cv=none; b=qpR2JLIeP+CL3WdnCI7AjdGUBE/dZ5jTMtHP8H1vmpgt2Q7AJtQCLxMr5heAQgtiOyLr4T3HEq3j3WcD4tewPV4LWwH/sG40UMTCO5VKKHdb1UJst/iSEKmKap2LrOUXOz4eB8lbTjPLNmGyiXXTW2PLdqtBdVZFBiu/B/nBKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239312; c=relaxed/simple;
	bh=LaExk5CcIsnQobdkf+tB0TGQXJcIbfm+LHR//18ybOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDz00R3Zcam4qYvvc0dhtgbFigTfnCOLQ/ZNhTy1idiAKsXDE9eo1DhSdUoyn6KKh3LtC7CFQkOTNRtAkocyz2Po1fMGKiIO69Az0+E2w7/Vv9zwQuhnPU6y9zNNDEXdwISSj2KY+p/NT5YEy9y3o6FTIGv9eeSfnpNexaR7s7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KvAciPTo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LRKjpe88; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KvAciPTo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LRKjpe88"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664MjtGr4092232
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNyCxijy9WsR1AOyIAocOM9RR1P64I7j0GHUMuAw51k=; b=KvAciPTo2opHuKFN
	hIdWUJNugTqAmpZnAo3usxfYZVs/0s23fjArjmpVvW9KWQAS+qXw6UxcUIinpVVL
	du5M7pS9upROlpHBDsp6SOwIRLMw525dbjpGq76d9GLofEEAT1a5IPL1r0I+duQV
	Qxq+jSCOg3Z2SPd+poj7m2ZD4Sbhcd8OlKWfXpU6p5nkcsHgrOk3S1QQSrUk84LB
	qmfTZJHNBaZlxPCa0y0WkBFW5RrTJTpfc1gMjSyZEscAsF9PwfeEK2I5I6t8rU1A
	ckuuruQOHoKwR1uiuiEnp0dX8rReYP1ctx0kxpm8CS2newYWi2m1RMGpQYgJvRTe
	XOisJg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txej8ab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:15:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c82843005eso36355545ad.1
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783239310; x=1783844110; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNyCxijy9WsR1AOyIAocOM9RR1P64I7j0GHUMuAw51k=;
        b=LRKjpe88TYrJ8nGvQ5/c89fN5AZjG0oNFYZ8FYGz8oJefXOgmiHTVlvodF8fUNfhEt
         rulw4DX6q6cVR3Icatzl+rt/XNbK0RxeeH2zWmDCcNl7wNFKni8ajdn7h8ruG/oQkELu
         MZztF1xZJKTtf2DEj4lsL1GEmzsRPGI/wZDGtFEccPZq6utW5mux57ugcwu5F3Xcg996
         5hdNAje/e8SvoG54EmXuMiCWhHWXTro/5txEVrGVSyN0JsOhvRGsC00TFKP383MH4wIA
         B7Wmqrv14ODQmL4y5U/o759NzkLhxWPnPk8EgNxKzOrDPyExJj9jxlhKNbBX2CRL/ccz
         dAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239310; x=1783844110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNyCxijy9WsR1AOyIAocOM9RR1P64I7j0GHUMuAw51k=;
        b=CFxzeeW6sPWAH3T3CewbiONVkoGtwVP2L7kAeL2A0uicvS7Jp59oP9bCfxPDrDusyb
         enBmKzzap9DXuOb420NR4zQP57hZggSBSTXHp5XQpTGUToIj1h7JMfvW6wVH1CxMIVS6
         /Qy6CW/S5yaVPa0H4R3uEA9+RLlQudeHPg6DhQjP9Ol9OOOpzDBlhomAQxO+NGyeEMvm
         URpSwzIK+OiAB5cDkhHInsuJ/6EYRH0GA+FAgJAO3tj4AgsryJknGupSg+WIrZGo/6dV
         YU+Lbbqv9TN0DeKTjhkfYXNQGkq+Ov5qmoMPtim8Diqc/x9gbJajlzfRF1L5ifz4K9/r
         ZQPg==
X-Forwarded-Encrypted: i=1; AHgh+RoTktTPMc67/KwdY/AH1Q2EOiyWAMdwCo2vrxbT7MY115cJMpwjIpx1kAESag6sqUaqEg+9sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEKdnw5nNrfqu/Wfp1uaz6K7E7DV29Z3dkVoQD8WfDjwiR8SAl
	ny7PoShwiPcoEhurxybHyB+DAYZq8GVO6xWz21WK0xkhC101Ra99kSUYFdStxgr/9nfgcOkHKSb
	0DTGryuNuXysqXGhVV5ChsJdXu9lPUlw/YC9AjNrExl6yLxB6SQCNsMHetQ==
X-Gm-Gg: AfdE7cnylivKu9yjBfpfYxOxsNMDn5S3OI1ukC4u7CVQoW9MbArfbEn5CWMgRlH/Y0v
	sv5k/UREL2PbkoekpaM9Bwi+BCFYPvByNoCvzaB2/STKAB0Im78xc9xuaSauN3u/XtzrRk0AvGp
	30TTPom/MB86yB8w3sQ8iwD9GurKFQN2PHYDwLfx7RgkDFAlR8X/PVlS/MlxfglLpDLupEu8GOv
	4QxuzhCkziL8FP0O8Hg1eTc3pw2jhi5AXH/3Pp29RsItb6VUK3Uua8RuP6p84i50Uf9NVBJqFKk
	odwe+W50GI+EwHPM7rjaze4HjpvIvCRPqHWGR8RRvLSGOWVC902M8vdZVVTZ7NKBQYFmYo7K0UO
	d/PAkqa+OybQc8q2D6I9Oz0Vn9jKHRIYhp7A=
X-Received: by 2002:a17:903:94d:b0:2ca:ca48:c380 with SMTP id d9443c01a7336-2cbb9f17242mr60484005ad.47.1783239309774;
        Sun, 05 Jul 2026 01:15:09 -0700 (PDT)
X-Received: by 2002:a17:903:94d:b0:2ca:ca48:c380 with SMTP id d9443c01a7336-2cbb9f17242mr60483705ad.47.1783239309320;
        Sun, 05 Jul 2026 01:15:09 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:15:08 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:19 +0530
Subject: [PATCH 4/8] dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-4-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=1118;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=LaExk5CcIsnQobdkf+tB0TGQXJcIbfm+LHR//18ybOQ=;
 b=VCe5OcUC+YrAxAUSyCuNQqTb0M7+on6Cxws1+B96zvqSXIOvBEXu8K5mbkAmqcoJ/obMc4EbB
 40gj+Ln37yCAo6AFTXP4OAT10Srm2ogRfoYXQqUulwYf1GqRudc9cNY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfX5gno7kI73RPx
 flMaJatpDEbnz99DsRh9e9WQtiemCbU4x32GRgAf45ghNjAWvI5Xmz+l0VdIS0NfmyuFcv3QHTv
 CC9sI0iZdo9DA1//dCI17pS/5+SXGNM=
X-Proofpoint-GUID: f8xUyNXKUyM0aOfAZ3YpHUy-_x6sqgPh
X-Proofpoint-ORIG-GUID: f8xUyNXKUyM0aOfAZ3YpHUy-_x6sqgPh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfX8AjbfISJp86V
 o/HY/90XY5awUHrXz6XBqcSkQWa8Ha6rzq54AnQbXAocAGbihDrt9G1qsDVX7ZknOK2dSySs/kX
 PGAsfo5+sTkXbLzohJ/rROmUxUtXJ0GlwVHSn1tAm3cB+7rgf+q9bJX7H5ir3FdONsM0JTjVID5
 eRmlq39r0qFa44KwoG4P42bpYezqi1wCUh6H9pBN5q3yrIrF86TLDN3NTf8KwW0psQvioC0TNpt
 VBdZA7iBQVRATormmncD82x3iCIhT0F1LAgDxDGO/xp4vEcuqJoup/f8rKx8uleTcoc0e3nRDgj
 iUpmV2got2tgVH8VhePfedLuYzCKTAwq03Fkeqprz2L6h6lE21HoTwB2fvD9Y89UGlpbwwLm94T
 Q/8mLDg0LHQAL4c4578XiDtAWXBvg70ddH6Ph7a4EBSjpUXEbUErDcSl1kccjD8djlwP7eL7EkJ
 9rU6bTneEAJ0wpK+c9w==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a128e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050083

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ed556683817c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -95,6 +95,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
               - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
@@ -570,6 +571,7 @@ allOf:
         compatible:
           items:
             - enum:
+                - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.54.0

