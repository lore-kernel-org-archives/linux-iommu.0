Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFC338929
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817089; cv=none; b=X12VU3fbdKx6B+aeFlZ49/JGEGGZZJFiJ2vcg7ANBtdylekr46myQh+D+b18YJ/Pt1Y04r9oq8xvmv73vDyV/ND1qfK3M150NPN9MPqj4Rq1l2w4V8e4n4LNaQZ8bd9d5KCiezhIWk9F/gCRsoibbX4i6t2EnNKnuTR+MGoEHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817089; c=relaxed/simple;
	bh=hUn7TlBmNUdymtQg3Kq9wRTksnPrB1glAZZeGAPR86s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEssF1CfpccnfNZ9izgcP7BXcKgPs5vNNqgVF+9ZYMF8knlQLgkgijlY1Dveo0w57n3OlUhoZ2T0ZQ8g+gXxTq9yW5lJ+dXV4oq1Vm5iToUqVhDHVPT87s24iY4kO+Yt2Y+6Un+6bAvpLvn8nj3F9OJ+2XYSFT7+SdRJ/gXPhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8sr2hG6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8sr2hG6"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c387d3eb6so2156147a91.2
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 12:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767817087; x=1768421887; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zK+/AslzkBPlSJC8UvJQiRH9fqye6KU8Yh2AdIhmFE=;
        b=L8sr2hG6eYexeRmhtvjIs9Jm1rqPtd3eOelsxoyGa1G3D93Da8xhheEgR0qlOlix1C
         ZB32Xukjf2Z4LLwhlvogLFPDS8DyamA8Lm33My3y4GrQ9V7F8Ly3LzEtaMV7Yonl9Rhi
         /CTTa0qSjg96pHWvnFlsCa2ju768sirjUU3u62GMqeE9MJGv1KN7g//xEeC/SRlq35KZ
         ntUmhVllGsVbh53yZBQSvrjKp4eO6CyIv/ulq7hEFndo4pGpb4Hc7Gxvfmpe8IhKAkm4
         LsAfldRXGVlFOaaNcs6dAzOGJVgiKLMAkVErYGcS5fuSnAyn5XrMrA8wCn7v9dBAg+Vv
         edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817087; x=1768421887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zK+/AslzkBPlSJC8UvJQiRH9fqye6KU8Yh2AdIhmFE=;
        b=V8OQNQZwevkvAwpH9T/SrRBGqcNDr4glEYzn57+fSDv7X5/Ve+GuF7WljtbWeQGoeF
         K0Topl94m7r7bjWI2QRHVpvUyKRvQRwf8Q5vpbs/tri2BdJ9lfXSFgXRPdCduh5sA/2y
         yiLka0pZ7llnchlIbFPlc1pFpLAzMoteGplDTd6Mli0XX003xxVSbBoQp60ZDVNrrRhv
         WZrE4bNSTF7dTB9hQeI6OdANGo/22kSglZ2HVmWiLpyx/cUVTq/vyc9nT8TPBULu4IHe
         um1DuK6lOQNIQmrP/9+mHC4k6QuHvn1fX8uA6cOo9zRn2qvtQYVwimOwHr/P+aDC+St8
         22vg==
X-Forwarded-Encrypted: i=1; AJvYcCXts7o7qncSA5Pq/VfZ5ZZ1vuRrw2/3A/iBGg97WEU9VS+OW7HyDz28UyP1rCW1C10gaGI/cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvqHLyD8I+TVPOgbDNEUDsCQB2wFAXPKC9tS13/TBSB2k0cX2j
	SJedqw3I8rxVP3FUVYR10tdPM4nDELpIazcBMhDW67S4OA1Da456OFjWE5N6Hth9JokPlOA1jLu
	AomGFyInO9G6ftw==
X-Google-Smtp-Source: AGHT+IHThLlbeg0Bz0L6XHahvlrl4KT7b217LsvR54vbtTKdYnIle66+HnkOhYRBZx9jZcBHpKpDIq/Pi3rfmQ==
X-Received: from pjbhl15.prod.google.com ([2002:a17:90b:134f:b0:34c:2778:11c5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2642:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-34f68c47f38mr2755853a91.33.1767817086729;
 Wed, 07 Jan 2026 12:18:06 -0800 (PST)
Date: Wed,  7 Jan 2026 20:17:59 +0000
In-Reply-To: <20260107201800.2486137-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260107201800.2486137-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107201800.2486137-3-skhawaja@google.com>
Subject: [PATCH 2/3] vfio: selftests: Add support of creating iommus from iommufd
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Add API to init a struct iommu using an already opened iommufd instance
and attach devices to it.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  2 +
 .../lib/include/libvfio/vfio_pci_device.h     |  2 +
 tools/testing/selftests/vfio/lib/iommu.c      | 60 +++++++++++++++++--
 .../selftests/vfio/lib/vfio_pci_device.c      | 16 ++++-
 4 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index 5c9b9dc6d993..9e96da1e6fd3 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -29,10 +29,12 @@ struct iommu {
 	int container_fd;
 	int iommufd;
 	u32 ioas_id;
+	u32 hwpt_id;
 	struct list_head dma_regions;
 };
 
 struct iommu *iommu_init(const char *iommu_mode);
+struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id);
 void iommu_cleanup(struct iommu *iommu);
 
 int __iommu_map(struct iommu *iommu, struct dma_region *region);
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..1143ceb6a9b8 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -19,6 +19,7 @@ struct vfio_pci_device {
 	const char *bdf;
 	int fd;
 	int group_fd;
+	u32 dev_id;
 
 	struct iommu *iommu;
 
@@ -65,6 +66,7 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
 #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
 
+void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu);
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 58b7fb7430d4..2c67d7e24d0c 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -408,6 +408,18 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges)
 	return ranges;
 }
 
+static u32 iommufd_hwpt_alloc(struct iommu *iommu, u32 dev_id)
+{
+	struct iommu_hwpt_alloc args = {
+		.size = sizeof(args),
+		.pt_id = iommu->ioas_id,
+		.dev_id = dev_id,
+	};
+
+	ioctl_assert(iommu->iommufd, IOMMU_HWPT_ALLOC, &args);
+	return args.out_hwpt_id;
+}
+
 static u32 iommufd_ioas_alloc(int iommufd)
 {
 	struct iommu_ioas_alloc args = {
@@ -418,11 +430,9 @@ static u32 iommufd_ioas_alloc(int iommufd)
 	return args.out_ioas_id;
 }
 
-struct iommu *iommu_init(const char *iommu_mode)
+static struct iommu *iommu_alloc(const char *iommu_mode)
 {
-	const char *container_path;
 	struct iommu *iommu;
-	int version;
 
 	iommu = calloc(1, sizeof(*iommu));
 	VFIO_ASSERT_NOT_NULL(iommu);
@@ -430,6 +440,16 @@ struct iommu *iommu_init(const char *iommu_mode)
 	INIT_LIST_HEAD(&iommu->dma_regions);
 
 	iommu->mode = lookup_iommu_mode(iommu_mode);
+	return iommu;
+}
+
+struct iommu *iommu_init(const char *iommu_mode)
+{
+	const char *container_path;
+	struct iommu *iommu;
+	int version;
+
+	iommu = iommu_alloc(iommu_mode);
 
 	container_path = iommu->mode->container_path;
 	if (container_path) {
@@ -453,10 +473,42 @@ struct iommu *iommu_init(const char *iommu_mode)
 	return iommu;
 }
 
+struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id)
+{
+	struct iommu *iommu;
+
+	iommu = iommu_alloc("iommufd");
+
+	iommu->iommufd = dup(iommufd);
+	VFIO_ASSERT_GT(iommu->iommufd, 0);
+
+	iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
+	iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
+
+	return iommu;
+}
+
+static void iommufd_iommu_cleanup(struct iommu *iommu)
+{
+	struct iommu_destroy args = {
+		.size = sizeof(args),
+	};
+
+	if (iommu->hwpt_id) {
+		args.id = iommu->hwpt_id;
+		ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
+	}
+
+	args.id = iommu->ioas_id;
+	ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
+
+	VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
+}
+
 void iommu_cleanup(struct iommu *iommu)
 {
 	if (iommu->iommufd)
-		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
+		iommufd_iommu_cleanup(iommu);
 	else
 		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fac4c0ecadef..9bc1f5ade5c4 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -298,7 +298,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
-static void vfio_device_bind_iommufd(int device_fd, int iommufd)
+static int vfio_device_bind_iommufd(int device_fd, int iommufd)
 {
 	struct vfio_device_bind_iommufd args = {
 		.argsz = sizeof(args),
@@ -306,6 +306,7 @@ static void vfio_device_bind_iommufd(int device_fd, int iommufd)
 	};
 
 	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
+	return args.out_devid;
 }
 
 static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
@@ -326,10 +327,21 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
 	VFIO_ASSERT_GE(device->fd, 0);
 	free((void *)cdev_path);
 
-	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
+	device->dev_id = vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
+void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu)
+{
+	u32 pt_id = iommu->ioas_id;
+
+	if (iommu->hwpt_id)
+		pt_id = iommu->hwpt_id;
+
+	VFIO_ASSERT_NE(pt_id, 0);
+	vfio_device_attach_iommufd_pt(device->fd, pt_id);
+}
+
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
-- 
2.52.0.351.gbe84eed79e-goog

