Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03B314B72
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734200; cv=none; b=PvzAs6amOk4nHS1gmuDAZZECQYlzj7tWgWYcBH/yd1vZ7Jgw4GxnkJdefiSLtJ9EmPApm22jgc5wRaOPsWdLaxhIes0TprbpcJwwZCMuLdj2yEKkcRIOP907UGD8vOiiV+QsjkZnlDqaCv+nYuQUfruVb/Bmn85qqpiT6PvWggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734200; c=relaxed/simple;
	bh=hsA5j6mN1Ho29wv3TqcaUo95fVf6ZgIDjmYFb88klhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZIXBvvAo6Ia6XrBqqGtsAGCQLAL18KQFRC/q8smKV+NgmsMgvnGr9q7pliXbeFNMQvCMnhQ2UkKPxgF//vJ9xb33J1LUf0WDhhg++VdPZL3hNgai8jhY+aT9OUqCEgCjQHqFKi/vxh7aQeP1vZk+XQUsUJHIpaHf+u5GxZE4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZVnd7vA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZVnd7vA"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63491fc16c3so3393a12.2
        for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758734196; x=1759338996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNxQWNsaNzm07NK0oI4QfKW+i7h07TGqHOD9HRkHR7U=;
        b=lZVnd7vALL7eUWk1WkcSs/fvD51CYudASfD9pNjq5sY4s/nZVmS5tqw8IJ4rtU4NtV
         4kYGTq3m82uO1AVOmmCjRMV/J4ev3pKT9wgJ9CRFY0xJRmsAZfTy+bcK1VkPiY4AGnMw
         CWsd2IUIq9o1eBsICQhbNea8RVu9Nho4Vhgfz1j2qSna/qmEKr/6VihwCuTU/fNDyPxx
         SaeqpfNpnDTrSHgIpX9AvmcaP/VZRxYIdfwN9j/LgQ5lOo1GKvvR8PfT2k9RBuvPdi1f
         NvEk7fBaTWhwMUtGy6oc2spJAhas2XDAT9pdD/gqBxBLJBnwKZ/G5t+onok7p7j4FZgr
         0NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758734196; x=1759338996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNxQWNsaNzm07NK0oI4QfKW+i7h07TGqHOD9HRkHR7U=;
        b=jtTvjokZAlIu4KSghO5or5PdHwdKjstvCpRcoHQPoXSlEuK+2e/8LqM2LifWErYo9v
         Po86mFrSRhgJtexViFMphSXdgWkxf4wcdIjmx2+SQRak+FH5LlfBirn3oNp9fYpvXKqo
         feWqIoJf3hL04mBfwXPhFByJD48D3LAXtOMsjflE1/hwfv7APWzYq+gd9OAGoorXILBt
         pkozXs8g6So+eJZaFKXMbzYqSfRAm/u6h/KwhWuOb921904utDGdb8S5138ZLKjcWiaH
         KeWmvVBSdFAEu2IBKeXWmKei/5xfB0/5hUTrQsIPJ/mVqV/HK5ry6Wwd2Hi3Lny8u7Cf
         zZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXdTfC9FAz6N4z7sEfsgTYrPBymLaTdJWLZF48dVVGTf1i0bHbcUhMRmKRKO8yXS1lL2YpRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf9QbXp/c7cDeH9mI+tUM5alH/s0J/0CIZHVv+FSLXjiRCte6F
	AEtmVVRoL8H4fjKAIGyOX+8188ilBBVHUrV9oha9IezJgwR2aaR0+dek
X-Gm-Gg: ASbGncvYczV8d1QI+DxvjiAmi/pDYtu7Ou/t/nl2z7lKNdxi1GfTSzXG4tjSh69UI3k
	rbCe8Js2PfYnuuyTaV5XNryWCN0BoCMcHNX08ZUtfISI7FIGf8eY4MOTFXyrUzAF9HhOGH9yKfw
	kQ5wX1JwPTYKDoRHd2E/UXj/FeqqtFVO+m0vBp+6WUNnfCrSWWFDBVTTAae7e6pjYtfGPfve2E3
	TZrmRQjOsAjrZgBkyeAjRDR057p81d2JpZVJ4gC1STmAd4g7RZFOhTxd72/c13RTEZ15xySdJa3
	hZBkcAjhRK9XkK0L/s1mRPClxygYzY1G/tTtlS4ndLMs9u+wK2xYZeT4JFs1GbG/UFkmY1i5UzP
	/iy8fA6aR6OvGS6dU0B7Vpv/NGKi6WS+h4CEtP1w1SaInEftkj2lvkQ620ya/YPv4FksA3otHa9
	4EQN+3Ag==
X-Google-Smtp-Source: AGHT+IGTRCVL+Vy3tfNF1MUEnXBCXWeb5Jrz0wQXqG7fNQTDEE2vWKNUIlbHrYap21jasTSQYR4WgQ==
X-Received: by 2002:a05:6402:160c:b0:62f:41d3:ece7 with SMTP id 4fb4d7f45d1cf-6349fa1b9a4mr208376a12.14.1758734196429;
        Wed, 24 Sep 2025 10:16:36 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d4357esm13318691a12.23.2025.09.24.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:16:36 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/iommu: prevent use of uninitialized variable
Date: Wed, 24 Sep 2025 19:16:28 +0200
Message-ID: <20250924171629.50266-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to avoid the usage of the `res` variable uninitialized in the
following macro expansions.

It solves the following warning:
In function ‘iommufd_viommu_vdevice_alloc’,
  inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
iommufd.c:2889:1:
../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
[-Wmaybe-uninitialized]
  760 |   if (!(__exp _t __seen)) { \
      |      ^
../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
  513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
      |   ^~~~~~~~
iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
 1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
nvevents))
      |   ^~~~~~~~~
iommufd.c:2924:17: note: in expansion of macro
‘test_cmd_trigger_vevents’
 2924 |   test_cmd_trigger_vevents(dev_id, 3);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~

The issue can be reproduced, building the tests, with the command:
make -C tools/testing/selftests TARGETS=iommu

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3c3e08b8c90e..772ca1db6e59 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -1042,15 +1042,13 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
 			.dev_id = dev_id,
 		},
 	};
-	int ret;
 
 	while (nvevents--) {
-		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
-			    &trigger_vevent_cmd);
-		if (ret < 0)
+		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+			    &trigger_vevent_cmd))
 			return -1;
 	}
-	return ret;
+	return 0;
 }
 
 #define test_cmd_trigger_vevents(dev_id, nvevents) \
-- 
2.43.0

