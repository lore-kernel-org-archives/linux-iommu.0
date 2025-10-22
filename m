Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027D78F54
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113766; cv=none; b=sp5nVWdKbsfCEkbfujW4KgWufKIQJtUc9VPb2AJ218l/wjA1AOBNkBzirCz2jhGiDP6V145qz3maGgJYGRcsjU4OQ0kmV6BW3S0MxfUwVUjNsTCeExBJuErQjKvCHLOGtiao7yZ0zhNc/Sur+IJGk4sqIxpqJaZ5xoGxXTJmg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113766; c=relaxed/simple;
	bh=Mdp/Hc2CfLvmDTYkA2DMn9LW5Eg9Clkn4+zwn1SGkTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=paWKhGgz43j1Zd9QEh7NynydiefaB1G1pqj6uWZRiHvc2+PyZ+a1a/l+e2BHkgNueruh0zJLCcJbao0pT+iUZesrAtRbQKv9qn3FgcaBb6MZ2mAShGr6xy0IAsnviIKorM54QnaowkIHA/z2j/P9OurSc3jqZJ4ktw4dA1gZzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J1twn36E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1twn36E"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3nqeG027557
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 06:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Caa5vkwdw4xHZraI3/8RKS
	xtU2t5kpfmIZu41KBIZko=; b=J1twn36ENOg0CLYJn5k195VQx7r9PBIhcu/dTY
	g9MQjCHDDznAe3zmAXA0/5UjOLKhtoWYcuzaClRs3a9VPGZiX0UuW0ZszR4eb47J
	2C4220ZUQ/g5pHjdZr6x40CLvnYqo3Yz8OwKYNbYyJOJHIxJl7M10UqgVMlex3w0
	aE9pcyd2toLyOTjnBKL/NE/ZnISo/xd3/9C9ojzuSdbGwgNFObMrR7Mg/lRaLXwe
	HUlRifK864+q0qYJkWBX2kobxw/GsKALg6kPD8GJ7OkUrVM7PeYzjVYxxxqNStaT
	/2D81rMREznd7bprcurqpxiMhDfth0zgHsjZvV572ghISqtQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j3f28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 06:16:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28bd8b3fa67so61892965ad.2
        for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 23:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761113762; x=1761718562;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Caa5vkwdw4xHZraI3/8RKSxtU2t5kpfmIZu41KBIZko=;
        b=Y0O0Rjap+CXb/ciH4eMQRyW9Dgw5hQbyYl9k7A66Hcan/YluGuT493VLnLQ50dAA6k
         lPG/aaZoct/nGlQsEbqHa8ntnWnL+9s1wWELQnf0IXKpWUVzTFmq7NKXUDX09EMZBcRt
         mKHLzENs//eGrqFrHxFazl0RkQdUP+ZyvHFcRnB9xoW2doG2mjcOftDPiQDigsnZLOlT
         0OgkF3b8544WpZqxbUhlkNvgbnkPwK3PWAHKZLFmKztmX6bIOBLuinzQt7eS0qjOPr6/
         gkzcJtmZ+zbIJ7I2g/T3hlmOb78s+2c3vEuoiffLVixNlc6xlHQ+U6R5+6Dd+lriqPry
         lwlw==
X-Forwarded-Encrypted: i=1; AJvYcCVNFcRvGs6U1S3JYAzVUsQ+BJ8GZTuAbpKggDo7RIql9UYM+bypFYkrAMQrK/odbLpDpnLMSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTu90Ju1XisAYWUxyMyq3GtcMsFA+x0XAjtjrTLMCiVIjiAxBl
	sVAIkvfVdiXJLnj0UOIllS6KGbmULfBDUnQt7Z0u8KfmBFExYX6gJvfV6IQaurEoFL8iFGWVmpy
	x+yl47Y0vaYs1m5ORDK9qXI5CWr6YsGTxh5i935UORFBBvDJSaAlUwdgMNg==
X-Gm-Gg: ASbGncv0dTvstjVMeY+T8/0WeM0amSaV/JdQUoVAp5IQ/kFZT3HT8xbInzTxetFq/pV
	iCjPo9n7ASc0CqcE6+mOjC6kCBK+rheUDoWK+Lqg1yWUL64fK9EVUDMTp1Ylg2fobIbgQUUN3aW
	ze5wrGHivh4yL38wzzkgeJBSRqLj/40bXeq34/PomTTGWaYGCA3cDZrWxNip1y7/MOkv1PLnbIJ
	2cH8Epqeyeluc2AbWqBQ4pfLkclSovmOVwzDBaWBsrT1xxLL2q+5lhJcI8sFk7dRw4fixUgtUF8
	6Ew1pzdxG+qNXAhxMG450993CEgibLrYtY/UhQZhixaZ/lCMxq0OQlJAZWCl2cSmb+8LoS/9Zcp
	MR76Wg6wA8aq9BGZLqL19Z0sjc0tuhSgSVvwctA+fwXvevlpbiw==
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr228745515ad.9.1761113762288;
        Tue, 21 Oct 2025 23:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK2AgOSc86y2gtANDpKitSqnm917eqTcvN+6mopis8vmZnFgELd8pw/IBae457LATXi4NWmw==
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr228745345ad.9.1761113761848;
        Tue, 21 Oct 2025 23:16:01 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2cdsm127890045ad.95.2025.10.21.23.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:16:01 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 23:15:54 -0700
Subject: [PATCH v2] dt-bindings: arm-smmu: Add compatible for Kaanapali and
 Glymur SoCs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-knp-smmu-v2-1-88774e6d2def@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJl2+GgC/02Nyw7CIBREf6Vh7W2A4gNX/ofpgl7QEgUq1zaap
 v8u7crNJCeZOTMzctk7YudqZtlNnnyKBeSuYtibeHfgbWEmudwLLgV0Ch5xAAphBDxqcxAWlWo
 UK4shu5v/bLZrW7gz5KDLJmK/OsperrXe0zvl7/Y5ibW86bmWf+5JgADUDWp9spYrvCSi+jWaJ
 6YQ6hKsXZblBzREBLHBAAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761113760; l=1520;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=Mdp/Hc2CfLvmDTYkA2DMn9LW5Eg9Clkn4+zwn1SGkTM=;
 b=xSrVO81Lo4lXRQpoQOgaTHn443ZBp7YKlNGDYCQt2R9bVirX0XZP4W8nz4Z3dr7Y6jmiGfP3x
 wucPu3qrWm6A4Qlc9956K7d9DiQvi5x1mODNtuPFMrg2CVgr9ECtyBP
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX2X+ZnTGNUvSw
 R45TCta/kUVU6W47Ls19w+S52kpDnQT89mMrjH4dJwH6EpkQ9Og/QBWW0LPEBAnI108Q2wKGn8B
 dPV7iV7Jc4TJMgAHpz0mZfwICsxOS0KQJHyFXmKyNYslRVXVDV0a3Y2uEO61Nj2ar04vQz2pR+m
 jANb3gZ3rVQrcXd701o+H1u+74K4IvgFyBrPf7EJods/eg2Jhb0ayjIzsBEd+M2PNb9R04R6SQp
 R/KoJ34xjCHnNzK7dF+KtyhXrldYcgME/OwMWC/Abkip11S+mCAz3fM+eVZRotW7tVzVCFgObDX
 7L4u/Z2Wq18ochyDRayecJumkyxOBiwH+IjmCBXFjSW64zyGe1dHpJZALH682nHInz41TTO+pN9
 Ncobun0JFFAJN/8GsSE4DDivyqu3Ww==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f876a3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: _SbfGe3qC9w6GUNEFPklZdx1QFScnS1S
X-Proofpoint-ORIG-GUID: _SbfGe3qC9w6GUNEFPklZdx1QFScnS1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

Qualcomm Kaanapali and Glymur SoCs include apps smmu that implements
arm,mmu-500, which is used to translate device-visible virtual addresses
to physical addresses. Add compatible for these items.

Co-developed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- squash glymur binding: https://lore.kernel.org/all/20250919133439.965595-1-pankaj.patil@oss.qualcomm.com/
- Link to v1: https://lore.kernel.org/r/20250924-knp-smmu-v1-1-c93c998dd04c@oss.qualcomm.com
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 89495f094d52..2ffc48a276df 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,8 @@ properties:
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,glymur-smmu-500
+              - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500

---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251021-b4-knp-smmu-c79a61dc4434

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>

