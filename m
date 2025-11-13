Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06A2877F2
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064592; cv=none; b=ib4/kZnwGG0+h15wBZFbXxnE32AMj+pMFP0u0kPCr7ylfKF2ZZlYXC/yBS9dFch/CxleIEJEoSdGiGzjHkwLjeasBrkmRvc1sub9ANZYgKe8OnO+efqkfMkv1m1Ugs4JuQOf8zGyi93mDhIt1JeppXaO1umUL5dIT6o1GKyv5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064592; c=relaxed/simple;
	bh=QKdBCUlNwtR+F2VgsVfMTt/KnsuIIdUNrx84lK3lLbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbVJN53YAdpoW7k5YL+SZRtcG6CrTd/HXV21pG7YFiAovMF8dhy9InMhZrG+49HU/5vAlzormCoX5OD8WUo6E/D7dYm+QScIatYMrE8xvliomXVzS2PnRDXkyU0O9dc74fuaimMKN7konN8MhcRm+6ZgMQt9J3l9rGwlROjCfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY1kFMIF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY1kFMIF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29845b06dd2so13040075ad.2
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763064590; x=1763669390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpG9MFDfcOAig9lTA5rz8MkmRR9OX2bi+Q5guu7HZEs=;
        b=IY1kFMIFd1H0ozr6ON78X2KKsgxwX6VQX+XdMD5hQNVe5jpd1gLydUKR/WX30QCbQC
         4C9nj9eY+CMxuiPz4q5dc1cxZ8ePhJo8CLcEojVQIZSOs7Az4QTIPkYAqoIgo0dBbm4a
         /54Cc8X6nBfxJxCaS+FHnVBoJNc6sm8jgD52BMzWdu+BSZ9Pb/T/CS+O7C2UT/7AtJBJ
         eBRNmTlniKhRgWYJUPrshBe74M7Q1rQX8kqk+Lz33at1nI4ZKevV4LK2nxV2deYnZ/Of
         DNqgNIylR89+82b5Q+/ZCkWQt3NIJZ8YQRqFcf4U0mf5Vlsd6FCcas3sQT7R4FnM1T1l
         pdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064590; x=1763669390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpG9MFDfcOAig9lTA5rz8MkmRR9OX2bi+Q5guu7HZEs=;
        b=D/U5i/f4R0Uq0O+iqZNt84PJGL5dwU4AYrAzgXUqtt6gPg8VK35FCeN09HUsp0OslL
         wURTQxASxwV1SSnOWXohsBN0aSZJKWrr3Jp2eVvMOb5WIwbaWFAbKDmvLbCCO7MVnHdO
         CDRQ+BUf4jpY2aK3Ko8jkTwGB8vmNr2FUGr75/ZNxsmCDbMumE2JWcGw04LFhHkyLfm1
         PFZH2dctv5mAUzhYpE1YLrOebnqKaz3cnlYw8fykS959S8Eo25hLHxnQqCAqUbw9Tp1g
         4DZZnMI+JeUgU9zAnudQfeFqn5JKKqERGK3DSTDejujbsRLjXQwgPZjWqipWpPTG15dD
         /cSA==
X-Gm-Message-State: AOJu0YzSSiVlI+/w92g+aj+IOCEk0aGMsFmm35iEOmlYxz3oY5HxPFbF
	L1ctmpKGU4GeOXTQHeKHsGxTtkhcKu8VvlRzYNz8jZJ1x/rxC+3dlXOd
X-Gm-Gg: ASbGncvhzPvFu5TUSfmz6JEFXfN6q5xC+3Gsz0u+9lEKjataf0kLSHUpcVIlNU+VEJE
	xCBy+xhyC0zoLVknD0ot0S7Tnxt3D4PXw7HuqcO3DLM3M5EttTHtLKREnsiFYezvSzdn7XEG5Bp
	sTMl66434obvsX/EJKE34RxH7O87BoKSLGs6NcrYbupwIhDvaRvd66Q63CJnutQw87YyiHPT2AC
	XhHf7qw+rJ7k/337WRFgrhmAIIXCI5J25aLV/lsBTLokpGM9Yhj94Ccxpxi1bDkLvxfqFv9LxEU
	1BwPmY5JQjgotKUp/j/2hMnAbMQoi8FdKVwLbUpcUwK07LAANUj0znniLsrVArL9QoTUbXCg3DW
	yqZEUI3bQoLRyBd0B/HCIBUUh1AqJ9ex2Zus1U6BOXcNmVtzPK5T+2oQv+Fy1c8InFCwqFfJaS+
	5CR8vN7q0VJtX2GFwfXsvXf+zN5ekatYYCc8Xw3DBGl/Ibyh2/nh3843csI2WzsHFv/v8=
X-Google-Smtp-Source: AGHT+IFVs3N/0Nluydf2W8ohAwTgqQqd1hktqndT0y1P5e+0Z+Tsef7VZeDU5gPIi03W+2qZKgyt9Q==
X-Received: by 2002:a17:903:234a:b0:295:5dbe:f629 with SMTP id d9443c01a7336-2986a6abf18mr2384305ad.8.1763064589974;
        Thu, 13 Nov 2025 12:09:49 -0800 (PST)
Received: from prakrititz-UB.. ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf0f8sm33985925ad.89.2025.11.13.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:09:49 -0800 (PST)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] selftests/iommu: Fix array-bounds warning in get_hw_info
Date: Fri, 14 Nov 2025 01:38:55 +0530
Message-ID: <20251113200854.429515-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC warns about potential out-of-bounds access when the test provides
a buffer smaller than struct iommu_test_hw_info:

iommufd_utils.h:817:37: warning: array subscript 'struct
iommu_test_hw_info[0]' is partly outside array bounds of 'struct
iommu_test_hw_info_buffer_smaller[1]'
[-Warray-bounds=]
  817 |                         assert(!info->flags);
      |                                 ~~~~^~~~~~~

The warning occurs because 'info' is cast to a pointer to the full
8-byte struct at the top of the function, but the buffer_smaller test
case passes only a 4-byte buffer. While the code correctly checks
data_len before accessing each field, GCC's flow analysis with inlining
doesn't recognize that the size check protects the access.

Fix this by accessing fields through appropriately-typed pointers that
match the actual field sizes (__u32), declared only after the bounds
check. This makes the relationship between the size check and memory
access explicit to the compiler.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 9f472c20c190..37c1b994008c 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -770,7 +770,6 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
 				 void *data, size_t data_len,
 				 uint32_t *capabilities, uint8_t *max_pasid)
 {
-	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
 	struct iommu_hw_info cmd = {
 		.size = sizeof(cmd),
 		.dev_id = device_id,
@@ -810,11 +809,19 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
 		}
 	}
 
-	if (info) {
-		if (data_len >= offsetofend(struct iommu_test_hw_info, test_reg))
-			assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
-		if (data_len >= offsetofend(struct iommu_test_hw_info, flags))
-			assert(!info->flags);
+	if (data) {
+		if (data_len >= offsetofend(struct iommu_test_hw_info,
+					    test_reg)) {
+			__u32 *test_reg = (__u32 *)data + 1;
+
+			assert(*test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
+		}
+		if (data_len >= offsetofend(struct iommu_test_hw_info,
+					    flags)) {
+			__u32 *flags = data;
+
+			assert(!*flags);
+		}
 	}
 
 	if (max_pasid)
-- 
2.48.1

