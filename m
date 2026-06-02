Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB964382F16
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443412; cv=none; b=OCb/8mJX2DV4SqrY1892ySPjyoV8w73gu/Zev4PnnxOaZwFsh0d36k3RvkBh1QHZlQ6DkZuguzP6OBwkkznziMqmlPTkeiE0hNb6RM9aHhCFL6euj7xSVUNHS91hANpYE5nOCQ1YlJcM6FhiTZZw3mtpUEZTcNYzT7jPbyE8rv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443412; c=relaxed/simple;
	bh=ZNuUnQtm2QZ2JMwplBFeCc5TjvOkVGByw+irME/PHDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTp7Lapl/yWh/zzcP0y5Wm5VWHoU3E2s9Ql7Xz6lZs09av4ca+hzauN0oU+uKDRjqDNN+J3afd+lTDHAKvWW/vQWwLvH/XbBbx2XINuk9iUcJ/8z/FEzp/q0AfO9lLTDHW60y/KY2x6BlFXhCgYMvJViVg7mXuVtUa6iwg8U4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljcmCkqK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljcmCkqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780443411; x=1811979411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZNuUnQtm2QZ2JMwplBFeCc5TjvOkVGByw+irME/PHDE=;
  b=ljcmCkqKOjFUU3OUwhDp0PrydMU9vjd8EkLjuX2STSdMscyCfQtIsSx/
   WaWw7CBVQpi4T+Fogc3lrIRCZW0peHSX/d5YVF5zxDa+Tn0zOcLcB+Btb
   u0GuT3rSOzTQ1VPq5yqH4Yr/qqfksx5f8jhUlfNB8JHYq+n08Z4jeA90U
   Xx1yLoi154U8BRcD1kRv+ADZNcmoDjstQGmVD3+s/EM3rEMwnxFKhDQcp
   qeeSHynbKu4WjFfwshDBCOBA0N4pajELRnF+Rf7OggswawArHu1Sk71FH
   5cAox8ICjEFKU44s4rN5GUBr7+f9iD8jTD90LCD4XMUVAsZy1CavDqzao
   A==;
X-CSE-ConnectionGUID: n91qy6tpROaHMKF3K3lyYQ==
X-CSE-MsgGUID: NpsvcUaYRiyDSLQUK20Mmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81369713"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81369713"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:36:50 -0700
X-CSE-ConnectionGUID: +PBzkT2ISS+Yz3CqQBEemg==
X-CSE-MsgGUID: wbKjNTolQnmyPbE99TOSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241068746"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 02 Jun 2026 16:36:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iommu/vt-d: Clear Present bit before tearing down scalable-mode context entry
Date: Wed,  3 Jun 2026 07:34:21 +0800
Message-ID: <20260602233426.357499-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602233426.357499-1-baolu.lu@linux.intel.com>
References: <20260602233426.357499-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

device_pasid_table_teardown() zeroes the 128-bit scalable-mode context
entry with context_clear_entry() while the Present bit is still set. This
creates a window where the hardware can fetch a torn entry, with some
fields already zeroed while Present is still set, leading to unpredictable
behavior or spurious faults. The context-cache invalidation is issued only
after the entry has been zeroed, and intel_pasid_free_table() then frees
the PASID directory pages, so the IOMMU can keep walking a stale Present=1
entry that points at freed memory.

While x86 provides strong write ordering, the compiler may reorder the two
64-bit writes to the entry, and the hardware fetch is not guaranteed to be
atomic with respect to multiple CPU writes.

Commit c1e4f1dccbe9d ("iommu/vt-d: Clear Present bit before tearing down
context entry") fixed this exact pattern in domain_context_clear_one() and
the copied-context path, but device_pasid_table_teardown() was not
converted.

Align it with the "Guidance to Software for Invalidations" in the VT-d
spec, Section 6.5.3.3, using the same ownership handshake as the sibling
fix: clear only the Present bit, flush it to the IOMMU, perform the
context-cache invalidation, and only then zero the rest of the entry.

Fixes: 81e921fd32161 ("iommu/vt-d: Fix NULL domain on device release")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Link: https://lore.kernel.org/r/20260528025557.3209367-1-michael.bommarito@gmail.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 89541b74ab8c..40910dc7363b 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -748,10 +748,12 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 	}
 
 	did = context_domain_id(context);
-	context_clear_entry(context);
+	context_clear_present(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
 	intel_context_flush_no_pasid(info, context, did);
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
 
 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
-- 
2.43.0

