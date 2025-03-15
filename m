Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229E1E1C1A
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033448; cv=none; b=GKHKXwCra/X+GcW6lVc1mRVVi0Q37i1PYYVlxj8Tkxxk8YoHHLQ9n+9QZQijVuoHBO3i1dtxsoL2ersP6T865m0YSCZHVXRGs2aZQKKejM52DoaWXzcDSZ5Q/eSayND6Jwez8caiGcIOmwR67rldCLalSFXiQ9n37jRdDGXGKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033448; c=relaxed/simple;
	bh=vo1Ew4aLSrrge0Lgz3BYM6r54y2dPTj2RJNNDXpsAMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNFP7jglAEb9Dxl3EaNth0d0nTtgUBo6DAqSWeXlUgUD1A/oL1dxGUmI3EWPfuId1x34O/vgJ2JYg0LqV45EgpuKCAQZOoCIrvPaMCmBd/ifYtgCwPOfdv8EWqxj35VKIkUlIfHhzNwO7OWt9HzY5S58mcA9W5BIdvgxXJlL0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZ3HTHZh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZ3HTHZh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2243803b776so79543515ad.0
        for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742033446; x=1742638246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=qZ3HTHZhhMEkoI6OVayMiIIYT+pIAYuYPUchOCPWLzCS4GPaQsZu5geNxGG2Ui/JTa
         CDCdOuIZqpiN/XUhio6JmLV00zDVSPRsBepKeTL/GKP9NuwvAZbIJwH61xPkWvSiIwm1
         Dw+y0U7m/I4ElHbZaq+HFV2RQ+hRDQo/sIF4GSAd4FTzrioEBUS/ULL4emmasl8tAx0v
         75r5sQ+z0i2364CyW+k3O0Zj2RDN0m1MZ1STLRWNE6E2PaC+axFOupU5J1E5O4Fqe8WU
         gPfG4g/Id+kHScN1nixLXx29ncI0GOcfOyFthxCJsVl1/x+He3D8Wsimx8DoKqi1n5LE
         adqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033446; x=1742638246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=qRS6ebBCCRVNDuSi/WTmcINECIcxh7V4YxSuEdEgO3HrkyLgzKX61OFBsRFBRW35MN
         FkMEFsyBo1vl+AVy/IaVi/5pRdVyHKMAb6M7+lX4Dr9Td4n7/BEGOV4mLfjkV6mp5k1f
         NzkbjgGojT2IQXs25k4N6YKd3sW5+9Y/5+nATnvVg2HDB510BFDvW0MNq8afwyKdz55N
         cogod0MKicYrzpbCi2g6N6mYnWa1xYrhm46/QvoPDQWFiH6OUZQW3HBL9vh/uTHdYmte
         88eVIDVnFJZcaE18n1u/d891F6rQJ9vrwCpFHbBPzI+LeJmzcIk56j8svI4SeZMakE88
         KF0g==
X-Gm-Message-State: AOJu0YxVIMfAgFW/XTGwQ5zk09aBLr+RFvVGIOGmfBd33Zc+dxfEbKw2
	dcilLY0IyPITOMA9Etn8+fMsoZ1lxt09ajjUjBekU68uguiOYVTOqvqQ5JiVuXs=
X-Gm-Gg: ASbGncvkah04uaOXLk/gOaxXyXRlLEHQg2z/qKrw1GW4bHfQuyLKFfrp+XV3+iY5KWf
	N8zVtDJp+iFhTF3p8a27xydY2vb62I3WJul8lHVwxxRbodwjw7yA2Qm8ypjTpBSFJ+7qt/Y70dp
	+vrkU3210wwtkOsp6d04BJbm82j27ZEFK+DJRsM8N/z0GX+YJXAZsPk3PEHFyrbbW+hi1IGmcI8
	u/MsaG/SC/k05M5lMvPVdwA7cO/7D/X9A2JFJsCj/Hb+qjdi2qh4rIulPxv8tXteNBerxX1Oe03
	JQRQIXcyrzcZ8YlhBcg2S7njk8ip6mKnJC2H96YGqujQNA==
X-Google-Smtp-Source: AGHT+IHosIY5bP7h7ArQEoRLmL4SQpY/tfLFxgPSITUzhMnagdaeGJGiz8uq3+AHPbKPkmPtW1BXFw==
X-Received: by 2002:a05:6a00:a27:b0:736:4644:86ee with SMTP id d2e1a72fcca58-7372235af19mr6775218b3a.14.1742033446613;
        Sat, 15 Mar 2025 03:10:46 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511dasm4305588b3a.60.2025.03.15.03.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:10:45 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	llinux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
Date: Sat, 15 Mar 2025 10:10:32 +0000
Message-Id: <20250315101032.5152-1-zhangfei.gao@linaro.org>
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

