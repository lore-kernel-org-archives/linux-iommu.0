Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D62D2741B6
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549574; cv=none; b=cLW0gpGnfhvEPvx39rWCRffbKIqkTJjgfTIyAmaBAz0RiIey/p2ehf0c+eKkk96Eb2z++kiK81hXsxPfnI6aESPAVYisbh6QjqMhG0LvO5tU7G26IooWtJxspG+zFfQRPBf51wpi9zfoA8H36xvs7x8ChphRpSO5zRPOufCE8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549574; c=relaxed/simple;
	bh=VwWXEoRA2xefS+sOhyg16w66CHqsVGP1eQj4xhE7JAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taP8h6iz+1SWZY6BnEvjClExIBkc0snm/aDWcgwJRn3sWbrD8irSn72Kl+qozw0bdYnCtShwM6LC5U0/rFOC7o6z1CQMDHvsoA/m34BE/fth694V5sOQ/j35MR3TX4ldxwfjyweZ7MrVgDXHUHJVf7p2O9WXnPcpT1HVwv/0ADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjRCHFyz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjRCHFyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549572; x=1812085572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VwWXEoRA2xefS+sOhyg16w66CHqsVGP1eQj4xhE7JAM=;
  b=jjRCHFyz56G41uWCC9moiM8y8EnLroRwtzyfRsa41dHTMQ7QQoZnPyRy
   ZlebokrITRvt6OQk5GxjCTQdzHPN+W+9lgfbvbEJuLFNpbLrxkDLoZrr3
   Lueuxgp9kVQsF0xCT2j2AOjhX8CfG69N3f45aGNhY0Fv+cBfL8DgQOzkc
   h4F7BzX2IeP9OjKPHhytSGCT7fyLousoCn67qOW/lwicuPHQkNwV67kf3
   QTpcvSP+vTBAeqOwgBbe2QPBfWUwOuwlRtXSHMJF6TeRgyRlNxjjEe5nJ
   4cAY6Tidqptw2olon9Y8FteZS15/mS7SZSXWmf2v7EIAVCsJg6mBocNIg
   Q==;
X-CSE-ConnectionGUID: EoP+/mRGQMGG2fB5YDNaIw==
X-CSE-MsgGUID: 2v0iDWNASkyoN94tq6d0Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943436"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943436"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:11 -0700
X-CSE-ConnectionGUID: 4BHbhNOSS1C9dya/zmOizg==
X-CSE-MsgGUID: i5zk3trORWqltDuWfem4Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266374"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:08 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] iommu/vt-d: Support a new DMAR flag
Date: Thu,  4 Jun 2026 05:15:31 +0000
Message-ID: <20260604051540.592925-1-kevin.tian@intel.com>
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

Kevin Tian (9):
  iommu/vt-d: Fix no_iommu to disable platform optin
  iommu/vt-d: Force requesting ACS when tboot is enabled
  iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
  iommu/vt-d: Consolidate dmar state management and force_on logic
  iommu/vt-d: Use dmar_can_force_on() for platform optin
  iommu/vt-d: Call dmar_can_force_on() for tboot optin
  iommu/vt-d: Remove the 'force_on' variable
  iommu/vt-d: Remove dmar_disabled
  iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit

 drivers/iommu/intel/dmar.c  | 92 +++++++++++++++++++++++++++++++++----
 drivers/iommu/intel/iommu.c | 73 ++++++++++++++---------------
 drivers/iommu/intel/iommu.h | 64 +++++++++++++++++++++-----
 drivers/iommu/intel/svm.c   |  2 +-
 include/linux/dmar.h        |  1 +
 5 files changed, 173 insertions(+), 59 deletions(-)


base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5
-- 
2.43.0

