Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE827BF7E
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755952; cv=none; b=KsTfK7irHuWXgtLPigiIQyZukw+wQj4Jx9sbhsjp3st9QorHLyAs5mRbRwgzrLIJxK22A7sA7fWWyedMKTo+sb7HvzE6+IT2OUQ4ceRcvD9r7w8+m5wr+/B65j0gGTovvm0a3wA7h6Cy/09pDldJ/ik9p4K5ApZ46mcCBfUv+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755952; c=relaxed/simple;
	bh=gM91KjfpF6IH0eLa0TrXrZO0nOEVZnjXw3GmCGYPcTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qFCa6nG29682lJg6IxAmAXp6oV8BLPD+KdPQzZdyfC492pr8yt6OVfkuK7n5jyCRUTkMtVCJx4Yo/yOBxCak76XASArp3NULk6kCYjsTxgCJRzcGhlzxviVg0+chc2eV2n+heK1nHLCurCauXafodSxgWUWrnnoJtti3H6U2G/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MwY/sVsJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MwY/sVsJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCTQLq017434
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 23:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TZvxXC1Da8p5Z7MQXHlGe2
	85o1OSAb5AblyLBDzUI2k=; b=MwY/sVsJVD6gtds/mEHZ7zYZdaaSLO2R96JidK
	ZE9oC6rx30gptMSyiW8TONl3rz0P2Es1iQTFuFPUEyghCAShEFg84yOmEC3ESpd2
	XPPxLlhn5X7KGb7xPh661wY0jY+hupIq7Lk/cmYx7jWzIZsca+a/i1GEkeq2t/bW
	gdrmM2jVG6c2vjJeyUlxcHyMX1ufXyTCmGAc+e6gQ3r3dsBLBm8CFs9aOM8LCdO0
	XUTkOxCbGBFy2VcvECcuhPSWXRe0WP8sN7r53Zb6ZOFpM8XacA+5q2mG21zwLCuA
	p2JQLKZ1grZKKmo1HbD/EjbFKVaF8+A/QqQnYHKmmf41Z4kg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjybfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 23:19:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269880a7bd9so3298345ad.3
        for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 16:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755949; x=1759360749;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZvxXC1Da8p5Z7MQXHlGe285o1OSAb5AblyLBDzUI2k=;
        b=T7GYuuWKT9Xk1aP8cGgm6/zvomtrF4rEleLGs3C7DUn72LnegmJRYYVXVqizqNb3ze
         v57DU47RtSO08tp+hJcxsh+crcfmZ3tgNYRrqG05ZQcTD+xsuMFd2s/+fYnKev8eL5qE
         Us/Vhw3Z0g4nQqrrACbtbgUgErNgtKhB1l1F6cjga0pAj9s0jzOKPmxtdrnzqyQQh/Yf
         1XAJem1w7x2N+tQvz2b6EIojbRz2rRxstulPCuMQPphrKzTLGj4AJZFk2S6xCQVz2haE
         DkoLGpqLRiiBuVSoUucIK1cxIMB0Ip/XLYPrl091Kfq/tkbelwgCaSV/x7BOjGaTkWcZ
         wiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLn2rFjuXSFVxyPtot2XaSgYakr+lUm0hUfLlSp79IfxEUGnJJEq2AxuCJ0mQeZipM3rXYAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzvlD/biE8X+qScRhQs6B+GWbI8/sQWIOt/4G2RYzx6y4YdUr/
	heIbcnN/th4xIp906zaObEqdWn57RjgMFcm2x9Ypb3q31QiMUdev/BOQYzM3O/VIUFCgb5gtH5O
	Zhnc+G7fS6o8zQZzn6rkDZ/uGeH2x2dY/rkOSybCNiCIeyrKzLsdeHSQY6Q==
X-Gm-Gg: ASbGncvGSTryc1s8XfFMylCeoXFlelXt/wmBBLvhKcpbWSRE6ri8oo0toTo/G4ZwF03
	BFXwleBI6CGzCicMH5/QMyhKbg/9wEIgUy5Ex682Yg276SVeX0wRg2Y5CFLVZqfMgz2FO0bo4qb
	7pTwVwQSIketnwh98Ie8hqh4JeXCZ1ENvB24rTZLofRPgxfn3Bj7DTsGAze9CDdc3PB6+8UhAcv
	mjsKzjPKPaT4te1kuXz9Xe+iysS7DqaO6JlsBMbmamLV/6pLFLxd0M0pKOm1LI3XwAVmGnpvnnY
	0AYlZbMgifHWNthOcXEpgcpAMMZ2bRlUbHUlTXH9CnPWGDxa4/Nsq3It+EMzjagNICN+AuCskDz
	/RLQmz0bz1+Owbeo=
X-Received: by 2002:a17:902:f786:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-27ed4aab57bmr13504895ad.38.1758755949325;
        Wed, 24 Sep 2025 16:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0g9Ol1DLkKsMps31M+yJ4FciPrXl+4Z2aimAO1Euo/GJz88L49z9jFp2vZBDSGu/BXgvxkw==
X-Received: by 2002:a17:902:f786:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-27ed4aab57bmr13504645ad.38.1758755948885;
        Wed, 24 Sep 2025 16:19:08 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ae5742sm3780325ad.150.2025.09.24.16.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:19:08 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:19:05 -0700
Subject: [PATCH] dt-bindings: arm-smmu: Add compatible for Kaanapali SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-smmu-v1-1-c93c998dd04c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGh81GgC/x3M0QrCMAxA0V8ZeV5gHYjMXxk+JG3qgrQbiRNh7
 N+tPh643ANcTMXh1h1g8lbXtTaEvoO4UH0IamqGcRgvwxSu+Kwbeik75pSjJJ4CM0HLN5Osn/9
 qvjczuSAb1bj8BoX8JQbn+QUtQnCRcwAAAA==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755947; l=1108;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=gM91KjfpF6IH0eLa0TrXrZO0nOEVZnjXw3GmCGYPcTY=;
 b=M77WsMOYGM4ezbvcuE0+jwkiEKDZIc5oCGJ3kWAinG6Bm2tIh2U9P2cMYSNVuetK16WO7HN15
 E0WuBxhINLrDwbwXlqCX5PI3z6xeRZuWHmUVd+MZj4ScpV0tFVAt4xP
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: O9dHhPJ8ssr737Xu0NlN-K7pxXiYEEfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX1HJwN2LbBNLk
 wGHaE0ewpPnkSkdkpZZHBDTh/zWg3RbDtUh7554egEIbhrjYZqTbsOXbmGokKy15RpNI2r0voML
 E0/mRGBlIJwOPfddO5WyGdZm8jDyt0YGdsg6F0NmTg/YDD3gEBdymcoMjRNXWX+5fnV09bmBoj1
 T3GuLne7DXCrd0pGvd0aeeSVIQn1m2tsQeqSM/17hhU3KKIocO5ZhWP1bUYqmSIsVZmFK4NzMAT
 wIkEHI5SLQnKL6T48UmJkzf3qLk/WghKLlu1AUo5AMwdp+j1Q/xh8euCOPiv4WlC5AWJnYfbiV9
 5c7g95PQQ0dRZCKsaAZSRKboE0X6bxIi+siDsmirKX0Fh0p0I6JyZCd/K4FR+kCIuUe6E1oQaq5
 OabgyblU
X-Proofpoint-GUID: O9dHhPJ8ssr737Xu0NlN-K7pxXiYEEfI
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d47c6e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=67qX4AuaID9EHpsuXEMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Qualcomm Kaanapali SoC includes apps smmu that implements arm,mmu-500,
which is used to translate device-visible virtual addresses to physical
addresses. Add compatible for it.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 89495f094d52..261c4c699a60 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,7 @@ properties:
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-smmu-fdfcedb91bba

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>

