Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205CBC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF80464F65
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF80464F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 96854274EE;
	Thu,  4 Feb 2021 19:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JEgW5G6aQGaw; Thu,  4 Feb 2021 19:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E0AF52043E;
	Thu,  4 Feb 2021 19:09:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE077C0174;
	Thu,  4 Feb 2021 19:09:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B919FC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A09DD2034F
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFhY+9CdtnPt for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 19:09:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 4C51A2043E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:25 +0000 (UTC)
IronPort-SDR: +/DIMwg+Qv6cKNGzCSwgknI1fgj+gAp7X7pRm2K8jyS2cce4d72l6JDn6XIROsu1kps8fWBZfU
 f/t+S4hdRMyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181377669"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="181377669"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 11:09:25 -0800
IronPort-SDR: cSP9LJxWRBz7I+yTpMlbQgvzji88bvziFq5UlYJ7uBXK1NOigBGTKnr1rEyV/k3vVzakXpIGAS
 jCR1V51rpIZw==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="434070474"
Received: from sgklier-mobl1.amr.corp.intel.com (HELO
 jderrick-mobl.amr.corp.intel.com) ([10.212.165.190])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 11:09:23 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH v2 1/2] iommu/vt-d: Use Real PCI DMA device for IRTE
Date: Thu,  4 Feb 2021 12:09:05 -0700
Message-Id: <20210204190906.38515-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210204190906.38515-1-jonathan.derrick@intel.com>
References: <20210204190906.38515-1-jonathan.derrick@intel.com>
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

VMD retransmits child device MSI/X with the VMD endpoint's requester-id.
In order to support direct interrupt remapping of VMD child devices,
ensure that the IRTE is programmed with the VMD endpoint's requester-id
using pci_real_dma_dev().

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 685200a5cff0..1939e070eec8 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1276,7 +1276,8 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 		break;
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
+		set_msi_sid(irte,
+			    pci_real_dma_dev(msi_desc_to_pci_dev(info->desc)));
 		break;
 	default:
 		BUG_ON(1);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
