Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3917CC10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 15:22:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAC3206DF
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 15:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAC3206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BE97A1A83;
	Wed, 10 Apr 2019 15:22:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 95F3919F4
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 15:22:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4873A7A6
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 15:22:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13FD2374;
	Wed, 10 Apr 2019 08:22:36 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C93D3F59C; 
	Wed, 10 Apr 2019 08:22:35 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: joro@8bytes.org
Subject: [PATCH] iommu/amd: Use pci_prg_resp_pasid_required()
Date: Wed, 10 Apr 2019 16:21:08 +0100
Message-Id: <20190410152108.48037-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410152108.1RyKV3ou8WAl5wof_X0KvYljgO6I98rPEp83goHZ1hg@z>

Commit e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
interface.") added a common interface to check the PASID bit in the PRI
capability. Use it in the AMD driver.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/amd_iommu.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..7a0de274934c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2122,23 +2122,6 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 	return ret;
 }
 
-/* FIXME: Move this to PCI code */
-#define PCI_PRI_TLP_OFF		(1 << 15)
-
-static bool pci_pri_tlp_required(struct pci_dev *pdev)
-{
-	u16 status;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return false;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
-
-	return (status & PCI_PRI_TLP_OFF) ? true : false;
-}
-
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -2167,7 +2150,7 @@ static int attach_device(struct device *dev,
 
 			dev_data->ats.enabled = true;
 			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
-			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
+			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
 		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
