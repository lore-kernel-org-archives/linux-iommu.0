Return-Path: <SRS0=mSd7=HI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B30EC433DB
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 03:35:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1397764FB5
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 03:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1397764FB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2FB387349;
	Sat,  6 Feb 2021 03:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNvvzx5pm3zA; Sat,  6 Feb 2021 03:35:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E0E5C872ED;
	Sat,  6 Feb 2021 03:35:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A699BC1DA9;
	Sat,  6 Feb 2021 03:35:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E157FC013A
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE00D873CC
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MiU66e20He3H for <iommu@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 03:35:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 453FA873D0
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:13 +0000 (UTC)
IronPort-SDR: mV9pi+aPkQKVYokF8M0j37XMjqqxOFfYW9GrwJ9kAzURCc3RUzzi6lr3Gatzbu1dK1LCKd2meS
 6t4iPzDtg3Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200534598"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; d="scan'208";a="200534598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 19:35:12 -0800
IronPort-SDR: 0qE1iklm5499/PHoudltYrlZb4ao/ad9XsB/5jIWStBtflQTvNvopNwjnl5WaWaU4aiwohds40
 8DfAksmlpIfg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; d="scan'208";a="576921853"
Received: from rgrover1-mobl.amr.corp.intel.com (HELO
 jderrick-mobl.amr.corp.intel.com) ([10.209.102.94])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 19:35:12 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH v3 1/2] iommu/vt-d: Use Real PCI DMA device for IRTE
Date: Fri,  5 Feb 2021 20:35:01 -0700
Message-Id: <20210206033502.103964-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206033502.103964-1-jonathan.derrick@intel.com>
References: <20210206033502.103964-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Cc: Nirmal Patel <nirmal.patel@intel.com>,
 Kapil Karkra <kapil.karkra@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Jon Derrick <jonathan.derrick@intel.com>
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

VMD retransmits child device MSI-X with the VMD endpoint's requester-id.
In order to support direct interrupt remapping of VMD child devices,
ensure that the IRTE is programmed with the VMD endpoint's requester-id
using pci_real_dma_dev().

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
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
