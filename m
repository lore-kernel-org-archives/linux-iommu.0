Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1826A1B0
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154955; cv=none; b=dzO9pQ6ttQztJYavmOlS0u+RM+XXULlp7TbYf9YXwPEuEwITE51p+8HoCtNxrIoUmGmD/mf7eLS9Zlh6ICnzAbqrMrR8Gm45osQrESgEHH39ewRa7ONpooOKYD6xAOWLW3p7bZi4z92TIcltwK0H9Ibp+o+vXKK5kpFsI0gs1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154955; c=relaxed/simple;
	bh=QrHjcBEPSqtyHnm7bqouFTQBugkf7uG4RIpVyX8EUx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sxw96MCi3ItIAq/UN3LRjH7j78TMhiZbEpTpBe6fTLB7Sx3yV1ACeMvkxLjm7S4Ga1yt4J5ee3z0ZXJ1pM8o0/ey8wTyxEgGawvEPJzKut8GHONCupPnyDGV4inJRQf8FGHCDb4BsgyPZAuDkazKlRsOCA1gt3R+OxkHpnmBOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8csEbWs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8csEbWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154954; x=1783690954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QrHjcBEPSqtyHnm7bqouFTQBugkf7uG4RIpVyX8EUx0=;
  b=i8csEbWscKgm1DXes0J/UEIu/tD1dmpjaHRpgDwrh7g/nu/nA4jL2y5Q
   cIQppir27BMUPAEOg+v4ggcWt74hzYgvsQbkMwsX49khXCPIuGRxfsb1h
   RrUXQpFtlL56UKJJDBj45IPiBHnl5u/sE/5KrNLgQLPsya4aUnPpCF5Ph
   eraNJ001AFN2r61Ctv+i/n4zAKPSV0qzk39eJPInr4BvILMZrs+J7S2K8
   v64jHZHArDfn9Y8lHAJAMPr1ViWYyUXRLIYfZpki96zFcsqY4xuMUy7tg
   Jd15zjKarmevOfJjAuAqdDJ/kOdSh6uneVlO8kxcx43NaaGx/Z7eZwuBD
   g==;
X-CSE-ConnectionGUID: rpAQb2LsT0WfHR12JWtLbA==
X-CSE-MsgGUID: qWte8T12QBK6a+la/CXMRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65787667"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65787667"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:42:33 -0700
X-CSE-ConnectionGUID: reV4IG/xR6Gw2h6DzgzikQ==
X-CSE-MsgGUID: KwwLF/aXTiyA0dqAe4ugMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156809429"
Received: from gnrd8.igk.intel.com ([10.123.232.137])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 06:42:31 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH v1 0/4] Implement IOMMU SVA page fault processing error notifiers
Date: Thu, 10 Jul 2025 13:42:11 +0000
Message-ID: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a facility of notifying endpoint device
drivers of failing IOMMU page faults occurring for specific
Requester IDs.

According to the PCIe spec chapter "Page Request Group Response Message",
in case of Page Request processing failure (e.g., detecting attempt to
access pages with insufficient permissions, like writing to RO pages)
the system responds to the requester with a message containing a non-zero
response code. The requester device is then supposed to process that
response in implementation dependent way.

However, some endpoint hardware supporting SVA does not provide insight
on failed IO page faults, being limited to generic error reporting
(via interrupts and/or few register bits).

These series contain changes that provide endpoint device drivers
with the ability to retrieve information about page fault processing
errors (the most relevant being PASID and IOVA PFN).

Endpoint device drivers are able to set a callback functions
which will be called when a failing page fault (such as accessing pages
with mismatching attributes - e.g. writing to RO pages) occurs.

Normal processing path (i.e., swapping in or allocating backing physical
memory for non-present pages) is unaffected by these changes.

The endpoint driver code can then take appropriate actions, such as
fault reporting and recovery, sending signals to affected processes etc,
using the fault context provided in the fault parameter structure.


Sergey Temerkhanov (4):
  iommu: Pass the Requester ID in the fault parameter structure
  iommu: Add rid_notifier array to the dev_iommu structure
  iommu: Implement iommu_set_rid_fault_notifier()
  iommu: Notify requesters of IOMMU fault failures

 drivers/iommu/intel/prq.c  |  1 +
 drivers/iommu/io-pgfault.c | 53 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu-priv.h | 11 ++++++++
 drivers/iommu/iommu-sva.c  | 19 +++++++++++++-
 drivers/iommu/iommu.c      | 21 +++++++++++++++
 include/linux/iommu.h      | 19 ++++++++++++++
 6 files changed, 123 insertions(+), 1 deletion(-)

-- 
2.43.0

