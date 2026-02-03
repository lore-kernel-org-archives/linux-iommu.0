Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258E38735E
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156614; cv=none; b=SjtTRvBIZ9djcAt0DjuWkX+bharbVSP9mHUjEhy+fpbKTKZvsdLLdNHGN9BZMQ1hzXSzE0742Z6UdPswNQ4RlfBgKH5WC230HPxjTM0MiLI+1MnHCuR7Q6/V5su916cy/hv02GYLa8Z4Hr99LbvwjK/Zgjgp8yNWeLwjzkpNyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156614; c=relaxed/simple;
	bh=+jbk5dN4Kg0hIbvLC9M49kRaC9JuOCkxvufz9fXJbrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XWCF1nFHSg2rKgvqAQcnuJkFPA7f5xT5VU56Rv1TvNZU+cpzr6jwtqOeLRsLJYMoLopn4xdBIQ/8MbODd/2GT0WAqs+ubj8C0Fay+/05WQC4XW/fyygseq3EuMcJLoWnDiXxnRHqe37gCZUO8dqkcLFLpF7icjMBPZYkb7T3h3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RsHi5vS9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsHi5vS9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81e81fbbb8cso5807752b3a.3
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156613; x=1770761413; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BadSv0cPbiUnIcaCmXI9N9Iq0BsivzkGFYVhjIgVFI=;
        b=RsHi5vS9Hx7INwvQq1iURK1Lx/lUwC98VAt6WKJVtYhoYcvLrOcaAlEw7FVEceLJ6o
         BqqtY4favft3VvkFzWDBdO3cXXwmvXHe9KaD79TGeNXJUnsRWbvr6DXoJhaYmE54rNRs
         Y37u2Q52gNDfYLvfbzM4MraKOkfGvc42BhyHoiOR4BgWuqpPFHVLoHXcMRvcsiOprb4R
         pdfenkzTo8VYPAR/XUYQSBViIjemuVTW7gTpna+M8hbZvg2V3X0WLUmjFPzhScFyRSXH
         P8LLsePHqslS4GpMCT0BC5Dk8UD0ZBT/WIoIyHlGMxWYUncEsW9UY05y0Dwrtz/Xb/Xm
         0LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156613; x=1770761413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BadSv0cPbiUnIcaCmXI9N9Iq0BsivzkGFYVhjIgVFI=;
        b=TJUud68fLwMCYQdKR/zcscxKqkcsd2dNGaKa8GqeQJ8AAVGafdBhMtdn2N9Lw8F9nG
         A6YFxyyt5GBNyKtTciG/L2uBT9/8x5Zn/HDcuL9N/CCHWJH1clwzOU07NLaN7h/Y8xtP
         L7mma/HHhzyMek788ks5XTp2oPu0TzfNL1+5tQcWKDH11bTQT6fIez9kgh4145X3QRTB
         B/CbfpcajNlojKI9LnrXUytWwMsSmbq/7q6wnycfJ7tgj1jeahWZV2Kj4yWk2Nt2ZblW
         WR04oRd4T3N9qTJLWkPyr4oFBVRRX4hARYja3WGenoa47jRf64aoEDjTbDRRU4zmDMbK
         9duw==
X-Forwarded-Encrypted: i=1; AJvYcCXAhMwsn5+rK7JQQBCFjoPchn6BlK2LMLVxB8lW8u/tZx4sDWiW8PZx9t7OVV5A6JX8ygFnig==@lists.linux.dev
X-Gm-Message-State: AOJu0YxN6g3wk06OxKyZZxuqkVFAboNzt0soqU0P/T3If8rVDAmKMZi/
	FoCsVyv6C1XkNu/kNfTnw/Csa0i19LDAYQ9h2YY9wVIzR8VaaLvY5t49ErDquLqYLzi97v7g9aS
	KvGNn2S+6fHhJsA==
X-Received: from pfld15.prod.google.com ([2002:a05:6a00:198f:b0:77f:33ea:96e9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2307:b0:823:1276:9a86 with SMTP id d2e1a72fcca58-8241c5efdabmr771793b3a.39.1770156612602;
 Tue, 03 Feb 2026 14:10:12 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:48 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-15-skhawaja@google.com>
Subject: [PATCH 14/14] iommufd/selftest: Add test to verify iommufd preservation
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

The restore path is tested by restoring the preserved vfio cdev only.
Test tries to finish the session without restoring iommufd and confirms
that it fails.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/iommu/Makefile        |  12 +
 .../selftests/iommu/iommufd_liveupdate.c      | 209 ++++++++++++++++++
 2 files changed, 221 insertions(+)
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 84abeb2f0949..263195af4d6a 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -7,4 +7,16 @@ TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
 
+TEST_GEN_PROGS_EXTENDED += iommufd_liveupdate
+
 include ../lib.mk
+include ../liveupdate/lib/libliveupdate.mk
+
+CFLAGS += -I$(top_srcdir)/tools/include
+CFLAGS += -MD
+CFLAGS += $(EXTRA_CFLAGS)
+
+$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -static -o $@
+
+EXTRA_CLEAN += $(LIBLIVEUPDATE_O)
diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
new file mode 100644
index 000000000000..8b4ea9f2b7e9
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdbool.h>
+#include <unistd.h>
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
+	do { if (!(condition)) \
+	ksft_exit_fail_msg("Failed: %s at %s %d: %s\n", \
+	#condition, __FILE__, __LINE__, strerror(errno)); } while (0)
+
+int setup_cdev(const char *vfio_cdev_path)
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
+int open_iommufd(void)
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
+int setup_iommufd(int iommufd, int memfd, int cdev_fd, int hwpt_token)
+{
+	int ret;
+
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
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
+	struct iommu_hwpt_lu_set_preserve set_preserve = {
+		.size = sizeof(set_preserve),
+		.hwpt_token = hwpt_token,
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
+	bind.iommufd = iommufd;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+	ksft_assert(!ret);
+
+	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
+	ksft_assert(!ret);
+
+	hwpt_alloc.dev_id = bind.out_devid;
+	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
+	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
+	ksft_assert(!ret);
+
+	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+	ksft_assert(!ret);
+
+	map_file.ioas_id = alloc_data.out_ioas_id;
+	ret = ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
+	ksft_assert(!ret);
+
+	set_preserve.hwpt_id = attach_data.pt_id;
+	ret = ioctl(iommufd, IOMMU_HWPT_LU_SET_PRESERVE, &set_preserve);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+static int create_sealed_memfd(size_t size)
+{
+	int fd, ret;
+
+	fd = memfd_create("buffer", MFD_ALLOW_SEALING);
+	ksft_assert(fd > 0);
+
+	ret = ftruncate(fd, size);
+	ksft_assert(!ret);
+
+	ret = fcntl(fd, F_ADD_SEALS,
+		    F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL);
+	ksft_assert(!ret);
+
+	return fd;
+}
+
+int main(int argc, char *argv[])
+{
+	int iommufd, cdev_fd, memfd, luo, session, ret;
+	const int token = 0x123456;
+	const int cdev_token = 0x654321;
+	const int hwpt_token = 0x789012;
+	const int memfd_token = 0x890123;
+
+	if (argc < 2) {
+		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
+		return 1;
+	}
+
+	luo = luo_open_device();
+	ksft_assert(luo > 0);
+
+	session = luo_retrieve_session(luo, "iommufd-test");
+	if (session == -ENOENT) {
+		session = luo_create_session(luo, "iommufd-test");
+
+		iommufd = open_iommufd();
+		memfd = create_sealed_memfd(SZ_1M);
+		cdev_fd = setup_cdev(argv[1]);
+
+		ret = setup_iommufd(iommufd, memfd, cdev_fd, hwpt_token);
+		ksft_assert(!ret);
+
+		/* Cannot preserve cdev without iommufd */
+		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
+		ksft_assert(ret);
+
+		/* Cannot preserve iommufd without preserving memfd. */
+		ret = luo_session_preserve_fd(session, iommufd, token);
+		ksft_assert(ret);
+
+		ret = luo_session_preserve_fd(session, memfd, memfd_token);
+		ksft_assert(!ret);
+
+		ret = luo_session_preserve_fd(session, iommufd, token);
+		ksft_assert(!ret);
+
+		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
+		ksft_assert(!ret);
+
+		close(session);
+		session = luo_create_session(luo, "iommufd-test");
+
+		ret = luo_session_preserve_fd(session, memfd, memfd_token);
+		ksft_assert(!ret);
+
+		ret = luo_session_preserve_fd(session, iommufd, token);
+		ksft_assert(!ret);
+
+		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
+		ksft_assert(!ret);
+
+		daemonize_and_wait();
+	} else {
+		struct vfio_device_bind_iommufd bind = {
+			.argsz = sizeof(bind),
+			.flags = 0,
+		};
+
+		cdev_fd = luo_session_retrieve_fd(session, cdev_token);
+		ksft_assert(cdev_fd > 0);
+
+		iommufd = luo_session_retrieve_fd(session, token);
+		ksft_assert(iommufd < 0);
+
+		iommufd = open_iommufd();
+
+		bind.iommufd = iommufd;
+		ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+		ksft_assert(ret);
+		ksft_assert(errno == EPERM);
+
+		/* Should fail */
+		ret = luo_session_finish(session);
+		ksft_assert(ret);
+	}
+
+	return 0;
+}
-- 
2.53.0.rc2.204.g2597b5adb4-goog

