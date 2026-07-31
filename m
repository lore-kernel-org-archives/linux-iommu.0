Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A7361956
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477288; cv=none; b=N9ur0kjz07vWpn/2yvVfXOlpbbubH52uQ+Qrjk1YjOSsseQI4P/mCYeWRl8XtmQsyxExmJpNy7nlksfByuXwdAJoadhN7dJebXAcPweeTDtDCiWdlH3jpI8CkMa8J0o9rzREa7O4uwXF97Z3pcmGu6Bv/kdJv5YlQ9iwRAHCq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477288; c=relaxed/simple;
	bh=nGcEK5ov3lgzx/0z00CAYMXlEb958viLjmsm0F0bSks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvZfM/vITPVP+K66CnQ+/km+MZWd0nKpolhErRwt3t086+MOu0tfluzoyxK3JnWxwoyCPgEAM8BJg2XDbWKjN6Nt/UfUmcLjCPa6ZAQKRNA5IxxJAb7aYTV0X1CqI+yUyO1z0pqVirPeyCzBeqshDDMhVDK8q+nnXhWXHgH8YVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzdrTL6E; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzdrTL6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785477287; x=1817013287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nGcEK5ov3lgzx/0z00CAYMXlEb958viLjmsm0F0bSks=;
  b=FzdrTL6E+fPetRljnbuzCY1Q1thYzB8z46vk26fxdhsZJH/8AQCbtveR
   4E57ITdMR3hIyN6vfz6zzBxJ/94K1nwre6JO6IvYeRIoIMpO+6f3rcjrY
   YulH+NSzBcWBEmlBo6IUw3w7Te1a6qgkxHBgKG13e0xSvV13lQt5OqKkd
   BC46XZsFHCr33o+4n1xBkCXbqCGQd4Pt5P2ctiAbossygjpBiajTfsWnm
   1qFrFXp2RxaeINb2qk5xPmOaj7fvERuXj4MhEwna2fKtGJI9gjpxcK3ad
   aCCfOwKSgUlVSDOlA9xipBfOab7BKf5wMVH6gfaHXHXKWIQaXk1uzw6IO
   Q==;
X-CSE-ConnectionGUID: YnaMBR9oS8ub2f6fqPZlfA==
X-CSE-MsgGUID: xuwX4FsRQGmVwVxHv/eFQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97615892"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="97615892"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 22:54:47 -0700
X-CSE-ConnectionGUID: Dx19Gj6pTZW/pGsEoSYhUg==
X-CSE-MsgGUID: ZXRAU9DDS3+5f5MXlzTX5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="298695476"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 30 Jul 2026 22:54:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 3/5] iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
Date: Fri, 31 Jul 2026 13:43:27 +0800
Message-ID: <20260731054329.2948252-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
References: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_iommu_attach_device() enables IOPF for the new domain but never
disables it for the old one.  device_block_translation(), called at the
start of the function, tears down translation but does not touch any IOPF
state; blocking_domain_attach_dev() has to call iopf_for_domain_remove()
explicitly before invoking it for exactly this reason.

identity_domain_attach_dev() has the same problem.  Its comment claims
that no PRI handling is needed because the device has been put in the
blocking state, but the blocking state and the IOPF reference count are
independent of each other.

As a result, replacing a domain that has an iopf_handler with another
domain at RID level leaks a reference in info->iopf_refcount.  The count
never drops back to zero, so iopf_queue_remove_device() is never called
and iommu_disable_pci_pri() triggers its WARN_ON(info->iopf_refcount)
when the device is released.

The PASID paths already handle this correctly by way of
iopf_for_domain_replace(); convert the two RID paths to do the same.
Using the replace helper rather than a bare remove keeps the enable
before the disable, so the reference count does not transiently reach
zero and evict the device from the IOPF queue.

Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260602233426.357499-1-baolu.lu%40linux.intel.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 528b59e5f4ce..6baf1c075dc9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3158,13 +3158,13 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	ret = iopf_for_domain_set(domain, dev);
+	ret = iopf_for_domain_replace(domain, old, dev);
 	if (ret)
 		return ret;
 
 	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);
 	if (ret)
-		iopf_for_domain_remove(domain, dev);
+		iopf_for_domain_replace(old, domain, dev);
 
 	return ret;
 }
@@ -3870,10 +3870,13 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
 		return 0;
 
 	/*
-	 * No PRI support with the global identity domain. No need to enable or
-	 * disable PRI in this path as the iommu has been put in the blocking
-	 * state.
+	 * The identity domain has no iopf_handler, so no IOPF reference is
+	 * taken for it.  The reference held by the old domain must still be
+	 * released here; putting the device in the blocking state above does
+	 * not affect the IOPF reference count.
 	 */
+	iopf_for_domain_remove(old, dev);
+
 	if (sm_supported(iommu))
 		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else
-- 
2.43.0

