Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9514265
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266765; cv=none; b=LGfWBGaRpYm0lLgO7Rs7EPUVnJdtZBD3owZyT/oT+FTMA8e5HliujNo+rweI9OJcNwVVxwhzfF+Cm56BPLxk1FVF/QojZQWo+gG+PMbdP/WLdmF9LaUlljDNguDsJ2lDJS00o2lP8Iwv7YZrpyUz+vnX5qeONNp9x+DkdoBJ0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266765; c=relaxed/simple;
	bh=Wl5UNtFVk8ZXZ4K+eceGuSpgE0BVMziZ4gm24eGRtS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rySy+6DDOnmNCMWhppNeU5wsWLSfAKFqR6RNPyIzKGk149OI0LI1CYPJzSQ5dGiq0L4zZJeJconZQAp7euWK8KNgy3tTEY08yRp8nN50nwQ5SlU7AZnL1EwK4nnhkN8Ee1gypRfcoOCPsKwKtoHCpsKX5VLdR+Qcp62Ydf4jc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcJK4Y4e; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcJK4Y4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706266755; x=1737802755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wl5UNtFVk8ZXZ4K+eceGuSpgE0BVMziZ4gm24eGRtS0=;
  b=FcJK4Y4eqGYRvbuIzCea3g2dO86nxfMT7gD1VGBZekE2n82eQtqn2FuW
   pPecwkZVgkRHiqXkVSkKjYJrjW7qPRPrp9ur5Ar9VjvGFy1oZd6TqtmNN
   TEvuknhZLKCSOvZabtyOEjQ8ADmS+DMbWW2leraHDTlWCXXCYrGJmehBl
   /2JL37zKFK7c6goK3WrohT7LLoqRfcTfB6NaK7oKJoE3KBMJbKZoEcbfK
   KiNB6D+xEkVxLY/mnS+CJVIM+RBNEIO31N7sXQhFYQG+rSnltxvZsW3lw
   6nwSN9X9cpXK4ahGCgSkWFsrauyqU7fnbEevT0RiwaHoA0JzpNT5sK9th
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9123352"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9123352"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 02:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857367824"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857367824"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2024 02:59:12 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] Use right iommu_ops for mock device
Date: Fri, 26 Jan 2024 18:53:39 +0800
Message-Id: <20240126105341.78086-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
for the device from dev->iommu->fwspec if this field has been initialized
before probing. Otherwise, it will lookup the global iommu device list
and use the iommu_ops of the first iommu device which has no
dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
device on x86 platforms where dev->iommu->fwspec is not used.

Probe the right iommu_ops for device by iterating over all the global
drivers and calling their probe function to find a match.

Change log:
v2:
 - Iterate over all the global iommu drivers and calling their probe
   function to find a match.

v1: https://lore.kernel.org/linux-iommu/20240111073213.180020-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu: Use mutex instead of spinlock for iommu_device_list
  iommu: Probe right iommu_ops for device

 drivers/iommu/iommu.c | 98 ++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 39 deletions(-)

-- 
2.34.1

