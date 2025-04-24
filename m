Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73A1CAA6D
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517884; cv=none; b=YJ7lSoFvebPqLsU6qNhc1NR8Na2FOqLCI6z7XdhSJlHkSvsrOpCPRbolDFgKmoSzWlxMjmRPu18LYycNqEE7iRYkSZrczvlctwyJgSoxM2S88JWZr/iuJ7sbT3x2eLXxO6FdE/ydbjBSh7oiq3g2S8pXFAnUVOQWpvgD1iUTv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517884; c=relaxed/simple;
	bh=SDpYS5ZWknMpckF1EiWnoZUkPjoTca1oTO5sjKUafB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MmLVDyQjPVeYFRYufabgDk1hQqmwlwTFysgqd5gaHxmpF7PPFkTGCILmuhKVe3QEBHAbNLHSKKXCP5iUoBre7Gp7y3ZBg8M0A20iGKqT4LEYa5KGlKx9LdkwhKBt4HtwBl0Q8h7e0SFIoxM0Mkp8Iz2WRmlZ/Vgnr6iZyvblz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ua/183mX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ua/183mX"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736abba8c5cso1643817b3a.2
        for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745517882; x=1746122682; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/zEUaD7XALmrEdJtQ+W7mbWtOiJSP/MzvvsaVR7LPI=;
        b=ua/183mXkrwv3Sg6HGhAVOVT07wMk7VL8Nk6nAVraYmyKLac7ph1BNRsfgzDN0WJfK
         QzASIYA2kMDeV983wp+XzUpF7VAET4K0j033TUbuIobMwBIbmQdU2e3m1civ7zkKD7O0
         w/LYY2vgVB2ETPjBRKMd1z0P1Dxv/j5ot5MrSy/LGOk87ShtodaSPX1mBRuJGps6zjL+
         HUIZKRfW8AqlkRzPHS5oj04A7hAd34VKdKHpb12joxVtKj7JcRE0pyf9oWwlcG8kkfbV
         UKJIAbUToMd0sqRd4sT3Pdb15TuK8Nt+B7sTwSc4OmIw7rWIpO7daHO3EFsZQU1nXmB6
         U1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745517882; x=1746122682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/zEUaD7XALmrEdJtQ+W7mbWtOiJSP/MzvvsaVR7LPI=;
        b=ZvoPzbZCYciqJpdBWhPrkDeKMtyQe7Gn812lJNI0YoCzV2Ic1NbCDt/EleH6rx+TIc
         2v+EOgwbgr2uZxoVYxtiVlu1OPscLsaNrZ/i6om88njuGymdIviHJZPrHCUJWsBdfBzq
         XSbeNSXEMS+IBdWTk0xxvlsKnb0s1jcAAS67DnOpzp0xcTqSZbj1PXpTVB75Wa5Ln8ZY
         mS/bMGwGyZBsuJT5VrtfPGTzpmGtqTSJqiAUl1Ru2Fxg5GlpQlmYM1YVZtEr142+hjTv
         Jt9jf8OrAIC3C9xLYbk63lNzrdOxNJj9EsK6wy2XMrPG9o8sLnXl35ooeXhPixMnjnK2
         SM3w==
X-Gm-Message-State: AOJu0Ywz5ssrlM6vAfNYNXhOakTG3/nImIRJRy7VgrQ3AnhiSWdaFePF
	SFvHd8HQO68vsY2Q2ErGWaHhzcBjRCp1LZlFTiC6SNJ8hnApkc7G/YI9dF4+5PG1hmxBNqGfWF4
	8++94ogsGHhi0CqiyealPg+d2Fg==
X-Google-Smtp-Source: AGHT+IFCD6wSkeShiUGYpxhZbZBv0/y9w0T1IIc3HNt1hkQLFgJDBQEO5h7Bli2VPrTT5E5MwlpXd85RSXZDpW3dVvA=
X-Received: from pfblm19.prod.google.com ([2002:a05:6a00:3c93:b0:73e:655:5bee])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:218b:b0:1f5:8e54:9f07 with SMTP id adf61e73a8af0-2045661ffaamr416057637.24.1745517882289;
 Thu, 24 Apr 2025 11:04:42 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:04:19 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424180420.3928523-1-willmcvicker@google.com>
Subject: [PATCH v2] platform: Fix race condition during DMA configure at IOMMU
 probe time
From: Will McVicker <willmcvicker@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)" <robh@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Saravana Kannan <saravanak@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To avoid a race between the IOMMU probing thread and the device driver
async probing thread during configuration of the platform DMA, update
`platform_dma_configure()` to read `dev->driver` once and test if it's
NULL before using it. This ensures that we don't de-reference an invalid
platform driver pointer if the device driver is asynchronously bound
while configuring the DMA.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/base/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1813cfd0c4bd..cfccf3ff36e7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1440,7 +1440,7 @@ static void platform_shutdown(struct device *_dev)
 
 static int platform_dma_configure(struct device *dev)
 {
-	struct platform_driver *drv = to_platform_driver(dev->driver);
+	struct device_driver *drv = READ_ONCE(dev->driver);
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	enum dev_dma_attr attr;
 	int ret = 0;
@@ -1451,8 +1451,8 @@ static int platform_dma_configure(struct device *dev)
 		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
 		ret = acpi_dma_configure(dev, attr);
 	}
-	/* @drv may not be valid when we're called from the IOMMU layer */
-	if (ret || !dev->driver || drv->driver_managed_dma)
+	/* @dev->driver may not be valid when we're called from the IOMMU layer */
+	if (ret || !drv || to_platform_driver(drv)->driver_managed_dma)
 		return ret;
 
 	ret = iommu_device_use_default_domain(dev);
-- 
2.49.0.850.g28803427d3-goog

