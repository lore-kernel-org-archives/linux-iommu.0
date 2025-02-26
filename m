Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99400137E
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740546094; cv=none; b=I/R9swE32tQX6LHWWvaehPENw5lk/IIN8qnAw54VHTOu8EYKbX925hTXt6BTnAyjKigEi2a+yXGb04FXTZgsOHB7Sh0E5U+W7XtVPc5tBCVLrpP6Lirnreq/ffshtW3RZdsJfkkc3LfLG3E8vQ8rXeqNAGnW+rcOOSQ0k+1zLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740546094; c=relaxed/simple;
	bh=T2RqmxOxupUWCyJ4fcBSoFpzwC7R3rs/vfV14bk2AQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sSmZ4QrVK/Vn6srSbhyoZo37QpgNXVwsdf70qKxC7G4ewEqQxUFygX0k0cP+5SJcX5AaoO8ZwnvD8qAnoVglxqQU7warI+NuWbJUhAJZJredDI8bLMdFTLH6GJUuugNSYpKqr72qFLtHhjeUc/0DmKODYnYSY1DhqiWaI0iK2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfTKq78D; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfTKq78D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740546093; x=1772082093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T2RqmxOxupUWCyJ4fcBSoFpzwC7R3rs/vfV14bk2AQk=;
  b=cfTKq78D657LGMVpYMMf7PKAlmHzeAuNgQhS6QoE7o3jfh9Cp8tlxYCz
   LLsErAMT+vYvPG+ErqZ0ll/wJaiFQQaV0RL1F6+RzrwtmAq2pk0mN6fJV
   Oj5wSfxrSN/mSoOg3T8Rt/533Iujgj6ew5V1T/ndzLVV1kP6AsV5xgExy
   BdFiTK49HOWquzHWQqCSrdtXiQVS3YRnZ8RIjA6aD8osLOcQjT2SedRAb
   5u5himUkw5HNLmcrfCk7rfWWDyLt56AzH8Ne9JjuIY/40b8d3t8QKLmsZ
   tOnl/4gjH9Wu5cUowKB8okVl3efNn3lAjVHxLf1IOpWrKTmKA7GmrMqYI
   A==;
X-CSE-ConnectionGUID: O5CukGmST52WZYMsUQzkww==
X-CSE-MsgGUID: w+R+sgQMQ32r5F/B7TZ3sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41396677"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41396677"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:01:33 -0800
X-CSE-ConnectionGUID: d5H9cEBkSwu1lEnUgRkkPQ==
X-CSE-MsgGUID: y3NUgP8DS2abzlvjYM1T9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116385393"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 25 Feb 2025 21:01:33 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH 0/2] Add an iommufd selftest for replacement between domain and handle
Date: Tue, 25 Feb 2025 21:01:28 -0800
Message-Id: <20250226050130.5814-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now iommu core has two sets of group attach APIs for RID. One is with
handle and another one without handle. iommu core allows replacing a
group which has been attached via the API without handle. However, no
known code used it yet. Add an iommufd selftest to cover it.

Based on the below series:
https://lore.kernel.org/linux-iommu/20250226011849.5102-1-yi.l.liu@intel.com/

Yi Liu (2):
  iommufd/selftest: Add a helper to get test device
  iommufd/selftest: Add coverage for RID replace between handle and
    non-handle

 drivers/iommu/iommufd/iommufd_test.h          |   5 +
 drivers/iommu/iommufd/selftest.c              | 134 ++++++++++++++++--
 tools/testing/selftests/iommu/iommufd.c       |   2 +
 .../selftests/iommu/iommufd_fail_nth.c        |   3 +
 tools/testing/selftests/iommu/iommufd_utils.h |  18 +++
 5 files changed, 151 insertions(+), 11 deletions(-)

-- 
2.34.1

