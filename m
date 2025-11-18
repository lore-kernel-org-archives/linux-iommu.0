Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA932C929
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456045; cv=none; b=V5Nb8bcD3v4IR1LWydBDE1LJk+7DO5YXuwVpT0XXxg1L3DUepuzA3MLneS/3/A0XPMK0wDc1YKbbSZKZQ4QDcwYrPg0jNBAd9k38OCW6J/A5/vJC6OpHkpNCj16uIuZPwXSzoV8uo/ntWW1vX1u+LFRkhv/RBGZ+qpYabogeaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456045; c=relaxed/simple;
	bh=DBrZfc4GPezP/e0loWuAe+68GknA5/X9CxqWpGUm6+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRGO66XHjGRn6fl1Fz1i35+0CnAEaXxJE5ooc+MywryzO1APzWbuyUMCDFrhpkeYOrxNHEQ61FwUPFuD42Qs2JZWvp028vny63WSNAC0/Nes7TgCNyu8gI3GLWGpA9vouXUhtqsMgGsg6wIZZnYx+wXKXmFSn4+L94gTYypY/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nap4cjrQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BVAt2wam; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nap4cjrQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BVAt2wam"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI5kHxn4108388
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRYfEhQHO/l4hKm8jFGZ03SmUwr6xcPm0oWaVVNpW6s=; b=nap4cjrQxREJ+aqK
	PMnvSbH2enVOsFMEJyhgwLWy24fFoEzavVDEgPpIkfjN8F9f/ZYSFxZgNbUB2EtM
	EUp2seF+tODO4xhwSfP3i/+/OFYSo7wc2lKhgoLEqnzXButwH+S78fcnjAI2JbYD
	Nv+il9pNolq6yf5W6DMSFVFSD3Xd+kLSAsx4SP3vQsMWqrX+EC0XDq7L37gJOmae
	gYcxjJnbNc9fha9vY1R4XLiTENeHb1ZUMZTXMf5VZg/6QI4XM13sbQCSdrEDsN9B
	obQcXXwVJB73dvRA9L7/boItF8/sbLgEBYlf/R6FJ363KSh5I0eQoOvSTzygwvQZ
	O0wyUw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2hpbdbk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:54:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29846a9efa5so145087475ad.0
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763456041; x=1764060841; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRYfEhQHO/l4hKm8jFGZ03SmUwr6xcPm0oWaVVNpW6s=;
        b=BVAt2wam1yPkyAY2AzAxd/KEK6imh14VBZ7CwgRcBCuPlLFUwiLg3fUCVwSAuJK7/s
         HWSXjUUKDG1mcNFd6DnGKemjUL+3COo4wMRrQgCsyKqvxKZpvqI8fH6pG7fbDvmV7kVF
         DHrewn6NKLMLcmYk11/w7w+sqXdvCeIiutx6YywKr+DIpEQTQs0fLh8dK0NZxuFN0hjh
         5qvCnplr7eM1keKgLuvW3Rw7xzrqH9sEO8aD/grX166a5TFTPDjjYYlL3MQG5jRBcYPF
         /a1g15MNjU/oIHXq36TWqtO3xjPxbcUatm869fVQ5gd0ZQRNACXU6v8XFOKZNZFfRA/W
         0SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456041; x=1764060841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRYfEhQHO/l4hKm8jFGZ03SmUwr6xcPm0oWaVVNpW6s=;
        b=gxfizrpZukd23sqAEBjkOjZ2Q7v6MkWMc0x1ljqQWXdcyP6iCkqYECuuEXhmhT6vdj
         7hpYqcu4KzJY3xqiIDWHo1eEvZN+6p2eu19k4Y81OD1rd6ln8z1Df9T/mehrPxb5HNWq
         gzJGcQ2heEFmp8RTnP6tVYOLhVrh8/CltunsSLviBPiT/NFypNOrcgdW2aBhZrLy5aya
         +W8VTRv4HpKg0fCTCHXV6z8xe9eWe53TiPo1PvZWoQ6v/S1TaS6RKb2y368xOJQw5Xtk
         7XDZ/qcQmvT9P7j/7HBL+shk+xzRzHKoyw/BED69hOpoUKS9J31s2Q6mxoxlK9+xIPqA
         8Kgg==
X-Forwarded-Encrypted: i=1; AJvYcCX3SpuMbwIOYgYq/wcCcCH1x2feplClhP/LNURWrpyF1kg1CieDrt2PgR+jugk/5yST76B2gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+Jn66uZ/laxHPrE5MvM8bEQiaLOoP5cCdfTpJCgekmXNNgGQg
	dGHrFr2GHcs4fW+Z6wtff2koFfX8utqfI0zlgOtOjWU3nVopa5LOFr7syQ0tFRR9aUKWKYS7QIq
	dne9utHeKOfLkf6VR7sxKwxUTFu9onOLDHZveYJwDvA60qAiG5tjExluA0w==
X-Gm-Gg: ASbGncsIodxFX0f2+5Elq1ynHbn/Sj6gNs07wXui1CeQZD8UXBockhagIYRsKyQqA7V
	BV+ZkjkLSt3m2HwbNyhV67Hf0lAhgl1GepZmscGd5cyi47xtwrKrcXpp9BJ1dSCT1JNJNzxTpcp
	G6uhIeFhfxhLSOg445wnvXGYu+g8kR1Jy/IrZN8FASaAHN5M4E8Wqqlgfl45F0BSO6O1Did11pT
	mDP7xqrVLQj4TPBaC6SETEMxyA54q+FGltTZfgcOmk3RTMcCVM9cmFO6h5Cx/h6l4kSCDdl1AaT
	syISiqMqUBSv7iecWc8O78ulkvNl3QYdd9QBT+lqunWLwneFECtgj3K5BnobbkaS7DQCWDsrlge
	XSpSJrq+Ut1NpPA0zUUkirY4=
X-Received: by 2002:a17:903:244a:b0:298:1422:510d with SMTP id d9443c01a7336-2986a7435cfmr202036335ad.48.1763456040671;
        Tue, 18 Nov 2025 00:54:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfC5w5rOHD0/xHuLdWAeU6V8QfxoC4sF9cyqENeOkg8O/0IIShO5Ep+df4JjWBBzLhi9J5rg==
X-Received: by 2002:a17:903:244a:b0:298:1422:510d with SMTP id d9443c01a7336-2986a7435cfmr202035865ad.48.1763456040119;
        Tue, 18 Nov 2025 00:54:00 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:53:59 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:48 +0530
Subject: [PATCH v4 21/22] dt-bindings: display/msm/gmu: Add Adreno X2-85
 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-21-86eeb8e93fb6@oss.qualcomm.com>
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=1677;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=DBrZfc4GPezP/e0loWuAe+68GknA5/X9CxqWpGUm6+w=;
 b=zvvisBZ9CDm655u/GMKAP2PN/vQQB431xxPZEb3DHkoURhax7xrlKi9CfUl8Bnj4wPgFckzyS
 rVSm5NWKKI0C2AxbhYwWPl9F7iIfqVGVFQNNrX2VVi4eTv0FFh7U6BD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: T39ho6W4sgd5NGmUvtAcaXXdXW-FjwaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfXzag+wD7ZKOoc
 /LeQ3oljtbOC2iNbF+EZC4bV9qCnt3oqOYtk2IAFqJJP2Tla8sXLN9sEePi0SJhV7+OclgJ0+nd
 8jO/eel8WG54EuEHvzq+DDLYPhn3dDlU8xVob6LQ3GJppZLiZ7OKnOzXjgLbj4VaJxlIIYOfICh
 p6Vh+uw0MKxfm9ID+lVBnJQOPuD/Fj3f1ddhC6O0yL4WECWvSTCMjR87jYSxxWHGnaNoQeEk7pu
 5EH1+27CdHZOPVolWxTWRLnrwgsWdBx3QZfeDmI94WBxwLkpJvjsGuM8BdvD8+ZiQCCN9t8VX5q
 nAdRIojL1Ssi3tA4gE/C98Jy7thZeD9Vk7WNjIhTMjiSPdUdbKwiO+tPTk2P3483dTIIFKP6O/l
 ChmhPy2rfNzHOhEffVxVj78ukNJFiQ==
X-Proofpoint-ORIG-GUID: T39ho6W4sgd5NGmUvtAcaXXdXW-FjwaS
X-Authority-Analysis: v=2.4 cv=Y5L1cxeN c=1 sm=1 tr=0 ts=691c3429 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=_Uo5JhhLEGw40-SN2AoA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

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

