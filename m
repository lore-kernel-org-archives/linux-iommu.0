Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAE368D42
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613729; cv=none; b=NGk8mX6tVzuxqMfVdEygmABLTsKtVKR1Ytk2BsOwshe1IiSJEhBctqQFuGD7+BHey3+8uCWyolNtd1gJeYCGJ5x8FRm1t8Tm06yxVe5hQs24Yg0XjyA1C85Mtq0hIyPZiL75tOjpCY7yKmkeKg4VmiN+83p1BM/4IiRiN5g5I2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613729; c=relaxed/simple;
	bh=Mpr6Q33aJKvJH4hPu7N8/Msc5ivh6tKB28dTURNeqko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhvnaHAaI8EZ6HOjrWmQYszrnkDwu0HNcXHOR2u9lzDHt8HNW5DXGaYXbdv1t97QxUT7l8dDLdbnOQMi0SVR9KhhGOvUeqPSI/f5kyFbtUFQ90tZBHgfd7lZOrWEeOpIDfDZeJQ+2nS2SNyt3exTL/vLcOd3tgHqsH3Spo5Hgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJakw1D6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AgArIrXM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJakw1D6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgArIrXM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CJ8MPb144590
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=; b=mJakw1D6cVqieOmn
	f10Zv4ujgl/+bv8kijme+B507ip9cG5AQPru7SOfLm5m1mCzkjPRn/Zb9GskcdXW
	H/xmhPBw1TJ/925r2vDYSj1si4leuJm5zSAElbXAnBqsSxK/lCLpzlWIyQfkmRjl
	3v+XgfDYF3m4SFkTQLbDdEHavpFc415EpCk3IRfpaCVaUR+U7Ottq2v90qtT5h+E
	5K7farLe5Z0XEh4OAo3EXQbhg/rxjWXqBCU0RyMtYyTaSbyV/26JxALHR6mjkpEd
	mBn2v/G/JRgRU2pitgagSaMIn7wg6cBw4o+m5Du9/q71FgTOwJpplMzqCLWIV//H
	ZVakRw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43yp9r33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4530a90fdso143370075ad.1
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778613725; x=1779218525; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=;
        b=AgArIrXME4UNSYqmJExQpt6HzWazMOZkK/rAuT5AWbYl0KWo4SWRzkIDSQskATITLQ
         8kcZdltumf3hQVV50tNuDib61PsZTVokwk14PW/suBod8Mrs9fEcTQAi9PSKCcYUM1vz
         GYkB25i6pI4mRGi4syWwwpkxrImW8AfMJvK1eb1oJQkhbzXJwyY5UzF9KVNpNOab7TeP
         ttPd64iWv97SIo361/4BZ91tBA3PrL9etq6TDJkn6/A+t90UuFxGWz4u5N7f24zHgPxl
         HuLR0A2lgNGJy8mFkAAJWcXmN1+T2Sin0gTk/6warnc3wy1TelMTcGgcZatEW3436WZ4
         4mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613725; x=1779218525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=;
        b=iVDk4E+1pRfHcnfeaTjtedU+cZqHA2QtMDUR7yTwyU29cwi9OdsjVzLfU5TOQLMt8S
         uANzoFUzCM8QB/YHEcuwtXeMUA3aicCpq6TdlpV2x68AE3bWp2/fZdsCpBQVo9k/PRcp
         vxqvnlfzQ9fM2aFik5NTEUD94eUb0BdOywqgnUUXMwaTONTwx/otX60rD48SMeHtXvrn
         D1aiHdX6IurjyyAtWQXEpV2L0kAJnGEbanPzsGnlbuo2yCG26OEXXxfALNOk+jdTgaoI
         +GijEn38LnwoQPIMirjO6sMK68B7JQOETI6kxqGeeZuT1rq9CT8qDH6XnQKtwNEh0pNA
         MqUw==
X-Forwarded-Encrypted: i=1; AFNElJ++hQZM82+d0WVYIvLlkvJ72qGPSjkWR6EMZhGmSFs9oQu3e/XKrK+Ah3oZ8+3Z458YcmD7FA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1Q9VGiaqV3vTc7dfq1sIISgZ7a89NhmaDDAhycr/xZymunwZi
	17XiJvdRGlu5DEoeDAXrar0BBQJsJKHhwyc5U5qa5EnXKLc+6if+e4JBLv7NOTxFsL20G9xiwQt
	hyTs5Ta5akUDeT1UUZfTp6bYv5YfafjgCyvvKZZ65MvSjr2738lxH5m6P2iCeknlpaw==
X-Gm-Gg: Acq92OHjn/Od9myPHWN9oWvQV0WZr/EvzuXWu1iKd0m5mEg+y6IMRonPF7yJTT4RzMR
	sOoV3jY7E8Am8QoHNZznNd/p7a/zlafRdZUtBEHKovixrIgOjQnaZ+2d/WqlZnUOOJqYvW3x2Oa
	by3yJQjoSyYxP65YsvqI2oe4oKQ4uKso2MlUs0z/piGWXBL8HbxhjgT82U88e0VfzLkA83QYqrW
	XTd02Z45PloDOYXcjaAW29546o30JM9Cyg25sUvFgEM5yYQ6OknFeLCa0Ncw3Rg2uoSY94caVkj
	eCBR3ObtcMIO6bSqeF+j49zyX9hdQOsKoWbydaWyFcG6y3K+SQqyhze4ZQq2ZzgGa3bQwlFHTQn
	6Rxz9R4xvgppXEvrosFijmehSfmYtcDwW6N8fdRSGfwBe5Q==
X-Received: by 2002:a17:902:70c8:b0:2ba:df8c:11d3 with SMTP id d9443c01a7336-2bd275d00a3mr2773325ad.32.1778613725160;
        Tue, 12 May 2026 12:22:05 -0700 (PDT)
X-Received: by 2002:a17:902:70c8:b0:2ba:df8c:11d3 with SMTP id d9443c01a7336-2bd275d00a3mr2772965ad.32.1778613724679;
        Tue, 12 May 2026 12:22:04 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:22:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:19 +0530
Subject: [PATCH v4 2/6] dt-bindings: display/msm: gpu: Document Adreno
 X2-185
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-2-f83832c3bc9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=1607;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Mpr6Q33aJKvJH4hPu7N8/Msc5ivh6tKB28dTURNeqko=;
 b=Gx9R8cnM6dmWa7xP8HG35i9llcmnCvT54E/MmvyhWf9dgg+yrc2NmmfCLxs6WzuV6JSZJdKkD
 rwYBNyfDpaABoe22B55Lf5pwSwQzUZVwZXKhfFNU6SBGUwmDH0uqd6A
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: KuZ_hiMEeWYaO2rZ4X8suAIXMWzbAk49
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a037dde cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=aapufVXKjK5bSyzaIfAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX7r8/P2kNywNd
 v0pADCjsYIYb/NEZkC+5ru4usczKkh/soK3GIzlK3bReYaJvyNEKH8FQaHTznf1eSBV7do2BR/P
 tsfeZ3FB6Czu/OftV6x2mul9x8IXYUEWKnKQzgihjKDrxTupAW4Rw6/4Iuaa4ID6I5PCedCh5oT
 a5VMyhfZIequs3v62hVoAHCNpr71DPUSvTbBzrDUzS+eIKrIw9LJEmmHsbNj+fjcKXXeuAHcOKh
 AkpiOtTQqees9nvnnd3s31t5yq0fZxuv1l9xlcjt6PJgRBGrmdd2RwoTt5KVSA/h86Y6iak/l2l
 YDIYBwxd8+Pl8pQemXVh2PgYku88ibLcyMV5A2TpqIukkrX/13Lg4IEeWr60jcO52+aCeJd1hTT
 fTYvgZ2J001pDVpGQDq4bKkhdUt2bdrkg2JKV5gAwcCvOI8dB3X+oHT6kCOrN5sCm6p64hSYIvx
 qD9rYKKGjBiMJqYhYrQ==
X-Proofpoint-GUID: KuZ_hiMEeWYaO2rZ4X8suAIXMWzbAk49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120200

Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
It features a new slice architecture with 4 slices, significantly higher
bandwidth throughput compared to mobile counterparts, raytracing support,
and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
other improvements. Update the dt bindings documentation to describe this
GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 04b2328903ca..e67cd708dda2 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -411,6 +411,22 @@ allOf:
         - clocks
         - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-44070001
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+
+        reg-names:
+          items:
+            - const: kgsl_3d0_reg_memory
+            - const: cx_mem
+
   - if:
       properties:
         compatible:
@@ -434,6 +450,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node
       properties:

-- 
2.51.0

