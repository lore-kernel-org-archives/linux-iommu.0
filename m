Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21B3DA7CD
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275364; cv=none; b=uWCqGcYnyhmbaZZb16DOdA6doibXgekdw8cs2JGJm/svdDNVEnMtgkBxUI3zJNh/LrwOG20gj6CDbIX141G8DbSIC8Yt1lShv0+4rMHwlNsCAAw8Bj3L/V51PmB4l84R2nbOntjY9k5itPLK/c1TG8JqEMKlqWMu/55Y+y8Rihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275364; c=relaxed/simple;
	bh=oCPQi6pqJjnzYEElWY4uswSYuY/PgQ7qdRL8tbXVe18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkM/3yX/LLtR0FuVuzhYFRjhKi2wZS56ZnpAEjsSYv1w/HnxLf4j8DFSwftRgQ/cHJYNjQNOr4PrpunaeXvXruBQ7LRSvWXpEW5WGw38bBNN5teXlsl+iiTYtkcYxyr+wYy/rGDdadxW8VKMbph1m17lovoPQHXGJg2iqkG0a1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KXByLRgr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xesq9Igb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KXByLRgr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xesq9Igb"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7ITwP1954131
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 11:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LSzjyVjG6hrqp81++brPl8d5tvFxkXJ87i4
	EMFI/KTw=; b=KXByLRgrJbKjITkMQNEpX6/TeDLS30yoyDNjFwTM08fdhjJ3aQv
	oFwhGD5N9ogJP1TjxKmxHGIE488U+jjIA/LK4ntwuypi045iO2J62QFiKtnNePQS
	uZD7YbR3jhWG9PPy5zwsiNX70iDnT5oWXqDf5Fn83kGZ9+7+qFnayFW8hzQAPA9y
	DCy/dxLUoysibXScfjOIvjOSjkL+VZI3RfeEes4DIPcWyKmGJO74KEuxm+N16OU5
	uE0SdFPxCa+jBRACKLSeuCQFzxipW8fvZBoWqyLXlE9j5KvPx++BTV/bUuUXYudT
	mU+CbJ9AEwfFvOyu50VbsENpWFJxbaV6TKg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3xven6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 11:09:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fb6d713ddso40940761cf.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779275362; x=1779880162; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSzjyVjG6hrqp81++brPl8d5tvFxkXJ87i4EMFI/KTw=;
        b=Xesq9Igbq+KPTPPntn/pRC/p5gJVHTSCHWr5D9WvWXbaTHifq4G9ZeePQRL1jBsQOZ
         /yvoOl0kpgzNO0YMWFBQ6952i6vQQgGM1npPdRfnN7We5K90PW1CDLfx1bj7LenJuDKa
         O0XcUN+yHt3Oph7y8nQk8s6IrmkZGMd1AqzH/HllwOgF3G/1rRCo8yHPCq3LTHodNSXK
         oXPxRaUmgC3Gum4V13Lt0RArzWnecGu1/YZgnciKshy7MtmuracyPXNemioWOplRfTlt
         b/z1Lo0Ayg67uxZP7WYb9r4b4Q8E20mlkjQSAIXQwszQai6JKYNI75Y2mTlNcIc10Nvy
         eflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779275362; x=1779880162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSzjyVjG6hrqp81++brPl8d5tvFxkXJ87i4EMFI/KTw=;
        b=avqVSlMWhPfyQCLfIVhVBg3Xgh+6J3fn1j51vNx6M4xSElFA3JHtqCG0VZVoJaiOgv
         3A6qefp11+JnHWykQkgHDPKomJ1yv0Jsbj5c5II2g9StgRBUNju6Fijn8K1GwH9w41bJ
         ESj8F1ewExQO+M2G5Deyd2ntqpRmfmK07BCGjMZjtA+h9WFawZxhhxmkUcVFCOhOboH+
         h4JXNGHug8EaQZm5onTGZQWK6PTbAEm9hKzaW2Oy3K+1TAElpF6YWo4oKmY11gj/6wRY
         udu0kRhWkcZBtFXRGpXem7XLTUIxbTM3uvdukbCOZibSQrx2GyOWFkQY65D+Snen0UQQ
         8yhg==
X-Forwarded-Encrypted: i=1; AFNElJ90TCSt6vJXRKx3g/esKesjcNTAvF8ae1JDc2gCw8FxT0iwTpv1II9ybAO6sDIzlXe+hG5eNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyL8sZMX79UgZYZvJ8Qui8iovsXUQa/XI95BVGuGTwwWeIsKyl
	2YT6bemBYv1K2qsi7tds5neydx8SoXoSvJffjreXBIcRCyG/NDGmJa8wQLDKM6XErZurWVEhB6J
	cVfyVQhFXzpvg3AzzQG0WfxcKX1mV5gqON1MM0m7vfxqTUEg90CG20GjCsw==
X-Gm-Gg: Acq92OGyCpHYZr2FPSTXV3pSe2uqKRXUQ0g1vRFsjgfOYWn1Nd3y2t6m73Mi3gp6JiS
	wInuvXCtotzbzl4WdM740qAS2lf2lGeuGr6xmfuRa9uCTGugF57rZ7C/1YBt619coAfkKHyfnaQ
	Xckm3MxLDPALe2SPJlKw9taHq7TSHNGm7XCTV8w1nAGXJ9Qaq/LpCWgqhAq6yBamMLl10VBfpbq
	Sd1jPkQs31mrwfRMp5TXBnVT1+hfRaoDifZgzRbRMZyVOia43KrpzHSr5NyXrPckKwPTFm8SP4V
	AZ0VgXzHONlFN/jLVfvw2UXfEd3bAzYZag7fXjzmutkQK0w6OqkYwH8zmXt/SsVQs/4kb8HP0AI
	B6s7GaD6swcLQP/PvYjGnn2BLGxAv5VTquh2+
X-Received: by 2002:a05:622a:5e13:b0:50b:487c:f3d1 with SMTP id d75a77b69052e-5165a0703b6mr307282031cf.3.1779275361738;
        Wed, 20 May 2026 04:09:21 -0700 (PDT)
X-Received: by 2002:a05:622a:5e13:b0:50b:487c:f3d1 with SMTP id d75a77b69052e-5165a0703b6mr307281551cf.3.1779275361246;
        Wed, 20 May 2026 04:09:21 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm54498441f8f.34.2026.05.20.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:09:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: arm-smmu: Correct and add constraints for Hawi, Shikra and Kaanapali
Date: Wed, 20 May 2026 13:09:14 +0200
Message-ID: <20260520110913.87271-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=oCPQi6pqJjnzYEElWY4uswSYuY/PgQ7qdRL8tbXVe18=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqDZZZc95YF3PNkoJLMoM0Gi3JS/r6PIDFTl9wM
 0LSdyjF8TKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCag2WWQAKCRDBN2bmhouD
 1w9zD/4vDQx7945Ay/ee+ltZNNEk+Qjl5p1UxHJ73ISPPzBJpbg3RF5YGSvGQWk+/KS0nnjzpjf
 gMI4+iLQC3cKX9la2sc4drK2nSpIP4dWS7OiCvpDPWQ3jC5a8sqGp+VT7RMKCdtxs6nMS+HsOmL
 luZb1chLuYTSL0Y8FqN2QyVWUZQCe3ZZNPrZBmu6nsVqvjJGkFA1l/Mkj67Lw/xdegpccqf1uyW
 WF3DTR32yyZJLFmvWyAUHyLBtx50Wi5ENU1yoYV/A6blEXSka7exP/x5mbl+Zws15iqF1Iscn+d
 ClzSWn3pxbLrzqXB+YgoStjQee9kzzfsSF3dzZqcC6iiNSUpfLaP169WMBP47SQ32LKYF0zSGAT
 bDgdS/vYJUxxjS3LQQmTZfGdpVp28xvrobWG79m4dHCE1cQOPA6tm0gILdOLRUX6K6yaFadBaF/
 A1rdPq2CORYpNEgmUBrn6wavKN586NjTnO4CKQ/MKgo8j6tcL8IzV9DmWr5S4O71aqk/P5yQl7o
 EbllfOHpktQHIIpTwVqbcScHjeITL39hDJmoDoU0S3/RlMQxyQbMc8izYQNjt/9zV6UthUBbRQB
 S4eUJyB9DdX1PC81DkzcBFskv/i0zVmEnt4+KoIl4vR202EX//xwNto9LFUmE4u1+IqxXlDo7s7 pPbZCchxmqJzrlg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WaY8rUhX c=1 sm=1 tr=0 ts=6a0d9662 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=LWJPcmncUgEYCnjaLLAA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: PJEyE9PKxef_-fTTN_wm-sJFdS3QGntA
X-Proofpoint-ORIG-GUID: PJEyE9PKxef_-fTTN_wm-sJFdS3QGntA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNyBTYWx0ZWRfX3YRr4Sv35bpX
 9Sb0UPc7MSr4ZSR/qi/1Ka4Z335cnqvfou88kk8WDXXsYp6z1UrL4JLkE6a9XFN2Jwx73VYKp2g
 zz/Lij9Bceeu39nb3KJBYxX5dsbw5l6xp14H7Jq4KZ5O0etfFfr6SKRsG0bmLKcsQKHbgrIGFgh
 7c3e9Er+fpRfCxmmljbZ7mbcr+i7iIbMOoaLRL+CfFX/CH8icJ9LzzzVtsn+qBcbXfmNdJpPn6Y
 Al5fvmWW4eiiZH/LBMTBvFMPFD5s+49hW8idOxq8NDAa6BCD1pd3YOS6Yo/1KRUCneQ1dA9yAgF
 BTp9sWwzMl+xmpnOnurXIBX+PZrPqepZbSwCat6nk+ledcySTiyANy+aC2YCGtCQODRB1e+zBEK
 YY+rsiWwnZnDebPD+UnVwZhB9nsMD0VUq9ibP5UVbwOY6YLZnaNOVe1LjpafsOlTuJ3eHclJ2C7
 rgTl21vjO9ilPgNTKmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200107

Previous commit 75949eb02653 ("dt-bindings: arm-smmu: Constrain clocks
for newer Qualcomm variants") duplicated constraints for
qcom,sm6350-smmu-500 and qcom,sm6375-smmu-500 - these are already part
of previous "if:" block.

It also missed enforcing one clock for qcom,kaanapali-smmu-500 in GPU
case and missed simultaneously added Shikra and Hawi.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ed0d10157bd6..5103adeee6d4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -568,6 +568,8 @@ allOf:
           items:
             - enum:
                 - qcom,glymur-smmu-500
+                - qcom,hawi-smmu-500
+                - qcom,kaanapali-smmu-500
                 - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
@@ -614,15 +616,15 @@ allOf:
             - enum:
                 - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
+                - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500
                 - qcom,milos-smmu-500
                 - qcom,qcs615-smmu-500
                 - qcom,qcs8300-smmu-500
                 - qcom,sa8775p-smmu-500
+                - qcom,shikra-smmu-500
                 - qcom,sm6115-smmu-500
                 - qcom,sm6125-smmu-500
-                - qcom,sm6350-smmu-500
-                - qcom,sm6375-smmu-500
                 - qcom,sm8150-smmu-500
                 - qcom,sm8250-smmu-500
                 - qcom,sm8350-smmu-500
-- 
2.53.0

