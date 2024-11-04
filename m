Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BBA18DF91
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684497; cv=none; b=qlCDsMut+T5QbGT0wJMDzeuN4XHqIIlwffB2JzumHWvBmslMFevWj+XzPqJfPvrXp3CAGH3qNbMmDq9Z3HYJ6ZpR885C3foGPI1miSXYBdq+tnQYsuK5e4aNab+qb9dUjktBF077vrcpixfMvxaInPkiW6Z42Qq5WuhDqlJA/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684497; c=relaxed/simple;
	bh=lj2v7HYEwksE0+spGGVvMber7LvKoV5iuNTn7MJJJm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDG0GvqM20uOJtPrB9ImCog6SZVVdeOeLUDUmSn4uDJirdl72lT6ZYldv2e6CUp1cTxemJUkQFAVHFjmIP58F0rbt53CGJpue4mHlZBZHNLoJcxtZk9IKKv3+Z2KG398MGX3eQA2qxjLjI1d7DcwwRZr4ZRHOU1ufV9xJnG1TdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSXfzC0X; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSXfzC0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684496; x=1762220496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lj2v7HYEwksE0+spGGVvMber7LvKoV5iuNTn7MJJJm8=;
  b=JSXfzC0XMHP5H4akYnHnvh2mIrWnYkEqwAs+tO67lm5aRltPs2uQgOxS
   YrHWpbRD3Ja0yVg1DNhWIdCF6h4INxk1mWzeXAodAo4MOIkhMIHlcGPtm
   SIuZxWnNbOM+Kh+0gw2/PVyDUa8vtZSurICSJ4O52Yi9vIb3BK4MfOqvl
   8rB7efmIXDiS7rSzzBz9j1FZthCFNcYnn/y1PSB5TlaG9uthnlqwGqTke
   XuKWPgiFnK6YJRcb0tfhVNKCuI4gYFRBdEko/3bKx7yxhKa9GCItqu/iS
   fBMVXhrkG5yWjxXGJep5vS58ZpZET8qB3b4C1mG3AyHSY/o3yZkJOgcs9
   A==;
X-CSE-ConnectionGUID: 4+XmsVouSAW923jaYvXp2Q==
X-CSE-MsgGUID: Um8z5darRBO5CguRsaEePw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221939"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221939"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:36 -0800
X-CSE-ConnectionGUID: sPZh5x9dS5e82/3c2R62og==
X-CSE-MsgGUID: TEPngGnkSv6U7cBwtcQ6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020888"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:35 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] iommu/vt-d: Remove unused dmar_msi_read
Date: Mon,  4 Nov 2024 09:40:30 +0800
Message-ID: <20241104014040.106100-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

dmar_msi_read() has been unused since 2022 in
commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

Remove it.

(dmar_msi_write still exists and is used once).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Link: https://lore.kernel.org/r/20241022002702.302728-1-linux@treblig.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 13 -------------
 include/linux/dmar.h       |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index e16c2b1d7633..9f424acf474e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1895,19 +1895,6 @@ void dmar_msi_write(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-void dmar_msi_read(int irq, struct msi_msg *msg)
-{
-	struct intel_iommu *iommu = irq_get_handler_data(irq);
-	int reg = dmar_msi_reg(iommu, irq);
-	unsigned long flag;
-
-	raw_spin_lock_irqsave(&iommu->register_lock, flag);
-	msg->data = readl(iommu->reg + reg + 4);
-	msg->address_lo = readl(iommu->reg + reg + 8);
-	msg->address_hi = readl(iommu->reg + reg + 12);
-	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
-}
-
 static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		u8 fault_reason, u32 pasid, u16 source_id,
 		unsigned long long addr)
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 499bb2c63483..692b2b445761 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -292,7 +292,6 @@ static inline void dmar_copy_shared_irte(struct irte *dst, struct irte *src)
 struct irq_data;
 extern void dmar_msi_unmask(struct irq_data *data);
 extern void dmar_msi_mask(struct irq_data *data);
-extern void dmar_msi_read(int irq, struct msi_msg *msg);
 extern void dmar_msi_write(int irq, struct msi_msg *msg);
 extern int dmar_set_interrupt(struct intel_iommu *iommu);
 extern irqreturn_t dmar_fault(int irq, void *dev_id);
-- 
2.43.0

