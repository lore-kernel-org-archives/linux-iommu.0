Return-Path: <SRS0=dyvA=XI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E6C49ED7
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 15:11:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF1720640
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="CdvwWiCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF1720640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6FC76104C;
	Fri, 13 Sep 2019 15:11:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AEB981000
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:43:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
	[207.171.190.10])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56B4883A
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1568385804; x=1599921804;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=ge4JMUNYcl1NX3zrCgT+4TVWb0y0wjcwfNAxsIUa28g=;
	b=CdvwWiCYA/9l+0Rhas9y6j7GldvOf3lbY9PnPZsZ3WXAfTDdp+Cw3U+6
	zxeKmrYUDljm+blBa2qsBTMLpZDe6DKy9zTKRMYwzyXHPPxcQ6K0M5xzp
	VA8nSjCnQqRk/o/Jqmn+LrHwR+xi3ZQmg6oWN5PFuogHSG1bFcc1KVI0f 8=;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; d="scan'208";a="831626040"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO
	email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.22.34])
	by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
	13 Sep 2019 14:42:42 +0000
Received: from u793be3441f0353.ant.amazon.com
	(pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
	by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with
	ESMTPS id 7FE93A200C; Fri, 13 Sep 2019 14:42:42 +0000 (UTC)
Received: from u793be3441f0353.ant.amazon.com (localhost [127.0.0.1])
	by u793be3441f0353.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS
	id x8DEgevs021497
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2019 16:42:40 +0200
Received: (from adulea@localhost)
	by u793be3441f0353.ant.amazon.com (8.15.2/8.15.2/Submit) id
	x8DEgeb2021496; Fri, 13 Sep 2019 16:42:40 +0200
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/4] iommu/amd: Unmap all L7 PTEs when downgrading page-sizes
Date: Fri, 13 Sep 2019 16:42:31 +0200
Message-Id: <20190913144231.21382-5-adulea@amazon.de>
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

When replacing a large mapping created with page-mode 7 (i.e.
non-default page size), tear down the entire series of replicated PTEs.
Besides providing access to the old mapping, another thing that might go
wrong with this issue is on the fetch_pte() code path that can return a
PDE entry of the newly re-mapped range.

While at it, make sure that we flush the TLB in case alloc_pte() fails
and returns NULL at a lower level.

Fixes: 6d568ef9a622 ("iommu/amd: Allow downgrading page-sizes in alloc_pte()")
Signed-off-by: Andrei Dulea <adulea@amazon.de>
---
 drivers/iommu/amd_iommu.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a227e7a9b8b7..fda9923542c9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1512,10 +1512,32 @@ static u64 *alloc_pte(struct protection_domain *domain,
 		__pte     = *pte;
 		pte_level = PM_PTE_LEVEL(__pte);
 
-		if (!IOMMU_PTE_PRESENT(__pte) ||
-		    pte_level == PAGE_MODE_NONE ||
+		/*
+		 * If we replace a series of large PTEs, we need
+		 * to tear down all of them.
+		 */
+		if (IOMMU_PTE_PRESENT(__pte) &&
 		    pte_level == PAGE_MODE_7_LEVEL) {
+			unsigned long count, i;
+			u64 *lpte;
+
+			lpte = first_pte_l7(pte, NULL, &count);
+
+			/*
+			 * Unmap the replicated PTEs that still match the
+			 * original large mapping
+			 */
+			for (i = 0; i < count; ++i)
+				cmpxchg64(&lpte[i], __pte, 0ULL);
+
+			domain->updated = true;
+			continue;
+		}
+
+		if (!IOMMU_PTE_PRESENT(__pte) ||
+		    pte_level == PAGE_MODE_NONE) {
 			page = (u64 *)get_zeroed_page(gfp);
+
 			if (!page)
 				return NULL;
 
@@ -1646,8 +1668,10 @@ static int iommu_map_page(struct protection_domain *dom,
 	count = PAGE_SIZE_PTE_COUNT(page_size);
 	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp);
 
-	if (!pte)
+	if (!pte) {
+		update_domain(dom);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < count; ++i)
 		freelist = free_clear_pte(&pte[i], pte[i], freelist);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
