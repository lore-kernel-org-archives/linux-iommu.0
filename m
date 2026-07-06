Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A606436BFF
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357018; cv=none; b=E+E/+EUYGPvHQ7KTocFe2WxbNLahUWV2R1Bc4y21zJBpJ5Z/8qFxJX5YrmS7rw2qCdCQuUK5Rxrw675jz1orRIRb+7zyR2pFv/EZqFQpLZOjBagujbtqdpHpFLPLSp65NjAk3iJqoVW6QbdQSLkv8iailB0oG7VeQC2GEooAsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357018; c=relaxed/simple;
	bh=G2Cd/UHUeBLQN2fTTAlASpH57IU25h8iXlFD+D/JrHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWUes5ocQwpLFhLGLGa/W+GjM5bN8r2YroAWnH9zHNa0cU9dYdZPu64LKpUW6vsVHmZpjMe4KKesBn4rn4TCjob1HRhg4AjI/900nxtjU0mJyGpbjHv0nm6oPZjbDwsdrqvpv8ldnwpbGwoJG8GxQhIIKcCJJauRXpfuhO5756I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmrSm8gl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HtwD4B9r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmrSm8gl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HtwD4B9r"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF5GS981539
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 16:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZWfEfDHzBncv/pi9+AyhHfHT0HYBarl4vGu6Az/nXSM=; b=AmrSm8glcCZwplQ2
	kXIAQik2uvZ8/h3mi703MpqxLdCkgdpqj1ps0GSiQyIGlGTn0ILnu18URKd/cjRN
	WhQZDRhT2cVSrva2EAxPk2xZP81Agj+1fimUphBuOFAiKoQnp01kDhjrOK46meEw
	S4dcBYQUWmfSSaFR/m4dcpcv8XF2EnRsqSaG4utXvWnk4IlsBEEabnY91FaI61rJ
	qUzixP3cwI4PFsj5kjjunutZP/QojESs6+VU5mT+bfeQtciFL7utXbucj7TSXDPZ
	9n3eB0rgxHhTl+tF+I7xnbUrC69sNC9h0fQdsxDZGShXeEPU+OevA5uFf9R4QleN
	BuJ0Gg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgt3rs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 16:56:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso5168534a12.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357013; x=1783961813; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWfEfDHzBncv/pi9+AyhHfHT0HYBarl4vGu6Az/nXSM=;
        b=HtwD4B9rtvLn65kj4TIWYpDLFTxUiziIET9Wy1w941/JdTS8OuPMKddKPQCt0dezug
         EGO1PqjwF2XuZVzEZ/ehma+leh6VpaE7/s/EXeXJwgaPdei1x+HH/akHDchqdFxSnRzE
         sPUlw3VRqS3YZjr2M7WAUqvhoXNOY5fzoOUlA4er8lc8TTzOexS95QNGEmBnmxbXXk31
         hXC/8Ne8GEzJCmjVMFQBf9Rj/X2YvFL30SOXycDROjjAgi/3g77lKtHLlPbWvJbOWtjl
         QO/NewCxogB4EiJOBpGhh0xZf6GigsYrihIUmh3zZ4/ifZU62p46RaHF7fhzCXlSq9Wv
         R1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357013; x=1783961813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWfEfDHzBncv/pi9+AyhHfHT0HYBarl4vGu6Az/nXSM=;
        b=kNfmQMxWuqIptzIH+TEDnQRvZp5jfmW0byEB7OkOymxz59GLKsx2HAXmVkHU5xgiK4
         k13ZU6R93FNePeYAI2M9z5BQLJQD53nlHLC4rM32S9ptLaBnHo2+8lP3M8crOhxdQITj
         qUwyUcl3Qs05A0wJFqy1LeyDAxZZkeE6ZwpCONYdq9rTdCQacc7pqFvpe7YUxVPk1rfG
         2k9GLy6G/LN7EoMibKQ00GWxoVYq3qqme9A6LaehmQeqeKeJK+AZwcE+akIe5+J8WBgN
         zcVZRkWbTOXX4Z4R7U+pMFqGwpGsNdO5R3ze5KwDJRbILTtJK00Zl2RCno0ZFPVvGNs+
         jyRA==
X-Forwarded-Encrypted: i=1; AHgh+RqEHvJECjSYDZvC9jEShUQ5fT7ExGUh27nMMLgniNV3vHyO33udvc1xuSIpyTlj5SZnmE4lPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJhNP8MtZCZgYGFPkT0N3ojEbL92ya4JRyMKYlAieOU2OrNFys
	Ea314sFQxkUvGQ0xff1vrnIknDWrLWuqhEuTMp5A3vdXDVftliY1kp+kT8UgN5qz+d7vUmVN0ng
	saqO1fHmKiHH3cMjtiocc2DONZpiDDiEZLoWE8sZhTRSUmFXJup6K/mqNtw==
X-Gm-Gg: AfdE7ckQLrCXFhlZjaIBKAdaEFAHtdjaukhYL/Goe1oF9fzyDrbHNIwRqy5khREIxsy
	E0/2Oa5f30ZSgojnarxIDxKfhoDhuQNsZqXvAxoGRxu8SgCFtAx6V0W+AvsKjehRziOyihYAK1t
	6fmB64B0wmJLOJsUrZqXTtf4/LWQ7In+3BJHX45+jCUwA2uqLttte6MYtc2SXRG1KQVio8D6YXb
	74w7qyBPYwbfzgptF1BiD9PQ14R9U8KTBmLglmsvIHtRXNPIt9ndifXy6bmoN5SEZyMwmnP6wex
	1MincoAn4PS3RlxagzachzzYLhWoXd+fiL5ScX4KQfGq3WZmhGj4bitvBeCbCm1Vc3EI7Y1GtHs
	ltVXtkPtlHEM2Z3P17DbTUhYI3MK4LcxGk811C54tHQ==
X-Received: by 2002:a05:6a21:9206:b0:3bf:6c08:4ec6 with SMTP id adf61e73a8af0-3c08f00256bmr1778673637.59.1783357013401;
        Mon, 06 Jul 2026 09:56:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:9206:b0:3bf:6c08:4ec6 with SMTP id adf61e73a8af0-3c08f00256bmr1778641637.59.1783357012962;
        Mon, 06 Jul 2026 09:56:52 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm6960604a12.5.2026.07.06.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:56:52 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 22:26:34 +0530
Subject: [PATCH v3 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-smmu_interconnect_addition-v3-1-afdca0125a65@oss.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
In-Reply-To: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783357002; l=1911;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=G2Cd/UHUeBLQN2fTTAlASpH57IU25h8iXlFD+D/JrHk=;
 b=E3aaeHiOrUd5FHK/d5Be0RRksYkwbu7lJwMG6vthS+PW3jji0kN6C6H0hq9Gx21ucOO1ddRs4
 U/2VitKxsIsDyjaUbkpDSupX0WqV+pJUrxlFbLlgxX6WmpHhkLtmKX0
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-GUID: xkLimqDWq8sB6IwYfXZAF8Bo86_5VJfd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX2Cc1IdqvajzG
 bvts3VCOmrtCNcEoKtHYv8OyjMtBSGDn7HCTdEkqS7CPiBxbXlhUkJDru+LxrFHr4VwXimzzeec
 ZfgASDr0gBS1wFuQYmnY6EFDJpUJz+4oRrfIDXxuQMP/VFDKocS6aDq2BFoPN0icAe/3kDjgcDd
 3enaauh0VmHXJMlB2uvKHTm90qcI2bNU/hfofjCDYFbdWRu90D4we7QTNxq1xQwGz7WqcQ7349R
 uRRNCcwJLE9rP3YCYF6D73+o+CWNAomIFYkcw/maAju1UXK+Uon15w/rjaLlG4fXVBBe9pNz5RI
 BLFoRFCC9jV3GWS6zTX+BYOWsyjwyUFX8y6z7VyhnStvzv9PklPihgtZiR0A8MhGOnxc0uh9HJx
 LmEYiEkBOIV/C2zw0CHrBobZOvgmx4TkBYyoU+DrXFetjacTUGqPbNcfhICy/vHtCY6utC3CZlz
 NvqF56LLjlZgFBQh8xg==
X-Proofpoint-ORIG-GUID: xkLimqDWq8sB6IwYfXZAF8Bo86_5VJfd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXwsG4qqCkTIHg
 UNUDpKkQLYE8MfyMhLIqx3C04WrE1pcByMYsMeyWMeKYAHoQ9XhAfG5n7CUnU81VDTZYyPPiALC
 mhQxwGhMds/VHp/ap3dQBOI0sgRhwds=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bde56 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=h2u_PYqE-o0iKWOXq5gA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060170

Some SoC implementations require a bandwidth vote on an interconnect
path before the SMMU register space is accessible. Add the optional
'interconnects' property to the binding to allow platform DT nodes
to describe this path.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..fab8944d7b63 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -246,6 +246,13 @@ properties:
     minItems: 1
     maxItems: 3
 
+  interconnects:
+    maxItems: 1
+    description:
+      Interconnect path to the SMMU register space. Required on SoCs
+      where the SMMU registers are only accessible after a bandwidth
+      vote has been placed on the interconnect fabric.
+
   nvidia,memory-controller:
     description: |
       A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
@@ -644,6 +651,26 @@ allOf:
         clock-names: false
         clocks: false
 
+  - if:
+      properties:
+        compatible:
+          items:
+            - enum:
+                - qcom,qcs615-smmu-500
+                - qcom,qcs8300-smmu-500
+                - qcom,sa8775p-smmu-500
+                - qcom,sc7280-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+    then:
+      properties:
+        interconnects:
+          maxItems: 1
+    else:
+      properties:
+        interconnects: false
+
   - if:
       properties:
         compatible:

-- 
2.34.1

