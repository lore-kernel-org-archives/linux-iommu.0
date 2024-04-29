Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133B46B9A
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390992; cv=none; b=TKZEWPGZnLH94g6e4YOEVBNtmQ5yJZvlbUK4JxJpsvBE3QUO9jf8/KV+i+e+ivDwZHuZ81iCEE4sOL3084tXnHjQhe4d6uukA9mCUImPzQkRmBBW7rH1NeEM1bz4QgRReiBpX5Nx2MAhTyVQzRlFw8A4UvDFLT1kyXUzDLpfzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390992; c=relaxed/simple;
	bh=g33ySN3LxvSYaTr5OKwNMo8DEr7hmdnQx2bZhCAnru4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQp6dd05riNDa+x0yf4Fm1QVub//iA5U+FavTC2L4F5t8C2/wEfNG6ELI5Zo3Aj1H0t5vkOfYsG+sKH02NjCNGUr9vj78E0fuRzARHqzPfTJVMI+J2V5uqfDla13wW0V0usISsTEb7XGF3mA6DmkmohJOscOBtY9+4jmz8OB/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTO5kke2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTO5kke2"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so6930811fa.3
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714390989; x=1714995789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iobJUdKPnLVIb4EdGa85F44GNjBoMRFbMt/Rt6vNcE=;
        b=jTO5kke2F4Z6rOeA//MsX1aheQRUoBE3o4AeXzTecNL6S5mnBJJyPzNIo1CpCkuZdh
         2PgiimOvjOhloutKQQMBz1wnXr+h6MAhotkTD4hbsZtEFzk6L3+oBkTgI5PnZdNwI2JA
         T+2xWtl7IVLq+Yp6W3+k2jmpWaVi7STrhyXHNHhocrZyCKVx656ZC9+M1sj+YB0YNGti
         Obo9Tz/qXujBAswhOLSo/tH89qiuA85QAss7cYzAy8/+r+UT1kT9G6xxnWoT6UV2k7oT
         0fo/sfg3bi4U07DHNWuWGOKFEBqtkPbI1tgMBuecvVcdS7xhghufFTuAttwpS1lYTLRI
         WyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390989; x=1714995789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iobJUdKPnLVIb4EdGa85F44GNjBoMRFbMt/Rt6vNcE=;
        b=J7S969NqoJr3lJblAGXDhwWkWeT2ayweZwSNBeO5V0Wriuua1k0FINqtl22SgIOWsl
         FJ41qE9tzlPDTondVCjmCSKaPcy+V5XEyXKi1YDf9ajx6L60394dRS2n9n0fCxIytyjA
         wSLrc2pPtWx7T1s8JyKDqujqs3cXnp3agP15Vhorc1Up7SSUBOsaRzG0yphHWUDNtt3Z
         /hVDk+IiGqWfMTdXUkr7/50FVkVoDQXsaI+AahhRDGdJeJIrMsWnj6n8DdJ0j5POlOCP
         7b8yniMl91zn0CepP1yffM/CNqOwopUB9Uw2Ec0yGr8E0ndP+nN1gYu/V1zNgNUit1DD
         Xekw==
X-Forwarded-Encrypted: i=1; AJvYcCWpT1UbcyGLn30P+3ap40QZ1cK/g3UW0ky+jDF1dyiO1ppdEuc8SyBP5jnHFNAh9r1av97te+K2MujC6ijM6ZVa47VHJq8=
X-Gm-Message-State: AOJu0YxGCAdDi9NR9Wl99vbJD2VwB3CHu/cJI6d4EWe9f+jaec4RZQOt
	p7NlyYXmqCevKWUZ/2TCE7Jbq+JkWculwL22CyuLSpAa3DFU98pERaigfwa1h0s=
X-Google-Smtp-Source: AGHT+IEq/BVzW1OsfvO81EUURO73iK1PlTqRjZgwsgNcExdaG/QA6hqLUNgRw7WtOV6ZCZAJNddz7g==
X-Received: by 2002:a05:651c:1a13:b0:2df:7d44:d784 with SMTP id by19-20020a05651c1a1300b002df7d44d784mr8398632ljb.3.1714390988764;
        Mon, 29 Apr 2024 04:43:08 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm7006611wms.27.2024.04.29.04.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:43:08 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 2/3] iommu/of: Support ats-supported device-tree property
Date: Mon, 29 Apr 2024 12:39:38 +0100
Message-ID: <20240429113938.192706-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429113938.192706-2-jean-philippe@linaro.org>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device-tree declares whether a PCI root-complex supports ATS by setting
the "ats-supported" property. Copy this flag into device fwspec to let
IOMMU drivers quickly check if they can enable ATS for a device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Ketan Patil <ketanp@nvidia.com>
---
 drivers/iommu/of_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 3afe0b48a48db..082b94c2b3291 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -105,6 +105,14 @@ static int of_iommu_configure_device(struct device_node *master_np,
 		      of_iommu_configure_dev(master_np, dev);
 }
 
+static void of_pci_check_device_ats(struct device *dev, struct device_node *np)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (fwspec && of_property_read_bool(np, "ats-supported"))
+		fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+}
+
 /*
  * Returns:
  *  0 on success, an iommu was configured
@@ -147,6 +155,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+		of_pci_check_device_ats(dev, master_np);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
-- 
2.44.0

