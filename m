Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17B7B
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330665; x=1709866665;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+VIsfsC+ed2JLTW7RF02HMNBvU/A0rEn7DhKk0iBQSM=;
  b=KS01tzCBQWnBOzBFBsSAMgrqNVLJmxLQ75m7hOYOFTkiVSfcwtMkg1Pk
   3GOsW4YFL1OKaW84/1SXjxU7BmmiERsN/1DaBTGw6GL/nGdKvgn6Opl+G
   RFs/0P/qHTaihoK+E0mVF3ob8SwB9DgD8CF7KP7Ap5GxuiU8gb4M1xvX6
   O1Xq+FdStV+/CKIg5BQ/F9IA281ICIEbChNXgIgrDvxu/i+oZUK5f6nLt
   zybxysvpBlqnFEUkMlRrPFjdYZTDcU50PUQdWSUHUTDc0Up2hJ392sUw1
   Nopk59vHFtKUNUtwXSnoptHdTaJJ9yqjKUcdTpuix0HmkoUoWWRH3Egs9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316732630"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316732630"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746144602"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746144602"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 18:57:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	dmaengine@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/5] Refactor code for non-PRI IOPF
Date: Thu,  9 Mar 2023 10:56:34 +0800
Message-Id: <20230309025639.26109-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing SVA and IOPF implementation assumes that devices report I/O
page faults via PCI PRI. This is not always true as some emerging
devices are designed to handle the I/O page faults by themselves without
ever sending PCI page requests nor advertising PRI capability.

Refactor the SVA and IOPF code to allow SVA support with IOPF handled
either by IOMMU (PCI PRI) or device driver (device-specific IOPF).

This series is based on v6.3-rc1 and also available at github:
https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-refactor-iopf-v2

Change log:
v2:
 - Separate a fix patch and merge it into v6. 3-rc1 [commit 60b1daa3b168
   ("iommu/vt-d: Fix error handling in sva enable/disable paths")]
 - Disallow device-specific IOPF is device advertising PRI capability;
 - Add some extra patches to move all IOPF related code to the IOPF
   enabling/disabling paths.

v1: Initial post
 - https://lore.kernel.org/linux-iommu/20230203084456.469641-1-baolu.lu@linux.intel.com/

Lu Baolu (5):
  dmaengine: idxd: Add enable/disable device IOPF feature
  iommu/vt-d: Allow SVA with device-specific IOPF
  iommu/vt-d: Move iopf code from SVA to IOPF enabling path
  iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
  iommu/vt-d: Move PRI handling to IOPF feature path

 drivers/dma/idxd/init.c     |  31 ++++++++--
 drivers/iommu/intel/iommu.c | 120 ++++++++++++++++++++++--------------
 2 files changed, 100 insertions(+), 51 deletions(-)

-- 
2.34.1

