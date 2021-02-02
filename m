Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F5C433E6
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 20:55:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D389964F63
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 20:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D389964F63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 90F8B870BB;
	Tue,  2 Feb 2021 20:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sAnGGfyoMatl; Tue,  2 Feb 2021 20:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2DDB7870B6;
	Tue,  2 Feb 2021 20:55:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FAEBC0FA7;
	Tue,  2 Feb 2021 20:55:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CBD5C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 38F5385A78
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wnjYW47bnedU for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 20:55:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D0F57859BA
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:53 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id m13so24264268oig.8
 for <iommu@lists.linux-foundation.org>; Tue, 02 Feb 2021 12:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6WKE/3EQ/xJ6AJH5xmJE9YBaYDJN1xjVTBGt+kvQ65Y=;
 b=qwTRkwlG0L5mvU9X4QuXRjyuewDCsdChnK5kji8PqV3ZSDSyZ+boXYpb5xEINKxPMK
 b7dfrSwWap2i/ZHpUWPc/702xgTDlJLBT9jZQqkKoDWENJK6TAhl7nSS/33HD62KhFGH
 8iBVyh09WQbGqBo+Gx2/aGqab2vSBuCk+4CPhjbYOYZLoRxpgjhJozR9lHxNV9E4U1fu
 xemcufDPaiZIY1UFFE9/YYZrYe9RuH0gTwgyPR/UDjDPY55bEhCRLQR+qEW2RHPdhH/l
 e/xqzCPJ0qd8SiyXFpo9svukZyHMIbco4yxl2sm1Jrtl55tMCZ/5ozfkYznGfBBRkNaf
 lASg==
X-Gm-Message-State: AOAM5328oen31bb/QoFGVTNXI/vYLuBVwJ8UfQG5HwaZPSySts5nLtJN
 Y47y6p0IA+bFaSgMrug4Ig==
X-Google-Smtp-Source: ABdhPJypjDN+Ts39JWA5K5FwFDZxnlgjEBltLJwzpuZeV8Gkh6PNkOJl8PkeKNKnT1CjwRFOWOyTZg==
X-Received: by 2002:aca:dc07:: with SMTP id t7mr4037098oig.15.1612299353146;
 Tue, 02 Feb 2021 12:55:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k15sm4206otp.10.2021.02.02.12.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 12:55:52 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: Fix errors in 'if' schemas
Date: Tue,  2 Feb 2021 14:55:44 -0600
Message-Id: <20210202205544.24812-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202205544.24812-1-robh@kernel.org>
References: <20210202205544.24812-1-robh@kernel.org>
MIME-Version: 1.0
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomer Maimon <tmaimon77@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Jeffery <andrew@aj.id.au>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>, dri-devel@lists.freedesktop.org,
 Tali Perry <tali.perry1@gmail.com>, Eric Anholt <eric@anholt.net>,
 Daniel Palmer <daniel@thingy.jp>, linux-i2c@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Scott Branden <sbranden@broadcom.com>, Avi Fishman <avifishman70@gmail.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Properties in if/then schemas weren't getting checked by the meta-schemas.
Enabling meta-schema checks finds several errors.

The use of an 'items' schema (as opposed to the list form) is wrong in
some cases as it applies to all entries. 'contains' is the correct schema
to use in the case of multiple entries.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-crypto@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-leds@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/crypto/allwinner,sun8i-ce.yaml   | 3 +--
 .../devicetree/bindings/display/brcm,bcm2835-hvs.yaml    | 2 +-
 Documentation/devicetree/bindings/leds/ti,tca6507.yaml   | 1 +
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml  | 2 +-
 Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml | 3 +--
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml        | 5 ++---
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml         | 9 ++++-----
 .../bindings/timer/allwinner,sun5i-a13-hstimer.yaml      | 3 +--
 8 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
index 7a60d84289cc..6ab07eba7778 100644
--- a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
+++ b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
@@ -46,8 +46,7 @@ properties:
 if:
   properties:
     compatible:
-      items:
-        const: allwinner,sun50i-h6-crypto
+      const: allwinner,sun50i-h6-crypto
 then:
   properties:
     clocks:
diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
index e826ab0adb75..2e8566f47e63 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
@@ -36,7 +36,7 @@ if:
   properties:
     compatible:
       contains:
-        const: brcm,bcm2711-hvs"
+        const: brcm,bcm2711-hvs
 
 then:
   required:
diff --git a/Documentation/devicetree/bindings/leds/ti,tca6507.yaml b/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
index 94c307c98762..32c600387895 100644
--- a/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
+++ b/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
@@ -69,6 +69,7 @@ patternProperties:
 if:
   patternProperties:
     "^gpio@[0-6]$":
+      type: object
       properties:
         compatible:
           contains:
diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 6bbf29b5c239..6c13703b31db 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -123,7 +123,7 @@ required:
 if:
   properties:
     compatible:
-      items:
+      contains:
         enum:
           - renesas,sdhi-r7s72100
           - renesas,sdhi-r7s9210
diff --git a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
index 58c3ef8004ad..04edda504ab6 100644
--- a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
@@ -99,8 +99,7 @@ patternProperties:
 if:
   properties:
     compatible:
-      items:
-        const: brcm,iproc-ns2-sata-phy
+      const: brcm,iproc-ns2-sata-phy
 then:
   properties:
     reg:
diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index 829e8c7e467a..0f358d5b84ef 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -81,9 +81,8 @@ properties:
 if:
   properties:
     compatible:
-      items:
-        enum:
-          - renesas,usb2-phy-r7s9210
+      contains:
+        const: renesas,usb2-phy-r7s9210
 then:
   required:
     - clock-names
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
index 5b5b1b9d2ec7..5d3947902f2d 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
@@ -76,11 +76,10 @@ required:
 if:
   properties:
     compatible:
-      items:
-        enum:
-          - renesas,pfc-r8a73a4
-          - renesas,pfc-r8a7740
-          - renesas,pfc-sh73a0
+      enum:
+        - renesas,pfc-r8a73a4
+        - renesas,pfc-r8a7740
+        - renesas,pfc-sh73a0
 then:
   required:
     - interrupts-extended
diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml
index 40fc4bcb3145..b6a6d03a08b2 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml
@@ -46,8 +46,7 @@ required:
 if:
   properties:
     compatible:
-      items:
-        const: allwinner,sun5i-a13-hstimer
+      const: allwinner,sun5i-a13-hstimer
 
 then:
   properties:
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
