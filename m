Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B3AC433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 01:38:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B8220709
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 01:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B8220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 24ACD88560;
	Tue, 19 May 2020 01:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qgdqe59BEPAb; Tue, 19 May 2020 01:38:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6701087F38;
	Tue, 19 May 2020 01:38:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ACD1C0888;
	Tue, 19 May 2020 01:38:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E250C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 756F4878D8
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:37:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eDS8d7vJ9Kao for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 01:37:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 85720878D6
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:37:58 +0000 (UTC)
IronPort-SDR: fKL5gKZtFqMUpBBhT0lkW3WSnX2/MKWyMeIuQ8i1S8BPYoehBTGbd1bRFOaMo43JMIPLNkH9hG
 61Um95qYY78g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2020 18:37:58 -0700
IronPort-SDR: 08Zoy6VJfj7+PSjyF5Msqo9aqhYBDlmVjTYZkKCU+0dqBRcC/+34Vnu50Ne7ZQweTuII59jWsi
 UfriBrzrx/ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; d="scan'208";a="288784810"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 18:37:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix pointer cast warnings on 32 bit
Date: Tue, 19 May 2020 09:34:23 +0800
Message-Id: <20200519013423.11971-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org
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

Pointers should be casted to unsigned long to avoid "cast from pointer
to integer of different size" warnings.

drivers/iommu/intel-pasid.c:818:6: warning:
    cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/iommu/intel-pasid.c:821:9: warning:
    cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/iommu/intel-pasid.c:824:23: warning:
    cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/iommu/intel-svm.c:343:45: warning:
    cast to pointer from integer of different size [-Wint-to-pointer-cast]

Fixes: d64d47f4f5678 ("iommu/vt-d: Add nested translation helper function")
Fixes: a3bea1a35c083 ("iommu/vt-d: Add bind guest PASID support")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 8 ++++----
 drivers/iommu/intel-svm.c   | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 25d749830500..c81f0f17c6ba 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -815,13 +815,13 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	}
 
 	/* First level PGD is in GPA, must be supported by the second level */
-	if ((unsigned long long)gpgd > domain->max_addr) {
+	if ((uintptr_t)gpgd > domain->max_addr) {
 		dev_err_ratelimited(dev,
-				    "Guest PGD %llx not supported, max %llx\n",
-				    (unsigned long long)gpgd, domain->max_addr);
+				    "Guest PGD %lx not supported, max %llx\n",
+				    (uintptr_t)gpgd, domain->max_addr);
 		return -EINVAL;
 	}
-	pasid_set_flptr(pte, (u64)gpgd);
+	pasid_set_flptr(pte, (uintptr_t)gpgd);
 
 	ret = intel_pasid_setup_bind_data(iommu, pte, pasid_data);
 	if (ret)
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 11366dc91971..acc7555b002d 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -340,7 +340,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	 * call the nested mode setup function here.
 	 */
 	spin_lock(&iommu->lock);
-	ret = intel_pasid_setup_nested(iommu, dev, (pgd_t *)data->gpgd,
+	ret = intel_pasid_setup_nested(iommu, dev,
+				       (pgd_t *)(uintptr_t)data->gpgd,
 				       data->hpasid, &data->vtd, dmar_domain,
 				       data->addr_width);
 	spin_unlock(&iommu->lock);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
