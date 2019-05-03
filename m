Return-Path: <SRS0=zl4V=TD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA6DC43219
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 14:07:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D212063F
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 14:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ccHpnw/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D212063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8C3753977;
	Fri,  3 May 2019 14:07:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6581B3962
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 14:06:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AD44B79
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 14:06:13 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id e24so6154612edq.6
	for <iommu@lists.linux-foundation.org>;
	Fri, 03 May 2019 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=r4u5O1ZVpfa/NoghF2cTBMxxDl8TKg0sIE8liHJFO9Q=;
	b=ccHpnw/RpgY9kfcH8RVxE+1twK6DE6BPB8HepDw/YqeUPaWmmuQTQ4r/xZPcJ/HS2V
	yXYeLA69ocApJMHE1Lo10gkLx3ejJJ/TPlFxpB0OKRuiXQiNxttte3sdqbpsugKPw1Mp
	jG8eBraDllvceAFhJZ8smmSPHz+e8XhEVxMWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=r4u5O1ZVpfa/NoghF2cTBMxxDl8TKg0sIE8liHJFO9Q=;
	b=FhMYymdR01azsdv0OnnMaTGroMGTFemUzFMH6/A+3yPhJzbMR43Xu4YMv/oGrZCSaw
	2MTf/6sYJN9X9qhm2vJFgXfY0aPOF52ZDgB3y5i4PoOqcA+44urBq692oqVMmVm/MDOa
	wAYnLCkTBU1v2EZNt/6vUp46D7Wid3J+eieoD3MOVzlVEdBMDKDHgAr5FOS8QKzxM4JC
	77JvTzZxyuJ6LxCrPo+PO/ZuhuejCuMuMDq8tNebkhGtjrBVxWNqI9J3B2PmgXnUJ8H9
	lGrCEzGWOTx4g17C2lzRMt3lAAoynkZwJeS5HasB5BiorR1vG9PofGehxQWwqbIP6aNp
	JVjA==
X-Gm-Message-State: APjAAAVOsGM8Xxyr0lzwoS6qYGvyl+Kn4NAhyj173/AKrbkfRcELOln5
	vUI7gplB3AiaJtzC4+ZHa4r2/A==
X-Google-Smtp-Source: APXvYqxyH2lm/fogXtpK3bsS+Au0kvjIwuk8eQfhakM9r2dOKPKR+UFhrZ/qW0kZyOaxJakoZDInag==
X-Received: by 2002:a17:906:2282:: with SMTP id
	p2mr6344456eja.283.1556892372220; 
	Fri, 03 May 2019 07:06:12 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.06.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 03 May 2019 07:06:11 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v6 3/3] PCI: iproc: Add sorted dma ranges resource entries to
	host bridge
Date: Fri,  3 May 2019 19:35:34 +0530
Message-Id: <1556892334-16270-4-git-send-email-srinath.mannam@broadcom.com>
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

The IPROC host controller allows only a subset of physical address space
as target of inbound PCI memory transactions addresses.

PCIe devices memory transactions targeting memory regions that
are not allowed for inbound transactions in the host controller
are rejected by the host controller and cannot reach the upstream
buses.

Firmware device tree description defines the DMA ranges that are
addressable by devices DMA transactions; parse the device tree
dma-ranges property and add its ranges to the PCI host bridge dma_ranges
list; the iova_reserve_pci_windows() call in the driver will reserve the
IOVA address ranges that are not addressable (ie memory holes in the
dma-ranges set) so that they are not allocated to PCI devices for DMA
transfers.

All allowed address ranges are listed in dma-ranges DT parameter.

Example:

dma-ranges = < \
  0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
  0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
  0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>

In the above example of dma-ranges, memory address from

0x0 - 0x80000000,
0x100000000 - 0x800000000,
0x1000000000 - 0x8000000000 and
0x10000000000 - 0xffffffffffffffff.

are not allowed to be used as inbound addresses.

Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..94ba5c0 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
+static int
+iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
+			 struct of_pci_range *range)
+{
+	struct resource *res;
+	struct resource_entry *entry, *tmp;
+	struct list_head *head = resources;
+
+	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	resource_list_for_each_entry(tmp, resources) {
+		if (tmp->res->start < range->cpu_addr)
+			head = &tmp->node;
+	}
+
+	res->start = range->cpu_addr;
+	res->end = res->start + range->size - 1;
+
+	entry = resource_list_create_entry(res, 0);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->offset = res->start - range->cpu_addr;
+	resource_list_add(entry, head);
+
+	return 0;
+}
+
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	int ret;
+	LIST_HEAD(resources);
 
 	/* Get the dma-ranges from DT */
 	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
@@ -1158,13 +1190,23 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 		return ret;
 
 	for_each_of_pci_range(&parser, &range) {
+		ret = iproc_pcie_add_dma_range(pcie->dev,
+					       &resources,
+					       &range);
+		if (ret)
+			goto out;
 		/* Each range entry corresponds to an inbound mapping region */
 		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
+	list_splice_init(&resources, &host->dma_ranges);
+
 	return 0;
+out:
+	pci_free_resource_list(&resources);
+	return ret;
 }
 
 static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
