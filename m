Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348AD263
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siKS+Q/P"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5a7cc433782so77638817b3.3
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 22:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699424551; x=1700029351; darn=lists.linux.dev;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtkncXbsGTzkcpmqE5CtxJKiAY38OeROQGiJSCfS/Bw=;
        b=siKS+Q/P87jYea4lnJ+UK+ceA5MWD5HOHr0TqW8Opbk3nfiBgOmSAm6gYFNF2faWgZ
         OR6v8g22vvXzvuzS+p+LQhHukHYpnTYpEc3rVFBrr0IsN5lJnphrGzOaMLyqBuqLIyHD
         +OfmEoKRLr8VYXE5qTdKL7UwFPyVM2IB9YhOukzYQiYyubUddUWTREsBHDGU1/bTWUrD
         th380YbGUUGekUFM1o7Am6NMftAaP4pzvCHiuOfR5jFr5sdEv40tdpTSWzDH7MDYj+hf
         z5BQM8cf119HPbnXqdmiIF/ACFH20DkyCvpXvANc9j430z0HvROLRLFFwYZLHZcTfKu8
         0U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699424551; x=1700029351;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtkncXbsGTzkcpmqE5CtxJKiAY38OeROQGiJSCfS/Bw=;
        b=vXjhKUJpXYj1qZuRMUNJ0Xzs7oMb1i5dFuDVDhDm0/FMEKSkPh3OSioF0n4siD6l5b
         rboVMt62msl2oC+0gcNUFWkoBZFLR+eKxeXBUlNwKFljKq+OUq4Jy/aPP+GyQlVHVAjR
         a75S3B2RtM9Cn8xeweNsjZsvObV6gfiiWXqiP5pN3eq9TJsgbqZbRP3FS7OED3fC3B9j
         szgNSIqcyzfzyRMzq8gSZ0qiE3OvnKsoApTZNbtm+a+xq6xadEMSL0nt6nhCyX/Jds5h
         hzdcMoDwYR0pWezZJ/3f4bkh0W5xxxNRMIByoHJaYamkrPDcyfc/1oZmCi8nfUdmTV+q
         Y47A==
X-Gm-Message-State: AOJu0Yz+wAN/k9bxHj/NQOqYfSW4c1oj8jj8+wds+zDxmc9J2TTt9a17
	cCgOKVgWaBV6RJRhAC7Tm+TKdIzROiIKha+UML4dIVAKUXfTuMP+5aIsDmTYp8XS30yqRyLNkzU
	q7hq9e4i2xvyM5KZL0V/92NyOWEz9UDLvGNjJoLFbxOGcOFlrJ+1BtFFoa6WJCo4f+ZnUcjmZpw
	==
X-Google-Smtp-Source: AGHT+IFHKHZTU1b+Uv0rAAJi3YZuxBu9Bkz4bp3XNDgKryp3AH9pPzgQGaS9NQt4cjgUqefGJ6gP1O/n/3OmZXwI3g==
X-Received: from danielmentz2.mtv.corp.google.com ([2620:15c:72:202:13ad:4116:9566:f14])
 (user=danielmentz job=sendgmr) by 2002:a81:4853:0:b0:5a7:f68c:8d1 with SMTP
 id v80-20020a814853000000b005a7f68c08d1mr14012ywa.10.1699424550472; Tue, 07
 Nov 2023 22:22:30 -0800 (PST)
Date: Tue,  7 Nov 2023 22:22:26 -0800
Message-Id: <20231108062226.928985-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH] iommu: Fix printk arg in of_iommu_get_resv_regions()
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev
Cc: Thierry Reding <treding@nvidia.com>, Frank Rowand <frowand.list@gmail.com>, 
	Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

The variable phys is defined as (struct resource *) which aligns with
the printk format specifier %pr. Taking the address of it results in a
value of type (struct resource **) which is incompatible with the format
specifier %pr. Therefore, remove the address of operator (&).

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf..d1f3b92560bc 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -191,7 +191,7 @@ iommu_resv_region_get_type(struct device *dev,
 	if (start == phys->start && end == phys->end)
 		return IOMMU_RESV_DIRECT;
 
-	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", &phys,
+	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
 		 &start, &end);
 	return IOMMU_RESV_RESERVED;
 }
-- 
2.42.0.869.gea05f2083d-goog

