Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F8C47097
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 08:50:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB51613F2
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 08:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB51613F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 711D540525;
	Thu,  3 Jun 2021 08:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Frc62JOIgEWK; Thu,  3 Jun 2021 08:50:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C48B40510;
	Thu,  3 Jun 2021 08:50:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 359CDC000D;
	Thu,  3 Jun 2021 08:50:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8D0BC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6EA760B33
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="mJIhPobR";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="JtyiJHH5"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QMeTl0Xxwkoh for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 08:50:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0A5D60B2E
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:50:28 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 7583E580F07;
 Thu,  3 Jun 2021 04:50:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Thu, 03 Jun 2021 04:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=SeU5hLmakRpJp0wYHm9YpfQgd+
 +fWAu9b5BVuriF3f4=; b=mJIhPobRGuJNTiSMlnBfbnv2uDMGCqnD7gmJHZQMNK
 7Z2AjI2AVt6uHOqCkE3j2XIC9i7qeUJiS3MjEnQfDygKdBRz5TPDccNA7GmnuFV/
 /HEqH8B8JAfFB7VYfqUflkIauwTmTJCKeJ/hNrgBTVWiNxi+SuzFgOQ4ppnKtMWR
 bQmVZpWS+pyw3m/PUddbEfEJ7loVibUL4Si5W5dNV2Wi8nTEbC5OedahkQWxQQ3B
 4KOdd+Nd+FnKosQ9UG3Edae6vTMn2A1hF4zBPemAsX8LXuzaLuH7aXL1Zt8CQXmj
 s/aZWqgPK6xEucyZeEGF9veFagkH49OTuD0ovhUKhjmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SeU5hLmakRpJp0wYH
 m9YpfQgd++fWAu9b5BVuriF3f4=; b=JtyiJHH5XvQhUlW67thTo5Q2G6H5TMbZ8
 O5xzZF9Y6BW5OW/h0CNR0akpLpzDG7WZZRkqHER812z9MXDGX/X38iTtJ5g4HcCf
 Hxrlq596I1EiTDVZUMkPjcGE8nNET4fYjvNQFkFEosuxlZGwLJvGrMTJBxpg/SIn
 4OS+LgGT9CmExRszynNz2ul/MrCIk9zCWdeMhWAYVaETafPw/9Pl2NN5SU+B4pNY
 k8zmc55XsJlAFMFzLZcdRX7F34ozb/qX87I0dyTTi5ItIZFqYw+dkCgsWhwJLVeY
 L2nVIiq9AzZEJ7xR6FNtAziKf+vccAAOrMzsWTWU9OMOGHfSArGvQ==
X-ME-Sender: <xms:0Ze4YJVn5WnUmLt7L0eK2iP4fKxQBSFpGHH7xqkVxu7gSB7MudGvkA>
 <xme:0Ze4YJkUDy2bU3lvMTyiELr-dZEF7VSWHZMsF0Krg4SQPhYrvBu6eIxYfbrdWyitf
 qjT5A8VgIanP3HdlM4>
X-ME-Received: <xmr:0Ze4YFaTWV6mPmidfwnt9X1UA0zgxwWbpSo_F8eBZqRSbdAFWpSRPFEGiHX7E65EFORX5K88H6uqnrMT4UnN6svbAJ0zKnIynIhUFLfIqV2QTduOxVCehK1naGd7QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelledgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
 thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
 epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
 ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:0pe4YMVrrlKzFcjpGFnwiK_eDkACWOyaBrMt7xBpT1wMrabLosSh2A>
 <xmx:0pe4YDml9lRR0EPI7nsGMBrjoILHriFn5ipRhfjZVyn1XXKEFsh5Ew>
 <xmx:0pe4YJcr6AS6ZnLQEMMLw8IPO1D0cx696rucurlLt0_sgUu7gsCeRA>
 <xmx:05e4YI_wzdlwUomPoNf52rdYFuTvRdfDtxaeZkNMOp4wlk4gcxTMtQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jun 2021 04:50:23 -0400 (EDT)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/3] Apple M1 DART IOMMU driver
Date: Thu,  3 Jun 2021 10:50:00 +0200
Message-Id: <20210603085003.50465-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alexander Graf <graf@amazon.com>,
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

This is v3 of my Apple M1 DART IOMMU driver series as a follow up to the original
two versions [1][2].

Short summary: this series adds support for the iommu found in Apple's new M1
SoC which is required to use DMA on most peripherals. So far this code has been
tested with dwc3 in host and device mode and PCIe on a M1 Mac Mini.

This IOMMU comes with a hard-wired pagesize of 16K. This makes booting a
kernel with 4K page challenging.

For dwc3 this is no issue: As long as the iommu is set to bypass mode
dwc3 works just fine. Translated mode isn't supported right now.

The most controversial part on which I'd like to get feedback are the
PCIe DARTs. These DARTs do not support hardware bypass mode and also limit
the iova space to 32 bit. To still allow booting on kernels with a 4K
pagesize I have introduced the following hack:

I program a static pagetable that maps the entire 32bit iova space to the
first 4GB of RAM starting at 0x8_0000_0000. Combined with an appropriate
dma-ranges property in the pcie node this allows to create a fake
bypass mode and successfully enables PCIe.
Right now the RAM offset is hardcoded in the DART driver and this will
likely have to change if this workaround is acceptable for now. I could
either introduce a separate property for the iommu node or try to grab
the offset from the dma-ranges once the first device is attached.


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


[1] v1: https://lore.kernel.org/linux-iommu/20210320151903.60759-1-sven@svenpeter.dev/
[2] v2: https://lore.kernel.org/linux-iommu/20210328074009.95932-1-sven@svenpeter.dev/

Sven Peter (3):
  iommu: io-pgtable: add DART pagetable format
  dt-bindings: iommu: add DART iommu bindings
  iommu: dart: Add DART iommu driver

 .../devicetree/bindings/iommu/apple,dart.yaml |  81 ++
 MAINTAINERS                                   |   7 +
 drivers/iommu/Kconfig                         |  15 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/apple-dart-iommu.c              | 966 ++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                |  62 ++
 drivers/iommu/io-pgtable.c                    |   1 +
 include/linux/io-pgtable.h                    |   7 +
 8 files changed, 1140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml
 create mode 100644 drivers/iommu/apple-dart-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
