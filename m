Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C570421A07
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524139; cv=none; b=GzKCHuSLsSfuPX1Jd03MvY0GXkN0tyIGHUu04LvunIdAd/NzyZlKWVZVFwWhPUeoEuvBmIAjb8Xpv8PwTzJXZuH7bMNVGeJgy380/D1bKo911+bpymnCdoZhxqila/LQpTv6tuW2JkifhDVWtg+ir4Eiq5czMGXFIXBSDpX9BmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524139; c=relaxed/simple;
	bh=ISO2SuIHi96YENEDGkOwdgRJTTkektLfFRHtgmfryng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge/2n9En4HQCbkTyd26g7EMwLlwQl6iDBpwGyAO/mT1w4Izq+Ht58/N4HHTGV0WErIqq0WqfdwfiRB9nNDDi8am3xZBaC45Dka2pdi+9XlL4P2jkVf8auNSNFv1ZQl7Rnoql0g98fn8MLDlZrzsiqNpKvOhszOvVle31E27bRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P8DvjF20; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P8DvjF20"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0851320B716D;
	Wed,  3 Jun 2026 15:02:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0851320B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780524123;
	bh=9iOe+4xrTvdYuZWo1/OXpHg74XdGQ2EUncLcsguBF6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8DvjF20CYDk9ioMoY1GGqe5Uu5xQiYKPq3eZFm7hAWrp4DVM9jfOFpT7yY9veI9l
	 SxBwrZT81rtihYfBrxw1I2FGlsFDHRCv3k0Qi9R6nUJun4d3Xvq4cR8ttZxwIAuC9C
	 0JtOMXWt9TvAxwpBqY858bW2Xkq6TKySdNwDx2/A=
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
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Subject: [PATCH v8 6/6] Documentation: Update VFIO NOIOMMU mode
Date: Wed,  3 Jun 2026 15:02:11 -0700
Message-ID: <20260603220211.2584590-7-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
References: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the NOIOMMU mode with newly added cdev support under iommufd.

Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 V8:
 - Remove reference about self test.
 v7:
 - Added Kconfig matrix
 v6:
 - Generalize device node names (noiommu-vfioX, noiommu-Y) in the tree
   example (Yi)
 - Clarify table column descriptions for Yes/No meanings (Yi)
---
 Documentation/driver-api/vfio.rst | 81 ++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index 2a21a42c9386..bf0632a43bc6 100644
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
@@ -370,6 +368,85 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
 
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
+  |   `-- noiommu-vfioX	/* VFIO device cdev */
+  |-- noiommu-Y		/* VFIO group */
+  `-- vfio
+
+The capabilities vary depending on the device programming interface and kernel
+configuration used. The following table summarizes the differences ("Yes" means
+the UAPI is accessible and functional in noiommu mode, "No" means the UAPI is
+not supported):
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
+Kconfig Support Matrix
+^^^^^^^^^^^^^^^^^^^^^^
+
+The visibility of CONFIG_VFIO_NOIOMMU depends on the combination of
+CONFIG_VFIO_GROUP, CONFIG_VFIO_DEVICE_CDEV, and whether a container backend
+(CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER) is configured.  The
+Kconfig dependencies enforce the following constraints:
+
+- At least one access path (group or cdev) must be available.
+- If VFIO_GROUP is enabled, a container backend is required; otherwise the
+  group node would be unusable in noiommu mode.
+
+The resulting support matrix:
+
++------+-------+-----------+------+---------+---------------------------+
+| Case | GROUP | Container | CDEV | NOIOMMU | Notes                     |
++======+=======+===========+======+=========+===========================+
+|  1   |   y   |     y     |  n   |   yes   | Group noiommu works       |
++------+-------+-----------+------+---------+---------------------------+
+|  2   |   y   |     n     |  n   |   no    | Blocked - no container    |
++------+-------+-----------+------+---------+---------------------------+
+|  3   |   y   |     y     |  y   |   yes   | Both paths work           |
++------+-------+-----------+------+---------+---------------------------+
+|  4   |   y   |     n     |  y   |   no    | Blocked - no container    |
++------+-------+-----------+------+---------+---------------------------+
+|  5   |   n   |     -     |  y   |   yes   | Cdev-only works           |
++------+-------+-----------+------+---------+---------------------------+
+|  6   |   n   |     -     |  n   |   no    | No access path            |
++------+-------+-----------+------+---------+---------------------------+
+
+Container = CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER (either
+suffices).  Case 4 is intentionally blocked: allowing NOIOMMU with GROUP
+enabled but no container would create unusable group nodes.  Users who want
+cdev-only noiommu should set CONFIG_VFIO_GROUP=n (case 5).
+
+A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to retrieve the physical
+address for a given IOVA. Although there is no physical DMA remapping hardware,
+IOMMU_IOAS_MAP_FIXED_IOVA is still used to establish IOVA-to-PA mappings in the
+software page table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
+
 VFIO User API
 -------------------------------------------------------------------------------
 
-- 
2.43.0

