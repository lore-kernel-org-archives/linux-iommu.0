Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA21F4701
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033615; cv=none; b=I1IdlBdRfT23/fkNI6VOOdtgqAuFsYNuP9LFJvL1FHuxCu2g0gY855uYqCYIHIOEmnKObFov6MSM1w4zwJdXm0lBB9SICvyazYAtuOw/cDpwQLFxOFFw1iQZx7dlOkM9HUAph6P++6ZSkx6IHZDzqhVWXA3xbH3YmfAFcPMeYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033615; c=relaxed/simple;
	bh=vo1Ew4aLSrrge0Lgz3BYM6r54y2dPTj2RJNNDXpsAMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKn8bq8kYo1+LwsqyX12XL5DA+54LSWc1XEJNdnIk2ObU2PikBC2golVTrLdCiIdStrNm7UPRKZT3kdr668Zxw0yqX80SU2uXHxRUHBZCvfrAqxdhg5Omz6X1bRO/vQOam+ZbGzJMKWcRJj9Ld53TxEvsVm27sNQo5aYBuSaS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NMvQ3229; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMvQ3229"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fb0f619dso49686685ad.1
        for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742033612; x=1742638412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=NMvQ3229iIuD/2hHtqmr68UzlUAChnO2TcAGDpFQ4N2r4jw7zc9Cwmouwro/WYaH/Z
         CvwzIXsQU5jewJPobElesrtlD7gsW8a6JzBbP5WQ7Sa8AaDKMvSdKxX3p01EGKq9dF6b
         Wuq/sk5gf5Wez4Ni72MzpVj9N7fRG6NJ4OGRdf93CW3YDHlAvQSaSArz2Es34HSYcTgZ
         p7uyN5tHhQDydSC0go9+y63eHPlBm61X3wyx89rFafJN5oVkYSk8ysqDWh858bwHneQk
         PxdA8O6dKedhBSybG0fDQS3SUnSgeSoVixvO0OJ1q/ttbSFKFeIyIIVS5oD33KI+f44i
         tfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033612; x=1742638412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=dShn+XZStP1qyHg4umLp7YZIz3LmNEIiFBw89OreqPlulX/baW34q9o3TX0+yCKjQC
         DGYYi54vcaFeH6u1BqyD9Cz5xkIv4UibaR6GY7Y4698ZMejCAOg8mu2HP/CBsMNKkhxF
         gfn+nE3aR9T4EteNH0TU6vXm6u9y1HFQ9CtnnujNtJNsspgDR/E1InOBSvDUr4ruZvnv
         8g27mmaG0gsXcIrLs3JHWEI3XC/i9qne45SBPb3Gjf/0wtNtfcS9hHAjBj1toViMVfKo
         ToGEjB90HGaKHs4ATxze+c4Agj7phspKSxEQJOAQfAIWVRM2XrYSEA5nhXsKtiXK6kWL
         ckHA==
X-Gm-Message-State: AOJu0YzjSPgQWRzQsctuKvsbGMho5sIz6FfMRRwMhSlwGPf5y1Shu37n
	cwPj3PtXEvPMWCPI9oDFcD3nNIutFr+cx48mqEGtAXiG2FIw8+he9qXNaE6+hw8=
X-Gm-Gg: ASbGncv4hCWe69K+9EzZsueD7x37Od9YyqQuP/T1Uwpb52kgejQXJYDASqVE1yhPDUM
	4Bt6youw+mVV78lqVZmq+j0rZFL1WXMlqN168rGHDmHFAic4mGCd122qbUdg+Q96W7kpDqgxbOn
	PO6n1lSLmBwqM9lSUWrs1gPAODMmx26WtH3cY4qpLLc/qMFsZQm/YHBbKHj+GOp3uudIMDKg2ZR
	Jqv1dBVwkkjAH+T8RGMIZBpvPxMxL084JYKHgExCUZsEDvLd+RDV7tMwvK8ymF1g11OTm6Vanpa
	fhF6FewBWDMo1IOJH80KBJFyP4a9PONvHGnGTDSiTJATpw==
X-Google-Smtp-Source: AGHT+IHc+zbfLPsEbvvVLayren4erBe1Dj0SSg+NK2HsIPUFW6sh7RHagO+DW1A24D8x9HdCwjeFHQ==
X-Received: by 2002:a17:903:3c50:b0:224:1579:5e8e with SMTP id d9443c01a7336-225e0a3635emr76218415ad.1.1742033612590;
        Sat, 15 Mar 2025 03:13:32 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688846csm41957545ad.33.2025.03.15.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:13:32 -0700 (PDT)
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
Subject: [PATCH v2] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
Date: Sat, 15 Mar 2025 10:13:19 +0000
Message-Id: <20250315101319.5269-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314071058.6713-1-zhangfei.gao@linaro.org>
References: <20250314071058.6713-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") changes the arm_smmu_probe_device() sequence.

The arm_smmu_probe_device() is now called earlier via pci_device_add(),
which calls pci_fixup_device() at the "pci_fixup_header" phase, while
originally it was called from the pci_bus_add_device(), which called
pci_fixup_device() at the "pci_fixup_final" phase.

The callstack before:
[ 1121.314405]  arm_smmu_probe_device+0x48/0x450
[ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
[ 1121.314412]  iommu_probe_device+0x40/0x90
[ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
[ 1121.314417]  pci_dma_configure+0xf8/0x108
[ 1121.314421]  really_probe+0x78/0x278
[ 1121.314425]  __driver_probe_device+0x80/0x140
[ 1121.314427]  driver_probe_device+0x48/0x130
[ 1121.314430]  __device_attach_driver+0xc0/0x108
[ 1121.314432]  bus_for_each_drv+0x8c/0xf8
[ 1121.314435]  __device_attach+0x104/0x1a0
[ 1121.314437]  device_attach+0x1c/0x30
[ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
[ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300

And after:
[  215.072859]  arm_smmu_probe_device+0x48/0x450
[  215.072871]  __iommu_probe_device+0xc0/0x468
[  215.072875]  iommu_probe_device+0x40/0x90
[  215.072877]  iommu_bus_notifier+0x38/0x68
[  215.072879]  notifier_call_chain+0x80/0x148
[  215.072886]  blocking_notifier_call_chain+0x50/0x80
[  215.072889]  bus_notify+0x44/0x68
[  215.072896]  device_add+0x580/0x768
[  215.072898]  pci_device_add+0x1e8/0x568
[  215.072906]  pci_iov_add_virtfn+0x198/0x300

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---

v2: Modify commit log

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

