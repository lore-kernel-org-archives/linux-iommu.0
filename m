Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A11A363C64
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401524; cv=none; b=CZCawxKLBGkgKvOiVzB3nHmOGFI/Y1e168Wh5sJRqY1iSTUuXEMvI7XHlH+R8K1QTefO67gySC21YB4NL6B39+YYLwHCKYUAlGknFhrqcQYPzngmywe09yWxXK3uKaKuWRMxm0XMFOKHURvZPtFqjaMYJJ9jMy+jrMv+cqayir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401524; c=relaxed/simple;
	bh=R3g9rR+SQcFS/QChrabp71IpbUopGms1sA+Trghuidk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgR6vItug67YtcrS754g1jqM5i7R2CUSRLLIhORgg0ZGbBc1cAX11vB9iecKACSmHDfh5QLaff/WdXP/7k7vVKv35nd0sM0clupAUOXjl1wSjPSKsnZRdSo6yE40Ira/q7sdwaWhQyNeNe70wMQT0K8dXR5kgWQZ+QeTJz07MNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qqv+d4xU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qqv+d4xU"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 52F1020B7169;
	Thu, 21 May 2026 15:11:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 52F1020B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779401514;
	bh=6KmR7jXbzopM+VNTMsaSMgkNWul8XMre5mGUEemKyLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqv+d4xUkOk07FH7eD27wbtienOgGQym4VPekLfdpKsH0aAZlWy8zf4houxDxCY16
	 THqAKCzjXCPn/2iKVQMjfp0to8N97HHGRck3vBhdtcT2gCF7uIPlhxwu8pesBW2q+w
	 LCwHZmkwtn00xJjKK+72RSoZsSzq6HCzMFjbOAdc=
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
Subject: [PATCH v6 7/7] Documentation: Update VFIO NOIOMMU mode
Date: Thu, 21 May 2026 15:11:54 -0700
Message-ID: <20260521221155.1375144-8-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
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
 v6:
 - Generalize device node names (noiommu-vfioX, noiommu-Y) in the tree
   example (Yi)
 - Clarify table column descriptions for Yes/No meanings (Yi)
---
 Documentation/driver-api/vfio.rst | 83 ++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index 2a21a42c9386..739576a22de6 100644
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
@@ -370,6 +368,87 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
 
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
+tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides an example of
+using this ioctl in no-IOMMU mode.
+
 VFIO User API
 -------------------------------------------------------------------------------
 
-- 
2.43.0

