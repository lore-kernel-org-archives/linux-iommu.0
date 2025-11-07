Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AD21D3F8
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558437; cv=none; b=DYqix62zUYdDyiYejCD4A7UbPYe9wtnvywvpzOY2LnI22qUhW8ED76RKknv0MGM8Pn82fhk2QIw7uwi/n/GFDKjXSGnhea+1I+3Xdj0LnCcKnuQpt+4O5bBt8N0WJ+Xsy/h1UhFK6Bj7V9lXbHltxG/BJnMjhvQcQL4vbm9J2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558437; c=relaxed/simple;
	bh=n1bFuKtdlnt7XRi46FUhRQ6Bn0uY8ezS7neJaezJxOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN5GiPGQexIwMfBANtrqmz6jjAftSt3lIyTAlWaSFnen+iiwj2gXp9s7QQ2ewybcF9ePZAXjp60AMGjesXxbeWHLUbpiH3TmRdywim9bjo0HBbf0JrN+F+PjViubqeEJcQ0hETepLcteGh68el+QEgj0XL1dhhjlS7KL6IEMPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5kTTnjv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5kTTnjv"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b556284db11so1015533a12.0
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762558436; x=1763163236; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGlJAgjZPtag5TirGXaS2/5ONA2zXm/4q2zVDYxz4+M=;
        b=a5kTTnjvdFxizblrlk1T7vEr530vKBmhvCVgAWBnl/vctLsHh8/V2xggsfHx0LjY2c
         PMdU1hVrUrbKzPtE7AgZbK6eOSPTAIbXs8mVbhnRH+fFJiV8CS7GPsAhqjn07Kp1Uy4m
         2/Zoxp9XOqjIQxU5QGL+Bxjfg/Kz61xrDOz8+xs+eLU2wr/q4WzJ/GmDVSLEC5LHk6D8
         jCXkD4ir8TpbODiOv9WEqJqXu4baiZSxGl5pDA9oSBtqvgKPA5/cMlsSGjtVoMzS+SYS
         znMaqinBpUzQE72Mn44XzpAIMF/ymFn49XrWA36myqJOrz8lxnIv8Ffjezmm0Lb44doD
         4kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762558436; x=1763163236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGlJAgjZPtag5TirGXaS2/5ONA2zXm/4q2zVDYxz4+M=;
        b=VklL4TZ6Mo8Vos30SC9f1r5HO0ivI+ye9UuA35OXJhzpGYw1AABjb1VCPdfNnWWjak
         62UqIpbqzAMoqcLWtqQNn8ZgnjFa38hkwS3ctJmrdBDXVcKOBIVQhE0ucehsBiNM8ei5
         0YMIRToFOFckaStRkFBQ7pmC+zqnTidJIrCbQDK9GWg86XmgUBGZ03x0iCgkKeBjgWht
         6+OzAcjHVAwQ1fcisQtunj9+L0q3Qnl9sCTE5bBWodrd/dMq1RLyO3Nalf2fT61tKJEq
         y+QMw/lWPEeP6oXq3QCc6AvugAgbqX5pMJZLNwo0H8vRj7pxqRbLB/p+KZfTAj5L+DCF
         i6Og==
X-Forwarded-Encrypted: i=1; AJvYcCX+lXGqWcFcAQPWW2X6OtUYedIbaGbGIkCfJn+KwVPERXC0aCv+wmy/T0hXkz0o6jCF0i9TRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeSq2kseeEPDWmdbZfA9rg/peJuAoxE2Gw+SOfBPnpn5osLw5P
	7sU1q7sMyHuNyhWMvGofx5CmHtVuwABwAPuitcMM03YbrzMBo9ClUub/PVTNrtSBo1g=
X-Gm-Gg: ASbGncuqlad0UP2jiptagq7xgSLVg5i56paKz53XetCjnbiEfg+G4uBxpCSLdlMQv9r
	Q8/PJf4H2ylIZudkm9RTWIldGZO1zDIH/4FlZ+WHmm/VEgwo6p8PDWHi/Zrau5S2lxpReWyOZwR
	Y4yrfZe8ei/MmoHox+z4VcmckrJLdiS/XNivdJjk6DW8vimmF/ozaxTcWLOGL+4jwn0WuNlcVd+
	gTiy51Jz+S4cj2ykJO0WESHiHWsbn3fJpI709gJjJsu8OQz0u1hQKX4FNWiNU3kOpR2tv42Q+Cj
	9UhVGtXVAhAVMqUVc2/8A/hPcm857dewmRVK6IfSg/26kisV280EfJi4c0jIlhpnUpB/05dE6vJ
	2+bPdnddjcJlQDkRvWjTvsgisJ7EnapIjM7oZfG8aV1zFJABao9O6dDxAKsj4Az1Vq0MzmqTuwb
	6b
X-Google-Smtp-Source: AGHT+IGJ+B/hqDtgl62JslOGOydMbTfxT1KUV6B60Z5pW1xtuDgezBwdauev+XWwxPmxcZIKm/8EGw==
X-Received: by 2002:a17:902:e847:b0:295:7f1d:b02d with SMTP id d9443c01a7336-297e56476f0mr9802925ad.22.1762558435589;
        Fri, 07 Nov 2025 15:33:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm70025515ad.24.2025.11.07.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 15:33:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5BA90423BF1E; Sat, 08 Nov 2025 06:33:51 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] iommupt: Actually correct pt_test_sw_bit_{acquire_release}() parameter description
Date: Sat,  8 Nov 2025 06:33:17 +0700
Message-ID: <20251107233316.7256-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=bagasdotme@gmail.com; h=from:subject; bh=n1bFuKtdlnt7XRi46FUhRQ6Bn0uY8ezS7neJaezJxOU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJl8jQEq11fXT/DUSg7faHZA8dkB3sUfjduPrWp/aqW/3 shgNadyRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACaidYeRodGo9tSeKccCBFnm mQmukpCf/+D0qehNPcXezEY5uluMzRgZHjj+bHsivy/R58lze+9wyc0tEdd+P47i+bnrXNeRSL5 wLgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

In review comment for v1 of genpt documentation fixes [1], Randy
suggested that pt_test_sw_bit_acquire() parameters description
should be written using "to read". Commit e4dfaf25df1210 ("iommupt:
Describe @bitnr parameter"), however, misunderstood the review by
instead using "to read" on @bitnr parameter on both
pt_test_sw_bit_acquire() and pt_test_sw_bit_release().

Actually correct the description.

[1]: https://lore.kernel.org/linux-doc/9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org/

Fixes: e4dfaf25df1210 ("iommupt: Describe @bitnr parameter")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/generic_pt/pt_common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
index 3b4e371089140a..e1123d35c90765 100644
--- a/drivers/iommu/generic_pt/pt_common.h
+++ b/drivers/iommu/generic_pt/pt_common.h
@@ -353,7 +353,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
 
 /**
  * pt_test_sw_bit_acquire() - Read a software bit in an item
- * @pts: Entry to set
+ * @pts: Entry to read
  * @bitnr: Bit to read
  *
  * Software bits are ignored by HW and can be used for any purpose by the
@@ -365,7 +365,7 @@ static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
 /**
  * pt_set_sw_bit_release() - Set a software bit in an item
  * @pts: Entry to set
- * @bitnr: Bit to read
+ * @bitnr: Bit to set
  *
  * Software bits are ignored by HW and can be used for any purpose by the
  * software. This does a set bit and release operation.

base-commit: 91920a9d87f5192c56ba5bf3e133aeb3576b705d
-- 
An old man doll... just what I always wanted! - Clara

