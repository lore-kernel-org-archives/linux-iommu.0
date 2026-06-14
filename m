Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757530FF08
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472817; cv=none; b=QQuWM4vDnxTpY13OVFSpmxKW0eAhW+To0DlFP9yqSFtUthoSLti4AjEtJT22nZB/jNj5OUWmNu3fMFPI/qegFB+eGJWm34cU3jskoNeTJnUMtFTOhuBux2iBHuCrIIlmTtm8sqsUrDZXDDPpx7H+KPgEvHgl8m3UG7cZ/1N9Ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472817; c=relaxed/simple;
	bh=8qIA4dcSBlcfJHA8gtA3WsEzp54v0mcEyfaTc7WO5lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4toz9IKWMxOINkzSrFijDdlXaU5ZmmYnkrQHEh4ytk/dG6OZzWMx5VOVVfMVxqwuxclD+Lf/WWSzbgs0kuybfLSD9G9r3UT0eyTrC/3yu3fjVdUQV327UpxPV9BjEzpJ6gP9+fc/Yj2iHxapTz1UWiX54CKcP0GpwMpIV5ws3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FsLNiNId; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XZXJt1sv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FsLNiNId";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XZXJt1sv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ELFAwv2545700
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qtZnYSknyC6VJ7wYBpo4K4Mxwk7AfbIC2xEn+pH4i4U=; b=FsLNiNIdFmZndie2
	tRt5ydKZzUxW/6mifNC4GmEyHdSfZP2CobxkJ+rfx12JrWu8TqPsWEqV6hLQfCzC
	5D84ckxeYSFcD6dJkM/mqv2AzG/hq+FgDJE9/SKyye0hceGdue4YM16lhngWdiXV
	J1rLaeNsLicGxKuzqPvFwYBzODqXhCSFA3hAmAZ90Och1F2ojiBtY8RYhF/Lnp5s
	HhAMSz4BM51OEeD552zbcTie5lu2I72Ki+P2Q8jN+U9xJUdI1G6XPy6eN3kPMJLu
	7zfwOdClIIFat+7IBwXfURaKD+LiOh27fFVZbro9dEXlOFybvshEz8CEPxP/bKJI
	rgmn8Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryk6chk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf11699875so30188265ad.1
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781472814; x=1782077614; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtZnYSknyC6VJ7wYBpo4K4Mxwk7AfbIC2xEn+pH4i4U=;
        b=XZXJt1sv+i9YXURMLjtAPxoQ4XfrLMw//WUGj+CnQfzrBu2k6cmn1EuGcccrcMWU/F
         1ZOZJslUxl4Yp5w+8o42uzXhYkaGX6roShXRDkPwnUXvKyWmcH+GNSJs/h/+JNbBPW+a
         Oq5HfaR5YgxdTC3tyYy70/MwTEyjTfO9nq+CrU0eXTwlQsI+CrOxpnbmwFu069sUiww9
         /PgRkOgCOkZNFaAPfYH6b7sesemW4kv85Hpg8inJq/3KMM2N+OApafhxrQxxkQONLit/
         57v1QGra/lyBTUqBgzzOV3Ftim1o6vSfAjo/z4LNS0rxTzXj9+KZzLEqH5c75tkdPOaV
         /cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472814; x=1782077614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qtZnYSknyC6VJ7wYBpo4K4Mxwk7AfbIC2xEn+pH4i4U=;
        b=G1EOTga8N3Ff0U1nlqyI0ahFoGccnIhps9nrCVLUfT6o5rhTlj1O0DnNjRbUiIXXCF
         7jMpjd+65rhU6iOpjIYYPyIHizrshoWsNovwcMl4i/s1MTos41xngfS4SnrNueF2vOpr
         yS5DtCFLvagEW45x28+O5lFxXCqLjLvN3trC7NpNp9qUozpNd0PRmpX3+zyH27exmRgf
         86/ChsPA/mhVWTy2JkfhJfmex6StL9C7oJRWO1VCA48vtM0iUabWzAWCrQ/sGY0szJp9
         Dh5JAYWdk3N5eE1Sq2aA1z4y1zk65/A2zQcGHjwHVrX1//3jDgU8XJG3C/YyV86TjamX
         1Qig==
X-Forwarded-Encrypted: i=1; AFNElJ9axIr6aZHw+bfpHod5LxwEtRT0zNBm8OvfVGGiReCon7RZpySZW0KgB2wutntpcGi7hiCbmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc4xza+xH1qitV6Y80yo4dZcmLDbYa6EgDXj1JfJPfWaYiaPWX
	yWtcJtqOeTX9Nk1V5EsrVK6S/Yb3se+Fb21sbiO44H18hvtdBdf3oEMZoztT57bi2J92eNpQ5HM
	Is1hBLmXqWaGjZyW2BXuO2tibMk2Tc7e1/1SDy3MoTKDMA3W6pLB22rYv9w==
X-Gm-Gg: Acq92OFXCvfbu3fQQK6tjbG/jc3qS+4na97ze68++1YnNGRPe41bxSclnp+u3ZMp1+G
	rbA2LUmocqQPYmR/kmeTiwLgzPGLTC1gjAjEXShIem4OYAlC2i8VvNJdmlS7dj4Kl0bVQEgpury
	537rFpkDS/AbSvrpcKHo8CgBCFCKHsDnXhea+4qv+oqNnuDkAldv2JHzdsoVXlMRZdy4w9rQj/P
	vz+/27OZs2rX57CCmvJlles0Ezhlv6WquQa3ngkyTgjwVV9yQK0HMeYEoXkPVP57crSsOk1p7yo
	saBnfnx4eIsw8Pxb5A2Qhjoow90vJDacwT9kyXpqS5FhMJuZ7xVbdanjKKHT3P8NHN7odbtiIoe
	sHqMD1N9cTZodX9C/zLAIKg7j5Xtmav7jCW2HU4MhE5KimQ==
X-Received: by 2002:a17:902:f790:b0:2ba:838b:bfae with SMTP id d9443c01a7336-2c42ee0f946mr95926815ad.18.1781472813700;
        Sun, 14 Jun 2026 14:33:33 -0700 (PDT)
X-Received: by 2002:a17:902:f790:b0:2ba:838b:bfae with SMTP id d9443c01a7336-2c42ee0f946mr95926735ad.18.1781472813306;
        Sun, 14 Jun 2026 14:33:33 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c5dsm78385815ad.21.2026.06.14.14.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:33:32 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 03:02:59 +0530
Subject: [PATCH v2 3/3] dt-bindings: arm-smmu: Document GPU SMMU for Shikra
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-gpu-v2-3-2f2d1347c3fb@oss.qualcomm.com>
References: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
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
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781472781; l=1225;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=S6znqV/U764pfMoWaMCKGZx0PPM7djt7INHbYNV0GNA=;
 b=cHbThRGdErenu+D4xB+6tFiU7NF1g5rTdTt10AdLvYMAoGXwlPggSRFZhJlXinOL4jAjn9CmZ
 z4iqDybCdYpDbwVAijgulh/0R9QqPHqBkUTaY2chI9tFPbAbld9LvBY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyOSBTYWx0ZWRfX8A1nsIVSw1Gi
 /x/4VoTRL48qT9XL6Vt8ULBdruDL8+Uku+x07EeGFl4sueB/Hs9pLe4RXN7DwhCAmaQ6nr61vCQ
 axrz2sLfB2O+2VW5ZDWot8lP4W+sOKg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyOSBTYWx0ZWRfXzxZZ7ZHA1Xu+
 mJx3PzYDLiAX6PqHes7s3hndWYwmEqIp6HDLBo4swwSDEfIVxoZkFV6YnzG4nkj6ZWmaJCj+4lH
 4wKC+CB08VObXrY4Gq/wGRSefF/kB5V83J6bkg/GXbS2khNLZhSWEJahG5RjLe3ypjamqaLuMIN
 lIs+tU9x2mhtCodkoho09j3qHByNZhTkgnUcdTHQuy6uojNF0hcDX020/7tW4ktTRRoB2ik/zgH
 96fPJ/z/wO1BcJiwG4s3LeiS9P8y43bVLkAFXjibVOoJlcdIqRTVjH049unVC7CDBhoHNm5ZGPF
 sCXoujYUfI4YX0YfTalEPpTbzRxyd9mUAEAAZSVGuqwVEIAGIgXWDMv2DdOUV1yaOebjxDkYm3u
 cSC4m7B7z2kDEfGYIBssbaC+8kak5jszE8g+fdHIpuz2Rcw9A98hvy9vseWSG7VB4s38vKGxwJi
 3a56mL0feLOjqZDTNbQ==
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a2f1e2e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: W7aMlshhHt6akD0nH0YnYvuT2dFr4BUs
X-Proofpoint-ORIG-GUID: W7aMlshhHt6akD0nH0YnYvuT2dFr4BUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140229

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
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
2.51.0

