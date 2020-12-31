Return-Path: <SRS0=YAC4=GD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD0C433E0
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 01:01:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9BD221FA
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 01:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9BD221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D8621873AA;
	Thu, 31 Dec 2020 01:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFRVS+CWAnIV; Thu, 31 Dec 2020 01:01:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 48E2A873A4;
	Thu, 31 Dec 2020 01:01:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43493C088B;
	Thu, 31 Dec 2020 01:01:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCADC013A
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 00BA42E0E4
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LRdCstr-WOHG for <iommu@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 01:01:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id B63022E0ED
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:36 +0000 (UTC)
IronPort-SDR: t06wTdd3EkVjNHsFkJ+ztztxz74FqCCJl9f1VNM6DBruN+C6Gf2UpnAXaf+WRYLEBK5qswjY2U
 2P7ZVj59Vxsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="176754133"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; d="scan'208";a="176754133"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2020 17:01:34 -0800
IronPort-SDR: VdyohXsM6+r+Lq5nvwH1B+WPcRdmYY9BkbiYe3k1ia9uo79YSHrJku1qlQwrqrvIGe+aa0J5dc
 CS7cH9fsZ4Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; d="scan'208";a="460676257"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 5/5] iommu/vt-d: Fix lockdep splat in sva bind()/unbind()
Date: Thu, 31 Dec 2020 08:53:23 +0800
Message-Id: <20201231005323.2178523-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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
---
 drivers/iommu/intel/svm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b16a4791acfb..18a9f05df407 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -299,6 +299,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	struct dmar_domain *dmar_domain;
 	struct device_domain_info *info;
 	struct intel_svm *svm = NULL;
+	unsigned long iflags;
 	int ret = 0;
 
 	if (WARN_ON(!iommu) || !data)
@@ -400,12 +401,12 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
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
@@ -505,6 +506,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
+	unsigned long iflags;
 	int pasid_max;
 	int ret;
 
@@ -624,14 +626,14 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
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
@@ -651,14 +653,14 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
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
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
