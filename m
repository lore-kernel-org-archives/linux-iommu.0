Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947E2EBB9E
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765401404; cv=none; b=IxXrZGOok/LpIfvJcft9T0lerSN+E/zjcPdLd0I8mQBqjdFEL0yK+SONpnGpIshGDiMEqyED6d/Cj6m0+5ipUG9po0JMJkryZDhm5xhEkAmau15v+WWKzkH4HKWET4zHfOaUJZcwQYwfIQ40oiuU23MJZFKWNQLqJmDoJErj+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765401404; c=relaxed/simple;
	bh=mr8MKA14m3hru5UbYvO5bVCKX70QVtF6+eaN8vBLjUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNqts7umohaMP2igwtFR+8MhwRhwTDxiFSLNJPg0rtWgZzEZxrJudlj8kE/dDZrRfX/Ejj3epsYQX3akE3s+wDfStPuVyShLmFmqxa+YSyJDorFlzlTEQiIEynljdx7MkfehNHQ++769xICmMOS0QjgnfYRyFGblG8axtTt+HXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvU/i8Eg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvU/i8Eg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7f121c00dedso333822b3a.0
        for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765401402; x=1766006202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWAaI77IK3V9A6IwXVo0vX3o908zHo/+nth9jNlQRds=;
        b=SvU/i8EgwjbXdF/Qbgu65aqMZigzzq2cyMlUNAvaovzDmqRgx37a1RPVKZfPZtFrAU
         BhIzKK48Oc3yqDEFJjIo4PwoLD8+SVsYCV+bPcKwOJjHPBHPDcNNNlhW4G5tj9u1ZTG8
         lIHcG+O3KjlDgZwZTDs4EhygndcR1kKpkmqyIJVzp1Z3NSbhiYkM+B87NdJeRz+1b8jN
         NVVXFkuiLd5gpbRH/iUBMXrGK/sVleYsyfOabcQ/ZPswm6ZS0jB9v6SViJRXJ2Bb+Ndi
         DBk4DsJAwB/iTkyeOGSE5i9B79goSECV8sgA9lISofJMRFg0G+Y3bk2GFTSgET5ie6b1
         fv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765401402; x=1766006202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWAaI77IK3V9A6IwXVo0vX3o908zHo/+nth9jNlQRds=;
        b=XzE9HQHbzvdetKQRcQ3sE9ATEz8mCSAqU/Xz+OUrOgNL7fwLZfEFhxx2zQ1uNwLlGC
         SMGwMh1hihbz9yoS8F3eC9Rqi9Rd7D2hw+CYFJQOt4ASylkd2e71vonYL+XES9mIDHBU
         4ggx7fWvA2ODYOER8u7EHJYMDXxy1Rh6AO9iz8PM4gi9izARnaW8s2pnSHdSWy053UWx
         CZ8m28gaeeTRu4Lyf0Zaw4zaJEGmburQhiyN1K5CgQmDIJu9c+uADTYrvjkakiK+SM2c
         9msQN1jN+0eASvMKLJf3uJ8ROnChNDn9T4C/b8EoRg0ZPyNhlD/IU9m2GNxQko4Aw8Ee
         Ilmw==
X-Gm-Message-State: AOJu0YwMnpXbs/IxhnBn0c+AQNkwBPKEwiBH436C8+ttRTcFDuxiAKw9
	E+lB416xVFPq7IMDOq1czKZp5b60ERsAQTupc+lKX7i9R7BRISBrBAbf
X-Gm-Gg: ASbGnctPLMwwVxSOK5y/23GfAt1amZTKR9OnjbynULCAk7cwlpOyX1dBCB/nZapRrEL
	A7itToyHRoCsDet/NznjUrNz0yZYnWDNfODk0cr5poN+YyW+J1lSlbluUiJ7sojAWhv5ScgUfpS
	T13YLw17hDedwA6VtQt6uE4ZXXQNwVcUl+0cxu87RgwJ2IHljfchcr44RFpKgy7CHoOGKTwtgfu
	tILfhv4Dkgx+khnj1LRAsfcZTNKeZ0HiK2gB5vs2P/217Yjs1haf8nPIi0uM/IiuoHe31NpB0KL
	v08za349d9Z2rVeoFGjiv01mVdIhc0WYbEBbrtrzJGPVy2nuQ5v4g4E1PR5PpzCc6gR/xx3BKUB
	XecLQuaCHULFyFhWVrjUwa1Or5iwr6mj50v+MNBcb3SkvfDmEZLrwqO2wCUpP98qUU1noQgkUNw
	lMzCCQxLegZR1coMPbzAH8rGgrW3hVfHwlXqEOqME=
X-Google-Smtp-Source: AGHT+IE2ULD1yYKY6ybGe7FNDn2kZdxGAEF3Iv6t0/+g1Icyf6iWWfIVjfCStoCP7aC+K+nu1WterQ==
X-Received: by 2002:a05:6a00:2789:b0:7b8:16af:3bbc with SMTP id d2e1a72fcca58-7f22d3023famr3337030b3a.31.1765401402189;
        Wed, 10 Dec 2025 13:16:42 -0800 (PST)
Received: from localhost.localdomain ([202.164.139.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa717fsm424373b3a.36.2025.12.10.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:16:41 -0800 (PST)
Received: (nullmailer pid 989870 invoked by uid 1000);
	Wed, 10 Dec 2025 21:13:57 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: jgg@ziepe.ca, kevin.tian@intel.com, shuah@kernel.org
Cc: iommu@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, yi.l.liu@intel.com, nicolinc@nvidia.com, alex.williamson@redhat.com, katharaasasikumar007@gmail.com, Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH] selftests: iommu: fix Warray-bounds in get_hw_info test
Date: Wed, 10 Dec 2025 21:13:42 +0000
Message-ID: <20251210211342.989850-1-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_hw_info uses a smaller user buffer on purpose to check how
the kernel updates only the fields that fit in the buffer. The test
created a custom smaller struct for this, but the helper function later
treats the buffer as struct iommu_test_hw_info. This makes the compiler
warn about a possible out-of-bounds access (-Warray-bounds).

This keeps the test behavior the same and removes the warning.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 tools/testing/selftests/iommu/iommufd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 10e051b6f592..f6aceb65313f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -755,9 +755,7 @@ TEST_F(iommufd_ioas, get_hw_info)
 		struct iommu_test_hw_info info;
 		uint64_t trailing_bytes;
 	} buffer_larger;
-	struct iommu_test_hw_info_buffer_smaller {
-		__u32 flags;
-	} buffer_smaller;
+	struct iommu_test_hw_info buffer_smaller;
 
 	if (self->device_id) {
 		uint8_t max_pasid = 0;
-- 
2.51.0

