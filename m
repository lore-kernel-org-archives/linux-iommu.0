Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8731A5B81
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936280; cv=none; b=tekAa9bL71nlQGDCmMCTkUJFUG6eVcvAs1McbkXccmgkUcM3QKBLaj3UDNBsDxT5HMo1R8bDOGzPrglhLAriLitXFpWb2M42twgUjGe8CaqEejb8FNovarTD89WnLqtXgTymTSoZgKDNsoYLYtICQctb68AcLL97N4QwgsiHuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936280; c=relaxed/simple;
	bh=v3Hh5XzM1q70/Zy0diNWQaVYW49fUs4qzgb8E/fNb7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uDWBArSYYKNXPL1mfBb2oIYrwQKtAWslhWH9VbRJ1wxZPbT/m4NNHLCvzvzEhRB9NU42qbqUkRkUkBLz9CxnuiEDav3awZfLwxciN+kS3QIkoX7laEiKRYpbWvIRtPWb/auPXCFJ3LnKm14XCeRKjds8cCib2pvUyCpA6SEpPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxR3fosk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxR3fosk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224341bbc1dso36238245ad.3
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741936277; x=1742541077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DavlysOJJOHA17TDQ0xs7RzF5yYVvf6N8aCOT9Y+pcU=;
        b=jxR3foskfzWcpg3vx9W1Z7WIOk90MMc0K2KrX6wM//STAGD6+e4zCTGWibFIKN5s02
         4LBkb1D/v5lzaZc0DJBH4HzGZeq1cK2b0W77xJTiUGe0moDYKwrU6YlRVcvk74r5ROL7
         ueZ9cEu3GIn+1y3eYChaIz2tinsE1sOEG5ks2rXu5DDeAIE5FjxMFEM2W4WSe8ZaTP0r
         Fo+ONvYwgbbAFz1h56SIFQYHduHB4WstIOFFHt67EoWlsaQoZRnOhmtGGW3qXnW6onrT
         3mXNxkN7ewf/Mq4SNkqwFjcPb5h2FqNrFgbEEIbM217+ONek8g2rfqh5JWGsIvkmvQ1d
         vPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741936277; x=1742541077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DavlysOJJOHA17TDQ0xs7RzF5yYVvf6N8aCOT9Y+pcU=;
        b=MScuhlDvF3VeyWcydYbRglYOzlu/Uwu8Uto1E0/KM1KRU+1QwNGKFu0ovvPCpQ+QE2
         IhLva1O0QUfnGVoFRj65AD0nN7gPYTj84B5dHovfSarFchMUjcWVL5/kG23WF20Z0B6h
         8YlNGjqJ3zI5I0e90dUZbAuUhHPC0MNjdOtKxyIKlC/ymx2k+RpHEEHRBLXqAaziymO7
         ShQ3OhcI6qKKEbtbeJBo+l4kCJHRVPHITuugjJK7OKJd3N4kzN/3GFnHHOrySANNIO8X
         nWnLEw1N1MtT2fVWg+vgrFYZfitsV8KJgiJGp1kiVHo0UJ8LX9ckz+Hx8tPBiBdJxDDA
         XqWA==
X-Gm-Message-State: AOJu0YzufOFguhoAmmByXGMuwy6fsQ8xFi99bwMXIYdAOp5vNoXkvruD
	pY+bhAYIFknbUeSYNPgKDKJT/8fGxd5htCL4DgaleaPM4dIuBHwFCHG2NM7cKEg=
X-Gm-Gg: ASbGncur6v0iMDGxvYeCTNiHn8e2c3ONWHNrYOjFxPFRwMlL0v1M9Lv8uWTebcaFL4B
	k/a1pJ1hVMQAwUn0MBIwgSNrdDBRHy5IIgvz6f06vgQzo+pbXl4r9yq7/wPh2ooT0Cm+DDSsdv7
	jepABHe3jhJ9Bk9mOxj/EJnCICrbeF29hKidDBOTET1l5OY1wgi04cc0zctMc5HcZMEdJP3e+SF
	OnAWK/qXv2vP50qaZ9iu/UeHcNOZvccKdV9JdKhkVchFIbs8Wx4njSGRh04osut8aifJA4Ncs3F
	b0vTe9krYByqls3Q9TxLrposK+GHgTqjpaqGzlPDBNo3XA==
X-Google-Smtp-Source: AGHT+IGPf7fXWdxEZzxqZBkzaZVDb+txe1gZne9gbcr6A/ds4bXXsnQpygSMKdfyZSdgoHRw/AONzg==
X-Received: by 2002:a05:6a21:648f:b0:1f5:591b:4f73 with SMTP id adf61e73a8af0-1f5c12d8e83mr2531873637.34.1741936277485;
        Fri, 14 Mar 2025 00:11:17 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea041e7sm1929966a12.44.2025.03.14.00.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:11:16 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
Date: Fri, 14 Mar 2025 07:10:58 +0000
Message-Id: <20250314071058.6713-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
changes arm_smmu_probe_device sequence.

From
pci_bus_add_device(virtfn)
-> pci_fixup_device(pci_fixup_final, dev)
-> arm_smmu_probe_device

To
pci_device_add(virtfn, virtfn->bus)
-> pci_fixup_device(pci_fixup_header, dev)
-> arm_smmu_probe_device

So declare the fixup as pci_fixup_header to take effect
before arm_smmu_probe_device.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
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

