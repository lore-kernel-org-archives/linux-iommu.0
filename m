Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FD3C30
	for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 16:44:30 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id h8so20785626ede.8
        for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678812269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVoWSrSw8iWnvdsUsZm3Xc3V9c32i6G9JTNL1QjtlpM=;
        b=Q6clugfH2wohZW+/jssUotWY9EqeGyTOorxwY/50yJNmRT/yX+yr2l4b9WrkomV9M2
         KA6RYdkb+Z82ezcLYElhpJ9q/kHG8WcSsHjFPIxYg1AF657VKEpQLmQ1vxzciKLLC9aY
         FeDHZ8DC9Hv2G3jsbjPWgaicialWvwk8ZD1B9TQvcWNp7j6/3SSVtOiiugxciAUFRL39
         aHk41xve72YWPyQmkFDWXwXxXVidovtu8+hBDuR35WKuTKXs8zTWYNG+SLAe2060h0K/
         E9WKNP88fYFtJVfh4u3gJSf7uWNKIuPaA1uJvj70gU5vLYS60bdTxx5lnxdFmTbEmFu7
         JPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678812269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVoWSrSw8iWnvdsUsZm3Xc3V9c32i6G9JTNL1QjtlpM=;
        b=G7k4d0buoij4ZPF5pvUASBVcpkIyEyfV94Yvh8SSdNljf4YtxFoE8KCiUE1o3cZc3K
         6ytlGsBvMJ2xdEHwpUEkN6yVaB4/wgv0HqgNbzNT5DdQaDYn8zIX/kghPmhx70mxWEUJ
         +PlmPe5kQRW4ELehW6QZsOIot8aTJWddYpPOvtvSRoL4X7lySj/ZDt5IqlLl8V3afgFC
         HGdm1URIezhcZIE4ailSfKdHMWK8+30W4jJv81qT/nOca2RAEHfGk21ycss8g5bLbKfy
         gHAyADPU3GI/5WrQs5AbCRa1mKjVUGN5d5CncNnVdTnPSPCu40RW2S1y5KAJtejDeana
         bSSQ==
X-Gm-Message-State: AO0yUKU0uAmxbfWkeD60DAhCpCCOFEztfvW4udRGXZvstjO++FO3magL
	/ua5sNddTSb2/JJTVnKlBzLcNw==
X-Google-Smtp-Source: AK7set+yBLjEXWLeeOSy1YCkZG3vvlqho9+FJiah/pJcz/iWU3nnD6rKgcsZCn3D2SKW5QT0yWNd7A==
X-Received: by 2002:a17:906:816:b0:924:d90a:6f97 with SMTP id e22-20020a170906081600b00924d90a6f97mr3276207ejd.13.1678812268851;
        Tue, 14 Mar 2023 09:44:28 -0700 (PDT)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id u21-20020a170906409500b00928de86245fsm1351055ejj.135.2023.03.14.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:44:28 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
Date: Tue, 14 Mar 2023 16:44:16 +0000
Message-Id: <20230314164416.2219829-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up DMA for a PCI device, we need to initialize its
iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
this we use pci_for_each_dma_alias() which calls
viot_pci_dev_iommu_init(). This function incorrectly initializes the
fwspec of the bridge instead of the device being configured. Fix it by
passing the original device as context to pci_for_each_dma_alias().

Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
This fixes issue (1) reported here:
https://lore.kernel.org/all/Y8qzOKm6kvhGWG1T@myrica/
---
 drivers/acpi/viot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index ed752cbbe636..c8025921c129 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -328,6 +328,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 {
 	u32 epid;
 	struct viot_endpoint *ep;
+	struct device *aliased_dev = data;
 	u32 domain_nr = pci_domain_nr(pdev->bus);
 
 	list_for_each_entry(ep, &viot_pci_ranges, list) {
@@ -338,7 +339,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
+			return viot_dev_iommu_init(aliased_dev, ep->viommu,
 						   epid);
 		}
 	}
@@ -372,7 +373,7 @@ int viot_iommu_configure(struct device *dev)
 {
 	if (dev_is_pci(dev))
 		return pci_for_each_dma_alias(to_pci_dev(dev),
-					      viot_pci_dev_iommu_init, NULL);
+					      viot_pci_dev_iommu_init, dev);
 	else if (dev_is_platform(dev))
 		return viot_mmio_dev_iommu_init(to_platform_device(dev));
 	return -ENODEV;
-- 
2.39.2

