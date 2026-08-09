Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831413AA4E9
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306551; cv=none; b=WychKwKIgraBV6cr7Dqc7LMfi+kvBhAo2W0hSw//DfORc46BQFlK5jscnTST7y++V/t5epvVXWGBoni9m4VauZQH/8dAWcakNKfzFe5q6KSwrScyQcjugluJTd3QVf/yGRiqYaCbRZpMM+206T5Wfp3GwKkY40zUa8rLvVhebfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306551; c=relaxed/simple;
	bh=JQ9sc9byZNSc9Sh4d39mWgKgoacapHogPOICv0zdO3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYI/pIQGZo2c7dMEs0QBsado2cEGQJxrZ762z5cLEUjEca1tQkUcn858VO0LGG6N8f//KaBCLvmBaAW80izzFtmcy3ekXLxOidchkabS5Qq1FJmuavspixplcnM+2hhYNSu0amCUVKTkG7/hIEkX5VUMuAUiLPj5l7qHUlZOYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b05br5eE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=az981Gg3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b05br5eE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="az981Gg3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679IAElr3748975
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W1pPMazMPEW6NPGoSQF0dXImkD3ATvdg63Q5ta3NC/0=; b=b05br5eEyxbjo2lB
	vkwKNNQkYLVBwgrvVl8DGcoNTzahrx4zULZnY4FieVVcnL7OBUkV0slm0WZDM9WU
	xfzg+n1NXrINvKMoEQa04DvH4SXANr2GxZqXQql8CYsSlly0lCN0NsbClVvFwlab
	9NtT61qkz7bgzvpALvJ+ouhZrND4iopLsqSbegoa0RpaWz7mufThhKUePLhWKJ/y
	kGIEfLWgqzvHPKFKT4bA4nQCdLIUKFv134hGSLH8AvO2uXXRGexUHBVDb/c3wqos
	U18odKwagBOInGCnvJoqMapVjY6z7QfzYJV0xDk02zle6E4kNxNJxtgecxaRZBsW
	K8saGw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7bjee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:15:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90284139cceso30825146d6.0
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306548; x=1786911348; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1pPMazMPEW6NPGoSQF0dXImkD3ATvdg63Q5ta3NC/0=;
        b=az981Gg3HDHZjiEEpgxh17cPrlF55A3WfFF8HCotR65d7MdGuYw2ls/lwnImxabqmI
         293wd/kT5UtQuVlRcDrPQCZmdRoKwarWUuPHSU0ucXsWr5Ak9mSkmpOVQHY7HuIvip2x
         PjrHiuUSB3bT8ZCesmjVG3fihpyvaFSJas5UEU88kCQ3hwUQDAh/e1ux19j9J1T45LnR
         07tZzi46R8liTq0kNsDFFoPG6cPAkDxCc331PA22OOpY1DXuLKxQ9EUAfaJe7dz/Bc0F
         j45dhvoWoXtZZ7hJg75e/lnzmi8MlcqwA8SGxoZRlflI8Ms3nWU0XtxGL8hJ9rBec94x
         oOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306548; x=1786911348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1pPMazMPEW6NPGoSQF0dXImkD3ATvdg63Q5ta3NC/0=;
        b=i2mGyvAxf3PexTr7AIYyCrV8oeB6iGv4nUIseWuZHlKxwX3Ko5crvxLNq1ODHcA/od
         /ARLC9HJNuRcYXVkM/AHVhGC8+dUaPdphA8iZTS6sGtdwobBQkx+yMwNwHoDMVq/DKiZ
         mnxyqkUkxbYCUgbBG3xpI1TL2MNXrtu/BqY22NXr9MTr8PRIfMyEX9lDeUOjbVfu6z4m
         SdKXveHI2WBRZa30ZDayEyJQW37O61TJ1y7iT1pNopt88z5HKHxXAX+m2+wUyw8rLAbu
         cXZ2f04eMrHOOnH0AggB1FUxQDfyoeBJh0448YBgvjtb9ZmsIUo+d1zfHCRCfEjFjT5Y
         yb5A==
X-Forwarded-Encrypted: i=1; AHgh+RpdNlT36xb+JwJ/QoroyIVvdMAj80vdPugAetnjwxQAelho5QzFnGctxxxj3bXMa/9WMDdvVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk2NP7l/fuSpmak4G2vwMZOna5xrrMLT87v5N81ZmVhyToOmPU
	eFKsDewFE/AlQrFc/vW3GO/TiIk+RjA1LSHDYDC3yPrJJ7LS3pV1mY035A6FCqJlAaAGU68wejw
	uULWI+JQlOYPUUya3Ix53vJxGrno6O/YulYe3Pbf+XJTRWxeGEwJQVzW6qQ==
X-Gm-Gg: AR+sD12sy81VGmTID9qVHNMYsH1V7+ltVIUy/xcvFAJeNPJ8q7GhsfG5kIcUi1L48Gg
	wkPgBEtbM8vaOzAu8pzoASRPkL/VK1dPRTct8aAaMu49vp0uDuNwR3eZMcEawQUnnEuucg772ux
	O7WrDP1PYQ31cV2oFYZnbkEe2q6sxgVIygBtZLI6uIl89W3GY6fIhXQm/BEIlX5+jXMgbmesUNn
	yHpBJLlT7aqjUipFC3MUhb8Vii78TZNqOfAHx8KEKRkQ9CPdvKMieXxLsgE/vvTs466QebAurMM
	0L+uo4sG6npjYUVYGvXeE473eJbS7S1mIoVJa7a+bPypm6Oyrghb5x8rnJWaPTsTDi4GcPuBlfB
	Xa+zvIWhzHyYTHwlS/WfgMClNOQnYozrlTGoGZtTxdffv1DnwYrFkBP079tRudkOzl4EbMzJSV4
	YFYehpdymbv5zXpA==
X-Received: by 2002:a05:6214:b6e:b0:908:598a:91d4 with SMTP id 6a1803df08f44-90a366e8fd0mr150744696d6.8.1786306547758;
        Sun, 09 Aug 2026 13:15:47 -0700 (PDT)
X-Received: by 2002:a05:6214:b6e:b0:908:598a:91d4 with SMTP id 6a1803df08f44-90a366e8fd0mr150744306d6.8.1786306547317;
        Sun, 09 Aug 2026 13:15:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:15:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:40 +0300
Subject: [PATCH 01/12] dt-bindings: iommu: qcom,iommu: document the MSM8974
 IOMMUs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-1-87f5cd492560@oss.qualcomm.com>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=JQ9sc9byZNSc9Sh4d39mWgKgoacapHogPOICv0zdO3o=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1bF/bef/f3CDXK/+5ouUjU9mzw7PWi3SuSf6gyzdXl5q
 a2RK5Z0MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAin5rY/xd9c1TWm8y0y7lO
 2eOo2Yu1y/yuHEoNX2Zto5nZ8KhuXsUJnmK5KQt6LqSy+bJzTg1Y7HQ9O869RKL2xrmJwiy1fse
 Nm7bIuKqlCnJ/EjpmEHb6ifOB4L937O/veJHS25J9v0PxzOWbp5d86FbQlNGQ2V7ZpimdxPAyLJ
 91jUjnAd5Ve1aVnV2orPNJ7tunRHGWZVV6X9P9ZsfGar3TyZp86li9jLtfIhPbJh8+475rBZcv/
 cp6+t+0YwrXNL83ZRJc/Pr6rK9mbs5gexIleGFJiKSIrrTjikspP38Z3M1/wNY3g2PmJveU/z+N
 Vz2fXNrusrfKJk1cUDnofnyAsNb0ryUW/lZet1v5P5cAAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX7PDVhy1B1p8m
 aTdelIpfh8G41r+Vf7dSyL44wQTYV1FmdvjtUeUkVsqwmM4t1dFghtLMV7Rooenf2Ne4ccTV0yk
 EyrKnmMvlZtvB8rT2hqIEqC/+Ik//O0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX5i5pMp7LCU9k
 kAeqXrjnY2Kgy64WyKULVqQ/9sZFmT9ayP02tx96bUabJyvQc6ed0mD+hqiz1PKPmR+hDQdZZVh
 K8zWlNPFN3+sSKtAYB6gpGghHXJptkx9DXH70Oxj8AMk1k1N7pe+waUOb0ngjs0nri43WNKQqhg
 mirVTbG5pOkDz1DTo8naL5l1YWq5B3EujDSsCLMand6+mzGzqVM8UrG+acKFhNKM+bySmpwL8Y1
 9uvCobKoDiHoBOdCMt9teoHivtZWCPQHhCEfTRtrdjutIpT/U/VH6urrnXMwFQNjlm9MTtd5gMh
 JLdSS94Vw5ost6za2qa0MNBLEJLTmNh/XafmmVNnal+f5MEN89bvlo7oGWGFY71fCYYYHM2DI1v
 tx6nHQZDDsuPSIJv35XHN+G6sT7Z28ZXjiZcad9mxMKY6zgd06OQpTkw7iD+CngvvgAayndjm0r
 DNkOWjUPOLZIqoOsYww==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a78dff4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=MlIQwWTDgEZjFnBirR0A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: Oq9IUTYkmRwi5WmwHUpj-X8wRj7ue5U-
X-Proofpoint-GUID: Oq9IUTYkmRwi5WmwHUpj-X8wRj7ue5U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

MSM8974 has several IOMMU instances, based on ARM SMMU v1 spec.
Nevertheless, the combination of implementation-specific registers and
the way TZ and hypervisor protect those instances make them not
compatible with the normal ARM SMMU programming sequences (nor with the
MSM8916 and later programming interfaces).

Add per-instance compatibles for the display, Venus and GPU MSM8974
IOMMU instances. The per-instance (rather than per-SoC) compatibles let
the driver carry the per-instance prefetch tuning tables and stream ID
maps, which are not derivable from the hardware. Document the extended
meaning of a missing qcom,iommu-secure-id and of reg on these instances.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index 93a489025317..43dffe41e3b8 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -30,6 +30,10 @@ properties:
               - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2
+      - enum:
+          - qcom,msm8974-gpu-iommu
+          - qcom,msm8974-mdp-iommu
+          - qcom,msm8974-venus-iommu
 
   clocks:
     minItems: 2
@@ -50,13 +54,23 @@ properties:
 
   reg:
     maxItems: 1
+    description:
+      For instances using the qcom,msm-iommu-v1/-v2 fallbacks, the
+      optional "SMMU local" register region used for interrupt routing
+      configuration. For instances with per-instance compatibles, the
+      SMMU global register space, used for stream mapping configuration
+      on non-secured instances and for the implementation-defined
+      prefetch registers on all instances.
 
   ranges: true
 
   qcom,iommu-secure-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      The SCM secure ID of the IOMMU instance.
+      The SCM secure ID of the IOMMU instance. When absent on instances
+      with per-instance compatibles, the instance is not managed by the
+      secure world and the OS programs the whole global register space
+      (stream mapping included) directly.
 
   '#address-cells':
     const: 1

-- 
2.47.3

