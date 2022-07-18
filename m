Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A57FC
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 01:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658107714; x=1689643714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iSzfrdEqebPw4+c2ygjk35cjtYfG15dYAOW7Bi0/ihU=;
  b=m/MUC18u/DHVZfmTL2apwpjcGKHnaZXQlBWiq08iW/LhKtL33sTZavZW
   BlnK3IA7Y2XgKNaqzfJsZBUCNEqTpfrHrYlx9gvd8mjkICt90TBArAbhf
   khwE4nctI6/wTAAazo1PgeNLeprs90LCuHEX+wfL6mg6mnHq0EWuQa7AC
   V1T0aDZA/hCFhUrIxrXtwOsT+e8TBZK+Tq4NFYwtvXYGfrIQUPytalPlx
   4mbG1lR7EcUsvBNzVYeqNoQ5YRHSqZhHJFTwB6O7xubPKwj9bVFX/TveE
   MxYw/e7aUTXfye2wSnSISlnZ3fEUPQNoOKBMRCuFNJn75rDsKZ4yje9y1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="266513493"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="266513493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:28:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="547294019"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:28:30 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: dave.hansen@intel.com,
	len.brown@intel.com,
	tony.luck@intel.com,
	rafael.j.wysocki@intel.com,
	reinette.chatre@intel.com,
	dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	ak@linux.intel.com,
	alexander.shishkin@linux.intel.com,
	Chao Gao <chao.gao@intel.com>
Subject: [RFC v2 0/2] swiotlb performance optimizations
Date: Mon, 18 Jul 2022 09:28:16 +0800
Message-Id: <20220718012818.107051-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intent of this post:
 Seek reviews from Intel reviewers and anyone else in the list
 interested in IO performance in confidential VMs. Need some acked-by
 reviewed-by tags before I can add swiotlb maintainers to "to/cc" lists
 and ask for a review from them.

Changes from v1 to v2:
- rebase to the latest dma-mapping tree.
- drop the duplicate patch for mitigating lock contention
- re-collect perf data

swiotlb is now widely used by confidential VMs. This series optimizes
swiotlb to reduce cache misses and lock contention during bounce buffer
allocation/free and memory bouncing to improve IO workload performance in
confidential VMs.

Here are some FIO tests we did to demonstrate the improvement.

Test setup
----------

A normal VM with 8vCPU and 32G memory, swiotlb is enabled by swiotlb=force.
FIO block size is 4K and iodepth is 256. Note that a normal VM is used so
that others lack of necessary hardware to host confidential VMs can reproduce
results below.

Results
-------

1 FIO job	read/write	IOPS (k)
vanilla		read		216 
		write		251 
optimized	read		250 
		write		270 

1-job FIO sequential read/write perf increase by 19% and 8% respectively.

Chao Gao (2):
  swiotlb: use bitmap to track free slots
  swiotlb: Allocate memory in a cache-friendly way

 include/linux/swiotlb.h |   8 ++-
 kernel/dma/swiotlb.c    | 127 +++++++++++++++++-----------------------
 2 files changed, 60 insertions(+), 75 deletions(-)

-- 
2.25.1

