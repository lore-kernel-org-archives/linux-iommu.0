Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51712C433EF
	for <iommu@archiver.kernel.org>; Sun, 20 Mar 2022 06:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 201AD81A81;
	Sun, 20 Mar 2022 06:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Suc6PJzvRb1T; Sun, 20 Mar 2022 06:42:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B03381A18;
	Sun, 20 Mar 2022 06:42:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4AE8C001A;
	Sun, 20 Mar 2022 06:42:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0923C000B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE50040908
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CaFHujhAHyp9 for <iommu@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 06:42:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D56740905
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647758572; x=1679294572;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hqPz7OA71vKX+4SbCI7310Zl8v9/gzrRYRCnasL1ZjU=;
 b=Bjn9FF/yoAvthFUxPXbfvvotbuh+yEca7RS87LZSgOYiysRZoFhFetJT
 ZndGOlcJ49QRyZB+wstE4mkPYv0z9ZdpRQYBkO1HXMK5Rw96ZTvU8+Vch
 cY72haaq8Gk8/HlG/rnTPbXLQVPYp7Cst/t6P3JILqVHWN2A++d9bxGMY
 Ppuc5t83vfpqoWumJc0OgzfxzSMqN/C1XWH5wP21UYlsVUgZcvhu9mvnz
 B5yYU3RXdNvsWPKZeZvJ0ORFQYKAVt1kE0l1KscDyq2oUYGkeXz80fWWD
 m/QV+VxU1QfsI40Nkx80h86TR6keh3ipkOmu4E2JX4Tc7Ypn+dS19tIq7 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237961398"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="237961398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2022 23:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="691839896"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC 04/11] iommu/vt-d: Add SVA domain support
Date: Sun, 20 Mar 2022 14:40:23 +0800
Message-Id: <20220320064030.2936936-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  1 +
 drivers/iommu/intel/iommu.c | 12 ++++++++++++
 drivers/iommu/intel/svm.c   | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2f9891cb3d00..c14283137fb5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+extern const struct iommu_domain_ops intel_svm_domain_ops;
 
 struct intel_svm_dev {
 	struct list_head list;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c1b91bce1530..d55dca3eacf8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4318,6 +4318,18 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	case IOMMU_DOMAIN_SVA:
+		dmar_domain = alloc_domain(type);
+		if (!dmar_domain) {
+			pr_err("Can't allocate sva domain\n");
+			return NULL;
+		}
+		domain = &dmar_domain->domain;
+		domain->ops = &intel_svm_domain_ops;
+
+		return domain;
+#endif /* CONFIG_INTEL_IOMMU_SVM */
 	default:
 		return NULL;
 	}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ee5ecde5b318..b9f4dd7057d1 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -932,3 +932,37 @@ int intel_svm_page_response(struct device *dev,
 	mutex_unlock(&pasid_mutex);
 	return ret;
 }
+
+static int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct mm_struct *mm = domain->sva_cookie;
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_sva *sva;
+
+	mutex_lock(&pasid_mutex);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
+	mutex_unlock(&pasid_mutex);
+
+	return IS_ERR_OR_NULL(sva);
+}
+
+static void intel_svm_detach_dev_pasid(struct iommu_domain *domain,
+				       struct device *dev, ioasid_t pasid)
+{
+	mutex_lock(&pasid_mutex);
+	intel_svm_unbind_mm(dev, pasid);
+	mutex_unlock(&pasid_mutex);
+}
+
+static void intel_svm_domain_free(struct iommu_domain *domain)
+{
+	kfree(domain);
+}
+
+const struct iommu_domain_ops intel_svm_domain_ops = {
+	.attach_dev_pasid	= intel_svm_attach_dev_pasid,
+	.detach_dev_pasid	= intel_svm_detach_dev_pasid,
+	.free			= intel_svm_domain_free,
+};
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
