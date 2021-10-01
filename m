Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6765CC43217
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:34:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA7661A51
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DA7661A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FECE42204;
	Fri,  1 Oct 2021 14:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LPQ75UZH3VCF; Fri,  1 Oct 2021 14:34:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8567C421E2;
	Fri,  1 Oct 2021 14:34:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 579A5C0022;
	Fri,  1 Oct 2021 14:34:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AEACC002A
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB36E843E1
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pNxW1hi8k25U for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 14:34:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC29C842CF
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CD7811F457AB;
 Fri,  1 Oct 2021 15:34:34 +0100 (BST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/5] [RFC]iommu/io-pgtable-arm: Take the DEVONLY flag into
 account on ARM_MALI_LPAE
Date: Fri,  1 Oct 2021 16:34:24 +0200
Message-Id: <20211001143427.1564786-3-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001143427.1564786-1-boris.brezillon@collabora.com>
References: <20211001143427.1564786-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org
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

Restrict the shareability domain when mapping buffers that are
GPU-visible only.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Flagged RFC because I'm not sure adding a new flag is the right
way to convey the 'dev-private buffer' information.
---
 drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index dd9e47189d0d..6ac3defb9ae1 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -450,16 +450,25 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}
 
-	/*
-	 * Also Mali has its own notions of shareability wherein its Inner
-	 * domain covers the cores within the GPU, and its Outer domain is
-	 * "outside the GPU" (i.e. either the Inner or System domain in CPU
-	 * terms, depending on coherency).
-	 */
-	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
+	if (data->iop.fmt == ARM_MALI_LPAE) {
+		/*
+		 * Mali has its own notions of shareability wherein its Inner
+		 * domain covers the cores within the GPU, and its Outer domain
+		 * is "outside the GPU" (i.e. either the Inner or System domain
+		 * in CPU terms, depending on coherency).
+		 * If the mapping is only device-visible, we can use the Inner
+		 * domain, otherwise we need to stick to Outer domain
+		 * shareability.
+		 */
+		if (prot & IOMMU_DEVONLY)
+			pte |= ARM_LPAE_PTE_SH_IS;
+		else
+			pte |= ARM_LPAE_PTE_SH_OS;
+	} else if (prot & IOMMU_CACHE) {
 		pte |= ARM_LPAE_PTE_SH_IS;
-	else
+	} else {
 		pte |= ARM_LPAE_PTE_SH_OS;
+	}
 
 	if (prot & IOMMU_NOEXEC)
 		pte |= ARM_LPAE_PTE_XN;
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
