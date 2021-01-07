Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CD7C433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 12:30:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FAE23356
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 12:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FAE23356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C8CF3272E3;
	Thu,  7 Jan 2021 12:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NDBzrNpjks-Q; Thu,  7 Jan 2021 12:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C70EC23600;
	Thu,  7 Jan 2021 12:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1228C088B;
	Thu,  7 Jan 2021 12:30:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1C4DC013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 12:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B83BE23730
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 12:30:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tWIfddPK2OSP for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 12:30:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by silver.osuosl.org (Postfix) with ESMTP id E1BF623600
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 12:30:21 +0000 (UTC)
X-UUID: 019e05679d6c4e05be293d4c8e860417-20210107
X-UUID: 019e05679d6c4e05be293d4c8e860417-20210107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2097611858; Thu, 07 Jan 2021 20:30:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Jan 2021 20:30:16 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Jan 2021 20:30:15 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 5/7] iommu/io-pgtable: Allow io_pgtable_tlb ops optional
Date: Thu, 7 Jan 2021 20:29:07 +0800
Message-ID: <20210107122909.16317-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210107122909.16317-1-yong.wu@mediatek.com>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 David Laight <David.Laight@ACULAB.COM>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org
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

This patch allows io_pgtable_tlb ops could be null since the IOMMU drivers
may use the tlb ops from iommu framework.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 include/linux/io-pgtable.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index ea727eb1a1a9..2a5686ca2ba3 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -214,14 +214,16 @@ struct io_pgtable_domain_attr {
 
 static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
 {
-	iop->cfg.tlb->tlb_flush_all(iop->cookie);
+	if (iop->cfg.tlb && iop->cfg.tlb->tlb_flush_all)
+		iop->cfg.tlb->tlb_flush_all(iop->cookie);
 }
 
 static inline void
 io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
 			  size_t size, size_t granule)
 {
-	iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
+	if (iop->cfg.tlb && iop->cfg.tlb->tlb_flush_walk)
+		iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
 }
 
 static inline void
@@ -229,7 +231,7 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
 			struct iommu_iotlb_gather * gather, unsigned long iova,
 			size_t granule)
 {
-	if (iop->cfg.tlb->tlb_add_page)
+	if (iop->cfg.tlb && iop->cfg.tlb->tlb_add_page)
 		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
 }
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
