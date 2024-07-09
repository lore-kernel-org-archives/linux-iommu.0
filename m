Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8F19DF4C
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538981; cv=none; b=rrqoaXCjrCnhcCs8+P9H7JqD9vNHck8buO+ZDH+F+fONk38YBB7F7Wg/HaQH71pwi/FjgXIPblMV31qnd+68WxvXQqju9VdIjq7knxVCW5oGUWwD2dXPpRlm3mgAmRse5yD11hVA+nOLKPQWbAmdDnv64ZGqpwnZZ9aQjF1Rhek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538981; c=relaxed/simple;
	bh=xTHmB6sMcCBQTXC6H4V4K9WpQKgMJxxiRCnbmEfxDaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5uspaBFCD5nuY9N3dUt7nwsmUDzL9p665VNjeUPGDnOQ2LiMeHSqEIFNpOLM7bJyiX1aiABO4xaJkNhlIDK+pBsSuHzSGnlN/AmIlkTgaE2/uJZSh2KtgszT7620vHxVWQQH7StdlJHPuohs+YHi5LknNN8Ufs/+/y7+3ktN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqrMetXt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqrMetXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720538980; x=1752074980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTHmB6sMcCBQTXC6H4V4K9WpQKgMJxxiRCnbmEfxDaY=;
  b=nqrMetXt55wBAq/5izWVgsRQ6H1qiukccaObhFfP2L1XETseLyOIcpVl
   N3ZdlawjrOkrZx0+zsGazgAtg2UuqFPLmwAVTaiA5nGxP0qmkT7BiWWxV
   VFEpfpH5DytltKp8uveDMHlz5XhGxf1E7CSTSGWF97hYzgGndIsP5vi54
   okzzlanaOIFwqMh+ZLq5wqijm5wKiFHeistHMTeSDfFqbR5JfdgMJoitL
   5vBnsICho2gOPRQDlFZXuIS8yvg/QX5MYYsa8QoDBrZH9a66qMH2KlDXg
   sunqrtuylt/T5OoseR4VxHJ3zbTI0i0YcraHA4exQtd5jEckCvkykbwsB
   w==;
X-CSE-ConnectionGUID: Qc8CiBRTQfCiIB6xSZ4hbg==
X-CSE-MsgGUID: aCr/azOLTFWUPR7EohNOfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="40321145"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="40321145"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 08:29:40 -0700
X-CSE-ConnectionGUID: WUw2XVEQS/aoCLZC/Qa0eg==
X-CSE-MsgGUID: +CegtaPIQGa8o8BecsaZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="48618948"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 09 Jul 2024 08:29:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Louis Maliyam <louispm@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/2] iommu/vt-d: Limit max address mask to MAX_AGAW_PFN_WIDTH
Date: Tue,  9 Jul 2024 23:26:42 +0800
Message-Id: <20240709152643.28109-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709152643.28109-1-baolu.lu@linux.intel.com>
References: <20240709152643.28109-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address mask specifies the number of low order bits of the address field
that must be masked for the invalidation operation.

Since address bits masked start from bit 12, the max address mask should
be MAX_AGAW_PFN_WIDTH, as defined in Table 19 ("Invalidate Descriptor
Address Mask Encodings") of the spec.

Limit the max address mask returned from calculate_psi_aligned_address()
to MAX_AGAW_PFN_WIDTH to prevent potential integer overflow in the
following code:

qi_flush_dev_iotlb():
    ...
    addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
    ...

Fixes: c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e8418cdd8331..0a3bb38a5289 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -245,7 +245,7 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 		 * shared_bits are all equal in both pfn and end_pfn.
 		 */
 		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
-		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+		mask = shared_bits ? __ffs(shared_bits) : MAX_AGAW_PFN_WIDTH;
 	}
 
 	*_pages = aligned_pages;
-- 
2.34.1

