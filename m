Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA65396B68
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498791; cv=none; b=rtxTC3JYN/qyF6hNVwqFSUQN7Fjg1TKpkiCfbv3M+2t6QQPO8mqZVjk4n8ZKXeRvq2quHxEb4NIojfXH5Yp6dn/rCKXNKAIhmX+fgDEmd1/C1zZerqBr7UyOWnmtZZAAZYbKAdRsTRB+4OoWx5KHD15eRqVBh0y3h7fPK2M/Py4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498791; c=relaxed/simple;
	bh=MlVeOjyzwpym+szw56TwOtGwaPWWiF2YunpAZEWQfDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndvtfdTX300QKpdkCfLpYso8E/y1l87QrepVNqyNyk/rVK2hF7NKmjbRAKkZWjRXWQkidZu2cMcrGmUoO9HMc5TuTqsMRzNP4fm3HmjQTwfh69WhJtqXUHkWqrs6MWQBB6FUpozMpp75TBYcl4gRPTEg9EjDgeJE0EVKSSXNgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MpJfbVvM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bxlVkunV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpJfbVvM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bxlVkunV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6539vTPS2368080
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FCvEktdSiv4A6mtT0YE77fV8FNu/cYvcs0DIGD1tKXo=; b=MpJfbVvM755po/He
	XTPfzryXQ/64qNgjYaLJh72VMguEPzoGAErIPRLRKcpzjRywcQXw/8RNcL3rD/jc
	vNGtu7kok8OpwFvnqX/kJOUyRQNWQnrTjP54ejaTJ8IPtZD2tMZJgVlNkTmcf8mB
	WWZWU0WvHj4SnloocUhlLjwEbas13xbjvGi0TzsE48O+GwMzhdNTgwZaRSeEPlOQ
	ShgH6NFjD7xaTGoz83jwWxdZM13Wo88ObLFGEmbqB6scRCcwhyBH+AR+a38QJvC3
	1oTYWPA8RTBWpIfAqteBT60TWBeFvA20Q+S2oJw47qqY1PQx2W5gHUoLM3Vx7Ia1
	jF/yQQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj3gh6a2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:59:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84245e2bb00so3277213b3a.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780498787; x=1781103587; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCvEktdSiv4A6mtT0YE77fV8FNu/cYvcs0DIGD1tKXo=;
        b=bxlVkunVaccFWCrorm8bgaekuY/+JA31taGiZfSgP3z7hpNB7KqCwccYXvsY+RdYKS
         qvJyh+VTKqGl3X3HKgy5vK3UYixV9rVFrSSdxhx0Yq3pcv2zu7rrg9UWTX7aDc3Q40xm
         wz+Z3B1yJWPNTYKPVsmm8JgYLQBczmJMUnKJoNzIqacMNVckzEmtOhoDtaQdxbmELC7l
         EdOWhKJ7G44k1prAXXJFaW0oY3CsWt3sMbJdJ6pbbJf/bN7klOK5viFYsqkj/gU+pbXF
         5Eaj0sK26AwXAY5gqf2yasWqvKXxfp7OlbQvTwLOkml4oV3gOtTct51crm0dhh1ijgFp
         1s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498787; x=1781103587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FCvEktdSiv4A6mtT0YE77fV8FNu/cYvcs0DIGD1tKXo=;
        b=E7ee6DSMwX7QwOLFOVQp0EIsA+lB4rRw8OPGtfZexg+6sEEQN/RZCeBo21TCzQ6VJ2
         eGtTOEyUm78PeHQsxTSgC85mo3Ot2w0sg3NBd/S/luwa0F4z/HTMBzE+jO+QFNYWReBS
         m8FWcxGcZI5QmpWIE1ayAniLCIinpM0UAYchZS1aBv6Oe+LI8I8gq9NNMqdz2UCJeSEx
         ezrBTS3PIqNSa+fthcoJeUUybCcQzElQE5Walq/Wpbj2jy+jMDPY8fO6DMtP9LU6KdSY
         gYznIcTyZ71I/JN/5+exyKyf1PUdHf7zI+E9Y8IW4LCR4ajwBSDgXv6f/iAWz/TVXgzK
         /o9Q==
X-Forwarded-Encrypted: i=1; AFNElJ87GBE9aOqcqFdtIKEjnyzPqFLWyzRvgRMCWZQR+paPJgUDRzhyzGkpD0Bb6FbNhXDPm7wXRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxNwFYiPs6E2vuUmdMhUK6IkIEP2nQ4SEE9y9uPxaY1W+43cGp
	YHmtTtTQTK16oKS1o6dxTRxTwzjjh16f1OnqVqnJb70QzGfEDk052h4EM+vlRQhEkpsmFlGOauk
	m0znon1vAT4Rzvg51m/etH973Opq8DYVR1kbzAkSnWclQrUgIYWtnih/c5w==
X-Gm-Gg: Acq92OHCzLtmUh1lLmv7+p/LzMcbUYA/FOjeRa6PxZVXpypLMEkf7RarLP68pOR2Djn
	HXCSaQTyb1GSVj2vs16zAsxz791gesutZoFSczuJ7IaY+yczPwy6MbZ987TyqwwnlO6DA+hoUJ3
	uryf4TUOlvBMMSseME2Lh7fwhUdI82yQYpPS9+PZjSspmZruNkhxq4zUdcJDaouj69cGaojagC6
	qIIwVL/vw4fUwqc7pRBDbO560wYHLAwl0MDhmqc2sE6Xf2CQVGEMzoKqEvyZ2s7titU1e83EzUl
	qlVojgsIN8BUcciSWc8Nki5vcyCClkeP8/84Vph/2lYN9uA38LmFawRLhoJ6B+SB8j8RcQ7uIrZ
	zvu6w1wWl7S1VnyguGOMs26RI5guUse/mZyhvfcgG9TGUdv/IO3m/uwZ7oS0=
X-Received: by 2002:a05:6a00:181b:b0:82f:4cc9:1854 with SMTP id d2e1a72fcca58-84284f4eb8amr3945717b3a.49.1780498787363;
        Wed, 03 Jun 2026 07:59:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:181b:b0:82f:4cc9:1854 with SMTP id d2e1a72fcca58-84284f4eb8amr3945675b3a.49.1780498786882;
        Wed, 03 Jun 2026 07:59:46 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:59:46 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:26 +0530
Subject: [PATCH 1/5] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra-display-v1-1-aeac1b94faa7@oss.qualcomm.com>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
In-Reply-To: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=4175;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=MlVeOjyzwpym+szw56TwOtGwaPWWiF2YunpAZEWQfDo=;
 b=oxLSInKe2xaUTLeI9g3Z5OUf7JJRMtiRqN/OpXficZ7vBb/NRa3zVy3B7/ShmW5dyy21yM4/H
 tkNVDWGHZMUBTCpEPMfU6fGIUthwjbz1/Zk+f3hiIxAYjthF9wOuCYJ
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfXxMfjOLtS7mmH
 FIRXJ7HeH8XZ0/avojWb1tUmR600Uq9QZ2qR76EhNMDirzFMPAOxxjeVO9mAchgFKGbR2vVG2Cq
 VacynfZiZKxGG1BmkTtKGXfmEgqWIpg4Krclb1BMQ24dlfBIPx+p44aEEisiNoCsV7nUKaQt3eX
 mptTNgTpbJ364NWqa6bQTIEMGM5YIpKw1pGdqnU5PyM6tgLT/fkaTtT9t8yvmBjTt3rjPNi+3cr
 A1qCSad9r7HEquZVSTaAlviCr5NxH/FTzA33yNijv/sC4wAe1Ogz/a3X+h9opQyAyQqCbcNgW+W
 1kFsSuQJO+VO/g4TzLjBgqTMVd+qhbNkPDs6uTVkNvCBTLvh1GD2K58S4zoUo1NCdYhohHrm2UN
 cOtFlg0Dptr+QvmQWaFshM6GmbQhrENKyl7QyfnYmFyaDCZyPjRC1meO6jDnaDIvvX6in+5Rlog
 cTAh0pj3BPHiijoT+Yg==
X-Proofpoint-GUID: kjFHV3lS9ZVdG78T2JadWGN8XrLKv8v2
X-Proofpoint-ORIG-GUID: kjFHV3lS9ZVdG78T2JadWGN8XrLKv8v2
X-Authority-Analysis: v=2.4 cv=UvhT8ewB c=1 sm=1 tr=0 ts=6a204164 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_tpsKkHDXNPZovU35XoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030144

Shikra SoC uses the same MDSS/DPU/DSI hardware as QCM2290 (DPU 6.5),
sharing the same register layout, DSI controller and 14nm DSI PHY.
Add qcom,shikra-mdss to the qcm2290-mdss binding compatible enum
rather than introducing a separate binding file.

Register qcom,shikra-dsi-ctrl in dsi-controller-main.yaml alongside
qcom,qcm2290-dsi-ctrl, and update the qcm2290-mdss patternProperties
to accept both SoC-specific DPU and DSI controller compatibles.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  4 ++-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 34 +++++++++++++++++-----
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index dbc0613e427e..a2f3e91104af 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -33,6 +33,7 @@ properties:
               - qcom,sdm660-dsi-ctrl
               - qcom,sdm670-dsi-ctrl
               - qcom,sdm845-dsi-ctrl
+              - qcom,shikra-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
               - qcom,sm6125-dsi-ctrl
               - qcom,sm6150-dsi-ctrl
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index be6cd8adb3b6..cc1f227ade2d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -13,7 +13,9 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-dpu
+    enum:
+      - qcom,qcm2290-dpu
+      - qcom,shikra-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index bb09ecd1a5b4..d2609c24e305 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -4,21 +4,35 @@
 $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QCM220 Display MDSS
+title: Qualcomm QCM2290 and Shikra Display MDSS
 
 maintainers:
   - Loic Poulain <loic.poulain@linaro.org>
+  - Nabige Aala <nabige.aala@oss.qualcomm.com>
 
 description:
   Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
   sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
-  are mentioned for QCM2290 target.
+  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
+  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
 
 $ref: /schemas/display/msm/mdss-common.yaml#
 
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,qcm2290-mdss
+          - qcom,shikra-mdss
+  required:
+    - compatible
+
 properties:
   compatible:
-    const: qcom,qcm2290-mdss
+    enum:
+      - qcom,qcm2290-mdss
+      - qcom,shikra-mdss
 
   clocks:
     items:
@@ -52,7 +66,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,qcm2290-dpu
+        enum:
+          - qcom,qcm2290-dpu
+          - qcom,shikra-dpu
 
   "^dsi@[0-9a-f]+$":
     type: object
@@ -60,9 +76,13 @@ patternProperties:
 
     properties:
       compatible:
-        items:
-          - const: qcom,qcm2290-dsi-ctrl
-          - const: qcom,mdss-dsi-ctrl
+        oneOf:
+          - items:
+              - const: qcom,qcm2290-dsi-ctrl
+              - const: qcom,mdss-dsi-ctrl
+          - items:
+              - const: qcom,shikra-dsi-ctrl
+              - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object

-- 
2.34.1

