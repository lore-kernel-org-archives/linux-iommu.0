Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73481275AF3
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086486; cv=none; b=uwo4/nSMYnbpWKiwidR9HqOhLol9d1ymBZdaCm3kqAfGUKHuyChMg7qWJEvRpnxqkAAoCdP1zeFfRHMjtY9VuwA44Xr+MTaDRtQmSE4ykSr+XCOSOJh0FOIlUQUrZM+HVz725Dney2ScQuBLV1RDkkAt+GUIHgi6U6ac4awsAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086486; c=relaxed/simple;
	bh=bp7Q5MfQ7BUhrxdif0RdrYgnTPagGMPXrfDPEix32cA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VI8IZKT4J+FMcvpNRpnla53f8tgb5CBiVXdpClJjWi62Ps2p7HTAi/jTuzjrVybFinILpvSiBuQZSUbdpQBe4uM8mH34+ftxLW7WIEhGDKI0yW6cEGJX9rXd7pGrxuFdzqGHXWjjNeUxZsoaOuvez6b4JdMbF+wwFhuLq92Gb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UX+vYyT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UX+vYyT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso3232509b3a.1
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086484; x=1759691284; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJxUEkhR4xzbVVm1hzIqWlYBXGWxXyVuvzNZ0+K6GBc=;
        b=1UX+vYyTapLIX8cPcA7RCzDB8pExhlSy9pBlY5MtmrKDL38vShYTn9/rHBoqWYQO83
         5LvOhCG7jgzHulY5eufcACobpot1Rmx4BVeVk0tRl6CuRWjcME83v2ztQZRkn6/4kpvq
         K4JIE2YipEHgOMc1ZpbzjEcvCE0Sov2JnSbJcnETzwT57+3o8AG2qKg7R6kgT8AGP+6Q
         /0Y/fs1HfEJHh0u9c8x6KwPUHdKeoCABGiJva8uroVhjRP1kvWeocLCcZ2MD2owzLf5Z
         5k6SU4AqVyPliRzdUFA0aU8wKY+DrHEgLTvIHAZ2uH0X2MC5ZpzpXfG0P/LA8XUXMeeE
         UUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086484; x=1759691284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJxUEkhR4xzbVVm1hzIqWlYBXGWxXyVuvzNZ0+K6GBc=;
        b=DcyXoo1DV0XzvW8jyiXarrYEOC03Qsoxln0B+vrULOFN1TERSaZrMik4IlSWysvaaI
         4l0HRTnUm7gINMHIMWoHNseyJVt35LmGrQRwo4UWtvKstvn5Ic8hucDHcPcJsDdX50CS
         vJX1q/C1Ll6bl+5WVHL1aCQ4S+EY9jmLoISr8twDBWLBk7I0UqVeTtoYE/yb+5U0DzUM
         GyCj+EZdsWxe8yjOcWCAtKSx9eCEKviHNFNHiKwFmqd3ZFRe8tqdjCTa7f7wLrEAAzgl
         9InAmfzUaWHWP6V1g9pvGLuEH7R/7nPPYsMU7VlUEN6lkKkUEQeAVNXtJE19xUjTu76X
         qmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvOvf9a3E+OSphIfdz5My6cIwY3j3r1bvSL67iiA2V/kzxDHbmWFVxwv0dX5C/XDl8+yc0cA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKsC76jmPA6EFFpADy53ZvxMKg9vyZ5LdFedCtVWtqjtlU4H1f
	/Ctu+wbBYQBxqqONgL7Ah4wtiuwFGkemwJdT17LTic23bzgb05EWkPlVgQ7HLs6IDIOFPLd1vf3
	gmYaDDqohr7aE0g==
X-Google-Smtp-Source: AGHT+IFMTxLoSANT4uRqLmmBpB6B54qHvJVSAjDeqXG+t6yE8ph3la8TEAGcK8rMwkormXLy9e2ya2SG2UiFcQ==
X-Received: from pfog16.prod.google.com ([2002:aa7:8750:0:b0:77f:1f29:5399])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2395:b0:772:397b:b270 with SMTP id d2e1a72fcca58-78100fcf632mr12637028b3a.10.1759086483707;
 Sun, 28 Sep 2025 12:08:03 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:23 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-16-skhawaja@google.com>
Subject: [RFC PATCH 15/15] iommufd/selftest: Add test to verify iommufd preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Test iommufd preservation by setting up an iommufd and preserve it
across live update. Test takes VFIO cdev path of a device bound to
vfio-pci driver and binds it to an iommufd being preserved.

Note that the helper functions setup_cdev, open_iommufd, and
setup_iommufd will be replaced with VFIO selftest library. Similarly the
helper function defined to open and interface with Live Update
Orchestrator device will be replaced with a common helper library.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 tools/testing/selftests/iommu/Makefile        |   1 +
 .../selftests/iommu/iommufd_liveupdate.c      | 196 ++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 84abeb2f0949..42c962c5e612 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -6,5 +6,6 @@ LDLIBS += -lcap
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
+TEST_GEN_PROGS += iommufd_liveupdate
 
 include ../lib.mk
diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
new file mode 100644
index 000000000000..1003d0cf2cae
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <stdbool.h>
+#include <unistd.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/liveupdate.h>
+#include <linux/iommufd.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+
+#include "../kselftest.h"
+
+#define ksft_assert(condition) \
+	do { if (!(condition)) \
+	ksft_exit_fail_msg("Failed: %s at %s %d\n", \
+	#condition, __FILE__, __LINE__); } while (0)
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
+int setup_iommufd(int iommufd, int cdev_fd)
+{
+	int ret;
+
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+	};
+	struct iommu_ioas_alloc alloc_data  = {
+		.size = sizeof(alloc_data),
+		.flags = 0,
+	};
+	struct vfio_device_attach_iommufd_pt attach_data = {
+		.argsz = sizeof(attach_data),
+		.flags = 0,
+	};
+
+	bind.iommufd = iommufd;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+	ksft_assert(!ret);
+
+	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
+	ksft_assert(!ret);
+
+	attach_data.pt_id = alloc_data.out_ioas_id;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+int open_liveupdate_orchestrator(void)
+{
+	int luo;
+
+	luo = open("/dev/liveupdate", O_RDWR);
+	ksft_assert(luo > 0);
+
+	return luo;
+}
+
+__u32 liveupdate_get_state(int luo)
+{
+	struct liveupdate_ioctl_get_state state;
+	int ret;
+
+	state.size = sizeof(state);
+	ret = ioctl(luo, LIVEUPDATE_IOCTL_GET_STATE, &state);
+	ksft_assert(!ret);
+
+	return state.state;
+}
+
+bool liveupdate_state_normal(int luo)
+{
+	return liveupdate_get_state(luo) == LIVEUPDATE_STATE_NORMAL;
+}
+
+bool liveupdate_state_updated(int luo)
+{
+	return liveupdate_get_state(luo) == LIVEUPDATE_STATE_UPDATED;
+}
+
+int liveupdate_set_event(int luo, enum liveupdate_event ev)
+{
+	struct liveupdate_ioctl_set_event event;
+	int ret;
+
+	event.event = ev;
+	event.size = sizeof(event);
+
+	ret = ioctl(luo, LIVEUPDATE_IOCTL_SET_EVENT, &event);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+int liveupdate_preserve_iommufd(int luo, int iommufd, int token)
+{
+	struct liveupdate_ioctl_fd_preserve preserve;
+	int ret;
+
+	preserve.fd = iommufd;
+	preserve.token = token;
+	preserve.size = sizeof(preserve);
+
+	ret = ioctl(luo, LIVEUPDATE_IOCTL_FD_PRESERVE, &preserve);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+int liveupdate_restore_iommufd(int luo, int token)
+{
+	struct liveupdate_ioctl_fd_restore restore;
+	int ret;
+
+	restore.token = token;
+	restore.size = sizeof(restore);
+
+	ret = ioctl(luo, LIVEUPDATE_IOCTL_FD_RESTORE, &restore);
+	ksft_assert(!ret);
+	ksft_assert(restore.fd > 0);
+
+	return restore.fd;
+}
+
+int main(int argc, char *argv[])
+{
+	int iommufd, cdev_fd, luo, ret;
+	const int token = 0x123456;
+
+	if (argc < 2) {
+		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
+		return 1;
+	}
+
+	cdev_fd = setup_cdev(argv[1]);
+
+	luo = open_liveupdate_orchestrator();
+	ksft_assert(luo > 0);
+
+	if (liveupdate_state_normal(luo))
+		iommufd = open_iommufd();
+	else if (liveupdate_state_updated(luo))
+		iommufd = liveupdate_restore_iommufd(luo, token);
+	else
+		ksft_exit_fail_msg("Test can only run when LUO state is normal or updated");
+
+	ret = setup_iommufd(iommufd, cdev_fd);
+	ksft_assert(!ret);
+
+	if (liveupdate_state_normal(luo)) {
+		ret = liveupdate_preserve_iommufd(luo, iommufd, token);
+		ksft_assert(!ret);
+
+		ret = liveupdate_set_event(luo, LIVEUPDATE_PREPARE);
+		ksft_assert(!ret);
+
+		while (1)
+			sleep(5);
+	} else {
+		ret = liveupdate_set_event(luo, LIVEUPDATE_FINISH);
+		ksft_assert(!ret);
+	}
+
+	return 0;
+}
+
-- 
2.51.0.536.g15c5d4f767-goog

