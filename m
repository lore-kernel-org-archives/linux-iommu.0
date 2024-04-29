Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F83DB8E;
	Mon, 29 Apr 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389437; cv=none; b=Ix5Q20WHg9zZjIjYtW5QMlFmGdqrOk4kMTRZ6TmiaM31IuwC8IRfsHcBM0N2Iq4st3mRyz3VhEVLFbitNN52zfQaBzMErsiPmGjIYoBwautJ+l42jbEJdoqkPEFIIG/lsTOan/tzlJyGf/m5EGp01il+e/dzYJLAidFtJdF4Fks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389437; c=relaxed/simple;
	bh=1Eo88DNt750jucwhczOVgMrfucx591HLz2m0Oln95J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCIhSsyX4ktHZyhw1EFf6dUxWC3AbD6mTpZdFQ7auDMEnMH7yB6qOKI97fmUHS9jKcPG5LYvofQsYsXlbwJinDZKVfwErVQ2hjewWhI2+6iGpZQrfTls3/VJxS3be4/yaFcJx+cCa2EVHwb/+yseMhYcmZwrx1MhNGYEtfrwsP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfdCmGUm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfdCmGUm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714389435; x=1745925435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Eo88DNt750jucwhczOVgMrfucx591HLz2m0Oln95J0=;
  b=nfdCmGUmm9dvlieviyBpO0G8CeGb9YE/+JSClCrB4aRuaoRy+Zzmjwsz
   gk4Ajgv762RAIykKhw7SFNp7jvpd9foy/Xb2W2k5VovahwiFC5STvedYU
   AYqjxTpW6LV2ER9e2msYT3vz3vabuJSCkeapgo2LmHjS4DaipQkEjrntN
   UcqkU7cLrxrAmZgqJTWB6E3nbLNDpli9c39Tpqn6QbEDIMBIDANXjciSG
   Bnv9HDYcLfzTeRyi0Y5bnZVvhu88zdtzk1YDN+AYrcIyv/ph/XJh8682A
   WQNB218OyzbMpeu9B5UQjKIIchCmYg8tzW+lk2nr7T+PzaDUlkokoAC+x
   A==;
X-CSE-ConnectionGUID: dd7yKKwfRFSIZfby30AoGw==
X-CSE-MsgGUID: n+ODOUrCT2SbC+OPu2P4wQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21459154"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="21459154"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 04:17:15 -0700
X-CSE-ConnectionGUID: jMiiwx0kSpu99QpjyGYENQ==
X-CSE-MsgGUID: PqfT1Ps6QFKeiwxu/lFwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26701015"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 29 Apr 2024 04:17:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 041C215B; Mon, 29 Apr 2024 14:17:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iommu/amd: Fix compilation error
Date: Mon, 29 Apr 2024 14:17:07 +0300
Message-ID: <20240429111707.2795194-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With WERROR=y, which is default, clang is not happy:

.../amd/pasid.c:168:3: error: call to undeclared function 'mmu_notifier_unregister'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
.../amd/pasid.c:191:8: error: call to undeclared function 'mmu_notifier_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2 errors generated.

Select missed dependency.

Fixes: a5a91e54846d ("iommu/amd: Add SVA domain support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 68d8fc107cb9..994063e5586f 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -7,6 +7,7 @@ config AMD_IOMMU
 	select PCI_ATS
 	select PCI_PRI
 	select PCI_PASID
+	select MMU_NOTIFIER
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
-- 
2.43.0.rc1.1336.g36b5255a03ac

