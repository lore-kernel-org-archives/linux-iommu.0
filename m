Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993943F54C6
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331014; cv=none; b=YKPKuko1+ZCx+VY+nZb9Y4fxn8SbxDO9XUk9/i2cpQA/F7CecNyfchybRDberMuYsGBSLUR4IY50VjPw8LBMIqrXo/EwKRPyRkhYZDw9/9CZTrRF7PsbiCSJ/dWhYw+y3/SHqP68gBpj+Pqmh46LrERC8JNoK8AUwGe14xK/ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331014; c=relaxed/simple;
	bh=Yfl32e/wH1s1fkSBmCkA0l5uMrhboi+dTtlW0Ww5QD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLTnHOzg1NXMZslEf8HfTlpg2Z11u8Q/FtO+ZT5802fihOPysgt31571/CS8oAPLDuVmfC8NBY9QOXMy5/71qbEqZ8WtSW0FZEa4qg0E/EWna7Lf8sw8la/xIZ3OIF1oRAXkTFEIcc3yG5AGyxYrgoxQ4/zjPwTo5dCaqyLlSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Sp6dT90h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Sp6dT90h"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id EFC4B20B6F15;
	Thu, 12 Mar 2026 08:56:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFC4B20B6F15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773331013;
	bh=6C5HqNSNlEXnphrTuI5WMJTUuVyBmzclsZEl1pFAJmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sp6dT90he5TB472gC+2sQoU1xJirIipV0ygV75bDlFlyCl3Su0+45XCgHZumUDQDc
	 BAZPwgtztN9dJt0OwzN6o/yt2WatoNlbNJlmCbqnW1ZiVvKA2jeelORU5lKZTGnX4q
	 SBqPtIkHsFY7z85Z0MTGWB/2IF0uPFLmjtsEEvMI=
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
Subject: [PATCH V2 09/11] vfio:selftest: Handle VFIO noiommu cdev
Date: Thu, 12 Mar 2026 08:56:35 -0700
Message-Id: <20260312155637.376854-10-jacob.pan@linux.microsoft.com>
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
 .../selftests/vfio/lib/vfio_pci_device.c      | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4e5871f1ebc3..15ddeb634a8d 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -290,6 +290,24 @@ static void vfio_pci_device_setup(struct vfio_pci_device *device)
 		device->msi_eventfds[i] = -1;
 }
 
+
+static int is_unsafe_noiommu_mode_enabled(void)
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
@@ -306,8 +324,11 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
 
 	while ((entry = readdir(dir)) != NULL) {
-		/* Find the file that starts with "vfio" */
-		if (strncmp("vfio", entry->d_name, 4))
+		/* Find the file that starts with "noiommu-vfio" or "vfio" */
+		if (is_unsafe_noiommu_mode_enabled()) {
+			if (strncmp("noiommu-vfio", entry->d_name, strlen("noiommu-vfio")))
+				continue;
+		} else if (strncmp("vfio", entry->d_name, 4))
 			continue;
 
 		snprintf(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
-- 
2.34.1

