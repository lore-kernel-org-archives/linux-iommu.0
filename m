Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDCAC433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 12:37:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E204564F58
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 12:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E204564F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A28994EFEF;
	Tue,  2 Mar 2021 12:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkblMJ7xV5Sw; Tue,  2 Mar 2021 12:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AFE04EFCF;
	Tue,  2 Mar 2021 12:37:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18F8FC000A;
	Tue,  2 Mar 2021 12:37:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B7CC0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84ADE83F41
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b69_NrYYTW2F for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 12:37:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A19A483F38
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:26 +0000 (UTC)
IronPort-SDR: I6tRkML9hQPIQe4LyK0JakUaXp8QlT7LTjh+Yvj0KuKSehlsBESCdjzDCIkz2BSTdOkSJDG1we
 IlHKr6fMvMIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="166675186"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="166675186"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 04:37:26 -0800
IronPort-SDR: SiVWC1hBDnXOmK0yf7bdE8OvzswRGXxFNQeTNq1QeScTJPrcHDSXsbsvgXASTpVesl11kamvEL
 olmx3W8ar+bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="427472166"
Received: from yiliu-dev.bj.intel.com (HELO dual-ub.bj.intel.com)
 ([10.238.156.135])
 by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 04:37:21 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [Patch v8 08/10] vfio/pci: Expose PCIe PASID capability to userspace
Date: Wed,  3 Mar 2021 04:35:43 +0800
Message-Id: <20210302203545.436623-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302203545.436623-1-yi.l.liu@intel.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, vivek.gautam@arm.com, yi.y.sun@intel.com,
 jgg@nvidia.com, Lingshan.Zhu@intel.com, jasowang@redhat.com, hao.wu@intel.com
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

This patch exposes PCIe PASID capability to userspace and where to
emulate this capability if wants to further expose it to VM.

And this patch only exposes PASID capability for devices which has PCIe
PASID extended struture in its configuration space. While for VFs, user
space still unable to see this capability as SR-IOV spec forbides VF to
implement PASID capability extended structure. It is a TODO in future.
Related discussion can be found in below link:

https://lore.kernel.org/kvm/20200407095801.648b1371@w520.home/

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
v7 -> v8:
*) refine the commit message and the subject.

v5 -> v6:
*) add review-by from Eric Auger.

v1 -> v2:
*) added in v2, but it was sent in a separate patchseries before
---
 drivers/vfio/pci/vfio_pci_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a402adee8a21..95b5478f51ac 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -95,7 +95,7 @@ static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
 	[PCI_EXT_CAP_ID_LTR]	=	PCI_EXT_CAP_LTR_SIZEOF,
 	[PCI_EXT_CAP_ID_SECPCI]	=	0,	/* not yet */
 	[PCI_EXT_CAP_ID_PMUX]	=	0,	/* not yet */
-	[PCI_EXT_CAP_ID_PASID]	=	0,	/* not yet */
+	[PCI_EXT_CAP_ID_PASID]	=	PCI_EXT_CAP_PASID_SIZEOF,
 };
 
 /*
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
