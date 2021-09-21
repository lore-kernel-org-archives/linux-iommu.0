Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D624C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 15:40:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D6560F44
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 15:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29D6560F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3B064011A;
	Tue, 21 Sep 2021 15:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GtL40n47kX5l; Tue, 21 Sep 2021 15:40:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3EB76400EB;
	Tue, 21 Sep 2021 15:40:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12DBBC000F;
	Tue, 21 Sep 2021 15:40:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2D23C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 15:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8525C40102
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 15:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mqSICU4KHA0x for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:40:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 161ED400EB
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 15:40:13 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id DEE225C0219;
 Tue, 21 Sep 2021 11:40:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 21 Sep 2021 11:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=NeiQiZ92CcyzMH6Gasfs+HCvVC
 zePzXrLSjQOYzGqBw=; b=kQWcAUPqB9sppmE47DfvKxYCcBMpwNv5PqHLy1zBqJ
 mE6b4cmfvlydNJ/8yJqDzTcuPEfiP5kYbncQt6zDhJGNxIT4W+xknSsipOtAQ9qx
 U6y+pkuFDDgy5xVoc117+B27zX59E82QMbN6xrc5VGml2TC8dqUzefh+K09kAgJq
 2lpNgDaa7Pp8yZGBQyFxYq9wuHZItFqcwLwADVk3BxlBvAN0nWvHH0A/Gw5yVX0B
 2pLbF9Z+LhvU0dnf8ifhUT+E3zo2wrUGB0nnHlCq2EKHf2DJv7Fj4preatyDtkUL
 hTV0tAl0pIho0+bPZW7GOtgUSfENQX+13iCSsGgC7yvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NeiQiZ92CcyzMH6Ga
 sfs+HCvVCzePzXrLSjQOYzGqBw=; b=Q5MfkIVh64zoQcghFJBj7Ze+5Whkzzk0L
 bCZvNi4FACRgI8/L2z4Ag1doix6JL5jw004VmSEpxXA4J+diC9jXLFBjocnwCNVb
 k5l/pBLUr/pL4RT4pREiRTL5KllCWD/7UN6MegS45X0/HGONFvGK4izKUX1uDRgq
 IfK3TEY3o/chEJVnGQ/Zlt5ewg00g0UIDPwBXuQEye2A05xG9wjCVWntOBEWgi/+
 6I7L4LrYnV9q7r2A0GvuL24WMuGufxIh8ksh8ZfE3LOnZJ04BKpwpKldgtSb6YTi
 ogx8olPNsgAi1RobBH2P1wmxjpwx8knt/YWj3jShYmzX11gyIPjAw==
X-ME-Sender: <xms:3PxJYX4gxcN4lt-Ue5QakfuYbmQ46itxYJLlg77Fr54a_fZU39y4SQ>
 <xme:3PxJYc4lPvb6Mo3UniX4zikBhlfS1xWEymC7J-ditStRBBJuKiahL2Gubekbn8hXr
 ty16ynrh0laMtM5AWQ>
X-ME-Received: <xmr:3PxJYeeEtSOfux14z-mN5WlWr-2fhvNa15YU0z5bi35wVIYNmBo37Rccw5alAZU3mHBZtFbOEDq6mF9ks1xghnBKCpG09E4d--3vKEq5DQ7P_5LcpU-DXXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeigedgledvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
 thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
 epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
 hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:3PxJYYKMiGURmBDapgMQPSyOV4QTLjhhV3GorhLaxtd45bwDs6H2HA>
 <xmx:3PxJYbJjfGlZ4VEjc1AsKUicULDV6YGVRz0CL9hu5SUjkwzy5ZSufA>
 <xmx:3PxJYRz7hnDw2t4HmwCCagGdaZGvPVs7LCXuCtqr8a8YTP_82pDPIw>
 <xmx:3PxJYYGPRMT-rZ6CdoiLQCVWB3472hPk0Ms0qX_0G5km5Xq-vn0nRA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Sep 2021 11:40:11 -0400 (EDT)
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/dart: Remove iommu_flush_ops
Date: Tue, 21 Sep 2021 17:39:34 +0200
Message-Id: <20210921153934.35647-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>
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

apple_dart_tlb_flush_{all,walk} expect to get a struct apple_dart_domain
but instead get a struct iommu_domain right now. This breaks those two
functions and can lead to kernel panics like the one below.
DART can only invalidate the entire TLB and apple_dart_iotlb_sync will
already flush everything. There's no need to do that again inside those
two functions. Let's just drop them.

  pci 0000:03:00.0: Removing from iommu group 1
  Unable to handle kernel paging request at virtual address 0000000100000023
  [...]
  Call trace:
   _raw_spin_lock_irqsave+0x54/0xbc
   apple_dart_hw_stream_command.constprop.0+0x2c/0x130
   apple_dart_tlb_flush_all+0x48/0x90
   free_io_pgtable_ops+0x40/0x70
   apple_dart_domain_free+0x2c/0x44
   iommu_group_release+0x68/0xac
   kobject_cleanup+0x4c/0x1fc
   kobject_cleanup+0x14c/0x1fc
   kobject_put+0x64/0x84
   iommu_group_remove_device+0x110/0x180
   iommu_release_device+0x50/0xa0
  [...]

Fixes: 46d1fb072e76b161 ("iommu/dart: Add DART iommu driver")
Reported-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index c37fb4790e8a..47ffe9e49abb 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -181,7 +181,6 @@ struct apple_dart_master_cfg {
 
 static struct platform_driver apple_dart_driver;
 static const struct iommu_ops apple_dart_iommu_ops;
-static const struct iommu_flush_ops apple_dart_tlb_ops;
 
 static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
 {
@@ -336,22 +335,6 @@ static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
 	apple_dart_domain_flush_tlb(to_dart_domain(domain));
 }
 
-static void apple_dart_tlb_flush_all(void *cookie)
-{
-	apple_dart_domain_flush_tlb(cookie);
-}
-
-static void apple_dart_tlb_flush_walk(unsigned long iova, size_t size,
-				      size_t granule, void *cookie)
-{
-	apple_dart_domain_flush_tlb(cookie);
-}
-
-static const struct iommu_flush_ops apple_dart_tlb_ops = {
-	.tlb_flush_all = apple_dart_tlb_flush_all,
-	.tlb_flush_walk = apple_dart_tlb_flush_walk,
-};
-
 static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -433,7 +416,6 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 		.ias = 32,
 		.oas = 36,
 		.coherent_walk = 1,
-		.tlb = &apple_dart_tlb_ops,
 		.iommu_dev = dart->dev,
 	};
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
