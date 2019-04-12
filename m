Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B71AC10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 03:15:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D340C2083E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 03:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OvIjFl1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D340C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B495F2D0C;
	Fri, 12 Apr 2019 03:15:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B38D52D02
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 03:14:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8229F7ED
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 03:14:00 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id x14so7054397eds.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 20:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BA318eIq/ox3LrTa6ojnh5Fujqy32l0ECRZ1GgahC8Q=;
	b=OvIjFl1cf6jHzfn8YkMI1A76F+PXL0/0dP+dQwBBo1jDqx6NVXCv6xprWX4fpMpNqw
	ptmG61OeALgLt9CLXh8FDB4qXP2nnGcvfUbDpXdATIpmOYzIheh+48cV7O7tcgZyGzKo
	nVW6VtcPYRH92qy3BltSNDlt5hjNzwyJPcVk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BA318eIq/ox3LrTa6ojnh5Fujqy32l0ECRZ1GgahC8Q=;
	b=XOar9C20Ylj85s4p8Ht0+UzV9sRMKBqiA9iuNhezyt+CTHEenz32LZx6qKrxPhy3v6
	AYCrlNIun/yZMzoJS+wnV4S6qf938UwmBMmjGNKeqvCsqsNDUsybV6nvCmvtv8IZ/OhV
	po0oonKQzfnD8HNEObXRR1uE9wl15CxlKHXWNA+l46rz9ket9Ysuf40gcOihs7G/za9p
	Bixh0hpAfbp9UbFFwH6GTlSF0iWdqfBmYthPvtSirrOYFDvT002QrX+iKyTJGbd+UQN7
	Et0Mm2VwJVlVEGBwlmkZE9mUImDWgdwyrRfpxRtj4RGuh9gfkNvaoPLjWVrBgPQL+TS6
	kskg==
X-Gm-Message-State: APjAAAWjYuCTRjyY5IiXM0MHCI8oSqzhkW8/hNLQ5Bmr3Ea6b4caM/1N
	+I8lRgn7W1rJxOcveKGhFwoNvA==
X-Google-Smtp-Source: APXvYqxIz+I4MHNrPKhgdy5fSwvOcaDMNK06XD7IWR8nOVbYPGDMhBVPDSd6C/ppYxHeJUSAax7pAg==
X-Received: by 2002:a17:906:54d1:: with SMTP id
	c17mr4317274ejp.223.1555038839109; 
	Thu, 11 Apr 2019 20:13:59 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id
	c7sm11533352edt.70.2019.04.11.20.13.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 11 Apr 2019 20:13:58 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v4 1/3] PCI: Add dma_ranges window list
Date: Fri, 12 Apr 2019 08:43:33 +0530
Message-Id: <1555038815-31916-2-git-send-email-srinath.mannam@broadcom.com>
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
Message-ID: <20190412031333.JbJAw69mp8-Fqa7q5A6l6I7TiVgwrScnJtJI_t4xQ7k@z>

Add a dma_ranges field in PCI host bridge structure to hold resource
entries list of memory regions in sorted order given through dma-ranges
DT property.

While initializing IOMMU domain of PCI EPs connected to that host bridge
This list of resources will be processed and IOVAs for the address holes
will be reserved.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6..ce5505f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -544,6 +544,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
@@ -572,6 +573,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
@@ -581,6 +583,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_ranges);
 
 	kfree(bridge);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c..016a044 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -487,6 +487,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
