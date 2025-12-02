Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A48327BE0
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716637; cv=none; b=JXRVmCUqLlyamFl/pAp4gwynwcDz14li0sfNIHAvhuxCM2murdLIVIWc1+qRx/zs7wnEaH4wpyrDxC6JVGebeSlVZfTxUFvFx4KhAWb0hfC385t7S7z4auku49FmKRvg8s1FCzkgoDsy4D6mBrF1y5edyqejB5YlsI2rzLNqc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716637; c=relaxed/simple;
	bh=djwOLIAVAGf0PZc2FQGQUH224LJ51Z/p4MNRg4S6K9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j03ze338r5xMZE2u8+z2nJ/GuDKMw2q2o6k7tXOUwgDr64eJ2YQNcYEk/1PMwlfsH1i0VUg3fckcInSE2Z8Vv3wE9/e5eu40hnfWW9Pbx4kmeAAQ6L7aeEIaL6SIFKDFnhHicYZdXuMRROuTo3Gp7bQJi6OVAPlnh64dRnCZPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyi3Yw5q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyi3Yw5q"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-299d221b749so109296065ad.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716633; x=1765321433; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtNkkJ4fOKVym9Kw56PvFDcP72K78cYEcRFkpwvZmS0=;
        b=iyi3Yw5qk6kUZ08a4VvO6X0hHGyinBkS1mBhLiZBRE6KA7vgAE/eDaunV17V/pukUX
         gRjtEbt9lvmq3CFMGm1i3tlRiqavtOKUvITo2UBIbpMzYG+vSucFjkkV5c8S/aoMeyaT
         UfQ9Xnm1VM7dqoclx4b454TJ7VaT3C6aFZ68jIIwKpz7mu8/BePHFqmWFh2lwpm9yv1c
         vP/IgKcyvx5p/TBr0vdfVpFz+dzMEuk+Eue9ZtEAw9n7ya0clARzr45lEu1XcE6h36eq
         yPOIm0WxSobjZCjsTcAtH/qVJFizIqQuu7PeIjiHXI7cruzgKlUzrMsVv1BcVnVxfY5H
         tFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716633; x=1765321433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtNkkJ4fOKVym9Kw56PvFDcP72K78cYEcRFkpwvZmS0=;
        b=uYKM/oNQCe2JWqp/b52GiGgy/bK66FK/G/BZWRGKad77pi2mies51jwKx5WhB1793H
         KClLzd1DiNo50f4nUA+zHfE6JZH3MTG4il7S66z54Cp+CUdUtrGvkqBpn9/XndniQ1Fj
         HlEv0EIZDWdy/ZZZmhEa4GU/j9IHxOXMrB84rTOldLqmQ9yb05anUC0IM3GcOPgLCEV1
         wIk16kM8HTJNGBVjC0/j1yY2UzlPD2vz1MM+TXGLDA77JwO4KYCXkxf4lEauJpnnumhi
         ezf6EP1tZ/gNpz9z05gS5sQJGiKWmDbVZKYTJX16YXC3y5KX6zvijdXuY2+W/H3RlZoX
         MnKg==
X-Forwarded-Encrypted: i=1; AJvYcCXe7uRxDUocTiXd7mJZ9gOmWQl47IrTt5qy92XpTp0B04zzhcf96y/KPQETuKmjrRbHm/V9Cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzicypjIvewila32837OLWU8oIy8YsPpnFcptxSh3bGHFHpACi3
	aauAidndyVBHj80czCAglKm7UU+JjnEpRoz4BMRs7njgWUD13xj3ONpl4TDvR8ZovA2/dcnVzi8
	ivNsJFvpx9QyZ8w==
X-Google-Smtp-Source: AGHT+IGZksqYr4tGXrD7qpWyT/Jbxtl3pYwtRiBlWDTRBv/H9eGWtV2yNN9inZkDYbNjJcesGP0liIzo2GL+jg==
X-Received: from pldr11.prod.google.com ([2002:a17:903:410b:b0:294:fdb9:5c0a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:240c:b0:295:5116:6a7d with SMTP id d9443c01a7336-29d68324b3bmr2492715ad.4.1764716633364;
 Tue, 02 Dec 2025 15:03:53 -0800 (PST)
Date: Tue,  2 Dec 2025 23:03:02 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-33-skhawaja@google.com>
Subject: [RFC PATCH v2 32/32] iommufd/selftest: Add test to verify iommufd preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Test iommufd preservation by setting up an iommufd and vfio cdev and
preserve it across live update. Test takes VFIO cdev path of a device
bound to vfio-pci driver and binds it to an iommufd being preserved. It
also preserves the vfio cdev so the iommufd state associated with it is
also preserved.

The restore path is tested by restoring the preserved vfio cdev, iommufd
and HWPT and hotswapping it with the a new HWPT. Test also tries to
finish the session before restoring iommufd, after restoring iommufd and
after restoring HWPT to verify that it fails as the hotswap has not
happened.

Note that the helper functions setup_cdev, open_iommufd, and
setup_iommufd will be replaced with VFIO selftest library. Similarly the
helper function defined to open and interface with Live Update
Orchestrator device will be replaced with a common helper library.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/iommu/Makefile        |   1 +
 .../selftests/iommu/iommufd_liveupdate.c      | 291 ++++++++++++++++++
 2 files changed, 292 insertions(+)
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
index 000000000000..5f767adb10fa
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate.c
@@ -0,0 +1,291 @@
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
+int setup_iommufd(int iommufd, int cdev_fd, int hwpt_token)
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
+	struct iommu_hwpt_lu_set_preserved set_preserved = {
+		.size = sizeof(set_preserved),
+		.hwpt_token = hwpt_token,
+		.preserved = 1,
+	};
+
+	bind.iommufd = iommufd;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+	ksft_assert(!ret);
+
+	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
+	ksft_assert(!ret);
+
+	hwpt_alloc.pt_id = bind.out_devid;
+	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
+	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
+	ksft_assert(ret);
+
+	attach_data.pt_id = hwpt_alloc.pt_id;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+	ksft_assert(!ret);
+
+	set_preserved.hwpt_id = attach_data.pt_id;
+	ret = ioctl(iommufd, IOMMU_HWPT_LU_SET_PRESERVED, &set_preserved);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+int luo_session_finish(int session_fd)
+{
+	struct liveupdate_session_finish arg = { .size = sizeof(arg) };
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, &arg) < 0)
+		return -errno;
+
+	return 0;
+}
+
+int restore_iommufd(int session, int iommufd, int cdev_fd, int hwpt_token)
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
+	struct iommu_hwpt_alloc hwpt_alloc = {
+		.size = sizeof(hwpt_alloc),
+		.flags = 0,
+	};
+	struct iommu_hwpt_lu_restore restore = {
+		.size = sizeof(restore),
+		.hwpt_token = hwpt_token,
+		.hwpt_alloc_flags = 0,
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
+	ret = ioctl(iommufd, IOMMU_HWPT_LU_RESTORE, &restore);
+	ksft_assert(!ret);
+
+	/* Should fail */
+	ret = luo_session_finish(session);
+	ksft_assert(ret);
+
+	hwpt_alloc.pt_id = bind.out_devid;
+	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
+	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
+	ksft_assert(ret);
+
+	attach_data.pt_id = hwpt_alloc.pt_id;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+	ksft_assert(!ret);
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
+int luo_create_session(int luo_fd, const char *name)
+{
+	struct liveupdate_ioctl_create_session arg = { .size = sizeof(arg) };
+	int ret;
+
+	snprintf((char *)arg.name, LIVEUPDATE_SESSION_NAME_LENGTH, "%.*s",
+		 LIVEUPDATE_SESSION_NAME_LENGTH - 1, name);
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_CREATE_SESSION, &arg);
+	ksft_assert(!ret);
+	ksft_assert(arg.fd > 0);
+
+	return arg.fd;
+}
+
+int luo_retrieve_session(int luo_fd, const char *name)
+{
+	struct liveupdate_ioctl_retrieve_session arg = { .size = sizeof(arg) };
+	int ret;
+
+	snprintf((char *)arg.name, LIVEUPDATE_SESSION_NAME_LENGTH, "%.*s",
+		 LIVEUPDATE_SESSION_NAME_LENGTH - 1, name);
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_RETRIEVE_SESSION, &arg);
+	ksft_assert(!ret || errno == ENOENT);
+
+	if (ret && errno == ENOENT)
+		return -errno;
+
+	return arg.fd;
+}
+
+int liveupdate_preserve_fd(int session_fd, int fd, int token)
+{
+	struct liveupdate_session_preserve_fd preserve;
+	int ret;
+
+	preserve.fd = fd;
+	preserve.token = token;
+	preserve.size = sizeof(preserve);
+
+	ret = ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &preserve);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+int liveupdate_restore_fd(int session_fd, int token)
+{
+	struct liveupdate_session_retrieve_fd arg = { .size = sizeof(arg) };
+	int ret;
+
+	arg.token = token;
+
+	ret = ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg);
+	ksft_assert(!ret);
+	ksft_assert(arg.fd > 0);
+
+	return arg.fd;
+}
+
+int main(int argc, char *argv[])
+{
+	int iommufd, cdev_fd, luo, session, ret;
+	const int token = 0x123456;
+	const int cdev_token = 0x654321;
+	const int hwpt_token = 0x789012;
+	bool updated = false;
+
+	if (argc < 2) {
+		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
+		return 1;
+	}
+
+	luo = open_liveupdate_orchestrator();
+	ksft_assert(luo > 0);
+
+	session = luo_retrieve_session(luo, "iommufd-test");
+	if (session == -ENOENT) {
+		session = luo_create_session(luo, "iommufd-test");
+
+		iommufd = open_iommufd();
+		cdev_fd = setup_cdev(argv[1]);
+	} else {
+		updated = true;
+
+		/* Should fail */
+		ret = luo_session_finish(session);
+		ksft_assert(ret);
+
+		iommufd = liveupdate_restore_fd(session, token);
+		cdev_fd = liveupdate_restore_fd(session, cdev_token);
+	}
+
+	if (!updated) {
+		ret = setup_iommufd(iommufd, cdev_fd, hwpt_token);
+		ksft_assert(!ret);
+	} else {
+		/* Should fail */
+		ret = luo_session_finish(session);
+		ksft_assert(ret);
+
+		ret = restore_iommufd(session, iommufd, cdev_fd, hwpt_token);
+		ksft_assert(!ret);
+	}
+
+	if (!updated) {
+		ret = liveupdate_preserve_fd(session, iommufd, token);
+		ksft_assert(!ret);
+
+		ret = liveupdate_preserve_fd(session, cdev_fd, cdev_token);
+		ksft_assert(!ret);
+
+		while (1)
+			sleep(5);
+	} else {
+		ret = luo_session_finish(session);
+		ksft_assert(!ret);
+	}
+
+	return 0;
+}
-- 
2.52.0.158.g65b55ccf14-goog

