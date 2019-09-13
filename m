Return-Path: <SRS0=dyvA=XI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA78C4CEC5
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 15:11:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32E62089F
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 15:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="tBjYtiBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32E62089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 00458AF5;
	Fri, 13 Sep 2019 15:11:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 80EDC1000
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:42:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F0B5A7D2
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1568385763; x=1599921763;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=tL7VZz8etW2SOfrRpMe1LtVFGcdBvKu1hAkYazabhwQ=;
	b=tBjYtiBZUx64w/NnUvJdjrIbFSKP0c/WoAbEBIKX5ntjtNzZ44DcUpq1
	fBJzwst4MsjrOKvgTguaA7uZ7aInxkidxAlKBM+cI0nysMgyyKxa0UWTS
	SEzfSAYDJDpdVtkyPjIodnV5Uom5Q5fOvLyZsImYKj0Bu4ukXbOpQ69un 8=;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; d="scan'208";a="415115258"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
	email-inbound-relay-2c-87a10be6.us-west-2.amazon.com)
	([10.124.125.6])
	by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
	13 Sep 2019 14:42:42 +0000
Received: from u793be3441f0353.ant.amazon.com
	(pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
	by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with
	ESMTPS id 075FBA224B; Fri, 13 Sep 2019 14:42:41 +0000 (UTC)
Received: from u793be3441f0353.ant.amazon.com (localhost [127.0.0.1])
	by u793be3441f0353.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS
	id x8DEgei5021489
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2019 16:42:40 +0200
Received: (from adulea@localhost)
	by u793be3441f0353.ant.amazon.com (8.15.2/8.15.2/Submit) id
	x8DEgdPT021487; Fri, 13 Sep 2019 16:42:39 +0200
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/4] iommu/amd: Introduce first_pte_l7() helper
Date: Fri, 13 Sep 2019 16:42:30 +0200
Message-Id: <20190913144231.21382-4-adulea@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913144231.21382-1-adulea@amazon.de>
References: <20190913144231.21382-1-adulea@amazon.de>
X-Mailman-Approved-At: Fri, 13 Sep 2019 15:11:34 +0000
Cc: iommu@lists.linux-foundation.org,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
	Andrei Dulea <adulea@amazon.de>
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
From: Andrei Dulea via iommu <iommu@lists.linux-foundation.org>
Reply-To: Andrei Dulea <adulea@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Given an arbitrary pte that is part of a large mapping, this function
returns the first pte of the series (and optionally the mapped size and
number of PTEs)
It will be re-used in a subsequent patch to replace an existing L7
mapping.

Signed-off-by: Andrei Dulea <adulea@amazon.de>
---
 drivers/iommu/amd_iommu.c | 40 ++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c7e28a8d25d1..a227e7a9b8b7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -501,6 +501,29 @@ static void iommu_uninit_device(struct device *dev)
 	 */
 }
 
+/*
+ * Helper function to get the first pte of a large mapping
+ */
+static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
+			 unsigned long *count)
+{
+	unsigned long pte_mask, pg_size, cnt;
+	u64 *fpte;
+
+	pg_size  = PTE_PAGE_SIZE(*pte);
+	cnt      = PAGE_SIZE_PTE_COUNT(pg_size);
+	pte_mask = ~((cnt << 3) - 1);
+	fpte     = (u64 *)(((unsigned long)pte) & pte_mask);
+
+	if (page_size)
+		*page_size = pg_size;
+
+	if (count)
+		*count = cnt;
+
+	return fpte;
+}
+
 /****************************************************************************
  *
  * Interrupt handling functions
@@ -1567,17 +1590,12 @@ static u64 *fetch_pte(struct protection_domain *domain,
 		*page_size = PTE_LEVEL_PAGE_SIZE(level);
 	}
 
-	if (PM_PTE_LEVEL(*pte) == 0x07) {
-		unsigned long pte_mask;
-
-		/*
-		 * If we have a series of large PTEs, make
-		 * sure to return a pointer to the first one.
-		 */
-		*page_size = pte_mask = PTE_PAGE_SIZE(*pte);
-		pte_mask   = ~((PAGE_SIZE_PTE_COUNT(pte_mask) << 3) - 1);
-		pte        = (u64 *)(((unsigned long)pte) & pte_mask);
-	}
+	/*
+	 * If we have a series of large PTEs, make
+	 * sure to return a pointer to the first one.
+	 */
+	if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL)
+		pte = first_pte_l7(pte, page_size, NULL);
 
 	return pte;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
