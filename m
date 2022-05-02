Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A2C433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 13:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E354983216;
	Mon,  2 May 2022 13:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id axp2EKiu52Cs; Mon,  2 May 2022 13:40:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC144831F5;
	Mon,  2 May 2022 13:40:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E5D7C0080;
	Mon,  2 May 2022 13:40:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F38A7C0032
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8C4E414C1
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RSiXtZ-12-wT for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 13:40:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AE7040A05
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:40:21 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:194e:5782:c420:7f87])
 by albert.telenet-ops.be with bizsmtp
 id Rpb52700A28fWK506pb5V9; Mon, 02 May 2022 15:35:18 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1nlWCe-002mrd-PI; Mon, 02 May 2022 15:35:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1nlWCd-002vA0-Ss; Mon, 02 May 2022 15:35:03 +0200
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
Subject: [PATCH 0/7] dt-bindings: renesas: R-Car V3U is R-Car Gen4
Date: Mon,  2 May 2022 15:34:52 +0200
Message-Id: <cover.1651497024.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
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

	Hi all,

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family[1].

Hence this patch series updates various DT binding documents to move
compatible values for R-Car V3U devices to R-Car Gen4 sections, in
bindings where the latter already exist.  Other DT binding documents
will be updated progressively, after adding support for more SoCs in the
R-Car Gen4 family.

These patches are intended to be taken by DT or subsystem maintainers.
Separate patches to update the DTS file[2] and SoC identication code[3]
are in-flight.

Thanks for your comments!

[1] https://www.renesas.com/eu/en/products/automotive-products/automotive-system-chips-socs/r-car-v3u-best-class-r-car-v3u-asil-d-system-chip-automated-driving
[2] [PATCH] arm64: dts: renesas: r8a779a0: Update to R-Car Gen4 compatible values
    https://lore.kernel.org/73cea9d5e1a6639422c67e4df4285042e31c9fd5.1651497071.git.geert+renesas@glider.be
[3] [PATCH] soc: renesas: R-Car V3U is R-Car Gen4
    https://lore.kernel.org/2bbecad7b6c24c0d5c1797b3f7f0733d5ba33842.1651497066.git.geert+renesas@glider.be

Geert Uytterhoeven (7):
  dt-bindings: gpio: renesas,rcar-gpio: R-Car V3U is R-Car Gen4
  dt-bindings: i2c: renesas,rcar-i2c: R-Car V3U is R-Car Gen4
  dt-bindings: iommu: renesas,ipmmu-vmsa: R-Car V3U is R-Car Gen4
  dt-bindings: renesas,rcar-dmac: R-Car V3U is R-Car Gen4
  dt-bindings: serial: renesas,hscif: R-Car V3U is R-Car Gen4
  dt-bindings: serial: renesas,scif: R-Car V3U is R-Car Gen4
  dt-bindings: watchdog: renesas,wdt: R-Car V3U is R-Car Gen4

 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml     | 10 ++++------
 .../devicetree/bindings/gpio/renesas,rcar-gpio.yaml    |  4 +---
 .../devicetree/bindings/i2c/renesas,rcar-i2c.yaml      |  2 +-
 .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml  |  4 ++--
 .../devicetree/bindings/serial/renesas,hscif.yaml      |  2 +-
 .../devicetree/bindings/serial/renesas,scif.yaml       |  2 +-
 .../devicetree/bindings/watchdog/renesas,wdt.yaml      |  2 +-
 7 files changed, 11 insertions(+), 15 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
