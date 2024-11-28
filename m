Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A652563;
	Thu, 28 Nov 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732765923; cv=none; b=WV5Zrc23kdFV36KyfdSRQLjUupNLRtlt+nrrjmb8fkO6AV7JKKbrNhmq4h0rkLtY8rp0Uxl8Brmy/EPpsgY2Wzwyy5/qd9ZzLu3pDgy4JJZgf/OSj/Ut6BpAnlE3m4zuvaGAlMsJYBDae2AgQFaruknEB4xiQqarj/ZJynhJhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732765923; c=relaxed/simple;
	bh=xB2G7h4IV/IFh/MZVy1ia3l1GQYnocTXi0O/lq8PUmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVTkdDZ9csRGlgIvrLVcTQfNN424aoxD+Cx/BGhHG2XOnZW7vyRiTV6UAk6ejEJWv2iLWAzQaVDW/ikqBmigchxV0iGN7ao9fyJd4AFbJFGXiL0xt+Ey7j/6fQhPf8zCydWTcXAaUMaWQ/orfEd4nctVIhsirb99ZXjHhupa8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b2tPVMNT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b2tPVMNT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MNTqIGD2GF80NWjX3zh1dlo1C8KR10PgrqiT8AEoCIE=; b=b2tPVMNThwtvVv0BTFSGVgqZuC
	ludOX+1vl5cdjGMpi91EUcg7VUODpRNdX2sFxn+dag1B1GVQutSpRXrloHLHSN4HmxDhXAsn0iL4B
	0Qr5jmnZw+TMYpDORMVa0o6TPgwuZFAS6+TVxuuVtEf6EZHQ/UcBGRV7HT5VEduzX6U/T9a87Dwdy
	YiQUeAnKcsw32Y0E9mLVSt8jiuhmmZqGFgYFPVvB/rJiJXqxuFC0fn7whvEcQJavPT3Wv35iVqEKE
	02H6OvMYaiKuOHPD7cpWZVGdZOUnu7zRSBzgCGYnEPLoqkDoYMAhriztEsMbh3BejsMLQkhbbNBfA
	PhN4nOpA==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGVZQ-0000000EdxG-0RCT;
	Thu, 28 Nov 2024 03:52:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Eric Auger <eric.auger@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev
Subject: [PATCH] iommufd: fix typos in kernel-doc comments
Date: Wed, 27 Nov 2024 19:51:59 -0800
Message-ID: <20241128035159.374624-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos/spellos in kernel-doc comments for readability.

Fixes: aad37e71d5c4 ("iommufd: IOCTLs for the io_pagetable")
Fixes: b7a0855eb95f ("iommu: Add new flag to explictly request PASID capable domain")
Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev
---
 include/uapi/linux/iommufd.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20241125.orig/include/uapi/linux/iommufd.h
+++ linux-next-20241125/include/uapi/linux/iommufd.h
@@ -297,7 +297,7 @@ struct iommu_ioas_unmap {
  *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
  * @IOMMU_OPTION_RLIMIT_MODE:
  *    Change how RLIMIT_MEMLOCK accounting works. The caller must have privilege
- *    to invoke this. Value 0 (default) is user based accouting, 1 uses process
+ *    to invoke this. Value 0 (default) is user based accounting, 1 uses process
  *    based accounting. Global option, object_id must be 0
  * @IOMMU_OPTION_HUGE_PAGES:
  *    Value 1 (default) allows contiguous pages to be combined when generating
@@ -390,7 +390,7 @@ struct iommu_vfio_ioas {
  * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
  *                          domain can be attached to any PASID on the device.
  *                          Any domain attached to the non-PASID part of the
- *                          device must also be flaged, otherwise attaching a
+ *                          device must also be flagged, otherwise attaching a
  *                          PASID will blocked.
  *                          If IOMMU does not support PASID it will return
  *                          error (-EOPNOTSUPP).
@@ -766,7 +766,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
 };
 
 /**
- * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
+ * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cache invalidation
  *         (IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3)
  * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
  *       Must be little-endian.
