Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB8382290
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201264; cv=none; b=IXIsewjFJe1HHz5OLc4IaRU7Xc6egzSj6vPAF0rqs4Xsv/GzRzFJr74XD+/JAVLggACjA+QJUr5RUK9c87XjH68KNTeBN1sviu+o8BqwmEvJf5GyeYTFvME70vpaOzl5sggeMImKBhuMDi0YTrn4p3HPAGHUP0jy3yptEpntWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201264; c=relaxed/simple;
	bh=WurGjAPySDnxSs87Rz7to6pBVzCWRroBMaf7/9rmgL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huryRbcR8uqbXLNGdGBpnlhGQSrBhMDB/c19xtovxFGJM5924ZnE53CUT2A8H2HRDtuygEoYi6t4VEClW8EaAXLaXulmxeI10j9Iw6LoVmqJA/xTQsjYsacxx2Hf0F28Gl+n82EEMGQkUjuegmlXgB6S0i8Pu4zGvNeCUlYCIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l+3rwstd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l+3rwstd"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4685920B6F1B;
	Tue, 14 Apr 2026 14:14:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4685920B6F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776201262;
	bh=5Pty+EK/52Y89Hf1Y5QloHTVW8bXBevk8NFrPi8hG1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+3rwstd9KDpXKl12D6liRYRGrQPHZOoGaeQESopXizr4hMMrq4cKZReORqETw01V
	 4yQ5gVb141uXUL+J6kApQXqf4moT8eCvvDc2LX6Co60DEBM4sGaCGxhnrydONKfZQ9
	 jYKz+2dX23jIvAMqH7xXJQV1srcsM00m129ayJqo=
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
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V4 10/10] Documentation: Update VFIO NOIOMMU mode
Date: Tue, 14 Apr 2026 14:14:12 -0700
Message-Id: <20260414211412.2729-11-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
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
 Documentation/driver-api/vfio.rst | 45 +++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index 2a21a42c9386..da6f77414c3b 100644
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
@@ -370,6 +368,49 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
 
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

