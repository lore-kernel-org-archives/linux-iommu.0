Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F36DC433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 00:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88AD041ECB;
	Fri, 18 Feb 2022 00:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsPQ5zlIxEgz; Fri, 18 Feb 2022 00:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C990440A13;
	Fri, 18 Feb 2022 00:58:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DF44C0011;
	Fri, 18 Feb 2022 00:58:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4B81C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AC0041EBE
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kD5KARmDL7ey for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 00:57:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D3C040A13
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645145877; x=1676681877;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f6wc9OlSg4rQokL1ZkwL4XG3KnhfZB89/WTbGAYuHAc=;
 b=MWrAoK14nVfTLr8A+xobFnmBu2pU95d+y3tm9VZp9XJMgn+uergRXxoZ
 lmbE0WlqDZAPjpqhQti83Alw5s8vdwiPkdrbzf0d4liGhLiSeCKaC5ejI
 GNk6IB4s5GG+xQwkzsFrGnFjSdvRh3qQi3TBGAEK4xLKPtGKny4siTKaA
 lSi1gme4l0ILDP23u/v3CdEGVMjlhzGUIOBlIPW4UkE/tee94BcF+rCA3
 PzwpRWjI7/GW9URHAtuNQML11FN5y2J9rj9CnNvwiECLaowXR05CIkhtn
 ZIAs34+/rqa4vJ7p/GVqEXSpdX0JGAzLnASlO4NxbDGrMrzDsiQ+XCRBd A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234548567"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="234548567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 16:57:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="637491059"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 16:57:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v6 05/11] PCI: pci_stub: Set driver_managed_dma
Date: Fri, 18 Feb 2022 08:55:15 +0800
Message-Id: <20220218005521.172832-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218005521.172832-1-baolu.lu@linux.intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
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

The current VFIO implementation allows pci-stub driver to be bound to
a PCI device with other devices in the same IOMMU group being assigned
to userspace. The pci-stub driver has no dependencies on DMA or the
IOVA mapping of the device, but it does prevent the user from having
direct access to the device, which is useful in some circumstances.

The pci_dma_configure() marks the iommu_group as containing only devices
with kernel drivers that manage DMA. For compatibility with the VFIO
usage, avoid this default behavior for the pci_stub. This allows the
pci_stub still able to be used by the admin to block driver binding after
applying the DMA ownership to VFIO.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/pci/pci-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index e408099fea52..d1f4c1ce7bd1 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -36,6 +36,7 @@ static struct pci_driver stub_driver = {
 	.name		= "pci-stub",
 	.id_table	= NULL,	/* only dynamic id's */
 	.probe		= pci_stub_probe,
+	.driver_managed_dma = true,
 };
 
 static int __init pci_stub_init(void)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
