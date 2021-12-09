Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737B8C433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 23:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C2F180C69;
	Thu,  9 Dec 2021 23:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ks5LVSS3aYwP; Thu,  9 Dec 2021 23:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C1BCA80C63;
	Thu,  9 Dec 2021 23:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 257A6C006E;
	Thu,  9 Dec 2021 23:36:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78C4FC0012;
 Thu,  9 Dec 2021 23:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66B6D4262F;
 Thu,  9 Dec 2021 23:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="EWH4R1T6";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="HZtl8rio"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJ_5CyCNT8iQ; Thu,  9 Dec 2021 23:04:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A518242622;
 Thu,  9 Dec 2021 23:04:43 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id D8885580336;
 Thu,  9 Dec 2021 18:04:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 09 Dec 2021 18:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=AnymEuCYCocHA
 Ds+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=EWH4R1T6XLR7/XPYv2+SuW3bSclZ2
 Kvvb5NsB7w82sEJmQn0JTB+0tYZOTesLZT4rKW45XSVxeH1bnS7C74KuCr4rc4MT
 p8BtjGButAGWBNV4uo+rZcJ3rKJswkkAJkPSP+Zqdo7YaZ6Zf+UbAsWH2oQ1IVu5
 y7x1kCiTvV6CbZBdLUT2NhuhIGI0vBByiLkfoLEdr6U32Cu6Rz/ZGFsfDuIYwnms
 wLY7nz1uydR2fz3GqBsSnRTesabSsmAgM5e6agHA8En5BtHs2HlAphAH1MBOpPsu
 m4O5k9GgUc1WCJD0+OoSKxbUvdWgPIcq+VlI1Uso6SDFOSpgDCfEEXzdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=AnymEuCYCocHADs+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=HZtl8rio
 tiDaICvgAUzv/4f1nQmSHjhBIUEQFY861mwC2NyYz6pCsrC7nu3u9UtEXyZVB/mx
 BjBVhTTTu0BpzEwPwkHvBsIVW5nwvpZQgy+QrLPmAH1nl952z6L38W21OrhYwnhc
 peJfhNpeHrz2BC7QfBdFv4KCbeG/ZZhUQWLtQy4lYqiwpdWIWIqCWQd4ToWrz5GP
 9N+4GLDRjrKZai/PggjolYf5hbvep3tSuZMRz/X/MuyX5iv7HYnYBXPwaOZiP3m8
 wAcugQbbt7v/J1Mf/NXWwgXTu4BjEh+XMdDtHqmxke9L9OqmXsy3lbasdxV1vKnd
 T6WCa5FKe+ZVTA==
X-ME-Sender: <xms:iouyYeTVgH8ecDbOlF7wKOSH2hbfe-phC6rhzNtLNbpHdlCYt1dIIg>
 <xme:iouyYTwGLDgDIEHg_Eaw_iNPBtu0RXQqNkJba78sHdTf9RiHSZNgQzS_JVIPJ2IdD
 x0vjj438dKjHVxP0g>
X-ME-Received: <xmr:iouyYb3nCDeuVSMgAhBPzHQBkjPbsZgdOD6I8i1CDXXu32PtmMKuxZJb-VgDZp3rmYzEfzr4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:iouyYaDlHTwHozoQD7OJ2ylBL_etQamuyf48-S6eHzhvK4FtAUES7Q>
 <xmx:iouyYXhJzCDzQtVD3NYsG4zcpqTAUAAJtH0AY-SZdLojN1sLOvUsvg>
 <xmx:iouyYWq0g8wwEte4zQhjjH6ln3n-DKcn94VCAAu62nPln3WBKoAB4g>
 <xmx:iouyYQaZscSeRo5m2okFZdWcKobvbA7nU8mLQF60niy2bvnUQLaDjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:42 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 7/7] arch: powerpc: adjust fadump alignment to be
 pageblock aligned.
Date: Thu,  9 Dec 2021 18:04:14 -0500
Message-Id: <20211209230414.2766515-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
References: <20211209230414.2766515-1-zi.yan@sent.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 09 Dec 2021 23:36:06 +0000
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
