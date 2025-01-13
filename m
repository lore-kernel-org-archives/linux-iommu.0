Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC371BFE05
	for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807984; cv=none; b=XsJauNz1yNhb/S9FMHcChbanimUIQMbGpidIVKvNnDmlnUBe++M2bMJUk004YE+8pPvv9sXBsAbrk/vpPXF730tlnQGaZTARp2F4UqU2KwHhhXgSoySMiw0fh8cvq3qOH0NSGYInGCm/Jz/xUQjgaeFbjwhBoynI7Zugnop/3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807984; c=relaxed/simple;
	bh=RxErtiYMUazEmoYmh5FZmHVVMAScn+qRuNOxqhFnq0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iG5OmpxZVq51A6+Uhh+bkU6BJETuEwffuLmWd4dyQOjgUGmSieFO2xrJ48Uk0ZLrQE0Jh1DV5uSajvdXzybSG35rW3jbrxkNGd24S7k7+OrCtXYqZmMKgnwDoL2FSzYMrjND3IOzj4MPuxlUp2vUzwyDjlC4ZtOCQ69P3OO8I/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLMAcmD5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLMAcmD5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso34101565e9.3
        for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 14:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736807981; x=1737412781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rta55Y0uNleLFD95WQHH7zhK/RaF2A6MCC0b6AuR85E=;
        b=jLMAcmD57GY4MtU6WmGnOTC0Zx3pZWjb4jgEA8q0s6yoglVCePKkKrsS0Drc7WacrF
         DyscI/3KdbDqkCIjHs2Ul9bxndFR4EoXoNTWGftO/6mWtwea97t/9qOKfeTm7tUXWbv5
         r8L0PxSROooX+tm8TZQUtQQrL4gxrWgFidCotx7vbCNm5CGLljBOnq13fs7q/SVBnIBj
         jC2933RuHLkRj6zzwUZdMbmJs/UIJNsUCMjqmyIRANtPeDzFKRUNlmo3b2Z//438qwqp
         +m0xC4Ax0sJ/cypEkBU6EReTduD9FowheJrV8k6uxv3CuAhzsFGT9/pKZg1QTBHI4Uf/
         mcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807981; x=1737412781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rta55Y0uNleLFD95WQHH7zhK/RaF2A6MCC0b6AuR85E=;
        b=t5wuOzmH/BPxRkyUMeyFTGZ7t1Ufm+kq0GoFJ22LD4zShcPfYils7X7pRal4fzurJg
         mJEnq+Ex/jTig+hDM3G34HRlDgo15zTMiZBc4C7ViPZjZuaNoBXUW9Wnkwisj+JG/Gwa
         Ii4V0iWlFL477z5pkaFadLoRPCcwg38JzZ4YcTsNpQKp1yw/1aFGBf4cF3IXCF48rzZ8
         YIZIKJ0N7R9EXymATbA/UTmIknUAM28caYQJZAlhfL1+VVB3U4h9LdoKLQzyBBskn8aN
         xXntapYKrEkFteLeFaONLnWztSQ8bZcIJqNU0fpEapkmyhE/KQJbOIvZeh3Ce1/GpOG9
         vjqQ==
X-Gm-Message-State: AOJu0YwQL7zBOSggtaS69zul8+lD0ZLBnnT3jdMNTfzMEiojP0BHGIBt
	fWD9+isf8pM2T10z/bcsHue2Qbx8UZ+apxcHE40rPSYxVGA6Upq4
X-Gm-Gg: ASbGncurb6NxRo9KJTyWBK+guTj4eC2dmMOC6DYvF4OdBcvNTTPiHpOdhKczj1nwVZR
	GN2YiD8DB8eLbmBoPXQy7BmTSpOpXlfMprpimQKgpuj7tZq745BPR5tv5qb76MaPg1D42m8v5CT
	ivTshudodQ0nPpGMhcDFDDeYMJ7NGgShYM78OLeD6XvfyC5hoFiXxxdSJOrgmASlkA/PKzWm5YX
	H6z0SUKqamKDNZ3HUrHOk4ThCiLWDPXmcbEt4r/p1jPZiHXTUlJiE+K1w==
X-Google-Smtp-Source: AGHT+IFGzq5og6YanPrPwl8l/ZTISokVsIZVxIjPlr/KZ8ekAKdPyzYlE1WUdc0CNq53L3tThF1YJw==
X-Received: by 2002:a05:600c:1884:b0:436:f960:3427 with SMTP id 5b1f17b1804b1-436f960357dmr58577895e9.22.1736807980577;
        Mon, 13 Jan 2025 14:39:40 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:af9a:68cc:e070:12c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc08bbsm189024365e9.12.2025.01.13.14.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 14:39:39 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
Subject: [PATCH v2] iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_bitmap_offset_to_index()
Date: Mon, 13 Jan 2025 22:38:20 +0000
Message-Id: <20250113223820.10713-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve a UBSAN shift-out-of-bounds issue in iova_bitmap_offset_to_index() where
shifting the constant "1" (of type int) by bitmap->mapped.pgshift 
(an unsigned long value) could result in undefined behavior. 

The constant "1" defaults to a 32-bit "int", and when "pgshift" exceeds 31 (e.g., pgshift = 63)
the shift operation overflows, as the result cannot be represented in a 32-bit type.

To resolve this, the constant is updated to "1UL", promoting it to an unsigned long type 
to match the operand's type.

Reported-by: syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=85992ace37d5b7b51635
Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index ab665cf38ef4..39a86a4a1d3a 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -130,7 +130,7 @@ struct iova_bitmap {
 static unsigned long iova_bitmap_offset_to_index(struct iova_bitmap *bitmap,
 						 unsigned long iova)
 {
-	unsigned long pgsize = 1 << bitmap->mapped.pgshift;
+	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;
 
 	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);
 }
-- 
2.39.5

