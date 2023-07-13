Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495A629
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 04:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689222885; x=1720758885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wqmFSfNFiLpHxGf4UqAgLc6Gm83K5eey8IZvYJAOyWs=;
  b=dx41XFn1fGAEFav7qShhOyMFtFIAn+Cd7Zk4UM8OLzYMwwROKt8awX6J
   zK5gLJd8hiINfyzl3x22nia8clbq34b8GX2iih4oSUybFES7thVwXDULy
   mAVaFEqew7McVm2NAbr7/dgesjNZhGsGHSB1nWfVlOCYQGyf3qFxPw7Pp
   Y3vogaDyn0AtGlxvTw25l/nuSBWlUn+cPj3oe45V8RebC+ee0AFCnPMNf
   b3pGDcNDXVX9QBaIoOwcAjfKlGkZbNLkfdLtW5UIcKNtzwWVbnYQTJVpq
   9/b9CiQ4E429DDqVMysQT/0kRzpyuA/FFQ0uzxrFEY1hX4cYtWZAj1TxN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="344677961"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="344677961"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 21:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866400203"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="866400203"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2023 21:34:40 -0700
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
Subject: [PATCH v2 0/2] Prevent RESV_DIRECT devices from user assignment
Date: Thu, 13 Jul 2023 12:32:46 +0800
Message-Id: <20230713043248.41315-1-baolu.lu@linux.intel.com>
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

Change log:
v2:
 - Move "pg_size == 0" check out of the loop.
 - Rebase on the top of v6.5-rc1.

v1: https://lore.kernel.org/linux-iommu/20230607035145.343698-1-baolu.lu@linux.intel.com/

Best regards,
baolu

Lu Baolu (2):
  iommu: Prevent RESV_DIRECT devices from blocking domains
  iommu/vt-d: Remove rmrr check in domain attaching device path

 include/linux/iommu.h       |  2 ++
 drivers/iommu/intel/iommu.c | 58 -------------------------------------
 drivers/iommu/iommu.c       | 37 ++++++++++++++++-------
 3 files changed, 29 insertions(+), 68 deletions(-)

-- 
2.34.1

