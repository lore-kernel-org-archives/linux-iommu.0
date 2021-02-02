Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C3C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 20:55:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4524964E4D
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 20:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4524964E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF5CE870B7;
	Tue,  2 Feb 2021 20:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tJgxsjYeQPPi; Tue,  2 Feb 2021 20:55:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC545870A1;
	Tue,  2 Feb 2021 20:55:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F241C0FA7;
	Tue,  2 Feb 2021 20:55:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05466C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E70D7868EB
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PalS1WvYQ+IK for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 20:55:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C13CF868E3
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:48 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id n42so21221200ota.12
 for <iommu@lists.linux-foundation.org>; Tue, 02 Feb 2021 12:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YcDLZh3Cqrzft9rIs/Kq27AfKEBZ9vkw9dbEJP0DrjM=;
 b=Se4fXcrtXrRbC2SHusA4H23NxgAYdWANd0Ib+v4yqeqmA0oICzvkGpC2K+tX8WOaKf
 q3+eM7pv4RuvdyZXYTCVzYzWaeGDI4yDiPPq5Iu6JNMmRQWFCleyXJhifGWoNCbP1A/M
 kbd3GIVoMoO3UVdujUvdkNOyxdeZ30VLnNpcd0/P5QlrXmnTExK/nizdID3pQmLuFiOu
 OTHjok3retqOck0bOn4/BrDXzemC0pbLADGZ7rQQNfEyjfXZ5Mh/22MdjnyBmBww09OD
 GIyEWYzIY4JeT9GQt5ZzUkMxLuBPxf++mxn6iDJTyezdGbnc+mKLnKSGiO94EGGkr+Ab
 CZYw==
X-Gm-Message-State: AOAM531C4xEe692cZ/DMRT5uYrPz9ZVvrdm8T47zr47o0Syg8zO+iMki
 zH9TP5aKTue1kOa5A4dGzQ==
X-Google-Smtp-Source: ABdhPJz+bxVqZHcA6WQ+rYUVLbRdjFrxDoLmtrg5Q88bRT0/dSLxHv+dlmm7nH5rNIdmYX/wLxVRrA==
X-Received: by 2002:a05:6830:1041:: with SMTP id
 b1mr16514781otp.335.1612299347994; 
 Tue, 02 Feb 2021 12:55:47 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k15sm4206otp.10.2021.02.02.12.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 12:55:46 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: Fix undocumented compatible strings in
 examples
Date: Tue,  2 Feb 2021 14:55:42 -0600
Message-Id: <20210202205544.24812-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: Tomer Maimon <tmaimon77@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 Tali Perry <tali.perry1@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 linux-i2c@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 linux-gpio@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, linux-kernel@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Running 'dt-validate -m' will flag any compatible strings missing a schema.
Fix all the errors found in DT binding examples. Most of these are just
typos.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Daniel Palmer <daniel@thingy.jp>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Vincent Cheng <vincent.cheng.xh@renesas.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml  | 4 ++--
 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml        | 2 +-
 Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml | 2 +-
 .../devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml          | 2 +-
 .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml         | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 2 +-
 Documentation/devicetree/bindings/ptp/ptp-idtcm.yaml          | 4 +---
 Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml    | 4 ++--
 11 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
index fa0ee03a527f..53cc6df0df96 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
@@ -18,7 +18,7 @@ properties:
     const: 1
 
   compatible:
-    const: allwinner,sun9i-a80-usb-clocks
+    const: allwinner,sun9i-a80-usb-clks
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml b/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
index eb241587efd1..118c5543e037 100644
--- a/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
+++ b/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
@@ -66,8 +66,8 @@ properties:
       - arm,syscon-icst525-integratorcp-cm-mem
       - arm,integrator-cm-auxosc
       - arm,versatile-cm-auxosc
-      - arm,impd-vco1
-      - arm,impd-vco2
+      - arm,impd1-vco1
+      - arm,impd1-vco2
 
   clocks:
     description: Parent clock for the ICST VCO
diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
index 1465c9ebaf93..1d48ac712b23 100644
--- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
+++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
@@ -66,7 +66,7 @@ examples:
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
     main_crypto: crypto@4e00000 {
-        compatible = "ti,j721-sa2ul";
+        compatible = "ti,j721e-sa2ul";
         reg = <0x4e00000 0x1200>;
         power-domains = <&k3_pds 264 TI_SCI_PD_EXCLUSIVE>;
         dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
diff --git a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
index 1f2ef408bb43..fe1e1c63ffe3 100644
--- a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
@@ -46,7 +46,7 @@ examples:
     #include <dt-bindings/gpio/msc313-gpio.h>
 
     gpio: gpio@207800 {
-      compatible = "mstar,msc313e-gpio";
+      compatible = "mstar,msc313-gpio";
       #gpio-cells = <2>;
       reg = <0x207800 0x200>;
       gpio-controller;
diff --git a/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml
index e3ef2d36f372..128444942aec 100644
--- a/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml
@@ -17,7 +17,7 @@ maintainers:
 
 properties:
   compatible:
-    const: nuvoton,npcm7xx-i2c
+    const: nuvoton,npcm750-i2c
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index cde1afa8dfd6..349633108bbd 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -93,7 +93,7 @@ examples:
     #include <dt-bindings/power/r8a7791-sysc.h>
 
     ipmmu_mx: iommu@fe951000 {
-        compatible = "renasas,ipmmu-r8a7791", "renasas,ipmmu-vmsa";
+        compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
         reg = <0xfe951000 0x1000>;
         interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index 54631dc1adb0..5dbb84049ff6 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -63,7 +63,7 @@ examples:
         reg = <0x1e6e2000 0x1a8>;
 
         pinctrl: pinctrl {
-            compatible = "aspeed,g4-pinctrl";
+            compatible = "aspeed,ast2400-pinctrl";
 
             pinctrl_i2c3_default: i2c3_default {
                 function = "I2C3";
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index a90c0fe0495f..ad1c33364b38 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -81,7 +81,7 @@ examples:
             reg = <0x1e6e2000 0x1a8>;
 
             pinctrl: pinctrl {
-                compatible = "aspeed,g5-pinctrl";
+                compatible = "aspeed,ast2500-pinctrl";
                 aspeed,external-nodes = <&gfx>, <&lhc>;
 
                 pinctrl_i2c3_default: i2c3_default {
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index c78ab7e2eee7..ad91c0bc54da 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -95,7 +95,7 @@ examples:
         reg = <0x1e6e2000 0xf6c>;
 
         pinctrl: pinctrl {
-            compatible = "aspeed,g6-pinctrl";
+            compatible = "aspeed,ast2600-pinctrl";
 
             pinctrl_pwm10g1_default: pwm10g1_default {
                 function = "PWM10";
diff --git a/Documentation/devicetree/bindings/ptp/ptp-idtcm.yaml b/Documentation/devicetree/bindings/ptp/ptp-idtcm.yaml
index 239b49fad805..658cec67743e 100644
--- a/Documentation/devicetree/bindings/ptp/ptp-idtcm.yaml
+++ b/Documentation/devicetree/bindings/ptp/ptp-idtcm.yaml
@@ -59,9 +59,7 @@ additionalProperties: false
 
 examples:
   - |
-    i2c@1 {
-        compatible = "abc,acme-1234";
-        reg = <0x01 0x400>;
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
         phc@5b {
diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
index c1348db59374..054584d7543a 100644
--- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
@@ -57,8 +57,8 @@ examples:
      */
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
-    watchdog0: rti@2200000 {
-        compatible = "ti,rti-wdt";
+    watchdog@2200000 {
+        compatible = "ti,j7-rti-wdt";
         reg = <0x2200000 0x100>;
         clocks = <&k3_clks 252 1>;
         power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
