Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1C1C433FE
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 01:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 441794060F;
	Tue,  4 Jan 2022 01:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t95v0kGCRzq4; Tue,  4 Jan 2022 01:58:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 09534402DC;
	Tue,  4 Jan 2022 01:58:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8D0EC0030;
	Tue,  4 Jan 2022 01:58:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11591C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2DB260AB1
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KHq1MPcqOP7R for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 01:58:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A597060E5B
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641261502; x=1672797502;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u2axiupT5cFi8yGZ7MA25zz/IgKwQEY9ZFFr/KlSioY=;
 b=PJyyLdvElz0VA7O2FO8LwVq33RgZxdNjzC/rEVrRxSSfOWNIeuZ9unk6
 NWVlvEBh03VJYhIdUCl+5BT0IWVFkJspGVKq9kJJEXkCzu9KfGARDFYTV
 ms1AAhx8he6UmFnKcKHnlVbM3c8eDdVpnoDjaRk2nm1JIJFa5hfqpc/3f
 9bVibDykLAW5o3UmQ2TGVz+PglMHi//yhQ127OwOuudU/6VUrkyhBc5ST
 ufGIWysAfEPSlciIVJsISuOrwrheamDRpi9YCasL4cGvG7YssFZLONaGD
 GQ9sb6BHlULvBOHbRi6tR/gkh648XPjVGPINdjtYdxwxaSgawIP64kxZm A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="302893833"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="302893833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2022 17:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="667573290"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2022 17:58:15 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v5 08/14] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
Date: Tue,  4 Jan 2022 09:56:38 +0800
Message-Id: <20220104015644.2294354-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

The pci_dma_configure() marks the iommu_group as containing only devices
with kernel drivers that manage DMA. Avoid this default behavior for the
pci_stub because it does not program any DMA itself.  This allows the
pci_stub still able to be used by the admin to block driver binding after
applying the DMA ownership to vfio.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/pci/pci-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index e408099fea52..1f4c0a58b819 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -36,6 +36,7 @@ static struct pci_driver stub_driver = {
 	.name		= "pci-stub",
 	.id_table	= NULL,	/* only dynamic id's */
 	.probe		= pci_stub_probe,
+	.no_kernel_api_dma = true,
 };
 
 static int __init pci_stub_init(void)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
