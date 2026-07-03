Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F134B662
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110957; cv=none; b=gIsKiIuuYXk/Rjk1gFULMSIFnuD7ouettvodMEBw2sXdREeNsD3A71CW9kb9KUNxgHLBwa/xQzfCs+a0mDrxX4KBGcfoU9DedcCy8SoRi1z1Nzv90fplz41m7603Uwb6K35STPcC4mOdht2BJtaF5cCVLGvUEB/bxJqpTF9NsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110957; c=relaxed/simple;
	bh=yGsij9VKWI7rB/vT0J8nK7LauF77nPjz0MJTy7VKUkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0AyLciQEfpdV5zYSr7pv0HxJbiFTEMwt99gP/E75uWs4kqubabSCQncrYceGdiA5jQwumM45BIWQM5wCUZ/U35/OjiHliX5cCRbkn8r7BG4CZyjjMCwVmRaC32jYhDJ5vfCljPWOfwGEih5gc9MsgNIp3CPhanT8yi2hLEvohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kbXCX3Zf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PVAjMDOn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kbXCX3Zf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PVAjMDOn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPUMO1019917
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=; b=kbXCX3ZfPE8xGbMt
	vMJtWU22XsCFV4p57+53pKeA3sF8erE5WGjuAIJ4v446eiEkXE9zyhh9NUiRUtAV
	vtfMB12w8Zz7nIM3aJN8gA/DmwzV0BKfCjhOp3EVC4ygnbJAzWsHakrDG4oyQqt+
	nG3cBLf8FbOA6iGXzcsCDQbwZYAI67JatbACMAOe+6vCX0AyEq7EJrxcz3AGLtfo
	qBoQg8XhoCRmU5wJTrTsMd1eqsCOXQpB9KeAyrASJwukltn14xq18TPfZY57Z0Bi
	b7pMwGhGFFb5tNuFjx1PGGYtj9SN/GmngMJfETIFQlcjhqyyIifDM1pqW3uDuvwz
	HJ+mog==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkhd8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:35:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d97955899so1341376a91.0
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110953; x=1783715753; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
        b=PVAjMDOnnFJ1mUd0odUsKmlZEpqix5Rk3+V97yZXi02KwBQFA0mxQ63KOGJV6XnsXH
         iQCg2XFcshva4Y3moRcS/tLYSQBeULWUBemhGzY3Df1jwkdDhOhE40whOVetWMlqF+t4
         4tQDkY2L3C+qxqc1ktAhLCNEFnP5PUD8RzAFpCOa5lMmT/w2DeT2EvrmLoxZw1XlfFnf
         S3lQ9yre9oFjSKlIgjgd7TegfYkz93ER8v9GlcsTwEoXhHpnIO9sdhAQATlm6eHMUyHI
         K/a6u3QXJf5a+0NeA/LYuUzaedqXGNTk1a3UES3XSRWZs5l4osXn8xbv2ANxxc2f722a
         bWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110953; x=1783715753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
        b=mdXkY8We8T+TcO/qb18EMhA+p9nzxwAd12vNsfuXgrPEgMA50c0OGsoYRHMLwBvr+V
         kB0LDYPATp3vk/4pmAoWG8LJCUZ4F+x4Mu0bDaeFUoWgipVa7aXljPlnrhwRmO4UwdEO
         zncstx3/E5gpsfmxUC7ENWCpPiFWk3nnZQ3etrz8XjDPw1LWp+VgZkPnMOg09TTO6Q+b
         wmlBZ8PMURj1PQVxDM9pkVEQQlxOwG1NcqT7kRunNIaFoA/kS4oD+/Jo1fZnbvKK+4JD
         YvwtiVqGJHStwa6+loxAyzdfZfSlohQv3ilY7LXE7Xfy/t4ITvOE8hS/6a/UtB0hO4TO
         s+1g==
X-Forwarded-Encrypted: i=1; AHgh+Rr6gK9iQ0/7Q5WD1xYJ00MYyOZXpm4EL8gFzw78nlk++mElEikRaIzuKFHUYrT0ii9+yBbH/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi/7X1UOjSpqKXYP041jZukzAYxiZHHAnXHhd/H4jjy4rHE9oE
	9rnRN6UkqpMOc/AKv+ATmipnu10ZpYtaATcqxXuiGBqbVIkJRuQYwn0H/2y9upl/9ySdHAODOpp
	oLM1QDDzQTE7J9j3VS6dkAWhZgDsweS2LJwWJWwM+aaCW/M+ZkNcr0jfpZA==
X-Gm-Gg: AfdE7cn5NC/aE+WT0xtKksWGV0Vqv3MGKMXeu1Po3GzkZJDGKOutjEkjKnCmwF6w1yi
	aR9FCLDJemnH6mX4jagQlo1/Ur1P4S0qZjfU1zdiL4lqRMYfg1/tVAO3LMzkTunxNg90xpJN1ei
	fEOtmronGSiouGYesm3sKDoAkVSugTgO6ldoLpMIQZKi3ChCOsaCNS/0MXJCNCX5lXULxfEPcLp
	9mD92u4AkKjzqJ0Y4BEUx1oGErdylpN8Wk7BpKZGwOElF0cvaip9A3HJ4DrGIdqLiXDeJLkz589
	PHpjGpHp7gTy+ERPxFpsl5gbRdrbN1MVkjy8sxFka2ih+tnOhSXRSNDsJ4dznK5kK2b8WaMJt6V
	Ws8tymjGC8Aa2sroTIeT79Z0bKu/AGtCDeA4=
X-Received: by 2002:a17:90b:51:b0:37e:2053:348f with SMTP id 98e67ed59e1d1-3829f7e86c6mr859257a91.25.1783110953171;
        Fri, 03 Jul 2026 13:35:53 -0700 (PDT)
X-Received: by 2002:a17:90b:51:b0:37e:2053:348f with SMTP id 98e67ed59e1d1-3829f7e86c6mr859230a91.25.1783110952611;
        Fri, 03 Jul 2026 13:35:52 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:35:52 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:30 +0530
Subject: [PATCH v4 4/9] arm64: dts: qcom: shikra: Add Adreno SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-4-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=1898;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=EYNcq3OFs2Ql/wREKtEM5ji0GMxwTnKnJ9RpGAjMe6E=;
 b=VV53sBo/O5fZ+NGsyhq4LtyFTf/b+WQ8uGjvE91A7dZXdXWNqRQAjopFaqZ2FFIMEKi2ZmO1b
 iWCZ4r056a9Aa6iGB0aED9govTFpDOH8j0BvDycAX5GdmmELVWBCWVb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX3Mn1E/kZhT15
 cLjKlmGqkOig94ATvPwbRLQNCzNKh5BPuSZkGXbOBmQ00rIdrs0AnjMsigZiT8/Zt5Z7iw0moEU
 ZAGWS0MOX235Qf9wBzYr2JSdXCX0gBMhisr/iMh+yZMPASiW1hXMSsvbHBU8TBVBWMqJfqDbfCR
 DTD9dyfCr7+xITGQLIQXEOkGz1rKtQtro+H6j/EP7fDHsbd1GCT4RRoKMkhKWy5JQQF15ELSahT
 cecm79rDUTjJovz5MzgqY0j0TqxbAst3hXzve9glhyhZEkYLJLlP5CzC/WoR1U+arHpnHJAhBGM
 XUJk8fljRx2rHSJ+IlgnYEc7rsxTUlnXl9JqISFZrwEvw89bvH2hQ1b7dBFIV/GU7+nhb+7bVkR
 peoRWHEeWeMA3kdxaXIH9CzL7iHmSuzHMPY/V3a1xXr8TWZl2n0AFwdEWSVKCLhqHi3yr3nbRgU
 ENsmrsWzNxxDWVWIQoA==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a481d2a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zTWU315qYGxAnKAOPQ0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Bq_fU8BuS0OPoWXL0jotlr652VNVgKVS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXzlYzVIFBXe4O
 Ih+UN35zR/oXP/SFyN+MjxY0Uc30C/VBBIUzHEvZcDP/MxgKSuFk0ad7v3apIi5sv2NpEUzrd35
 FzDzZ3Cnt3uYgm4JEX1QTaSPsBSZGyY=
X-Proofpoint-GUID: Bq_fU8BuS0OPoWXL0jotlr652VNVgKVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index be443b362576..bb11e832d9a6 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2005,6 +2005,35 @@ gpucc: clock-controller@5990000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@59a0000 {
+			compatible = "qcom,shikra-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x059a0000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>;
+			clock-names = "hlos",
+				      "bus",
+				      "iface",
+				      "ahb";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
 		dispcc: clock-controller@5f00000 {
 			compatible = "qcom,shikra-dispcc", "qcom,qcm2290-dispcc";
 			reg = <0x0 0x05f00000 0x0 0x20000>;

-- 
2.54.0

