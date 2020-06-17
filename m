Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F2C433E1
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479C5217BA
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479C5217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1CDFC2155C;
	Wed, 17 Jun 2020 18:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksKyrfnkXhep; Wed, 17 Jun 2020 18:24:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7651022001;
	Wed, 17 Jun 2020 18:24:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6161EC08A7;
	Wed, 17 Jun 2020 18:24:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0CF6C0863
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BCFC0873D6
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qFtOvAxA9Yxe for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 18:24:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7132E8757C
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:15 +0000 (UTC)
IronPort-SDR: 5ELibAnbYE5oEavPejBF1l7jRs3t3eDPd5+DJTf35Q4P0x5hsMHaZ9ksfPUDIKl+IT53ZCqyPD
 0Wt6ONTYiD2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 11:24:15 -0700
IronPort-SDR: LcoPq0c48x17JS0rxsa8AWZ6uhU+zz4Hf4xIxQM+83snMxY+jAznwPlghheKk9kJ2oTiwgOKsZ
 TL97BHIxndvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; d="scan'208";a="308874153"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga008.jf.intel.com with ESMTP; 17 Jun 2020 11:24:14 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "H Peter Anvin" <hpa@zytor.com>, "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradeed.org>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v3 03/13] iommu/vt-d: Change flags type to unsigned int in
 binding mm
Date: Wed, 17 Jun 2020 11:23:43 -0700
Message-Id: <1592418233-17762-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

"flags" passed to intel_svm_bind_mm() is a bit mask and should be
defined as "unsigned int" instead of "int".

Change its type to "unsigned int".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Add this new patch per Thomas' comment.

 drivers/iommu/intel/svm.c   | 7 ++++---
 include/linux/intel-iommu.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b5618341b4b1..4e775e12ae52 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -427,7 +427,8 @@ int intel_svm_unbind_gpasid(struct device *dev, unsigned int pasid)
 
 /* Caller must hold pasid_mutex, mm reference */
 static int
-intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
+intel_svm_bind_mm(struct device *dev, unsigned int flags,
+		  struct svm_dev_ops *ops,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
@@ -954,7 +955,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_sva *sva = ERR_PTR(-EINVAL);
 	struct intel_svm_dev *sdev = NULL;
-	int flags = 0;
+	unsigned int flags = 0;
 	int ret;
 
 	/*
@@ -963,7 +964,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 	 * and intel_svm etc.
 	 */
 	if (drvdata)
-		flags = *(int *)drvdata;
+		flags = *(unsigned int *)drvdata;
 	mutex_lock(&pasid_mutex);
 	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
 	if (ret)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 44fa8879f829..9abc30cf10fc 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -759,7 +759,7 @@ struct intel_svm {
 	struct mm_struct *mm;
 
 	struct intel_iommu *iommu;
-	int flags;
+	unsigned int flags;
 	unsigned int pasid;
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
