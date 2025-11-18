Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D03093B2
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456028; cv=none; b=K+Wiv5GlprDChCw/bKk5dUSTDl803W0okBsfzjEz1OTW2iElct0n3X4U6rsZFqauFI2MEJImJOqjFpKpSZT0Xkriy2I1gwXxk1aDSTw8EBBAfaRa8c4PyQM0hknNI4hMUSt6QrgMoAnjzdxv4tq5wa28oeppsNoAG2aavqvxwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456028; c=relaxed/simple;
	bh=b8dhLGeLQCmbMQGCYbMJAVhuNtUDEylRDp1y1629j4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=An6c2VyDtFgUtVP9n7FNLOs65TPLBZssOlKA64mbFvafDz9YrqbPTLdsClSHEOeQTysWF8iffIqeCztjsO4nSTRQbcjij+/Llzb6j1yl6d36qFAFt/7id8tpI+zUkPFl4QEUw/nWhdezwGXYIUPqUpdhzXDKcR6A6ODWj1kU3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LkM0/TTx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DUmM7Pwf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LkM0/TTx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DUmM7Pwf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6FmJn385449
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kg6FTa4q14ZNGOkUdnGlMucEYQPn2MtoqjU3mnf1uE8=; b=LkM0/TTxA6iBg2bp
	caqvCVp4AjAO+m5Yu2BZAMmr8BO7QlZoBeEw+Hflflo3pG/0iBP8C5s7vXjiKk/J
	R1bCYLuvJ+V0DganVweVFB1qcAgnVXA9Pwdxx0yCBQ910NYtuU8EC/84LxjkRDqf
	Tp+xO9z2tVUlzVQnxkTCQPKpHDSOxn9VWHG51GYoEgNO9qWgcrEQ4WBccmf4G549
	78m6z0UOZQMO8T8JtxWZ3PW3bBT7NFb8bITNhHSxJZcKoqCjbauPNME+rgRUF8Hx
	ktK3Q+oRU6eDq/rReA3pk/NEMoIPjmI/Nb56Hr3LnPAy7Rx/o0jKpVmuwJjiNigZ
	QCoHig==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agag8ht70-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297e66542afso177425455ad.3
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763456025; x=1764060825; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kg6FTa4q14ZNGOkUdnGlMucEYQPn2MtoqjU3mnf1uE8=;
        b=DUmM7Pwf7VDe0dn7ldLX/2ai9sxu7SRm6nM9qvbdU+hzmdkSKjAz2XqJ4leOEX3TnV
         4+o2BjR7iy1ZxEz/pp0RimWED/L/3IbkzX7GHfIrvNF+QVXJG6sVmV5JlW62zGm1+YoG
         jtAshWsrblxrPVC3NsCTj3YhyjR+CzRKGMJhv1/6rv0JMd6HjVWCLc7lmhZgxyn2PXv8
         IMYFH2Y2ng3QraZCMzCLDAT8ae8WnS6c3hhw/LEo01V0dL0tMnwcA7ANhjE8B8IQkuw4
         Z+UCntUi2921TR0S1R3zM9D8u50fGwfJQlypbGULFhiiWwqV3cDBb5UHPj7qOxOXWSVP
         8gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456025; x=1764060825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kg6FTa4q14ZNGOkUdnGlMucEYQPn2MtoqjU3mnf1uE8=;
        b=kfX0Fx+qdDrUQjUDM9WKohfQjHLTsBYIjFXJrJBpP7CyxAv6bZv0vj+c4YZv/HxsL8
         SAoqRXgs5WE2E7v6SJ8NrnzPZKAEK9rYy0Y3peELxtQ3Pg0nNObXE7d3boDr4wH7AUj1
         FvqQbcODChrob24zKP3xqu2DYbztasK/iSirlB1ihjup2c6IiOAq2/BDjNbwNmGp+h0T
         z14e+Za2pOl0Y7/JUZMwZeIL1DgSPqDAtHdpL3S/Mxy6zPPQLylQwjqdFwv84WFngtdG
         KFzLianiEYRUKbvNDG/7/G6icTQaw2DKuJw7R698O0/X5AaW8ukoJQHFMWNVROeljnU/
         tidw==
X-Forwarded-Encrypted: i=1; AJvYcCXKIY6jbgkaAGM0l0H65U/2NVCfOrHvYkDEBP+J9l99epLrIMrsIHuBZ+yRqmPqepz1ckaNnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfbydS2xB5fjbqLnxXqlLQEGSOTGMTiDV2hi6ag5aDhHlg//9L
	12fCLLPI0Iu2/YDAx4u0LnzBXNEFE7+jk3LDdFOrex3VAGBL/ssKDNtAtKukbSc/Raog9/nZr/y
	BStQ/ZLEaf5ShQhp0RRyyFRKawO10vBWuRfo2B3awDNvv6+sXVkOh9SEDDw==
X-Gm-Gg: ASbGncuoNiTLJdoTzVkbVZ+ns7n3ToubTw2uK9q/bDuAxWIyJLaPghjzlTyXlrU4oRJ
	3ApfhkMUFEvJ5sDc6b/fwhHZNiO2aySlowJCbKWqyDdrOoGcjXsQAdL1wX6Cw/nMGNwOzNMUY89
	TU489j4ftUbewW65TlHrWAseZAry9u7XxvEB42jDuxRf4XJv+Z3rY14zp+V8cdk0X++7UFCdGzs
	XTOSuoDXTrzHqGcpSxU/mZ7GJqxXJNAnGUlz1UugwjCXbe/mC/4uyA54+Z/cR7dZUjUcIBydKF0
	nbMEmmtw7RlQX6TZtFt2gF65WN7XdSDMyvyIJbLXOPoYqYcHji/av3lTfpVb3OPGPKxzfHXZHZl
	m/k2Q8xYWOuDEqscNBI5VtCQ=
X-Received: by 2002:a17:902:e84c:b0:295:9e4e:4092 with SMTP id d9443c01a7336-2986a76b624mr185293485ad.56.1763456025374;
        Tue, 18 Nov 2025 00:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJLx55VIEQR1X1kdhaTupHT64CD5j1PJ74J97Jx8OWItPIbJf1c2CruPdv9q63aQsbVJdMRA==
X-Received: by 2002:a17:902:e84c:b0:295:9e4e:4092 with SMTP id d9443c01a7336-2986a76b624mr185293105ad.56.1763456024830;
        Tue, 18 Nov 2025 00:53:44 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:53:44 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:46 +0530
Subject: [PATCH v4 19/22] dt-bindings: arm-smmu: Add Kaanapali and Glymur
 GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-19-86eeb8e93fb6@oss.qualcomm.com>
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=984;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=b8dhLGeLQCmbMQGCYbMJAVhuNtUDEylRDp1y1629j4w=;
 b=jOmgC3U/mxErhlMr4MADnr67IrIUEIl8TZO8WCrxFy8KxEMIAkZL3bL9elKhtgNJKsYb8oNbp
 LrlluiY4THhC/9gW3BN/csHmcffGEBaqOL6sP0AXVDDO4ygLkT1IjBr
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: q7QU5YBR2e_kPQoiwX3e3paCus3o7C0V
X-Proofpoint-ORIG-GUID: q7QU5YBR2e_kPQoiwX3e3paCus3o7C0V
X-Authority-Analysis: v=2.4 cv=G6sR0tk5 c=1 sm=1 tr=0 ts=691c3419 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=nx9Ee08JJy_q_36Bb04A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX/5A0wv74ue4p
 zcczEh2v14/p01rjFL3feA6kzCEuvOU3YmNjNwV1pUBzxtmiCqj+v53OHblmxFAptBFy0AfoUTk
 8o8bux64nPSMRzvh7fRna1951z5a09lKJE8I5FFQkYTDoOV/51a16xNpOA7fL8AhwvHgvvC/KSd
 wVPnB4mtytxN/cbnqMTQPSrddEGi003ZgUCmChcvX/NI5c92x7k64R/txkipSSdJ+psJI37uBOY
 B6o2qLbN60KwN9fotS5R7W4ysNWJN8ON6Bi/WyMtvrJYMhEgAH1DVv0LlOd3t7axm0apsQhE4my
 Q1Oi6rCByyfrQshwBpRPJaPHRNARG3DQNZ2qW6m1q3hfxxlfozaHnovPQ2u/Zx98Z3q7ZmE674l
 sxA9K3VIp+lCgIRIGE4vilPSM3Q8qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180069

Update the devicetree bindings to document the GPU SMMUs present in
Kaanapali and Glymur chipsets.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 89495f094d52..c9efdd1a6d1c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -89,6 +89,8 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,glymur-smmu-500
+              - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500

-- 
2.51.0

