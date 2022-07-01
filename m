Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B14CCA486
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 20:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2ED64056F;
	Fri,  1 Jul 2022 20:10:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2ED64056F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sholland.org header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=ewPaKoSk;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TBQ5zmWo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RpyhjddJjDR1; Fri,  1 Jul 2022 20:10:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C0C8403B7;
	Fri,  1 Jul 2022 20:10:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C0C8403B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEA32C007B;
	Fri,  1 Jul 2022 20:10:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 780BEC0035
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CE70403AA
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CE70403AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dT939ev1_Dcb for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 20:10:49 +0000 (UTC)
X-Greylist: delayed 00:09:36 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99BE540134
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99BE540134
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:48 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 4055A5802F0;
 Fri,  1 Jul 2022 16:01:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 01 Jul 2022 16:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1656705696; x=1656712896; bh=D0
 9F9v2OsTHtUMBckCisA3fh+Z9dxIk2ZgixoBozn6s=; b=ewPaKoSkHX2BJXiLrX
 5+oSIjybcWAklW5wxV0V+2224R1S5aSbhX/ZumtO+pevNUEajJ4W+xkdb1xobtmO
 5XYTY4EQgS3vI31X9KpJqpcSStss2CBfMnsdLsoEi24/QiILGCKcwtKmT3IHTl3M
 Mv1Py5jjNaGrcKT545FKqrpJreT45hH04ngq4b9+jLCXhOz/SJLgVou/odMMcxHf
 jE7L5Oa7EAAx5jIAr6O1i4neJfVW0AS/PUT6wWsmA07a/DS+FN2RC5D0zeLTTFHO
 gxpbBrSPW1wLPGNr1k53E8cUdIxhDr0COGRwcsfZT5hqn7efH9ktohj1e3H0gw2y
 IDKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1656705696; x=1656712896; bh=D09F9v2OsTHtU
 MBckCisA3fh+Z9dxIk2ZgixoBozn6s=; b=TBQ5zmWoRj8elXqnGUzA7FTSfUjgW
 8okx2QN7XCl3ky8WadN5LKY6hzwdOfA9BJ0eXRmer/tFEiAUvbmU6wyJhpcSQZgj
 Rmt76VA2NSnO3ovcCIK5WjyW5TFWl9HMcuavVAdkHsJTygI2nPusqodgPFJV4ZxT
 L/edAsj355kbI6l/RzXXpdx9yUIvX2RXPv6ueqmRU44epIbZ+yjNJpk1CA53x/K2
 6amlSq383hivdloACmsNrkmMJ+PWpdATylN2kVPVACnX4rT6i/tvFuKDeoqp86hr
 Enu7oREUdbzL42YZLwjDCYWMY8dHPJjpHxLTP4IgdrwaIjKWoEmRjseFA==
X-ME-Sender: <xms:nFK_YllnnRr_sciHqyPrgkD6BfM39zvsg08F5osTHcg_sR-Wy70VOw>
 <xme:nFK_Yg0T4Xs609Ou5ecwzclnL5FBE5F6rJ1z1kAvq9AADLi3didfXi2Wxyr8n3TpT
 mi7NakNtF0ybkEmZg>
X-ME-Received: <xmr:nFK_YroiT8Opzgg4mdQnQVspyugX-2Yp7TSWYjWSc_Gb3Z8jy7_oEVH24qDxlp30FU5OF6EH21X8QO2bXW2VYXXm05wIsfBRtq4vhrPsEdruTaavuMPiuUbOCX2QMSVYSGH3Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
 uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
 ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
 gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nFK_YllRQNY4ItnskcF3wZbSLRLA3CEAGpYupD7J2qW5peJo-ruNIQ>
 <xmx:nFK_Yj1dyGrStlLWi3Ibk1qa3a0DHtHuehPp5qlPfFiYZ8f76dMmZA>
 <xmx:nFK_YksdN9ZGevKx8SgkWwqLy8z5Ru1bwIDqa-wLH1UTAjSTVJD4JQ>
 <xmx:oFK_Ym2-Tx0kPJpXYNb6tkjCsCFHW9yYiblMWutR_FFjjXDpmGWUnQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:01:30 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 3/8] genirq: GENERIC_IRQ_EFFECTIVE_AFF_MASK depends on SMP
Date: Fri,  1 Jul 2022 15:00:51 -0500
Message-Id: <20220701200056.46555-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220701200056.46555-1-samuel@sholland.org>
References: <20220701200056.46555-1-samuel@sholland.org>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 linux-hyperv@vger.kernel.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jan Beulich <jbeulich@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Sven Schnelle <svens@stackframe.org>, Rob Herring <robh@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Samuel Holland <samuel@sholland.org>, Will Deacon <will@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, Russell King <linux@armlinux.org.uk>,
 Wei Xu <xuwei5@hisilicon.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-xtensa@linux-xtensa.org,
 Kees Cook <keescook@chromium.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Maximilian Heyne <mheyne@amazon.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Juergen Gross <jgross@suse.com>, Chris Zankel <chris@zankel.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Colin Ian King <colin.king@intel.com>,
 Helge Deller <deller@gmx.de>
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

An IRQ's effective affinity can only be different from its configured
affinity if there are multiple CPUs. Make it clear that this option is
only meaningful when SMP is enabled. Most of the relevant code in
irqdesc.c is already hidden behind CONFIG_SMP anyway.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 arch/arm/mach-hisi/Kconfig |  2 +-
 drivers/irqchip/Kconfig    | 14 +++++++-------
 kernel/irq/Kconfig         |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 75cccbd3f05f..7b3440687176 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -40,7 +40,7 @@ config ARCH_HIP04
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
 	select MCPM_QUAD_CLUSTER if SMP
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
 	  Support for Hisilicon HiP04 SoC family
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5dd98a81efc8..462adac905a6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,7 +8,7 @@ config IRQCHIP
 config ARM_GIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ARM_GIC_PM
 	bool
@@ -34,7 +34,7 @@ config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ARM_GIC_V3_ITS
 	bool
@@ -76,7 +76,7 @@ config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select PCI_MSI if PCI
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ALPINE_MSI
 	bool
@@ -112,7 +112,7 @@ config BCM6345_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config BCM7038_L1_IRQ
 	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
@@ -120,7 +120,7 @@ config BCM7038_L1_IRQ
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config BCM7120_L2_IRQ
 	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
@@ -179,7 +179,7 @@ config IRQ_MIPS_CPU
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_IPI if SMP && SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config CLPS711X_IRQCHIP
 	bool
@@ -294,7 +294,7 @@ config VERSATILE_FPGA_IRQ_NR
 config XTENSA_MX
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fc760d064a65..db3d174c53d4 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -24,6 +24,7 @@ config GENERIC_IRQ_SHOW_LEVEL
 
 # Supports effective affinity mask
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
+       depends on SMP
        bool
 
 # Support for delayed migration from interrupt context
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
