Return-Path: <SRS0=B3TS=TL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD6EC46460
	for <iommu@archiver.kernel.org>; Sat, 11 May 2019 12:41:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8405C2184B
	for <iommu@archiver.kernel.org>; Sat, 11 May 2019 12:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8405C2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 44F50AF7;
	Sat, 11 May 2019 12:41:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E6BAAA49
	for <iommu@lists.linux-foundation.org>;
	Sat, 11 May 2019 12:41:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 79F141FB
	for <iommu@lists.linux-foundation.org>;
	Sat, 11 May 2019 12:41:38 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.76)
	(envelope-from <colin.king@canonical.com>)
	id 1hPRJo-0008Us-2r; Sat, 11 May 2019 12:41:36 +0000
From: Colin King <colin.king@canonical.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: remove redundant assignment to variable npages
Date: Sat, 11 May 2019 13:41:35 +0100
Message-Id: <20190511124135.3635-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

The variable npages is being initialized however this is never read and
later it is being reassigned to a new value. The initialization is
redundant and hence can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 09c9e45f7fa2..c0b5b9298e8e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2609,7 +2609,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	unsigned long startaddr;
-	int npages = 2;
+	int npages;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
