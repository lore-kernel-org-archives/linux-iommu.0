Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841CC48BCF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 12:49:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD91613AD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 12:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD91613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7420983C63;
	Wed,  9 Jun 2021 12:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AvsmifhbqAi8; Wed,  9 Jun 2021 12:49:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D717983C61;
	Wed,  9 Jun 2021 12:49:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5535C000D;
	Wed,  9 Jun 2021 12:49:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D322CC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 12:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C09D583C63
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 12:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aUCjzkszAcfw for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 12:49:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9325F83C61
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 12:49:46 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0RdY3ZbtzWtQ8;
 Wed,  9 Jun 2021 20:44:49 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:49:41 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:49:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, iommu <iommu@lists.linux-foundation.org>
Subject: [PATCH 1/1] iommu/vt-d: remove unnecessary oom message
Date: Wed, 9 Jun 2021 20:49:37 +0800
Message-ID: <20210609124937.14260-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/intel/dmar.c  | 2 --
 drivers/iommu/intel/iommu.c | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 84057cb9596c..ede7525b4ec3 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -148,8 +148,6 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 	} else {
 		info = kzalloc(size, GFP_KERNEL);
 		if (!info) {
-			pr_warn("Out of memory when allocating notify_info "
-				"for %s.\n", pci_name(dev));
 			if (dmar_dev_scope_status == 0)
 				dmar_dev_scope_status = -ENOMEM;
 			return NULL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..432f4019d1af 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1780,11 +1780,8 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	spin_lock_init(&iommu->lock);
 
 	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
-	if (!iommu->domain_ids) {
-		pr_err("%s: Allocating domain id array failed\n",
-		       iommu->name);
+	if (!iommu->domain_ids)
 		return -ENOMEM;
-	}
 
 	size = (ALIGN(ndomains, 256) >> 8) * sizeof(struct dmar_domain **);
 	iommu->domains = kzalloc(size, GFP_KERNEL);
@@ -3220,7 +3217,6 @@ static int __init init_dmars(void)
 	g_iommus = kcalloc(g_num_of_iommus, sizeof(struct intel_iommu *),
 			GFP_KERNEL);
 	if (!g_iommus) {
-		pr_err("Allocating global iommu array failed\n");
 		ret = -ENOMEM;
 		goto error;
 	}
-- 
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
