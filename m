Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630433396F0
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076726; cv=none; b=ZTssGvWPcwA9fkbakgld2HG2kMQ+Qhn9FDmEyk/0mpjMcyvESpCnKj/UGzQX6cTpZi4d8ir1wC5UulHLc5DgfArQHc7ASvoHim0JbUfCiuOML22QxQBAQFOisRWoWFms9qP8k73nxVCFX4KQC1QHeObbumbJk3+AjxgpCAsI+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076726; c=relaxed/simple;
	bh=+yhNHPe0JhwA+eOy4wzvzgK3jwdDA7lGVXF9GN6vVCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzlnhKKgly12e6sWPYh7G7rV34ZXq+ev2sO9QDmzJrsMPkMymsSFaopRXn1R4m8KuF73IZbFnbIeSd+Ffcn1VoGj4q4zeGFnXptHKi4/Nq0nMmvX6pVKkT7kbReef89iLSxSIo6/gkiQVOzcDqDscWh/nSKR1k1KZoClimh2Exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fufrg+A/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DMj1bFol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fufrg+A/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DMj1bFol"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMb6S11694033
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sx+7duOt8Mg6zZHNtc4wd93FWjeo32qOP0acS5OMuFQ=; b=fufrg+A/xvLPXJTR
	4goiQlZWmQiZLlyKIyzu7A0PvvDEGbY5TrNXy5RWDaW7zCoGqbpArXEUNNDCn3U6
	QIuxR/9S3N83lS0SF4YCS0rFr7xVW4TNZjYVh0Ex9CyD5c+gPEuQvrYwOoGb3PMV
	BoSm46RZq6QHmWCBlwhUJpG4XgjBlfwXf/8RKMIhrzQ3mPEd41Lko8PUMpQTbgvH
	Yrhsdng5FjRaP0AY25++McgRwtTm0n+avl5/HMgqJ/pjZgSGFnYBrSHLos779594
	OQcPnKid5h4OHFznwLit4FekPz4EwG3ow9sRY9HrgWbVqGKeeqtvyW1MCXJ0q+MX
	nN+6UA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9g04f8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9321b9312so3058220b3a.1
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076721; x=1763681521; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sx+7duOt8Mg6zZHNtc4wd93FWjeo32qOP0acS5OMuFQ=;
        b=DMj1bFol1ydKJTSO8PnymKmf0bwMZpWNzCczDFI5ySvP6GMGvH7FO1NOM2mBYFZc8L
         46m2s0zDrh6WCHhakH3yFoGTSK9xBfh+pmGF/Mza39yIeToqT7V7w++CQ3U/GATHkP4T
         RRKaSLR1BaDP0YVoK4IKjkBl96HvphCjdoFokSnbs6FVqESQuQRX00T9EaG7ZSIwld1u
         mBZyLilHT8QNn5xD7amA+2amEgH8MY/DROodPt6ZXQPJjl2X2X2fvvp7k90A3we1g8fA
         SAVqQZ9sU5W5QJ9HYMy7PU7YGMFYgFKcrO0P++b4hswAh/45uK2hqXkhlLhzyQPm3/KV
         xHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076721; x=1763681521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sx+7duOt8Mg6zZHNtc4wd93FWjeo32qOP0acS5OMuFQ=;
        b=GbMnChM81BJr16BwXfoVu0fbmwMexd/wZyzoOc2UfsyywL7M48WMVVJ2KBg3joI1Dt
         iOfxp6QC+yeX392k7Vlubw1g1MzyWqrNJQz/a0aavrKLvD+iLk0DM+lducIoxSRkBcoJ
         6RyliweTu+r+x52+xQPFP7HDRV6FSEEZxxs5clFpTh66Yy/c4xU0Ddpo1mOH7jqRaNip
         RIXAuNsq1WZRARylJ3dCj3PQ34rSZ2yQb9atZaBqbFAzYM4kg/Dm6jFKWf3erK8fI3+r
         fqzDmBqtjJPGTDWqNGPW9JwGtEgezmH2ByTbxZbbcpG5sPEexfDbd9XVok295JVT9zU/
         JPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCULIUULpDVPf8e880Vw2iUGe3DBUz/gu6FlQvGVjcV1GiJLHWVcVBtXkm7AdZXtMu4riFJCQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzdt1xm2Xro4V9Rg2msvwiEvhal6OkWiE10offOKXXJGvUrWTDh
	/6bCD+Vt1tT3rI3qtsjuhlUtXIEhDtvSjP4uBr1uGKbnF9Dvui8dCi0S8jPKZ/P2zWz4iLS14nR
	SJ6U3uynXF+wK+tPLOKlyLRQAIclIeopNQTorOLjs+6nI6yXoZymOgpsNCw==
X-Gm-Gg: ASbGnct5pA2Vgl/V8r5AqoZg1a5i7zg71MFnEIHYPlIe+SAtmUy4DsbeXjZbX+dREHw
	AqyGvIYvu6zygq0kuVsoH+QUf264/X2cWiUqirbKxbPuN8TNtkOzvaaa7jNErwqeB7PK7I0zEo5
	EgvS5mAeu85eWOclE9qUoSFetkeuk5kc0tUXe6HQRLRDjQuviz58wx3Scln6pQ0wt51/eQliMjT
	JOk7V6p6A96eyXnV5Ihtoeq442Pqdw+Gw8Vdp/uvxiDtdOLsRFKU0u4iUFZMjOzgbNSVgoB36CI
	yghfqFTq7VnXlkmAX52U823cWM4s3RBx33wlvMOhlUHOArZxCWYsUKEbT6azBc42mCBFqA3gzNn
	25gRUEwX0CoHEXMLztYW/MSg=
X-Received: by 2002:a05:6a21:6da1:b0:34e:a1b2:a35f with SMTP id adf61e73a8af0-35ba2692da8mr1640190637.53.1763076720944;
        Thu, 13 Nov 2025 15:32:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX/aqiHfq+KfDFbcwSzPve/zFmwha2Yv2xlolDdxZkmw42sGuTr2PqLnQdgxCC3lptWEZ10w==
X-Received: by 2002:a05:6a21:6da1:b0:34e:a1b2:a35f with SMTP id adf61e73a8af0-35ba2692da8mr1640150637.53.1763076720415;
        Thu, 13 Nov 2025 15:32:00 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:32:00 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:59:15 +0530
Subject: [PATCH v3 18/20] dt-bindings: arm-smmu: Add Kaanapali and Glymur
 GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-18-92300c7ec8ff@oss.qualcomm.com>
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076574; l=920;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=+yhNHPe0JhwA+eOy4wzvzgK3jwdDA7lGVXF9GN6vVCw=;
 b=EVrIxsWJTSe1QIoktPi4f9hvpt+misNrn2q21fLyuIb1hcisO++zvNfpv7RIWnOz7RLMMksXA
 uKfR/4rWGFlBNoAJWn6V4gbbQ5DHcW/ZW+YYGwoh/JaM3aQxtDxxox5
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: jhuIO_gczHlZBl11UFFSH2jfSxiWuDk_
X-Proofpoint-ORIG-GUID: jhuIO_gczHlZBl11UFFSH2jfSxiWuDk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX/k1FGcOMgps5
 0ncpvWLLN7DgAc6ZjcysdcUTBQ4106tZZ3vBrLIHYqJWh+LZH09Gs7cA74GQcF4oPuENl7JFM56
 UZHFGbw3f2BBBMnuTMk2ZiL8UY/cdm+Ruc4TOOInNfOWhNeDkQV+ZDanRfdFOnIJOGi+00Z83Bw
 lnbAbUiNta6Wf1a9Tvm8HLGEDIP2T9PLY8IyACHchDVKxUTT8rYTkycZ+EMw0V9L+sIHX4qmfms
 AwJsUYyPtYffzkeogyu6h945mlWi3AR8VwpgEpV4F+YGIu633GD8rKdpO4BUiJc/GTKOd7FL9OE
 KfNt0tQyfG4h9bjTst8dAnNdB2YRKfE4hMXagi+n0Ubfzvr6Qzg7BCBNvCxNJR+oKO1P5R0r8dg
 FHeIqWRD31dj2GTzsCazmmv54mhVcA==
X-Authority-Analysis: v=2.4 cv=IM8PywvG c=1 sm=1 tr=0 ts=69166a72 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nx9Ee08JJy_q_36Bb04A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

Update the devicetree bindings to document the GPU SMMUs present in
Kaanapali and Glymur chipsets.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 59bbd20992c9..cdbd23b5c08c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -91,6 +91,8 @@ properties:
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

