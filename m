Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D462CCC1
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413925; cv=none; b=CsKN5TOT55VzoGzrkphWvtqYo8HQKOx4UQxM4EoqcX49+ezmFS0d1d7GSdCOSF99yu8+SCoTJl++SjCC+KZTMRX+ks7dNTEbaVbUP0MhUojRAp3xQy9Xsp/1eQFuj/qvykF4uIaNGwYPSH+TpVwfjlwy/+PNhRubDiDCkgw8UsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413925; c=relaxed/simple;
	bh=owW5BW/NYrC/Wuk2ibVtQN+bnARL2NjheJiatBrF8j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLMOsjGXPqmIqCjokAXUfRRJjJGBc1NMN8wAwZUbTmh5VOUlD2vE1qD2ZBpbRQ9OKHI1YgndCKlr52b75UCQJXUvbfkInYwIy6A81iQ7jB1h6n+zAY41XHqCk7Spvo0s44OHEa0fM69C2cKVb+QuXljQzNn/Bv+Hy0lKBz3aHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k0p7QBRh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k0p7QBRh"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id ECE68201DB33;
	Fri, 16 May 2025 09:45:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECE68201DB33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747413924;
	bh=Wa7PxPiuMO0CWgSRhlkFp7Ep/EsgIXDeCqKiwEetvCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0p7QBRhpRNMjRScnt4YnVB1o1EDtuUWW/EjiGE43TZgky4tgMLjv1W8RPDKq6KI7
	 zAtmlZdSDh3chmJjY7Ewl0n2JfE4Y3fa4A6lE0JRVE0pQpha99wCmxzO1seKwvflbD
	 rc4D1UZMnw4Z9k4lWUPWV++/6TI0JPKRsRB/avWU=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 2/2] vfio: Prevent open_count decrement to negative
Date: Fri, 16 May 2025 09:45:22 -0700
Message-Id: <20250516164522.51905-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
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

