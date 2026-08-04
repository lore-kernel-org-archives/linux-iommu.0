Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755B453A32
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887703; cv=none; b=DJ8oiP2sKJ4prAxSjlj+8EsaPPHd7qUoykDF7bCFiFuSsvaPMUd+nEew/lpAn3GnPHVz0mQwJyRJzovFV8Wa2CbyNcISeERO/CA911nN+po+M3qI0778LBjcXYHm2U10ZWF3M75CQxGYIjcwQ+R1SrWQM2zLiNQ+HsByjr5a4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887703; c=relaxed/simple;
	bh=9NljmWmOa7zf85w1KhZzM5Q3pk7MPOLgw1HR0hX9Rhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZvyrHNtnNxyZQQNhN4UELVgc1FC0jiJgM6N6uqnXt4+0dhGcaFDp2vBAF0nuzcmR1zcIEewZirjgrnBtOQsEdYRAFVDUaxcjyxPEs1qGoC1G6Ys6d64pkuFTE/BErgfoHAbgJjrTU+IGI+FMJbV7hxSfS4sgSU11al2V0clONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hW7CZhQJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hW7CZhQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887702; x=1817423702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NljmWmOa7zf85w1KhZzM5Q3pk7MPOLgw1HR0hX9Rhw=;
  b=hW7CZhQJRA/SnryoMciGD3JFa1AqZWk45SvIMB/YOMScvW8JC6XakpRn
   nwXLEbyRUvT0wPC9ien4j8xuSQQLpyjlUKP2MDJUQiYc33TI2+LSUsKpH
   w89mLphiIB+y04QP/87uAZVeRzf4gDIelUYnhKNcyCwkrKzN9wGzwj3t2
   rhmjU3yBZUbJGtFzUG0sUYFyK6SAOfR0PbOmag9NWDFBo82PNfYdqPfL3
   GVLl9lfUpodZbCh0hy9Tp9WIh7QOQAfvSM17+2bCfntvq9wXLM9KWJjkT
   /C3xqseUr/uSHEo6ACjG+ezHOGBdQDuD1h0cu0U8Tr5LXlDA0otItu1A9
   w==;
X-CSE-ConnectionGUID: 9EfbzX/1TbWmhycplBPgkg==
X-CSE-MsgGUID: KSzbC2YyTUaMg9sQLlpHYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263344"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263344"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:59 -0700
X-CSE-ConnectionGUID: U+mK/9tUQYmO0IC50+/XVA==
X-CSE-MsgGUID: hRrGd4yAQpeBMWibucZyLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324402"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:56 -0700
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
Subject: [PATCH v2 15/19] iommu/vt-d: Fix copied_tables bitmap leak on error in copy_translation_tables
Date: Wed,  5 Aug 2026 07:43:09 +0800
Message-ID: <20260804234314.3087110-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
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

