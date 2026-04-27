Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F153ECBD5
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312626; cv=none; b=ahyth8szxIrLF8dti9cqbl33S/fjhmXvQOhlbRH+3uXw9dRq6eLAo93YT1GYCBcW4NJuctl30f/yMwBfhX/81EhAwflgIfV6NUI+i0XqXIQhJ5oDW9RQGRIBFBMeec7kfWD3iVltQt5dCuKeYqA2nm8apfBXZJmcXEufg1vmHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312626; c=relaxed/simple;
	bh=gMdtqwz7BvSQfC8uI4NmsnYMlFnEUpS63+xZZv9vTMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mQNAyoW2sWdDC57QYMmXjL6qKqtz9h41KlWLPykJbiobm92eq1ByNapBl79ikhWXCHn+pUTFHldXs857/Jv3AMKErgAuyCT61VKRyq8yE2skaWrBzh6AkHk6q9vmcBvwZWP8J5MpaZ6UXTJJrhjIKV2NY6Wq+6/hbn78lXFhqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GF5ectTn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GF5ectTn"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso5793005b3a.3
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312623; x=1777917423; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOOImK8WXz7tNusSwniJN4vzly2mvHAuEL1lusqixo8=;
        b=GF5ectTn3DOpAnJP2KypPtjNkw0No4lOOCaqml7QT1uG55S3fnuy4QwExn+MEiI7XO
         fD/q4vUm8ut/EhisRb3J+7fOXwdQb5LIr7HyIpkqoTTk66j9Q4JFnjbmYdz7sCzu/K2J
         FQWiCnolMu5Pgvv56LW+ihwej4lvjP453fngb9LN8f8bStthMOTKUiuaNHUFjdVcmSIz
         eVDOGo0hB4r8cK3LzgSuW/JzTWA1kjFlPkr0r8o8gDhSckh29NKYevqWD7gn7k2PkNap
         4Ga/4EzuKl+UKn2oBP+Ll00eoIvRqViKnXEp4jGl9K18u2Af+J1R9bMPwx03oCwqke11
         uUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312623; x=1777917423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOOImK8WXz7tNusSwniJN4vzly2mvHAuEL1lusqixo8=;
        b=W72dvchdegrEGPdTdItyIR+i0Fzy6exZ4yYkm7lBK4W41IOgyOlACznLCptoGzPIR3
         vPFeWrGM7o7zr6TRs8mxD5PG6eueSv4uQXkiEU0pXdW4QOtoxEd1B53j8U6E+PKcmDDj
         HsHKmHi0Dy1XTzIYKSUG3z4c+WwkYt1S6UnQx+V/vgMm2yJVVxHBLROCqJva2PI/RbLS
         QbMw+jo9+XN1Dpv5eBouo0dfR7e2yhhUZ/VFAq2FPww0Wnrnu8SnRNGu5+yv4Q1AujW7
         MDbHI9G4kcLtmD5I7c0Y3UPpESx21JJhYUWh4JBx7r4NHDfOcYPDqgShMowfV23Dr9lq
         A55A==
X-Forwarded-Encrypted: i=1; AFNElJ9UXBZoSWyah2pqmdoINrHdJK6gi5N16m5b9VBsY4xTqCjqnGyCK5w4lNEevrqkOHsh9oi8Jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMIOl5iYJ0BVLy1miDitmKFjV9IWedquHgejffCrbtQfTSJQsK
	nD8jPx9glm3BepC6GRbzyNS9xMllQbTpfiJbrN2c7FD/jeUmguVElPU1PDN4wqpJ1CEw2EFsLNV
	j8RaoP1Tq0MnUTg==
X-Received: from pfbho13.prod.google.com ([2002:a05:6a00:880d:b0:7ba:8e68:3140])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c8e:b0:82c:e1a0:3453 with SMTP id d2e1a72fcca58-834dc265fabmr16417b3a.26.1777312622436;
 Mon, 27 Apr 2026 10:57:02 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:33 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-17-skhawaja@google.com>
Subject: [PATCH v2 16/16] iommufd/selftest: Add test to verify iommufd preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

Test iommufd preservation by setting up an iommufd and vfio cdev and
preserve it across live update. Test takes VFIO cdev path of a device
bound to vfio-pci driver and binds it to an iommufd being preserved. It
also preserves the vfio cdev so the iommufd state associated with it is
also preserved.

The restore path is tested by restoring the preserved vfio cdev only. On
restore, test verifies that the bind with a new iommufd fails as the
device is attached to the restored IOMMU domain. Also the LUO session
finish fails as the preserved iommufd is not restored.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/iommu/Makefile        |  12 +
 .../iommu/iommufd_liveupdate_kexec_test.c     | 239 ++++++++++++++++++
 2 files changed, 251 insertions(+)
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 84abeb2f0949..ab35e8b21580 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -7,4 +7,16 @@ TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
 
+TEST_GEN_PROGS_EXTENDED += iommufd_liveupdate_kexec_test
+
 include ../lib.mk
+include ../liveupdate/lib/libliveupdate.mk
+
+CFLAGS += -I$(top_srcdir)/tools/include
+CFLAGS += -MD
+CFLAGS += $(EXTRA_CFLAGS)
+
+$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -o $@
+
+EXTRA_CLEAN += $(LIBLIVEUPDATE_O)
diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
new file mode 100644
index 000000000000..49f34146ab63
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <limits.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/iommufd.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+#include <linux/sizes.h>
+#include <libliveupdate.h>
+
+#include "../kselftest.h"
+
+#define ksft_assert(condition) \
+	do { \
+		if (!(condition)) \
+			fail_exit("Failed: %s", #condition); \
+	} while (0)
+
+static const char *device_cdev_path;
+static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+static char iommufd_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+
+static const uint64_t STATE_TOKEN;
+static const uint64_t IOMMUFD_TOKEN = 0x123456;
+static const uint64_t CDEV_TOKEN = 0x654321;
+static const uint64_t HWPT_TOKEN = 0x789012;
+static const uint64_t MEMFD_TOKEN = 0x890123;
+
+static int open_cdev(const char *vfio_cdev_path)
+{
+	int cdev_fd;
+
+	cdev_fd = open(vfio_cdev_path, O_RDWR);
+	if (cdev_fd < 0)
+		ksft_exit_skip("Failed to open VFIO cdev: %s\n", vfio_cdev_path);
+
+	return cdev_fd;
+}
+
+static int open_iommufd(void)
+{
+	int iommufd;
+
+	iommufd = open("/dev/iommu", O_RDWR);
+	if (iommufd < 0)
+		ksft_exit_skip("Failed to open /dev/iommu. IOMMUFD support not enabled.\n");
+
+	return iommufd;
+}
+
+static int create_sealed_memfd(size_t size)
+{
+	int fd, ret;
+
+	fd = memfd_create("buffer", MFD_ALLOW_SEALING);
+	if (fd < 0)
+		fail_exit("memfd_create failed");
+
+	ret = ftruncate(fd, size);
+	if (ret)
+		fail_exit("ftruncate failed");
+
+	ret = fcntl(fd, F_ADD_SEALS, F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL);
+	if (ret)
+		fail_exit("fcntl F_ADD_SEALS failed");
+
+	return fd;
+}
+
+#define test_ioctl(fd, cmd, arg) \
+	do { \
+		if (ioctl(fd, cmd, arg)) \
+			fail_exit("ioctl(%s) failed", #cmd); \
+	} while (0)
+
+#define test_luo_session_preserve_fd(session, fd, token) \
+	do { \
+		if (luo_session_preserve_fd(session, fd, token)) \
+			fail_exit("luo_session_preserve_fd(%s) failed", #token); \
+	} while (0)
+
+#define test_luo_session_retrieve_fd(session, token) \
+	({ \
+		int _fd = luo_session_retrieve_fd(session, token); \
+		if (_fd < 0) \
+			fail_exit("luo_session_retrieve_fd(%s) failed", #token); \
+		_fd; \
+	})
+
+static void setup_iommufd(int iommufd, int memfd, int cdev_fd)
+{
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+		.iommufd = iommufd,
+	};
+	struct iommu_ioas_alloc alloc_data = {
+		.size = sizeof(alloc_data),
+		.flags = 0,
+	};
+	struct iommu_hwpt_alloc hwpt_alloc = {
+		.size = sizeof(hwpt_alloc),
+		.flags = 0,
+	};
+	struct vfio_device_attach_iommufd_pt attach_data = {
+		.argsz = sizeof(attach_data),
+		.flags = 0,
+	};
+	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve = {
+		.size = sizeof(mark_preserve),
+		.hwpt_token = HWPT_TOKEN,
+	};
+	struct iommu_ioas_map_file map_file = {
+		.size = sizeof(map_file),
+		.length = SZ_1M,
+		.flags = IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE,
+		.iova = SZ_4G,
+		.fd = memfd,
+		.start = 0,
+	};
+
+	test_ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+
+	test_ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
+
+	hwpt_alloc.dev_id = bind.out_devid;
+	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
+	test_ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
+
+	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
+	test_ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+
+	map_file.ioas_id = alloc_data.out_ioas_id;
+	test_ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
+
+	mark_preserve.hwpt_id = attach_data.pt_id;
+	test_ioctl(iommufd, IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, &mark_preserve);
+}
+
+static void before_kexec(int luo_fd)
+{
+	int iommufd, cdev_fd, memfd, session;
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session = luo_create_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_create_session failed");
+
+	iommufd = open_iommufd();
+	memfd = create_sealed_memfd(SZ_1M);
+	cdev_fd = open_cdev(device_cdev_path);
+
+	setup_iommufd(iommufd, memfd, cdev_fd);
+
+	/* Cannot preserve cdev without iommufd */
+	if (!luo_session_preserve_fd(session, cdev_fd, CDEV_TOKEN))
+		fail_exit("Preserving cdev without iommufd should fail");
+
+	/* Cannot preserve iommufd without preserving memfd. */
+	if (!luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN))
+		fail_exit("Preserving iommufd without memfd should fail");
+
+	test_luo_session_preserve_fd(session, memfd, MEMFD_TOKEN);
+	test_luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN);
+	test_luo_session_preserve_fd(session, cdev_fd, CDEV_TOKEN);
+
+	close(session);
+	session = luo_create_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_create_session failed");
+
+	test_luo_session_preserve_fd(session, memfd, MEMFD_TOKEN);
+	test_luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN);
+	test_luo_session_preserve_fd(session, cdev_fd, CDEV_TOKEN);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void after_kexec(int luo_fd, int state_session_fd)
+{
+	int iommufd, cdev_fd, session, stage;
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+	};
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	ksft_assert(stage == 2);
+
+	session = luo_retrieve_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_retrieve_session failed");
+
+	cdev_fd = test_luo_session_retrieve_fd(session, CDEV_TOKEN);
+
+	iommufd = luo_session_retrieve_fd(session, IOMMUFD_TOKEN);
+	if (iommufd >= 0)
+		fail_exit("iommufd should not be retrievable yet");
+
+	iommufd = open_iommufd();
+
+	bind.iommufd = iommufd;
+	if (ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind) == 0 || errno != EPERM)
+		fail_exit("Binding cdev to new iommufd should fail with EPERM");
+
+	/* Should fail */
+	if (luo_session_finish(session) == 0)
+		fail_exit("luo_session_finish should fail if iommufd is not restored");
+
+	close(iommufd);
+	close(cdev_fd);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc < 2) {
+		printf("Usage: %s <vfio_cdev_path>\n", argv[0]);
+		return 1;
+	}
+
+	device_cdev_path = argv[1];
+	sprintf(iommufd_session, "iommufd-test-%s", "cdev");
+	sprintf(state_session, "state-%s", "iommufd-cdev");
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.54.0.545.g6539524ca2-goog

