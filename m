Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2576736167E
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775193122; cv=none; b=lgL+HQ4A91b1S/J5++R6PdoBK1dGpF/zLq+V3otuAhfWjM0BMVopF/XLnshfS8OEZ7vTLK65uzwPXrv/4gvKYZETMNUzZ1jt1B2SrAad9A4xGOe3RMtO3UqNtt9BAR4xY1uQpjB7sTCBRWpWCaas9VYbGebwksXiFuOFHbn8DWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775193122; c=relaxed/simple;
	bh=V31Q3Af4wdCYq4VTT4ChM3OKL1fBC/ih/e2pbKE1f2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmf7O6Uj7egAIrZqcQFH+lVtPHEqPN/sqvnw1n5PJFC68gDrNaekY7yVyzmR6W3OpNxvaqtHIbzFgdtYtDCMbV/zQgDkaUDb6ODXKhG6+hrC9ZGj9h1rt+cqAxgRNnnEx6HT7BI3KYd4ZVxcUseYiWobQpif56oE8JYwaSeLYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m/KYJqbj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m/KYJqbj"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3C14420B700D;
	Thu,  2 Apr 2026 22:11:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C14420B700D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775193120;
	bh=Kwjfymmh3pQiKj6OmsaX+cYDKLyC7WNs0YCS0m8B5TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/KYJqbjOAIpmvmxkmNAge4PDjzaNe9SjRqOegjC8PqJtj2qbT42g5Ihi3F4poBKv
	 hR+wC+6oqw0Nwdh25gUZpmKEXNa1ozhwlK6tofv5UoDQv6GMHOJj1N951pr2fCZKLF
	 lNJIRdBqQ9MBHPsQZUkc7cuh6sJaJDaMbSTMCEOg=
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
Subject: [PATCH V3 08/10] vfio:selftest: Handle VFIO noiommu cdev
Date: Thu,  2 Apr 2026 22:11:44 -0700
Message-Id: <20260403051146.10210-9-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With unsafe DMA noiommu mode, the vfio devices are prefixed with
noiommu-, e.g.
/dev/vfio/
|-- devices
|   `-- noiommu-vfio0
|-- noiommu-0
`-- vfio
Let vfio tests, such as luo kexec test, accommodate the noiommu device
files.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  1 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 32 ++++++++++++++++---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     |  9 ++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2389c7698335..e2721e36b37e 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -124,6 +124,7 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 }
 
 const char *vfio_pci_get_cdev_path(const char *bdf);
+int vfio_pci_noiommu_mode_enabled(void);
 
 /* Low-level routines for setting up a struct vfio_pci_device */
 struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 66ee268110e2..1ba81d169208 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -225,11 +225,14 @@ void vfio_pci_group_setup(struct vfio_pci_device *device)
 	struct vfio_group_status group_status = {
 		.argsz = sizeof(group_status),
 	};
-	char group_path[32];
+	char group_path[64];
 	int group;
 
 	group = vfio_pci_get_group_from_dev(device->bdf);
-	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
+	if (vfio_pci_noiommu_mode_enabled())
+		snprintf(group_path, sizeof(group_path), "/dev/vfio/noiommu-%d", group);
+	else
+		snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
 	device->group_fd = open(group_path, O_RDWR);
 	VFIO_ASSERT_GE(device->group_fd, 0, "open(%s) failed\n", group_path);
@@ -294,6 +297,24 @@ static void vfio_pci_device_setup(struct vfio_pci_device *device)
 		device->msi_eventfds[i] = -1;
 }
 
+
+int vfio_pci_noiommu_mode_enabled(void)
+{
+	const char *path = "/sys/module/vfio/parameters/enable_unsafe_noiommu_mode";
+	FILE *f;
+	int c;
+
+	f = fopen(path, "re");
+	if (!f)
+		return 0;
+
+	c = fgetc(f);
+	fclose(f);
+	if (c == 'Y' || c == 'y')
+		return 1;
+	return 0;
+}
+
 const char *vfio_pci_get_cdev_path(const char *bdf)
 {
 	char dir_path[PATH_MAX];
@@ -310,8 +331,11 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
 
 	while ((entry = readdir(dir)) != NULL) {
-		/* Find the file that starts with "vfio" */
-		if (strncmp("vfio", entry->d_name, 4))
+		/* Find the file that starts with "noiommu-vfio" or "vfio" */
+		if (vfio_pci_noiommu_mode_enabled()) {
+			if (strncmp("noiommu-vfio", entry->d_name, strlen("noiommu-vfio")))
+				continue;
+		} else if (strncmp("vfio", entry->d_name, 4))
 			continue;
 
 		snprintf(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 36bddfbb88ed..d72f6a58e3e6 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -159,6 +159,15 @@ static void check_open_vfio_device_fails(void)
 	VFIO_ASSERT_EQ(errno, EBUSY);
 	free((void *)cdev_path);
 
+	/*
+	 * In no-IOMMU mode the group lives at /dev/vfio/noiommu-<N> and
+	 * cannot be added to a Type1 IOMMU container, so the container-based
+	 * access check below doesn't apply.  The cdev check above already
+	 * covers that the device is inaccessible in this mode.
+	 */
+	if (vfio_pci_noiommu_mode_enabled())
+		return;
+
 	for (i = 0; i < nr_iommu_modes; i++) {
 		if (!iommu_modes[i].container_path)
 			continue;
-- 
2.34.1

