Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28716C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:37:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98412081C
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cNeTm+C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98412081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D39D92B3E;
	Wed,  1 May 2019 17:37:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CF8372781
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:37:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3D94F875
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:37:05 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id g57so8924052edc.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 01 May 2019 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=aFszwaQY5oH4KxJcDNAltHmQUtC7DYEBegh+wY9ZhAU=;
	b=cNeTm+C8Sqi5mAJCHuRT7Oc0+dO/63ZhzRkoYfADHFXz8zh3Pndmn65kGUCDlaz81t
	J1j2eYjGQGPsgGjy3R6Bsi/O4r3Zanvv/sQbLPmkG44qaK4qFSP4oGbz3udaTje1EMYY
	2vcMpgjUgXXa577nrS8MTreZN9ECfSQLgLE4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=aFszwaQY5oH4KxJcDNAltHmQUtC7DYEBegh+wY9ZhAU=;
	b=AZ1vwb430PeFPLqVNZAyKfNcqMgEnETCix1jk2NPj5oFwIZ2+8eM3hpceLOVrPNqa0
	GNpe6Wzi9KRP9FBODYdHvs8k0kVCbFaJaJ+JFh5IR/itENWGb4sR3U+D00dwRIPKQHvk
	KVet3oUxZ0KRmoQKqPjYj2aG8AoJJKZTZ+CGPeMaK/DddUgcWdwd0ZU+SvWUj6OwoXkd
	OovMdwCSPhvQANfHToLycFbcsXZtdbtdJHJfzsxB8EiI5LeMl87utwZ9ZuMRXgd4/wdn
	K7pgQNj2BuB9JW4oSQD+e/fqLZZeJ8ixViqSmyVQFhSlA3nhHH1f00lIKxWoL/eeDhqn
	VNoQ==
X-Gm-Message-State: APjAAAUBSELLPbjYkHeaDUTsEoMr/Z93VnW0m7t+8qDgo7wuEMtPJg99
	91sIE/P5IfrlzznpyQhiPE8Tuw==
X-Google-Smtp-Source: APXvYqxGBQcZ/qykETC1CAlXAsxs7RgZAz0rpL8xixum/V2QqoCz8gnlSBK3/rkrc2PtiS9UiScFoQ==
X-Received: by 2002:a17:906:2301:: with SMTP id
	l1mr25776880eja.121.1556732223856; 
	Wed, 01 May 2019 10:37:03 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id s6sm2462671eji.13.2019.05.01.10.36.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 01 May 2019 10:37:03 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Eric Auger <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v5 1/3] PCI: Add dma_ranges window list
Date: Wed,  1 May 2019 23:06:24 +0530
Message-Id: <1556732186-21630-2-git-send-email-srinath.mannam@broadcom.com>
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
Message-ID: <20190501173624.xez858j0RvmFf_wZUBPqywBwqgTjod9mIMVf7pJzVQg@z>

Add a dma_ranges field in PCI host bridge structure to hold resource
entries list of memory regions in sorted order given through dma-ranges
DT property.

While initializing IOMMU domain of PCI EPs connected to that host bridge,
this list of resources will be processed and IOVAs for the address holes
will be reserved.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7e12d01..72563c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -595,6 +595,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
@@ -623,6 +624,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
@@ -632,6 +634,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_ranges);
 
 	kfree(bridge);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7744821..bba0a29 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -490,6 +490,7 @@ struct pci_host_bridge {
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
