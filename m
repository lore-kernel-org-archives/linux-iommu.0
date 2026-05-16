Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4B3D648C
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934866; cv=none; b=pVeXHIBikmQ2Qzj2el4HVNaVCskT/TETRW/J5BkH5KMEZAGwrPOVIsXqQQUwV3acGQsK+JMDZja2OwJixwpTgIxrOQFM0RMifkS/Ik0BRhTESTxOuSYuAHmFHc6l6XO1CaS6oof/1Ilu4EbLGYjBBpLkMdNXudGp3QWa1dV6fHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934866; c=relaxed/simple;
	bh=+ZLfc3QA+QBsQTaKp+HhzOK7CJ71bHrL5yqZzxvE/mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqOI7mx5ZLdkuy6aNQS5tl34F67kuphT/KWH06ygGFx3r9FSwHdIDnPBEjolpZFeNiPKHEe25Jbshxl5KSz4N05BnhMQ0HiMld0cOn+uW+sip1fWZGwPqS+gtlWkKLuD35+zX7+FynZPqaUb6MgZl7qNLvn/bUR6cihGTTzaoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NQ4pcXER; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IimbJ8RZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQ4pcXER";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IimbJ8RZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G3gBvq1902518
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jw0cReuBvl0p7xYPoFikX0tHkyYFstCR2xf8gOH3em0=; b=NQ4pcXERhzYssk+B
	N4JUNVLNprCKeNfSq4UTXr4H1qEwb8oqNeRCh9A23ITnl88Sqw4fcO7lUm1xAA1q
	8wKj84FLXmx3c4lhs3pzVfa7YPDi6z6kPVxHJIzMFxwhDZW251JciNtJ/lJVynxL
	adFwLBUhtMvkcaRUpDtE8Leode5vvOr9ZJZSC+xAPhpGohX4jV4gbgfSWac0R5ew
	Hy2O6nnt0KFBXi3GbeN4ldbCTCzmgmlnImgEMGnVT5xzOnhXYO3Qodtle1URdZJX
	rD3H5ms2e31hRDwK8KzkpEHyKqC6QBIXae5J5gYocOeA3BN5HlYTRtUuZZH+kYLn
	Hkan8A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gwm8ush-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8271fb4407so1073150a12.2
        for <iommu@lists.linux.dev>; Sat, 16 May 2026 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778934863; x=1779539663; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jw0cReuBvl0p7xYPoFikX0tHkyYFstCR2xf8gOH3em0=;
        b=IimbJ8RZREyyXJc+5DCBaUXgW9jIubQ6vqwnq/XaKnQlDHCDMc207cvqNRgUDIooF4
         SH0THNOlJeFVFdqPH38gYk9vmFZ+kKJCcUh2nIihB/OjKgF3BLrdIw1IUgkH3DGzXCHw
         FLm2Ls/gsW/OYtm0PQtlhC1wXWSlSk38BxzpP2OYySCVYo+78x9JAC9yWURpTX3NFiMw
         a/GLUE1uxSutrekXVPYGKE1GU9YGnUioAbnMHWbimCWFsMJO6c/CXH9LYTE3UThJvENL
         JZmXwl5AczsWF7bkseZfedEPknTO5amBkDQcE7IQOiJl3gL6h6ufQ/OvyieV0PSIayg4
         wz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778934863; x=1779539663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jw0cReuBvl0p7xYPoFikX0tHkyYFstCR2xf8gOH3em0=;
        b=pob1/8fycMsrLXyb1BlBwent1vYWQ+f/apVYl+wpvbH5d9vqrGq7Y5MTBvU1lizJlc
         m3psmyUaWFd4PthfLvxNsu3MP7OK6qJM2NPOwLtuXbVGEwLsIqiM8mX5SsgezI3fh9KE
         2XRdMq9a6QzBOADvGUY9/IJ3Gwu2XlG3Mmd5WdF8szKBReAbQ28LFmuGo9Wu5xVjJKAH
         /LTogf2ubISBRSDAMVJwww/vx1/lT18PB64L+Tv3AMXcXnHYrxnVCnz8e1diQgxZ2QqC
         1BbIuoKrP71M1h5gS7KpuJ2LMCkAM2HWJEJWNSMnlFh1nuvzqtD0aZd1djewo9A0KcOC
         Ddbw==
X-Forwarded-Encrypted: i=1; AFNElJ/d9tBkd4pEFGVqppI0/xB9xy7IZoBCoLkCy/xMQe5AjZmNk/0XtoOz4pkGx1J5o03Dt3398A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbgKfELetmM8GceIPonP3ACSekwx0WXlmVEt4Y2b28qFWHwl7e
	NB3ggZj90NjQiZPIWyC0zL8us2eax7YtjkO5zJQmGT6H6mtNL+M8GETwbpX/IHc8g3zB+wjGCkY
	58JIIQeI/leoeYKmLgDO9SZ3Us2SBXhhAS+BJ45p3QSP3+Ku8D3Eqz22/Og==
X-Gm-Gg: Acq92OETOA93whvPoCG3I35S9XtC9x6QpUbpmlBHkzBlS4StGuUm7oleL/lU3RiULcX
	Znu5dlBFm+xyBulWzzkVYcMz2MR47raBIdNDeNTmM2CliOYb+ScDW4OpKXXaGNUhp6LEomAPp3c
	3HJMtQKquPSv4jCFxdTUf/TAWdTz/ckonltZdRDmLyA2f0jfYZboti6xJ82ByNWhzRVL89Jvrzu
	FHjgQcQxR/syorPHeNBvd9KkfueyXG/RLGIUgFxJT9WJvlbrWv39LNx3pLyZRtnXU9v4BXFemQ/
	j0q8K1qWjM7dmB3nsMSrqKo/JmLA6peIZavwTWqC0k2pi0vLc7+qlpmcJDFjKmGHLuOY4wP9Gms
	NNL4x3mdkfNI9/uVz3GEE+73A9g0w/bKrnLi6HZViFqwEHVpb1j05
X-Received: by 2002:a05:6a00:330c:b0:83f:9c6:9c with SMTP id d2e1a72fcca58-83f33c32d67mr8367661b3a.10.1778934863048;
        Sat, 16 May 2026 05:34:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:330c:b0:83f:9c6:9c with SMTP id d2e1a72fcca58-83f33c32d67mr8367629b3a.10.1778934862594;
        Sat, 16 May 2026 05:34:22 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc9asm11405217b3a.53.2026.05.16.05.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 05:34:22 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Sat, 16 May 2026 18:04:03 +0530
Subject: [PATCH 1/2] dt-bindings: iommu: arm,smmu: Document optional
 interconnects property
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-smmu_interconnect_addition-v1-1-f889d933f5c1@oss.qualcomm.com>
References: <20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com>
In-Reply-To: <20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778934854; l=1523;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=+ZLfc3QA+QBsQTaKp+HhzOK7CJ71bHrL5yqZzxvE/mg=;
 b=cApZ3bZQJ/56u9eFXAcmzjTKWoxsGgJHT9Bi/cl0ETuWX9o9MT14b3Fo6lOx3Pt0yomP7WFkP
 q9xu2/KDLtlAEnmD60hjWV+2pIhb9TEKp1TLdexxsINRIILaVNMoHF6
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Proofpoint-ORIG-GUID: CfftA2wJwERMFaw3DLJDvMMUQerPFYo-
X-Proofpoint-GUID: CfftA2wJwERMFaw3DLJDvMMUQerPFYo-
X-Authority-Analysis: v=2.4 cv=W/AIkxWk c=1 sm=1 tr=0 ts=6a086450 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=h2u_PYqE-o0iKWOXq5gA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDEyMyBTYWx0ZWRfX7iKMQSJ52L24
 bfDjXdfC2c8kxlS2An/qeeef0O2UTyUClTg0V5Jc10kQfujSG/L7oNxVk/gXWuSwv5cF9XXcs7d
 jW1spzSvXiLbQm2OE4F395adNtWYkzWO5nWalwaj2Dw+x3BW53OCT7qbTw1vd0+f3TJAVVeVEPJ
 5Q7kyGOl1UpyxcZXcTPg0roIZTZvV7tca7X7OVyrku1YF65X4Qn6v3nXKOcMqFEBIg1X5lPGcnx
 ZEmjgr6ioHajEiSIBkQVifTYK+L+lJxgZ3tBZpoR9omxV0ehFeJNM2P3CQOW3oIZQAUvrQ7SEjl
 zXucmd1WxI/Zo4yu8vx3TD+MfTfTQcRWa+CCfp5nfj4lsYIt/JjLnn9JTblCaVREuHEHluiaspr
 ojgv1vnB53Zdg0P5yQS4lVHbJ7vOfNsE9MVhPs9pwh/sFmGmY+yfYCh4nbhGAA4JOhHxCgNWXEn
 ah//gBJN8xWoL9CpQ7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160123

Some SoC implementations require a bandwidth vote on an interconnect
path before the SMMU register space is accessible. Add the optional
'interconnects' property to the binding to allow platform DT nodes
to describe this path.

The arm-smmu driver uses these properties to vote for bandwidth before
accessing any SMMU registers and releases the vote on runtime suspend.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547cb7a92823adc2772b94f747376a6..5cbf944f2d3e178b3723d4dbaa19ee0d33446979 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -243,6 +243,15 @@ properties:
     minItems: 1
     maxItems: 3
 
+  interconnects:
+    maxItems: 1
+    description:
+      Optional interconnect path to the SMMU register space. On some SoCs
+      the SMMU registers are only accessible after a bandwidth vote has been
+      placed on the interconnect fabric. When present the driver votes for
+      bandwidth on this path before accessing any SMMU registers and releases
+      the vote on runtime suspend.
+
   nvidia,memory-controller:
     description: |
       A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.

-- 
2.34.1

