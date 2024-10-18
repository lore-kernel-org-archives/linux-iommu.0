Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EEB20E302
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253852; cv=none; b=LhNR/Pt9lCiTI28/vvwzS0XCgYjlhPw6MjRl8WlMZWIfkyi73NnCRJyzLg1Zbky/26uW7pK0vry/bM63NKqdmIM7kA9/FNiwaQjYNlpCTOAmXKaLK7yBwLVxB8Kn9TVtTLZFt3yqP56/AwV0WRQB+5CU8d2eiY3Y9ewuW8RBgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253852; c=relaxed/simple;
	bh=cRedNhZinFJWNF1LdgN5osG3CkN3lOod1l75Ye8/xU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqjqbhGxDanLjGX8P35AjvXqrdxpqiaNHvGI029y68IsH9x0TfoRxdjndY0vfZiplN0AWUIV3lxg20DE05BbSaV22qDfd1p7vawouItYKb3K2bkWmZPJQhO4CD1zh0jc/3dn93Rvfk291DNyUPBdtSHo8M2trc8C8KGKD2A+mxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DalZQ3nv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DalZQ3nv"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d50fad249so1465291f8f.1
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729253849; x=1729858649; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJU/+Wh+ldjpgT/D+5mz9a/ir4F3D+2s5F/fl+n3k4k=;
        b=DalZQ3nvxkmNzA765ySZivZTerCMhGV/uWudvjl4lGKMK0Bxg6sKtrGFbqFll7Mabz
         LJrIn3Yo7H6b3WA2T8WQmJ6YTJ5F05442y5/qR0x9IpobGfF1yNByTighUBVjZ/NrFiF
         Eq/GOKZ4pXRPVmsA8Kr1CMsAtTq0DroW7oyGt7Zzw7IcOFfW0XtPNlnKYjAG10ibWbIr
         cH2xSV+r/DQ/mcF+KSzPAPF31Xw2xgIWSK1mkhYRA6CQWwTY2Ac4G2QEyZNLGFjnnCqu
         GKbKvL/zFSU2HtguChEPJ4sAN3BDvWInoICHiOGyc24LSNgOt74atWlKioXL+8SwZ32w
         0GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729253849; x=1729858649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJU/+Wh+ldjpgT/D+5mz9a/ir4F3D+2s5F/fl+n3k4k=;
        b=CGvKfC4Tim5AwVCoOwLY5H2UDc8QnDNglITP8+9Ur2Z9wi2aLm79oZQ6fPllf/dpQJ
         iD0TTGidXzC/QZ2zIihEqCf9q/GVGWpFCRWo83YD8mJPgbMzKMNnMqT1JeDBFQ8Sg2fY
         e99vAg3L4UnnqhsJANcjq02EwYu+lDBJseDHlDf1KFinQyxtqMYjQD3OJ6HQURkqJfCF
         XMEuZa+lZn4ctTH2ukrH6AdBNkN/r7/r+yt1p8zg0sQYThj02jDhdL2sdMTmH2ckzSu8
         4Ivj6mMpOLGzkOpaT0UblTWgztudC0kA5EdhSXP7lzR0O4imrSzS6QHX4VG/9aa3VNK7
         ht9A==
X-Gm-Message-State: AOJu0Yy/+AaT/qR/Yhd517vfIC8GVGDXPQ2t4BxhUuwmWLRxLSHU7LtF
	mfoMkg94GcYUzFctEjMhO7JmGKowpkAr+QiqFU1ZrfAEeYUEXWwmGRcSs/o+4BI=
X-Google-Smtp-Source: AGHT+IG330zsN0flUqcTgZUnJJ1SpIQvi23hlZqBRQ8HFr1BZREwbQHpxywMkQFN0Av5sFjn2jDufQ==
X-Received: by 2002:a5d:4535:0:b0:37d:49d1:1e89 with SMTP id ffacd0b85a97d-37eab6e46b9mr1521452f8f.27.1729253849150;
        Fri, 18 Oct 2024 05:17:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dc9370sm22535955e9.12.2024.10.18.05.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:17:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] iommu/sysfs: constify the class struct
Date: Fri, 18 Oct 2024 14:17:25 +0200
Message-ID: <20241018121725.61128-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

All functions that take the class address as argument expect a const
pointer so we can make the iommu class constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/iommu/iommu-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index cbe378c34ba3..170022c09536 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -34,7 +34,7 @@ static void release_device(struct device *dev)
 	kfree(dev);
 }
 
-static struct class iommu_class = {
+static const struct class iommu_class = {
 	.name = "iommu",
 	.dev_release = release_device,
 	.dev_groups = dev_groups,
-- 
2.43.0

