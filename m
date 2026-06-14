Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF329D267
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472802; cv=none; b=UyVdUmc6GdhjmBc7+KDwS7HPV2QnYsl0HmRkF4b8Qz7uI65sifHu/j0TsAHwvhNxzsYiQ5usrdXf4Wf12dvTaMexwBnYjiWA7GO04Px37XbJGvwCGQOppe+E6WvrcmiYJeY8tCa9Ek3azAxfOE5pTJgZi1Zip8+PqrviFmqBMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472802; c=relaxed/simple;
	bh=FouFj+iYJhzcqR59XAa2/WxqzLLfYvt1re4RY7l+JLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mny4fKTF9U8VYETzarNMycFOS4eDZxmwZm6hB2DrEkjQi0q28ncNrilIk8BKS7K6GmFS0/1R8JScBFyi8NrK6v2cwOCSomzdsK6ylOlZOlAPWuNMMwF9YPqavwnnNkm/RKS4CTb5P2Voa9j6FTRg8Dhw46V+QlSaD3OTZS0gM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kZVvZP6V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUxKIjxF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZVvZP6V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUxKIjxF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ELEqcJ2668272
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=; b=kZVvZP6VJrKoSNV7
	LKhWeEnDvy8IowCzIt6/hmnwStxg4uCjdN1GlRDOcsPizXajLUvfCBEdbhYJR5ut
	bWBXM/xGfnVx8JP3CVlt48QKCcU0uI5nCar9ZL/AUh1ImXT6vzSZ1exCyc/gNLgA
	FaBJeKjOdHlqowWqZF03bGMYMziZmq7WqJ2bVZcE2L34vo+p4gJjRBFT94FtlxBu
	3QgMvuOhG61la6WPdSzn0KK3/7vM2sgfuBprK1zPpE+qZqNKAaZJOYRDqgEiyrZV
	Gxb/jUlrN7AlSEZjIQqv55kFWmJwHOOxQ405eb9mMaRSCr0p+skAWRSbClUnGwou
	9KtT7g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u4jtg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0bf6904a6so46004015ad.1
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781472798; x=1782077598; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=;
        b=JUxKIjxFPKRoO0SKM/oZW0CQVHix2uxI9SB8rFi+D6uuSFAbgeBmL6SOT3jSFpeRC0
         PKhUm0dbQmK0iYkkXdmNayAhBsKvDaMTvBrFKfvHLPESe3pGA8C4lUcHnXPtaV0/ldSp
         T5ZgFRQh/52ITWzihKq0+J9CKCqA1mICrFHioN/Y+9hxvddCHZTm6fGt03lwPSTZIG+X
         jlTOd9qI2t4eADB9KH+yYcVKwim/y1JdSYqO5HU7PZdme2xWbf+bv4l54YOdLh/3mRKE
         s1Ekb+Rnq7mIIJOMzZCv/QzLZ+qfmCfo7kkVbuTjcHJVrQTYRfzOGhGcwdWEAAy8hBkQ
         xcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472798; x=1782077598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=;
        b=DT0LkVlP0E5xVMQWbByKIO0LM8mKzvezA8wVg116SKduZqnM1XEfL0qnhz0tW2RSn6
         Pu/jo83QQkXYXUo7pxGlenpMHYqk/5R1/1cN6tmJamVxCWjVfeM7+/pcThZ2L4gYo2PV
         JczTveoi6CVskeVT1nxzcSMNOEBRVfob2Nrw2jM4Xz+dN32F/QlUPw24l9/IaOHu6o9t
         uyMicg1kNytnNL+oVJ2hwF56uO+6x03NxTUQBC9u9gVnI0cfn7pgx+M5QCpiUWmjx03H
         nSUDhnPaUKibS5qzuWFQFtEnowrmbJsAMFx5H2iq/EsyMjZaQEX3u/L8pZGB/yIusa2x
         Gizw==
X-Forwarded-Encrypted: i=1; AFNElJ/U1CHT+e2zR0qYlcFvGYuvwhI3r/Lszc3sSdo9gMY/og5Kz0NJijqnXP1ZTnUxyYUKre7Xag==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKyK0QzvYHnEoggEbqrRosNeSdRQ4vOMbvMw/L8PZmuMquFhIR
	TkfFqul+M38JyN8uoiftRVI8UmplOlN11d4I1/0eAJs2T0ThZzMuHSXyGReVsD4UViWRtpZqnFA
	DUR934mPWpbgNbqCXQ3xCVxOLbg3ipU+AvNPDhMtku+UaKTi/dEof+7H4OA==
X-Gm-Gg: Acq92OEtZwO0pS4+f1R+QVHDr+b/dXBqMZDRdP5DCzm8AFxLi+GEfLCAf6/z8ygmhJP
	4C6C/uAmNakPqtZ4ZsfuFy9JjW4a6oMTFNpPKvNRK7EWFUobO/xVALusAaFsF0qvDkIDoPu6437
	XrMouCa+zONIrRxRLKoLSaIUZaghd+yuR9v1bx1fCIIg4X90o186OPrf76aAsspMKNLQbLQ6BSY
	a/b1W5BigdD38C5tvfWgKuEja0zNfSj8GzGSvsUAXCn/vbQ+SQMVi3SWg12M6HGkX1faomemYXb
	VQvge6uwOSSYL3BDUByOxlDkjDeTU8aKZNE1af/tKyaWn+ePQ6VPZ356tj44gEcTnlSD3ldmDoz
	UkncwwSZf+9r4DNcj/BsoIfCxr+EzENUjbV+TTyB/F3whVA==
X-Received: by 2002:a17:902:e54b:b0:2c0:bb2d:a314 with SMTP id d9443c01a7336-2c4129391a8mr131369505ad.28.1781472798100;
        Sun, 14 Jun 2026 14:33:18 -0700 (PDT)
X-Received: by 2002:a17:902:e54b:b0:2c0:bb2d:a314 with SMTP id d9443c01a7336-2c4129391a8mr131369115ad.28.1781472797754;
        Sun, 14 Jun 2026 14:33:17 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c5dsm78385815ad.21.2026.06.14.14.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:33:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 03:02:57 +0530
Subject: [PATCH v2 1/3] dt-bindings: display/msm/gpu: Add support for A704
 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-gpu-v2-1-2f2d1347c3fb@oss.qualcomm.com>
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
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781472781; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=JBJQ6bZjxqgxmRsc6EMGB+P+JygJ8pgGviEVLPjhEKI=;
 b=9c/Nh5M9LMZTEf7PKcK+5Hqv/dWjx+aNYHao+IXyE9Lpi8hX9zjkIPm1EMl/8kFjmr1IfHoDb
 QnNQYN//NpABbbG/pAJC2eLV4BL8orSO/XzLvu9r9mMxo4M1FCp7ipD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2f1e1f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: WRUJVQqzoICDvzaOrUPifCb4upyCnLNo
X-Proofpoint-ORIG-GUID: WRUJVQqzoICDvzaOrUPifCb4upyCnLNo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX36N5FCN3zA2y
 LykMgP+ZO0XadccX/afYrfT+Z1qOt516o1TXoJwnH62iFNEephClP6ZRmeaOvYe/bITdRhKaXHT
 XHKZi+gH3QFTq9E/7M+pl4xZt3qPAoJkBOzwq8NbhxtZoNRta/vupsbHNXAjJ2uFvYFbkyCiJ0x
 Ys2/yujlgv/SBgyQHmQfcQz63gpSFSbkvSZBHhpY7H8vfxSxFPmhGq/IAuQUPWVP6lY50XAwbS/
 IVJ/9HuEPtV8WH5Hsq6xRTbNC63X10MLS1/HKCNmlVGVhsXznMtiR3olvxts+NY5TXBKCxxdSzA
 l3eEO6NgJA/iKNbCDk1iZ6EnDSGPejAZTdYlVdBbr3wA1+xqjeFrvD7dTxCa3KUgtJcDad4Ahq4
 BpFAUpmavFBn2KZlx38mSt8CLVL/n5rOVWKQ4n/hddR3xCHw9dD6I1I0qOKOzn5FrH5hHON6xE0
 57oFLkU2132iOn/5xRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX5ueOi8QYHLMu
 AbyGas4xVXlS/HlxWe4To1rT0OU4146zwwMD490zUT/Ibav/XvrraAx/YyRfxDOgEVgqWyyxF8o
 NzqT2gmsSCOxxDYdioUu1pqVwffVQ/0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140228

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.51.0

