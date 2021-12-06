Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3519FC433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E94BF408EC;
	Mon,  6 Dec 2021 22:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7__3cqMV1gIR; Mon,  6 Dec 2021 22:39:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E576E40469;
	Mon,  6 Dec 2021 22:39:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3A77C001E;
	Mon,  6 Dec 2021 22:39:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BE70C001E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0AFE641C62
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPrE0YOUOnZS for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D96E41C5D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:30 +0000 (UTC)
Message-ID: <20211206210438.742297272@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=W2lCRcP9RIug8p7Jz6C0/K2R924e9P+4OVHLDtbDEY4=;
 b=NAItHuLmL2ZcCfnzc7fXrckrfGRBHJLTQ6z+8GQi+pDtw3TJzWlrZdzM68dhy4eE1OUrN4
 WQpDNI30CiepjXFq3GVRqOgL6lbHugqbiK1cgKeYZQQlmp0QNv6K3/G1f9qICr1H7udj02
 IL3YCTHnXu0Nc9n7X5/vnjZpUzoBt0BVJmug9p6XoFHASymZZCX8NBeLxW7a+KomP2zscN
 Yw4oyjCuV9LJAUYax/vCmkxmlobmILYr9Kaz4DUGkfdOhTY2fy7moleVn4aZ55FimhJjry
 KhYtaopElknezT4DQ1+BGYb8QpKLSmpd8RvSeJ/uyfPSLa3v/+iGr3ib39VvMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=W2lCRcP9RIug8p7Jz6C0/K2R924e9P+4OVHLDtbDEY4=;
 b=1Bo7ypMWpOuT+BmW7TSVzw6bj18E4LKNZBSZWEJqZFWNgSmXB22SiYHDMtnKsfQTyHA/Yy
 OLurUGAL5gX1tZAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 20/36] x86/pci/XEN: Use device MSI properties
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:28 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/x86/pci/xen.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -399,9 +399,7 @@ static void xen_teardown_msi_irqs(struct
 
 static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
 {
-	struct msi_desc *msidesc = first_pci_msi_entry(dev);
-
-	if (msidesc->pci.msi_attrib.is_msix)
+	if (msi_device_has_property(&dev->dev, MSI_PROP_PCI_MSIX))
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
@@ -417,7 +415,7 @@ static int xen_msi_domain_alloc_irqs(str
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return -EINVAL;
 
-	if (first_msi_entry(dev)->pci.msi_attrib.is_msix)
+	if (msi_device_has_property(dev, MSI_PROP_PCI_MSIX))
 		type = PCI_CAP_ID_MSIX;
 	else
 		type = PCI_CAP_ID_MSI;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
