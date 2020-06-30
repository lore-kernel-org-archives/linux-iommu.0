Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BFC433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F662073E
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZVxRodUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F662073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 56F898502B;
	Tue, 30 Jun 2020 22:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x2ZEdDnIznUn; Tue, 30 Jun 2020 22:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E453884FB0;
	Tue, 30 Jun 2020 22:47:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0FD7C088F;
	Tue, 30 Jun 2020 22:47:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE414C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 307C0835D8
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YaOxPLBnromF for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 22:47:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 27E218721B
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1593557233; x=1625093233;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=zNDwKeFsXiPftO0g4+2i8CwkFlB4xav3vyu/LbH4gl8=;
 b=ZVxRodUR+9ozlDmJjTlCPiGroa5D0FEv/wj51IhSEtGlIlqj4kYFEXRQ
 A6SBYN4mNM6wEz8jBAQh3e1hK+UY49ACSY+WCcv+cv/kDFns9xXGCkBEM
 G9XruJC7e/Cne1ZQqRTD0q5ixkMNlBO1G/dpXU9fhIyrLtREMQAiatT9R U=;
IronPort-SDR: w6qXFHpbsL/OM2kzRts4445bRQ8hGvzMDhcUYQXmhZnLFJiZyEM2m2GlAcxeW4qhVNdfH8FPDy
 sRBaL3XkPjwg==
X-IronPort-AV: E=Sophos;i="5.75,298,1589241600"; d="scan'208";a="39319767"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 30 Jun 2020 22:47:11 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS
 id 6FBDBA1FA8; Tue, 30 Jun 2020 22:47:09 +0000 (UTC)
Received: from EX13D29UWA004.ant.amazon.com (10.43.160.33) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 22:47:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D29UWA004.ant.amazon.com (10.43.160.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 22:47:08 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.20) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 30 Jun 2020 22:47:07 +0000
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 3/3] iommu/amd: Actually enforce geometry aperture
Date: Wed, 1 Jul 2020 00:46:34 +0200
Message-ID: <20200630224634.319-4-sebott@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630224634.319-1-sebott@amazon.de>
References: <20200630093039.GC28824@8bytes.org>
 <20200630224634.319-1-sebott@amazon.de>
MIME-Version: 1.0
Cc: Benjamin Serebrin <serebrin@amazon.com>, Filippo Sironi <sironi@amazon.de>,
 Sebastian Ott <sebott@amazon.de>
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
From: Sebastian Ott via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sebastian Ott <sebott@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add a check to enforce that I/O virtual addresses picked by iommu API
users stay within the domains geometry aperture.

Signed-off-by: Sebastian Ott <sebott@amazon.de>
Cc: Benjamin Serebrin <serebrin@amazon.com>
Cc: Filippo Sironi <sironi@amazon.de>

CR: https://code.amazon.com/reviews/CR-26408388
---
 drivers/iommu/amd/iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b3f79820fd6d..bfa9c4a1fcf8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2159,11 +2159,13 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 static void amd_iommu_probe_finalize(struct device *dev)
 {
 	struct iommu_domain *domain;
+	u64 base = IOVA_START_PFN << PAGE_SHIFT;
+	u64 size = amd_iommu_max_va - base;
 
 	/* Domains are initialized for this device - have a look what we ended up with */
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, 0);
+		iommu_setup_dma_ops(dev, base, size);
 }
 
 static void amd_iommu_release_device(struct device *dev)
@@ -2500,6 +2502,11 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (pgtable.mode == PAGE_MODE_NONE)
 		return -EINVAL;
 
+	if (dom->geometry.force_aperture &&
+	    (iova < dom->geometry.aperture_start ||
+	     iova + page_size - 1 > dom->geometry.aperture_end))
+		return -EINVAL;
+
 	if (iommu_prot & IOMMU_READ)
 		prot |= IOMMU_PROT_IR;
 	if (iommu_prot & IOMMU_WRITE)
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
