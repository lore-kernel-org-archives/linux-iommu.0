Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F24C0419
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524887; cv=none; b=dQ6RgX3aUl++An9ntLjREVFBuuO0dpd0i+XJigS2UAbWq6eiy0rZsTJXOv3TwHyspY6xl5XPXK+4mU358e6KgqR5hwQvGd2eqY8mXR33raN/nYGR4I1Wm+SgVSsVWBN8CV4PuaKllcig2k4BLitjo6PL8LkWYmUVCHYJhop1FSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524887; c=relaxed/simple;
	bh=O/DngcUI2BzfOTaG7QGuvMJMnYlUhv8RWNmBXvnHwcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAgl/y2n8SxcNqah3WPOIefREdrAE0cg9dqbMCgJgKS0VOyAMYKjd4sTpJWytNHgzEuNWKJfuWvJMC3PadgqsLkXg5NjCZdjRZJSKJPH9qzeQHbEcWKKqi1OYDruW8FNryNHW2xZFX5qoB2K0ElnnpBXGiNW0iX+1jhbpxEy0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P/3XquV5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P/3XquV5"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7C55A20B716B;
	Mon, 11 May 2026 11:41:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C55A20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778524882;
	bh=PIZ3AtZMw5ZZgdKM/toxFCQtVAmRi6DowL2aMuJTh28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/3XquV5fdCbD7dbbcGRRUyK4mFHJ2f7SgvTMjFn+V5nsV9c4biJFqzSAxEFVYYXg
	 2vrQ9UUCsqIUp4mvptsYVW+SDJ5K6w8Qe3wHARRNuhYknH5E5B9TAlUzpeMWEwtAYF
	 HWBrIH/PRqAGNzOsBXFlx591hEGRmyN3bbwNz6EM=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 9/9] Documentation: Update VFIO NOIOMMU mode
Date: Mon, 11 May 2026 11:41:14 -0700
Message-ID: <20260511184116.3687392-10-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the NOIOMMU mode with newly added cdev support under iommufd.

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 Documentation/driver-api/vfio.rst | 46 +++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index 2a21a42c9386..d97017d80b98 100644
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
@@ -370,6 +368,50 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
 
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
+with a VFIO group and device file, e.g.::
+
+  /dev/vfio/
+  |-- devices
+  |   `-- noiommu-vfio0	/* VFIO device cdev */
+  |-- noiommu-0		/* VFIO group */
+  `-- vfio
+
+The capabilities vary depending on the device programming interface and kernel
+configuration used. The following table summarizes the differences:
+
++-------------------+---------------------+----------------------+
+| Feature           | VFIO group          | VFIO device cdev     |
++===================+=====================+======================+
+| VFIO device UAPI  | Yes                 | Yes                  |
++-------------------+---------------------+----------------------+
+| VFIO container    | No                  | No                   |
++-------------------+---------------------+----------------------+
+| IOMMUFD IOAS      | No                  | Yes*                 |
++-------------------+---------------------+----------------------+
+
+Note that the VFIO container case includes IOMMUFD provided VFIO compatibility
+interfaces when either CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER is
+enabled.
+
+* IOMMUFD UAPI is available for VFIO device cdev to pin and map user memory with
+  the ability to retrieve physical addresses for DMA command submission.
+
+A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to retrieve the physical
+address for a given IOVA. Although there is no physical DMA remapping hardware,
+IOMMU_IOAS_MAP_FIXED_IOVA is still used to establish IOVA-to-PA mappings in the
+software page table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
+tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides an example of
+using this ioctl in no-IOMMU mode.
+
 VFIO User API
 -------------------------------------------------------------------------------
 
-- 
2.43.0

