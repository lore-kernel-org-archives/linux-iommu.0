Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70A2417D9
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639685; cv=none; b=aBi0QwASwAhVK8lF4eZHZnjaDtWAM/W4yOEYSpBOe4KYVcEy7jdv8T4zDH1qsYfChY6ThSwfnWpMuL4oPi9r/MxGAcUOqIbSpJveP697r7SGwMP/T2iltPJCe0XaCTG/f6Yapk1HzXxWrDnxntSDxiFW41U5KZlHrSPwnho74SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639685; c=relaxed/simple;
	bh=jtgAPbRC64BilnnjInFYbI1iljXOGGsr+cEZ9zamqj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oIa+gguTitNI9XBbLymgxy+9s0BeSiL2TXTXkK/14FPbq5cdXL0ZsV7mOE8Q8K+jt6ZfR8sRENOT4mhtvFwZWrfoVTkisTwo7leuy7r7JjUFjxwYetXKRtju9ogEUpehBDVRQxPH3SxJGT6xjSIy8NuOQoDcB75OvV07J5FWS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOeoeFJe; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOeoeFJe"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2e0513433bso300238766b.1
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758639682; x=1759244482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FVP7DhJGj/Y7czW4fXk9UCowjLbsO5dman73jLjS9Q=;
        b=jOeoeFJe/YFcUMLfQhrjd9j5MecwOvMdtHrdOh1/z+P9vVH7zwUQHU7PAaQEcjPfWE
         TsJlDfsqyVI4R56lzxGkoLrfc+kOwXLWkBA+pqm5i1ml4cOkLTYsCLZwJrzW+qOn+xGE
         fA8aAxV6wmI8VgwqiPUhKzAI6wS1y4Kw1wbosjRcjGhuzUH1+MIK2f3ZSW4v43aVcvIm
         VpS1Ouyt4j/FrOqZ59nqveLjPvrgEvjxMbm7Bt8RLJfupHOkMieBHtGhpFMeyZ0z4lW4
         Jn0WenQt3zH9Ulmdx5eVnGhQnwHZccwW2sYv8B6x6qmeRsunAfeMiK745XQI62lp1Ze6
         rLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639682; x=1759244482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FVP7DhJGj/Y7czW4fXk9UCowjLbsO5dman73jLjS9Q=;
        b=ZgJ4GNSab2ok9DSlGMM3zi6R+z8GsNb7mgoRJZpN+a8nxzl1cfygSr6EcUSxz9geiB
         KeIGkl2YFLC114ejEjceMm9iwoaKUhe13tZ6Ux3hWGjNLVDF0iHIH2zuCPgHdYoGRnQL
         6ju/7P75BZxFTZm/VJk6jt/Ga6+d/jXSRz/BAdEVueug3EGVHrM0ZhoHaRDaMDysPj/R
         wurHTrFfxCdq3KIpl+WyPmUC7jgML5jmtzUgMywkgugxppK90Et8P3efwh2AEWbr6Zpq
         9D605NEMypejsAmYgHjCplGLpmN1k9y3PI3BfJzvHj/e+t1Xa9j9zlnxte0unAnjgUqc
         YWfA==
X-Forwarded-Encrypted: i=1; AJvYcCXPtdcBOiXhE6F46T5l9a1FwLkxjZnBCAlNGCI8ceKU0ZZsGRiznzDVDgZz4fbAmX353xEoUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx08dUGY6/7/GjeyLr9MT3DKElmzBUq4HBfycpZvonMmcNjU3w1
	tJQuexVaf9h43UTZvRZQFHUa17HHQBWB0xD9coGVoiw/d9xHlb9Pa4HB
X-Gm-Gg: ASbGnctvt/Mo7Mifc15U2fTbOXytg2+fmHGjJAQ6GZKA7pvIIkoihf/f1872jkUYQzg
	BISk02Gli0rAzyBlGrmqcG/jEcir0nPrvqptLnDoTig9H9mwNMFzU0BEqCdxivsHbeFCqSZ4+tX
	7NVHR3DjeZB1/lvGtC4E62aMaMs6C3YlgUgsu6gv5O9nSAlRCtFWGAY/+TzhLq7xGqB2ZtIOcTt
	Uf8EpiW/O9tcn6oPHiX6d6/2JEYQMawBwB2yVUD/wxDu583xO84NspyEqtoDdF3cBKOMcnD1iVw
	NsfckwkFQv0U02TaYvawlmt4bmr8xEO0t3Sg2YvvRRIQrbd9g7nuNlmgKksjjWBt5Jw7bjPzdzK
	rzzz6LSK5qLgtZjEzJiAfCS5LKnw+Xl9lnh9p9Ev07UIayPchuS2G687AGz4rRBzjr4S5tSkaR9
	LecO5LCA==
X-Google-Smtp-Source: AGHT+IGTNS722I7OANZxiBMclWCKztu0Pg51a2Ss6XlfTfx7tF/PJx0HR5RKBr5uLe6oVYuyIBPe6w==
X-Received: by 2002:a17:907:724c:b0:b28:b057:3958 with SMTP id a640c23a62f3a-b302c6ea7b9mr295681066b.48.1758639681727;
        Tue, 23 Sep 2025 08:01:21 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb52a2sm899719066b.53.2025.09.23.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:01:20 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/iommu: prevent use of uninitialized variable
Date: Tue, 23 Sep 2025 17:01:06 +0200
Message-ID: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
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
 tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3c3e08b8c90e..4ae0fcc4f871 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -1042,7 +1042,7 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
 			.dev_id = dev_id,
 		},
 	};
-	int ret;
+	int ret = 0;
 
 	while (nvevents--) {
 		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
-- 
2.43.0

