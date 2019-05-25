Return-Path: <SRS0=lyO4=TZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF4C282CE
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:50:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CEB21848
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CEB21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C08D9DBC;
	Sat, 25 May 2019 05:49:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DDDD7DAC
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4E61FA9
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:49:10 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 May 2019 22:49:09 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:49:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 11/15] iommu/vt-d: Implement is_attach_deferred iommu ops
	entry
Date: Sat, 25 May 2019 13:41:32 +0800
Message-Id: <20190525054136.27810-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com,
	tmurphy@arista.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

As a domain is now attached to a device earlier, we should
implement the is_attach_deferred call-back and use it to
defer the domain attach from iommu driver init to device
driver init when iommu is pre-enabled in kdump kernel.

Suggested-by: Tom Murphy <tmurphy@arista.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7f9cf9188f5f..b93d328fcceb 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -352,6 +352,8 @@ static void domain_context_clear(struct intel_iommu *iommu,
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu);
 static bool device_is_rmrr_locked(struct device *dev);
+static int intel_iommu_attach_device(struct iommu_domain *domain,
+				     struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
 int dmar_disabled = 0;
@@ -381,6 +383,7 @@ int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
 #define DUMMY_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-1))
+#define DEFER_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-2))
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
@@ -2434,8 +2437,18 @@ static struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
+	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO)) {
+		struct iommu_domain *domain;
+
+		dev->archdata.iommu = NULL;
+		domain = iommu_get_domain_for_dev(dev);
+		if (domain)
+			intel_iommu_attach_device(domain, dev);
+	}
+
 	/* No lock here, assumes no domain exit in normal case */
 	info = dev->archdata.iommu;
+
 	if (likely(info))
 		return info->domain;
 	return NULL;
@@ -5527,6 +5540,9 @@ static int intel_iommu_add_device(struct device *dev)
 
 	iommu_device_link(&iommu->iommu, dev);
 
+	if (translation_pre_enabled(iommu))
+		dev->archdata.iommu = DEFER_DEVICE_DOMAIN_INFO;
+
 	group = iommu_group_get_for_dev(dev);
 
 	if (IS_ERR(group))
@@ -5869,6 +5885,12 @@ intel_iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 			dmar_domain->default_pasid : -EINVAL;
 }
 
+static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
+					   struct device *dev)
+{
+	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5891,6 +5913,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
+	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
