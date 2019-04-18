Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246CC10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 22:30:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB6A2087F
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 22:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB6A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 341FE1D82;
	Thu, 18 Apr 2019 22:30:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 434431C39
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 19:09:05 +0000 (UTC)
X-Greylist: delayed 00:22:36 by SQLgrey-1.7.6
Received: from gateway21.websitewelcome.com (gateway21.websitewelcome.com
	[192.185.45.95])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 40E4C466
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 19:09:04 +0000 (UTC)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
	by gateway21.websitewelcome.com (Postfix) with ESMTP id 963B4400D7427
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 13:46:27 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
	id HC3Hh7zHLYTGMHC3HhF7tg; Thu, 18 Apr 2019 13:46:27 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.103] (port=43216 helo=embeddedor)
	by gator4166.hostgator.com with esmtpa (Exim 4.91)
	(envelope-from <gustavo@embeddedor.com>)
	id 1hHC3G-002rUT-10; Thu, 18 Apr 2019 13:46:26 -0500
Date: Thu, 18 Apr 2019 13:46:24 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/dmar: Use struct_size() helper
Message-ID: <20190418184624.GA17025@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.linux-foundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.103
X-Source-L: No
X-Exim-ID: 1hHC3G-002rUT-10
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.103]:43216
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Mailman-Approved-At: Thu, 18 Apr 2019 22:30:27 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
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
Message-ID: <20190418184624.ecajf-o3u5Jz2EescZBDEynuuTB4Bwg_2E4poe-Pqwg@z>

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace code of the following form:

size = sizeof(*info) + level * sizeof(info->path[0]);

with:

size = struct_size(info, path, level);

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9c49300e9fb7..6d969a172fbb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -145,7 +145,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 		for (tmp = dev; tmp; tmp = tmp->bus->self)
 			level++;
 
-	size = sizeof(*info) + level * sizeof(info->path[0]);
+	size = struct_size(info, path, level);
 	if (size <= sizeof(dmar_pci_notify_info_buf)) {
 		info = (struct dmar_pci_notify_info *)dmar_pci_notify_info_buf;
 	} else {
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
