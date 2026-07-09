Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686A43745D
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622601; cv=none; b=GVVhH97MG8XIso8DVjMRfcFUReDY8ymZNHuQB10srGjnd3SnRycQN8pTK2k3atpYRHXn/7eD49Cm5LC9GbfwoU/qJOhoxzkSYWHQxgMfipJvc8mpMtTgwwur0w6OpmhTtRoqWmGYtgIy5+Ynt5EM7XQq3es+TxkoXDNKu54XG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622601; c=relaxed/simple;
	bh=O9niL4UAC1BXVT/0hAy727laAjQWWk0ZIJq8uv4T2Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbOckzV99/03QIfR3JkXIxunLLKlv9zyQcUDGhQCgw0+Rwa3HlKAdqIJukY9u+DdZtcWVTUgdAv88KS8xwy0kxSpGYQrWZtGhUDiL9R99C51BdfEMnFIImoPXyT2/LsTCUjc83vZy4DoYL4os7j6+llTJkX/INifuM6htGeiY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kttAp11+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BtkSHldR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kttAp11+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BtkSHldR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HWtNn2502336
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 18:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VZQa/mqvt93chY0RVU5zPGmb1at+p5NGdnFyV5RZOgI=; b=kttAp11+1wwuB+SO
	rITOqpWpy1QK9fpn+uMaZKyNalwD7bIGGLtFn5BeOZkpPVi/+zNYM+KkfvzDRdlL
	J3kAbwQhVdMMv4BPn6OIPeS+XTWxyKuz+l34yGxtPHIgNHjbFd7nrjHkeC7Jnkcb
	tDLPYYOdjPN7VbH++3Q33STz9tgjxtB8ptOCoaeNIpVOt/Y8+wpeHCWudekjg5Q9
	GIAfy1rL70lAHnOuviXTOLTLdjlupoibNXJ5f2gtBsntJ5Jnai9X7QKapndaPOk3
	VpVPC/mEFbUhgFNzGW6NNAyTxDPyW4x3YesjtJ8I7BskFT9hDf82Z/qilaa3KWiU
	fg/eEA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3uctw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 18:43:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cce02cb769so900815ad.1
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783622599; x=1784227399; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZQa/mqvt93chY0RVU5zPGmb1at+p5NGdnFyV5RZOgI=;
        b=BtkSHldRwqLkAja4hkV4vYmVTr9CM/C4mKXKhvBfxgwmzzODcyERK0ruNRicA/K5Ee
         zxGMHywzXX9TDzsJwwgBKLvb2PAzZwWmOWaibEGr3KAW3cIQVc90cApHPwClauNuzn0m
         CgV88AwWzw02or9/53jV7uJVrqrnZG3LbmEeyVDZ0yUoR0DKJMJGxyiVM5TppJyua9UC
         HZ/V/ivxTseHJCGF3V8IaF1oDfFXUmr8QiVAIJ6k/hT0j/aDPKBNQ7n+Brz5QnUSzglJ
         ImIEQGT0wmwHF9n7108yEllO3lVmOfs22rYeRIZznPweN09lNhIyNQlAXs5wjNZ2nUpr
         K6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622599; x=1784227399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZQa/mqvt93chY0RVU5zPGmb1at+p5NGdnFyV5RZOgI=;
        b=ZJDoyAqed7zlVVXs3K0owvn+j0dTFw5xxoANX4EWXGSfQ8Q9fiiH5beZUYREyHhJDN
         lFvEg879ByieXEN3RnSS81YQrE2jzeG4wZfDXl9BmJ8ise0GVZ08fg3F2uM73jPQNNJr
         h+t5Y0GmISrbFK9IMZ9LP5tgwnG0dkq97wJi/nH2awZJKJBXTd16b3OA0U1hQ+t2dKXw
         lJ7jZVwB6AKfJZYwnVR/Z+sq0OLrCnF4fgow2W7nrgwgT4njotnwO6UeAnfrRsEZflt0
         MZsR6z3nzEmM/ofWI9eBfgdtqLi4ef/Hn3Z3WFW9FpgR83iN9LQQKzAFcReLn+iUwlGS
         wuUg==
X-Forwarded-Encrypted: i=1; AHgh+Ron/FtzW8CQZSo802n/AOU9y+IN1b2YmpZK+0Df8LgyUlQ2qwNe/zX2Tg303Onj+3njdwwLKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf8l0ekyhpfkaeHCCZM+dOSJBrBekg4CuRfwVQTtIUrQKJj9RD
	UI+Fv1xO4y6yWAaxl+W1tAkgJS+AgLMbeDz/TL0KnrgeFcJNS4F0BtNhypA25BxFpjZpGSOExAN
	0JsOtoLoNNy9W6U/eCwaXt0HZIYc4kmQnISI5WgaXbSEI0eJhcr2KT09MCw==
X-Gm-Gg: AfdE7cnqfHCR4A8ojkpZzkccPo7JIYn5ugmuGb4i4ipm0gJhsklcJaWjqod/D2lt3fh
	IVeBZROClOR98IC47O+AOmmAzReTduRsgy6oTJuUZn1v4rsS8U4oRzr9oj0ZJg5dKp07IwUpVbm
	gkV6WLuSY1pr7k0viSExbunFJ2XW+MzmFFLqffI29UQ//KPkBFrXqazuJDsy2teO+yY72LC8bv8
	KYYKSyhV8RylzoYOJBoTro9MA0+srZemSXsIpgPHxDj+y730MCFB2lKbMMg5wp9eA5sDAvGXfVw
	UDgLKuRbAFOBUuXzuiE+pj6p3RUM2rdW24jE+ysTFf6Cszbvd0zmUTC0u4j5EyAbR0H7HQxJJ2v
	GrelxfiUys5yiZWpqqlGCqbWqTm87wMSpR48=
X-Received: by 2002:a17:90a:e7cc:b0:381:9ff6:3dd5 with SMTP id 98e67ed59e1d1-389415e9f47mr8816684a91.25.1783622599276;
        Thu, 09 Jul 2026 11:43:19 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cc:b0:381:9ff6:3dd5 with SMTP id 98e67ed59e1d1-389415e9f47mr8816665a91.25.1783622598836;
        Thu, 09 Jul 2026 11:43:18 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:43:18 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:05 +0530
Subject: [PATCH v6 6/7] arm64: dts: qcom: shikra: Add GPU cooling
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-shikra-gpu-v6-6-b388ec5dce77@oss.qualcomm.com>
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
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=1606;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=hyEGcjwM6KENpeiGPhvJEAD4XFMZNW+63d9GkBZxZpM=;
 b=NnPL1pTXwyODmjoz9V6QImzaxRVMlFXSMFKP0EI3HRuym5woRxSxuwPBcZ6F2RmFq4guFSEBF
 HlxdGGQu0CeB7RqV2YL9E3KoLSDrA8wK8H/NZ1rspf394vAZc1s+TfN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: n6mbtepEnzqNheQ0mz0q_dO2DuuOGaAr
X-Proofpoint-GUID: n6mbtepEnzqNheQ0mz0q_dO2DuuOGaAr
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4febc7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=tZdy-_Mj5ciOPZFqPb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfXzyyVvbva4gil
 vywW1BgbwxP7MGR4lo5MT77Y/zchCoM+22qL9x0OxcJo/tRtjaKa/usWMpIiS4hH8MCUhkrffdF
 7b9TKBNgf1A2pEyMMVT5Hol6NoVq6/k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX/MWXXZ03CNz4
 yUK0hzf2X67iDESCa6sRv42CspsYzb21+JKbDfm+FD4dhQp+X1fOeW4UqjG2mugQQNgcIuWdJ+/
 iOGqo2o353e5cgE/9gY1JVImpY6ZLfiAnKYWdy5DlQWChnTSJF1b9pGrGAqZzeEtsji7xfUIfGO
 jwNWSYuIuqvNL6/2+36wf5Mgd+G1D3BsdG78/8lz+toYNAU8tfJBj/g1uQ2wJQ9IkBCRWNVQEFG
 WhIz7XSFKa8NsyZ14jhdZEtO7aqo1tmPQPiFvEmqBWw8gr+DWgCAcmRfq/cIIv/MuIrLEDW4qyA
 bVgRuxw4Qb+eg1hOAvr3eFS3C5SSLP1p4Q15xI8OEw3nX+HRFMvTCqVp0abuCXPAl3Q2kiQvdXK
 hX7dDJOYl+XAaUkLHchqvB/qNYaqRVpPxEJ2JZVt8C64lZZ+1asAerf/tlOT2nrIX4gzgYuTuRj
 glbLzgfp8Yqkfbo4kgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090185

From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures. Set up GPU cooling by throttling the GPU speed
when reaching 115°C.

Without passive_delay, the governor fires only on trip crossing
interrupts. Temperature stabilizing between two trips generates no
interrupt, so not all cooling levels are applied. Set passive_delay to
enable periodic polling to ensure all cooling levels are applied.

Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 34261221664b..eeeaa369d3a7 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2510,6 +2510,7 @@ cpuss0-critical {
 		};
 
 		gpuss-thermal {
+			polling-delay-passive = <10>;
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -2519,12 +2520,25 @@ trip-point0 {
 					type = "hot";
 				};
 
-				gpuss-critical {
+				gpuss_alert0: gpuss-alert0 {
 					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				gpuss-critical {
+					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-thermal {

-- 
2.54.0

