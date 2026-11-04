Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769839;
	b=HfEHQmWDH/cQp/vwy22AbbO0JVH8IQ1g+9VThJ0O5V8/OsaZ6AVCqJ3TZ8TpKb06pMSX
	 KOCY3NN4OxbUt4r1yBUsjcT0tJTuV7mLzMUFzhyvIRbR//FI/jNJ5QddBHYa7uUx/3oDx
	 SPsubo6jileWU1OO9t3KXDfKJ1De/jphBPh5v6p+xqk/KWUkYqRLn5SgiTtFYM1Ut1lc1
	 +Edx45VznYN8ItHoiD91I4wKoxJEm3gt+y8k+7/1Hy6OeNzPWSPQltJjrDkmCiRwcYgkU
	 XSNjf4504Jm/PAgV1xqIfK1sNTsRNuZlUQ0df6eEKTvzbS0zISNfScrHr8IxRIQ6K8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769839;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jdvZYk018mSPsmLuCOkqT6jhVzBjZ04iDcinjdGFt2U=;
	b=nBrA47LyMWxb7+/1dTNrj08YC/Q2zn6Go6pHifrUUmg3D22ID+EqtaWWJhqmzLYJ8hEj
	 vvnvq2M4MJEv1mikvrfyVN0y9CrRRob+QTsuZqzdVnmZO4Vd+RiLFJBgG9ZjSluVOBwPa
	 PL1akEcDHflQX7Jela1HSyXe/xVCfx0d7shlGWGcUjg3/2CV0QsKetOC4c1JVviZBgzLR
	 bVThT/9HgsFHGcXIYinCF8CNL/XUO1hHH6ZHdB5kAYPBwJ8Ij5ntPMypP1lSFLgt8aP4F
	 0SKbmxoGQnKw4W1oQGXeAJnu726KHFCNXqQYNhZqCSctYOAqVECQD0qZNT3d0gv0xJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YIFMhKCZ;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FE606A330
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 05:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 041FE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YIFMhKCZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793769839; x=1825305839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T0BB9X5RuLN1WPPjK6j7RgAFlyOTBCL4fcKWxpzmi2Y=;
  b=YIFMhKCZhlteaKKkm6z+ywh1Fj79wsMDT9sxZtKVMmhLm2qcB/UFWwzh
   R716jXywJZuceZAllL7eTT3ndW6dipV6hjQTTcpJ7c4qcRODUYh6TZ2mm
   dtH8TnGTJPd8JDzNOjWvKJ1F24W9FDi+igalyhmAOERmTY+bxUJQjDf0U
   hycgqqwlwtoXeLOlngS8ftSw0hwDrBCiL3hW8Hd+d0CoQOrjO1age/ez0
   /jxUlrlwfP+LPSPhDvCWoxXT5M6JPH5nOhneHbiG1dMu0swdRobC84lEZ
   Uy0PgC9womur9+LHBG6PViLzhFJeQAYGylojksl592n9BQHBNOjCv+sjA
   w==;
X-CSE-ConnectionGUID: OGmGmMHaTjaGJ/KKE32GPQ==
X-CSE-MsgGUID: Kq6SzpwAQUGV3pmPpyMzhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2414143"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2414143"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 21:23:58 -0800
X-CSE-ConnectionGUID: tytz82qARqaKNpv52+KZpA==
X-CSE-MsgGUID: 4HsIcB60Sl2z1f5LPCvpHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6777209"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 03 Nov 2026 21:23:55 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Serialize SVA unbind teardown with intel_mm_release()
Date: Wed,  4 Nov 2026 13:10:58 +0800
Message-ID: <20261104051059.1345010-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
References: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_mm_release() can run concurrently with an unbind of the same PASID.
The unbind clears the Present bit, drops iommu->lock and then invalidates
the PASID cache, IOTLB and device TLB:

  iommu_sva_unbind_device()              exit_mmap()
    blocking_domain_set_dev_pasid()        intel_mm_release()
      intel_pasid_tear_down_entry()
        pasid_clear_present()
        spin_unlock(&iommu->lock)
                                             intel_pasid_tear_down_entry()
                                               !present && !FPD -> return
                                           ... free page tables ...
        ... invalidate caches ...

intel_mm_release() then returns before the invalidations complete, and
exit_mmap() can free the page tables while the IOMMU and the device still
hold translations that reference them.

intel_mm_release() walks domain->dev_pasids and tears down each entry
under domain->lock. Do the same in the blocking attach for an SVA domain:
tear down the entry with fault_ignore under domain->lock, so that either
intel_mm_release() completes the invalidations first, or it waits for the
unbind to complete them.

Fixes: 4f0bdab175d6 ("iommu/vt-d: Make the blocked domain support PASID")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++++++++
 drivers/iommu/intel/pasid.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..02d2c97da86b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3699,6 +3699,16 @@ static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+	if (old && old->type == IOMMU_DOMAIN_SVA) {
+		struct dmar_domain *dmar_domain = to_dmar_domain(old);
+		unsigned long flags;
+
+		/* intel_mm_release() must not return before invalidation. */
+		spin_lock_irqsave(&dmar_domain->lock, flags);
+		intel_pasid_tear_down_entry(info->iommu, dev, pasid, true);
+		spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	}
+
 	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
 	iopf_for_domain_remove(old, dev);
 	domain_remove_dev_pasid(old, dev, pasid);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index d1c08d180788..00f9b0722eb5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -237,7 +237,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	}
 
 	if (!pasid_pte_is_present(pte)) {
-		if (!pasid_pte_is_fault_disabled(pte)) {
+		if (!pasid_pte_is_fault_disabled(pte) || fault_ignore) {
 			spin_unlock(&iommu->lock);
 			return;
 		}
-- 
2.43.0

