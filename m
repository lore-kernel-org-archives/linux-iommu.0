Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDC7C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:37:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7762081C
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CVI1N4Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7762081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 328472B44;
	Wed,  1 May 2019 17:37:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 313132764
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:37:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9C2FE711
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:37:11 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id g57so8924263edc.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 01 May 2019 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3xPTSPJw6iXFSiPTAFBwEzjmdm3DJtxn26MyBE7/ci4=;
	b=CVI1N4BlG8HwXPhLobOU6JAKTbRtMIUjDK6ECuX9wHHKeV08OuvfPs7JCW/zhln6zx
	VeRfsSMzyuQzlAQP4XUJGGYxkwegvObFdmcJ7eXh2y4mdwktDgaPQY4+scz4a/eqMGMg
	IvcHOuRD+rxgwsloHSZJoKCD2uIgDL4cTg7Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3xPTSPJw6iXFSiPTAFBwEzjmdm3DJtxn26MyBE7/ci4=;
	b=bov35npbv9YfBfQgU7ipJ4gBtL8rVyYfgZAaoWUGtVEWMHzvoslVKPLKLX176ipy8y
	cTmhrtJ2UCklROcDBnmBUCYL6BDxA5Tj4w+m6uNw9LoZGmEoAE+N52oyWpELzuVx5jJv
	3Q8n/pxUIIZJ/oMPmkJVyugLdOsPeLFuNdrh37ZxKeKE6uOmP0pmosBR9w9OUHYRvZvj
	Fa6n/6h6b7j2R2mkyeZ6Q6YS9obmDA2AHXImA5TQTOAosNGHocx5NKYd5/0o2zoVHQ/P
	daldUh1js2C90CidmN5X/KyKElP6OneNR6W63+dXafwjL6NQjK1To8xuaj2p6o/Ohk1q
	/XYQ==
X-Gm-Message-State: APjAAAUCeMjlH85ehPAaQbT+/bgr3tk+XkhrFKhA/tnwC8gOKgimxqBn
	EDS42w2jrxLxoPkM7RTTavVQ2w==
X-Google-Smtp-Source: APXvYqxMHzoyOGYf0drHmb/y6wXO6syp/FMQbIZyj+iJbtVBJ6FIp7okadJfXPNtGbt+KmI0BUYQqA==
X-Received: by 2002:a17:906:49c4:: with SMTP id
	w4mr34032869ejv.0.1556732230217; 
	Wed, 01 May 2019 10:37:10 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id s6sm2462671eji.13.2019.05.01.10.37.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 01 May 2019 10:37:09 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Eric Auger <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v5 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA
	address
Date: Wed,  1 May 2019 23:06:25 +0530
Message-Id: <1556732186-21630-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
References: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
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
Message-ID: <20190501173625.UxtQjfKtbmKtTDE_cNyN4EFMSsC--_poEmX4ycyHtAQ@z>

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
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe6..da94844 100644
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
+		    end != ~(dma_addr_t)0) {
+			end = ~(dma_addr_t)0;
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
