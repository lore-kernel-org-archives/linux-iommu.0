Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09343137928
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544079; cv=none; b=Vof2/idj0EymZurchW0w1vRS7EW4Y/ZvJEYF4kHoLh0Hj2zq2tZEqN2Rakvt7ujIy+oPTwysTJ3gFEMUjUjykfxsRJy32O7Lk053oC08g4uOhUSwRheu+sJ0sI75vdtdhB+3PrP9NYlL6jgPeoqmBpKQXA8gqEgLjmKXQtrezag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544079; c=relaxed/simple;
	bh=cAVVRtstNbT74yvObIYd/Lue9LgPSI7eW9Y69qZk/C8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aK78Sl+T4B571Apu7YQe+671BTSkYRaWYl1VQ69ed/abYW6Ggu2t+rmWgOWhvNHD2IpuUrTJBo52mlu6M2C6gM8ci3CGt5nN5GW+TG+PcqfU1JUl2DeZ/EPlunMxYl/MKpSh/blP11stsM0xYzih/4OOY4QiUtneuFBqcye+cPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc9Fm7KQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc9Fm7KQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711544078; x=1743080078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cAVVRtstNbT74yvObIYd/Lue9LgPSI7eW9Y69qZk/C8=;
  b=Yc9Fm7KQh4CeZphCyz7ohdu5RwXTAbdRGmG4ZeG7oLPs1TKAD+aq+8PR
   1gi+gQKtE5KQf46d3peE9rE3t2K6nyHSMeSdvl3JnGrgZ5ot4mfnjXDde
   aTUVVkH+6kKRtlqFhcUnejNACytB7a/wh7dpYviCqTgCE16LgmC+kOGHW
   ZZQHZNlg4VL0LYqDixtxqHTP9/G45oPPn7zAvgyPVxH+8BHyh7Hw1+DIc
   gCU+rK2wx+6J5kxBsT44YQEC/7MRPEIq0CWoVFZvBUMAY3CmodgpXoVqz
   alO+EQmdAcAtY07JyiUxuinuBncDbPwVe4R766/pTzcCnIIV4ZWqDuuH+
   w==;
X-CSE-ConnectionGUID: Ml1v3PkhSau9jrqwXh6s/g==
X-CSE-MsgGUID: VxiFsc26SLuwoL8A8ruYsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17271780"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17271780"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 05:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="20811178"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2024 05:54:34 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	jacob.jun.pan@intel.com
Subject: [PATCH 0/2] Two enhancements to iommu_at[de]tach_device_pasid()
Date: Wed, 27 Mar 2024 05:54:31 -0700
Message-Id: <20240327125433.248946-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are minor mistakes in the iommu set_dev_pasid() and remove_dev_pasid()
paths. The set_dev_pasid() path updates the group->pasid_array first, and
then may call into remove_dev_pasid() in error handling when there are devices
within the group failed to set_dev_pasid. The remove_dev_pasid() callbacks of
the underlying iommu drivers get domain for pasid from the group->pasid_array.
So the remove_dev_pasid() callback may get a wrong domain in the set_dev_pasid()
path. [1] Even the group is singleton, the existing code logic would have
unnecessary warnings in the error handling of the set_dev_pasid() path.

The fix is passing the domain to be detached to the remove_dev_pasid()
callback, and only undo the set_dev_pasid result on the devices that have
succeeded.

[1] https://lore.kernel.org/linux-iommu/20240320123803.GD159172@nvidia.com/

Regards,
	Yi Liu

Yi Liu (2):
  iommu: Pass domain to remove_dev_pasid() op
  iommu: Undo pasid attachment only for the devices that have succeeded

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  9 ++-----
 drivers/iommu/intel/iommu.c                 | 11 +++------
 drivers/iommu/iommu.c                       | 27 ++++++++++++++-------
 include/linux/iommu.h                       |  3 ++-
 4 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.34.1

