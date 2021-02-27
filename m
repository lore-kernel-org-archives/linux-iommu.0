Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E2CC433E0
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9566564E55
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9566564E55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51F1A4F078;
	Sun, 28 Feb 2021 06:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rT_mXJ_xLfNN; Sun, 28 Feb 2021 06:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED0B84F0A6;
	Sun, 28 Feb 2021 06:33:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEC32C000E;
	Sun, 28 Feb 2021 06:33:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B99BC000B
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4E864F0A4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tGvqBH3OKbVP for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E56534F063
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:10 +0000 (UTC)
IronPort-SDR: J7RQTTt7Y0TjcUv/ygzkzc+eGKFZH69BWjV1K2gt1W4VcW8lFZrc4IktOdpdWi3dYw0ZNKNhTE
 RBTIUvN1+3gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="183755898"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="183755898"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:09 -0800
IronPort-SDR: hnVkePC/wEnT+/HL2gHIbAQbFByil5YHx+ktvhwo4sg34QFPUG9YGQGxrJ6ncZRA7lZHesKh0c
 ect8uTsA01Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029700"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V4 02/18] iommu/ioasid: Rename ioasid_set_data()
Date: Sat, 27 Feb 2021 14:01:10 -0800
Message-Id: <1614463286-97618-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Wu Hao <hao.wu@intel.com>
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

Rename ioasid_set_data() to ioasid_attach_data() to avoid confusion with
struct ioasid_set. ioasid_set is a group of IOASIDs that share a common
token.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 6 +++---
 drivers/iommu/ioasid.c    | 6 +++---
 include/linux/ioasid.h    | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 18a9f05df407..0053df9edffc 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -371,7 +371,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
-		ioasid_set_data(data->hpasid, svm);
+		ioasid_attach_data(data->hpasid, svm);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 		mmput(svm->mm);
 	}
@@ -425,7 +425,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
 	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
-		ioasid_set_data(data->hpasid, NULL);
+		ioasid_attach_data(data->hpasid, NULL);
 		kfree(svm);
 	}
 
@@ -468,7 +468,7 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_set_data(pasid, NULL);
+				ioasid_attach_data(pasid, NULL);
 				kfree(svm);
 			}
 		}
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 50ee27bbd04e..eeadf4586e0a 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -259,14 +259,14 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
 EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
 
 /**
- * ioasid_set_data - Set private data for an allocated ioasid
+ * ioasid_attach_data - Set private data for an allocated ioasid
  * @ioasid: the ID to set data
  * @data:   the private data
  *
  * For IOASID that is already allocated, private data can be set
  * via this API. Future lookup can be done via ioasid_find.
  */
-int ioasid_set_data(ioasid_t ioasid, void *data)
+int ioasid_attach_data(ioasid_t ioasid, void *data)
 {
 	struct ioasid_data *ioasid_data;
 	int ret = 0;
@@ -288,7 +288,7 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ioasid_set_data);
+EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
 /**
  * ioasid_alloc - Allocate an IOASID
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e9dacd4b9f6b..60ea279802b8 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
-int ioasid_set_data(ioasid_t ioasid, void *data);
+int ioasid_attach_data(ioasid_t ioasid, void *data);
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -73,7 +73,7 @@ static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allo
 {
 }
 
-static inline int ioasid_set_data(ioasid_t ioasid, void *data)
+static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 {
 	return -ENOTSUPP;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
