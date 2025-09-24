Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8E314A63
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733113; cv=none; b=INLZfyPvbN0zoVVDjs6O15iw8/voF6O5WWIXA4cVFeP0Lv+RZSfkn0QnkyId4NLb7LAhOpYUqcEI26xM3MHD8j61gSGRJO+xgCt6VDZQmwJ9+axXbUrJFBYm+c/xbHURSSXH6HyJx8K95fOadjTSW0mgXOH3JDz9RX6np2laBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733113; c=relaxed/simple;
	bh=2HMOyoB1zdsMaOjuaw59c8qho+a5Jwog7IztYjSvDgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdTDWezdtn8PRcNAOWH846zz+szLaKUh2gwFxWK1G16XDmwkz6XrXAREhfBa+vzXCY1piSRJttjl4Hu2pi2MemlUJ8tYBBSwz00LVAkfcQ+1iPUbqn/Ygd3vKBc492BEwcRLoYJvTxu5ZNvdLFQTlmQ9ODbZE4QHB8xSKnM+6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awZBELPc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awZBELPc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so11888540a12.3
        for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758733110; x=1759337910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhxhXtqktHcioL92cLF4a3/2LgXkVdX5qcYz1AChCIQ=;
        b=awZBELPcoEOyQU9uW8GwqnrwuE3hhELqb5ryhtw/S2kOtAKoT3JW5nRTjVbC3EAvEG
         gnpGghKDytKFa4xkAgvtYO5F6Qu8p8tF/jtCHZKwPewkXhrlm+DQHpZXDHrLe4mP+H3K
         5ZMNFd818V5URDGRwiUjZSFN/SfTxwIIW5nWMO4GErqagx5SU5lnujWzquYB3BBiYZ+8
         HOPBovUrjOK1vpGP8XPfOQsNSwyQ9dFeG+mlrB9XyzGlq7WKLIAUZvje+WlL3dZngtFO
         +WXOTlhiMIVo4iQDdOwHqykWq69W1+xXsKJYXc5fbczHWHf9uewMQJ1HFwUvAkACf/cy
         UEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733110; x=1759337910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhxhXtqktHcioL92cLF4a3/2LgXkVdX5qcYz1AChCIQ=;
        b=vnSl9RDC7THIwx9QKAc7/VE3DZzp8t3WPSUeeBQYHNtKq/rOYS0zZzp7D4wc3mslfM
         S+nXAcSO8BFVHr2VX3M/mGf71tk/ip/NJ80hOWngMC1WxQottoLpFyZDwHCY/PKAvlB+
         X5ABaFTGdVheuRT97v8UI1d4XXjCyQThGJbNZl3VcEAR1DK5O4ylbDcBj3LNe/8YDwnS
         1RG35rCtgIBZG0WQwtMBMdhug1BLE2O10eBczsY1V7lpWIlrVowhlzOZl18Wmw8Ld3l6
         6Sf5fp2jROuyxKM9YS2KceKl8ISoTpRH+d+eqrQvqyrgnqmCsbeX5O+PZ53EsLBZoe6t
         VEOw==
X-Forwarded-Encrypted: i=1; AJvYcCVo/dFxqHSPskh+yf/UsT5ZPuVlG2+Oh8GiqQmsGRNwjl1z3ZFdS+a1IDBirYyrLV9Vw1YDcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YycekHWFAM9IV6ae5oIbfBN0ywfdmj0j6GQiFjEgI76VMCF3N7D
	HRG/EEloJe3pp2Pnk0HnRaJPFpzb19hEq4zj0XJ54qPv3imOarOwVbTK
X-Gm-Gg: ASbGnctmnVtS1ywpiTVT0zq1PLjEJfcENLfgKs7FPU/EAlUYFXIwEmfnwO12W3gA14N
	kPcy5lOvHnKcthyp+7E/GH+lKdrI0LiytZeZzuoiUQXQ+Bk0H5Ag8we8N1pyQkf8DbH3TSrsd4n
	JvXsIxE2COEziuagwfR9P1GIp1BkxXJGUmFfx2wiZW1N/pU8927KFCXmVrzuwgDJ0sEFhCD6a4R
	F+Y9Psqfhn1Dz1bmBdhqrLA/9C63GhOA2JEi9dleKog+4L4W3Y3ITOLtKWk/T1noQpCuBGP/brp
	eMmpwuP3GoPmbli4WeA9j3gy6ybZJRgkZKat2srXcANVPkr3LYsR0hI4D/3pWS6BuoFsTJWp26E
	Zq1M8Pf5F+iHIepoFXIQ5fKYQ2S6obs/4FraJh59HWIGNPsVh0t+VWc2ZXzYMfI8cmUfuon/ntp
	bVRzd9DA==
X-Google-Smtp-Source: AGHT+IHc0IHg50HF9lykmrkaQ/1sP3tnQTdw05PnGmQL20/LTTIZFvq6gMv2fB5YlFPC46sPAXgG8A==
X-Received: by 2002:a05:6402:4412:b0:631:6713:3ac2 with SMTP id 4fb4d7f45d1cf-6349fabb58bmr111654a12.38.1758733109399;
        Wed, 24 Sep 2025 09:58:29 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5cfa60dsm13172236a12.4.2025.09.24.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:58:29 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fix to avoid the usage of the `res` variable uninitialized in the following macro expansions.
Date: Wed, 24 Sep 2025 18:57:59 +0200
Message-ID: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

