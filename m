Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA24C63798
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 06:19:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CB4246A5
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 06:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CB4246A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 97A7F86B74;
	Thu, 19 Nov 2020 06:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mRUCkV4O966H; Thu, 19 Nov 2020 06:19:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F000D86B68;
	Thu, 19 Nov 2020 06:19:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFD56C0891;
	Thu, 19 Nov 2020 06:19:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33199C07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 06:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2F1D7834A1
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 06:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lVAQ_sxCywjQ for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 06:19:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9359A8086A
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 06:19:16 +0000 (UTC)
X-UUID: c699f1342b924e3fb40ede5a158461b5-20201119
X-UUID: c699f1342b924e3fb40ede5a158461b5-20201119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1858901902; Thu, 19 Nov 2020 14:19:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Nov 2020 14:19:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 14:19:11 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 4/6] iommu: Add granule_ignore when tlb gather
Date: Thu, 19 Nov 2020 14:18:34 +0800
Message-ID: <20201119061836.15238-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119061836.15238-1-yong.wu@mediatek.com>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, jun.wen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
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

Add a granule_ignore option when tlb gather for some HW which don't care
about granule when it flush tlb.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 include/linux/iommu.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 794d4085edd3..1aad32238510 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -171,6 +171,7 @@ enum iommu_dev_features {
  * @start: IOVA representing the start of the range to be flushed
  * @end: IOVA representing the end of the range to be flushed (exclusive)
  * @pgsize: The interval at which to perform the flush
+ * @granule_ignore: For tlb flushing that could be regardless of granule.
  *
  * This structure is intended to be updated by multiple calls to the
  * ->unmap() function in struct iommu_ops before eventually being passed
@@ -180,6 +181,7 @@ struct iommu_iotlb_gather {
 	unsigned long		start;
 	unsigned long		end;
 	size_t			pgsize;
+	bool			granule_ignore;
 };
 
 /**
@@ -544,7 +546,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 	 * a different granularity, then sync the TLB so that the gather
 	 * structure can be rewritten.
 	 */
-	if (gather->pgsize != size ||
+	if ((!gather->granule_ignore && gather->pgsize != size) ||
 	    end < gather->start || start > gather->end) {
 		if (gather->pgsize)
 			iommu_iotlb_sync(domain, gather);
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
