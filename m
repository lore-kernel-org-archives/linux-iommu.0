Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BC2217733
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750290381; cv=none; b=cWAd2Fp7qlPUZ1KbCWOJuuh0aYLrmuTZprZrYy9vMgA98fNAYWwtwTAhmSDcc+xqRmSWaO6ENlcNTYs2WchndNBIbR8QTpBCLqpH6ohpfRrg/3yREN2Lg4lPkqTRy2+YrIM/ejP42CGujJZcXuF7R8TCSVRuGsgXKcC8PJRKR3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750290381; c=relaxed/simple;
	bh=ILG+AckVaKn2D95UHpfOwBot0U5Is1NjPMMRFqsxLK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYKnizxLe9fjaQESpY1hih3+t/0YFeLDOjWd7uXHxmAC0Z8Sn8a8RMPQj/nWrIcWbVp+opZjb42SRApu82iJ7Y5keXHTYepFxySjTWRZql+QmJI+z++zTvmmRhnYf9GgYG8c01mUccVNuZeMNOr/9V9o0SzRRHmb1JlnDuWnugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kUfaTTOy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kUfaTTOy"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE32A2119374;
	Wed, 18 Jun 2025 16:46:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE32A2119374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750290380;
	bh=THi24rMJ1Me4HQW1krEEgLKvWT803fq7eI3afVIv8Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUfaTTOyOvjy6kj/3MTtYSKZ8eQrmmZNh/Qm3V8ACiGYyyTkBZ3NbkLMNLsAd9bc9
	 PRqlAvUQURSVyExqZ1QK6AeMnys6xVRHKNJQj0duGj3ZBPyOiYecA/H9uihdcHLSjV
	 nI/7nL/jL49ntH6kkGJ8a4Njf0cxj8GVEoT29MpQ=
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
Subject: [PATCH v3 2/2] vfio: Prevent open_count decrement to negative
Date: Wed, 18 Jun 2025 16:46:18 -0700
Message-Id: <20250618234618.1910456-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
References: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
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

Add checks to avoid decrementing open_count below zero.
Fixes: 05f37e1c03b6 ("vfio: Pass struct vfio_device_file * to vfio_device_open/close()")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v3: Added Fixes tag
v2: Added Reviewed-by tags
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

