Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A336C0CF
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214780; cv=none; b=jssRZ9rSKpDhc4fmmdNwsqhinHM6S5xAopJ3D1MQ8r8NjC7X50g4FoP8ZGdiASAjJTd3eWy4Sr5Hm2YfLgZQ0BRbhcs8s497X/1p0HWqsxoljwRUwwMiQgP+v6cBfaGm+82Ws22M3GLjXkEgVGuuZuctRVXa4+5n3Oyom28DlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214780; c=relaxed/simple;
	bh=I5gAUUB8Ti6eWgykzRpibFwTRcv9KWB0V/PC/QTQ5AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5JzJ9Fd6mExrFZ0ysJfoD7R3IKMp2brJjo9VaiM4IczMTzEhCCijPAugwN2ydrQEz+YpTqHr5HGEuSsXOpsPP9bEdZ+twEGtftviehtQx8pjh2lGq8+kIpik/k9S7RyL7P5cgt/BalDC9ZcFoywE8dmpLnA+JJYrclbPIL0Yo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MQ1CjTLK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MQ1CjTLK"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id B39FF20B6F04;
	Fri, 27 Feb 2026 09:52:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B39FF20B6F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772214779;
	bh=tizjuLFHEk/Wc4SiQ1zGGxLYp2aa4CoKwD5TQrr+Y0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQ1CjTLKIa0BFHkvloBYg2s0e64+1cANGhw+++CsDazoTKmMg9D7Tb2iwPoq3IQK4
	 vMWrzg8Ni1aRaulZzdMZ4zawy3QhJMVtFg/JyRAnUw76gIoTGlF+jb0G+53d2uvsyz
	 oVcWHd7pTKSnCVBIuQ5SU3tRp/cBBqrPNpwmchwY=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 11/11] Doc: Update VFIO NOIOMMU mode
Date: Fri, 27 Feb 2026 09:52:47 -0800
Message-Id: <20260227175247.26103-12-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
References: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the NOIOMMU mode with newly added cdev support under iommufd.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 Documentation/driver-api/vfio.rst | 44 +++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index 2a21a42c9386..d1ee13dc6e98 100644
--- a/Documentation/driver-api/vfio.rst
+++ b/Documentation/driver-api/vfio.rst
@@ -275,8 +275,6 @@ in a VFIO group.
 With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
 by directly opening a character device /dev/vfio/devices/vfioX where
 "X" is the number allocated uniquely by VFIO for registered devices.
-cdev interface does not support noiommu devices, so user should use
-the legacy group interface if noiommu is wanted.
 
 The cdev only works with IOMMUFD.  Both VFIO drivers and applications
 must adapt to the new cdev security model which requires using
@@ -370,6 +368,48 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
 
 	/* Other device operations as stated in "VFIO Usage Example" */
 
+VFIO NOIOMMU mode
+-------------------------------------------------------------------------------
+VFIO also supports a no-IOMMU mode, intended for usages where unsafe DMA can
+be performed by userspace drivers w/o physical IOMMU protection. This mode
+is controlled by the parameter:
+
+/sys/module/vfio/parameters/enable_unsafe_noiommu_mode
+
+Upon enabling this mode, with an assigned device, the user will be presented
+with a VFIO group and device file, e.g.
+
+/dev/vfio/
+|-- devices
+|   `-- noiommu-vfio0	/* VFIO device cdev */
+|-- noiommu-0		/* VFIO group */
+`-- vfio
+
+The capabilities vary depending on the device programming interface and kernel
+configuration used. The following table summarizes the differences:
+
++-------------------+---------------------+---------------------+
+| Feature           | VFIO group          | VFIO device cdev   |
++===================+=====================+=====================+
+| VFIO device UAPI  | Yes                 | Yes                |
++-------------------+---------------------+---------------------+
+| VFIO container    | No                  | No                 |
++-------------------+---------------------+---------------------+
+| IOMMUFD IOAS      | No                  | Yes*               |
++-------------------+---------------------+---------------------+
+Note that the VFIO container case includes IOMMUFD provided VFIO compatibility
+interfaces when either CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER is
+enabled.
+
+* IOMMUFD UAPI is available for VFIO device cdev to pin and map user memory with
+the ability to retrieve physical addresses for DMA command submission.
+
+A new IOMMUFD ioctl IOMMU_IOAS_GET_PA is added to retrieve the physical address
+for a given user virtual address. Note that IOMMU_IOAS_MAP_FIXED_IOVA flag is
+ignored in no-IOMMU mode since there is no physical DMA remapping hardware.
+tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides an example of
+using this ioctl in no-IOMMU mode.
+
 VFIO User API
 -------------------------------------------------------------------------------
 
-- 
2.34.1

