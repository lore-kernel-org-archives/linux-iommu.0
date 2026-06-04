Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABBA3D565A
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553135; cv=none; b=e3G6wqJLeNRMKx5AXYhsbBsl7nOBV8RAO7JbZdhYjRh3IQWcgidVsD/0CA9JGD7dfr3ftJ3X3nRD48Dc2z9vgYpfamRwgF3eut9nJBRZPzVQ7o1ZdFjX8KAvu3RDAs1pQvAQHCLGYuUMlbRypx/OoZkUaJL6hLVDqrmNWhL8aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553135; c=relaxed/simple;
	bh=ZNuUnQtm2QZ2JMwplBFeCc5TjvOkVGByw+irME/PHDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIIDsRFrUOqCgRBlASJlj64dUGxzHU6uWKRZt+aT6hF8exmXwIozm41fif1k7iZIE3a9NubgkUpcq5rFQfJ4LEiCjvKsKHmm+x4XNeCKmonY6K+5RpP4Os2cnZ1Xuac0V2/1WAsGAffVUeXzYE5MDLTPOCCJmNf6qieochUxt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eu5o/8oD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eu5o/8oD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780553135; x=1812089135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZNuUnQtm2QZ2JMwplBFeCc5TjvOkVGByw+irME/PHDE=;
  b=Eu5o/8oDvzIr569IFXsDGBgbWu0faROx2NENNxpnF7GjMtWef9/4NqMl
   idT3wlxSIyBPeicuU0EtoeTeGMmBFd1XbBO3nFLxFSt1HZvQuiKe+Wu1i
   0wxUE1Gp4BAhOBop99y4VHhbPvh4LWGvGvY8/lVPDx6tjhojIaqq4V43m
   cMZLn9E3KKlHpIvc5apbPNimM5ikXOt61yJj1f+/tU5pItnOT57ps5LlC
   BkPPElZXMTuiGm9dbnZOntxJLQHXcafRhhb0VgYJVRUeHSyTfgiYj6H7t
   Uih2BUYQHYnmv5m/uxlGjFayBDfn6a6KfSxdqqEwvC+W6HPjlAO4ma2O4
   g==;
X-CSE-ConnectionGUID: RQih4SkJQem5omiCVJwoPA==
X-CSE-MsgGUID: VmdJs2cBQIKg8p4kY9bBBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81554242"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81554242"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:05:35 -0700
X-CSE-ConnectionGUID: fFARWh9CSsyHr6vzFbJjVg==
X-CSE-MsgGUID: gOU0XIbgT8iOclobibFcwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268112158"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2026 23:05:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] iommu/vt-d: Clear Present bit before tearing down scalable-mode context entry
Date: Thu,  4 Jun 2026 14:03:07 +0800
Message-ID: <20260604060311.365074-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604060311.365074-1-baolu.lu@linux.intel.com>
References: <20260604060311.365074-1-baolu.lu@linux.intel.com>
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

