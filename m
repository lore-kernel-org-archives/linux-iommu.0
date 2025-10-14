Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181C314A8E
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450789; cv=none; b=b2Sk2FSKAa4ezLMN4dUVKwG3CImjkvFXdc9hHrDbZ6di+5SJdn2IUrolaBLQ9cSZk0B6lL+aqeNUCPtdgBwn0h2HWvXir+OuVfxNun9rLPYdD+rImokWaM5m1mtVGwFK0XSCKz9Zx3uB+f/w0qpfpHiR/1c2zdXK+5xwbVUgfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450789; c=relaxed/simple;
	bh=qXgvWo/arDfz4FQGxhmSd+d+QgpyevLvyROQW/TPwQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K01wFXfq1LMSDTx+NnxZ1C3bNdYDgpudmsqSOXsgaEhHI3ksFI8QXY+HoVWJYdweWhRf3bGKq4uw5+ENFqvEhTZPPAcgLAAorNGuz/7G6LzEsWybnSlhNtS9O8TzbvbxHZzt6RMuIyH3czXQYn0uy9NZCT19TD84ukQqo7BDajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=F01Y80gW; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=h30FJP+i; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="F01Y80gW";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="h30FJP+i"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1760450672; bh=bs3pDuZF7k0IowhT2GCL0eg
	O4YvxtwPIPG+lhIu5moA=; b=F01Y80gW6+ESDXKSws0j1x/dTV9RV/yDsnc98htnqdjfwOlmo8
	6K/ezvRS1+abziPdc22/0hGtGaGm3vNrTYnhNQWhVJD7UHdGrd6BlyLw7ep4+iRIGWw7YhosaR8
	YCGT8C3su6M2oW5tR1cdHdbMFR5afuv7c7THz1XKBwSVzJR4sk1wlNCUqTcUfT7Cm8rBdD4/Ixm
	z0xwSzyXWltiMHzlXAno/6tV4aW7dl78wRAFGSJlzUxBQtItVmR7V588WMds6tiizIOw0FhkI1V
	3sLvvSsIuzqn9ZyV8EHMWqAKaq2ZSJzG2q2WD5JMZPkwCV133XjbpPHkjFY5bhgWgiw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1760450672; bh=bs3pDuZF7k0IowhT2GCL0eg
	O4YvxtwPIPG+lhIu5moA=; b=h30FJP+ip4dEkH/Jff3KdHwdN+vJvU6dB+LfknzUOokJe8hZB8
	G2URqHWNdt9wBKC5Uz4/84ONbPnjigI9BEAg==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 14 Oct 2025 16:04:25 +0200
Subject: [PATCH v10 2/3] dt-bindings: arm: qcom: Add Xiaomi Redmi 3S
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-msm8937-v10-2-b3e8da82e968@mainlining.org>
References: <20251014-msm8937-v10-0-b3e8da82e968@mainlining.org>
In-Reply-To: <20251014-msm8937-v10-0-b3e8da82e968@mainlining.org>
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
 Robert Marko <robimarko@gmail.com>, 
 Adam Skladowski <a_skl39@protonmail.com>, 
 Sireesh Kodali <sireeshkodali@protonmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760450666; l=1121;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=qXgvWo/arDfz4FQGxhmSd+d+QgpyevLvyROQW/TPwQo=;
 b=KQDScanAjFKMO8WzDyf//3eLkzU7mYF2IuY0W2qnqGctb6YwYg75o445X1+D+2aljXYfz4S83
 uYr3TK7uTgkADB25RqKgSowWJXwMrczqGSJrs7t8TrBEk7+u1YKd9Gn
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
index 18b5ed044f9f..639a59d991de 100644
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
               - flipkart,rimob
@@ -1167,6 +1172,7 @@ allOf:
               - qcom,apq8094
               - qcom,apq8096
               - qcom,msm8917
+              - qcom,msm8937
               - qcom,msm8939
               - qcom,msm8953
               - qcom,msm8956

-- 
2.51.0

