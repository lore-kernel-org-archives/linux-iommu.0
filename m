Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723953;
	b=Diy7jWqYmy3P/5WgMD05/ptUEubOeBISZ3RUnxzBzCgC1peIabjF+L3wpXRm7eAlKqmB
	 a0MSuCIoO+/T4kCbgF8iTf3i1UX0QBvJFNanANWh9OOn252QB4dYF0f5yynPpG9XLaz8d
	 hM+BrSDFpt2SgU8rF0t0Cl++R6kuHUP/ywR+sw3zQW9XqvV9GOFZUq2zn0rrn4wtfXtOv
	 dds4PlXnUx2Zns+njGiwapRmwIcToZQYnsTHUhI28i9CE1ByZlhw5nMOxkISkAfhWFyFe
	 NKmZhQYQ5OJepH5g64aqr3h9srPw5blVgW2hFZ+LFDMBhGVD1YZtfM288CM7aScO/7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V7CHaxJjio26zC0cpwOTJ7GJgFVKnUUB8e0VQq1U5gQ=;
	b=my0dlfNmZQvVcdZKl+83Fsc+SDtTMr0V4KbdkrvBk+qVV2nrnnznhifyaulGZI9Nbq2K
	 AVy/+Ezh1aNy+s9e9x0no1CxESiHkYt6EsuASRGeAQD2BSOB6NLwXj8OXcgROn37Jf76T
	 l9NXTS0PzcO+Zeu41BL39x835lfi73MPdVH17RU/6AbEeowmNYMGPfD9NU4o63MNh1H1A
	 f4O7EZAkNEZU2ykOXbKhgJ0+R9Sr+jLTMScBoTi3f9LBIdcO8fSJn0NH6P2qcTJGHtm57
	 eXHfHM/LkTWDzJR7lIo449uRqvE67En51y0Coo0EfECk9Nv3vEueldQBVJCtQJuuLIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdBvAHNI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29596606D82E;
	Tue,  3 Nov 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdBvAHNI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1251E1F000C1;
	Tue,  3 Nov 2026 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723952;
	bh=V7CHaxJjio26zC0cpwOTJ7GJgFVKnUUB8e0VQq1U5gQ=;
	h=From:To:Cc:Subject:Date;
	b=TdBvAHNIBiCJJBY5I1S+uoEa5ecgBwXwsRVhoUSH1ux5MYJu9206o9rs5ElSUGLok
	 OXNwcM7ttaX5bSOZLAZ2llT/uQ3WAh6GNnqE52m3yVx9FWQpgu82M4qVxHJW5eUCT0
	 qlplwpqd2UA+MJRQRpXsN8CmcCiGcchQoDMhNhKItMDQWJippImuH/bnHvE3Bv1VQX
	 XsVp9O70ggB4iyeh4+p8D5x6cA+IK11qbfs8b0skK/pmJ/j8UGb+qXN3Rl/KSOBubw
	 1mrPPLdkH0xSYsUO5VDqF19GrHIoQ2T0jeKydoMiDedrBTZP0WyiGEW5KGtRfGHny7
	 dVk+5HlNbDO3A==
From: Sasha Levin <sashal@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd/selftest: fix the unmap-all length on 32-bit architectures
Date: Tue,  3 Nov 2026 11:39:10 -0500
Message-ID: <20261103163910.640756-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_test_ioctl_ioas_unmap() takes the length as a size_t, so on 32-bit
architectures test_ioctl_ioas_unmap(0, UINT64_MAX), which asks to unmap
everything, passes SIZE_MAX instead and doesn't test the unmap-all case:

  iommufd.c:861:9: warning: conversion from 'long long unsigned int' to 'size_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]

Take the length as uint64_t, like the length field of struct
iommu_ioas_unmap. While at it, cast the pointers that go into 64-bit
UAPI fields through uintptr_t, as casting them straight to uint64_t
warns on 32-bit.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
-m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without them now, and the x86_64 builds don't change.

 tools/testing/selftests/iommu/iommufd.c       |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index ca2b35e9d443a..f96c262c6a245 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2454,7 +2454,7 @@ TEST_F(iommufd, map_cmd)
 	struct vfio_iommu_type1_dma_map map_cmd = {
 		.iova = MOCK_APERTURE_START,
 		.size = PAGE_SIZE,
-		.vaddr = (__u64)buffer,
+		.vaddr = (__u64)(uintptr_t)buffer,
 	};
 
 	map_cmd.argsz = 1;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index b4928cbd4d9c8..38339dc9f943b 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -198,7 +198,7 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id, __u32 ft_i
 		.pt_id = pt_id,
 		.data_type = data_type,
 		.data_len = data_len,
-		.data_uptr = (uint64_t)data,
+		.data_uptr = (uint64_t)(uintptr_t)data,
 		.fault_id = ft_id,
 	};
 	int ret;
@@ -310,7 +310,7 @@ static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id, void *reqs,
 		.size = sizeof(cmd),
 		.hwpt_id = hwpt_id,
 		.data_type = data_type,
-		.data_uptr = (uint64_t)reqs,
+		.data_uptr = (uint64_t)(uintptr_t)reqs,
 		.entry_len = lreq,
 		.entry_num = *nreqs,
 	};
@@ -341,7 +341,7 @@ static int _test_cmd_viommu_invalidate(int fd, __u32 viommu_id, void *reqs,
 		.size = sizeof(cmd),
 		.hwpt_id = viommu_id,
 		.data_type = data_type,
-		.data_uptr = (uint64_t)reqs,
+		.data_uptr = (uint64_t)(uintptr_t)reqs,
 		.entry_len = lreq,
 		.entry_num = *nreqs,
 	};
@@ -695,7 +695,7 @@ static int _test_ioctl_ioas_map(int fd, unsigned int ioas_id, void *buffer,
 	})
 
 static int _test_ioctl_ioas_unmap(int fd, unsigned int ioas_id, uint64_t iova,
-				  size_t length, uint64_t *out_len)
+				  uint64_t length, uint64_t *out_len)
 {
 	struct iommu_ioas_unmap cmd = {
 		.size = sizeof(cmd),
@@ -832,7 +832,7 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
 		.dev_id = device_id,
 		.data_len = data_len,
 		.in_data_type = data_type,
-		.data_uptr = (uint64_t)data,
+		.data_uptr = (uint64_t)(uintptr_t)data,
 		.out_capabilities = 0,
 	};
 	int ret;
@@ -978,7 +978,7 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 		.type = type,
 		.dev_id = device_id,
 		.hwpt_id = hwpt_id,
-		.data_uptr = (uint64_t)data,
+		.data_uptr = (uint64_t)(uintptr_t)data,
 		.data_len = data_len,
 	};
 	int ret;
-- 
2.53.0

