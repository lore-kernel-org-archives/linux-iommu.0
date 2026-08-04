Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E3443E3E
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887665; cv=none; b=bp1iZr+bJFSDMwsqVfSVsaH4+B5Pkh240WwJI0ZDaM6EmmFpiH9+0GKtguchMFEHzGBOZ+PCba0V2GGTd4sMgJaP0ZQa0wtg8t6+FkAk6lt7xyoGJKTsjqTVB9FqWyxNNYPxWgCpGjiuxrtiwkdAOn1eSF8/Sx/0FbM6Xehz9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887665; c=relaxed/simple;
	bh=qolPm8tNTECeTIYz3z4ZWnFY1BA8uMjw4rPWPseG7Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POJ8HMPCBZY+WFiIyp9PBPO7n4V4qWptvlCrTFlC5iZfjUYicWWQctcEvGMW8tYI2mnWcPm90Unk/+5K/A8U/hoNGLMenDH7EC0v5B/CZbCt0d5QxtPphskbI0hHSI7NG2iKnXMXQ3yo+WhMWoQM7BBTgE8q+bOUiVBvL/RQLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Owy98xpR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Owy98xpR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887664; x=1817423664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qolPm8tNTECeTIYz3z4ZWnFY1BA8uMjw4rPWPseG7Tk=;
  b=Owy98xpRSEYk/775J9KgZrKRHykhcTG20bZ7kmbhqPbc9NF0iOiU8pyl
   IHOFV7k2vTF1TFOp/Xt+E27Bk812iBJZ8WXRh0QJP1N/aojTqfayDU8ms
   kO74emniUnfdL6cA9KZMcecKqO/Ol9/psGm8GSNLVgifarPe/XP//N2Ja
   wx+vY9PFxSk2zpuElyhpEm5L7E3eFcIDXUGl9BTX3C01gCGE2xejSGkEa
   uvlYlC8+M9brUd8GVDTwkjcGJg/89tcucYj5MXZKh3GB2i0vX7iJ78F0P
   GunLyqR8v1o4URqT7O+cNYHHCs4T6wJOuHwu1Lfbe+0P/3rKOaXKBaEHe
   w==;
X-CSE-ConnectionGUID: R3z/cWIDTwe8nPhNgNQXjw==
X-CSE-MsgGUID: 2XQMIqBfRySf5L3RMcxLaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263163"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263163"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:23 -0700
X-CSE-ConnectionGUID: jbPqaG0XQ5+Hxha/iN6TFg==
X-CSE-MsgGUID: T3zTI14NS5WuS3xqTOh7IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324283"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:21 -0700
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
Subject: [PATCH v2 00/19][PULL REQUEST] Intel IOMMU updates for v7.3
Date: Wed,  5 Aug 2026 07:42:54 +0800
Message-ID: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
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

Change log:

v2:
 - Sashiko reported a critical issue in the previous PATCH 16/20. Remove
   that patch from this series. It requires more investigation time and
   will be submitted as a separate patch.
 - Add comments to the commit message of PATCH 03/20.

v1: https://lore.kernel.org/linux-iommu/20260804023714.3080506-1-baolu.lu@linux.intel.com/

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

Lu Baolu (5):
  iommu/vt-d: Cache max domain ID to avoid redundant calculation
  iommu/vt-d: Clear Present bit before tearing down copied context entry
  iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
  iommu/vt-d: Tear down scalable-mode context on probe failure
  iommu/vt-d: Flush context cache with correct SID when tearing down
    aliases

ZhaoJinming (1):
  iommu/vt-d: Fix copied_tables bitmap leak on error in
    copy_translation_tables

 drivers/iommu/intel/iommu.h   |  73 ++++++++++++++----
 include/linux/dmar.h          |   1 +
 drivers/iommu/intel/cache.c   |   5 +-
 drivers/iommu/intel/debugfs.c |  16 +---
 drivers/iommu/intel/dmar.c    |  96 ++++++++++++++++++++---
 drivers/iommu/intel/iommu.c   | 139 +++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c   |   9 ++-
 drivers/iommu/intel/prq.c     |   2 +-
 drivers/iommu/intel/svm.c     |   2 +-
 9 files changed, 238 insertions(+), 105 deletions(-)

-- 
2.43.0

