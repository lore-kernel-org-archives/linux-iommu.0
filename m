Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310E2E2286
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972065; cv=none; b=Cu6PpOGkrDiwkzPA7T7UDPD5dFXWUt0sxbw7aYhOB4mPWO5pF24lhRGQNj8yp9hwOy7dVqNJSNR5+q7/y8Z3Ux+3QahpnBdYPYhHJAUKpZUPiR2+Y4Hfw6qVtJWvjNfLhNGkk0vBoBQ/QTTaZUwL6z3ITRJvMDLxE682b6SM7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972065; c=relaxed/simple;
	bh=PGZ7XcqusTzo/vEZ4Zwieltb3LQtUVtLZXDHcuy63NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ji/nPVWpV7xfA/3o52vM9XF+E7yqbNwp3zx6tbaE9W8hiWF+u4aMUklYJvGYMSoD1uchvBY7lxfBuWiNnWON6Yr4FJApKPJik5+L45hLjXEDE3/D0YjEgD+C6sKtdn83DirVcvDGz6lbeB9LTtsRQDrFPjFjyAKoFxk4o+T4/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lC/rAhFl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lC/rAhFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972063; x=1814508063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PGZ7XcqusTzo/vEZ4Zwieltb3LQtUVtLZXDHcuy63NI=;
  b=lC/rAhFl1ZHkR/sMv0yqovcUukDcZHX7Xyf2UKSjc7cOg5ppQMWZS4Ze
   prjQjOnTfVh4oAnRQuhEEMsbpgCTIZNLsPZf/aPjxA+yRKo7+7QfD7sKv
   vBeUiiSXWNFPQI9N6zfPZss1Km+OitgKK3JbKahK5v6mNP6UbQ4MD/K50
   3Or/JBQkcpmWxcTKzI4B9pQ5CwqR4lgu3d+jc2Jsk4FITQoin9WGX5VMx
   Bbi1PnjkuG2MjlP0uVtXAQm85MfXBxMQjucXmCsIhD1NxnyrdX0z+whCr
   MYxQYUS9H4T71wJrEFMk5SH5Poewhj8YcefdAwa4mdLgctynvAKIaPJxJ
   w==;
X-CSE-ConnectionGUID: u56vL4j0SZqOU1Tug82vng==
X-CSE-MsgGUID: 9HCytKmURnSlYQOINbC8ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256427"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256427"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:03 -0700
X-CSE-ConnectionGUID: /14sC3GpTyqXtVp2JEcF6w==
X-CSE-MsgGUID: wFq0icQPTR+RfbwMFxUMcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425716"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:00 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] iommu/vt-d: Support a new DMAR flag
Date: Thu,  2 Jul 2026 06:12:07 +0000
Message-ID: <20260702061216.388743-1-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VT-d spec v5.2 introduces a new DMA_REMAP_OPT_OUT flag in the DMAR
table, adding another knob to affect whether the DMA remapping
capability should be turned on or off.

While at it, first clean up the existing on/off policy messed with
user opts and various force_on conditions in the first 8 patches.

On top of the improved framework, the last patch introduces the
support of the new bit.

Some cleanups will be done after this series:
- Cache dmar->flags instead of reading ACPI table multiple times
- Check intel_iommu_enabled at runtime instead of using dmar_policy
- Clean up existing warning messages (e.g. force_on panic message
  always has the "tboot:" prefix)

v2:
- Rebase to 7.2-rc1
- Policy-oriented renaming to avoid confusion with runtime state (Baolu)
- Warning message/comment improvements (Baolu)
- Always return error for unsupported force_on type
- No need to do platform optin if tboot already forces on (old behavior)

v1:
https://lore.kernel.org/linux-iommu/20260604051540.592925-1-kevin.tian@intel.com/

Kevin Tian (9):
  iommu/vt-d: Fix no_iommu to disable platform optin
  iommu/vt-d: Force requesting ACS when tboot is enabled
  iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
  iommu/vt-d: Consolidate dmar policy management and force_on logic
  iommu/vt-d: Use dmar_can_force_on() for platform optin
  iommu/vt-d: Call dmar_can_force_on() for tboot optin
  iommu/vt-d: Remove the 'force_on' variable
  iommu/vt-d: Remove dmar_disabled
  iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit

 drivers/iommu/intel/dmar.c  | 95 +++++++++++++++++++++++++++++++++----
 drivers/iommu/intel/iommu.c | 78 +++++++++++++++---------------
 drivers/iommu/intel/iommu.h | 64 ++++++++++++++++++++-----
 drivers/iommu/intel/svm.c   |  2 +-
 include/linux/dmar.h        |  1 +
 5 files changed, 180 insertions(+), 60 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

