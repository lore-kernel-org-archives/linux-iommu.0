Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579F3403F2
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790298797; cv=none; b=KLftHLQcr2v31tOwpu65rxALBjMSlxtwFlwaNdj7gqO3L3lMleBEZHPwAgQhQOrJLP+MbYwDWmkb/1AaGFtJA5UZYADCy8xkg0s9GuZoDQXMOwU9jg94sagSJYuhzjsfvOL5oNcl61+BmLgRxAMcgU+gadAu/xGY1NO35U6ah08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790298797; c=relaxed/simple;
	bh=bmgdSm8YNHW5kPtfT3/SqPZq1EkFkf4vUCBmOXLEWxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kKo/9TQ8lZ/pKgKch8Wes5CoK+1tfJd43LQSh+UKkasRyE9KeRUMl+uba1ZT5aKJYmeU4zj08pZdJEcIme3nlBqVi/ITrNd3PsZzlRQt/YWBzfxFCr7tjBseHm9HHZEbFJXQCVNQfSGmgxQNhPrqKrQpbAyDYNP8IUKDGXGZlBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5UoLabw; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5UoLabw"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a0dc7f26cso539650b3a.3
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 18:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790298793; x=1790903593; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lelMh14JrGavtZ6asWUfZuJNFtBWesyUfwFCF+GGQWw=;
        b=M5UoLabwT33VeskS4L3oCfSi/fbDvczLM7CKII8ukKu2YrPAx6xjdvR3yVNs854SEg
         /YHdF6D1zExIGoJ8SvxHnKks1X0Go8jk2GbEaIvXkonu+JKxz5rCo06sd71DvuzuGIrP
         rm7UKxuFk3VcbH+HnUDSlVKFiZSISQ21DyUof+drcSSBgDSTpNVWKQCqfWBnERAN6rpm
         siEAWYWN/ufaX3PH3cQJ/5lfkUDzBrio8UOVT/kRC0VVV63n40ZwgBrOMbC3N+2Ef4IC
         REd7Fc6GUUiJFabkLBND3SF61mnafF1SwKdNq0QB/30DP4nZB8A5qzHvlUWpB491PJzf
         yMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790298793; x=1790903593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lelMh14JrGavtZ6asWUfZuJNFtBWesyUfwFCF+GGQWw=;
        b=i9lqEDBzQa0StOieged6HKPar5IzJ3CN9j3BJ1FNz9sH/1yP1ooJ/WlHc5HMAjfUx3
         lJvFXqE7DctPL0JdMD8Wv6W4UaqR5dEq0jnjkFFENnEeMMWhiS0EY06qcw1+ETf+X1yn
         VTXHPzyBgyV/sK0iOIRzt99SFoTzOUXVEPkDF6nqvxTGwFNRoueRSl0yYM5hz1J44UVg
         p/jHbu2BqxJn7R+RudZXm1SBoQ6A4xvbqsyStIauVujDvBW2p480WLHoGMyap4aGxxKj
         +5QDmYLzZwP3dp/UlOcN6OouRYDOz6MYamWDcdVWigcMEGU+jqokx4IytVipnDiAKtqU
         51+g==
X-Forwarded-Encrypted: i=1; AKwUvBwNErOgvSEsxHGvYYXEg9sa316K8OoOVieb3yQw6O8emUDnDban1UHv8JOHANGu6Bvn931HEw==@lists.linux.dev
X-Gm-Message-State: AFuF++k3dVguY26THtEF70iglGO+/Bqx7mhAEVmP6qDz4sBsyFohHSWQ
	hH2Uc6Ag2d/dprP/GEY2v9IuF1p9m5ptR2nJudZbogmnbe4zM98gvLHZw+Jg7V+6+QwuTQXasKC
	SM2mnlqOeCxdN6Q==
X-Received: from pfbg5.prod.google.com ([2002:a05:6a00:ae05:b0:87f:c4bd:8a29])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:28c3:b0:87d:3894:198d with SMTP id d2e1a72fcca58-87e9ca1ea12mr4000958b3a.58.1790298792751;
 Thu, 24 Sep 2026 18:13:12 -0700 (PDT)
Date: Fri, 25 Sep 2026 01:13:05 +0000
In-Reply-To: <20260925011308.3381953-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260925011308.3381953-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925011308.3381953-2-skhawaja@google.com>
Subject: [RFC PATCH 1/3] vfio: selftests: Add support of creating iommus from iommufd
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add API to init a struct iommu using an already opened iommufd instance
and attach devices to it.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  2 +
 .../lib/include/libvfio/vfio_pci_device.h     |  2 +
 tools/testing/selftests/vfio/lib/iommu.c      | 60 +++++++++++++++++--
 .../selftests/vfio/lib/vfio_pci_device.c      | 25 ++++++--
 4 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..62f1e8affd2b 100644
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
index e19bd94b8dd2..4dcc23bc9b78 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -19,6 +19,7 @@ struct vfio_pci_device {
 	const char *bdf;
 	int fd;
 	int group_fd;
+	u32 dev_id;
 
 	struct iommu *iommu;
 
@@ -82,6 +83,7 @@ static inline void vfio_pci_cmd_clear(struct vfio_pci_device *device, u16 bits)
 	vfio_pci_config_writew(device, PCI_COMMAND, cmd & ~bits);
 }
 
+void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu);
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..6d2d5c82813c 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -405,6 +405,18 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges)
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
@@ -415,17 +427,25 @@ static u32 iommufd_ioas_alloc(int iommufd)
 	return args.out_ioas_id;
 }
 
-struct iommu *iommu_init(const char *iommu_mode)
+static struct iommu *iommu_alloc(const char *iommu_mode)
 {
-	const char *container_path;
 	struct iommu *iommu;
-	int version;
 
 	iommu = calloc_assert(1, sizeof(*iommu));
 
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
@@ -449,10 +469,42 @@ struct iommu *iommu_init(const char *iommu_mode)
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
+static void iommufd_cleanup(struct iommu *iommu)
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
+		iommufd_cleanup(iommu);
 	else
 		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 774d1e90ec0e..81d3879d064f 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -469,15 +469,15 @@ int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
 	if (ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args))
 		return -errno;
 
-	return 0;
+	return args.out_devid;
 }
 
-static void vfio_device_bind_iommufd(int device_fd, int iommufd,
-				     const char *vf_token)
+int vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
 {
 	int ret = __vfio_device_bind_iommufd(device_fd, iommufd, vf_token);
 
-	VFIO_ASSERT_EQ(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
+	VFIO_ASSERT_GE(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
+	return ret;
 }
 
 static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
@@ -503,10 +503,25 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
 				   const char *bdf, const char *vf_token)
 {
 	vfio_pci_cdev_open(device, bdf);
-	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
+	device->dev_id = vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
+void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu)
+{
+	u32 pt_id = iommu->ioas_id;
+
+	/* Only iommufd supports changing struct iommu attachments */
+	VFIO_ASSERT_TRUE(iommu->iommufd);
+
+	if (iommu->hwpt_id)
+		pt_id = iommu->hwpt_id;
+
+	VFIO_ASSERT_NE(pt_id, 0);
+	vfio_device_attach_iommufd_pt(device->fd, pt_id);
+	device->iommu = iommu;
+}
+
 struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

