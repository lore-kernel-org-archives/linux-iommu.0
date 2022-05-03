Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A6CC4167B
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 06:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 560BC81DAB;
	Tue,  3 May 2022 06:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3NLXRIELFmm; Tue,  3 May 2022 06:30:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4637D82C61;
	Tue,  3 May 2022 06:30:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32388C008A;
	Tue,  3 May 2022 06:30:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4BEFC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFEE660FCC
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D70Zvem2jSrm for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 06:30:35 +0000 (UTC)
X-Greylist: delayed 00:07:30 by SQLgrey-1.8.0
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92CAF60C1A
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:35 +0000 (UTC)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de
 [87.154.217.136])
 by soltyk.jannau.net (Postfix) with ESMTPSA id E76EF26E9B4;
 Tue,  3 May 2022 08:23:02 +0200 (CEST)
From: Janne Grunau <j@jannau.net>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/4] iommu/io-pgtable: Add DART subpage protection support
Date: Tue,  3 May 2022 08:22:59 +0200
Message-Id: <20220503062301.20872-3-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503062301.20872-1-j@jannau.net>
References: <20220503062301.20872-1-j@jannau.net>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
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
---
 drivers/iommu/io-pgtable-arm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 94ff319ae8ac..71570bbc9096 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
@@ -133,6 +134,9 @@
 #define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
 #define APPLE_DART_PTE_PROT_NO_READ (1<<8)
 
+#define APPLE_DART_PTE_SUBPAGE_START	GENMASK_ULL(63, 52)
+#define APPLE_DART_PTE_SUBPAGE_END	GENMASK_ULL(51, 40)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -273,6 +277,12 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
+	if (data->iop.fmt == APPLE_DART) {
+		/* subpage protection: always allow access to the entire page */
+		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
+		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
+	}
+
 	for (i = 0; i < num_entries; i++)
 		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
