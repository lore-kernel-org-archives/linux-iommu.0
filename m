Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EA2C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7EA64F65
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7EA64F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6EBA32034F;
	Thu,  4 Feb 2021 19:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lS13e8nuwrvz; Thu,  4 Feb 2021 19:09:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B93092043E;
	Thu,  4 Feb 2021 19:09:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3E9AC0174;
	Thu,  4 Feb 2021 19:09:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D8BC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DABF9204C6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIn4Wis3CT4r for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 19:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 1D1322034F
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:24 +0000 (UTC)
IronPort-SDR: MiyGeN+D6kn9Le7BVrXba05tfUcML6ihgJ654KmXM8TNF27PELDGwZSA2tTgAKVHM8owJc6ekQ
 EhMdVHom8zKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181377661"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="181377661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 11:09:23 -0800
IronPort-SDR: w0atSNMjsRFsy4Ai8n7QIQ836ydnbir2pqCTllgrKm/NZlsqJ4GYxh3J91sf2CDZ84DDCYr88w
 FTJCJe5k81Wg==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="434070462"
Received: from sgklier-mobl1.amr.corp.intel.com (HELO
 jderrick-mobl.amr.corp.intel.com) ([10.212.165.190])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 11:09:21 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH v2 0/2] VMD MSI Remapping Bypass
Date: Thu,  4 Feb 2021 12:09:04 -0700
Message-Id: <20210204190906.38515-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Nirmal Patel <nirmal.patel@intel.com>, Will Deacon <will@kernel.org>,
 Kapil Karkra <kapil.karkra@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jon Derrick <jonathan.derrick@intel.com>
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

The Intel Volume Management Device acts similar to a PCI-to-PCI bridge in that
it changes downstream devices' requester-ids to its own. As VMD supports PCIe
devices, it has its own MSI/X table and transmits child device MSI/X by
remapping child device MSI/X and handling like a demultiplexer.

Some newer VMD devices (Icelake Server) have an option to bypass the VMD MSI/X
remapping table. This allows for better performance scaling as the child device
MSI/X won't be limited by VMD's MSI/X count and IRQ handler.

V1->V2:
Updated for 5.12-next
Moved IRQ allocation and remapping enable/disable to a more logical location

V1 patches 1-4 were already merged
V1, 5/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-6-jonathan.derrick@intel.com/
V1, 6/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-7-jonathan.derrick@intel.com/

Jon Derrick (2):
  iommu/vt-d: Use Real PCI DMA device for IRTE
  PCI: vmd: Disable MSI/X remapping when possible

 drivers/iommu/intel/irq_remapping.c |  3 +-
 drivers/pci/controller/vmd.c        | 60 +++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
