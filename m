Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24836384CD1
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613738; cv=none; b=MiFfDx7h/e5LlnEVczQ/CQdVQ+uKnyXeTl5QPiuHdNlD67E3hGUCkXtruEM7SsgFOB68n6sxdyhCkO9x5AcZmIiEgyO6g1FsO9tpbB3ODxKKyAVBH5y9y5dhp7PEc/D1AQBMyjirKRt3xOLSFtEFqlKU65VB0sk7//JIuWfeaXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613738; c=relaxed/simple;
	bh=+Y9gYZSkWF93iB7//ohDWKNnMjwm/WhLykXaB9JYn4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OyKEPV5Jz9GVqA/QJhgcZF968RSH5J2sJRVTbAwkcZ4Xp1gAC7Y/mUsxrEQs2xkNKQfJV11vL5/4v2/VD9wxqeH0iQzEpQi5IelV81rboyctgf27eLRTrbr6XPN6xHTgQLyBmqIHi+/RJ2Qpcpb+4ztaIDz2aJ2AzX4rNDX3RgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bZf97tOG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XOpPfYKw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZf97tOG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XOpPfYKw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CDgInt680110
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=; b=bZf97tOGRyEE0oAa
	X1dFXhFPupPx5Xm+inIKhxZ2AiqxWkHeS3+pjkttLQS15PaqkD5NmqcV2K2tR07N
	4xCiGKoA6xW1w86ZsMG525PPYHIItjicOThVekEdKdqPy0zEaiQ3S89smuSr1uOG
	rNVXKZ7ZK++HTwhp12GsF0/9i9LJNI6eJ2rxCzr9JXo8WnsWOqfufrLFkdnmq0Gb
	jngW+Mz2QY5+/MQ5PVFfiqcHcUx53CiEUMIGX1GJ0kgnwvyoiV0QN1UNGClXk4tu
	l1PU8Qv3drmHmnwdRAPW5j4OpkAa0qbhMiXtbPmEsYngFrAGULKrdZ/C1XhQvifd
	/HTjCA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avhd3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba224c3ffdso85948825ad.0
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778613733; x=1779218533; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=;
        b=XOpPfYKwtB2Kw2SKuokr8sncWor6AhkByPTHeAJHKMNO4UqHOzLYf5jyl+fEq4BQX+
         Ag2uNwgmDQezu13ByCc+VhQ3FJmerbHO0ljEd9IsBopS5tgqbOP9qW3vIa64vhpxD18A
         zF84T96BknUKHbOSxYwPtdO6dtCnDR0NRjY9RLqRM/SZbd/rRfwSSLSbq1SlgdDzZJri
         cEtJO0tMqf9zu1aMYJPgSxOd09hEQGPfl7fbTY1uSPVtLLOOg9lmyz7z6S5kNkKwuM2K
         xLNQe7lfxVGTmbeWn/0aF2r9kbkOgV60bqjXguSH8dRtqQj3OAi3MXiJFvpnt5jj36Ll
         JRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613733; x=1779218533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=;
        b=BbsgPVKNlkOPBSZPw4PZwez/JLRzFtt5iqg1TdoBZjwCLKRdMWh5CpHcW3/AHug2+E
         Q/KoavrKAJCmVmR7JAX/E9eXt8DbaYB8nuar2ZhDD7egxIynluDb8Js6teb5mopDJRDo
         a0M6ThENwNIpZTBTCKNWA1TA6m/EMD1yTlf3UTtaL7RO7YYB9xiqRgeUGrD9BbQ6LomT
         +wC5H891CNMPX2S+xVQByQPEMR+xyjgYhR+5976fqeW/ceGB8s+yUpvom6CXgHLpY3mU
         sLWfqctPNHxaHdO3dINzXvHkLXRodEJy/tsh9EX4s2TOCAubuN8jb1gu7fp7wEtEQiz8
         xovw==
X-Forwarded-Encrypted: i=1; AFNElJ82ska3hKEsdFPxDv47mTIwd+3kpKiDdvztuIMOvl0TjcJ7NWbTomkASRpGN+Ot65Q2nZxX9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRqcqiy0/FX/iv23nUvzyZZGYiOykDxBUgsRYH4GBH5iwIS6jT
	SauxkRU7gnpwI1Sxoo9p0Zi8SYu5Ak+OCBk1uOIjo4IcBPY8uHr5mToXmbiQQ7SM8clkJTuLzwq
	qnNO4eV6v2ByxR1ai5gQRhTZXUAQ+D2Wlr7TuFIsmd5exFsira0x2nVKZe8totSxbwQ==
X-Gm-Gg: Acq92OG1+QeMpy5uJEF0DZ2SkMvRzSaqVzYyhDS2ovacETUjCmNhHtVy/VdiV18quqp
	3yh8VCeQhPp0rjf3N+K+rntIUNxRI4TJPnilMYfO9ts7L4aivk4tUqouMFp6nown+TN9CLXIb+g
	xPnujWrJGjix/rxPJL24YMLMXF55SWu+gigbczwcwAaPzaXEW17k5SgzrJHDxKXvNtGZEl5NzkH
	oeiQfAigtvHwFikxQh2gsEZbEZR9Xl7UN0zqmG21+HM3NF0WOxK/YSTrxMm0rn2Gr2yWHRCjZgh
	KifH4fuP/3Aw4rp5om/OMIda93LKYPini+qa9xSFco4FkoCj7auP53pvXkHXmL2WKdYQWQ7Jpun
	UDiNCFAK+5Xsi8VPVVMMjVY4kCNLNEnpgoSObztkJHheSVg==
X-Received: by 2002:a17:903:8c6:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2bd276f20f8mr3596395ad.32.1778613733140;
        Tue, 12 May 2026 12:22:13 -0700 (PDT)
X-Received: by 2002:a17:903:8c6:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2bd276f20f8mr3596105ad.32.1778613732663;
        Tue, 12 May 2026 12:22:12 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:22:12 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:20 +0530
Subject: [PATCH v4 3/6] dt-bindings: arm-smmu: Update the description for
 Glymur GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-3-f83832c3bc9a@oss.qualcomm.com>
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
In-Reply-To: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=1014;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=+Y9gYZSkWF93iB7//ohDWKNnMjwm/WhLykXaB9JYn4Q=;
 b=sJd52zbNvhJgb1ND3wewPjtymBQO1zHcJeff4xbFhYmqzmdH1ZAPEn/CEg3GbkRyuYyQW/n63
 GG493bLcmq7BWjLKyNq7Z7xbAwWo7HUq3kgm0UbPs89yZspZIMONxfz
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: myN12ZAPU5AzT1is9KFCe7JnXStnffwC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX4kUYrWOZLcKI
 w9QnsMoW01+PetPImW9rszPlTnvfZYaa+cEJnYTWH95edL4JQ+E67BbN4jO7RXy78oemqpEFR5/
 /xVGTTO0M55S77MzLnCKhjG188qfha8jH1p58Kj9mCILDkHb7nt8wgA9zbm9MxQzSwWfpBXsnE7
 Zm0fzPoLzJ+vTZd/lVXwBlPbVYYQD1+dvX0iDQWWhnghZygH+vzPMXTdyIZO6FNgxTFPUR1klJs
 rmjxyYGB2IFfZaiBa6yVPoC443RdlhucaAjye1+JnNcNSSLnKWUKEySK0FC9rCXo3I/s1GjegwG
 gknnSU/YJ9u0K3Y/H7Fb8GNdhozH3+CmFwzYiuY6VTPsigQFjKrgzkroMeVPZtvScPN979EV10J
 5OsbtluxRVjRR1yFASNM5j8f4M3jv+cohAEACJE3moX9Wfplexw8bwEaaUUXM9y2+9HxLPijC8j
 9lBdtrsm4UtUPRlIodg==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a037de6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=RQVZ3Ks9ONUmwc3llXAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: myN12ZAPU5AzT1is9KFCe7JnXStnffwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120200

Add the interconnects property to the common SMMU properties and extend
the sm8750 clock description section to also cover Glymur since it uses
the same single "hlos" vote clock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..b811ece722c9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -566,7 +566,9 @@ allOf:
       properties:
         compatible:
           items:
-            - const: qcom,sm8750-smmu-500
+            - enum:
+                - qcom,glymur-smmu-500
+                - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
             - const: arm,mmu-500

-- 
2.51.0

