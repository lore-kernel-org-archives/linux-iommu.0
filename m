Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D617C91
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728870151; cv=none; b=tBfDybI3DugKp8MF5plARItoTmpsDM3DcE3kMsUFbSe/vVs2OquB0e8qfIAaXxJkn5jAMC3iiQuhwaNJWKEg1orj2fxZ9JUWmGw6DLRASAWkZOASAGK4hc6UkvnpWuwxOZd5pV/PW2m9BOwyRAm5jOKoGNU79VADtonUMuVdAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728870151; c=relaxed/simple;
	bh=q3D1q2iubT8uEHm0mI7fu9YayFjRPXmqoTIwkpJs3Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edVP+HCZlMzDv/62I2nAV1zs1sZQA7XyLvitCNbEwsb9bnCAxk0oMI7Rf0ZmF0dgbJLmArDLdeNnL3RAlf0r6nPdsF+LKJAMTVUGvhfOyl09C+UoGmpkCpXpH4GJdNHRd9izG2Eio24Qn3OVBz4joxlX+xZ/8twiVaK22eOJ6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYaUvLG+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYaUvLG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728870150; x=1760406150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q3D1q2iubT8uEHm0mI7fu9YayFjRPXmqoTIwkpJs3Co=;
  b=DYaUvLG+Ir7W7GCxg94+lokwZEu7nl8dixaNsCOYiMp4D+vVi+1AkXs+
   fZmVzx8YPbaYccnyNzU8+2WFvENfJes0uvQN7UwFyJga+6FC+pOwZ+Uae
   ZleSFBqxxIhlMngalnQEidFDY2Ertz5jemDcD2ueVKhq9LnvxpbznnqjU
   4lvnbLS8ufcojVkGs4sDOBAv5WXPAYB7KbbOfqYYhiOxvWBrTffTAUwc9
   LOoRpFfJM70DKkzzHxVwIuUP2PU5wMRJjY33/KCaJu8FghWccT6UMWWk9
   KwTBfThuHyzCZClkBSJqOFanK/cnQBcaw3OGYEdpUHguls87A2HaAIO/r
   Q==;
X-CSE-ConnectionGUID: kEhMvuKYRJOZIDcyrH9jAQ==
X-CSE-MsgGUID: cB/TWr9ITqa9uwvyYidUUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28389760"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="28389760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:42:28 -0700
X-CSE-ConnectionGUID: WCDr7wGrTf23uXaIG//fNA==
X-CSE-MsgGUID: VrodvMIXR8CEmqDJnn2tDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77867587"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 13 Oct 2024 18:42:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices
Date: Mon, 14 Oct 2024 09:37:44 +0800
Message-ID: <20241014013744.102197-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014013744.102197-1-baolu.lu@linux.intel.com>
References: <20241014013744.102197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the domain_context_clear() function incorrectly called
pci_for_each_dma_alias() to set up context entries for non-PCI devices.
This could lead to kernel hangs or other unexpected behavior.

Add a check to only call pci_for_each_dma_alias() for PCI devices. For
non-PCI devices, domain_context_clear_one() is called directly.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219363
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219349
Fixes: 9a16ab9d6402 ("iommu/vt-d: Make context clearing consistent with context mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..e860bc9439a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3340,8 +3340,10 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
-	if (!dev_is_pci(info->dev))
+	if (!dev_is_pci(info->dev)) {
 		domain_context_clear_one(info, info->bus, info->devfn);
+		return;
+	}
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
-- 
2.43.0

