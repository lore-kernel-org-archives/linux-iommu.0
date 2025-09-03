Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67A2EB853
	for <iommu@lists.linux.dev>; Wed,  3 Sep 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934874; cv=none; b=aGB5AeN0tyvi0v06PZaZ8g+kHtSRxxOsn7TuoOOiQEptbfT8kZ0JQRCEwyVEEslA+RI4SAroINkrWzidfx4JTzuiRQVeBb+M7Ubj8LyYDln7WwLxQ2MSvMpf29wSQefcDNvu1LrhJxqKPGYevxLta4erjQ+eryYkk3O9F4/eR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934874; c=relaxed/simple;
	bh=wtKe9H6U+LhS2f603AlELwNS+homIUhNUwT6Z3ZM8hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Px+gIxij6DuB+4XhS5GyUjIFg1a0FtAzu2QYy0sedMjQSYkqfCIizNzij8Ou8OBYDuXjeCEzqLnLdevpbA8EAy8VBL9YMd9Kim+A3YEQCvkoO/Op5c/lWUhCyvXprney0gOUD9p4e8fj6h6+WazlbZWQfBJnzJHqLVqbZNjVV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=aaYiTBxW; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ybHw/iBr; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="aaYiTBxW";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ybHw/iBr"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1756933743; bh=75jbWC6rzZi0qzMwWHXrcn6
	GuZQp+Mi+3zTPjxiaEug=; b=aaYiTBxWje+0vRlthR6Gat3DbfP0XRq7AudGJIdaQHk9+XHz0F
	2QvtXYMNZnrP0Buz4iFzoGGjNXY7B9DDvjtZuSR+PgH37qVREOGIZadKxkL7v2vqroeG0Ke2gAq
	if3zVNrAZmrwPAS3cEXaZ87G3WwqVMKflwspwz8ETYvuh4roR8yTzeXt9SDZiAYRfvjcYSWzonK
	XVvhjEd8Kld2hnBQGwUgD2wrQ76zgpLr2nr/O/jhFQk5TJF8fch6eIQTW1rYajKyCzIFmAs885g
	Rv+t33uuCEcgbRY3iyx7NULXi+0SAHaNUp/WAqAYLD0jnocrDE8APS3VGGEVHspwH/A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1756933743; bh=75jbWC6rzZi0qzMwWHXrcn6
	GuZQp+Mi+3zTPjxiaEug=; b=ybHw/iBrO1LP5DtUOVfyyKnZ9Yq2IZEfk5EnfxwlnifKVEiI5P
	cibIeBCzLT6yUCy4JW89xKvKED7dEIuYW1AA==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Wed, 03 Sep 2025 23:08:21 +0200
Subject: [PATCH v9 1/7] dt-bindings: clock: qcom: Add MSM8937 Global Clock
 Controller
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250903-msm8937-v9-1-a097c91c5801@mainlining.org>
References: <20250903-msm8937-v9-0-a097c91c5801@mainlining.org>
In-Reply-To: <20250903-msm8937-v9-0-a097c91c5801@mainlining.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756933738; l=3026;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=wtKe9H6U+LhS2f603AlELwNS+homIUhNUwT6Z3ZM8hU=;
 b=gJuwckff6DqKPQaxjBxTmQeyUD4X/b80EzktRF5RqPVO+0i+82ROMTtasIHI/+e+78ld9GN8V
 5vtIBEy0UdIAKnMH+fxZ4HLuCp/S6p9hkSOBmmmInqM1AmQWSEmIJlD
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add device tree bindings for the global clock controller on Qualcomm
MSM8937 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 .../devicetree/bindings/clock/qcom,gcc-msm8953.yaml   | 11 ++++++++---
 include/dt-bindings/clock/qcom,gcc-msm8917.h          | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
index fe1f5f3ed992453a347062a556b1ddb2a011db6f..f2e37f439d28b3ec066f407927955b3b82b5c10a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
@@ -9,16 +9,21 @@ title: Qualcomm Global Clock & Reset Controller on MSM8953
 maintainers:
   - Adam Skladowski <a_skl39@protonmail.com>
   - Sireesh Kodali <sireeshkodali@protonmail.com>
+  - Barnabas Czeman <barnabas.czeman@mainlining.org>
 
 description: |
   Qualcomm global clock control module provides the clocks, resets and power
-  domains on MSM8953.
+  domains on MSM8937 or MSM8953.
 
-  See also: include/dt-bindings/clock/qcom,gcc-msm8953.h
+  See also::
+    include/dt-bindings/clock/qcom,gcc-msm8917.h
+    include/dt-bindings/clock/qcom,gcc-msm8953.h
 
 properties:
   compatible:
-    const: qcom,gcc-msm8953
+    enum:
+      - qcom,gcc-msm8937
+      - qcom,gcc-msm8953
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8917.h b/include/dt-bindings/clock/qcom,gcc-msm8917.h
index 4b421e7414b50bef2e2400f868ae5b7212a427bb..4e3897b3669d9149b61a6feec31ca35e2058dcb9 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8917.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8917.h
@@ -170,6 +170,23 @@
 #define VFE1_CLK_SRC				163
 #define VSYNC_CLK_SRC				164
 #define GPLL0_SLEEP_CLK_SRC			165
+/* Addtional MSM8937-specific clocks */
+#define MSM8937_BLSP1_QUP1_I2C_APPS_CLK_SRC		166
+#define MSM8937_BLSP1_QUP1_SPI_APPS_CLK_SRC		167
+#define MSM8937_BLSP2_QUP4_I2C_APPS_CLK_SRC		168
+#define MSM8937_BLSP2_QUP4_SPI_APPS_CLK_SRC		169
+#define MSM8937_BYTE1_CLK_SRC				170
+#define MSM8937_ESC1_CLK_SRC				171
+#define MSM8937_PCLK1_CLK_SRC				172
+#define MSM8937_GCC_BLSP1_QUP1_I2C_APPS_CLK		173
+#define MSM8937_GCC_BLSP1_QUP1_SPI_APPS_CLK		174
+#define MSM8937_GCC_BLSP2_QUP4_I2C_APPS_CLK		175
+#define MSM8937_GCC_BLSP2_QUP4_SPI_APPS_CLK		176
+#define MSM8937_GCC_MDSS_BYTE1_CLK			177
+#define MSM8937_GCC_MDSS_ESC1_CLK			178
+#define MSM8937_GCC_MDSS_PCLK1_CLK			179
+#define MSM8937_GCC_OXILI_AON_CLK			180
+#define MSM8937_GCC_OXILI_TIMER_CLK			181
 
 /* GCC block resets */
 #define GCC_CAMSS_MICRO_BCR			0
@@ -187,5 +204,7 @@
 #define VENUS_GDSC				5
 #define VFE0_GDSC				6
 #define VFE1_GDSC				7
+/* Additional MSM8937-specific GDSCs */
+#define MSM8937_OXILI_CX_GDSC				8
 
 #endif

-- 
2.51.0

