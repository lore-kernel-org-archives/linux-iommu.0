Return-Path: <SRS0=zl4V=TD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4BFC43219
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 22:31:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DE12075C
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 22:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DE12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 48DCF3E38;
	Fri,  3 May 2019 22:30:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A59703E21
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 22:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 26BEF876
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 22:29:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 May 2019 15:29:33 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 03 May 2019 15:29:33 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v3 13/16] iommu/vt-d: Clean up for SVM device list
Date: Fri,  3 May 2019 15:32:14 -0700
Message-Id: <1556922737-76313-14-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Use combined macro for_each_svm_dev() to simplify SVM device iteration.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-svm.c | 79 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 8fff212..068dd9e 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -227,6 +227,9 @@ static const struct mmu_notifier_ops intel_mmuops = {
 
 static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
+#define for_each_svm_dev() \
+	list_for_each_entry(sdev, &svm->devs, list)	\
+	if (dev == sdev->dev)				\
 
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
@@ -273,15 +276,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 				goto out;
 			}
 
-			list_for_each_entry(sdev, &svm->devs, list) {
-				if (dev == sdev->dev) {
-					if (sdev->ops != ops) {
-						ret = -EBUSY;
-						goto out;
-					}
-					sdev->users++;
-					goto success;
+			for_each_svm_dev() {
+				if (sdev->ops != ops) {
+					ret = -EBUSY;
+					goto out;
 				}
+				sdev->users++;
+				goto success;
 			}
 
 			break;
@@ -411,40 +412,38 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!svm)
 		goto out;
 
-	list_for_each_entry(sdev, &svm->devs, list) {
-		if (dev == sdev->dev) {
-			ret = 0;
-			sdev->users--;
-			if (!sdev->users) {
-				list_del_rcu(&sdev->list);
-				/* Flush the PASID cache and IOTLB for this device.
-				 * Note that we do depend on the hardware *not* using
-				 * the PASID any more. Just as we depend on other
-				 * devices never using PASIDs that they have no right
-				 * to use. We have a *shared* PASID table, because it's
-				 * large and has to be physically contiguous. So it's
-				 * hard to be as defensive as we might like. */
-				intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
-				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
-				kfree_rcu(sdev, rcu);
-
-				if (list_empty(&svm->devs)) {
-					ioasid_free(svm->pasid);
-					if (svm->mm)
-						mmu_notifier_unregister(&svm->notifier, svm->mm);
-
-					list_del(&svm->list);
-
-					/* We mandate that no page faults may be outstanding
-					 * for the PASID when intel_svm_unbind_mm() is called.
-					 * If that is not obeyed, subtle errors will happen.
-					 * Let's make them less subtle... */
-					memset(svm, 0x6b, sizeof(*svm));
-					kfree(svm);
-				}
+	for_each_svm_dev() {
+		ret = 0;
+		sdev->users--;
+		if (!sdev->users) {
+			list_del_rcu(&sdev->list);
+			/* Flush the PASID cache and IOTLB for this device.
+			 * Note that we do depend on the hardware *not* using
+			 * the PASID any more. Just as we depend on other
+			 * devices never using PASIDs that they have no right
+			 * to use. We have a *shared* PASID table, because it's
+			 * large and has to be physically contiguous. So it's
+			 * hard to be as defensive as we might like. */
+			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
+			kfree_rcu(sdev, rcu);
+
+			if (list_empty(&svm->devs)) {
+				ioasid_free(svm->pasid);
+				if (svm->mm)
+					mmu_notifier_unregister(&svm->notifier, svm->mm);
+
+				list_del(&svm->list);
+
+				/* We mandate that no page faults may be outstanding
+				 * for the PASID when intel_svm_unbind_mm() is called.
+				 * If that is not obeyed, subtle errors will happen.
+				 * Let's make them less subtle... */
+				memset(svm, 0x6b, sizeof(*svm));
+				kfree(svm);
 			}
-			break;
 		}
+		break;
 	}
  out:
 	mutex_unlock(&pasid_mutex);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
