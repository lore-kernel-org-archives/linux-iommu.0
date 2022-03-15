Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD01FC433FE
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 05:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 767A340900;
	Tue, 15 Mar 2022 05:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3-bVRKAoG0B; Tue, 15 Mar 2022 05:04:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E08A4090D;
	Tue, 15 Mar 2022 05:04:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE86DC0085;
	Tue, 15 Mar 2022 05:04:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 092F5C0033
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C879402E7
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZYKp3d-9aIV5 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 05:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F6C2401F2
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647320639; x=1678856639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ekgMTzrt4B/E5Ajgcaoa3ieo7uw7tCFXNnm15MECQas=;
 b=j3tFWjjbJXQZXqaPeqGqSofo4rdP7SE9wTatfAfzaDkQjzXWzbIHM+Ya
 /pT2oo4EDx6KGF22yPenV1VcJI/KINW0TfR2mZdNuuGz40J2cKGuKPY4L
 O5JhsNiPHkZxKIP6C9B1e6GQrxIx/128/iRBMRa4cA7xMpJIX0ww+e/JZ
 qasmJ9q4jc84xM7hUzlh1kewbnM773FmzAT0Wu00HoEFdj7DNHcaD8upa
 VZSItOWJAZlGUWVW3/nFm0UQkm35FKtVUG2FSnG8Hv6RJ5D8KqtJfZFCn
 6WB/Wvs+AJmcqaGuMkB8J7R+ub0q6tX+1vknYHuVvq2SewFYHeaLpdQUU w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342640146"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="342640146"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 22:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="580383567"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 1/8] iommu: Assign per device max PASID
Date: Mon, 14 Mar 2022 22:07:05 -0700
Message-Id: <20220315050713.2000518-2-jacob.jun.pan@linux.intel.com>
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

PCIe spec defines Max PASID Width per-device.  Since a PASID is only
used with IOMMU enabled, this patch introduces a PASID max variable on
the per-device IOMMU data. It will be used for limiting PASID allocation
in that PASID table is per-device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  4 +++-
 include/linux/iommu.h       | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50666d250b36..881f8361eca2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2602,8 +2602,10 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (sm_supported(iommu)) {
 			if (pasid_supported(iommu)) {
 				int features = pci_pasid_features(pdev);
-				if (features >= 0)
+				if (features >= 0) {
 					info->pasid_supported = features | 1;
+					iommu_set_dev_pasid_max(&pdev->dev, pci_max_pasids(pdev));
+				}
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de0c57a567c8..369f05c2a4e2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -364,6 +364,7 @@ struct iommu_fault_param {
  * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
+ * @pasid_max	 Max PASID value supported by this device
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -375,8 +376,20 @@ struct dev_iommu {
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
+	unsigned int			pasid_max;
 };
 
+static inline void iommu_set_dev_pasid_max(struct device *dev,
+					    unsigned int max)
+{
+	struct dev_iommu *param = dev->iommu;
+
+	if (WARN_ON(!param))
+		return;
+
+	param->pasid_max = max;
+}
+
 int iommu_device_register(struct iommu_device *iommu,
 			  const struct iommu_ops *ops,
 			  struct device *hwdev);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
