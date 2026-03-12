Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1EF3F6612
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331017; cv=none; b=BG8izTlf1tFYZTILcYsReuAOH6BYa6jWl3zVxpIkgOuCQdCLLDSgRRk3SWbYLuhtKTeXkrwi+/X0/TNEj4dydDZUOnJrCdBq9Tn1uCosH3h6+dSAQcsbGN/mfpdkcKWugdRnK5N3+r4oEbokzdItye/5+oZL/VQaoJf4j8h2t9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331017; c=relaxed/simple;
	bh=I5gAUUB8Ti6eWgykzRpibFwTRcv9KWB0V/PC/QTQ5AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EI4DKDy5kWxL75yWNE0aMeupCULZzOwnifeAfYpRzz3ZYuC0ta/uyEP1Gc6iKdSu/x/R8tWP/HBXKXaeSe4nIFBDaa6XhEY3+zgkGilo3pw4EeqWEfY+Q1fxJMtxfAjLaDzI61gY+ivqL7t8jhhle13aq7f90zubuY3DhEiT37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ByqJJuHE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ByqJJuHE"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 096C320B6F01;
	Thu, 12 Mar 2026 08:56:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 096C320B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773331015;
	bh=tizjuLFHEk/Wc4SiQ1zGGxLYp2aa4CoKwD5TQrr+Y0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ByqJJuHEuZbxzdTQo1dJQxfrt55PNrUOCV1jWLdgpBiBysyzCs58lXq43bdvcU5mD
	 TFc1sR5XAEoqcwljwwASIOLOVCYiIMymnp4E6HgBLWVAhpMSKEtB7gZNtwwSNF3dgv
	 xzFO3GirFjlX47M2bNGW8/wnd7zFE2dK42rH6Ezo=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
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
Subject: [PATCH V2 11/11] Doc: Update VFIO NOIOMMU mode
Date: Thu, 12 Mar 2026 08:56:37 -0700
Message-Id: <20260312155637.376854-12-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
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

