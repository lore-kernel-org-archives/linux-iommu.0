Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DF79EA
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592593; cv=none; b=stzptzzi1iuRWLZyUnuBFZ/lfIbulOAHP5cB29jiETcHsWW/w6bNvHuy44uz6mcr07wZ5H2bXoPJDRbhWutEBrqias092cIn2xEL8NaVBl4g4tH/ws7hGHaL5QGp956EnIrXo48cV01KMn/R+XeDq3PTgXnJ6IOpub2KkeqCN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592593; c=relaxed/simple;
	bh=IRW1uC71joWZcrsE1fj7twP6y+QOF1/7H0nNSSijBHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QFz2lomc5DCIPf1XfwMqpXfm9B5f7OoFjEeQdN4obvU6hGBotkI3+bPqoR6q1Ctr5tT+uwHwe2N0TLjbyPNIN1rd8Jf13oxmibxI4Fr4HKQ9LeHPxmMlGD/Hjv36mTjeTW2e0M31YbMhCHcZB+mgBp5lcDK59qBbdCf97C9f1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiNndbcl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiNndbcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708592592; x=1740128592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IRW1uC71joWZcrsE1fj7twP6y+QOF1/7H0nNSSijBHE=;
  b=BiNndbcloGSeZkKXPjF5FjsSkU92cfHBf7E12LDA1oUTNXadcb/oL1Mu
   oaxj5umZbEkKjG/s6VskUsk+RgKWVmG8NUS0oTJGoXOoFHgz29M+Zc55F
   RitVQobEObhzh187kdkt0MMiFAOSSDMkNKlWwALPnmE7Ifqx2xlWuHBJZ
   RlinBZwjyuZSEA0k2OKxhENJo8lXkn3L4C93e2R5MddGU7D14It5OcMrD
   E8oS0KjpgiS47fzxbHkwM00UPDUQPI7TDoXVAVRmt56RfI0WVHJS7uO0B
   N0bE372+BFkxsvXB5fmBK/1uHX8sXrhCl5Bj2Aj+fAXTPZ/qLNQnf72dV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25264406"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25264406"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:03:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10122584"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa003.jf.intel.com with ESMTP; 22 Feb 2024 01:03:05 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v13 0/3] fix vt-d hard lockup when hotplug ATS capable device
Date: Thu, 22 Feb 2024 04:02:48 -0500
Message-Id: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is used to fix vt-d hard lockup reported when surprise
unplug ATS capable endpoint device connects to system via PCIe switch
as following topology.

     +-[0000:15]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
     |           +-00.1  Intel Corporation Ice Lake Mesh 2 PCIe
     |           +-00.2  Intel Corporation Ice Lake RAS
     |           +-00.4  Intel Corporation Device 0b23
     |           \-01.0-[16-1b]----00.0-[17-1b]--+-00.0-[18]----00.0
                                           NVIDIA Corporation Device 2324
     |                                           +-01.0-[19]----00.0
                          Mellanox Technologies MT2910 Family [ConnectX-7]

User brought endpoint device 19:00.0's link down by flapping it's hotplug
capable slot 17:01.0 link control register, as sequence DLLSC response,
pciehp_ist() will unload device driver and power it off, durning device
driver is unloading an iommu device-TLB invalidation (Intel VT-d spec, or
'ATS Invalidation' in PCIe spec) request issued to that link down device,
thus a long time completion/timeout waiting in interrupt context causes
continuous hard lockup warnning and system hang.

Other detail, see every patch commit log.

patch [1&2] were tested by yehaorong@bytedance.com on stable v6.7-rc4.
patch [1-3] passed compiling on stable v6.8-rc4 (Baolu's rbtree branch).

change log:
v13:
- rebased on Baolu's rbtree patchset.
- removed refactor patches [3/5][4/5] in v12.
- amend commit description of patch[3/3].
v12:
- use base-commit tag to format patch.
- fix building issue on v6.8-rc2 repported by lkp@intel.com.
- https://lkml.org/lkml/2024/1/28/535
v11:
- update per latest comment and suggestion from Baolu and YiLiu.
- split refactoring patch into two patches, [3/5] for simplify parameters
  and [4/5] for pdev parameter passing.
- re-order patches.
- fold target device presence check into qi_check_fault().
- combine patch[2][5] in v10 into one patch[5].
- some commit description correctness.
- add fixes tag to patch[2/5].
- rebased on 6.8rc1
- https://lkml.org/lkml/2024/1/25/1314
v10:
- refactor qi_submit_sync() and its callers to get pci_dev instance, as
  Kevin pointed out add target_flush_dev to iommu is not right.
v9:
- unify all spelling of ATS Invalidation adhere to PCIe spec per Bjorn's
  suggestion.
v8:
- add a patch to break the loop for timeout device-TLB invalidation, as
  Bjorn said there is possibility device just no response but not gone.
v7:
- reorder patches and revise commit log per Bjorn's guide.
- other code and commit log revise per Lukas' suggestion.
- rebased to stable v6.7-rc6.
v6:
- add two patches to break out device-TLB invalidation if device is gone.
v5:
- add a patch try to fix the rare case (surprise remove a device in
  safe removal process). not work because surprise removal handling can't
  re-enter when another safe removal is in process.
v4:
- move the PCI device state checking after ATS per Baolu's suggestion.
v3:
- fix commit description typo.
v2:
- revise commit[1] description part according to Lukas' suggestion.
- revise commit[2] description to clarify the issue's impact.
v1:
- https://lore.kernel.org/lkml/20231213034637.2603013-1-haifeng.zhao@
linux.intel.com/T/


Thanks,
Ethan
 


Ethan Zhao (3):
  PCI: make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: don't issue ATS Invalidation request when device is
    disconnected
  iommu/vt-d: improve ITE fault handling if target device isn't valid

 drivers/iommu/intel/dmar.c  | 25 +++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c |  3 +++
 drivers/pci/pci.h           |  5 -----
 include/linux/pci.h         |  5 +++++
 4 files changed, 33 insertions(+), 5 deletions(-)


base-commit: e60bf5aa1a74c0652cd12d0cdc02f5c2b5fe5c74
-- 
2.31.1

