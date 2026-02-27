Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779DF363C69
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214778; cv=none; b=k3D98X+VR0IIH7yrzl47iCFaP3O7LSgC2wurzRN5TVFy5PyEmqeDS2XRbvpodQrJpsSpPaR/CVXHkzjsqi20iFzb+zwW/zLKxZ4nnuyOawK/efpYjGaMPm/Y/pBif645TlmUXAzEiWwvl0UtcVUTOKQKh893SLThhzEvx/+LZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214778; c=relaxed/simple;
	bh=Yfl32e/wH1s1fkSBmCkA0l5uMrhboi+dTtlW0Ww5QD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GY15kRhZn/TaBV+VKiO53URtjev976ufGMrPEBFh+jb61y+Ilf5tK+ufrAPLtVKGK84O4JS2AcMcJb1hY4oswnTEutKrjSXpwJpc4NTdDAWilwVgjmeErXnw53oTrmlYW4+3oWn+cU0rfQwb/iQnaj+xUQkEWldprGzU8BaXcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bHLRM9zx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bHLRM9zx"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id B23CB20B6F07;
	Fri, 27 Feb 2026 09:52:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B23CB20B6F07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772214777;
	bh=6C5HqNSNlEXnphrTuI5WMJTUuVyBmzclsZEl1pFAJmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHLRM9zxbYh2tnPNsFCVqVrbKceaFNyVr/WAvwyZjc9exp3RG/GkkVfLnbOr6Z5Zr
	 AU8UqOn6bgyjH9CO8IVJ+33ybSr7whrcn4obB+hA/0XsQNkLGzVakP2KQIsUpdtAxq
	 5qAapwr7wNcdqpS+XP5wdClpLYijHiDpu9MD25wc=
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
Subject: [PATCH 09/11] vfio:selftest: Handle VFIO noiommu cdev
Date: Fri, 27 Feb 2026 09:52:45 -0800
Message-Id: <20260227175247.26103-10-jacob.pan@linux.microsoft.com>
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

