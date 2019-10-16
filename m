Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D624C4360C
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 03:33:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8488020663
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 03:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8488020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0FEF4C3A;
	Wed, 16 Oct 2019 03:33:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0284CBA0
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 03:33:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4007C14D
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 03:33:23 +0000 (UTC)
X-UUID: 3011267dac5e401f8c87368b7d50e8e0-20191016
X-UUID: 3011267dac5e401f8c87368b7d50e8e0-20191016
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
	with ESMTP id 147662271; Wed, 16 Oct 2019 11:33:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
	mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Wed, 16 Oct 2019 11:33:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Wed, 16 Oct 2019 11:33:16 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 0/7] Improve tlb range flush
Date: Wed, 16 Oct 2019 11:33:05 +0800
Message-ID: <1571196792-12382-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	edison.hsieh@mediatek.com, linux-kernel@vger.kernel.org,
	Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This patchset mainly fixes a tlb flush timeout issue and use the new
iommu_gather to re-implement the tlb flush flow. and several clean up
patches about the tlb_flush.

change note:

v4: 1. Add a new tlb_lock for tlb operations.
    2. Delete the pgtlock.
    3. Remove the "writel" patch.

v3: https://lore.kernel.org/linux-iommu/1571035101-4213-1-git-send-email-yong.wu@mediatek.com/T/#t
   1. Use the gather to implement the tlb_flush suggested from Tomasz.
   2. add some clean up patches.

v2:
https://lore.kernel.org/linux-iommu/1570627143-29441-1-git-send-email-yong.wu@mediatek.com/T/#t
   1. rebase on v5.4-rc1
   2. only split to several patches.

v1:
https://lore.kernel.org/linux-iommu/CAAFQd5C3U7pZo4SSUJ52Q7E+0FaUoORQFbQC5RhCHBhi=NFYTw@mail.gmail.com/T/#t

Yong Wu (7):
  iommu/mediatek: Correct the flush_iotlb_all callback
  iommu/mediatek: Add a new tlb_lock for tlb_flush
  iommu/mediatek: Use gather to achieve the tlb range flush
  iommu/mediatek: Delete the leaf in the tlb_flush
  iommu/mediatek: Move the tlb_sync into tlb_flush
  iommu/mediatek: Get rid of the pgtlock
  iommu/mediatek: Reduce the tlb flush timeout value

 drivers/iommu/mtk_iommu.c | 88 +++++++++++++++--------------------------------
 drivers/iommu/mtk_iommu.h |  2 +-
 2 files changed, 29 insertions(+), 61 deletions(-)

-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
