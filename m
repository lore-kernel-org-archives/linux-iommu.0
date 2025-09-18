Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AFF27F728
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171850; cv=none; b=GrJ26AzBnNLNkpdINisiGcU//XXIPBwWs33Q+Ns/ZgvBKCrXiSPEctuMvZGoUtDbgJ12AnpQw/b8p+vydCafR1tzw5Y4TruPQdc4O7pdZBsRKO2WfKfcqOlkaAmh2JbGANFrXurzLYW7ens/dPes+7fMh9oMVgERQiXekqo3WBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171850; c=relaxed/simple;
	bh=lHghKH4ULMXAHmF5d8L32yT2BD6X8Hm29QJ7mE4fltI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CstNTKt45II21hcpRImNVHBqvbdOQ9VZ1RncS6LjYImtGaMERappIk7IkFOtV9xaSdmVbC+v4H34pfcH15NwQ8vequr3k0C0r27UVSP/OxReou7U/kRlZQhle/nBEcOiKs0sxy1wrTmalzRk51AX7Xe9KfQfTy25k9308L+1AkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/7VmVC/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/7VmVC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171848; x=1789707848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lHghKH4ULMXAHmF5d8L32yT2BD6X8Hm29QJ7mE4fltI=;
  b=V/7VmVC/coR0bjnJlNRtRKTjEFa1IJydSJEdjBDejyTLAFYgrhkUIzFT
   LodYC0KR9U2vSaARg1IbmHs4l5ufg08dyQWDZUq5C8raS2sZWGHWWyC0B
   +lNZwsi38il+2m/iDP+hTqVB1GVpCwfYumZeLPbdEOh2+AIBWZgsEQiXv
   j40MJYvV+lVNPwdo28WhG9YjvHI5G1sNaes1gBT+VzD+/BjuRZ0inVJ/s
   yYHGQQtC2b/Br+bF8X0+Td9R3I+kHBxEChaGAhaGvdi8Wt7Rb4mkeyD6P
   zdBVyC59+ClmPTV9XTBymuQvi9JGw9xa5Ya0Luo25j7Q4DlqZdk5jBF9R
   g==;
X-CSE-ConnectionGUID: c1IDDF8VSLWniP+wVUotfw==
X-CSE-MsgGUID: eQcmH8f/Qkab5Qol8L9p/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182268"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182268"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:08 -0700
X-CSE-ConnectionGUID: +Hia2RwMTrCOgB2D5Evtmw==
X-CSE-MsgGUID: a1SS4fVlQF2+HD8nN1ybbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353409"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] iommu/vt-d: PRS isn't usable if PDS isn't supported
Date: Thu, 18 Sep 2025 13:02:02 +0800
Message-ID: <20250918050204.359508-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918050204.359508-1-baolu.lu@linux.intel.com>
References: <20250918050204.359508-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The specification, Section 7.10, "Software Steps to Drain Page Requests &
Responses," requires software to submit an Invalidation Wait Descriptor
(inv_wait_dsc) with the Page-request Drain (PD=1) flag set, along with
the Invalidation Wait Completion Status Write flag (SW=1). It then waits
for the Invalidation Wait Descriptor's completion.

However, the PD field in the Invalidation Wait Descriptor is optional, as
stated in Section 6.5.2.9, "Invalidation Wait Descriptor":

"Page-request Drain (PD): Remapping hardware implementations reporting
 Page-request draining as not supported (PDS = 0 in ECAP_REG) treat this
 field as reserved."

This implies that if the IOMMU doesn't support the PDS capability, software
can't drain page requests and group responses as expected.

Do not enable PCI/PRI if the IOMMU doesn't support PDS.

Reported-by: Joel Granados <joel.granados@kernel.org>
Closes: https://lore.kernel.org/r/20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org
Fixes: 66ac4db36f4c ("iommu/vt-d: Add page request draining support")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250915062946.120196-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c3ab9d9f69a..92759a8f8330 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3812,7 +3812,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_pri_supported(pdev))
+			    ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}
-- 
2.43.0

