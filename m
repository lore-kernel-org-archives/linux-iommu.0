Return-Path: <SRS0=zl4V=TD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59300C43219
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 14:07:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7622087F
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 14:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eGhXmoc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7622087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 185B73971;
	Fri,  3 May 2019 14:07:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6148D3962
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 14:06:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2921971C
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 14:06:01 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id w37so6153445edw.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 03 May 2019 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=D/CH4GqGr+z8YvNiyoDqREVHjChbqZqJjYmwX1HGL8k=;
	b=eGhXmoc8I9oK5S07+Cf/+NBpgznArjYFwNdzPDBoc5oNv6WpfFrICkvkWudLf8UoXM
	oURzLmKVEFVRQxZXxb+XXHRTJNlkjfG1iBgT1ph5n5gPYfsTtOVyyG6Rty6Z+jReH9cq
	R71Ey5B+kPUXrCZdmq4MraXrTUzvKbiMIgtaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=D/CH4GqGr+z8YvNiyoDqREVHjChbqZqJjYmwX1HGL8k=;
	b=d12e26eKzW2Kw1ZChpqzqoM3T5nrcnXI9WuD0sfhdl76J3W5i0PiZZv0+mP1t53diS
	UdPOyjxba0+m5wG2F+KXPfshepdIhVdguRjZh7jQgzsQPZnLUdsB+NAcv0HXHTQFnHZl
	gs3Hjod+FGwsm0/a7JYqveS0hOvyycVM5gJZcyBOSAgpzpXVu7QSmWpf5pGvJjp3xHGJ
	XO380hHVQQ4SJ+et1RUnI4sW5QivbnDP4D92Ec2kEXG5WLHSz0pr6g/vIAZQeFeX5YKj
	MFesJwjlSeUnz6WHS/08TWKiaIh22w9gVDdnJTGNaP0yUi9BOfqMBCGP0DQ0XoTf2bio
	RFdw==
X-Gm-Message-State: APjAAAU2Ms7881q4SE1kJ5AosOlJi2TAYvSFKG93GBYXBmqde+79rajO
	ZnPs+A7+tPKsNZNLAOQUXwL+ww==
X-Google-Smtp-Source: APXvYqzGIjNck5fcKtNGAmKeDcxVbNQcwMe9+Ow76Mtcv1tHZaSwqBqwtaKclkMR03PmKdn3UxvlPA==
X-Received: by 2002:a17:906:6a1a:: with SMTP id
	o26mr6433401ejr.170.1556892359682; 
	Fri, 03 May 2019 07:05:59 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.05.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 03 May 2019 07:05:58 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v6 1/3] PCI: Add dma_ranges window list
Date: Fri,  3 May 2019 19:35:32 +0530
Message-Id: <1556892334-16270-2-git-send-email-srinath.mannam@broadcom.com>
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

Add a dma_ranges field in PCI host bridge structure to hold resource
entries list of memory regions in sorted order representing memory
ranges that can be accessed through DMA transactions.

Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
