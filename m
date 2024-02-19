Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14EE31A81
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347463; cv=none; b=pkQHjSd2iwrrw5M64+w26e5CJ1RRrtuRfATynBHllQ8d49X6rQD77Knz6zDZ9NfUCytINtahE+SF2p71rdMUrDlBfilQEdZeYyJbvyvLwAiRHdWncNG1dksPEPbfKRJmxn7eRmJQseshsw/ivxoJLFhLUUvDHQh0/4T0ZZLNImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347463; c=relaxed/simple;
	bh=rxTf2sHIKYHUVryBpqK9+NhWxGPeCQ4SLQQrcya0g6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXMakZqpwMMyEsV89cCwF7pOAbEwR1OwMd+3KSf8pJgltzPunne6QP598fdES3xSOoOTC4SpF/RJWAEChRxM9kg8b/z1R3RJCZ4qwvDs3BptIyuOMNqrzKcex2bSdOMSiwP+Gay90Jkbl1GTekMyUSA/LN3hkIf54XvFMiJzJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvAgMCjv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvAgMCjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347462; x=1739883462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxTf2sHIKYHUVryBpqK9+NhWxGPeCQ4SLQQrcya0g6g=;
  b=kvAgMCjvlMj3YDJ+aiLEvVbn9a2XSwoDJvdfYvX80FBfUM1p/DYSE/k6
   df7XUWyiB4APWLIMq8Omn7ttDvfDfC/+9vrG2KxurK7XSU80xGVrc7GnK
   X/sjzIn4RXCH1FggZVvpXw6xLz1E9DUq18cWpQq8Zr/0SRpuMusdoGe8d
   qRjeI5fD7JwO22DHFfBMMydSE8U3kyuTupZdgV7jekZuCqxnHNf+a3qqS
   uX1do4677/Sscx6QCLPvcL4+5ktUfQsNuJkGlD+eugD6TbOskmh94L58Y
   PN3NStkuIp2J3wgZoRy6kYRcE93T7r19tATwAN98YuUndq313nJu06m+i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296423"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296423"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449261"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:39 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 01/13] iommu/vt-d: Retire the treatment for revoking PASIDs with pending pgfaults
Date: Mon, 19 Feb 2024 20:57:11 +0800
Message-Id: <20240219125723.1645703-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219125723.1645703-1-tina.zhang@intel.com>
References: <20240219125723.1645703-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revoking PASIDs with pending page faults has been achieved by clearing the
pasid entry and draining the pending page faults in both hardware and
software. The temporary treatment can be retired now.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 40edd282903f..a815362c8e60 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -408,13 +408,6 @@ void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 			if (svm->notifier.ops)
 				mmu_notifier_unregister(&svm->notifier, mm);
 			pasid_private_remove(svm->pasid);
-			/*
-			 * We mandate that no page faults may be outstanding
-			 * for the PASID when intel_svm_unbind_mm() is called.
-			 * If that is not obeyed, subtle errors will happen.
-			 * Let's make them less subtle...
-			 */
-			memset(svm, 0x6b, sizeof(*svm));
 			kfree(svm);
 		}
 	}
-- 
2.34.1

