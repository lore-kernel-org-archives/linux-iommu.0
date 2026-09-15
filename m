Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71F43F4AB;
	Tue, 15 Sep 2026 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458905; cv=none; b=tD/STLlSvg0e0DPyuyQNOvXX6jTL9VYQZaD3jSXUFGjXpEsU7u8699WP1RrgY/HcqVt8spOcsQfuE+KdX21/PtHRoAynULCBsnJESmQye4p9ll5uAp79drWv9kPExAlu/fqB7hzuF4d0rS8rXOzLDb+pCnERM1X32HkV5dmJjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458905; c=relaxed/simple;
	bh=75MOes6SzozZa83TP0M7XKvyRkKiNnMyJKwfpsv2ODE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUb2kIuYja1rkcMvCDpPo9ArSv9pU/sF+OOT19dz+nxVYEEBQiZVcPxCFCtjl6cg4qNvHrh6cPUE/+RBgUjBFxUvxJKHR9j0ONBQLzVHayhNfrQy8XAIGUJEAjBhgT+oJQchoEP6MKZimowmBAfh7T1igOGauFY/BGZDFr60BH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQ+0mAnD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQ+0mAnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458904; x=1820994904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75MOes6SzozZa83TP0M7XKvyRkKiNnMyJKwfpsv2ODE=;
  b=bQ+0mAnDeZgwNQaxB8FkgJumCUIC8TyFaZukVHYWnZsAMESX0MYMsFNt
   8abQf/Fr2K+6bE28GOl3tAiBXIDgYgjC91vrtfjb0WqxSEiUYLBS/vuld
   NpX8mzL95zUt/XFqrwau8aGLSOorX8D1Qcm9BrAlQdh/ftEVLu13AHYUU
   O8MFw+BQZWxy3RG5yJDERArB9/YrnFvJb5zuYoUeP/xyno0HBdaMnv95J
   E2QrGwKw23M+ZMpJboHtuPJPHy81dJDKk+hzENNT4ODYcZAT1RBOnjrrL
   jSTT6qATDEzDMowlIcizEzj1E6ypvmENSL2cEMoGe5giRs1WfRP2zN0hu
   g==;
X-CSE-ConnectionGUID: flMQQpj5Ru+z1mntOHjUJw==
X-CSE-MsgGUID: fUQcBeqSQEqSOEC8DqPumA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101163815"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101163815"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:55:04 -0700
X-CSE-ConnectionGUID: rT2cmXajScm8cB7jjgCycw==
X-CSE-MsgGUID: v+wc3xDfRfazH5AHB9Wo9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269205548"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2026 00:55:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/5] iommu/vt-d: Reserve MSB of domain ID space for TDX module
Date: Tue, 15 Sep 2026 15:42:33 +0800
Message-ID: <20260915074235.1219183-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
References: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When an Intel IOMMU is enabled for TDX Connect, the VT-d DID namespace
must be split so the TDX module can use the MSB-tagged half for trusted
DMA translations, while the host/VMM uses the lower half.

After TDH.IOMMU.SETUP succeeds, restrict host domain ID allocation to the
lower half of the DID space by capping max_domain_id to ndoms / 2. Before
applying the cap, verify that no allocated domain IDs already exist in
the upper half; if they do, abort bring-up and roll back the per-IOMMU
TDX setup.

On teardown, restore max_domain_id to the full DID range.

This matches Intel TDX Connect architecture requirements for IOTLB/DID
isolation between TEE and non-TEE translations.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/tdxc.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/tdxc.c b/drivers/iommu/intel/tdxc.c
index b5dfdeeb23db..1ca03257d456 100644
--- a/drivers/iommu/intel/tdxc.c
+++ b/drivers/iommu/intel/tdxc.c
@@ -129,6 +129,7 @@ static struct tdxc_pages *tdxc_alloc_mt_pages(struct intel_iommu *iommu,
 
 static int intel_iommu_bringup_tdxc(struct intel_iommu *iommu, unsigned int nr_pages)
 {
+	unsigned long ndoms = cap_ndoms(iommu->cap);
 	struct dmar_drhd_unit *drhd = iommu->drhd;
 	u64 r, tdx_iommu_id;
 
@@ -144,6 +145,10 @@ static int intel_iommu_bringup_tdxc(struct intel_iommu *iommu, unsigned int nr_p
 	if (!iommu_mt)
 		return -ENOMEM;
 
+	guard(mutex)(&iommu->did_lock);
+	if (ida_find_first_range(&iommu->domain_ida, ndoms >> 1, ndoms - 1) > 0)
+		return -EBUSY;
+
 	guard(mutex)(&iommu->tdx_lock);
 	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt->root, &tdx_iommu_id);
 	/* TDX Extension is not supported on this iommu. Nothing to do. */
@@ -154,17 +159,27 @@ static int intel_iommu_bringup_tdxc(struct intel_iommu *iommu, unsigned int nr_p
 		return -EFAULT;
 	}
 
+	/*
+	 * Intel TDX Connect Architecture Specification, Section 2.2 Trusted DMA
+	 *
+	 * When IOMMU is enabled to support TDX Connect, the IOMMU restricts
+	 * the VMM’s DID setting, reserving the MSB bit for the TDX module. The
+	 * TDX module always sets this reserved bit on the trusted DMA table.
+	 */
+	iommu->max_domain_id = ndoms >> 1;
 	iommu->tdx_iommu_id = tdx_iommu_id;
 	iommu->mt_pages = no_free_ptr(iommu_mt);
 
-	/* Bring-up is not complete yet; report as unsupported for now. */
-	return -EOPNOTSUPP;
+	pr_info("%s: trusted DMA for TEE/IO initialized\n", iommu->name);
+
+	return 0;
 }
 
 static void intel_iommu_teardown_tdxc(struct intel_iommu *iommu)
 {
 	u64 r;
 
+	guard(mutex)(&iommu->did_lock);
 	guard(mutex)(&iommu->tdx_lock);
 
 	if (!iommu->mt_pages)
@@ -179,6 +194,7 @@ static void intel_iommu_teardown_tdxc(struct intel_iommu *iommu)
 	free_mt_pages(iommu->mt_pages);
 	iommu->mt_pages = NULL;
 	iommu->tdx_iommu_id = 0;
+	iommu->max_domain_id = cap_ndoms(iommu->cap);
 }
 
 void intel_tdxc_exit(void)
-- 
2.43.0

