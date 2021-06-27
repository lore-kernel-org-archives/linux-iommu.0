Return-Path: <SRS0=6lYj=LV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D324C49EB7
	for <iommu@archiver.kernel.org>; Sun, 27 Jun 2021 14:37:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D0261C29
	for <iommu@archiver.kernel.org>; Sun, 27 Jun 2021 14:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D0261C29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A18684031E;
	Sun, 27 Jun 2021 14:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BgL6xo0Zvg9q; Sun, 27 Jun 2021 14:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B227140338;
	Sun, 27 Jun 2021 14:37:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26828C000E;
	Sun, 27 Jun 2021 14:37:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F866C0010
 for <iommu@lists.linux-foundation.org>; Sun, 27 Jun 2021 14:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79FDB60662
 for <iommu@lists.linux-foundation.org>; Sun, 27 Jun 2021 14:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="y6fT8Wg3";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="NDilULHx"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFPc2P3aeKg9 for <iommu@lists.linux-foundation.org>;
 Sun, 27 Jun 2021 14:37:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 652E0605FB
 for <iommu@lists.linux-foundation.org>; Sun, 27 Jun 2021 14:37:27 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 583E25806BC;
 Sun, 27 Jun 2021 10:37:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 27 Jun 2021 10:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=ucRXwWejv64MFzazAwEltyGum6
 z36bD1hippP3YWEjE=; b=y6fT8Wg3YQl154OoxC/i89oc0BfPzg4kSavNyvbJie
 5WoSv52BvjpEAsxmoSAMU3HudImrE/z4gAxJYlUXXBLcGRpM+DzMkQHQB6qRAwO/
 eJnLDTPdE3ClLkMXq+9cHKgML5+hR6lgDUWoL995nIGfV/PEAGMtIIPk2lg7iOLO
 At05o/RmZDH13FqfxLC22DLMSnfM6CQRPrOOvyvKH/zMoT9A10Wtu1YUNcZ9P1fF
 61yiSckJ1Kk429P3EQuQ1VeBgeMIGGHmZ7WMmcMRr0WNSCShxA2TAjiTLy4zpoBu
 eq1qvjn1hU4dfod1Ws4L+Qz+UjRanws7vnzmuZvgOY7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ucRXwWejv64MFzazA
 wEltyGum6z36bD1hippP3YWEjE=; b=NDilULHx486ywwTpyQ/u2gF53NLcUrjk9
 McaKDbpetGTdQZ4bNYJTK1J7hQZtTrzYGmOEN6xGG047hVXGySF+r7vco/MIz4vZ
 yaM++EqkzYeaGQS5nP1i5X7H8WJxu6F11dp9L4wRz3Iph2eBnjd9sNfneOxPxIk8
 JMZlSojnbj/klfi4oJpgTqs4R0YMZNXQcMsg3nVQRwB6XYgReV3jflw0RmPHkuoS
 q+ApqPobomS+Xws72YpXd0Wk63weKqBHURBBqfDJ1w+aZux8fH0YCBbyT4mfEt0f
 88MoK1BM1UncdzJtzj+WWawFW8bw/B63YOIYyFWoo8vghEsX6twIg==
X-ME-Sender: <xms:IY3YYE9uj2Sl9-c5XLH3U71O7b9DtK2IWER4LL1zIprlcNuR-IwXEw>
 <xme:IY3YYMsN9ygMAVRb6TS7d3-xHZBXJpIGyVe-p02MvfRDRZSLNJK0B937vJ0a3p0Wi
 M-L6MneQdZ27oPFHJg>
X-ME-Received: <xmr:IY3YYKCZGSBiCUou2-3WrrtIt51QyeE09JoEGL-Fb87SOTRTAhKHu0L_z7muegjoDPL3RDNhryt8TtekAlk90ZObxmplrRmXZniKPJN-5zCuGf0T8NJOr-coZ7SSyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehvddgjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
 thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
 epvdffieelfeekteeuvdejvdduteehfeeijeefkeevteehueegveeltdehkeffjeejnecu
 ffhomhgrihhnpegrshgrhhhilhhinhhugidrohhrghdpkhgvrhhnvghlrdhorhhgpdhgih
 hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:IY3YYEeVT08VJu4gdMbAwWlO1EM2oNkp3nrILbHYeXl480emxkUUsw>
 <xmx:IY3YYJMduLC9HrJKP7F9SPkMt0D_dVT0wUYE_7NA8sIzJC3OAd-qvg>
 <xmx:IY3YYOlFYef-sgKH3kUcHxn5VwwGiNnDuqMWkdxeNy5sXJbUlVPNEQ>
 <xmx:I43YYGexxLMifB7lhoiLz2EDB0HPMrTYTh8boHZrOJuGx9PXnVKhzA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jun 2021 10:37:18 -0400 (EDT)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 0/3] Apple M1 DART IOMMU driver
Date: Sun, 27 Jun 2021 16:34:02 +0200
Message-Id: <20210627143405.77298-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, r.czerwinski@pengutronix.de,
 devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
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

This is v4 of my Apple M1 DART IOMMU driver series as a follow up to the previous
versions [1][2][3].

Short summary: this series adds support for the iommu found in Apple's new M1
SoC which is required to use DMA on most peripherals like the display controller,
the USB ports or the internal PCIe bus (which is used for WiFi, Ethernet and
more USB ports).
So far this code has been tested by multiple people with dwc3 in host and
device mode (which both only require changes to the device tree after this
patchset) and PCIe (using a yet to be finalized patchset).


== Testing this patchset with the USB-C controller == 

The two USB-C ports on the M1 machines are exposed as two separate dwc3
controllers which are behind a DART. Now that my USB phy bringup code has been
merged into our bootloader m1n1 you can easily test this patchset yourself:

1) Follow the instructions at [4] to setup our bootloader m1n1 on your M1
   machine which will allow you to boot kernels using a normal USB cable.
   Note that you'll still need a special setup to expose the UART for very
   low-level debugging.

2) Either apply this patchset and add the DART and dwc3 nodes as done in [5]
   or alternatively just pull from [6] to get the tree that I've been using.
   (That tree contains two commits already in linux-next, this patchset and
    a final commit to add the dart+dwc3 nodes)

3) Boot the kernel through our bootloader m1n1. You'll need a version after
   commit [7] which enables the USB PHY and the USB PD chip.

Note that the dwc3 controller has a quirk where each root port can only be used
once right now. The most stable way to test is to already connected the USB
device(s) before booting the kernel.

It's also possible to test the PCIe bus but this requires a more complex setup
for now. I can write a quick howto if anyone is interested though.
(tl;dr: Mark Kettenis has a u-boot fork that includes PCIe bringup code and
Marc Zyngier has a WIP patchset to add a PCIe driver)


== Hardwired 16K IOMMU pagesize ==

This IOMMU comes with a hard-wired pagesize of 16K. This makes booting a
kernel with 4K page challenging. Right now it will hit a BUG_ON if a translated
domain is used.

For dwc3 this is no issue: As long as the iommu is set to bypass mode
dwc3 works just fine. Translated mode just isn't supported then.

The most controversial part on which I'd like to get feedback are the
PCIe DARTs. These DARTs do not support hardware bypass mode and also limit
the iova space to 32 bit. To still allow booting on kernels with a 4K
pagesize I manually program a software bypass mode. With a correctly configured
dma-ranges in the PCIe nodes this then also allows a 4K kernel to boot.

In the long term, I'd like to extend the dma-iommu framework itself to
support iommu pagesizes with a larger granule than the CPU pagesize if that is
something you agree with.
This would be important to later support the thunderbolt DARTs since I would be
very uncomfortable to have these running in (software or hardware) bypass mode.

== Project Blurb ==

Asahi Linux is an open community project dedicated to developing and
maintaining mainline support for Apple Silicon on Linux. Feel free to
drop by #asahi and #asahi-dev on OFTC to chat with us, or check
our website for more information on the project:

https://asahilinux.org/

== Changes ==

Changes for v4:
 - Addressed Rob Herring's remark about the incorrect phandles in the device
   tree binding example and added his reviewed-by tag
 - Take the software linear mapping range from the bus instead of hardcoding
   it in the driver
 - Use def_domain_type to force bypass mode if there's a pagesize mismatch
   between the DART (hardwired to 16KB) and the kernel (may use 4K)
 - Added lockdep_assert_held instead of comments as suggested by Rouven Czerwinski
 - rebased on 5.13-rc7

Changes for v3:
 - fixed name of the iommu node in the device tree binding example
   pointed out by Arnd Bergmann
 - remove hardware specific checks from io-pgtable.c  as pointed out by
   Will Deacon
 - introduced a fake bypass mode by programming static linear pagetables
   if the DART does not support regular bypass mode as proposed by Alex
   Graf
 - added checks to enforce bypass mode if there is a pagesize mismatch
   between the DART HW and the CPU.
 - fixed usage of GFP_KERNEL during a held spinlock found by Julia Lawall
 - rebased on v5.13-rc3

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


[1] https://lore.kernel.org/linux-iommu/20210320151903.60759-1-sven@svenpeter.dev/
[2] https://lore.kernel.org/linux-iommu/20210328074009.95932-1-sven@svenpeter.dev/
[3] https://lore.kernel.org/linux-iommu/20210603085003.50465-1-sven@svenpeter.dev/
[4] https://github.com/AsahiLinux/docs/wiki/Developer-Quickstart
[5] https://github.com/AsahiLinux/linux/commit/7d4ebb0b22e9bfec849e2af86ddeb46ec29d7feb
[6] https://github.com/AsahiLinux/linux/tree/dart/dev
[7] https://github.com/AsahiLinux/m1n1/commit/9529ec2b4fd6550f9cfd66d9f2448b90804699a1

Sven Peter (3):
  iommu: io-pgtable: add DART pagetable format
  dt-bindings: iommu: add DART iommu bindings
  iommu: dart: Add DART iommu driver

 .../devicetree/bindings/iommu/apple,dart.yaml |   81 ++
 MAINTAINERS                                   |    7 +
 drivers/iommu/Kconfig                         |   15 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/apple-dart-iommu.c              | 1058 +++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                |   62 +
 drivers/iommu/io-pgtable.c                    |    1 +
 include/linux/io-pgtable.h                    |    7 +
 8 files changed, 1232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml
 create mode 100644 drivers/iommu/apple-dart-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
