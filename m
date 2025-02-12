Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D871FBC86
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340344; cv=none; b=FAB9noeRFMj8dBExvmyKBiLfmjv3Nz4K0gweMxJiyH1DDlxBfFumC7oFVzudlbIW9yMwuOJ4JK9vs7MjS9sgkH+DPFNpfNqig7aRfnuOYs6dstH1tB6nw/qGGIC45OjQI0M2z+xbTRiZJzEHJEr/HCe6WFzVo6yNgpVVa83x/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340344; c=relaxed/simple;
	bh=sNwPmdsHuqRISvv8TKKAtwf+5/7PtMBM42IUv4+DEAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZQF8NE9RV+aPrWi2AjmHRXU/utpIOPppr1WGrF8GJNGFl3CZhd6gm0cwetGfRiDHPHgGnNyp6HXX/xGcePBRW62SupIK/4nyl4Lk6Ubb2dWledSRv5vUiOznfcglARprojwMpj6RlzsHF2BoaSyqg48KNsIBdwKXsJAP2gjkj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrwIjKiR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrwIjKiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739340343; x=1770876343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sNwPmdsHuqRISvv8TKKAtwf+5/7PtMBM42IUv4+DEAk=;
  b=hrwIjKiR/KptqejwM4KoCtFqEWOLTetkLMoNFUt6GSbEU7W0KW7qQKMK
   UHtyhRM5Vi0lFjiwVk3wVC7AXGZZfRVJXIINu8JpQYLk2L+RFR7COT+Fc
   CUErLLOMPZckpcJ+S32MqNf2X0YuVBIHEkDuaPK8Ro1Y7RVnoe04Ripus
   GWWFMiRxwvCmYjWmf9hyGH3JchpuAuJcaAhpKtTVIiby21MEjtS8077V5
   dHgK9fOFMs+xAWsN74WXVx1Nz4ytVJZ5hnsgICfQ4S1pUkwcrgyZ+zUXx
   QO4SRws7FxAGW8ybXIZe+sDTd786nD5lzLoikaDnhuZoo9sv0kdH9lo5w
   Q==;
X-CSE-ConnectionGUID: kO9DxSP1S0KkCm7kf45YDQ==
X-CSE-MsgGUID: X2Sn82Z/Qoiwy0k8cafgqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57391218"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57391218"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:05:42 -0800
X-CSE-ConnectionGUID: SJWrPAamSGWp7MRutbgdig==
X-CSE-MsgGUID: OMi83F4ASMeFg64fSG4PdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117899985"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 11 Feb 2025 22:05:42 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com
Cc: kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org
Subject: [PATCH 0/5] Misc iommu_attach_handle enhancements in iommu core
Date: Tue, 11 Feb 2025 22:05:35 -0800
Message-Id: <20250212060540.261436-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to enhance the iommu_attach_handle-related APIs
in the IOMMU core. The changes build upon Nic's previous series[1], which
ensured that users of the attach/replace handle APIs always provide a
valid handle. With this foundation, the series refactors the IOMMU core
to share code between the normal attach/replace APIs and the
handle-supporting APIs. Additionally, it seeks to avoid processing Page
Request Interrupts (PRIs) before the attach operation succeeds. Ultimately,
the group->domain becomes redundant and is retired.

This series also covers the prior series[2] which only takes care of the
iommu_attach_device_pasid().

[1] https://lore.kernel.org/linux-iommu/cover.1738645017.git.nicolinc@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/20250120030840.4171-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (5):
  iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
  iommu: Drop iommu_group_replace_domain()
  iommu: Store either domain or handle in group->pasid_array
  iommu: Swap the order of setting group->pasid_array and calling attach
    op of iommu drivers
  iommu: Retire group->domain

 drivers/iommu/dma-iommu.c  |   3 +-
 drivers/iommu/iommu-priv.h |   1 +
 drivers/iommu/iommu.c      | 254 +++++++++++++++++++++----------------
 3 files changed, 151 insertions(+), 107 deletions(-)

-- 
2.34.1

