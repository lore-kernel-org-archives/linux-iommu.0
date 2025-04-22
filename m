Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439541F0E26
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745364417; cv=none; b=U8T7/WyfItKDi5yr+POR7u9HUSweiRROy1M5VQR8opiTrf0xzIep7trwli0UTABB1Ce8hMoYYz0STWMeg94vVWrQEh1cTAtoq2h7Dp2tDkEZP8369G5HjwU5lwphbrVU5CCTrfTWwe18L0K3ehfrrvZsx4OuC5PVc9Cmvezl9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745364417; c=relaxed/simple;
	bh=yV3172UPyrcXv7aQzcJRnQD7GsQG4ZbS0O7C0Ikh3Xk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W0eXeb+jZ7g9F6kwRLrE0uDj2VKZF5uHbsEc1vUfDs0BzL209cwCrLFqaKmD5BCy6be1Ev9cqbAiXcDLPJ0B04Xz+Mxu0gYqHTralWyssu4dgfR5tCwW6S+Xvk95mp0WtzGF8dHUCby3ZRX2BglN7E/vLNR4tWfuJZExfCGLea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=biZqMM3e; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="biZqMM3e"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73720b253fcso4817146b3a.2
        for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745364415; x=1745969215; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J6IcEzJxiXJWo904KtPQWxlx57qhuamCaTjhCSuG3DE=;
        b=biZqMM3ex5sK3DkrKY7PwD5sqJuLmwQz+UQ0jcolJeBCAJNjJCn8BS4wxufTd6F6DR
         LRbWo4MFDw/aCjlVU1ftY5Cn0FRRG5TqC+EwfswMnZ8HIGA5TII8mC/R9mTbRYZnZkJV
         68vi2/keTZSsXHK2I2zTxSDEdPhZJ9VWODdfZMfhkoMRh1B88AL/ILIZbcrhPL3lvAer
         DoSUqFE9jFqavzpuGFs/KA6n8IRhLsvVvjQkUGTBmX5pftuSiLNDzjwcScSqKJKOx3jp
         Q1t2ziOxiFWUnMu+TvMc1Pkl6Za/4PxG1fQK2YevLHlVdCbdnVGQBRCOMMYR5SwPlRDZ
         +zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745364415; x=1745969215;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6IcEzJxiXJWo904KtPQWxlx57qhuamCaTjhCSuG3DE=;
        b=liQAOQWhc4LSynxk9tC820NRqoep5cLsxl1KuY5iuN42vU1B6OLxqYPZOwaqKr8PnP
         u2uNle5AWzfBo7ju/RPS8oifv3tON46E1QySO7hgfDkhNRsin08IiCYlEtO4PUtC1t9W
         g9RuxR+OPdMxCypUEftnXenwWJKxZFAP9VDj9nha+gTtHrOHBV0CL1SiLi73KYnWY257
         8JVXjTFXAD18Llau+UxPtcad3fZQcbjOnhYlqI+BNo/hZOnIAfE/+Qy78WH6UhgfhzPr
         wllCVG2D6WyRiH2miMR5CZagQ5YFI/2TTAybrs3srDaYPvhNMDdh4s1Hh0Ii2noNIGgh
         bRiA==
X-Gm-Message-State: AOJu0Yx3nI2krwijQb3avx05Dza/Al1iJl7TXUZL/mP6Pz7EfHzPEBoP
	BFsFkgRD6A2AckN55mYOr5/U8UtdbFJCxy0u1QDwmR1jdPkXEOxxtRhAof1viIfGzDTaFi933uN
	GVjMnv7RDWS2moB3HNkM7ujNx6g==
X-Google-Smtp-Source: AGHT+IFnwY/Qn0g1gsIgPB5XRIFKYBhaqHjmYzWi4x3FEL3PSBxc1+8xW0JU5Z+aHvwvasCUwllL13+nb8oxx5IDyVw=
X-Received: from pgbfm20.prod.google.com ([2002:a05:6a02:4994:b0:af5:de08:d3a9])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a49:b0:1f5:8220:7452 with SMTP id adf61e73a8af0-203cbc74dabmr26806906637.24.1745364415552;
 Tue, 22 Apr 2025 16:26:55 -0700 (PDT)
Date: Tue, 22 Apr 2025 16:26:49 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422232650.2737369-1-willmcvicker@google.com>
Subject: [PATCH v1] platform: Fix race condition during DMA configure at IOMMU
 probe time
From: Will McVicker <willmcvicker@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Rob Herring (Arm)" <robh@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux.dev, Saravana Kannan <saravanak@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If devices are probed asynchronously, then there is a chance that during
the IOMMU probe the driver is bound to the device in parallel. If this
happens after getting the platform_driver pointer while in the function
`platform_dma_configure()`, then the invalid `drv` pointer
(drv==0xf...ffd8) will be de-referenced since `dev->driver != NULL`.

To avoid a kernel panic and eliminate the race condition, we should
guard the usage of `dev->driver` by only reading it once at the
beginning of the function.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/base/platform.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1813cfd0c4bd..b948c6e8e939 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1440,7 +1440,8 @@ static void platform_shutdown(struct device *_dev)
 
 static int platform_dma_configure(struct device *dev)
 {
-	struct platform_driver *drv = to_platform_driver(dev->driver);
+	struct device_driver *drv = READ_ONCE(dev->driver);
+	struct platform_driver *pdrv = to_platform_driver(drv);
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	enum dev_dma_attr attr;
 	int ret = 0;
@@ -1451,8 +1452,8 @@ static int platform_dma_configure(struct device *dev)
 		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
 		ret = acpi_dma_configure(dev, attr);
 	}
-	/* @drv may not be valid when we're called from the IOMMU layer */
-	if (ret || !dev->driver || drv->driver_managed_dma)
+	/* @dev->driver may not be valid when we're called from the IOMMU layer */
+	if (ret || !drv || pdrv->driver_managed_dma)
 		return ret;
 
 	ret = iommu_device_use_default_domain(dev);
-- 
2.49.0.805.g082f7c87e0-goog

