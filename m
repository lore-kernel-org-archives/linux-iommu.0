Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E734BA50
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790298798; cv=none; b=JLpbSyhP3RhvV9eqriLLGw2bgTtYzd/26uU0Poe9FsvAHbSo2xqiKgiCe5ntBm4e5veDEQxyzMpRDuLTx2oTGXi3aojA6/cMR5QX7VC93J2Li+x9zvS4PQ147nu4ohoP7kl6M6HDNoWnXfJ8p62aej6PfDnAjvOlhyFyDXXm59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790298798; c=relaxed/simple;
	bh=LiyBbJDZCBB5X8w/ZM9TIidOppoWtqkP9KkO1Sd2NMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oAoYR0IpQkNuU0ZlxZoKOqTo0bkXWJSLg6awnT5xDPbS/LUYs6JSqqLUV4xkaKEElUI0DY+1f2YJcj02dNv3AJDqm0SlX7U0VgMsScKMgFIpjQLNUS/Wlg9sd5+QuPkM38mrcStYTRGIpv0xMWARPq6tMWjTzzz94FyD+ZFnOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsHkUuNd; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsHkUuNd"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so715627a91.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790298794; x=1790903594; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8WxcCWRE+LsVuWv5E6OF/wCr2NQ/egFEQk0kG2izEQ=;
        b=JsHkUuNdA/ur/t1A0sTknzepolJgpFAbHAXc/L1KzPHTFyJaOF08w4tVVPsb3l3NfQ
         xfR0dMaS4GUiz646xzzUYSuoSRgtx+kxuAT8etsfRPAknLn1v59hbyCA16V22375h3v/
         OIAGIFIA+odglM6kUz8SbHrh8ucGugHv4mWviUmllVXqUAQ4fL3nJG5PZ+7OdjKuU0fK
         lQR4gust3gm5/xC9nA9gGSoXks6lecWtp4YYRbvCJaqCuKWpVw+I7jTElhjVXHWVGzC/
         hYeukE+OZpb3pdSKIecQy0MSwBn2mF3/UeDOWFaq3ZQRpGVA3yqWg8+5sHykb1y8YJih
         0NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790298794; x=1790903594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L8WxcCWRE+LsVuWv5E6OF/wCr2NQ/egFEQk0kG2izEQ=;
        b=C5AYA98HP5+NaXFWxOrI4NktCwRLHYx2GZ7ujRvk7GKFZC0VwLhY0sGL9cL92KokNZ
         VXBDHK2qsbTCLYAOE6OxU4O0TgdbZ1Xzm1UpwikZyfOvOCeTgc7JUnrdG0F74eU/gFgP
         IdpSuf0uZukPZhj1iXOdhccH18mAI4lCrA8e/smbGn8lde4liFSFt9YtDG6iy341VDXy
         wsZGZytaKW3UGtCoTCftG7vfCrlMw3O3AqSvDH0h7UT6RffoCUVYhJzFccrtEG4dkXX1
         EoNlVOsZjUD9F2y++21C/XLZXFzCRdVLj9B+kpb5rYcA6zn4k5NYDvky4tJw85IjbXn6
         6H2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxjKo+UZOOXlffp5+i+lsF0wGlrHVLJpDlVVKZTNyQ7Av3fsRVp62jPFjPKir+lZ0nzn3fomA==@lists.linux.dev
X-Gm-Message-State: AFuF++l4h/sZizI7SCOLyKdgQfTPNGNhXAlGt+iEy074bpANh1DYJ1XT
	U9ZnSeCue9gbVOqMVcfMegUotwJG0NV95PZaYlTyE51oBKt3OScDZppdzxh8/AZ6H8FkpT0TKKb
	POvmF4NWV1kEIyg==
X-Received: from pgbdk13.prod.google.com ([2002:a05:6a02:c8d:b0:cc7:573b:6115])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d85:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-3a098ae21c7mr4203805a91.12.1790298793622;
 Thu, 24 Sep 2026 18:13:13 -0700 (PDT)
Date: Fri, 25 Sep 2026 01:13:06 +0000
In-Reply-To: <20260925011308.3381953-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260925011308.3381953-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925011308.3381953-3-skhawaja@google.com>
Subject: [RFC PATCH 2/3] vfio: selftests: Add iommufd hwpt replace test
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a test that does iommufd hwpt replace while a DMA is ongoing. This
verifies the hitless replace of IOMMU domain without disrupting the DMA.

Note that the new domain is attached after mapping the required DMA
memory at the same IOVA in the new domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/vfio_iommufd_hwpt_replace_test.c     | 171 ++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_hwpt_replace_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..01d0e808871b 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -8,6 +8,7 @@ else
 CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
+TEST_GEN_PROGS += vfio_iommufd_hwpt_replace_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_hwpt_replace_test.c b/tools/testing/selftests/vfio/vfio_iommufd_hwpt_replace_test.c
new file mode 100644
index 000000000000..3ec243aae626
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_iommufd_hwpt_replace_test.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+static const char *device_bdf;
+
+static void region_setup(struct iommu *iommu,
+			 struct iova_allocator *iova_allocator,
+			 struct dma_region *region, u64 size)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	void *vaddr;
+
+	vaddr = mmap(NULL, size, prot, flags, -1, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	region->vaddr = vaddr;
+	region->iova = iova_allocator_alloc(iova_allocator, size);
+	region->size = size;
+
+	iommu_map(iommu, region);
+}
+
+static void region_teardown(struct iommu *iommu, struct dma_region *region)
+{
+	iommu_unmap(iommu, region);
+	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
+}
+
+FIXTURE(vfio_iommufd_replace_hwpt_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
+	struct dma_region memcpy_region;
+
+	u64 size;
+	void *src;
+	void *dst;
+	iova_t src_iova;
+	iova_t dst_iova;
+};
+
+FIXTURE_SETUP(vfio_iommufd_replace_hwpt_test)
+{
+	struct vfio_pci_driver *driver;
+
+	self->iommu = iommu_init("iommufd");
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->iova_allocator = iova_allocator_init(self->iommu);
+
+	driver = &self->device->driver;
+
+	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_2M);
+	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
+
+	if (driver->ops)
+		vfio_pci_driver_init(self->device);
+
+	self->size = self->memcpy_region.size / 2;
+	self->src = self->memcpy_region.vaddr;
+	self->dst = self->src + self->size;
+
+	self->src_iova = to_iova(self->device, self->src);
+	self->dst_iova = to_iova(self->device, self->dst);
+}
+
+FIXTURE_TEARDOWN(vfio_iommufd_replace_hwpt_test)
+{
+	struct vfio_pci_driver *driver = &self->device->driver;
+
+	if (driver->ops)
+		vfio_pci_driver_remove(self->device);
+
+	region_teardown(self->iommu, &self->memcpy_region);
+	region_teardown(self->iommu, &driver->region);
+
+	iova_allocator_cleanup(self->iova_allocator);
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+FIXTURE_VARIANT(vfio_iommufd_replace_hwpt_test) {
+	u32 attaches;
+};
+
+FIXTURE_VARIANT_ADD(vfio_iommufd_replace_hwpt_test, domain_replace) {
+	.attaches = 1000,
+};
+
+FIXTURE_VARIANT_ADD(vfio_iommufd_replace_hwpt_test, noreplace) {
+	.attaches = 0,
+};
+
+TEST_F_TIMEOUT(vfio_iommufd_replace_hwpt_test, memcpy, 120)
+{
+	struct dma_region memcpy_region = {}, driver_region = {};
+	struct vfio_pci_driver *driver = &self->device->driver;
+	struct iommu *iommu2 = NULL;
+	u64 size = 0;
+	int ret;
+	u32 i;
+
+	if (variant->attaches) {
+		iommu2 = iommufd_iommu_init(self->iommu->iommufd,
+					    self->device->dev_id);
+
+		memcpy_region = self->memcpy_region;
+		driver_region = self->device->driver.region;
+
+		iommu_map(iommu2, &memcpy_region);
+		iommu_map(iommu2, &driver_region);
+	}
+
+	if (driver->ops) {
+		memset(self->src, 'x', self->size);
+		memset(self->dst, 'y', self->size);
+
+		size = min_t(u64, driver->max_memcpy_size, self->size);
+
+		/*
+		 * Fill the device's queue. memcpy_start() returns with
+		 * max_memcpy_count transfers still outstanding.
+		 */
+		vfio_pci_driver_memcpy_start(self->device,
+					     self->src_iova,
+					     self->dst_iova,
+					     size, driver->max_memcpy_count);
+	}
+
+	/*
+	 * Replace the domain repeatedly while that transfer is in flight. Since
+	 * domain replacement is a race with the translation requests, it needs
+	 * to be done multiple times to capture the small window where iommu
+	 * faults can occur.
+	 *
+	 * The loop ends on the original domain, so the teardown below is safe.
+	 */
+	for (i = 0; i < variant->attaches; i++) {
+		vfio_pci_device_attach_iommu(self->device, iommu2);
+		vfio_pci_device_attach_iommu(self->device, self->iommu);
+	}
+
+	if (driver->ops) {
+		ret = vfio_pci_driver_memcpy_wait(self->device);
+
+		ASSERT_EQ(0, ret);
+		ASSERT_EQ(0, memcmp(self->src, self->dst, size));
+	}
+
+	if (iommu2) {
+		iommu_unmap(iommu2, &memcpy_region);
+		iommu_unmap(iommu2, &driver_region);
+		iommu_cleanup(iommu2);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

