Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50232B9A3
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076739; cv=none; b=RxCTWWEk/O8JkcoBJ8f1WT/0e7NxeA1zkTK9h9fyrdHCI00u+OKkaqrVhyAy3plKKlK37wXUgXG4uWLqyqW04UfUdmyYUbGHNylVUiFkekwE7KgsrDjZsh6t+m3QiGX3tnF2tYV3K3ajMty6al2zvLGjkSU2wEQ8Bt6x+gJ2CUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076739; c=relaxed/simple;
	bh=DBrZfc4GPezP/e0loWuAe+68GknA5/X9CxqWpGUm6+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reVk86Mnfgp71oHGwAzNHWxHQmx11cFbNBNKK4HfpWvXlVn5H0nfLqr42ii8oJxYolGO1cBcgNwkjOYuq0J80UHf+P0TGmdaxyvb8z58qeL+yV9azAMRzJF4VCG46bSRL4jQnUaOXBHXmsFHPy6h2uX1jF/mN2aNSOJtDGTzmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThXyaQTD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P7RZM0fd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThXyaQTD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P7RZM0fd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMadgd1629375
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRYfEhQHO/l4hKm8jFGZ03SmUwr6xcPm0oWaVVNpW6s=; b=ThXyaQTDJPqOcpAb
	1tEkPU6On/laF1l3L7aoaFM6DzJ0yGYot74k9fRZpKoFQ9jOpKf+ce9rvXeL8nXC
	Jl3z7rn14ut8dTx0fKahmsGm6xSazPsfYpmZCsw/J8CqgPizB6jlxTNGOVbwtv3o
	GpgA6+7Id2RZ10O6s9GbGLpPE0IYh/f5F/T79qhql/yUkYl92xyAd9nVpvw/FT/W
	kq9Kw/rN6m0YqrkxiYBGdnddkNctuWrY0WmfZwbamQYVuhOHo867Iil/qJOhs6hG
	fHGf7RKjzmdeHDHtO5h9yooAHvlEGBi/rXyRpnYtuQlKvtbVtmVhBITOsp9ImlN1
	Ww9ijQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9d845h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29846a9efa5so34550385ad.0
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076736; x=1763681536; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRYfEhQHO/l4hKm8jFGZ03SmUwr6xcPm0oWaVVNpW6s=;
        b=P7RZM0fdRYNmRCBTOJVeG/ub1c1ifhEJphxhI3omCclK7vBmkscarNXJ7LkMgkTdXi
         VnGFf7dz7IERkLsYQC2X76crhxeLx0dX0JSlGLm//kDIfClKjow6/ygER9t8RGEa+HEC
         SEGQwFx1TtKz/3R5FuV1Tv99F9+AsOT/EK1u/0/0J6OfJF3jasFUZxYJpCQJP0pH19Vg
         lsVqtkH0LgnlisRoUOjZ7vNFijaUqROGdXwuFKC8d+W3AmbevUCsDwPO5c/Bw9IZQFOk
         g6sKMq4L5fLJirZcqRUwGnvENH1+RbwpK1wNRI2Sd2X9xusVaxA/RYBLKeGXoAMYoO2S
         muLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076736; x=1763681536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRYfEhQHO/l4hKm8jFGZ03SmUwr6xcPm0oWaVVNpW6s=;
        b=BbKcQIsixRGwNIDwkeq8zQdmAQfJ4KLHTa4dcX/GxMCqGly5mwjUvjycyD7Ssp2rI7
         pHOtsKRaj9GQLxHeQ+qZmKfMBZ8WwOJT4edOhnuP7pNhLjQNoQjVvjvonaXdcmLNyUQh
         Z+iReovvetmxzoEOCUP8D+XiaohI01ue85ZjzSFgILihN3l+L1W22c/2OKs/zMRl9j/6
         tH+x+Cb4bjFo8D7OQ5u5YhlSa2yzoFcULpXx2NKfsEiLNGg3PBs9rpe96btY8d/YTDl+
         qUhoWGSnc0pX2Jq88Be5Gv6HMPXeUcLb1jfmhmDD4UVRy8XX6hnHSdN1R4KApuf96Qsn
         oTuA==
X-Forwarded-Encrypted: i=1; AJvYcCUEmG9G5qdS1wTGgkhRrXzI7S4jIoX6nzHwsSCGvllPD7IzhLuJLeHECrqfNYR00G2tURbUCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYIQPU2CY/tzphSCUQ9iqkJGYRyDil9BH7HxjNE5VWocbikRI7
	Tv8jqisaBPcnf3WswtBRwBzO2pVFgELFX7mORhHWraxrY/+U5DT6n6ach3rIWrYgLRL3hJexYaJ
	iBGfquZ3uh61BY4V+cWu4e/KFxgj7w/6LDxeOJf4SMAqtCKiyDY70OcQQUQ==
X-Gm-Gg: ASbGncsqWthtx5tjgz91CE/MzthTm4Cp5/E3sUNjgZcu90fYrx369XCZKU4vxBqihOh
	DlV5b4jQPy42pTEY9Q/m+/FAFhwWRKGNqF7FM6LzSyRpnVKxecpvtWAaUGAC1nwnPIg+NJ5pUpb
	A6ugHyVxhx3Izqn35W0ONCTbQv0/tPaC0gcjW32+s3MgGbqWz/G2E2otiabARP+gJsYsT6hLSw0
	1TnmcVINhuLdP/hOXXDr1LZbIBaUs/74PBkliKL8OViqyO7GkKce6xYkvEGr/mSvMOk8Y21brGr
	0QL5FH+Zt3aZ6OOVH9NenSS9aaknfo5h1k4j3MG2x3hn+NcPS5Uq+SRal5qSkTRw3IDCCJOqM7J
	8F0+thJKP2BFVx/nVkXqYEao=
X-Received: by 2002:a17:903:90d:b0:297:d951:b4bb with SMTP id d9443c01a7336-2986a7435ecmr7356085ad.47.1763076735696;
        Thu, 13 Nov 2025 15:32:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEodQqYgRJkYLIy60kg92PboSbyAXwzBxQKHsvJ7k9auT4mdj7T3WB7cWTBc3Q78iQHPbKACg==
X-Received: by 2002:a17:903:90d:b0:297:d951:b4bb with SMTP id d9443c01a7336-2986a7435ecmr7355695ad.47.1763076735212;
        Thu, 13 Nov 2025 15:32:15 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:32:14 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:59:17 +0530
Subject: [PATCH v3 20/20] dt-bindings: display/msm/gmu: Add Adreno X2-85
 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-20-92300c7ec8ff@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076574; l=1677;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=DBrZfc4GPezP/e0loWuAe+68GknA5/X9CxqWpGUm6+w=;
 b=VcSmbJTK+AwALI8XC93AXkctqWpbKLucIhitRFtg+TnNd7qWT/+mcPon0M8DxlJ+BMR8C3A3A
 P4jrORXACVYDIs9gVsH1RAPyI2NIJ+HFj6zCe6e8XrFttR2KeLzGgOY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: WhFl9rLUVqNjAxiqe0QoBwPQJgUvL0LD
X-Authority-Analysis: v=2.4 cv=Rdidyltv c=1 sm=1 tr=0 ts=69166a80 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=_Uo5JhhLEGw40-SN2AoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WhFl9rLUVqNjAxiqe0QoBwPQJgUvL0LD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX7OpWuQ7LaUc6
 FUcSsN/NSzxc5TIWZB7VwDlB53zcwPY6cvLCE2FKTZ3vnPfdQc6ZNlEv5GPsF9HZXuXGsfK6xvY
 /4WMrJkZYsjDTM1/oIO7pc42hMPfz3bxJi0Nkq2lsvMUpBBdBDLuBGLVYuR9ng8NIy+GTrqrpYi
 B6O6QJEUIg+iNs9jxA6n4697+r7ce9vfOcxBfvEmjE4pRQc9TLGNNCKoQ+Tx1uTQM/hKQwPZX3F
 /uIq15n6mA7XtOl3Vlvt2DBOzmKCdlkzmoKrOVkcj3OYdK2SGuZB/FS+dtykh0bxgWtyLihZY9q
 c89+sLWphGDJIpv4uizu5XFmE8KhzCKL4HEt4PfAdT6iTo0hFz7zAHRyQH4ZCHY47h18VxlpMcS
 dlvF8AJN6YFSWtqeySlnawc9dEP13g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

Document Adreno X2-85 GMU found in Glymur chipsets in the
dt-binding specification. It is very similar to Adreno 840
GMU with the additional requirement of RSCC HUB clock.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 2ef8fd7e9f52..e32056ae0f5d 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -327,6 +327,36 @@ allOf:
             - const: memnoc
             - const: hub
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-x285.1
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
+            - description: GMU RSCC HUB clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: hub
+            - const: rscc
+
   - if:
       properties:
         compatible:

-- 
2.51.0

