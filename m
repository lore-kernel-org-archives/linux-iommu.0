Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507240245F
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551895; cv=none; b=qc8qrlUkMraBUQqP7xIkqB76B1shcJ4fOPBsZkWkiKprCofX6D0kje/FLOBa6PbQPMthc9NKXCqCrgBe4TWLp7d0wJMHKDgH6Cwd7hUvIh4dHsqVRCRLOAqoug9C4oBlJE/kX0juNt3RKEUnTEfGkrynv4gWj6m6aFqv7/rVgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551895; c=relaxed/simple;
	bh=1sPp6qkgLL16bC9J8/CczkLx46Zc5+CObd4eTssOwD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z25NKlRDYj3+Rug8FlXPuG3W6A7KGLNcnBCvalhg+Mi9iaTn3zSoMwM8F/w13yRjxmWhglHCCtLs7yG1LhosCmOkbG4wbKzNQ9zFsAOPkq8YbbLuQwo41HzNniq71o5lEYX974GSQN7KkWln4Sl6frTmlH81Zc7l78fk16paLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AQ2dFKLy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RA8yxgl9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AQ2dFKLy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RA8yxgl9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UANWTG2943404
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 12:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jiRe8cM1xmTVogAyyDIKzj
	saynJQK1XUXAfnmLXh/uY=; b=AQ2dFKLy8GjJTg2Z/P/g1YUNN/LGcctCHOufbT
	8PnOyK6P9bqyC/e20sJSNIBk+/59H34vBtIZ1XjbwqVrsiYhnBbfQCEK1XRq1V1P
	WhhYxSx55/J2hKuH0PAf1t3tEbhcBvF/Q4lKUl4GpEeb6WgCF2x9Er4qPswkRk2N
	lzhhsl0XFrrRaYtGNOvhyZLiHtnqVPW6oXHjDceoUa9NZlGbLKA39YZwdC1Voxc4
	FBAfLlLx9HEJrdGr5FGapPToZrp7+YRoMSjgqog5uPBEq4QuprymK0Ukl6ltt1LA
	WFVtkHDf8zLnXTyb9waJDV0bzQLMBE0Ibp3KyOQYah6An6Tw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr41w6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 12:24:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso1587336a91.2
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777551891; x=1778156691; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiRe8cM1xmTVogAyyDIKzjsaynJQK1XUXAfnmLXh/uY=;
        b=RA8yxgl9nqW2MnTQSpg3pzW1IeRvHNtVXz1IVxHBsp/yyVXAVFRSd+5q1mG3n2JubR
         i+lLeYyzzmMhD9eGZbTmGIRa6cifw9kNG2zz7fPagJoQCnUFyuFu2UG0YPNjI5pDm12j
         K2s+SJmTiOzjXTkyFN2XSyiXjI9dwsNOuEiLOAlyBNZrpKlgoGJCpaQeG5kXBpWAtG+q
         hvLRfm+xw6VncN2QfHcMyUiD7yNtUWUks2aZVWTDb4y7WeccC3w+N4yGwjVcGf6f+nUK
         14M7Wz9VkvvUmyo/15Kp0T9jhMgFe358v7CFD0sB1xokUff2BdJuPbafoGfIZbxJApZv
         o88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777551891; x=1778156691;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiRe8cM1xmTVogAyyDIKzjsaynJQK1XUXAfnmLXh/uY=;
        b=gRQrucese5vQynTd7RfX2rsqVjVVOdRtzqcVEAZKXyowDWUDsMiUYL4p2jLHXx+QPu
         A4kF3130sapF+PhUeJVpEOdFg/1TWxT2liruitErSPqnO5R/mTpsDaNlEW2QpIT4Hcmz
         q8eYOPxXyH5og/SZILwkxKVO6f4IgHPYoGfgJlBmmdD85oB4tIOepKOr7+Rz6VX/tqoA
         m4MispazAz86x0ZAOxpeyUsBWfF9+zu/Du/rSxbNjOGf2wQGJbxoyflVFjQu2nPGBQMg
         /SpzN+1FyiQ6snVRwmWeM7tMaFXvPvIEuw68aydxSxzqVf//DnKzeiCOQ4S94m5jtGRM
         6AXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uHiV9tb+UEP/V/QExmRcmYdA5mahORj+np75V7kbngrTmUUQSbj+y3L6cZtPzLfL5YS0gmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzQ4x1+/3zDcMRtvJP46Sk0qVRbyxN8Ke0xyW3HXBwbCRaOqkK
	2jvuAXMQ421hQeHE9X1eYGBYiSBUa3unVsxSGSX+UtmvAyrJb0F3adOn16I3tspDb6ZfF1hbcxT
	nGQ1huyJU7gfGj23qWFLcbHILvtQ4EgPxx38mVXMhlrOT0wADkIln/SKwTw==
X-Gm-Gg: AeBDietFVsaeZNrBB1HQIuskaaZRzDyhArGvj+Ez0NJKqv9P+OPpAnnxZFeAcRGHJNQ
	adbKuQc6sYzKcFHVBSQqOQwkjpGjzGUcFcTPMlFK1ce8XgAl5HvEkPM6qGCgi15plk96JdyMSQI
	esb4J05/3g0ieubdn2zaqOFz8SnbHCbS1Mnssc8Qd1mETk/OoxtmsNoCc9empyz6isqWLivAoL+
	NrVTTvcTqXcqFI32XcjMot/sh65lyw1uy4LX0LbMSqQ/EY2l8Pg9kYRgKz5hGn9M7R56l+KV5Vg
	zfw2q5CKhpiTxKepdSNh/XqMmdVEvRhBc6qdkoFtrIokU8FIUJlS2KJ0TC/oQb2y2+lXlfMZOa+
	gaAMMRT+YF5WhxNC0WQjoKkux7zKx+sMlbPZ5/XwNhZbgC0U=
X-Received: by 2002:a17:90a:d448:b0:362:bc8a:9c22 with SMTP id 98e67ed59e1d1-364c3126f20mr2972342a91.27.1777551890691;
        Thu, 30 Apr 2026 05:24:50 -0700 (PDT)
X-Received: by 2002:a17:90a:d448:b0:362:bc8a:9c22 with SMTP id 98e67ed59e1d1-364c3126f20mr2972318a91.27.1777551890241;
        Thu, 30 Apr 2026 05:24:50 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772e79sm53756765ad.12.2026.04.30.05.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:24:49 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 17:54:44 +0530
Subject: [PATCH] dt-bindings: arm-smmu: qcom: Add compatible for Qualcomm
 Shikra SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-shikra-smmu-binding-v1-1-1a28572ebccf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAtK82kC/x3MTQqAIBBA4avErBsw+4OuEi20Rh0iC4ciiO6et
 PwW7z0glJgEhuKBRBcL7zGjKguYg4mekJds0Ep3qqkVSuA1GZRtO9FyXDh67C05alqanTaQyyO
 R4/u/jtP7foLAqQtlAAAA
X-Change-ID: 20260430-shikra-smmu-binding-7befe45ecf2a
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777551886; l=1113;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=1sPp6qkgLL16bC9J8/CczkLx46Zc5+CObd4eTssOwD8=;
 b=FOl29HQGOmuqRAc/DitTXHvBc+Y1BIXIhzO7Gt6oy++8zB5/N7SvHf5+4YKAwQ4IiCQCXTRpl
 ugnuoIa8J4cCf9P1fU4RFKg86MoZAA/Bxqr/bS3fEJTyKFXiMJWkw1w
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f34a14 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nZKb0XQ6c_9jB4svJKQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEyNSBTYWx0ZWRfXx1Yk6C8xFr4u
 WwwjrLe+9r3Ot4Pf6hgkUmM/X7BIztMV11v9O3AOAuykj5Lyd86rEd778qEIt1g02RHw9+qPnqE
 qRYyDgHD7jTl9rOlZQWJlGVMMG9sVWwaP1ol0SgGV6Vobv96/YvhVa7CAoIfAqtL9yfFF/u3xzH
 2SePI04Aj2W5IgKOVE01xzCpQkY1HKJ7duC4xoV2owLebn5zrUZLX5372B2OiVOLOUY6bzq7dV4
 OvGdAGsz3axPrUegl6aInC25i2H715MQ8FSj4b/c+e2KVCggCep+Ew+qFMzkQ6kg+TPUen9f30U
 kRYtO/wdbkW2HJB8Hxoj2Kf3WN5dAC+GxgE3BdqmUSU1SCBYnjizpQJOXbyryMWqVMjPnhGx11H
 mNkFoS+FgZ/puERapou9XpIRbKh5cnWL2hjbqErK/USLElVTFOtjiZdflEwqUXzzTbAZOp8ahvL
 ZNd1PXV5MeQpsjRVXpg==
X-Proofpoint-GUID: Q2bwHKFS04iYYAVdH5vksMrTEg47sU8p
X-Proofpoint-ORIG-GUID: Q2bwHKFS04iYYAVdH5vksMrTEg47sU8p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300125

Qualcomm Shikra SoC includes an apps SMMU that implements arm,mmu-500,
which is used to translate device-visible virtual addresses to physical
addresses. Add compatible for it.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..1f544103b574 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -55,6 +55,7 @@ properties:
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
               - qcom,sdx75-smmu-500
+              - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm6350-smmu-500

---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260430-shikra-smmu-binding-7befe45ecf2a

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

