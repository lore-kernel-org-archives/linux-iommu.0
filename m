Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F9283FFA
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171851; cv=none; b=bVD5nK/vw9cy2eHH+qm+vPtZ2gkWCD+IZRS5tTtc0TSWmrL9faoSzko53e/Sq+ssz/7l836og2ODJ2aQRgLQl2MhtyxROgg9rFya6QiLwSeLF8Iq7uIomWtdozKxb5Xl7gN4LChjrVjkOEfQP9ovpSCBrDU+8rQMpjMOc37dHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171851; c=relaxed/simple;
	bh=gAv61IfogKa6k1nhAsVHmIS1MZiQQ1MRA7IlN77Qpvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJNVloE8YUGdj4APJaKWYI23LLDG9SeYTBApLGncFbj0QBBABwaCOHv7YRGOX5NmqUPKtgbra808icH6Ls2urxexzd/+jatqdFhYJMaH1fFKQBBf8jgI3kaBzRtpADQb+qFCJyxM5hCmlwJBUP3v3an+3PFod0EDKScmq/aK+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRaVncSJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRaVncSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171849; x=1789707849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gAv61IfogKa6k1nhAsVHmIS1MZiQQ1MRA7IlN77Qpvc=;
  b=cRaVncSJU1vfVCdXLxJmUSC4483PE60Xf1yiMqzeJFojsSsZazVHcqLG
   XtQI8cErfXmHLjd8jwmfwsuK/CxrELdkaC/MjkY9q9sg0QudymI+xke7H
   Qi/upcN5FbD4/IbjWqpVM8wSlJuaWd/2hI0NXhR+JyfGRvwjo96Z6eBaq
   KgWs+yKxXwxREnu8ci0gq1BhCGrTDL5t/3gV5hptIpSr3tlBUSq9iEZgG
   nU4uNA8CvWwtQeJdLU14ppM8VD+qan2G6REnvk/dZaBoH5R/S32tZSYuq
   3NPX+kP8uYrKeJEZerzJ5CEA+OIZ9erO+fkt22E7ofjA4d0AYDeC+aCTE
   w==;
X-CSE-ConnectionGUID: uInuzWwYTwKIZpeW4MPI+A==
X-CSE-MsgGUID: uyT5uEeNRwm3GoOgMCGTIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182273"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182273"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:09 -0700
X-CSE-ConnectionGUID: u/1YlTDATGCLD63kcYK6yA==
X-CSE-MsgGUID: Pe4IiJ1EQpCGaUNiQvfCdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353410"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] iommu/vt-d: Removal of Advanced Fault Logging
Date: Thu, 18 Sep 2025 13:02:03 +0800
Message-ID: <20250918050204.359508-7-baolu.lu@linux.intel.com>
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

The advanced fault logging has been removed from the specification since
v4.0. Linux doesn't implement advanced fault logging functionality, but
it currently dumps the advanced logging registers through debugfs. Remove
the dumping of these advanced fault logging registers through debugfs to
avoid potential access to non-present registers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250917024850.143801-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/debugfs.c | 1 -
 drivers/iommu/intel/iommu.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 38790ff50977..765edb3740e2 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -63,7 +63,6 @@ static const struct iommu_regset iommu_regs_64[] = {
 	IOMMU_REGSET_ENTRY(ECAP),
 	IOMMU_REGSET_ENTRY(RTADDR),
 	IOMMU_REGSET_ENTRY(CCMD),
-	IOMMU_REGSET_ENTRY(AFLOG),
 	IOMMU_REGSET_ENTRY(PHMBASE),
 	IOMMU_REGSET_ENTRY(PHMLIMIT),
 	IOMMU_REGSET_ENTRY(IQH),
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 21d79414385c..ef7a1ae8e0db 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -77,7 +77,6 @@
 #define	DMAR_FEDATA_REG	0x3c	/* Fault event interrupt data register */
 #define	DMAR_FEADDR_REG	0x40	/* Fault event interrupt addr register */
 #define	DMAR_FEUADDR_REG 0x44	/* Upper address register */
-#define	DMAR_AFLOG_REG	0x58	/* Advanced Fault control */
 #define	DMAR_PMEN_REG	0x64	/* Enable Protected Memory Region */
 #define	DMAR_PLMBASE_REG 0x68	/* PMRR Low addr */
 #define	DMAR_PLMLIMIT_REG 0x6c	/* PMRR low limit */
-- 
2.43.0

