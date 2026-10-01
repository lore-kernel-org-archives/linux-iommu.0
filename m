Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB04DEC19
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894811; cv=none; b=kRzcxYnhwvDhn1Ms4WXoySFgpK64wPIe1Xsky7G7y/kSdAQgGynM5EbaPjPVIVsY9AIxLZUkkDdqEkg+Zf7Df2JN33CEg4livqEBo5Ry9zVErM+TXTiT9clWzZXK5KVin+oMTxni16Jpl5SA1wWTgipCY5UqN0+onEDV387IWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894811; c=relaxed/simple;
	bh=+ZrMyvypAMHMJwmzcIZVzfzQU/AIsNYo+KFbpNJHSEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SVbcYr4cLGH/+YsQQDgjhe0ylYSd14pYs3UVRzm6Uc/QeiGKS7e3IqF/LHbyTAec+R87xa7vZjAmxKCZjOdKs0Msu8jtVz2tDg5pwkJ0iS3ZoY0gs02tfP5YcEOyBC0IyKGR8plP0t9G0fYDPCnUkkg3qyKO6S4AvMsIFXhCplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uT6BqYxK; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uT6BqYxK"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8886b1d3242so979310b3a.0
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894809; x=1791499609; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkzBth2K8luOc5hRw7dwkQ++Ts6T4OZjlz0I1Txn4EY=;
        b=uT6BqYxKW2Q9W0Pd68BXgKYaD2Lq++dzEA+wQxEi67BBLKUmjJ4DbKnzqbZ7ztjjEr
         02aaZiOGBRCj9S/cwe1taF54HBm8aKNLOBH/6WMGgfiCiBchk3TTiSCBrXcsLH01Rkj+
         eKcnBXf0dMXh3ZQdkKHkNh8fcQvUHyAf6GXxSeiFTkAkN4viqrmCd+tcHf+5sxYIxtpv
         gUQGJV3hGIfLVqt65iwBhicupWXFWiU+4KuoL2eUGeP4iur+488O8eqB18xFC5mbd86E
         Rt6NZP3cOb6BGv32A1qalf4WWGDICKroJ2BEWQ/30hLTBn4jU4OUA2FyW5t36YNAh5Rv
         SB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894809; x=1791499609;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OkzBth2K8luOc5hRw7dwkQ++Ts6T4OZjlz0I1Txn4EY=;
        b=umTNlUgVLdQfXf0LQbOv6k9xJEC9qcj+wzh0Q1colTPx5L9CY/m1WLC+LR5rLVXoXF
         6gBR9xeuDl24+CRYzuR6j/K4wCMmF8kiIdcrbvzd8O3FiLHWXqnWHmYHYfNfZnUmPDaa
         iThMMFwOIC1Wfbc3WmhJNkYwqWI25zJfTEENW5liQVnPVlCExRCwRzqPIFpRXs36d4Nx
         yoKozhC4LISQypmVIAngC7giJHbKh4Qc1o458mBFdMer3YvjRE5jMd2iiRYpfQ7khzYB
         KPFUplwwwJgrmrLAaan2xqqiVsUWJ85mHoh/FxRseAV8RxZlUEAb0k9YMnAi3LYvTYm5
         fBiw==
X-Forwarded-Encrypted: i=1; AKwUvBy9e2Wy2l21Ds69O2w1+XfXFggsXKZyw5GUUSS6tpLElMjoLErrPDLldEF/OZUlv+V85OqqqQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nrrgYDAcK5cmtAy6w5304ynl19zE+5foDlfHIwIJlMfdY1CyJe
	r6gwUHbahO9CxVv5lTjEir6NlLRIAzzQbS8M+mm//vpUKSCjyMPeGxRTlrqq/hebTtKXaN381de
	eRg==
X-Received: from pfbhu50.prod.google.com ([2002:a05:6a00:69b2:b0:887:3013:c8e7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1888:b0:886:1119:2cbf
 with SMTP id d2e1a72fcca58-88af2687915mr858560b3a.5.1790894808625; Thu, 01
 Oct 2026 15:46:48 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:31 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-8-praan@google.com>
Subject: [RFC PATCH 7/7] vfio/selftests: Add observability test for IO page
 table usage
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a new selftest, vfio_nr_pages_test, to validate the iommu-nr-pages
fdinfo metric across all IOMMU backends (Type 1 and IOMMUFD native/compat).

The test performs a sparse mapping to force the underlying IOMMU driver
to allocate a deep page table hierarchy. It then asserts that the
nr_pages metric increases and proves the 'sticky' reclamation behavior
by verifying the page count does not drop immediately upon unmapping.

The test is skipped when the IOMMU driver does not account its page
table memory, in which case the metric is not reported.

Co-developed-by: Logan Odell <loganodell@google.com>
Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_nr_pages_test.c       | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_nr_pages_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..140ef273e36b 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_nr_pages_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_nr_pages_test.c b/tools/testing/selftests/vfio/vfio_nr_pages_test.c
new file mode 100644
index 000000000000..aef6b1dd8e19
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_nr_pages_test.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <linux/sizes.h>
+
+#include <libvfio.h>
+
+#include "../kselftest_harness.h"
+
+static const char *device_bdf;
+
+static long read_nr_pages(struct iommu *iommu)
+{
+	char path[256];
+	char line[128];
+	FILE *f;
+	long val = -1;
+	int fd = iommu->container_fd != -1 ? iommu->container_fd : iommu->iommufd;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", fd);
+	f = fopen(path, "r");
+	if (!f)
+		return -1;
+
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "iommu-nr-pages: %ld", &val) == 1)
+			break;
+	}
+
+	fclose(f);
+	return val;
+}
+
+FIXTURE(vfio_nr_pages_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_VARIANT(vfio_nr_pages_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_name) \
+FIXTURE_VARIANT_ADD(vfio_nr_pages_test, _name) { \
+	.iommu_mode = #_name, \
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+
+FIXTURE_SETUP(vfio_nr_pages_test)
+{
+	self->iommu = iommu_init(variant->iommu_mode);
+	if (!self->iommu)
+		SKIP(return, "IOMMU mode %s not supported", variant->iommu_mode);
+
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	if (!self->device) {
+		iommu_cleanup(self->iommu);
+		SKIP(return, "Failed to initialize VFIO device");
+	}
+}
+
+FIXTURE_TEARDOWN(vfio_nr_pages_test)
+{
+	if (self->device)
+		vfio_pci_device_cleanup(self->device);
+	if (self->iommu)
+		iommu_cleanup(self->iommu);
+}
+
+TEST_F(vfio_nr_pages_test, sparse_mapping_sticky_reclamation)
+{
+	long nr_pages_initial, nr_pages_mapped, nr_pages_final;
+	struct dma_region region1 = {0};
+	struct dma_region region2 = {0};
+
+	if (!self->iommu || !self->device)
+		SKIP(return, "Fixture setup failed");
+
+	nr_pages_initial = read_nr_pages(self->iommu);
+	if (nr_pages_initial < 0)
+		SKIP(return, "iommu-nr-pages not reported by this IOMMU");
+
+	/* Map a page at start */
+	region1.size = SZ_4K;
+	region1.vaddr = mmap_reserve(region1.size, region1.size, 0);
+	ASSERT_NE(MAP_FAILED, region1.vaddr);
+	region1.iova = 0x100000;
+	iommu_map(self->iommu, &region1);
+
+	/* Map another page far away (1GB stride) to force deep page tables */
+	region2.size = SZ_4K;
+	region2.vaddr = mmap_reserve(region2.size, region2.size, 0);
+	ASSERT_NE(MAP_FAILED, region2.vaddr);
+	region2.iova = 0x100000 + SZ_1G;
+	iommu_map(self->iommu, &region2);
+
+	nr_pages_mapped = read_nr_pages(self->iommu);
+	ASSERT_GT(nr_pages_mapped, nr_pages_initial);
+
+	/* Unmap both regions */
+	iommu_unmap(self->iommu, &region1);
+	iommu_unmap(self->iommu, &region2);
+
+	nr_pages_final = read_nr_pages(self->iommu);
+
+	/* Page tables should remain allocated */
+	ASSERT_EQ(nr_pages_final, nr_pages_mapped);
+
+	munmap(region1.vaddr, region1.size);
+	munmap(region2.vaddr, region2.size);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

