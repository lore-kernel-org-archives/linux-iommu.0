Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C9C4332F
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 05:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F1E760F77;
	Tue, 15 Mar 2022 05:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xA-fxR3vNZnt; Tue, 15 Mar 2022 05:04:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A6F860A80;
	Tue, 15 Mar 2022 05:04:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33048C0012;
	Tue, 15 Mar 2022 05:04:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AFC0C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E3CC41609
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2iQ3RGVvglV for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 05:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7782541592
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647320639; x=1678856639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ol0nXzisKyEPOLK+60+mhBiQ8qX4SQP0mQu06nsUuvU=;
 b=alQVRmNNGtHK3kOWOiuuBSGPIRKNMZl6v9o+d+oD8NGqpnZ0fpxIgeNl
 /o5fyO/S8Aqm7h07P6iG+YCg5tQw2Np62zwGD/awm9VgAl0H59LVUO8KJ
 xXKFSD/GRoh27sUyBG/+dQFAU7bzPbR4SyHCRamNHrv9xctNsMx/FsCa7
 dYQdvdmwfMFCK7yuKUMJil0ZnEAw5dPI0Htimk4xny48UpyZQOCdXpxri
 GYZNcK/uRzvPcdZS6JgmgDshKHqD00+bw7HXSVXmRTlXDux99JkDQOwqk
 36bxfLB5q9xssGXvP0I7LldXLkvBQimESfnoZFnTH1zdTKCBDcVjxUuAc A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342640148"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="342640148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 22:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="580383571"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Date: Mon, 14 Mar 2022 22:07:06 -0700
Message-Id: <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Dan Williams <dan.j.williams@intel.com>
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

An IOMMU domain represents an address space which can be attached by
devices that perform DMA within a domain. However, for platforms with
PASID capability the domain attachment needs be handled at device+PASID
level. There can be multiple PASIDs within a device and multiple devices
attached to a given domain.
This patch introduces a new IOMMU op which support device, PASID, and
IOMMU domain attachment. The immediate use case is for PASID capable
devices to perform DMA under DMA APIs.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/iommu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 369f05c2a4e2..fde5b933dbe3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
  * @aux_get_pasid: get the pasid given an aux-domain
  * @sva_bind: Bind process address space to device
  * @sva_unbind: Unbind process address space from device
+ * @attach_dev_pasid: attach an iommu domain to a pasid of device
+ * @detach_dev_pasid: detach an iommu domain from a pasid of device
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @cache_invalidate: invalidate translation caches
@@ -296,6 +298,10 @@ struct iommu_ops {
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
 				      void *drvdata);
 	void (*sva_unbind)(struct iommu_sva *handle);
+	int (*attach_dev_pasid)(struct iommu_domain *domain,
+				struct device *dev, ioasid_t id);
+	void (*detach_dev_pasid)(struct iommu_domain *domain,
+				 struct device *dev, ioasid_t id);
 	u32 (*sva_get_pasid)(struct iommu_sva *handle);
 
 	int (*page_response)(struct device *dev,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
