Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326287C
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 18:06:11 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id h8so50200543ede.8
        for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679335569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X51Q8hDC/IQxJug1cczWInk9U8e16wx3dU7fgiFAEVU=;
        b=s4zbcOKPCoiqw9KRAGBSFZTaJyDewczivh7t8hPtYrCCNn8bqj0J0T2OqKKvvYB9Yj
         sjh0W2oKI4G+eK05iX0on9cf9ERsEgAzAtxsMiSbKSiXG8AEeXYGrfj+/BBUEDNV5Cks
         iIM9K3QIL6ZoIOsIbLETQ9fjlIgn8L3PLqVMlyW4bmbD1ByykROv2swPRVbDSfjM7tAm
         yxsyeAcIt/mXzqN7vvzXDrGWbIx1xhatTOyeO5gTuwLiStGJIOC5aTzEndiMiFkFFfK3
         NFAEIfclPmRhsNlGGeHRf4Y+XC+xAaDHACHQxat0cwf9qtx7onBavwhxCoz/pziy6/Rq
         ceHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X51Q8hDC/IQxJug1cczWInk9U8e16wx3dU7fgiFAEVU=;
        b=SdUves2dijKt5RodRKlOdYJaDz/QF6Q/SgrWXLvrDPqVjUy1HURgVck3xCJ2UZ2L52
         vLzqZuwOxvAhxLnuCYSpvp855d9MrHVh1QIQRhtuqMCgksg0rPAwwOyKYzBoyvct/DV7
         XobhGPlYMXHSSEKK0MGXwEm5uP8Y+ytpSuqiawlOCIQA3/Yt69qygar9N6HYRcpH9yWn
         PHGbkIwDl3V4oIG75IqhzrfNc8jApAcHE20rOYL4V1lEN4p4m2HYjBdpDON4WvDhmg4a
         2IeUobRgLtJaxhLodbrS03FafSPxvTTP4ctpkbIkP5iKrPCLc0WBA41cmkszwJ0a8sXw
         SHNA==
X-Gm-Message-State: AO0yUKUSm4bKDJt4U6x8hhgPerB5g2qo9pGQeo/tzV9uvJ31495ficrj
	xtmRXCraHKHZKjyFpSejrWYOrw==
X-Google-Smtp-Source: AK7set8tMwaO8piMMP4jhGMzPqLtV6anULnSbduxtDUNwOaGKChCb4uO9Q+3Akhnoo86JOA6tYtPRQ==
X-Received: by 2002:a17:906:eec2:b0:935:4981:fd0b with SMTP id wu2-20020a170906eec200b009354981fd0bmr3016551ejb.55.1679335569395;
        Mon, 20 Mar 2023 11:06:09 -0700 (PDT)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t14-20020a508d4e000000b004d8287c775fsm5213115edt.8.2023.03.20.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:06:09 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	helgaas@kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RESEND PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
Date: Mon, 20 Mar 2023 18:05:29 +0000
Message-Id: <20230320180528.281755-1-jean-philippe@linaro.org>
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

resend: Added linux-pci list
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

