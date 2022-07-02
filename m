Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D291849
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 02:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656727248; x=1688263248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VMlxlWrP1ErjumYvh2kyBvw6utshI62Qz8CCa6LtuXs=;
  b=P+i+7VnyFWkabLjrJ/g5BJSymURuGcCUB66OsHNbacvMYF6Cyx8pgjv4
   ZPunZfzl+ev7sB1nrN9fXNhfiSqSzb3pzVqweSD2vI1WL/30wOlxGx4nw
   CuuY3IiaIjtn9+o3s2uHs5GvWaL0HhZUQG8HUQ4TKj1541ze5Dtqbn1iq
   M5N9mRCkAzfUtwk+3yG7AA6Rgg4iPgFfKFTVnzdFAaGix2h3zVlCnWvAp
   xap4E4crzgG/RQKreMvPtY1lj7HnvKwi2jXDtUk9whsr5Ta8efNXFuB9u
   Iu6QLil/O2CkwoapL/5lzfWgyhr1TqqVq7RLi+hXpr3bz5lIxbGRUraM8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281539705"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="281539705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="589518325"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:00:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Steve Wahl <steve.wahl@hpe.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Mike Travis <mike.travis@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/6] iommu/vt-d: Remove unnecessary check in intel_iommu_add()
Date: Sat,  2 Jul 2022 09:56:08 +0800
Message-ID: <20220702015610.2849494-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220702015608.1A-eN9vhdzWEHW9TO2snXDT8F8hXlLbWaedFcn3QpyI@z>

The Intel IOMMU hot-add process starts from dmar_device_hotplug(). It
uses the global dmar_global_lock to synchronize all the hot-add and
hot-remove paths. In the hot-add path, the new IOMMU data structures
are allocated firstly by dmar_parse_one_drhd() and then initialized by
dmar_hp_add_drhd(). All the IOMMU units are allocated and initialized
in the same synchronized path. There is no case where any IOMMU unit
is created and then initialized for multiple times.

This removes the unnecessary check in intel_iommu_add() which is the
last reference place of the global IOMMU array.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 70408c234f5b..d79c48c5fc8c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3463,9 +3463,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
 
-	if (g_iommus[iommu->seq_id])
-		return 0;
-
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
 	if (ret)
 		goto out;
-- 
2.25.1

