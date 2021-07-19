Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B11C636CA
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 00:56:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA45610A2
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 00:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA45610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A66E835DF;
	Mon, 19 Jul 2021 00:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8lXPzTblwrr6; Mon, 19 Jul 2021 00:56:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44B8F835D3;
	Mon, 19 Jul 2021 00:56:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0566FC001A;
	Mon, 19 Jul 2021 00:56:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 889E2C000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 00:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70455835DF
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 00:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2Lzuhpvu8QG for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 00:56:46 +0000 (UTC)
X-Greylist: delayed 00:09:23 by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DD79835D3
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 00:56:46 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id A67827F46A; Mon, 19 Jul 2021 03:47:19 +0300 (EEST)
Date: Mon, 19 Jul 2021 03:47:19 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Fix I/O page fault logging ratelimit test
Message-ID: <YPTLl7XHOGp5NiVH@wantstofly.org>
MIME-Version: 1.0
Content-Disposition: inline
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

On an AMD system, I/O page faults are usually logged like this:

	drvname 0000:05:00.0: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x0000000092050da0 flags=0x0020]

But sometimes they are logged like this instead, even for the exact
same PCI device:

	AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 domain=0x0000 address=0x0000000092050de0 flags=0x0020]

This discrepancy appears to be caused by this code:

	if (dev_data && __ratelimit(&dev_data->rs)) {
		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
			domain_id, address, flags);
	} else if (printk_ratelimit()) {
		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
			domain_id, address, flags);
	}

If an I/O page fault occurs for a PCI device with associated
iommu_dev_data, but for which the __ratelimit(&dev_data->rs) check fails,
we'll give it a second chance with printk_ratelimit(), and if that check
succeeds, we will log the fault anyway, but in a different format.

Change this to only check printk_ratelimit() if !dev_data, which seems to
be what had been originally intended.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 drivers/iommu/amd/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 811a49a95d04..7ae426b092f2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -483,7 +483,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 	if (dev_data && __ratelimit(&dev_data->rs)) {
 		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
 			domain_id, address, flags);
-	} else if (printk_ratelimit()) {
+	} else if (!dev_data && printk_ratelimit()) {
 		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			domain_id, address, flags);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
