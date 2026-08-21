Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208B40B6E0
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340911; cv=none; b=HJWT1SJJPKmHEGjrcNTy1uZZXTqlMlU7s4bXNB5KYRTKhUcSpM8IiKV8nTdy9OW1+WTb1Y6pw/zalYcYc+tGof7MHj6MRY23SP9/5AdjkHvuAForehEjaOQWVLMSrsRdc3DvxLTFt7Q/j/2LuQbrxLNpTS8oelLMotJ81oMwbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340911; c=relaxed/simple;
	bh=bRSJ89K8K73/lfPTmQjl/e3hiGKByMp4oSrMZ6XtBYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KM8sXuQw+QUuDmaqw84fikbb8TrgQ5fKSibHeCJpThtGzNv8etruJagl9EGXQU4YMrwXm8svl6nIOkr2uL8hhvrzzjXJRr4FazsPL9vG+V6OhHVC3wtfeisQ5imLGvpe9/pDl7m8BUHn6Mht8EbQ6hiZBZ14LBgtv5eFbcxYqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQ3tWH/x; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQ3tWH/x"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d5d00fd19bso25868805ad.1
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787340909; x=1787945709; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GMXnvq7D8YucUDG8E30c7kSwAfsqFKmqAniOaqKEfc=;
        b=OQ3tWH/xVUMoIqow1IKu6am4ryYq/a2c/D+IIrLvXER5OXlqgzgd9Li+4G1laQ6bKj
         PSvkIuyblFyDUdk0z3UrPcOfzIBMs/oGeHaGTV7Lww5O4NgX0zH9nmwP3wOkEHGpZkKs
         0nXFash2vg5+QHbRPxAaWpDaFsSG9GuQH8F0Hxdw1nxL0xqZUgE3pYKgUnenfoDNRdA8
         c3zv3nRld5L1Dqxyp01ewXGlqRJzvHBnW36JLu9L1FDtFFmZIyHfz6KcinHR9t7NnVTO
         dgUNoKiNJ9moupJw/b73kXNpBDgiZK/Z21jFBf8564pJk/fnc9BngbHuOQ3XgFOhjv+w
         cbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787340909; x=1787945709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GMXnvq7D8YucUDG8E30c7kSwAfsqFKmqAniOaqKEfc=;
        b=bulIM4bIUu58NZhAYNK3IPKoG84LdJ5oHwTJRmUogdoS60Rz5vKPjGwaH+mYzNcqFI
         22UppcS0Eb+MTNpOBp7SOl6gFyPLHnL+TkI3cMhsumyEq4e3Tsa19PrCQE5hj2g3sf7x
         VO4zeH8aUrtUEl8lWBPg7/hHH1gWc1rTbOw76bxTVRqpT6N2zTHx3EHyoOsAd2Sg/Nah
         QKCYDn5KRdBsjGzYn1Vi2oaezRKtr1e6gkdiAWBQXFJp9VhGIpTEP0MVQV33wyL0drZr
         YXcAjirgEIaGCAn5uHbhDiEYwe9S0Bgz+WJa9+VQVGuQ8zxjhtUj4l3naU9o0NCb6NoM
         LIQg==
X-Forwarded-Encrypted: i=1; AHgh+RrJc67/sDPEwXSRJkz1H2DPtqHsTOuZiISKri4JEZz7PScQ479xthSgiuC9drvOMZ+J/LaIQw==@lists.linux.dev
X-Gm-Message-State: AFuF++k7/2G2BQU/Jbp91QDyFcbXL+cFHoC6ptmqykiRYwKKaslHdjdr
	F75nf8kyTENkQk2HkYTpibR32yyRbQT9eVRFRv83z3+w5aozcYuJshZRXlTEyxfcnX3yyyZ2wB1
	6CyjDVfPJkg==
X-Received: from plks10.prod.google.com ([2002:a17:903:2ca:b0:2cb:d8fb:3da3])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec86:b0:2c6:9f66:d573
 with SMTP id d9443c01a7336-2d64ae3ac9emr164652355ad.2.1787340909050; Fri, 21
 Aug 2026 12:35:09 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:35:01 -0700
In-Reply-To: <20260821193502.92431-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260821193502.92431-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260821193502.92431-2-vipinsh@google.com>
Subject: [RFC PATCH 1/1] selftests: vfio: Add mmap fault and device reset test
From: Vipin Sharma <vipinsh@google.com>
To: Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>
Cc: jrhilke@google.com, skhawaja@google.com, tatashin@google.com, 
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest to verify VFIO PCI device reset on an mmapped and faulted
device. The test maps all available BARs on the device, faults them,
and triggers a device reset via the VFIO_DEVICE_RESET ioctl.

This exercise uncovers a circular locking dependency introduced in
commit f5b16b802174 ("PCI: Suspend iommu function prior to resetting a
device"), where pci_dev_reset_iommu_prepare() acquires group->mutex
under vfio's vdev->memory_lock.

Assisted-by: Jetski:gemini-3.1-pro
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/vfio_pci_mmap_reset_test.c | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..17b3a2fe215c 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_pci_mmap_reset_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c b/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c
new file mode 100644
index 000000000000..b004867905de
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/pci_regs.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+static const char *device_bdf;
+
+FIXTURE(vfio_pci_mmap_reset_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_SETUP(vfio_pci_mmap_reset_test)
+{
+	self->iommu = iommu_init(MODE_IOMMUFD);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_mmap_reset_test)
+{
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+TEST_F(vfio_pci_mmap_reset_test, mmap_fault_and_reset)
+{
+	volatile char dummy;
+	bool has_mmap = false;
+	int i;
+
+	if (!(self->device->info.flags & VFIO_DEVICE_FLAGS_RESET))
+		SKIP(return, "Device does not support reset\n");
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct vfio_pci_bar *bar = &self->device->bars[i];
+
+		if (!bar->vaddr)
+			continue;
+
+		/* Touch BAR to trigger page fault under mmap_lock */
+		dummy = *(volatile char *)bar->vaddr;
+		(void)dummy;
+		has_mmap = true;
+	}
+
+	if (!has_mmap)
+		SKIP(return, "No mmapable BAR found on device\n");
+
+	/* Trigger device reset under memory_lock */
+	vfio_pci_device_reset(self->device);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.55.0.766.g2966f0265a-goog

