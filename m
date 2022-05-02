Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C65C433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 13:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE6E283279;
	Mon,  2 May 2022 13:40:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4T3QDLJ07cc; Mon,  2 May 2022 13:40:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BF12583252;
	Mon,  2 May 2022 13:40:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54013C007F;
	Mon,  2 May 2022 13:40:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27168C0080
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E37FC824A4
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KbCxdcpAR_YV for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 13:40:22 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
Received: from michel.telenet-ops.be (michel.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A671782EE1
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:40:21 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:194e:5782:c420:7f87])
 by michel.telenet-ops.be with bizsmtp
 id Rpb52700J28fWK506pb5Ud; Mon, 02 May 2022 15:35:18 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1nlWCe-002mrk-Ls; Mon, 02 May 2022 15:35:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1nlWCe-002vAm-5C; Mon, 02 May 2022 15:35:04 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 7/7] dt-bindings: watchdog: renesas,
 wdt: R-Car V3U is R-Car Gen4
Date: Mon,  2 May 2022 15:34:59 +0200
Message-Id: <2882a6de3905a57ae62d91060d27521af43c4068.1651497024.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1651497024.git.geert+renesas@glider.be>
References: <cover.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, dmaengine@vger.kernel.org
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

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family.  Hence move its compatible value to the R-Car Gen4 section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 77ee7c4b8067f506..1fa243052327bffe 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -59,11 +59,11 @@ properties:
               - renesas,r8a77980-wdt     # R-Car V3H
               - renesas,r8a77990-wdt     # R-Car E3
               - renesas,r8a77995-wdt     # R-Car D3
-              - renesas,r8a779a0-wdt     # R-Car V3U
           - const: renesas,rcar-gen3-wdt # R-Car Gen3 and RZ/G2
 
       - items:
           - enum:
+              - renesas,r8a779a0-wdt     # R-Car V3U
               - renesas,r8a779f0-wdt     # R-Car S4-8
           - const: renesas,rcar-gen4-wdt # R-Car Gen4
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
