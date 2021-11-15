Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33473C433EF
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 19:55:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D051661B48
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 19:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D051661B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97F3C80D6F;
	Mon, 15 Nov 2021 19:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQp29fRIhWhP; Mon, 15 Nov 2021 19:55:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 86F9B80D4C;
	Mon, 15 Nov 2021 19:55:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46CEFC002E;
	Mon, 15 Nov 2021 19:55:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64D69C0012;
 Mon, 15 Nov 2021 19:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 445DD6079D;
 Mon, 15 Nov 2021 19:46:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="xB60fto7";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="ARzj9GHt"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Um0zGOVranj0; Mon, 15 Nov 2021 19:46:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81D61607A7;
 Mon, 15 Nov 2021 19:46:00 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 49F79580604;
 Mon, 15 Nov 2021 14:37:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 15 Nov 2021 14:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=AnymEuCYCocHA
 Ds+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=xB60fto7b9p9zKYRdTNdwVmSChO8D
 SsoFs9Iaft6I6qyt8nf1cWMRPpERDLgYtJOY0e4P4TglBSN2AD5X5hepF72gu8A9
 3bvt5vdgmvsE1/Rmxdq98v6ijYxlrVXB08X4oJCo6XWKh+j/x3mT3xJBTVhK9UTt
 gwPKsITbiYfpYQR72+sVMrihaWedOfxpwppqGJoxAVxys5BWkP3r8uWtHMgsBZEP
 L8ilWVDaa5mKsOtUesoBnZRwPXg4inqJjIUHFvHiZH7aFIfqcT+9zn68o17HRl4t
 cso1oqksai7tfAsNxYbjKiE9enRRMgsV4ASU/j9Z362aYKw93iODw8t0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=AnymEuCYCocHADs+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=ARzj9GHt
 89g8ElhfXy2AeWhnjWydjJMa7fp8+4jCzsf+jp8rv0KH7rW7KKKl40wkQOQP06K3
 sop3YEKBNBAa2jUfpJo9pZ5EXaNJDa8zswYcftk3XMqBYiSXrHSa066NfWqNn1Zw
 96W9bSlWUscrUpyoAwaJMRaf23fi7ZvWYnEN9xPvIO48sq/n6KAOCEpZN2Rd3MeP
 9YghOUKXbxaU+2GuzQ/JKc6O2blT1W9oJ5qdLMt1YGGj6temHwPaGPTJ0jVGypV3
 djHnqcVbuQ/oN//2e48ZaqMMYe18Fm+pc0vyoOAp66vhtkFhOqx5WInoUtNJLyTX
 Vb0drxpdVv3WIg==
X-ME-Sender: <xms:D7eSYepi9_Z8uf-YaHwqRwLRPKfy8_CJW2g9ecIlmuCKhdZavlICEg>
 <xme:D7eSYcp14c186VrFe3DZgntVxmtYeZCcVNEh5-NBfBfe2e5nELed8sVqHe72rpUXU
 XvaoGjEFFbgF0eo_Q>
X-ME-Received: <xmr:D7eSYTP7avKM76qeEnjbyf3F9-6N7NXUyyLCQRFSS4ZKQoxTp6EMnMvUHusYBIy8Gnf1HltY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
 rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
 dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
 thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
 hnthdrtghomh
X-ME-Proxy: <xmx:D7eSYd4yJGehSQMDMdWB_xRmvIPDOk3IdN66w9wppYPuVduHoVtIyw>
 <xmx:D7eSYd7gCBUQmT2CMLvfkRawMDbo81AJQ-SFsg-Cja9aKjU1iUGJ9g>
 <xmx:D7eSYdjOXUCZtIHGbIbHMr9SQgmvy-WOZndHNEJ1sY9TXOEVGqurhQ>
 <xmx:D7eSYSHHQ-Is8qJNgu2aA7Y43q2g-vUX36d-mkxiqCvX19_ozECB1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Nov 2021 14:37:50 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/3] arch: powerpc: adjust fadump alignment to be
 pageblock aligned.
Date: Mon, 15 Nov 2021 14:37:24 -0500
Message-Id: <20211115193725.737539-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115193725.737539-1-zi.yan@sent.com>
References: <20211115193725.737539-1-zi.yan@sent.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 Nov 2021 19:55:29 +0000
Cc: Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Zi Yan <ziy@nvidia.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
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
Reply-To: Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Zi Yan <ziy@nvidia.com>

CMA only requires pageblock alignment now. Change CMA alignment in
fadump too.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/powerpc/include/asm/fadump-internal.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump-internal.h b/arch/powerpc/include/asm/fadump-internal.h
index 8d61c8f3fec4..9198f20b6b68 100644
--- a/arch/powerpc/include/asm/fadump-internal.h
+++ b/arch/powerpc/include/asm/fadump-internal.h
@@ -20,9 +20,7 @@
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
 /* Alignment per CMA requirement. */
-#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
-				 max_t(unsigned long, MAX_ORDER - 1,	\
-				 pageblock_order))
+#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE << pageblock_order)
 
 /* FAD commands */
 #define FADUMP_REGISTER			1
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
