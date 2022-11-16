Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44796C43D
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 05:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668576162; x=1700112162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FjurWFCvoXZKqf1tYBIy7z0E6td/viqNYdezBb3YLyA=;
  b=NE4h6RMc4ghypoEw+Z2ps2aC05rFU8cT5/HGvvXpU1IXsFL80Dz9Hj6M
   gJbGD5j5ABLq9u2wdGu497KuJsOf90m6qIkoIHMrbhYtpajC7C8dppcQo
   eCBe5dr8ouVMjjCjFf4ssjYsIYYKKax8EHxaow1FHFtdG7v0TCVsGA8MH
   PXRvPNJoCZxz99memqZpvXSrKhuNwJ9hor5DtNNVmLFiyfVdNvOX9oCqx
   GiGzjpKb1ixX6ACuHZbJzwB8aKXvF6MmUfaJ7JofV7iOAKuxvANTVyWwk
   6XT5XWoLOJ2jxskVbv2wGYW9aqK6yhldRB9tZKkfz57pdxiviktCm8ONd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295820134"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295820134"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 21:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702724770"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702724770"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 21:22:40 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc6
Date: Wed, 16 Nov 2022 13:15:42 +0800
Message-Id: <20221116051544.26540-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Below fixes are queued for v6.1. They aim to fix:

- Preset Access bit in FL non-leaf paging entries.
- Avoid setting hardware Reserved(0) bit.

This series is also available at github.
https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v6.1-rc6

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Tina Zhang (2):
  iommu/vt-d: Preset Access bit for IOVA in FL non-leaf paging entries
  iommu/vt-d: Set SRE bit only when hardware has SRS cap

 drivers/iommu/intel/iommu.c | 8 +++-----
 drivers/iommu/intel/pasid.c | 5 +++--
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.34.1

