Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8AF1AA7A2
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684505; cv=none; b=MgbpmGesziR/w9HM3ALSF2lj1BfgQNu/QByMrIkWexP5oCWfNxUR7OqZPTQAWol4WHIJiro99qa+GCDMGgkE+QJwTUh7VssVKPaH1G2lhGq8Sgdl4GH/IYoXtKmjLgu7WvxHw009q9l0waYYxnFJdrhfPtFM+Gz0Xr8D4W/FLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684505; c=relaxed/simple;
	bh=zStUxPh4rqD6gZCjwJZJ3tmHJFJj60A6NugLiO0geFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCNjtCij6V3Nmfn9a2PbLP/cn+5MG2qN8kt/5+aHdHKDmrFCtsT8UzXIgCUzgWdHIA+pS4qjrvoouhozokBQ/svB7iGfPASOL1+ca3drVuZpSiE1GrGnS0wE/e5RU076nAIA+1DOvgoyZ1LpVYnu7Qqex1jgiAo2zu/3CmgW9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JthIaiUu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JthIaiUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684504; x=1762220504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zStUxPh4rqD6gZCjwJZJ3tmHJFJj60A6NugLiO0geFs=;
  b=JthIaiUuZEYdh5Iqkin33ioKwpn4rBtp+E7IDt9IxeVfAopX/hoSrz2T
   hwEPXSL4AacALtWr+8jYWy2Fghdhpj9d3UsGJPw/yvQsWaXtUX+Ii2TOC
   oiP7XdEKgRxdwtcxI57cv3QATJS5grphR7LywvsOTOPAM2ZZszXmdJkZw
   uqiHWeqw+k4z3o2H5lIz30BA8LTq9FXFi6dEWAQJnxRHuuJnEUuAoDYAa
   Ogg1nA0wzMfSlaMmAO9qZaKzl0SYnL83PbA8hTy0SG8DUT5ATP3XfBoNX
   QeyNtwsHDedEf43Nafm/t4bEWumJZKXbxwacTA61IflkgC+Y73bzht3pt
   A==;
X-CSE-ConnectionGUID: IxoabJ08S1KuONUOZHdvyQ==
X-CSE-MsgGUID: GeSTijt5TaOUxLTKHbq+aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221960"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221960"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:44 -0800
X-CSE-ConnectionGUID: ozfN2kOgTJykGqXjuqDzOw==
X-CSE-MsgGUID: vyBDRqRtTR2kFyreJw/6vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020905"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:43 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] iommu/vt-d: Move IOMMU_IOPF into INTEL_IOMMU
Date: Mon,  4 Nov 2024 09:40:36 +0800
Message-ID: <20241104014040.106100-17-baolu.lu@linux.intel.com>
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

From: Joel Granados <joel.granados@kernel.org>

Move IOMMU_IOPF from under INTEL_IOMMU_SVM into INTEL_IOMMU. This
certifies that the core intel iommu utilizes the IOPF library
functions, independent of the INTEL_IOMMU_SVM config.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
Link: https://lore.kernel.org/r/20241015-jag-iopfv8-v4-3-b696ca89ba29@kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 88fd32a9323c..f2f538c70650 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -14,6 +14,7 @@ config INTEL_IOMMU
 	depends on PCI_MSI && ACPI && X86
 	select IOMMU_API
 	select IOMMU_IOVA
+	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
@@ -50,7 +51,6 @@ config INTEL_IOMMU_SVM
 	depends on X86_64
 	select MMU_NOTIFIER
 	select IOMMU_SVA
-	select IOMMU_IOPF
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
-- 
2.43.0

