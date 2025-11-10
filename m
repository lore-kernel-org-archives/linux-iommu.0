Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094731AF3C
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792846; cv=none; b=Zi3cmR+am2yxrqfa0C0W/qqpcbVQfIdJaSOqJLCCpKA2FZoflOLYZS1GjQAVN/ia9KmUyRpCoyJFNb/O7hxaL3b01MYhnRXbk6BsbkhMCvhh6kfgqP2VhvKJT2xBeZg5Hf2UKQWWx87W4iCoUYvzMlWASZDKsGS2Ciixxv6ni+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792846; c=relaxed/simple;
	bh=NcxT59isJ8a73ABBo5632Wjovo4V8SjmsWcRhDa2gQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHt3qWOtLoZvT7e2z9SgnZ71zu3Si58vkCViSGr0EVZPam6ypC15ri0NR9lAwvKObE/i+QmLPl4WBK3b/djFR7GcCHww6vb1RjL1glcSgjYmHIy1CrcU2U0QvKVtJmbNHfss3+U8/vjLnjuuEK65+nXTiWqGGgveKCyqHE5a3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mfb5RfcM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TEuzBAfv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mfb5RfcM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TEuzBAfv"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAD11up3676867
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=; b=mfb5RfcMzuKHoEwN
	bE/7sAthi6igUtT7/JkWPEeev5XN9rHHFoloGCk0VSPlSTJG/dFXReEi9t/AFBwF
	rLZOEj5lM0LS5lQodxix27ElTFsUVSWdWpfmnn0RI2jvTQB1wyMIgul1RZmgYMNX
	9rP9bkQNkRJEz4VpaQgvOBKccWu5MbtL1J8lX2xtbaws10fA2Zng1C49+WajOKC3
	ZghEAo8v/AcssjoShvDRK9kH66nbQ+SZsP4d71kPVOoCbMlwdNpKrQC3jhjDbrRs
	M+y7S8EKKJQTlh7J1QFtJij2Nhtgxngc65a8UVrLyawJGF4EKvPz7jU8rxty20MU
	UvZ+hA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abgjh8q9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-342701608e2so4063602a91.1
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792843; x=1763397643; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=;
        b=TEuzBAfvXfW6TygB0WHOTU77fhXn3zVSa7JoZMT4yL3mnjKzQix05tRmmoxl011IDN
         qctx1Wg+LkTohYfX1amc3KYKhxPfrdaO+X94Cz6palRLl2cUdOrgaR6nBEVkV1nb1md6
         70QwD9bfRVUQqPg35v6JfIJRIRfIcSouVCu2w8ojiKGl7STpLvWzcSpS0aXN61OaIKMZ
         3ooJJT0YF9fL05XJF32JQtalqVd5bRN3aiUc+FcW/oZzhIF2H7y1muZIpA1v4SO9fYi5
         idoBrAUSU+3k8Aob0mqVchOx4Su+sKETBIdjN6rM83DGSctNojxDGdJTAxjYzApDrJVX
         pF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792843; x=1763397643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=;
        b=WqtEZEYW2cIUKLajsHpgvOM6S+OQGV8tksb5hDj9aNma1sn+Vh/67qWT3ZLrbY/Ab7
         4nscS38RKzBz+OgxGL97V0MrsSrzAtdroZlR2KY0dCht02Tjxrl9S9b4N1CIttM8jkM8
         Y3yD7kl0L3VYIMUmaoPIFPE5/2JCz9/ZNKwjEH/UVPpVyaV1oRiNsAB96dFtjmYNvtl7
         zTH55cKP76EtSmCO/nsjFGootCfsJ9RrRs4kqhfJJNuoG5zaLJK9V6siX7RBwMJB1V81
         0XT59cnx4TwJezrC4vh7GwTLrp7kgnS7O4G7Cy3nVVkHu/OvyIhL5ZVjJdIuxWdkkZBX
         xmCw==
X-Forwarded-Encrypted: i=1; AJvYcCU+L8s+UiwGTG6xX+cmSCQYghuEyqiO7eurvun+nlkU2zjo9rc4P0yxbqoRDwYj4zdZpQ+eLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGQu3Nyb5I2Pf+ex/Gmwx79hEzSzMt/7FVk6DmOFsdHJqWtOcE
	rj9jj+NsfI6qEjVUZnzb8QUBYr6kOkV55lbb90BLA35tQGP0rwMceTgX+277hp5/hI3pVxE7dAi
	Dr7RnL7o8JQXn30pbqvFz1QYC2DNEr4u599NoE5oaNPq8PNfsALvN3xpuAw==
X-Gm-Gg: ASbGncswq7wT1h2ygnPtcQDRmpXbZsVkPPXy21PwCsQ0MDH0qpuXsM3Z3qhp4ZX2wzB
	0lOTD0PqWap8wS6VBwpRQJiJNOYKGuL/7cm3oYd3/3WFHEwF80a2S8uFN3zHLUI0eVVuVHgmGy8
	+wlGbnzeANRPBzpEVM5np170s3JmxUAWIspC+BTtB/uq4iEzhYjTma5fMWUief/Zalv/ceKaH/E
	LoTQI8OM+lK3W294fpSBrdBV8f005SqiuU6N39TRQuUAcgPDo1F9bF+99FOjjSO17Tsza6VeZXr
	D/ytzIW80X9f8dznLqaajxnfk6+weO7bv7ip0KlLW4zXThF6HDPB0QAUEaW31102nTDQhS/YaVr
	M2M2KzSRDoQjk6uExAXSHpKc=
X-Received: by 2002:a17:90b:3bcb:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-3436cb91d57mr10342263a91.11.1762792842922;
        Mon, 10 Nov 2025 08:40:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKgiLlV4ge4N7aykjwSwNvV4o0Enwd4Uv2Fhb5/BsT0fXjzUdfmFl0uh16HkMMpYGhsNkY5A==
X-Received: by 2002:a17:90b:3bcb:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-3436cb91d57mr10342217a91.11.1762792842430;
        Mon, 10 Nov 2025 08:40:42 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:42 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:25 +0530
Subject: [PATCH v2 19/21] dt-bindings: display/msm/gmu: Add Adreno 840 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-19-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=1792;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=NcxT59isJ8a73ABBo5632Wjovo4V8SjmsWcRhDa2gQw=;
 b=eQNZUxkw5igOzSHswIKdod1+5/8HKSYuY9+tGDZhsMU72Rcrco55Fm5uE0tPCMdIF2KWAnNZM
 /YOiz8V/KyiDqaG+09P3D1DWGc74RvvkXZCpIovZE2CAEjx+EVlVC6f
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX44bXFjyXoU7y
 uGDklCGWRlHGPHlAqjGOedgFfh1z8bJ8Oqrbn2IfusGWQ0Ha2939FlQzE8h8B/wOjl1kFf86uSN
 ZN9umjpNxkr8A1uNjZ77wvVOD1Xe/DgZkHDAhVwHHQU8hKe9eco9r0gyitpKJEyjYP98lOctIUG
 ADVzJ0zWuF8mgDxJAWsDTldQj1q306wQywim2CQhzlFYaktQOYKUNPhpaZTDJMOCAX7E0v6w6fT
 Zzvi/It0kX+laTI1cufDg/JoNKEmu7u51q+JDuPeZz+wKukYKmB22GKPaUHAFm2ab2wNsP7KB0V
 StxcDkY0226ogkOBaZ+Zy/Q/OU3uQc2exfFrjuitBYXpm3YplDqtYVA5nrVh5VZdIOSRzHAWgMR
 IsUO3520i8UzIiiv0raKb9g9wl5mEQ==
X-Proofpoint-GUID: AkPDmm758IWhtD981x9SqKMIvYIWjriR
X-Proofpoint-ORIG-GUID: AkPDmm758IWhtD981x9SqKMIvYIWjriR
X-Authority-Analysis: v=2.4 cv=La8xKzfi c=1 sm=1 tr=0 ts=6912158c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=e8idWDajkKX97RI96f4A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Document Adreno 840 GMU in the dt-binding specification.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index afc187935744..2ef8fd7e9f52 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -21,7 +21,7 @@ properties:
   compatible:
     oneOf:
       - items:
-          - pattern: '^qcom,adreno-gmu-[67][0-9][0-9]\.[0-9]$'
+          - pattern: '^qcom,adreno-gmu-[6-8][0-9][0-9]\.[0-9]$'
           - const: qcom,adreno-gmu
       - items:
           - pattern: '^qcom,adreno-gmu-x[1-9][0-9][0-9]\.[0-9]$'
@@ -299,6 +299,34 @@ allOf:
       required:
         - qcom,qmp
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-840.1
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+        reg-names:
+          items:
+            - const: gmu
+        clocks:
+          items:
+            - description: GPU AHB clock
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU MEMNOC clock
+            - description: GMU HUB clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: hub
+
   - if:
       properties:
         compatible:

-- 
2.51.0

