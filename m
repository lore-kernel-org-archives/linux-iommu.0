Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DEEC47256
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 10:09:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFDC206E6
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 10:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ZZGh5MnH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pubwQPmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFDC206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8C25B877F2;
	Tue,  5 May 2020 10:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GnYQKDkEqxHL; Tue,  5 May 2020 10:09:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD9FE877CE;
	Tue,  5 May 2020 10:09:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0C21C088B;
	Tue,  5 May 2020 10:09:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60C9FC0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0F049204D7
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RT5eI4DMZ31x for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 10:09:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by silver.osuosl.org (Postfix) with ESMTPS id 61493204BC
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:09:42 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 403235C00F0;
 Tue,  5 May 2020 06:09:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 05 May 2020 06:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=sqWvtyC3J90S0Z1L+sUBcl2FyI
 lVrX1gjpJJsojN7CU=; b=ZZGh5MnHyAsBjrATihvWyiXuatnkx9Q902qebeCMWj
 bPagP6ViNmSSEpjVyDl4dqe9wCCuhJX77M4GrtfLVj3CSYSquSI/wu09DNq2l+6Y
 EW1NdnFMwv4L5XO1RNdl08/Ydrb+CLnWqb4vTwUP1oGK6Crn5a0DWrnBI5d7LwBi
 VQ2vce+MaqACpRlhufoX9adMXRdbP897DldFXk9K4cO/yH194TkTU+XR67RXiMi9
 gh7dlsK66G7kkhM+zoraTEjvqJ0QCAohGuZhjlOFusQCGOgeabEvKszyDk3lshNc
 Vz3YOPw3gjEbNoAj4yxbHBUhyKZRv294A5cK4m/Fh/hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sqWvtyC3J90S0Z1L+
 sUBcl2FyIlVrX1gjpJJsojN7CU=; b=pubwQPmFoNTcmqtrJbtlTb7F3nRAPi96D
 7JPhrrJ2iRuXb0600Hu63p20VWjR9kVZDoZkwJYC26EqRfk4X7982gXZw0xqaT7N
 tTo+tnndUcEWwpZVvaZmSbP3IxdXlhC6YjzMf6I8NAnoRZuMHsQBuLbL9dEYWzcs
 /beCe4LYII50pyJfiGWqsNf3SQMq2zj2iG2pYiObKMJBKt5+2buiUckSajIPR69o
 P2NZWFdvDm6eG/Wep9rkDDZiT6flA2Gu50i4a0HnMrFFWUfrAgZ1dzG7jE+Onv+J
 rj4JwM/H0llDbFBTO6imhAdWFTwjW3hKAEgXjK6iKSZtWgLBWlnag==
X-ME-Sender: <xms:YjuxXjqxVM0XsIc9M9cv_wPdSK4IhFiQKd47o-It_yUvaDKubKK47Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeigddvfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucft
 ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
 hnpeejffehuddvvddvlefhgeelleffgfeijedvhefgieejtdeiueetjeetfeeukeejgeen
 ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:YjuxXsb2pIVHiw2esUC5gL_zyfsgb-PMys3ZuBhKST-bmwlrGldw5w>
 <xmx:YjuxXkzt-qV_SE8upgRfbQowVyaWF1SFBJd3MHSxtOR8ByU7pynpkA>
 <xmx:YjuxXi9G-5s7Hb6X2JTLljlM3bBSRSo_0QpKR6n36YXBtTXTNzHURw>
 <xmx:ZDuxXmP_pEJyNXtprJ13xRM1SmcjOOAqq9RLfgj0-9Is_LdsogKshg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5CB84328005D;
 Tue,  5 May 2020 06:09:38 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3 0/5] iommu: Add Allwinner H6 IOMMU driver
Date: Tue,  5 May 2020 12:09:29 +0200
Message-Id: <cover.70f96f9afd2e04161ebece593ae6cd7e17eca41b.1588673353.git-series.maxime@cerno.tech>
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

Let me know what you think,
Maxime

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
 drivers/iommu/sun50i-iommu.c                                                  | 1065 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 1162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
 create mode 100644 drivers/iommu/sun50i-iommu.c

base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
git-series 0.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
