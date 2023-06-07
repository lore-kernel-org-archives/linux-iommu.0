Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451A7C
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 03:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686110006; x=1717646006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=075khLrPsaylNwjI1Hcf0TEQzPBC5O5WohuQUXG8IA0=;
  b=iDolyg0CGwER6LSIJBrIdOcr+IiPkHUkLNrbZfzRYNpfH7YvB10LHk6i
   sjcFznWI4oM9J5zJSDS2IDhmWOhD5bu5nvGFPI7hi6IpG9DKVJjcVIj1A
   00EGXtAYVxQXykBaOmC9ougE5PL6lF8KoXo5n3nQZAA38Y0S+POb6peBV
   0ZBdsf3a2/6krjDQn76Fm3Z8nAkDtRBJB+s0FTpnA4vYAhJtWqGPsSG5O
   5n6GjQBAnxGrgtbadUYiVKmF00wEeM3kJx/jijmMvmnQoJCe0HN7sXloa
   cBlSg7p/ccpYCaZzCduhAT8A2WFMNhGGsvivj2NlPh8U8+z/7yYzV8Dxh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385186334"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="385186334"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 20:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="799125349"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="799125349"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2023 20:53:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] Prevent RESV_DIRECT devices from user assignment
Date: Wed,  7 Jun 2023 11:51:43 +0800
Message-Id: <20230607035145.343698-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are follow-up patches on this discussion:

https://lore.kernel.org/linux-iommu/BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com

I just summarized the ideas and code into a real patch series. Please
help to review and merge.

Best regards,
baolu

Lu Baolu (2):
  iommu: Prevent RESV_DIRECT devices from blocking domains
  iommu/vt-d: Remove rmrr check in domain attaching device path

 include/linux/iommu.h       |  2 ++
 drivers/iommu/intel/iommu.c | 58 -------------------------------------
 drivers/iommu/iommu.c       | 39 ++++++++++++++++++-------
 3 files changed, 31 insertions(+), 68 deletions(-)

-- 
2.34.1

