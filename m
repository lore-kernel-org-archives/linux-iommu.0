Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AE25FA2C
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752034259; cv=none; b=I+gdMyx2Xcv7P4NH7vr/p1JNA42yByxmmwZ+N6Og8PLnozSFN7rUwNk/BY/3kutJvDECRH9j+okLKlDu4l67xRPJTQruZZ9zkL0oymlvQumyrGJYGZLRujnLezLQRrgbWCV9TON8wvFcwuNWTU4Z7zwk/ZlEDaLKBTFOnc36fCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752034259; c=relaxed/simple;
	bh=zHhHm4K/1JO2RXYDJbax7jEbZ8b8EO2F/AJh0pf/QrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRU6dsCldRAmghqSSXuxgO1RUgkn2LBPLO9L5WSAV4IRP3up1IfN3XWtZ3KDTcfsJ1/LGlnVI409PxAgU4HeHe9Sc1PRzpH4IFAdDM14sxWNaNPKpn9bWDTtgSbtvES9bXQ+V9RJ7K8ACCxja+jFI48KPD9uNTyqBVAqmTiHo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBw0P53z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBw0P53z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752034258; x=1783570258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zHhHm4K/1JO2RXYDJbax7jEbZ8b8EO2F/AJh0pf/QrU=;
  b=JBw0P53z4wyQzVyFzwh+NcJ+mr0ehhMZFmv592bE1OBGCc+YVg77EpRW
   k9KQ3KXrHNBKa4mRZ6ZKXD6UohgK9wWIbzrbnH0ZXPMclNcP05/p7UmvC
   Flp8GEWzyuI78TCB56O+IX6rHeS12Gn5caYPEeBqPMyNhs9Zycb69Za91
   oMUXLlyXYZbQn7Ee03sha1+mW9bvMmeIplnBu3QQYlJXJFxvOYxxpOtAX
   stUNnl7lpbxNm005Kl0zs+IcSMR1gNzL8ik2IJS/2U3dITjUf8pg33ign
   u0YibStJKkOg0yqE+E9U/Q45kQOIf6wRE2vcDIjZlP60kpBtmsPMZi/H5
   A==;
X-CSE-ConnectionGUID: rEDcnqbCT5+BoKDpk1teeA==
X-CSE-MsgGUID: BN93atKgT4aQVkKAhMUcDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76831769"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76831769"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 21:10:58 -0700
X-CSE-ConnectionGUID: c20bXawEQWaFt3kS+BQHng==
X-CSE-MsgGUID: b//OOEQiRtKMVawkigAJVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192851572"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 21:10:55 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v4 1/7] iommufd/viommu: Roll back to use iommufd_object_alloc() for vdevice
Date: Wed,  9 Jul 2025 12:02:28 +0800
Message-Id: <20250709040234.1773573-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To solve the vdevice lifecycle issue, future patches make the vdevice
allocation protected by lock. That will make
iommufd_object_alloc_ucmd() not applicable for vdevice. Roll back to
use iommufd_object_alloc() for preparation.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/viommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 25ac08fbb52a..f556a65f3062 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -144,7 +144,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev = iommufd_object_alloc_ucmd(ucmd, vdev, IOMMUFD_OBJ_VDEVICE);
+	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
@@ -159,12 +159,18 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
 	if (curr) {
 		rc = xa_err(curr) ?: -EEXIST;
-		goto out_put_idev;
+		goto out_abort;
 	}
 
 	cmd->out_vdevice_id = vdev->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
+	goto out_put_idev;
 
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
 out_put_idev:
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
-- 
2.25.1

