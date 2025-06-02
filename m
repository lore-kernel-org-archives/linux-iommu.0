Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CD019CC39
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748907802; cv=none; b=l2H9HTqPSHEvLi6r7Idbsnaef3Db20o+LNHYvdnfNrLipH7FyhStklFyHcPCZ8BXU0ECSz43XswgG7uxye3mV65mZlt13gCDhfZekfYSDtb5INSc2vOtlMkP258dnKNp7+1ZZmh+OwdziLFPBwRC1Aym5frbEOGeYygtGDqae5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748907802; c=relaxed/simple;
	bh=owW5BW/NYrC/Wuk2ibVtQN+bnARL2NjheJiatBrF8j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZ6/EZiXKpQAfyCPIL7uRuT4LXR+l3xmkOTNX60QmXoJKQHysRMKrbTT3DEp8bxKXTO2WTNvEOM5/p0hZXHrcg/hGWQqqDyzbRaK+dD2X7ZKYXbdJ1elFJRYWf9wxCOFVrscHXVlo+ijl0823UuM+IOl39gWs9JB89pXFHF5XsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=awJY2gXR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="awJY2gXR"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id E71AD21176C2;
	Mon,  2 Jun 2025 16:43:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E71AD21176C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748907801;
	bh=Wa7PxPiuMO0CWgSRhlkFp7Ep/EsgIXDeCqKiwEetvCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awJY2gXR4FG+JIVb1PAWOG7Thr36PlmTCCenP09u8iWDmj4bEDYeMgunoa5a6mwOV
	 UtrNRBmDkXFKoe/O/nnmH8yxYRQff9WwJOfn+7rabG1GeOExmVwbcaW4kdRCgC5lAA
	 w4Cn/hB3CG3T3aSqx26bDQniV7rhPA1zApuSgmAw=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH 2/2] vfio: Prevent open_count decrement to negative
Date: Mon,  2 Jun 2025 16:43:19 -0700
Message-Id: <20250602234319.4404-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602234319.4404-1-jacob.pan@linux.microsoft.com>
References: <20250602234319.4404-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When vfio_df_close() is called with open_count=0, it triggers a warning in
vfio_assert_device_open() but still decrements open_count to -1. This allows
a subsequent open to incorrectly pass the open_count == 0 check, leading to
unintended behavior, such as setting df->access_granted = true.

For example, running an IOMMUFD compat no-IOMMU device with VFIO tests
(https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c)
results in a warning and a failed VFIO_GROUP_GET_DEVICE_FD ioctl on the first
run, but the second run succeeds incorrectly.

Add checks to avoid decrementing open_count below zero

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/vfio_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 1fd261efc582..5046cae05222 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -583,7 +583,8 @@ void vfio_df_close(struct vfio_device_file *df)
 
 	lockdep_assert_held(&device->dev_set->lock);
 
-	vfio_assert_device_open(device);
+	if (!vfio_assert_device_open(device))
+		return;
 	if (device->open_count == 1)
 		vfio_df_device_last_close(df);
 	device->open_count--;
-- 
2.34.1

