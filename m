Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097123C50A
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672641; cv=none; b=c6rEjl+/31FulYlbHKjwlXJ3xyzfV1o6/9KN+0WNec1LW37msuGH1Ssn+AUeWGIX799g1OuKILiu2aGIW8VAWq4OiYYMlXKcBwDGGkgShIqBriC6i+H2eUY8LJLwpmrBuVvMwvA9nrD04du94lGdGk0Z0IyfZvqf5eAu4hX7pcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672641; c=relaxed/simple;
	bh=9p11Hyt81JNcS9fjYemVYbwq6Vxf3cd2Wgu+6SP6ugE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RAfKXOse+oJPvhHNaO96V+5RflgVXGdRINtz+VceuMqmeRf230CpGFRCP5EwaG/RQ5+hclg6GU7Uc/24Ko8pjo1FWAHF/KY8KevJJPVPVvpXmIa0M4kbcLHCNBcfxnawUVi7IbOyHTu1vqsThiROV+EicEM8RQPoFV1G6UyTjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzQihwD5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzQihwD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750672640; x=1782208640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9p11Hyt81JNcS9fjYemVYbwq6Vxf3cd2Wgu+6SP6ugE=;
  b=UzQihwD5dulO1b0rWIX6zo9Xczl4b7CmABBHzabJA5Jj0foDKGYqp17A
   MLN40OWtXSW1eUAWpV8Lsui0LGfNji6jA4kZCSKV6JkEiJHBl3HhSaZx0
   TgwaE5s9yB/nrs5eIvqSKXry4QNjw1N6wfOKMZDjzr6voqZ454CFs2H4e
   IVmgiblYeHigEBhBOBECmOqLlISUM0Kon1Ehrvrkm/kmzKVV+2tZsZgyt
   8bAndLqworBLRG7vrgYS9qQQFtqhWOXlzo+EhqqbsT96NkzXoafA+hrBW
   dsbYgo0oyLL8eF2IHPMEu8scwCKZtbpjysWnJA8RFJstC1AyANo4ZEIUA
   A==;
X-CSE-ConnectionGUID: eHQMEoCoTXOZsl64mw/1BQ==
X-CSE-MsgGUID: 9N+1p4R5TU6Nra2Twx8y6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="78285780"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="78285780"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:57:20 -0700
X-CSE-ConnectionGUID: BhxICe9nR7uH5yk1yEvr7g==
X-CSE-MsgGUID: NtWGDheBST+OxrY16hiK+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155859329"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jun 2025 02:57:16 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v2 0/4] iommufd: Destroy vdevice on device unbind
Date: Mon, 23 Jun 2025 17:49:42 +0800
Message-Id: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of Aneesh's patch [1].

It is to solve the lifecycle issue that vdevice may outlive idevice. It
is a prerequisite for TIO, to ensure extra secure configurations (e.g.
TSM Bind/Unbind) against vdevice could be rolled back on idevice unbind,
so that VFIO could still work on the physical device without surprise.

This patch revives some Nicolin's vdevice_alloc change in v5.

[1]: https://lore.kernel.org/linux-iommu/20250610065146.1321816-1-aneesh.kumar@kernel.org/
[2]: https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com/

Xu Yilun (4):
  iommufd: Add iommufd_object_tombstone_user() helper
  iommufd/viommu: Fix the uninitialized iommufd_vdevice::ictx
  iommufd: Destroy vdevice on idevice destroy
  iommufd/selftest: Add coverage for vdevice tombstone

 drivers/iommu/iommufd/device.c          | 43 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h | 34 ++++++++++++++++++-
 drivers/iommu/iommufd/main.c            | 32 +++++++++++++-----
 drivers/iommu/iommufd/viommu.c          | 34 +++++++++++++++++--
 tools/testing/selftests/iommu/iommufd.c | 13 ++++++++
 5 files changed, 144 insertions(+), 12 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1

