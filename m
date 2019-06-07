Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCA9C28CC3
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 07:53:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188BD208C0
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 07:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188BD208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B021EF49;
	Fri,  7 Jun 2019 07:53:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3E2D7F3C
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 07:52:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
	[210.160.252.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 7C712A9
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 07:52:32 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.60,562,1549897200"; d="scan'208";a="17860181"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
	by relmlie6.idc.renesas.com with ESMTP; 07 Jun 2019 16:52:31 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CDCBC400B9C0;
	Fri,  7 Jun 2019 16:52:30 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: corbet@lwn.net
Subject: [PATCH] Documentation: DMA-API: fix a function name of
	max_mapping_size
Date: Fri,  7 Jun 2019 16:47:13 +0900
Message-Id: <1559893633-6852-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Cc: jroedel@suse.de, linux-doc@vger.kernel.org,
	iommu@lists.linux-foundation.org, hch@lst.de
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The exported function name is dma_max_mapping_size(), not
dma_direct_max_mapping_size() so that this patch fixes
the function name in the documentation.

Fixes: 133d624b1cee ("dma: Introduce dma_max_mapping_size()")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/DMA-API.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 0076150..e47c63b 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -198,7 +198,7 @@ call to set the mask to the value returned.
 ::
 
 	size_t
-	dma_direct_max_mapping_size(struct device *dev);
+	dma_max_mapping_size(struct device *dev);
 
 Returns the maximum size of a mapping for the device. The size parameter
 of the mapping functions like dma_map_single(), dma_map_page() and
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
