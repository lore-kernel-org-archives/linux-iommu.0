Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD98C433C1
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 07:41:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385936196B
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 07:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385936196B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E216F83D0E;
	Sun, 28 Mar 2021 07:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w8szHZM_4RL4; Sun, 28 Mar 2021 07:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA41583B67;
	Sun, 28 Mar 2021 07:41:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7410BC0011;
	Sun, 28 Mar 2021 07:41:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA9BC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 556FA83D1D
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BmgsHoF7qLjT for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 07:41:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5769983D0E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:40:37 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id BBA45580830;
 Sun, 28 Mar 2021 03:40:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 28 Mar 2021 03:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=MI94jwmE2zLqhfN/R9l+Jdqfny
 JcLTSsv9uX8W7RVRE=; b=ssuZv+AFrzSuDD41TBt4dn2cF94qJZKbByHwNkWB8U
 0MDHj9gb+fzYfS7q0BEUsRFqeoLm910DZH0xfd7YADc3RhgZjDCG2v2raUxMU/fR
 j04JbluAfqKyQHB0S+PqshL+nZgbYZ6gF/JXAqN1iSKNFnx2pctngaUzizgCnWS/
 hZlNULm3Jsg2CZAfy/TGumBaUcUg+vnhZpnT7qkLjBsx8Q+l5P9jbqt8RuE0WLay
 CthyAiIa6be75L+rQDQqY33LQ2K1tFtc6ejsFNKtrZorU/HnyMaFTmZhAsKUa13K
 j29mv95y2Zs7gDzuqX1hHDAaGsnauNmRapc5fFrfl5Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MI94jwmE2zLqhfN/R
 9l+JdqfnyJcLTSsv9uX8W7RVRE=; b=ENkFBFRf0FHBKM5TXCf9p+OXBY87FTrZU
 IkEXDP7nbhhphIwE5P8tj/yEOldBFtrfx7DBm2Jwbh4XKfK2yGPL1tFR5hJQIiQc
 5m+UIvJr0Jd3cK73W4djH6NpsiMMBHZrvSRm57ZiZwetKJzm8LQGAorc1WVz2oHj
 BdMly1dGvQRSzjrCTtB9puhe80vcx2Qmbg0j/ZtqlId9idkp3OfDMALyQkODerUV
 VwzxOfbWP3hOosl9CgxILNbNPhIdkEMa46jAJ2Ib89yPHnxI4mIgYSp+a8A+FxEg
 wbkRQOycolY4yNOc7gtYqJgFxzmyTpNSP8euXrmJh6rCESLCIUtPQ==
X-ME-Sender: <xms:7zJgYBopPunbEkBwirC9xV2Bf2z3od4HasX21IdEu5yETq1t62RkIg>
 <xme:7zJgYDr4UuDabTsxXddDbYO7JC-19ub7H6rubBO4ieFb_9A2nrK6a_bD1QQpNJblg
 Z10PgtNIKwtywJw0lY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehhedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
 vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
 hnpeeiueeljedutdfgvdegleekjeetveehffdvudefteeklefhgffgkeeljeevheelhfen
 ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepud
 ejiedrudelledrvddutddrudehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:7zJgYOMkMCfK3IjSwdALAHcf6wJQEFX5dtodFra87xzHb4nOKtg2Ew>
 <xmx:7zJgYM4SyxDD5JPuUtAKUpw6E1YqphakgiGBf6DzCRkUKGx8tELcow>
 <xmx:7zJgYA7ah88jsotm5L6JlkoFr7P1WWuZCOliQYinfwx-HwFu5uw8Ug>
 <xmx:8TJgYAwwm-GvqXyk_59nDfwl9upKKhiC9ZsCR4x8Sxl9nM3J-CTK2S4y96M>
Received: from localhost.localdomain
 (ip-176-199-210-156.hsi06.unitymediagroup.de [176.199.210.156])
 by mail.messagingengine.com (Postfix) with ESMTPA id 41B0624005A;
 Sun, 28 Mar 2021 03:40:29 -0400 (EDT)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/3] Apple M1 DART IOMMU driver
Date: Sun, 28 Mar 2021 09:40:06 +0200
Message-Id: <20210328074009.95932-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sven Peter <sven@svenpeter.dev>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

Here's v2 of my Apple M1 DART IOMMU driver series as a follow up to the original
version [1].

Short summary: this series adds support for the iommu found in Apple's new M1
SoC which is required to use DMA on most peripherals. So far this code has been
tested with dwc3 in host and device mode on a M1 Mac Mini on top of the latest
version of Hector's bringup series [2,3] together with my m1n1 bootloader
branch to bring up USB [4]. It will also apply (but not be very useful) on
top of iommu/next and v5.12-rc3.

Thanks everyone for the suggestions and discussions so far. I believe they
have already significantly improved the state of this driver and our
understanding of the DART iommu!

The part I'm most unsure about is the way I keep track of the multiple
iommu nodes attached to a device. I would love to especially get some
feedback there.


Changes for v2:
 - fixed devicetree binding linting issues pointed out by Rob Herring and
   reworked that file.
 - made DART-specific code in io-pgtable.c unconditional and removed flag from
   Kconfig as proposed by Robin Murphy.
 - allowed multiple DART nodes in the "iommus" property as proposed by
   Rob Herring and Robin Murphy. this resulted in significant changes
   to apple-iommu-dart.c.
 - the domain aperture is now forced to 32bit if translation is enabled after
   the original suggestion to limit the aperture by Mark Kettenis and the
   follow-up discussion and investigation with Mark Kettenis, Arnd Bergmann,
   Robin Murphy and Rob Herring. This change also simplified the code
   in io-pgtable.c and made some of the improvements suggested during review
   not apply anymore.
 - added support for bypassed and isolated domain modes.
 - reject IOMMU_MMIO and IOMMU_NOEXEC since it's unknown how to set these up
   for now or if the hardware even supports these flags.
 - renamed some registers to be less confusing (mainly s/DOMAIN/STREAM/ to
   prevent confusion with linux's iommu domain concept).

I have also fixed my email provider so this time the series should actually
be a single thread and not contain any HTML by accident anymore...

Best,


Sven


[1] https://lore.kernel.org/linux-iommu/20210320151903.60759-1-sven@svenpeter.dev/
[2] https://lore.kernel.org/linux-arch/20210304213902.83903-1-marcan@marcan.st/
[3] https://github.com/AsahiLinux/linux/tree/upstream-bringup-v4
[4] https://github.com/svenpeter42/m1n1/tree/usb-dwc3-serial-wip

Sven Peter (3):
  iommu: io-pgtable: add DART pagetable format
  dt-bindings: iommu: add DART iommu bindings
  iommu: dart: Add DART iommu driver

 .../devicetree/bindings/iommu/apple,dart.yaml |  81 ++
 MAINTAINERS                                   |   7 +
 drivers/iommu/Kconfig                         |  14 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/apple-dart-iommu.c              | 858 ++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                |  59 ++
 drivers/iommu/io-pgtable.c                    |   1 +
 include/linux/io-pgtable.h                    |   6 +
 8 files changed, 1027 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml
 create mode 100644 drivers/iommu/apple-dart-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
