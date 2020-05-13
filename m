Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015BBC2D0FC
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 14:07:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8234A204EF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 14:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="oQs+HaW0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JoHC7/tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8234A204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD6CC88211;
	Wed, 13 May 2020 14:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KfpxzeVCpSIa; Wed, 13 May 2020 14:07:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA72287858;
	Wed, 13 May 2020 14:07:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3EA5C0178;
	Wed, 13 May 2020 14:07:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8493C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C2282221B7
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qVjw0jDoclG0 for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 14:07:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by silver.osuosl.org (Postfix) with ESMTPS id 048F6221B1
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:07:28 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 354205C01A4;
 Wed, 13 May 2020 10:07:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 13 May 2020 10:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=lKdeG/SS5K17qzibBRTuO63YA/
 4VCH6EVTjUZm7Nekk=; b=oQs+HaW0z7SPEUSTpSgGWKSx49idmw59YLaFuTT2Uq
 876Wox/otMTgoBMIUjfDxbSWEHtp8IAVhp2XZBnJSugDsWXM4V57b63xbxRhkfPD
 j90/QZKBJWQ3uub0n7tnmQ2Xn0bll59FnbwLVkXsPrpHKLCr4ZU/Q6FGm8ctajZc
 NbKeaKj1HNgrhFG2uveEtD++WJNEMiRRzJlQNZFtOIp6KFSQ076qhXkvfpRKd76k
 3GNcx9TzCYtwU0qV01ijTzfzXWqLwawsta9RoF3w7LrU9rKRhxmbQcdIYCMhaVkd
 qm5W0VAs7yN4c9VYjBmjyAKsdjD2ZsB9DRW14UcaXGdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lKdeG/SS5K17qzibB
 RTuO63YA/4VCH6EVTjUZm7Nekk=; b=JoHC7/tmMCJpkMUFyme90FikR6GScx/v2
 BtZACc47bi3oS+lp8b9e9UFpDlfK3o1l9uaf0QqVR8yX7BOed65Qdkb6WIL59CBM
 8LOCN5WFJ6ssYiqfgA2vx9IePdfEUvoM4jD04byqpcqKs6L3bRhg77JvKChNQKXI
 F2T14ot9jzxCkUFGMU12SKtvacAwmu5nK/aBxlJba20gbY131dXF1VHH9Oc0QxqN
 OWJTcd5lJQeq1HYQEm24RR2qvFKXkwZVymykOP94jT2m0GlQZWP2l2oCybxwhgQO
 FLy+4fzW8KfaBd4Jn2O5t6Ohgq7bv3b6O5LvpPfZxu1PfotPdocYw==
X-ME-Sender: <xms:H_-7XqgUcAvKaT0Q8C2fawAX_l80x6X8r8X_LmFnuwtr_39RSZo6oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdejvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucft
 ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
 hnpeejffehuddvvddvlefhgeelleffgfeijedvhefgieejtdeiueetjeetfeeukeejgeen
 ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:H_-7XrDXHZSboH3oszh-T19XWEjPYwYMHUuTs7jcPczYqwlnfWonXA>
 <xmx:H_-7XiFOHU7LhGZZWuxdh1W1QFv8-uPmDyxtRe62YGJ5Bb_hMYS3fA>
 <xmx:H_-7XjRW-3__U6yI1vJ-4pyF0vJXDacXO5GwRIc5N38DddK3gf8x3g>
 <xmx:IP-7XunzK8-NcvXjT1qiwP1OsIYUdfKWMJSpg9e58Yp05IHy-lsWrg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id B2FA83280059;
 Wed, 13 May 2020 10:07:26 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v4 0/5] iommu: Add Allwinner H6 IOMMU driver
Date: Wed, 13 May 2020 16:07:19 +0200
Message-Id: <cover.b27dedd61e008ffcf55a028ccddda3bb4d21dfc8.1589378833.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 Maxime Ripard <maxime@cerno.tech>, linux-arm-kernel@lists.infradead.org
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

Hi,

Here's a series adding support for the IOMMU introduced in the Allwinner
H6. The driver from Allwinner hints at more SoCs using it in the future
(with more masters), so we can bet on that IOMMU becoming pretty much
standard in new SoCs from Allwinner.

One thing I wasn't really sure about was how to expose the statistics
reported by the IOMMU PMU (TLB hit rates, latencies, and so on). The
Allwinner driver exposes them through custom sysfs files, while they would
be best represented through perf I guess? Anyway, I'm planning to support
them later on.

Patches 1 and 3 should go through the IOMMU tree, 2 and 5 through drm-misc
and 4 through arm-soc.

Let me know what you think,
Maxime

Changes from v3:
  - Rebased on next
  - Removed PTW flush on map / unmap
  - Added Rob's reviewed-by

Changes from v2:
  - Rebased on 5.7
  - Add dt bindings patch
  - Allow the identity domain to be allocated
  - Add an unlikely to the check on whether a PTE already exists in map
  - Remove locking and adjust the PT installation to use an atomic
    operation instead
  - Switch to iotlb_sync / flush_iotlb_all callback instead of flushing by
    ourselves.

Changes from v1:
  - Add a patch to configure the IOMMU on the virtual DRM device
  - Rework the domain allocation / freeing
  - Remove the runtime_pm handling to power up the device and rely on
    refcounting
  - use map gfp argument for kmem cache allocation
  - Removed unused macros
  - Switched from BIT(0) to 1 for the page table entry valid flag to make
    it more obvious that it's over multiple bits.
  - Switch to module_initcall
  - Make accesses to the fwspec more consistant
  - Removed dev_info logs
  - Reworked invalidation / flushing
  - Allow for compilation with COMPILE_TEST

Maxime Ripard (5):
  dt-bindings: iommu: Add Allwinner H6 IOMMU bindings
  dt-bindings: display: sun8i-mixer: Allow for an iommu property
  iommu: Add Allwinner H6 IOMMU driver
  arm64: dts: allwinner: h6: Add IOMMU
  drm/sun4i: mixer: Call of_dma_configure if there's an IOMMU

 Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml |    3 +-
 Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml        |   61 ++++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                                  |   10 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                                           |   13 +-
 drivers/iommu/Kconfig                                                         |    9 +-
 drivers/iommu/Makefile                                                        |    1 +-
 drivers/iommu/sun50i-iommu.c                                                  | 1027 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 1124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
 create mode 100644 drivers/iommu/sun50i-iommu.c

base-commit: e098d7762d602be640c53565ceca342f81e55ad2
-- 
git-series 0.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
