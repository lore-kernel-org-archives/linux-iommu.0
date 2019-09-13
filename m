Return-Path: <SRS0=dyvA=XI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF123C49ED7
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 15:11:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A7120640
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="q7QDqhLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A7120640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2A448B0B;
	Fri, 13 Sep 2019 15:11:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 586981000
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:42:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
	[207.171.184.29])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0512A7D2
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1568385772; x=1599921772;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=i/PRMXkTFAccxRqjG+XQ5gD2K3ic7ThMmrOGqVw+YYo=;
	b=q7QDqhLUyiHP5WuRajKtB5a5wpx/eXETkO45sq8vwijfVklECNMmofvD
	QwTJi5ta21UpXLNlZTFjva14g2SVofqtPcpPZ1DnG9ENUbAX0NhAC3tTt
	FwR+tKNSHd/j/GzQ9epTDeWLMLKElTMSeHUaQTJZ+IT2Nl1WBkoB2W8Iy k=;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; d="scan'208";a="702310561"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO
	email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.38])
	by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
	13 Sep 2019 14:42:45 +0000
Received: from u793be3441f0353.ant.amazon.com
	(pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
	by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with
	ESMTPS id 54A26A1887; Fri, 13 Sep 2019 14:42:40 +0000 (UTC)
Received: from u793be3441f0353.ant.amazon.com (localhost [127.0.0.1])
	by u793be3441f0353.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS
	id x8DEgdVl021472
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2019 16:42:39 +0200
Received: (from adulea@localhost)
	by u793be3441f0353.ant.amazon.com (8.15.2/8.15.2/Submit) id
	x8DEgcks021471; Fri, 13 Sep 2019 16:42:38 +0200
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/4] iommu/amd: Fix pages leak in free_pagetable()
Date: Fri, 13 Sep 2019 16:42:28 +0200
Message-Id: <20190913144231.21382-2-adulea@amazon.de>
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

Take into account the gathered freelist in free_sub_pt(), otherwise we
end up leaking all that pages.

Fixes: 409afa44f9ba ("iommu/amd: Introduce free_sub_pt() function")
Signed-off-by: Andrei Dulea <adulea@amazon.de>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1ed3b98324ba..138547446345 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1425,7 +1425,7 @@ static void free_pagetable(struct protection_domain *domain)
 	BUG_ON(domain->mode < PAGE_MODE_NONE ||
 	       domain->mode > PAGE_MODE_6_LEVEL);
 
-	free_sub_pt(root, domain->mode, freelist);
+	freelist = free_sub_pt(root, domain->mode, freelist);
 
 	free_page_list(freelist);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
