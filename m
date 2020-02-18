Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F25C34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E332464E
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E332464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 56D93870DF;
	Tue, 18 Feb 2020 17:13:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CmWAxP+4U-aM; Tue, 18 Feb 2020 17:13:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7120786727;
	Tue, 18 Feb 2020 17:13:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E708C08A0;
	Tue, 18 Feb 2020 17:13:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA875C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D9060204D0
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n+HIjXHEc3bz for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:13:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by silver.osuosl.org (Postfix) with ESMTPS id A640220489
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:42 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id i6so20247315otr.7
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9rvVQxjEcVSUPCQUA8Lpt3skYnAzdX5d/I/sFEuvNBI=;
 b=ZWC+WxY5tXF5DQRq4iVo9Ogfnc96YdFQBWmOUi7kB+BETqYLRznMRKOlPcVYfrx94R
 Its5iEmdVrbGJpexJLcRPcALVSXasXJ0UcV/Jh/EBtfU+5t36/sWZ/NmI+q5iGfCTAwC
 Z+FQLrYkmfR+rxqgybmfMimO1Z6VXO8OtDzETwQh1nUoBnusicpL8K2+PAW64mEIn9uf
 e5vihH9pid9aklUWCjopJOXBxUAGE+i7PA9fFosvbuZZooyAw3Ji/TIueiNYBGqwTZKz
 bQeYAym/I3lS6ApEykunCBKbgm0keM2xokUGpYiI6FQE2Wnz5rDzcuwXRPiWn9tA9AaX
 BVTQ==
X-Gm-Message-State: APjAAAUj7u0kPL2CVlLU63V1hWlFMb7SNImCSyvWtRDtGji5zAQ684L7
 0ec42UwL0BBINUZh6Jjbzw==
X-Google-Smtp-Source: APXvYqwA7mxMXzEdUlX4eeVusmEzMBWCscl1LrX6G+t9T9zWzSOg5CEef2pK0PwwCFSogRLqNYvU8w==
X-Received: by 2002:a05:6830:18c4:: with SMTP id
 v4mr15986958ote.265.1582046021808; 
 Tue, 18 Feb 2020 09:13:41 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:13:41 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
Subject: [RFC PATCH 11/11] dt-bindings: Remove Calxeda platforms bindings
Date: Tue, 18 Feb 2020 11:13:21 -0600
Message-Id: <20200218171321.30990-12-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218171321.30990-1-robh@kernel.org>
References: <20200218171321.30990-1-robh@kernel.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-ide@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>
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

Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/calxeda.yaml      | 22 ----------
 .../devicetree/bindings/arm/calxeda/l2ecc.txt | 15 -------
 .../devicetree/bindings/ata/sata_highbank.txt | 44 -------------------
 .../devicetree/bindings/clock/calxeda.txt     | 17 -------
 .../memory-controllers/calxeda-ddr-ctrlr.txt  | 16 -------
 .../devicetree/bindings/net/calxeda-xgmac.txt | 18 --------
 .../bindings/phy/calxeda-combophy.txt         | 17 -------
 7 files changed, 149 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
 delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
 delete mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.txt

diff --git a/Documentation/devicetree/bindings/arm/calxeda.yaml b/Documentation/devicetree/bindings/arm/calxeda.yaml
deleted file mode 100644
index aa5571d23c39..000000000000
--- a/Documentation/devicetree/bindings/arm/calxeda.yaml
+++ /dev/null
@@ -1,22 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/arm/calxeda.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Calxeda Platforms Device Tree Bindings
-
-maintainers:
-  - Rob Herring <robh@kernel.org>
-description: |+
-  Bindings for boards with Calxeda Cortex-A9 based ECX-1000 (Highbank) SOC
-  or Cortex-A15 based ECX-2000 SOCs
-
-properties:
-  $nodename:
-    const: '/'
-  compatible:
-    items:
-      - enum:
-          - calxeda,highbank
-          - calxeda,ecx-2000
diff --git a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
deleted file mode 100644
index 94e642a33db0..000000000000
--- a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Calxeda Highbank L2 cache ECC
-
-Properties:
-- compatible : Should be "calxeda,hb-sregs-l2-ecc"
-- reg : Address and size for ECC error interrupt clear registers.
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt.
-
-Example:
-
-	sregs@fff3c200 {
-		compatible = "calxeda,hb-sregs-l2-ecc";
-		reg = <0xfff3c200 0x100>;
-		interrupts = <0 71 4  0 72 4>;
-	};
diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.txt b/Documentation/devicetree/bindings/ata/sata_highbank.txt
deleted file mode 100644
index aa83407cb7a4..000000000000
--- a/Documentation/devicetree/bindings/ata/sata_highbank.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-* Calxeda AHCI SATA Controller
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-The Calxeda SATA controller mostly conforms to the AHCI interface
-with some special extensions to add functionality.
-Each SATA controller should have its own node.
-
-Required properties:
-- compatible        : compatible list, contains "calxeda,hb-ahci"
-- interrupts        : <interrupt mapping for SATA IRQ>
-- reg               : <registers mapping>
-
-Optional properties:
-- dma-coherent      : Present if dma operations are coherent
-- calxeda,port-phys : phandle-combophy and lane assignment, which maps each
-			SATA port to a combophy and a lane within that
-			combophy
-- calxeda,sgpio-gpio: phandle-gpio bank, bit offset, and default on or off,
-			which indicates that the driver supports SGPIO
-			indicator lights using the indicated GPIOs
-- calxeda,led-order : a u32 array that map port numbers to offsets within the
-			SGPIO bitstream.
-- calxeda,tx-atten  : a u32 array that contains TX attenuation override
-			codes, one per port. The upper 3 bytes are always
-			0 and thus ignored.
-- calxeda,pre-clocks : a u32 that indicates the number of additional clock
-			cycles to transmit before sending an SGPIO pattern
-- calxeda,post-clocks: a u32 that indicates the number of additional clock
-			cycles to transmit after sending an SGPIO pattern
-
-Example:
-        sata@ffe08000 {
-		compatible = "calxeda,hb-ahci";
-		reg = <0xffe08000 0x1000>;
-		interrupts = <115>;
-		dma-coherent;
-		calxeda,port-phys = <&combophy5 0 &combophy0 0 &combophy0 1
-					&combophy0 2 &combophy0 3>;
-		calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
-		calxeda,led-order = <4 0 1 2 3>;
-		calxeda,tx-atten = <0xff 22 0xff 0xff 23>;
-		calxeda,pre-clocks = <10>;
-		calxeda,post-clocks = <0>;
-        };
diff --git a/Documentation/devicetree/bindings/clock/calxeda.txt b/Documentation/devicetree/bindings/clock/calxeda.txt
deleted file mode 100644
index 0a6ac1bdcda1..000000000000
--- a/Documentation/devicetree/bindings/clock/calxeda.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Device Tree Clock bindings for Calxeda highbank platform
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be one of the following:
-	"calxeda,hb-pll-clock" - for a PLL clock
-	"calxeda,hb-a9periph-clock" - The A9 peripheral clock divided from the
-		A9 clock.
-	"calxeda,hb-a9bus-clock" - The A9 bus clock divided from the A9 clock.
-	"calxeda,hb-emmc-clock" - Divided clock for MMC/SD controller.
-- reg : shall be the control register offset from SYSREGs base for the clock.
-- clocks : shall be the input parent clock phandle for the clock. This is
-	either an oscillator or a pll output.
-- #clock-cells : from common clock binding; shall be set to 0.
diff --git a/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt b/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
deleted file mode 100644
index 049675944b78..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Calxeda DDR memory controller
-
-Properties:
-- compatible : Should be:
-  - "calxeda,hb-ddr-ctrl" for ECX-1000
-  - "calxeda,ecx-2000-ddr-ctrl" for ECX-2000
-- reg : Address and size for DDR controller registers.
-- interrupts : Interrupt for DDR controller.
-
-Example:
-
-	memory-controller@fff00000 {
-		compatible = "calxeda,hb-ddr-ctrl";
-		reg = <0xfff00000 0x1000>;
-		interrupts = <0 91 4>;
-	};
diff --git a/Documentation/devicetree/bindings/net/calxeda-xgmac.txt b/Documentation/devicetree/bindings/net/calxeda-xgmac.txt
deleted file mode 100644
index c8ae996bd8f2..000000000000
--- a/Documentation/devicetree/bindings/net/calxeda-xgmac.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Calxeda Highbank 10Gb XGMAC Ethernet
-
-Required properties:
-- compatible : Should be "calxeda,hb-xgmac"
-- reg : Address and length of the register set for the device
-- interrupts : Should contain 3 xgmac interrupts. The 1st is main interrupt.
-  The 2nd is pwr mgt interrupt. The 3rd is low power state interrupt.
-
-Optional properties:
-- dma-coherent      : Present if dma operations are coherent
-
-Example:
-
-ethernet@fff50000 {
-        compatible = "calxeda,hb-xgmac";
-        reg = <0xfff50000 0x1000>;
-        interrupts = <0 77 4  0 78 4  0 79 4>;
-};
diff --git a/Documentation/devicetree/bindings/phy/calxeda-combophy.txt b/Documentation/devicetree/bindings/phy/calxeda-combophy.txt
deleted file mode 100644
index 6622bdb2e8bc..000000000000
--- a/Documentation/devicetree/bindings/phy/calxeda-combophy.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Calxeda Highbank Combination Phys for SATA
-
-Properties:
-- compatible : Should be "calxeda,hb-combophy"
-- #phy-cells: Should be 1.
-- reg : Address and size for Combination Phy registers.
-- phydev: device ID for programming the combophy.
-
-Example:
-
-	combophy5: combo-phy@fff5d000 {
-		compatible = "calxeda,hb-combophy";
-		#phy-cells = <1>;
-		reg = <0xfff5d000 0x1000>;
-		phydev = <31>;
-	};
-
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
