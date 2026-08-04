Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2003542F8
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811707; cv=none; b=R7ga/pdj0b8eToVrIQe5/aaF1EmWsss//gQlq7FtparJ1RevJeOvvteY9nOmi9iLjRbCPDkWu6WE7jYmMcEWurOSlEgY92pYsHAXKVuA7UL+wxT8KSTFkwyIva6cGbjNGC2kKTUc/M/kxFTMu2d9mOgVLaeiXS5xg0447UNl1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811707; c=relaxed/simple;
	bh=CQ3W1/2aj/o3UHC3E6D/HiOGxzV152+uyIZW7yTXbkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmTxnZCZ1S+CPgtbnpiDlcsiBul/2gjt2IcSQnCNMP9uLNkmBqaEo8scoR3rCybgm+ZvW+kflztj3Y/4kbt2fk5D8bny1NIyhaojRMFM676CTs7vXdi+Eir1u2nUOlASIF7xf7dG5mAgF60PKJPydEaK0rx98zqB/Zsl+XVKS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLWZlipE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLWZlipE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811704; x=1817347704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CQ3W1/2aj/o3UHC3E6D/HiOGxzV152+uyIZW7yTXbkg=;
  b=JLWZlipEobnPlJEJ4a8QZ9m5/PqqKmpiU0Tvurcb1M+lbmzzzd8ggkC/
   i/nDcFfa1IpzVhe3q2Mk8+DYL0vF8SI9dvUQYETzEqGM06tg8gvK/jRgc
   5y0t/aLOIIMAa/MLGdG3Ppq6zGqZtMHZtJqmdqooSROAkbvWVtdL5RduA
   DgSR7QOHqt6WCkGQ8dAfnrSZtICqxl9VZmPXo+TJEdx/5+l3fSW4ztJzr
   qTjjDFH8cwlKMOhhRJFuIxvCjp35sH8SUa6t/kSzLk7jNhevNkL2rE3yr
   cQFqH28M3WQBJnGHUKulwEf1Sd2OdbisSIGQ+hXRo86vLoiqa5SaGe4Hi
   g==;
X-CSE-ConnectionGUID: WcxA9yfyTbWnp/vs24h0Qg==
X-CSE-MsgGUID: E1/qRFH1TmizkXhYqlfHvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231215"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231215"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:24 -0700
X-CSE-ConnectionGUID: dm+6HSFyR+qvPuN3K3Acgg==
X-CSE-MsgGUID: tEWU+kzWQ3GLw/csNbjErg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587381"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/20] [PULL REQUEST] Intel IOMMU updates for v7.3
Date: Tue,  4 Aug 2026 10:36:54 +0800
Message-ID: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes are queued for v7.3-rc1. This update introduces
new features, quick fixes and several refactorings, including:

- Consolidation of complex enablement logic into a clean, priority-based
  state machine.
- Support for the DMA_REMAP_OPT_OUT flag from the VT-d v5.2
  specification.
- An update to cache_tag_flush_devtlb_psi() to use full-range constants
  instead of modifying shared variables for CACHE_TAG_NESTING_DEVTLB.
- A fix for the UCTP context-table slot when copying root entries.
- Fixes for several pre-existing issues reported by Sashiko.
- General code cleanup and refinement.

These patches are based on v7.2-rc6. The full series is also available
on GitHub:

https://github.com/LuBaolu/intel-iommu/commits/iommu/vt-d/next

Please consider pulling this series into the iommu/vt-d branch.

Best regards,
baolu

Desnes Nunes (1):
  iommu/vt-d: Fix UCTP context table slot when copying root entries

Dmitry Antipov (1):
  iommu/vt-d: Use kstrtoint_from_user() in dmar_perf_latency_write()

Guanghui Feng (1):
  iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared variables in
    flush loop

Kevin Tian (9):
  iommu/vt-d: Fix no_iommu to disable platform opt-in
  iommu/vt-d: Force requesting ACS when tboot is enabled
  iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
  iommu/vt-d: Consolidate dmar policy management and force_on logic
  iommu/vt-d: Use dmar_can_force_on() for platform opt-in
  iommu/vt-d: Call dmar_can_force_on() for tboot opt-in
  iommu/vt-d: Remove the 'force_on' variable
  iommu/vt-d: Remove dmar_disabled
  iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit

Li RongQing (1):
  iommu/vt-d: Use logical OR operator for privilege mode check

Lu Baolu (6):
  iommu/vt-d: Cache max domain ID to avoid redundant calculation
  iommu/vt-d: Fix shift overflow in qi_desc_dev_iotlb_pasid()
  iommu/vt-d: Clear Present bit before tearing down copied context entry
  iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
  iommu/vt-d: Tear down scalable-mode context on probe failure
  iommu/vt-d: Flush context cache with correct SID when tearing down
    aliases

ZhaoJinming (1):
  iommu/vt-d: Fix copied_tables bitmap leak on error in
    copy_translation_tables

 drivers/iommu/intel/iommu.h   |  89 +++++++++++++++++-----
 include/linux/dmar.h          |   1 +
 drivers/iommu/intel/cache.c   |   5 +-
 drivers/iommu/intel/debugfs.c |  16 +---
 drivers/iommu/intel/dmar.c    |  96 ++++++++++++++++++++---
 drivers/iommu/intel/iommu.c   | 139 +++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c   |   9 ++-
 drivers/iommu/intel/prq.c     |   2 +-
 drivers/iommu/intel/svm.c     |   2 +-
 9 files changed, 250 insertions(+), 109 deletions(-)

-- 
2.43.0

