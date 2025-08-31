Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E41684B4
	for <iommu@lists.linux.dev>; Sun, 31 Aug 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643704; cv=none; b=BhNHv/cLKwVxbDedzYMA644bRoHcCPMLcgM7DYAHl1SClUHBd3405SR02mK4KIlfEjO4ri254MELzy256Ld2w2qkzlAicV7VtJnPRfN6uc0Y8eHR4A9Rn7EIsgbRKbMzOCtw06RfijJyE+ATCx3ComNsdFKrCnQOE/rezPAhUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643704; c=relaxed/simple;
	bh=MnWusNcFCa2Zg4e3EfsWg+xVTvEHMbXZjtCTnraquOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/N90lK96HAzTQRBN9seWgzmhAJED+GIFNJVlZeIi7GG7OiMs0mO4dlrCibv6/CuiEZAte1lfaA4wJGtKdlOSAt50ai/wyyXUzpZDXAIB5Pwg7r53D50/8akYiZGv3Umpd7XGeCu84pZEcrAef+ZkUL93pJPYRWA5CKrFP+SJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=osecxt/k; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=GFOJN8Hi; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="osecxt/k";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="GFOJN8Hi"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1756643381; bh=c4MGC8FIVSrF83JvXLuGkEw
	gC/SqBYt8eFhZPlAakzM=; b=osecxt/km5J3p+mWa8FlC2vlW7in+QLY1Jxm42ZOugGLnsKqCJ
	5HM1+criFcM8BRSPOHyLSANNQclUlWdX4gBBm0jaANzg2Sy2ZAhTI9dgitJwENr0u0rPvt6Rlid
	X0Hcbe3K7bYEtCjLz1FICsprDWr2DmnxUYXAJgpKIlqT0A5KB1+IHhXFlU5uc+Xnne3f0Heo/hv
	4dl+MWkIhJQD1nLSMsLFo85MHSqCf16fzXtIcAtERgBF4WAizMis4+bUlrqgjc0nY231B/GY+5B
	JBCc6oogn7vseTKyKptWA9BGYcg6UXgGmEO7uHb/eCHFJhSTBvOJT2VI4PyArfTEp1A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1756643381; bh=c4MGC8FIVSrF83JvXLuGkEw
	gC/SqBYt8eFhZPlAakzM=; b=GFOJN8Hi+piMWGmTQ8x2Pz7fBgryowwb03ccsFNAggtiPGj8gc
	fVheUiarg5lAOWE18R/Zb5sVDGJvdrWoF3Cg==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sun, 31 Aug 2025 14:29:29 +0200
Subject: [PATCH v8 6/7] dt-bindings: arm: qcom: Add Xiaomi Redmi 3S
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250831-msm8937-v8-6-b7dcd63caaac@mainlining.org>
References: <20250831-msm8937-v8-0-b7dcd63caaac@mainlining.org>
In-Reply-To: <20250831-msm8937-v8-0-b7dcd63caaac@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, iommu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756643366; l=1178;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=MnWusNcFCa2Zg4e3EfsWg+xVTvEHMbXZjtCTnraquOw=;
 b=2n9bEV/XzHN2fP17Tj7vi0Y9UDKVj7ZAsh4yEdSf9B9uHs9rTfQk0LtsLgcfoQzr6JSNlDetw
 qY/kwkFUlniDwbOnHVXDuLVTao4CyxuIXnLnkazCFspmdCKImjYHXyx
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document Xiaomi Redmi 3S (land).
Add qcom,msm8937 for msm-id, board-id allow-list.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 55e5eb75af8905c93e6604d54d516585f70a8e29..16e003ef0e1892cf8b1d2e5c581358e344b46349 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -191,6 +191,11 @@ properties:
               - xiaomi,riva
           - const: qcom,msm8917
 
+      - items:
+          - enum:
+              - xiaomi,land
+          - const: qcom,msm8937
+
       - items:
           - enum:
               - motorola,potter
@@ -1153,6 +1158,7 @@ allOf:
               - qcom,apq8094
               - qcom,apq8096
               - qcom,msm8917
+              - qcom,msm8937
               - qcom,msm8939
               - qcom,msm8953
               - qcom,msm8956

-- 
2.51.0

