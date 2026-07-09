Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25FF449985
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622575; cv=none; b=IRBd5ndoF6YvaDXc1EWMCKtCgTcMFgEm79JVw64NVmtFivpvHGCXuGURHiZaP0jm8d0SfHOVvmeCegC0G1JfgliUCp4QW1bxWe1Vs38LMIcDu8LCcMzTu/x4j4nC+8NRQHbjQ7ZAR22T5P50Tai+dOh3VDBcG11bJ6CoLOHITOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622575; c=relaxed/simple;
	bh=8G002/IxABPssrEzt3TqDoNY1L4MUJqdSn00j40u6ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=csSIAbzQPScx9GUkX2Z4XgGlSBpu2PMLTk6SOR2+wvCyzcrmQ/X9jxYG5K4O4heNWQ5rJQgRhPufKXKm0aOzetAMXN9IZ/BRsnrqzqbducWHyuKUN6HUNJ72DFZwPqPUEfU3IPOZ+3y9F+rcnblfYJvF5QOcDnpQHM45JwWWNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YfNQknXE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ADgdORLW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YfNQknXE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ADgdORLW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HXXon2473789
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 18:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=; b=YfNQknXE40JDrClz
	EHFnTG1PkwuOYhq2NNByi3fOFBH8S3XdJ4p84LWsrRi0ASDYyQRM6gNf06kEg/bN
	FmGvNqpXo09tetopfi9LGsQt721cySlXMqnluZSFr+ExFKgd3EctkIoJjijlHffR
	GozG87Gp00lltvfk1OLRHKtNJBzN1BJgoU12ex+wHQvFc/duMohJlGRW2SG/S4Bh
	aLHzSmxu8Z/jb+Nh5QEKnNYPrqiUBBCOZl6iRNe57xmTL9prx8PAeJ1NkYNET0F5
	+olZA6fZD3W4xF0nLUTIf5TwqOmC3Mx+PSb/CzLmFn/5wASY+scwjCdwSSzCuNoy
	6HVfcQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqphgr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 18:42:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381ed6616f7so233341a91.1
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783622573; x=1784227373; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
        b=ADgdORLWvPduG5AZwXnawC0g/sFbcDi9eeb19dlY/DblyPHmrHdFmqStUn2KWZo9Dm
         jCk4Rlbc9U3x/mmJLmT6IW+kuDnmVx/b0QVuJhS6CNVo4/U5bWbfOpf9GeZmCjdAfsC+
         eDxY6sR+ofyy9r/z0tmQhip+8yi/byxyRTIrBvUx+9kCqQb/STNYLjtUEM6yeKaY0dpg
         P00cozZcINlfqOvD22Oh+cNBJ6HEgigPSiB8o3HrIWfQd3pv7kRnikmrMeHXdeGdxr8q
         lJe4YyA+AeKE3xyjuHKkvlUXnBwn4xty5w2/h2O9DHGnuvgCjmkNeisVfk1G7J9N27Hh
         ZgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622573; x=1784227373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
        b=oNFC8czdAlzAOtDDhGI8bB6D7tPVQLa+mCmL754MSM1ssO56VPRW5ZSdNMOERUk+5X
         JHgDMpgTEzJk0T6m2joEj57NGnb/Z0vRDZDbgoYky3dOMDDOnzpxfDTNP1aaWPxzxnSf
         KrF98hwCqKbngs8Mx5E/SgerVAMSDTHpzCgWCh8PHo+z9MLi7E1MhF2bVf+wj0KUJyig
         6iUd7N4V6ReTI/+ojBmUKNxYKGm+Lod9fFfiTJak00VUBbOKPsra9Tlko2AtI+HuuPIU
         txNfMnMg0EUnm+cRwZDFrFLz95SsTWC2TcNMVkpbBSZuy4Nubv/sUfDRqZkGBGQcML8u
         lBIw==
X-Forwarded-Encrypted: i=1; AHgh+Rqb9JBSEiJ1fMmQk0h6Q6wtFL4R/WNk9ydsXsxK260GzPncJEAjeMCBFyHoDSF4NSAJk8UlLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/5ueD1f+V+IiZYfIsq3eW+A+SMvyRJVpwCsuzAs/sonsAVPyx
	yfW3DWNhxLc5HS/QJWy8sjJJ3uLaoIIbBVg98S9VqHYalB1ulTe+tTi2DQ9XQXFoW6pvGNGO64p
	TzQt4MrHMVfH37fn8mqxGN1+ffjyPjDWwP4vkxKHpMcXUG/UJbQULXtppkg==
X-Gm-Gg: AfdE7ckDLKTL1rZo3Ph3PHT9O+v/9uMahhaBwGY2VbA7Vo37EYc/C9Qs+LWoBi7+cQ9
	N4tvrpFSgrm48Rt9Hlst9YIvWPGYcGZbRA2Bj/jRZqWV6rAj+eClVTh8MeT5m24cqbwfjQNcwkV
	Srkk36iBWa898bks7KCVpEzwpfeqjeIsQ6BZozIANGnBIcR6DRe5ceRkY0lokvbat2hPQocIrpP
	UwqB6MO4oiUZ7niGKFJnwgRc5yo4vvn9m272DUurix+VWYXCLeWnL8aPEnrBJhid+16ITLiRsMF
	hd4BHZphSGau5oWHRSbEJL/r7gDQNV6tyJogrnbswRop+tS07FLwgRCSaP1mZaVbB4GHfCbIJxc
	+G6o1LT+PFEUGmGxRHt8CYv1sUQ2W8l4u9h8=
X-Received: by 2002:a17:90b:5685:b0:387:e0db:3d8a with SMTP id 98e67ed59e1d1-38943854a52mr8741854a91.37.1783622572621;
        Thu, 09 Jul 2026 11:42:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5685:b0:387:e0db:3d8a with SMTP id 98e67ed59e1d1-38943854a52mr8741825a91.37.1783622572199;
        Thu, 09 Jul 2026 11:42:52 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:42:51 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:02 +0530
Subject: [PATCH v6 3/7] dt-bindings: arm-smmu: Document GPU SMMU for Shikra
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-3-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=1298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2jQmU1XEfwX7ksFDjORvPn6m0bWV65j9hgt3Tl3GEMo=;
 b=ZHYwuBBmHydbbYbR66h8CvEw070fSbVdXWh3mYBcTePopE1EO2/nQ2AQyCyuVLwlR9uzZCS7X
 FeMi9LFyjJrC962OmSUnxwOhByuza4MZs+vELBPqh9Pj8eXByS5d7P0
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX4nSZGLPyRSub
 SO1GvRUC1tfHbhvUkMrmsKwVJCNtakaLSi969BoRbhrJCMEhj7LsAM69jLZ55hM2AKlkj+Vu6fA
 gA3OIQf9dTmHfKdqycK/2iIXKcbKw5MQqBP7DKBFbjrDsgFvFnfOXVZwwkEkhN+YP9mTNGavx+X
 fzG52bPFaGDsmtpw3dtAAj7utgejTkKmIouv4VnT+CcaKtbIhlxO9xrnZbwlGPZM+Y22v4fmZ3P
 OTjrfbDUFYVjg2Lm7Uu5q4wnPBTeBocFBc1T//xFzs+PrU/hFzcUHyXzckMGvfo88J2keWz5MEk
 qoxcUbH0HfeYjnJUx3DGEbha98sKITxUzUtxcfN5GAGrc4583aDYnUK8lGL7B5aRv7CXP2pF/oA
 2xbF5xIdlMjScyB3lKWN676wrGLr/p+neImvjPno4mdYjp8WTtm4Oe/poakQoPJZ+jL31wOTvXN
 Y+T1e5Ehrw368K5X3Dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX8t0KzcvIkXuG
 5zTQEMKsySlYGi30ZVGm0Xp5J/m6cHfCJVtLy99Vyd1eQ+cIhAfZzvd7nis/H4/AXBSmLX5v+b6
 7fE5sQsVKSIFe+o03qOmGZXJlQYpYR0=
X-Proofpoint-GUID: dBjZVYV5czZMF6W55gmKCmN6_Wj9rais
X-Proofpoint-ORIG-GUID: dBjZVYV5czZMF6W55gmKCmN6_Wj9rais
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a4febad cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090185

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ad15fda5c25e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -108,6 +108,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm8150-smmu-500
@@ -543,6 +544,7 @@ allOf:
             - enum:
                 - qcom,milos-smmu-500
                 - qcom,sar2130p-smmu-500
+                - qcom,shikra-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
                 - qcom,x1e80100-smmu-500

-- 
2.54.0

