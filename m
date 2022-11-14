Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9010F2
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 01:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668390479; x=1699926479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j140O/WHBMrsJSHsHEaF6cUi5s3fzlbz0+OwH/+tCb0=;
  b=nFxYEGGBHsthMlH49Eg2yJ9H9XBTMAd5rQXZBxJO2ZlQrc6gsz7dVA1H
   sRqv5o8VBNtwNnTw3rbXSUB+buA4Zmj9MaDq/6LjoR3v7AckVFUZ3GI31
   MvKKVzdYZJwTnIEaKuIkExZ08qt1uoNcUWWTdy6A+WNCtvj+LOjY6J+j1
   NMUOCJ/tWDtyqhbPJgryofQB58IcrYkct0G223Cm1XwGbNuBpX4i6navY
   V8ZX1I/GLjROhEFNjSjrnn3C0u21n+UlGv4tUpcJYyguWzQPNlGlXnz7u
   SnDYcnxV81QoX6jlHijDpU5ncwbD2EJhrxtCHrKA6L+ee2WTNG+ZlAbhF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="398151520"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="398151520"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 17:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="707124231"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="707124231"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2022 17:47:57 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/7] iommu/vt-d: Rename domain_add_dev_info()
Date: Mon, 14 Nov 2022 09:40:47 +0800
Message-Id: <20221114014049.3959-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114014049.3959-1-baolu.lu@linux.intel.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmar_domain_attach_device() is more meaningful according to what this
helper does.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f165e0d37bab..6a2a77fce0f8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2455,7 +2455,8 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
+static int dmar_domain_attach_device(struct dmar_domain *domain,
+				     struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
@@ -4264,7 +4265,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	return domain_add_dev_info(to_dmar_domain(domain), dev);
+	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
-- 
2.34.1

