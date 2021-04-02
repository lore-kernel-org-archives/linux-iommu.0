Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D9C433ED
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:33:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B934A610CB
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B934A610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ECD36061B;
	Fri,  2 Apr 2021 14:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jh0cwWHrWJ9A; Fri,  2 Apr 2021 14:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DF9160605;
	Fri,  2 Apr 2021 14:33:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A858C000B;
	Fri,  2 Apr 2021 14:33:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0499C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B479360607
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XaHBe4gkPoTy for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 14:33:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 446F360605
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=sXSKTsGRw3P71+Ydxq+mxOs0N8SkMB3MCrXyoev8/OA=; b=ciSNhtJxNgbNPhqmft4Azse1Cq
 bJ4w7dWBvhCLi1gQ9O+m/aZYd/6XUYHIzETHedBvqzHpmo3yS458vVU1v/Pin77WzMgRk6RFWxU0l
 FFjXOSq+jV9GEejBbjgwIiBsD4021DMIjaGVicNfGkdeAh7Sop9KrxW+81mVghfZCTQAoD15R4+Fy
 2om2co3bl7fBBdyEJ7zku16IoNpweVfzETkCB5lH9n0IwN+OTy3KAhnMjXP8U0MZGJIQYBIzo9S+F
 oiZfRzErLWiu8LOLwItciVCq91ut+p2muDCCwXtQNhGJLrUOsixY/0Xl0J4B6BKyfGRTXlxpHo4Dj
 QuDQaG1Q==;
Received: from [2001:4bb8:180:7517:6acc:e698:6fa4:15da] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lSKrK-00FAFO-My; Fri, 02 Apr 2021 14:33:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: AMD IOMMU cleanups and dead code removal
Date: Fri,  2 Apr 2021 16:33:08 +0200
Message-Id: <20210402143312.372386-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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

Hi,

this series cleans up a few random bits in the AMD IOMMU driver.

Diffstat:
 arch/x86/events/amd/iommu.c            |    1 
 arch/x86/events/amd/iommu.h            |   19 ------
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c |    4 -
 drivers/iommu/amd/amd_iommu.h          |    2 
 drivers/iommu/amd/amd_iommu_types.h    |    1 
 drivers/iommu/amd/init.c               |    5 -
 drivers/iommu/amd/iommu.c              |   90 +--------------------------------
 include/linux/amd-iommu.h              |   30 ++++-------
 8 files changed, 16 insertions(+), 136 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
