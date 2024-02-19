Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED92C19F
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341725; cv=none; b=Hu9pJzy/KP3NfROoRrume8EVnp+dDBkojbLoDEp9oVDKbekqcN4lRZQxh1ZmMgIZR2fayWjGivPFgokAnsZnDwrtY0zlDoudMhwtw80nbkyfqvIJ73P70/HppFQw4Th4lgmkTgBRvlLJj8v/W9Pmi6KkBH/x4lONVpcAEGP2fFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341725; c=relaxed/simple;
	bh=Czn+l+8Z40u8Nj0hak+E8ur277wY/U7sKfZyklmUb7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSMczP3xTJS/I5WNCRqaHMxGmxQr+U1h2LnttOaCziOV5Igj+O2VxiOB2dUHXFTZOPUql8+sJs79j5DtVlTsSlIFAf0XeJGmo0yP4emhf0FtcyYA7zbGcq6feOF1jYIEMjyh1a/OZSw6Ee7N4N8YtZIIDJJk7S++2bT9OIfHNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4pP64VG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4pP64VG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341724; x=1739877724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Czn+l+8Z40u8Nj0hak+E8ur277wY/U7sKfZyklmUb7M=;
  b=I4pP64VGDfXV3GfszASSTXJZ0VP91xa+IBCmdi7Kx/2LmzcUxppIiIqu
   yF9JNpAie3u7QiYH6cO5P0eiKWIXpFmqnv24DgMUQNygmLvyF2UQaRM8R
   bWCuKv1hhtB1iPmqevO5MxtfhUkM46sM5qVdIl6YbN9QViPbDXlcPR6/t
   GBznt+Xm4ksD7jdoNBq5169WGyqIeTaIQv2BnbucvATKjvl+BLBq8N6Hm
   C/zAN0RK6ys6gi0QxKmgkPN0+XAVf1ZF82jyxyEaxdbayYBAzkfmW43uY
   JP6oNU7n4P9VOAR07Th4UL3XSfCBfhtnvJhVbD5wO3MzZkqeXLufHtSw+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823372"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823372"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826834"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:22:02 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] iommu/vt-d: Add missing device iotlb flush for parent domain
Date: Mon, 19 Feb 2024 19:15:56 +0800
Message-Id: <20240219111601.96405-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

ATS-capable devices cache the result of nested translation. This result
relies on the mappings in s2 domain (a.k.a. parent). When there are
modifications in the s2 domain, the related nested translation caches on
the device should be flushed. This includes the devices that are attached
to the s1 domain. However, the existing code ignores this fact to only
loops its own devices.

As there is no easy way to identify the exact set of nested translations
affected by the change of s2 domain. So, this just flushes the entire
device iotlb on the device.

As above, driver loops the s2 domain's s1_domains list and loops the
devices list of each s1_domain to flush the entire device iotlb on the
devices.

Fixes: b41e38e22539 ("iommu/vt-d: Add nested domain allocation")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240208082307.15759-6-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 711c3e3fe095..2eee83b5441b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1461,12 +1461,30 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 	spin_lock(&domain->s1_lock);
 	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		struct device_domain_info *device_info;
 		struct iommu_domain_info *info;
+		unsigned long flags;
 		unsigned long i;
 
 		xa_for_each(&s1_domain->iommu_array, i, info)
 			__iommu_flush_iotlb_psi(info->iommu, info->did,
 						pfn, pages, ih);
+
+		if (!s1_domain->has_iotlb_device)
+			continue;
+
+		spin_lock_irqsave(&s1_domain->lock, flags);
+		list_for_each_entry(device_info, &s1_domain->devices, link)
+			/*
+			 * Address translation cache in device side caches the
+			 * result of nested translation. There is no easy way
+			 * to identify the exact set of nested translations
+			 * affected by a change in S2. So just flush the entire
+			 * device cache.
+			 */
+			__iommu_flush_dev_iotlb(device_info, 0,
+						MAX_AGAW_PFN_WIDTH);
+		spin_unlock_irqrestore(&s1_domain->lock, flags);
 	}
 	spin_unlock(&domain->s1_lock);
 }
-- 
2.34.1

