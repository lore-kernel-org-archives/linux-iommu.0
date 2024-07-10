Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67512BEBB
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600596; cv=none; b=VQFKLqjHPUhk06QKya02cm2Zs2XX7cjfcYVDwAiEJazY6KIRCD8yf+tKK5mhGzsCyylZF8ACBj2jmXpjMndgchMo5eq3oPZAfZl9QtjWwW+NqkE+tRzhixtfCy2375cWaYQ0U4Rje8ZFTmzSIy7+4kjbnTXMssjDUdFzNEtJ99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600596; c=relaxed/simple;
	bh=RBBisoNzr9TB3QnmsBQJXxD6dWDj+sa6TbFMt7V32ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qoKWOY9LW2iIm5LBDT+oLLQvwNSQpa6qGsr/CnTAT/G/hXMPAHNuHHQcugDEnHtcf+2gau1WB1Mey9NM+EX3ENe8nE82+CdLnJn3B0ZspblTdU8YSNInhcry7PZWj7VcRKNSZCAPxJD0V1Coxlqek8khyMXiaQgRXR+HSDm3+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzRxa/hq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzRxa/hq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600595; x=1752136595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RBBisoNzr9TB3QnmsBQJXxD6dWDj+sa6TbFMt7V32ak=;
  b=jzRxa/hqYIJiEA7eYRVqRFSiwb1RTf32SbAtEIejRJjDPDec/DsH0wPU
   ft0pKqQVmtV9Yt5IcbPIwLKq7cMuFPwDYvli4gdIboSk4jBGB/LmYfb3y
   aajcyP8LKDs6R6PN2hhRp8Q9ok+ugIFgSYPPBI5VlrcUuQMIHpUiKDpfD
   2+UUqCbui8r1myM5D40uuFDWXkKePH+QMvAuYSTbPhrHv0RHxFnH20Pxm
   gdgl/fFamCqfPhCS5/Rmx/rgI+5FXE3V7eOw0Qz5HGF5Wqjei/opVS4BN
   Uy1/4lMJEVxHGTGf7IGqMUkhY9R4z9RpBdhCn5A9gg4pBQWAtIcDt1St7
   Q==;
X-CSE-ConnectionGUID: IsX2bZXwQV6xVBrDm/71lg==
X-CSE-MsgGUID: 7GEWSeE+TRexnjI3yvck1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17770953"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17770953"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:35 -0700
X-CSE-ConnectionGUID: NxrwHnxWQYSYQtgQpnawLQ==
X-CSE-MsgGUID: XUkfYUZHTweasDil1Bb0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48236116"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 01:36:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommufd: Avoid PRI Response Failure
Date: Wed, 10 Jul 2024 16:33:38 +0800
Message-Id: <20240710083341.44617-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow-up for the discussion that happened here.

https://lore.kernel.org/linux-iommu/20240709173643.GI14050@ziepe.ca/

It prevents user space from responding to a group of page faults with a
response code other than IOMMUFD_PAGE_RESP_SUCCESS and
IOMMUFD_PAGE_RESP_INVALID, which will be treated by the device as
Response Failure according to the PCI spec.

Please help review and comment.

Lu Baolu (3):
  iommufd: Remove IOMMUFD_PAGE_RESP_FAILURE
  iommufd: Add check on user response code
  iommu: Convert response code from failure to invalid

 include/uapi/linux/iommufd.h  | 4 ----
 drivers/iommu/io-pgfault.c    | 2 +-
 drivers/iommu/iommufd/fault.c | 6 ++++++
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.34.1

