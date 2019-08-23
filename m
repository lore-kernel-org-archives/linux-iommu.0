Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE25C3A5A1
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 02:47:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2B621897
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 02:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2B621897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 34C2712C3;
	Fri, 23 Aug 2019 02:47:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 97C78D85
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 02:46:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A1EE789E
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 02:46:57 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 1DF7C88E4DAE3FF3267F;
	Fri, 23 Aug 2019 10:46:55 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
	DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server
	id 14.3.439.0; Fri, 23 Aug 2019 10:46:48 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, John Garry
	<john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
	<will@kernel.org>, Joerg Roedel <joro@8bytes.org>, iommu
	<iommu@lists.linux-foundation.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/2] iommu/arm-smmu-v3: change the lock type of
	arm_smmu_domain.devices_lock
Date: Fri, 23 Aug 2019 10:45:51 +0800
Message-ID: <20190823024551.24448-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190823024551.24448-1-thunder.leizhen@huawei.com>
References: <20190823024551.24448-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

A master add into or remove from smmu_domain->devices only happened in
arm_smmu_attach_dev()/arm_smmu_detach_dev(), the frequency of these
operations is very low. But we traverse smmu_domain->devices list in
arm_smmu_atc_inv_domain() are frequent. So change the protection from
spinlock to rwlock can improve concurrency, especially for the smmu
domain without ATS masters.

By the way, the cmdq has its own lock, so this change is safe.

Here is the performance data tested on my board:
Before:
Jobs: 24 (f=24): [0.1% done] [9798M/0K /s] [2392K/0  iops] [09h:59m:13s]
Jobs: 24 (f=24): [0.1% done] [9782M/0K /s] [2388K/0  iops] [09h:59m:12s]
Jobs: 24 (f=24): [0.2% done] [9825M/0K /s] [2399K/0  iops] [09h:59m:11s]
Jobs: 24 (f=24): [0.2% done] [9836M/0K /s] [2401K/0  iops] [09h:59m:10s]

After:
Jobs: 24 (f=24): [0.1% done] [10996M/0K /s] [2685K/0  iops] [09h:59m:13s]
Jobs: 24 (f=24): [0.1% done] [10817M/0K /s] [2641K/0  iops] [09h:59m:12s]
Jobs: 24 (f=24): [0.2% done] [11083M/0K /s] [2706K/0  iops] [09h:59m:11s]
Jobs: 24 (f=24): [0.2% done] [10603M/0K /s] [2589K/0  iops] [09h:59m:10s]

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Suggested-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e0dcc5d27291f8b..eded2e7a5a0c444 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -641,7 +641,7 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 
 	struct list_head		devices;
-	spinlock_t			devices_lock;
+	rwlock_t			devices_lock;
 };
 
 struct arm_smmu_option_prop {
@@ -1536,10 +1536,10 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	read_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head)
 		ret |= arm_smmu_atc_inv_master(master, &cmd);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	read_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	return ret ? -ETIMEDOUT : 0;
 }
@@ -1648,7 +1648,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->devices);
-	spin_lock_init(&smmu_domain->devices_lock);
+	rwlock_init(&smmu_domain->devices_lock);
 
 	return &smmu_domain->domain;
 }
@@ -1911,9 +1911,9 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	if (!smmu_domain)
 		return;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	write_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	write_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	master->domain = NULL;
 	arm_smmu_install_ste_for_dev(master);
@@ -1966,9 +1966,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	arm_smmu_install_ste_for_dev(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	write_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_add(&master->domain_head, &smmu_domain->devices);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	write_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
