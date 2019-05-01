Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10CFC43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:37:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93C32081C
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cUf6xcDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93C32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BCD6A2B49;
	Wed,  1 May 2019 17:37:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 624E42780
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:37:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BAC78711
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:37:17 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id a6so15531491edv.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 01 May 2019 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Ax6W8oR/LKpnpvm9+BdZQ4COcLSu6HmYx3pNJLAuU8g=;
	b=cUf6xcDZO0zeRRKPcX3zT3wtCPz/pkDZyrdTIv5OoPwwCqQWBtRWEufz5txdgRE06Q
	zj/lKfg5dR/zrATFrE2bQiz90VYSyN6rtEXj+S9iUvmNqC1gw5OaIspwgjQmGUMxj0FT
	pXwWJD6kXv+h0ZCVEciD4DUaiWD8v/2kQFGF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Ax6W8oR/LKpnpvm9+BdZQ4COcLSu6HmYx3pNJLAuU8g=;
	b=T5Y6s4zIJGPVTrNsqmu4vUKY82gKeW892ol4yn5XXKR7elKL1qw80RA0HSL/TrpQ03
	gpTg0ZNVR1gr/M2hacrC6r9ogdBIY2enFv3gURh2a5fA2B0rHqRuUk7sFiE4mtd4YUwh
	CxURKhVDvo3QKm4DfYojcmzlKWp/8Zg+/f8SMEBO68ojhRGQ1xWd/SZb4r047HnbqH6Q
	uat1tNh1yRMVfMdxP4oPCoUAYJrjHnyO9Ck97B52gJ/cK8p/eyeLydoF5OcZRLSud49b
	5TlsfVCdgdbs/ILiFK2mDfKNihBRzO/yIPE/NLm5wmF2zH96aaM+XWGskPybiz218qzG
	LIXw==
X-Gm-Message-State: APjAAAVIzK9kQ/Cpt07CqfeohQwBLxZa8ERzhrgfmA3SCdV7XT+7tfOW
	gPE/OHbE8Qhui5f7kq00koK26g==
X-Google-Smtp-Source: APXvYqxvTmdFByFxL1w4pHspctPX+YRxQcowPlRPGwXZlaSHhqy7ThNL9K/rQTMfCpMDUxaJgeL6sg==
X-Received: by 2002:a50:a389:: with SMTP id s9mr10033513edb.113.1556732236330; 
	Wed, 01 May 2019 10:37:16 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id s6sm2462671eji.13.2019.05.01.10.37.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 01 May 2019 10:37:15 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Eric Auger <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v5 3/3] PCI: iproc: Add sorted dma ranges resource entries to
	host bridge
Date: Wed,  1 May 2019 23:06:26 +0530
Message-Id: <1556732186-21630-4-git-send-email-srinath.mannam@broadcom.com>
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
Message-ID: <20190501173626.t1oU0Q_GFbaYeUu055a14EHWC_vz2c9CiVzX4Ohq_50@z>

IPROC host has the limitation that it can use only those address ranges
given by dma-ranges property as inbound address. So that the memory
address holes in dma-ranges should be reserved to allocate as DMA address.

Inbound address of host accessed by PCIe devices will not be translated
before it comes to IOMMU or directly to PE. But the limitation of this
host is, access to few address ranges are ignored. So that IOVA ranges
for these address ranges have to be reserved.

All allowed address ranges are listed in dma-ranges DT parameter. These
address ranges are converted as resource entries and listed in sorted
order and added to dma_ranges list of PCI host bridge structure.

Ex:
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

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
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
