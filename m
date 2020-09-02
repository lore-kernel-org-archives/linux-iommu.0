Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97AFC433E7
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BEB2083B
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BEB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9139E86907;
	Wed,  2 Sep 2020 17:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPqn+0D4SvRN; Wed,  2 Sep 2020 17:31:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A584868D9;
	Wed,  2 Sep 2020 17:31:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7817BC0893;
	Wed,  2 Sep 2020 17:31:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 193C8C0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 17:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 085A0866AE
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 17:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ByrZ6i3H1VRq for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 17:31:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5017D8686A
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 17:31:10 +0000 (UTC)
IronPort-SDR: ZoEiHB5/sJU2XmAEBcX6OXNArl0neKX4dxZu7+CGf8HMCpnPT0pNy3ksXb/wHVPvqAqBSNdovB
 4jeWUlVA2biQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="137493020"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="137493020"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 10:31:09 -0700
IronPort-SDR: PgfSfN9GeZ2DpsLN9FpjvvJBKfCKO9A4Sdfc1J/ckEdSg0vKaK83gb2O3qiwrtOwMYh9cQEnEM
 b8Mfju1r7dGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="334183283"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2020 10:31:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 3EE4D11E; Wed,  2 Sep 2020 20:31:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/3] swiotlb: Use %pa to print phys_addr_t variables
Date: Wed,  2 Sep 2020 20:31:03 +0300
Message-Id: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

There is an extension to a %p to print phys_addr_t type of variables.
Use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped bytes replacement (Fabio)
 kernel/dma/swiotlb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fabd20..6499bda8f0b8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -172,9 +172,7 @@ void swiotlb_print_info(void)
 		return;
 	}
 
-	pr_info("mapped [mem %#010llx-%#010llx] (%luMB)\n",
-	       (unsigned long long)io_tlb_start,
-	       (unsigned long long)io_tlb_end,
+	pr_info("mapped [mem %pa-%pa] (%luMB)\n", &io_tlb_start, &io_tlb_end,
 	       bytes >> 20);
 }
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
