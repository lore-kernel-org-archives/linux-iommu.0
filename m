Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA61C433DB
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 12:56:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E976223447
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 12:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E976223447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6FACC204E6;
	Tue, 12 Jan 2021 12:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sooFt+F8lxVT; Tue, 12 Jan 2021 12:56:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 451A7204AE;
	Tue, 12 Jan 2021 12:56:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E319C0893;
	Tue, 12 Jan 2021 12:56:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1CF8C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 12:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9DBBC85AE4
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 12:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPntZz4L7ZRA for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:56:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 14B8C85A37
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 12:56:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C719C2333D;
 Tue, 12 Jan 2021 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610456197;
 bh=zLYawgbkxTGvzeINYqmnu2PERnl3cvpEaR0b/BUkCDA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l66f19BeB76GRBoCMvC7bMI3PlTsCgW0V7KMc1JVg/uU1KR+jnlDacG5dcEUUPRDS
 ElC9MePLgd2a916CB0urItgjAFunmDFuzXu15aSn0u3rPDZ2gyNAhuJZqIfxEpJDDR
 JaJF7/IrkR0g3xpjXUtf8T7Qc0m9yqQO7eHkSqiTgd0d+sRz5J2rClwHaRRzdy6NJY
 JwPoDpgR70ScTNhzsK3p/eZLqx4Wu5I+mngjDPstAQ7Ca291qeuFai+JgltORzsz06
 ItT3ev9kJVQeV4zdOG+NrxZ9gKpbLmYLMaZXmRfwWIl+i95vQMjO8fwuJCqiVaOIz8
 bYsXjs3VUxicg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 47/51] iommu/vt-d: Fix lockdep splat in sva
 bind()/unbind()
Date: Tue, 12 Jan 2021 07:55:29 -0500
Message-Id: <20210112125534.70280-47-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125534.70280-1-sashal@kernel.org>
References: <20210112125534.70280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 420d42f6f9db27d88bc4f83e3e668fcdacbf7e29 ]

Lock(&iommu->lock) without disabling irq causes lockdep warnings.

========================================================
WARNING: possible irq lock inversion dependency detected
5.11.0-rc1+ #828 Not tainted
--------------------------------------------------------
kworker/0:1H/120 just changed the state of lock:
ffffffffad9ea1b8 (device_domain_lock){..-.}-{2:2}, at:
iommu_flush_dev_iotlb.part.0+0x32/0x120
but this lock took another, SOFTIRQ-unsafe lock in the past:
 (&iommu->lock){+.+.}-{2:2}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&iommu->lock);
                               local_irq_disable();
                               lock(device_domain_lock);
                               lock(&iommu->lock);
  <Interrupt>
    lock(device_domain_lock);

 *** DEADLOCK ***

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20201231005323.2178523-5-baolu.lu@linux.intel.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/svm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3242ebd0bca36..267001e8076cd 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -281,6 +281,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	struct dmar_domain *dmar_domain;
 	struct device_domain_info *info;
 	struct intel_svm *svm = NULL;
+	unsigned long iflags;
 	int ret = 0;
 
 	if (WARN_ON(!iommu) || !data)
@@ -381,12 +382,12 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	 * each bind of a new device even with an existing PASID, we need to
 	 * call the nested mode setup function here.
 	 */
-	spin_lock(&iommu->lock);
+	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_nested(iommu, dev,
 				       (pgd_t *)(uintptr_t)data->gpgd,
 				       data->hpasid, &data->vendor.vtd, dmar_domain,
 				       data->addr_width);
-	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&iommu->lock, iflags);
 	if (ret) {
 		dev_err_ratelimited(dev, "Failed to set up PASID %llu in nested mode, Err %d\n",
 				    data->hpasid, ret);
@@ -486,6 +487,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
+	unsigned long iflags;
 	int pasid_max;
 	int ret;
 
@@ -605,14 +607,14 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 			}
 		}
 
-		spin_lock(&iommu->lock);
+		spin_lock_irqsave(&iommu->lock, iflags);
 		ret = intel_pasid_setup_first_level(iommu, dev,
 				mm ? mm->pgd : init_mm.pgd,
 				svm->pasid, FLPT_DEFAULT_DID,
 				(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
 				(cpu_feature_enabled(X86_FEATURE_LA57) ?
 				 PASID_FLAG_FL5LP : 0));
-		spin_unlock(&iommu->lock);
+		spin_unlock_irqrestore(&iommu->lock, iflags);
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
@@ -632,14 +634,14 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		 * Binding a new device with existing PASID, need to setup
 		 * the PASID entry.
 		 */
-		spin_lock(&iommu->lock);
+		spin_lock_irqsave(&iommu->lock, iflags);
 		ret = intel_pasid_setup_first_level(iommu, dev,
 						mm ? mm->pgd : init_mm.pgd,
 						svm->pasid, FLPT_DEFAULT_DID,
 						(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
 						(cpu_feature_enabled(X86_FEATURE_LA57) ?
 						PASID_FLAG_FL5LP : 0));
-		spin_unlock(&iommu->lock);
+		spin_unlock_irqrestore(&iommu->lock, iflags);
 		if (ret) {
 			kfree(sdev);
 			goto out;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
