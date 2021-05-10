Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD1C43470
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50C66144E
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50C66144E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66C1D839E6;
	Mon, 10 May 2021 06:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4YJhjNCoP8RP; Mon, 10 May 2021 06:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30AB583673;
	Mon, 10 May 2021 06:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C727AC0026;
	Mon, 10 May 2021 06:54:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ECA6C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC62F60A36
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HwkHxWOT-uAG for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 06:54:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9255260B4D
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=vouLh55IquRr56ds5p71M6C9n8Amq3+wvZYp5AFKiIk=; b=xuRn7bkOI4TEy5CW24kUbFyn0h
 0T1OapwVOSjSVhsGEKoJ16Zx9w3+4ymWpItR38qG5IAym5Dxt1YQxC7XoiXQgRIpsLJ9OiE2VjLe0
 0Hm4Lk/jwrqi5yHkisOFoA4d9ss+4BAhvJsNqu4OhSEcq6nr3QvJRkYIyvtUQZO3H/64GLhmCVcRU
 IdPHkhzc8ZWtCQ0oTtA7IZDnuo2rkClCS6sQXN9k2so9jcWZHnfaBVf/by97LZtJOP0YiBmNXMlfY
 RawdNK1YI+Gy3FcfSyCKs0EQnHm2wWfu9FsKuYY8B0xNBuKBlUnD2d8hkkgz9ia+b90tkJtehJQ7w
 HjE8+LTg==;
Received: from [2001:4bb8:198:fbc8:e179:16d2:93d1:8e1] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lfznx-008LoD-5t; Mon, 10 May 2021 06:54:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 2/6] iommu: remove the unused iommu_aux_get_pasid interface
Date: Mon, 10 May 2021 08:54:01 +0200
Message-Id: <20210510065405.2334771-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510065405.2334771-1-hch@lst.de>
References: <20210510065405.2334771-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

This function was never used since it was added more than 2 years ago.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel/iommu.c | 10 ----------
 drivers/iommu/iommu.c       | 11 -----------
 include/linux/iommu.h       |  9 ---------
 3 files changed, 30 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ba1060f6785119..cc07f316adcb18 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5375,15 +5375,6 @@ intel_iommu_dev_feat_enabled(struct device *dev, enum iommu_dev_features feat)
 	return false;
 }
 
-static int
-intel_iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
-{
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-
-	return dmar_domain->default_pasid > 0 ?
-			dmar_domain->default_pasid : -EINVAL;
-}
-
 static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 					   struct device *dev)
 {
@@ -5485,7 +5476,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.detach_dev		= intel_iommu_detach_device,
 	.aux_attach_dev		= intel_iommu_aux_attach_device,
 	.aux_detach_dev		= intel_iommu_aux_detach_device,
-	.aux_get_pasid		= intel_iommu_aux_get_pasid,
 	.map			= intel_iommu_map,
 	.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
 	.unmap			= intel_iommu_unmap,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df50f..6721ac17baf29b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2934,17 +2934,6 @@ void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
 
-int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (domain->ops->aux_get_pasid)
-		ret = domain->ops->aux_get_pasid(domain, dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
-
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1092a7f967a5e8..d8aa5c8a5ba57a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -202,7 +202,6 @@ struct iommu_iotlb_gather {
  *                               iommu specific features.
  * @dev_feat_enabled: check enabled feature
  * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
- * @aux_get_pasid: get the pasid given an aux-domain
  * @sva_bind: Bind process address space to device
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
@@ -262,7 +261,6 @@ struct iommu_ops {
 	/* Aux-domain specific attach/detach entries */
 	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
-	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
 				      void *drvdata);
@@ -594,7 +592,6 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
 int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev);
 void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
-int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
@@ -945,12 +942,6 @@ iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 }
 
-static inline int
-iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
-{
-	return -ENODEV;
-}
-
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
