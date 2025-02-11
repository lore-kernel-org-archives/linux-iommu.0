Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055111361
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235307; cv=none; b=mm3JoLboty+2o2/9ySNuQgcbRBiTNYJIJ5kurDya+jjQboESAJXc/CLabWsx3Xz3+2SDE7o6TIGnGkNGQfvEx01zwrAthc/MNnvRo/PgxymvlgVIZy/htSx1Ubat5Qlfl6LgQJv07DBWXMiIgKK57IWQtCnHG/QHeMmv9AD6KnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235307; c=relaxed/simple;
	bh=DVK1BM6fsgQdcrJqVs9z4/2JlTjuP1XLF668jqOTA2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Md0FhZMsP54kyy2qZ1Pp9Z5FzCmMnC8DdJfhN9AVyLV4b8Ftkl0QMFk+lcwYRJEinljkU5cW+fneFyNrnhtFLae1GVbgGPBPuvH2y718VNbN4ifb/a2CueyeYeRt9J1SH45lv8k/64F3sMxkXC0nsNjCcoI0X+k5DOINEqxYfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmRPetxe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmRPetxe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739235305; x=1770771305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DVK1BM6fsgQdcrJqVs9z4/2JlTjuP1XLF668jqOTA2c=;
  b=jmRPetxeTGiTEHbO6pJTALkqOaGFTp6SuiqtqtGx/3h1nQE0B1T6X0ku
   3niMIKXl9nbfc3c2qHp47GKj1n3ijNlReah/kJRQTLR2HPMttEXpk9Usk
   z2BMBJDwn0QpPblhYOsnE8NrET53kgOmxIckze45JAM1MyLaj78VE8kgF
   AYF7w/WOes6sIuPObrfRvVY2E2o4GyTNUd+Ik22DhoTaeKWR11ObSPVz1
   3gG3BWlIUhzLPdhb4TVKEiZh0TPDoKwdC4CYSpmSyQAYxWNLCRJvmbqaH
   LFDYhWuWEoeNQswIIDLUSB6xBBYZV0AmDxajYI8md3eiWh4QJAl9fHwJo
   A==;
X-CSE-ConnectionGUID: nW2sYi4KRAO+0DhBCEj6Kg==
X-CSE-MsgGUID: xBQTISL2SmaaEF7utat4GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39756004"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39756004"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 16:55:05 -0800
X-CSE-ConnectionGUID: FobcnFARQG2swwv7OZQ6HA==
X-CSE-MsgGUID: 25lPm/0AR0OgfDN0Y1zmLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="112186399"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 10 Feb 2025 16:55:03 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1][PULL REQUEST] iommu/vt-d: Fixes for v6.14-rc
Date: Tue, 11 Feb 2025 08:55:11 +0800
Message-ID: <20250211005512.985563-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for v6.14-rc:

- Add a missed check in intel_iommu_drain_pasid_prq()

It has been reviewed and tested. Can you please consider it?

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID

 drivers/iommu/intel/prq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0

