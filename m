Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B2448BAF
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604708; cv=none; b=SuLMwweJeSpVHWFNEl6KwTFZQ4XxFJA7u4Hd6gX4ABpFEPgWlvP8B41qKlUOgVRiXk/FNKOdjmor3HaeRu90704ra9s3lFMkGFge+41x+8Fxg6Dh+HsCcOfO4Ge/paEdQ855wfw7RGMcWIUgtKdY6fomg4bnGtnOANLrSzLv8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604708; c=relaxed/simple;
	bh=6k1nS/F9xk3/l6EbkKNHsEdhtudmFiQXpV5uPZWMm9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G+rafrEmbaj1c+46eLXVEltPbR4p4Y3om8wSMXFub9RThXsNLivdGNVbt4agFEEC7/DZwm3opllRg6yfsEV+aqSidJeR4QjOgKHrK2mjo3KEt4GfWJ3dG9GGU9LDWgsHh+1YJr3LKtIM2wRDciW68HL5no4gvbpwWnAzj60oL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK9QIhQ1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK9QIhQ1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso15507555e9.1
        for <iommu@lists.linux.dev>; Sat, 05 Sep 2026 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788604703; x=1789209503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EuOySspaniUOzxdoDKGAWC5U3uQzn5Y/9QqLZWlIQck=;
        b=dK9QIhQ1dduU+VYENJKoeBfFpTo1p5JZNyprgPMoqdX+hS47ZZTBBB9MCIB/ldc4rh
         TbYdP4wsm1g0F/MTU4nTzAodMfyGOyR8H+jjTYSjTnIGJ9KHwvGiWeAxKApTW1g9zKAp
         XhDXl+u01reHqAW1dXegKYWqHOdR80MbHFtt0k5NB+vWQ2ftkO+Y9YsuwNQGcVXrOSck
         J8BvED7p9O5Pn1eMfBo3J+xwT4YTCx8QQLOSQJHVYBlOJOxnhzzdqeyx0z2NIAtFDNwP
         g/U4lJiuh7sOE0FFGhHzWfcQLvHJV2Cj5TKYx/zu7YIz8KnoZZBk2eMO61CWgy76Whbj
         himA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788604703; x=1789209503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuOySspaniUOzxdoDKGAWC5U3uQzn5Y/9QqLZWlIQck=;
        b=gG+nzVEWc4XH59IMXYjYwfcwWhPefgfM3LYelBJTCR5/t+XcQfL+gNLcLTJjM37ZS3
         TPZx8O61qjayZc8resbECFl8ZSHVmSTnwbS5SM62piCFcHeW7CQJgWICehE98VifJ2wE
         Ytcg0OTJMxtdklbPJSr4/1r3VxNNOhFHqvUteqOss7C7+kLP4NkBpvwVT0h34OX6khFg
         75sp2KiuRqeVfdfZCjARsr78ZUWIQWwTfVHdO2qz4KURwpuxCl8SrczLRqeU1OOtZ6jP
         yaQylb7VXBaLg1jg9mMBo/+T945iTjBGOrP30xTC4FJ9+Y0HBDrFDq7HW86mQevwrxVF
         fklw==
X-Forwarded-Encrypted: i=1; AKwUvByM7VDM0doXN1g1C/9E68+G42Js9pC0MYv/FZyIWQ/kqXVri0/n/HFi6WRhCEXXaURCCUhapw==@lists.linux.dev
X-Gm-Message-State: AFuF++lXtukjZhU+jM9ChFgXiDXmDmxbwaw0oODO7JSPKTkF2v/8F6XD
	jJEHbdG6c61AF6BUzhLpZ33hwrwVFxMtueVsz8xU9vA0P+nyF4A6HiqV
X-Gm-Gg: AYBFou1J2fHvENcBcLOzQdSFzmR93Ry+kdlXg/6FuZVlYvtIF70QHDWKa7FW/6pxan1
	oY7jfZMH/QXpLm575L1cTTCcSJlsYgAaRCRd6fMaKI/JiE+jEntgIAaCLpnLSS67q7YLtkEQ3/x
	K0KMQFZMwmdxGODz6KVORh25VuCSYeKd21DOUqMN7kZNRRe6qh9GPhg6Dei+0Q212VWq8GWORCu
	wHbdC1Unq0KVTORFIfBTEP/R/nVIUo4kbTUHI+axiVbFTA+xgECkFo87egf+W3nuNXWdHaUeF/+
	lhvnr7ObgCLCfFm9Oufdx2GVXzBlbAV5mKVn41roQH/mxR/n+sL1CaB/XREduJ2OvuqVOcC5I+1
	jkSifgb6W34TYRGPHIMcvurWZmhTOWOIwqqSV8iQMtTwsfeu8hkFgieirKZsLMUbU9NbQoGQA0S
	hexOWu5MtieDT8D1kxNeqDs9NmJc0EYeDFIpNpDvDbX8DqAdjNsPydOJZrqPXtF4P69Dr3cJpc+
	8UiknlsLjapXUAerffKORCfwvtY8pCMM+gEO/KnYE8D15a0tW8+/vvgvvABWXSOC6Mab+TjsCom
	qpK+M3Mng704FMa5q08XGrfhB/bsAh51eZeK/VAHjQCKe5r/wMIaEhYdl5Et+MGBvP1bk7S0P9G
	4Zg==
X-Received: by 2002:a05:600c:a4b:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49cf824020amr106100295e9.6.1788604703271;
        Sat, 05 Sep 2026 03:38:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm3335250f8f.0.2026.09.05.03.38.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:38:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH] Documentation: userspace-api: iommufd: Fix the struct iommu_hwpt_alloc name
Date: Sat,  5 Sep 2026 12:38:19 +0200
Message-Id: <20260905103819.43424-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct iommufd_hwpt_alloc does not exist; the name is struct
iommu_hwpt_alloc.

Use struct iommu_hwpt_alloc.

Fixes: e2d8fe9148b7 ("Documentation: userspace-api: iommufd: Update HWPT_PAGING and HWPT_NESTED")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/userspace-api/iommufd.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index f1c4d21e5c5e..763b23339480 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -242,7 +242,7 @@ creating the objects and links::
 
       Either a manual IOMMUFD_OBJ_HWPT_PAGING or an IOMMUFD_OBJ_HWPT_NESTED is
       created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at the type
-      of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc.
+      of the object passed in via the @pt_id field of struct iommu_hwpt_alloc.
 
 5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
    uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)
-- 
2.53.0

