Return-Path: <SRS0=A2w3=TU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6ACC04AAC
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 14:41:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F54216B7
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 14:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F54216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 517E3BA4;
	Mon, 20 May 2019 14:41:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2355CE80
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 13:43:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B784D81A
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 13:43:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 May 2019 06:43:11 -0700
X-ExtLoop1: 1
Received: from gklab-127-091.igk.intel.com (HELO gklab-125-020.igk.intel.com)
	([10.91.125.20])
	by orsmga004.jf.intel.com with ESMTP; 20 May 2019 06:43:09 -0700
From: Lukasz Odzioba <lukasz.odzioba@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/1] iommu/vt-d: Remove unnecessary rcu_read_locks
Date: Mon, 20 May 2019 15:41:28 +0200
Message-Id: <1558359688-21804-1-git-send-email-lukasz.odzioba@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-Mailman-Approved-At: Mon, 20 May 2019 14:41:11 +0000
Cc: lukasz.odzioba@intel.com, dwmw2@infradead.org
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

We use RCU's for rarely updated lists like iommus, rmrr, atsr units.

I'm not sure why domain_remove_dev_info() in domain_exit() was surrounded
by rcu_read_lock. Lock was present before refactoring in d160aca527,
but it was related to rcu list, not domain_remove_dev_info function.

dmar_remove_one_dev_info() doesn't touch any of those lists, so it doesn't
require a lock. In fact it is called 6 times without it anyway.

Fixes: d160aca5276d ("iommu/vt-d: Unify domain->iommu attach/detachment")

Signed-off-by: Lukasz Odzioba <lukasz.odzioba@intel.com>
---
 drivers/iommu/intel-iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199..1b7ad80 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1911,9 +1911,7 @@ static void domain_exit(struct dmar_domain *domain)
 	struct page *freelist;
 
 	/* Remove associated devices and clear attached or cached domains */
-	rcu_read_lock();
 	domain_remove_dev_info(domain);
-	rcu_read_unlock();
 
 	/* destroy iovas */
 	put_iova_domain(&domain->iovad);
@@ -5254,9 +5252,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 
 		old_domain = find_domain(dev);
 		if (old_domain) {
-			rcu_read_lock();
 			dmar_remove_one_dev_info(dev);
-			rcu_read_unlock();
 
 			if (!domain_type_is_vm_or_si(old_domain) &&
 			    list_empty(&old_domain->devices))
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
