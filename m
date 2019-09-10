Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3192CC49ED9
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D4E2171F
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="MgufWJ00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D4E2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B3D30E3B;
	Tue, 10 Sep 2019 17:50:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 734D9D67
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:50:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
	[207.171.184.29])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 226218A8
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1568137809; x=1599673809;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=mJRW8lKwbthmLc8gotnL669qFNsjqI2ujReZHQn2tbQ=;
	b=MgufWJ00ltEuOEgyB8fXoFS3I+1zziObDzpq6iF4dTvoNi/06GBU/ciV
	vDrmPDMOhZ4tzbf80pp475b/jItaUj9x2LFJjAy7fCDQrfYTQIU26jXmY
	xdIsdVLMff3MnKP+Jp87oGt9QF7UVr5ZoYSlbCawEghk0xp7XlvOd8oL0 g=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; d="scan'208";a="701858197"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO
	email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.38])
	by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
	10 Sep 2019 17:49:51 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com
	(pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
	by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with
	ESMTPS id 87B94A1EC9; Tue, 10 Sep 2019 17:49:48 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
	by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with
	ESMTP id x8AHnk7Z023845; Tue, 10 Sep 2019 19:49:46 +0200
Received: (from sironi@localhost)
	by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id
	x8AHnkE6023839; Tue, 10 Sep 2019 19:49:46 +0200
To: sironi@amazon.de, joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iommu/amd: Hold the domain lock when calling
	domain_flush_tlb[_pde]
Date: Tue, 10 Sep 2019 19:49:25 +0200
Message-Id: <1568137765-20278-6-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568137765-20278-1-git-send-email-sironi@amazon.de>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
Cc: Wei Wang <wawei@amazon.de>
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
From: Filippo Sironi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Filippo Sironi <sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Wei Wang <wawei@amazon.de>

domain_flush_tlb[_pde] traverses the device list, which is protected by
the domain lock.

Signed-off-by: Wei Wang <wawei@amazon.de>
Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/iommu/amd_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3714ae5ded31..f5df23acd1c7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1806,7 +1806,11 @@ static void free_gcr3_table(struct protection_domain *domain)
 
 static void dma_ops_domain_flush_tlb(struct dma_ops_domain *dom)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->domain.lock, flags);
 	domain_flush_tlb(&dom->domain);
+	spin_unlock_irqrestore(&dom->domain.lock, flags);
 	domain_flush_complete(&dom->domain);
 }
 
@@ -2167,7 +2171,9 @@ static int attach_device(struct device *dev,
 	 * left the caches in the IOMMU dirty. So we have to flush
 	 * here to evict all dirty stuff.
 	 */
+	spin_lock_irqsave(&domain->lock, flags);
 	domain_flush_tlb_pde(domain);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	domain_flush_complete(domain);
 
@@ -3245,8 +3251,11 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
 
+	spin_lock_irqsave(&dom->lock, flags);
 	domain_flush_tlb_pde(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
 	domain_flush_complete(dom);
 }
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
