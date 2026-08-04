Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774634248A1
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811738; cv=none; b=TBiNqIWkeR4kW98v077PZLLZ8LQ1/xC1fkwD5e2Vhh3rlGaqgV3sCura3HQGY9CHvPeSf+6iy/1T+smruMW4EvWIGNCr7PNHFJVfd5u4vv5zcgcVS3LwfQdsZN126f3q04PsnzwP9e869wBbfbj89MPv05XmaEi0Kc5Coe/hlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811738; c=relaxed/simple;
	bh=9NljmWmOa7zf85w1KhZzM5Q3pk7MPOLgw1HR0hX9Rhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVUM0dQq6DgNi8oC06XjgpXHMZoT0m3yj73dh2FJpxWOXUQWBw8AYBMFQhncDQOQVhxdze6UVdoOfSkctoKKMqsmnAoAdBFadv/1NytnbAid5MoPVYZfuoF4YzES8nMUfgj5p+QAz4BOI2VNM6qULZZC2Y7gvbob8In3y2PoIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cn1jeZZE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cn1jeZZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811738; x=1817347738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NljmWmOa7zf85w1KhZzM5Q3pk7MPOLgw1HR0hX9Rhw=;
  b=Cn1jeZZECZ7nV4KcSzYI/9c0xFYKLBAmajQtGgF3Eptx+ope6nnMtX18
   vD5T9nGzHNJmIyP10FfJAdMs01yvY7YxHEub3Up5PF5qvqbFpA7AQ6RiD
   jovNIGWgi/VnuFtDf0ow1WvczVqXbmJITlq/5pwZb30nmhFu2Sip+aPXN
   JAaKe2igcEKXLgQGRusSgaRlVpn4Hrz3c1EVhTPWa/J/FRk8QRf9Wt2ee
   PjFsaM9mFC+MARjBpDNJz1OGL1SAYrJV93Qe3spfLuSQTwbPJfwiRgBEJ
   axAIMoYCGHsfShlSTwXXkV6rKSlRf1hG2Gfh6dR65ksi+zu65jABHgaKh
   w==;
X-CSE-ConnectionGUID: 55kQfryITQ2UcM6826BOvg==
X-CSE-MsgGUID: sZDEFvE4SB2wzLlPxjU7jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231347"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231347"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:57 -0700
X-CSE-ConnectionGUID: lSQ4U9u1S4WODt/sl9d+mw==
X-CSE-MsgGUID: 7xgenynzQZe0va3hkDWYmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587587"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] iommu/vt-d: Fix copied_tables bitmap leak on error in copy_translation_tables
Date: Tue,  4 Aug 2026 10:37:09 +0800
Message-ID: <20260804023714.3080506-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ZhaoJinming <zhaojinming@uniontech.com>

The iommu->copied_tables bitmap was introduced by the IOMMU live
update series to track which context entries have been copied from
the previous kernel.  The allocation via bitmap_zalloc() was added
inside copy_translation_tables(), but the error paths were not
updated to free it:

  1. When old_rt_phys is 0 (invalid root table address)
  2. When memremap(old_rt_phys) fails
  3. When kcalloc for ctxt_tbls fails (goto out_unmap, which only
     unmaps old_rt without releasing the bitmap)

The bitmap is only cleaned up by free_dmar_iommu(), which is
called from the free_iommu error label in init_dmars().  However,
when copy_translation_tables() fails, init_dmars() does not jump
to free_iommu -- it logs the error, falls through, and continues
with the next IOMMU.  As a result, copied_tables is leaked.

Fix this by converting the two early returns to goto a new
err_free_bitmap label, and by making out_unmap fall through to
it so that the bitmap is always freed on any error path.  The
success path performs memunmap(old_rt) inline and returns 0
directly, since copied_tables must remain allocated for
subsequent use.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5ea584b76f77..7098a6bf6a40 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1557,12 +1557,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		return -ENOMEM;
 
 	old_rt_phys = rtaddr_reg & VTD_PAGE_MASK;
-	if (!old_rt_phys)
-		return -EINVAL;
+	if (!old_rt_phys) {
+		ret = -EINVAL;
+		goto err_free_bitmap;
+	}
 
 	old_rt = memremap(old_rt_phys, PAGE_SIZE, MEMREMAP_WB);
-	if (!old_rt)
-		return -ENOMEM;
+	if (!old_rt) {
+		ret = -ENOMEM;
+		goto err_free_bitmap;
+	}
 
 	/* This is too big for the stack - allocate it from slab */
 	ctxt_table_entries = ext ? 512 : 256;
@@ -1606,11 +1610,14 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
 
-	ret = 0;
+	memunmap(old_rt);
+	return 0;
 
 out_unmap:
 	memunmap(old_rt);
-
+err_free_bitmap:
+	bitmap_free(iommu->copied_tables);
+	iommu->copied_tables = NULL;
 	return ret;
 }
 
-- 
2.43.0

