Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B351DC433DF
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 11:37:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0393D22263
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 11:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mp2Xzjek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0393D22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 716EC27404;
	Mon, 19 Oct 2020 11:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id avqpDrvOCuQY; Mon, 19 Oct 2020 11:37:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F10AF20343;
	Mon, 19 Oct 2020 11:37:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDE1CC0052;
	Mon, 19 Oct 2020 11:37:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF329C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8FCCD20343
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0s-IWK6m2mz6 for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 11:37:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by silver.osuosl.org (Postfix) with ESMTP id 594BA2011B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:37:34 +0000 (UTC)
X-UUID: c1b147055df648459a539ae96bd73431-20201019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=aNtNGXeJLGDumINEjf9bWj2sEZwVw3nV2iDSgN4Ie4I=; 
 b=mp2XzjekOuzWMA059D20L/sxhoiNY9V2AElGv9X5dTgtrDawc3SYTRZEWfXze9qEdYozfZuQaKTDwZUfQTH4Mas0z+RgDp4Hhhgpk+c5tLqs+HZS+swjcnimr6C/xUL3Y83t7Fks4VEbjekVZCqjvtNNG8Xxz4zuFwr3uOtE8Sg=;
X-UUID: c1b147055df648459a539ae96bd73431-20201019
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1952249611; Mon, 19 Oct 2020 19:37:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Oct 2020 19:37:28 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Oct 2020 19:37:27 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 0/4] MTK_IOMMU: Optimize mapping / unmapping performance
Date: Mon, 19 Oct 2020 19:30:56 +0800
Message-ID: <20201019113100.23661-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-TM-SNTS-SMTP: 15E5CB9EC7FD0FD48D83E2456A7D282C07A92B4951C0BD41AB454EE3475C52ED2000:8
X-MTK: N
Cc: Jun Wen <jun.wen@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Mingyuan Ma <mingyuan.ma@mediatek.com>
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

    For MTK platforms, mtk_iommu is using iotlb_sync(), tlb_add_range() and tlb_flush_walk/leaf()
to do tlb sync when iommu driver runs iova mapping/unmapping. But if buffer size is large,
it maybe consist of many pages(4K/8K/64K/1MB......). So iommu driver maybe run many times tlb
sync in mapping for this case and it will degrade performance seriously. In order to resolve the
issue, we hope to add iotlb_sync_range() callback in iommu_ops, it can appiont iova and size to
do tlb sync. MTK_IOMMU will use iotlb_sync_range() callback when the whole mapping/unmapping is
completed and remove iotlb_sync(), tlb_add_range() and tlb_flush_walk/leaf().
    So this patchset will replace iotlb_sync(), tlb_add_range() and tlb_flush_walk/leaf() with
iotlb_sync_range() callback.

Chao Hao (4):
  iommu: Introduce iotlb_sync_range callback
  iommu/mediatek: Add iotlb_sync_range() support
  iommu/mediatek: Remove unnecessary tlb sync
  iommu/mediatek: Adjust iotlb_sync_range

    drivers/iommu/dma-iommu.c |  9 +++++++++
    drivers/iommu/iommu.c     |  7 +++++++
    drivers/iommu/mtk_iommu.c | 36 ++++++++----------------------------
    include/linux/iommu.h     |  2 ++
    4 files changed, 26 insertions(+), 28 deletions(-)

--
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
