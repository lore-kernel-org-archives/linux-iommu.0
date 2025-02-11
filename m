Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689526B95C
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313503; cv=none; b=afF+u3U99eWzsGdQl9aQHM4NKv/03Cp2JXWtDed/Jen8sF7PGoUBA0Cm7bjzczo/po7tPeol38sJsZaCQY58BOJUdwlC9YjNVyR5RVUnGcoscv8onV9hzEn+jB4hnaplg1A+p34EPsUQFECulrW8xjpojcZHM7Ry1WUzS4bs9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313503; c=relaxed/simple;
	bh=rk+vlmL/TIh8p46IODnNbOjorvhFl0jsmbqeymJZ4PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asozQVW3gaFv098+uJ/e7Zx0qyIlI5/Ypqg5Jjib63nSHlzO+eZmP2/tdpfoQmknUwy5fP3SU1C13fJ7huVNUDA+bwmBSoVJy3rXPOwuOnJcshBqcGIIQ6pvpgTnX8u8pBoali5hHo6sphKnBVBPpk9FtGfWpd7wi/AGgNfFx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RY2++CuJ; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RY2++CuJ"
Received: from [192.168.244.162] (254C21CD.nat.pool.telekom.hu [37.76.33.205])
	by mail.mainlining.org (Postfix) with ESMTPSA id 37AD7E45F7;
	Tue, 11 Feb 2025 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1739313500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBbPY593lVr8ZuiJAYMkcH3xaVApscOMmfMrR44/PbQ=;
	b=RY2++CuJied5SAbxQ3OSyaal+Qvg0SorYx5SGMqOd41O53j6Waz9ivx2efPAvB/WHArUdw
	myEsVOkyXRg9qzDIY4z4U8e4AARhZEA1yenS7ekQGnm7xJRibCyTFJHwfOpa8tsvWI6D0t
	G4z5szyDXHO3UfsmpZKojcSZd2wDSueRUXgl0RnXkWTI9OveEfdZjjuA4I5CWo9+7ftNYw
	ApHoIpWnAsli8/7l+FdnttR7uHLKk6VMWB5tS2E74UDfiYEVozZ7Hz8z4GVWHPELwTxNLY
	Nc20RW0xbjEG0/3PNHlRZuvUYOTcFWGtMcHodz0i7lVV2sNT4DZ6VTZfFP/w0A==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 11 Feb 2025 23:37:53 +0100
Subject: [PATCH 09/10] dt-bindings: arm: qcom: Add Xiaomi Redmi 3S
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250211-msm8937-v1-9-7d27ed67f708@mainlining.org>
References: <20250211-msm8937-v1-0-7d27ed67f708@mainlining.org>
In-Reply-To: <20250211-msm8937-v1-0-7d27ed67f708@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739313484; l=1275;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=rk+vlmL/TIh8p46IODnNbOjorvhFl0jsmbqeymJZ4PE=;
 b=dFuty6iDbabSopOqG699WuBxJTSq9az3tDQMCu7aR0Qfc8rLFnoKKduTS+AF0T5LWgKbNEGrH
 UkghifhzIAZCKFNAEjwf+g6aJ1oEWARzaucLcRSngPNJ6k0wgq+427x
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document Xiaomi Redmi 3S (land).
Add qcom,msm8937 for msm-id, board-id allow-list.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 618a87693ac1dc32b40a2201bc219a4f12e9f3e8..d082c1a2c8b3cdb36caf511840bf217f1175cde8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -38,6 +38,7 @@ description: |
         msm8660
         msm8916
         msm8917
+        msm8937
         msm8926
         msm8929
         msm8939
@@ -272,6 +273,11 @@ properties:
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
@@ -1222,6 +1228,7 @@ allOf:
               - qcom,apq8094
               - qcom,apq8096
               - qcom,msm8917
+              - qcom,msm8937
               - qcom,msm8939
               - qcom,msm8953
               - qcom,msm8956

-- 
2.48.1

