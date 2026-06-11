Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FED408034
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198834; cv=none; b=n0VtnXrfaym0gz7r6BwzenTx6WjMhWAMeW9OyVHOya/LAUboTjn4eoVARX+uXIpN6lWt6/lpIpUS9MIiQCXATyLQAuAsA60vakwQKY8+qEFPegeacOXBueQzi4BCsmqufMlH3CTP61Z6SpB28J2oLWv7OKA6k4R5/05yKEOIdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198834; c=relaxed/simple;
	bh=M6aY3QlIiKOGoLvmiKZaFO1cKABuzgTbwoPj4JL66zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2oFaLM5hin4ZAHzo6deKB4MQccgt3vYUFBMuusm1Tfc4y15kT4dzz+/qAtWaOtLnUkZulswhtTZk6HPMfvwrAGCJCWIE4s5WQZ85j+8/VkAg3RxJKxU+Ev3WTOM7BFWBnNIr9LEYUfK0GA5Mr/Av6zCTmwU0zNBcGwIpaboLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E6suWFz5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E6suWFz5"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8164D20B7171;
	Thu, 11 Jun 2026 10:26:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8164D20B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781198807;
	bh=N0uX3l0IRX9eO07K7v7r5GzpPinj6VE9ztI3tZWc6z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6suWFz5ujIP0t1WpTPReZv9IS3tfKEZlKCA7wUEgbaPltYCmWXXaYDEdJhHcQLXc
	 hpg+/m47bjluLdrkRdChco0txAbHIRytukeXNzIeK9ZO/dQ8g8vx5MyTobRxUqWzWJ
	 B/uHMwwu0REztgO83uUaKCnw2gZu3OFBUnGmF88U=
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
Subject: [PATCH v9 6/6] Documentation: Update VFIO NOIOMMU mode
Date: Thu, 11 Jun 2026 10:26:58 -0700
Message-ID: <20260611172658.3421138-7-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
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
 v9:
 - Clarify VFIO cdev no-IOMMU Kconfig limits
 V8:
 - Remove reference about self test.
 v7:
 - Added Kconfig matrix
 v6:
 - Generalize device node names (noiommu-vfioX, noiommu-Y) in the tree
   example (Yi)
 - Clarify table column descriptions for Yes/No meanings (Yi)
---
 Documentation/driver-api/vfio.rst | 89 ++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index 2a21a42c9386..07192386f7a6 100644
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
@@ -370,6 +368,93 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
 
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
+- The cdev noiommu path requires CONFIG_GENERIC_ATOMIC64=n because it depends
+  on CONFIG_IOMMUFD_NOIOMMU.
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
+|  3   |   y   |     y     |  y   |   yes   | Both paths work [#cdev]_  |
++------+-------+-----------+------+---------+---------------------------+
+|  4   |   y   |     n     |  y   |   no    | Blocked - no container    |
++------+-------+-----------+------+---------+---------------------------+
+|  5   |   n   |     -     |  y   |   yes   | Cdev-only works [#cdev]_  |
++------+-------+-----------+------+---------+---------------------------+
+|  6   |   n   |     -     |  n   |   no    | No access path            |
++------+-------+-----------+------+---------+---------------------------+
+
+Container = CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER (either
+suffices).  Case 4 is intentionally blocked: allowing NOIOMMU with GROUP
+enabled but no container would create unusable group nodes.  Users who want
+cdev-only noiommu should set CONFIG_VFIO_GROUP=n (case 5).
+
+.. [#cdev] The cdev noiommu path requires CONFIG_GENERIC_ATOMIC64=n.  When
+   CONFIG_VFIO_GROUP=y, CONFIG_VFIO_DEVICE_CDEV=y, and
+   CONFIG_GENERIC_ATOMIC64=y, CONFIG_VFIO_NOIOMMU remains selectable for the
+   group path, but no noiommu device cdev is registered.  Cdev-only noiommu is
+   not selectable on those platforms.
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

