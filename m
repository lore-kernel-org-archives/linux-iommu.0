Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC047C10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 14:50:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9012220821
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 14:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9012220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 622B4C9B;
	Tue, 16 Apr 2019 14:50:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4A65AC96
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 14:50:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB42682D
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 14:50:06 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id C5372D550CFA91E781BA;
	Tue, 16 Apr 2019 22:50:02 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
	(10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
	22:49:55 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <konrad.wilk@oracle.com>, <boris.ostrovsky@oracle.com>, <jgross@suse.com>, 
	<sstabellini@kernel.org>
Subject: [PATCH -next] xen-swiotlb: Make two functions static
Date: Tue, 16 Apr 2019 22:49:50 +0800
Message-ID: <20190416144950.37952-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190416144950.1tDAYMG6xFD5aqB1Cj5yvjqvzVbsH4uPg34HjYOc4X0@z>

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/xen/swiotlb-xen.c:489:1: warning:
 symbol 'xen_swiotlb_sync_single_for_cpu' was not declared. Should it be static?
drivers/xen/swiotlb-xen.c:496:1: warning:
 symbol 'xen_swiotlb_sync_single_for_device' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 877baf2..e741df4 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -485,14 +485,14 @@ xen_swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 		xen_dma_sync_single_for_device(hwdev, dev_addr, size, dir);
 }
 
-void
+static void
 xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 				size_t size, enum dma_data_direction dir)
 {
 	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
 }
 
-void
+static void
 xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 				   size_t size, enum dma_data_direction dir)
 {
-- 
2.7.4


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
