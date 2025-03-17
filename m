Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668DC13D
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174049; cv=none; b=EqrVBG6TI6Lz5kXGGfgHdeaxj7G00Dv0AtUqtibCCxheSTJTkBrE9N0ahfs92SMua/E5YvsnP3QSDeQSrm+Mh1skEu0hgKKOkYQzxcO0cSPs22v8Hue3TWt3eIvVGW1eoQFiVovaxW8dxXMGZVNbz5yvMtUPshA+hD3eDbkik2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174049; c=relaxed/simple;
	bh=HBdNRz7NWotgzuk+x/kxszEOIgphn0BH0jzSWHy0fPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnLq0oMaf+sm99tLBFp4weLoDfdTIJK2zFq5FQMxvThLIIoWUA+4pjZRfEaSJgeHbm9P1CaDtYYGM+8DB8YPdKGkX97/ATHI0QOIBE/WcyIc35wUmn0f+7boMHpSeu18PwbpYAdJmdspmJZGKtD1vUt2+zWbFrvxwYvmjaXo+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a1aRV4XZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1aRV4XZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so3125118a91.1
        for <iommu@lists.linux.dev>; Sun, 16 Mar 2025 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742174047; x=1742778847; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXru3TCUuPTakrv/YVRqLX7LKq46qhiQdzkoohXODxU=;
        b=a1aRV4XZeNyfnudbJ0/Jr+QA2KOrCx9GtzB8uu6CSpBsNELnlfM8Ya8l1SpdAX6unK
         4ZmyNDUmZoj/AbKGa3TtKD3YjoGWggsV4xvQK8CwllyWcTk3D4Rhf6wexiJ8XA6/7lxX
         MjDcu/SRlsmoAKv2IPy+A1dIyc3KhpDEZ+wo9OzJElpclN5l1wzJxqi1bMPaiFCH4utD
         B15L9FmnORJJh5F14buHdgWSzWaNkvFZi2nOlhhYf5e1LaOHLyS05pfjOgh9ncaR8l7a
         /zFuUxFptv+o3U25TA1CwKMtmC8V3eBKmHo10GdTfF0K3XrFUmFH599Jt7OFwKYfk/JL
         40ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174047; x=1742778847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXru3TCUuPTakrv/YVRqLX7LKq46qhiQdzkoohXODxU=;
        b=WucWST8ATM5QhvyrhOtQhYKXqtPLdv8Tpsq6OdOjY/mx/APtME1zgns4RBJ9yddYI3
         VTqvnkE+AvIomswqQLHIhU9kDyZoT3MIHCgIT3zg3JRolIAZQh8ViGHTbYWB08c5Nw3V
         yjXUK8hYfOB4X7DfpJa5Mu0e/ZkDVDNNyCF519sNpYVvcckYJdMYrKJ/fMDg3sV0YZv7
         y4cm4/sEUWATA52+sp/VwoFz0DD0suXS60RpQKbHkXoRljlRE1Zy1x8MjCAxMKEJKxIP
         CWYZjwDRtBdp0/PdySiQlAcOV25Ej0UuQL4GIF9Ia09WXJklCUMmvAv4rLWLvZL/PV1p
         LGyw==
X-Gm-Message-State: AOJu0Yysie+Xuf85ljWTvN/QTbhUYrPEjpMdv2EB6ymdHiH8WlUe3umo
	1+y1aNeP4XA9VQ0/j5xfeuP5P1tgbYoV0rpgvpdHD/uFtvsGTFedEyWoz9ipqjM=
X-Gm-Gg: ASbGncsH4iHzfrrbX7s4J8RXMMqO0rfT5NvmvpKI9EqfPjr9lIU9Y53Nt8x4RPxoKcD
	AHYWHOEpZLs5d2JeB6O+krBTCOcBxCbB1wEPJA4eDyM9VVBpEt1x4FQVFxNiLOQZ/weu4EHL22e
	K21zicRzZITxE/ka7d6YDxwSiRGilQiOV4wSA1gTgzZHNyi6vkgdeWmODRDUrAl4xDByDD0ZwqY
	vInS388SZOQVv+xoBXNROnu/E8FpQDocWEW3jPRkNdlx9d6ltcf3dNViqLirr6Rlm6S8hnjGuNe
	68BOPFVehlvqpDfb5BalltUM2cuI3K2ebcJu3p7pUoojGg==
X-Google-Smtp-Source: AGHT+IGOmbtA4Nm1nxJHb0yeQ9L0e+qEg9pRtI7VVMCpHNpNnF2DyuK2Y2lCTtT06AGryzfhV/6wQw==
X-Received: by 2002:a17:90b:5201:b0:2ff:5750:7a34 with SMTP id 98e67ed59e1d1-30151d81d60mr10497286a91.34.1742174046713;
        Sun, 16 Mar 2025 18:14:06 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153bb94e2sm4756494a91.45.2025.03.16.18.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 18:14:06 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
Date: Mon, 17 Mar 2025 01:13:52 +0000
Message-Id: <20250317011352.5806-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250315101032.5152-1-zhangfei.gao@linaro.org>
References: <20250315101032.5152-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") fixed the iommu_probe_device() flow to correctly initialize
firmware operations, allowing arm_smmu_probe_device() to be invoked
earlier. This changes the invocation timing of arm_smmu_probe_device
from the final fixup phase to the header fixup phase.

pci_iov_add_virtfn
    pci_device_add
      pci_fixup_device(pci_fixup_header)      <--
      device_add
        bus_notify
          iommu_bus_notifier
  +         iommu_probe_device
  +           arm_smmu_probe_device
    pci_bus_add_device
      pci_fixup_device(pci_fixup_final)       <--
      device_attach
        driver_probe_device
          really_probe
            pci_dma_configure
              acpi_dma_configure_id
  -             iommu_probe_device
  -               arm_smmu_probe_device

This is the pci_iov_add_virtfn().  The non-SR-IOV case is similar in
that pci_device_add() is called from pci_scan_single_device() in the
generic enumeration path, and pci_bus_add_device() is called later,
after all a host bridge has been enumerated.

Declare the fixup as pci_fixup_header to ensure the configuration
happens before arm_smmu_probe_device.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v3: modify commit msg, add Acked-by
v2: modify commit msg

 drivers/pci/quirks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f840d611c450..a9759889ff5e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1991,12 +1991,12 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 	    device_create_managed_software_node(&pdev->dev, properties, NULL))
 		pci_warn(pdev, "could not add stall property");
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
 
 /*
  * It's possible for the MSI to get corrupted if SHPC and ACPI are used
-- 
2.25.1

