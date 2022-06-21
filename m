Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679D6CCA473
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 07:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC31A41985;
	Tue, 21 Jun 2022 07:18:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC31A41985
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QI5oPLiHPWZe; Tue, 21 Jun 2022 07:18:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 605904195D;
	Tue, 21 Jun 2022 07:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 605904195D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 296B9C0084;
	Tue, 21 Jun 2022 07:18:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE327C0032
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0D4C60B29
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:18:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0D4C60B29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iw3FB_3dNfiq for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 07:18:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE65660B10
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE65660B10
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:18:52 +0000 (UTC)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de
 [87.154.217.136])
 by soltyk.jannau.net (Postfix) with ESMTPSA id 7E63126ED18;
 Tue, 21 Jun 2022 09:18:50 +0200 (CEST)
From: Janne Grunau <j@jannau.net>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3 3/5] iommu/io-pgtable: Add DART subpage protection support
Date: Tue, 21 Jun 2022 09:18:46 +0200
Message-Id: <20220621071848.14834-4-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621071848.14834-1-j@jannau.net>
References: <20220621071848.14834-1-j@jannau.net>
MIME-Version: 1.0
Cc: linux-arm-kernel@lists.infradead.org, Hector Martin <marcan@marcan.st>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Will Deacon <will@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

From: Sven Peter <sven@svenpeter.dev>

DART allows to only expose a subpage to the device. While this is an
optional feature on the M1 DARTs the new ones present on the Pro/Max
models require this field in every PTE.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Janne Grunau <j@jannau.net>

---

Changes in v3:
- apply change to io-pgtable-dart.c

 drivers/iommu/io-pgtable-dart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index 0c5222942c65..fa8025c03bb5 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt)	"dart io-pgtable: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
@@ -63,6 +64,9 @@
 /* Calculate the block/page mapping size at level l for pagetable in d. */
 #define DART_BLOCK_SIZE(l, d)	(1ULL << DART_LVL_SHIFT(l, d))
 
+#define APPLE_DART_PTE_SUBPAGE_START   GENMASK_ULL(63, 52)
+#define APPLE_DART_PTE_SUBPAGE_END     GENMASK_ULL(51, 40)
+
 #define APPLE_DART1_PADDR_MASK	GENMASK_ULL(35, 12)
 
 /* Apple DART1 protection bits */
@@ -140,6 +144,10 @@ static void __dart_init_pte(struct dart_io_pgtable *data,
 
 	pte |= APPLE_DART_PTE_VALID;
 
+	/* subpage protection: always allow access to the entire page */
+	pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
+	pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
+
 	for (i = 0; i < num_entries; i++)
 		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 }
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
