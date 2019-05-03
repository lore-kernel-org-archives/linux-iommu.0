Return-Path: <SRS0=zl4V=TD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ACEC43219
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 14:07:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4252075E
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 14:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="feHZTD51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4252075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 55E3D3974;
	Fri,  3 May 2019 14:07:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 150163962
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 14:06:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6FC9B79
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 14:06:07 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id e24so6154172edq.6
	for <iommu@lists.linux-foundation.org>;
	Fri, 03 May 2019 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dDG9A8vcxSWTc3lAhtot1/d3GbhCCecRqw2WbSyKudk=;
	b=feHZTD51V3Kr5/f8uHGsEm9lvHVjGVHfGjgwWhBBXg8KQhQyWaTT5ocm2pxvOmaA/U
	NHOymXRcp5B4BsHyh/B+1ypKS+hMZQKRMWS54BDSZVMwYYsObRy83TR+APQNE+A7fpTO
	V42S20HGilmypBW2HZg6GJD9e9LMG8JhGKKGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=dDG9A8vcxSWTc3lAhtot1/d3GbhCCecRqw2WbSyKudk=;
	b=Dv147yMzpRYOP8uWqMDk6IIk5hyMhK/gPuTpmfUEPDARLOq9XVuXe2hPdz2bjB3VJJ
	DduXSn+4EewLQ/WkaCC53ujcB21Cwjix0DmbMTZAqf/NyGAJmH4/YDf/ddHQZfwBXcAX
	2pGkXRcE89qO5LBPjnBQQJ6ICjDJsmo/28wf8K68rH6zMDNiQBsJwwWqlWX4rkeHqo3+
	mY1SdCvV/3A29GZkPAeT+KJzRLdhxTigEWKee6pp+y+5HL+4Kztsj0C5MxUxRB20y4iP
	UqNdTfPV0SjWKhM9lvplsDdMK6t1DsfiX103WKOD4UfZz5+pCaMALniYinOMmSzeYhm/
	4UNg==
X-Gm-Message-State: APjAAAXlN5uLjxgm+o/kMes7QXI188GFzEZRgR9vT47smQgrKkxQCnWl
	xgOsxaHzqTzKKUz7WLzc3j2C5A==
X-Google-Smtp-Source: APXvYqxdUNO4AAjiICo5DT6ucVOjhvprFFm/2BtoKIfgOXzHwJyKhWHar6DRBfmM7Rt0E3BQHIA7OQ==
X-Received: by 2002:a50:b835:: with SMTP id j50mr8464031ede.63.1556892366022; 
	Fri, 03 May 2019 07:06:06 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.06.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 03 May 2019 07:06:05 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v6 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA
	address
Date: Fri,  3 May 2019 19:35:33 +0530
Message-Id: <1556892334-16270-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The dma_ranges list field of PCI host bridge structure has resource
entries in sorted order representing address ranges allowed for DMA
transfers.

Process the list and reserve IOVA addresses that are not present in its
resource entries (ie DMA memory holes) to prevent allocating IOVA
addresses that cannot be accessed by PCI devices.

Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe6..954ae11 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -206,12 +206,13 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 	return 0;
 }
 
-static void iova_reserve_pci_windows(struct pci_dev *dev,
+static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
@@ -221,6 +222,31 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_ranges) {
+		end = window->res->start - window->offset;
+resv_iova:
+		if (end > start) {
+			lo = iova_pfn(iovad, start);
+			hi = iova_pfn(iovad, end);
+			reserve_iova(iovad, lo, hi);
+		} else {
+			/* dma_ranges list should be sorted */
+			dev_err(&dev->dev, "Failed to reserve IOVA\n");
+			return -EINVAL;
+		}
+
+		start = window->res->end - window->offset + 1;
+		/* If window is last entry */
+		if (window->node.next == &bridge->dma_ranges &&
+		    end != ~(dma_addr_t)0) {
+			end = ~(dma_addr_t)0;
+			goto resv_iova;
+		}
+	}
+
+	return 0;
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
@@ -232,8 +258,11 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	LIST_HEAD(resv_regions);
 	int ret = 0;
 
-	if (dev_is_pci(dev))
-		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+	if (dev_is_pci(dev)) {
+		ret = iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+		if (ret)
+			return ret;
+	}
 
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
