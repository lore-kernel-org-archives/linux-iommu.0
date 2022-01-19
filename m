Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77902C433EF
	for <iommu@archiver.kernel.org>; Wed, 19 Jan 2022 19:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C55781241;
	Wed, 19 Jan 2022 19:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NPSfnQtX9uRm; Wed, 19 Jan 2022 19:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1CCD280E3F;
	Wed, 19 Jan 2022 19:06:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8C60C0039;
	Wed, 19 Jan 2022 19:06:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14613C002F;
 Wed, 19 Jan 2022 19:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D909940260;
 Wed, 19 Jan 2022 19:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="yepEWOhq";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="kp2bX3kb"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ruSgOoWweokp; Wed, 19 Jan 2022 19:06:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DA08404C3;
 Wed, 19 Jan 2022 19:06:41 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 3A41E5806C4;
 Wed, 19 Jan 2022 14:06:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 19 Jan 2022 14:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=8yuexR1+nrtHG
 SO8wGNcV0MvB+tGU4p0S4nQ2u6/h9Y=; b=yepEWOhqQwJaAjEwgeK7ltMCvFLxT
 bWHWuUq61bCnebk+XIZWZAbFWk2RZ4zogGXrQCh4S3EqNI3esApEtzpXvRH//XK9
 eNIm42Ph0bcPylp93/Lty3jNJFArwl0QKNutZPJuX0/Fjx/MQ6HjhOr6wt6vKxEs
 TRNmtz+ct8O0ERpGexJ2iByprgaswMXxFk3ALJOX6SH2VyrYksrNsF4TbLK3pED9
 r/98U7UrkyTJi3Ru9PqNb6rWFsBx0tnpxsIJ6gic+V50zRFXhfVhO6JOBeu3mbdd
 OL676jHn8AyPIDpdmBLzCffgesZROjN+Dy9eGlciRFAUP490htMC8JebQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=8yuexR1+nrtHGSO8wGNcV0MvB+tGU4p0S4nQ2u6/h9Y=; b=kp2bX3kb
 DYDCMRBL8FNpr/1RYUeTX4yIw+9hmcc9JbIz1l0nG9kHJcva/xj2cSyefBW1Zg/y
 7UY6tJbAjM9/NlOqrL0e03iIuaofDBz8zH7kJYwk5k2pNr2VmufUXz3GUM58IVJl
 UPRGcbxcBpQNIezbpGuM7GzCeIvSMJjS/jizBkPGNr/RZYcRoC0TgFPg3IJYXQpJ
 /U1E68h5gHpx/fXj9oTWwVBmJVejbAMSb6H1ekIFqjaBRlOc5HSSQkgAEfY4S6P8
 TVcvVHEDCdHT8Tm4jlWsKdwo8VTkJHy93+I+Lo4VWReK6LwVCTuiw1JZe7ksJr69
 ajUi4jX5K5sTWA==
X-ME-Sender: <xms:QGHoYSRY4H48mGFpQ1CYPHyM51xpyR0Al1_H13wTS9AbpSsy3mnllg>
 <xme:QGHoYXz721WeYmo8ZWwPJd_3L6arLfMxqoveB9_LEgRi0yO0Wcv7YbYYgVeqC5SOU
 DWg4ztmeNxL78gMdQ>
X-ME-Received: <xmr:QGHoYf3TS4gy4tX3peD_EMagLecgnVFgDRcOpyz_KwQvnlkLOdpKJX9teb6VTYLB09ZGJ4Nv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:QGHoYeD83UCxVKejVvzNy4cLR9rUbiULW6CM9EaY0fTgQ_uKqDUgdQ>
 <xmx:QGHoYbivearrSCITj7TM-fzcwlLJ2ggHNiGuBrZ1rkUyox129k262Q>
 <xmx:QGHoYaq9NfgZWCAYbskDkwvoVZ_gksJGQg-pwYNaAnFaY7A1riXFYQ>
 <xmx:QWHoYUaZC_pi-6q7r2ORLbdTqmqr4tk1pWSC9MlpMxQTkzjMR-4J3g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 14:06:40 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v4 7/7] arch: powerpc: adjust fadump alignment to be pageblock
 aligned.
Date: Wed, 19 Jan 2022 14:06:23 -0500
Message-Id: <20220119190623.1029355-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119190623.1029355-1-zi.yan@sent.com>
References: <20220119190623.1029355-1-zi.yan@sent.com>
MIME-Version: 1.0
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
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
index 52189928ec08..fbfca85b4200 100644
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
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
