Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F48C10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 03:15:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9032083E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 03:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J9hWhQyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9032083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EE19D2D10;
	Fri, 12 Apr 2019 03:15:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9D6CD2D02
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 03:14:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0FB507FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 03:14:05 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id d1so6997858edd.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=lcdd/bPKb2XUUzHHJ4Ig8E0QGdqRPLhszQ1yDGy5ZoU=;
	b=J9hWhQySSKQQY/XopWADH/wdNBV0kNkG//jg+fm5ydk4AhhSp4gHwr1RUmnOT9S+KM
	QHb3rpEr99GzSx6C8Dpp35JjOjX+qGTA4QuIfW0QOgTuNkCplW3PyO0jEGB6hpN++Erv
	VyD/WxxOIeNgUM1EpxGp+vagG6TfquBJVcLyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=lcdd/bPKb2XUUzHHJ4Ig8E0QGdqRPLhszQ1yDGy5ZoU=;
	b=pfMxvZBLJyj628zMgmEZ02EYo9OzLZ9u+D/h0sa0HqSRAPYxkp1G+fjPEyPLAn02cw
	7If8mNWqJjIGomwe+Jir7Du8IGqV+alSuWmTpY46PvSI9Rx9Tod561WCqCQFqY5RLCxw
	uVS9pGn7JrnxkfY7jgzPwBwPtcPmP0PMAvgeuHrtsVicfAB6f7Gf/W7wwnRFelT+YyxE
	Y/Pm+VAMhSAVe1Mnl91Yuynthd4BBs6pOEkQnwghjigaNqQUIjcJQT0P2ZiV4T+3CCAY
	7pezv3FnitkiT7GH+Q+Yl7vc7EtqGiD+WbAgGdK4QEMe55ppeDXHkr0WqiSlMpRI58LO
	50qA==
X-Gm-Message-State: APjAAAVFfaT+Tgh+vykClpU/o8Yh/b36kFNBjp+eU+cD5uLBeSOkbXP/
	Xgel0WpGd4ilXop5htvDzhFwMw==
X-Google-Smtp-Source: APXvYqyF17DtGNMMVaBx6A9eheF/VVXMsZT2lLxxTqgX/YA0cIoSQ3aE7MBfBF9RiDuoupVXJBcmfQ==
X-Received: by 2002:a17:906:d72:: with SMTP id
	s18mr18238050ejh.111.1555038844689; 
	Thu, 11 Apr 2019 20:14:04 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id
	c7sm11533352edt.70.2019.04.11.20.13.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 11 Apr 2019 20:14:04 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v4 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA
	address
Date: Fri, 12 Apr 2019 08:43:34 +0530
Message-Id: <1555038815-31916-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412031334.TO3FjuZ0TsR9xQEkphDrk4fuiMmH-CILYXSJV9SdeLY@z>

dma_ranges field of PCI host bridge structure has resource entries in
sorted order of address range given through dma-ranges DT property. This
list is the accessible DMA address range. So that this resource list will
be processed and reserve IOVA address to the inaccessible address holes in
the list.

This method is similar to PCI IO resources address ranges reserving in
IOMMU for each EP connected to host bridge.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..fb42d7c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -212,6 +212,7 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
@@ -221,6 +222,24 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_ranges) {
+		end = window->res->start - window->offset;
+resv_iova:
+		if (end - start) {
+			lo = iova_pfn(iovad, start);
+			hi = iova_pfn(iovad, end);
+			reserve_iova(iovad, lo, hi);
+		}
+		start = window->res->end - window->offset + 1;
+		/* If window is last entry */
+		if (window->node.next == &bridge->dma_ranges &&
+		    end != DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE)) {
+			end = DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE);
+			goto resv_iova;
+		}
+	}
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
