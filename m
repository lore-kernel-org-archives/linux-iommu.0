Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F3CC4167D
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E268416B6;
	Wed, 18 May 2022 18:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RNRzZYaY2Y-A; Wed, 18 May 2022 18:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD499416B7;
	Wed, 18 May 2022 18:17:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEF22C0086;
	Wed, 18 May 2022 18:17:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 102F9C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A34561247
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q_XUMGdEjSqg for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:17:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5615761245
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652897855; x=1684433855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hrkDrSmygZqDJVCbXXXzX8LyYOgqsByefLY3F+S5ueg=;
 b=lPmdVDi16p5wrCTNQ2zw/UZ58Mfw9EbQpDdplCf0ejtj1RVg9jVchPzn
 ZPuwwdMNVuHRQzkw7blitQqMWN1g4QBsKQy3ItRYK6jl3Z01z+EM/BRfa
 BXF/V4TadQd26p551o/AgjKQSv5AKI1RNpThz2CIvLOjzyaCZex8Qu1ZV
 MRxp5sTaGNdZLDLsrbmljyBAMPlnn21wI8msYHNvB5El1Km5NzSr2Ye6I
 Pi7ci86BFR9YVZhWGoLAn3Q591KuFocE12Py7UjVra7DgNTUPLl+U5chu
 NlAtjbygLA5U5gWPrwfGQd9rfGr4H/VX+yhLBzvypycaEX7z9glk9tRuL g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259392423"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="259392423"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 11:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="639405499"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
 robin.murphy@arm.com, will@kernel.org
Subject: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Date: Wed, 18 May 2022 11:21:16 -0700
Message-Id: <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>
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

IOMMU group maintains a PASID array which stores the associated IOMMU
domains. This patch introduces a helper function to do domain to PASID
look up. It will be used by TLB flush and device-PASID attach verification.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
 include/linux/iommu.h |  6 +++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 00d0262a1fe9..22f44833db64 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3199,3 +3199,25 @@ struct iommu_domain *iommu_get_domain_for_iopf(struct device *dev,
 
 	return domain;
 }
+
+ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)
+{
+	struct iommu_domain *tdomain;
+	struct iommu_group *group;
+	unsigned long index;
+	ioasid_t pasid = INVALID_IOASID;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return pasid;
+
+	xa_for_each(&group->pasid_array, index, tdomain) {
+		if (domain == tdomain) {
+			pasid = index;
+			break;
+		}
+	}
+	iommu_group_put(group);
+
+	return pasid;
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 36ad007084cc..c0440a4be699 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -694,7 +694,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
 struct iommu_domain *
 iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid);
-
+ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1070,6 +1070,10 @@ iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid)
 {
 	return NULL;
 }
+static ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)
+{
+	return INVALID_IOASID;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_SVA
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
