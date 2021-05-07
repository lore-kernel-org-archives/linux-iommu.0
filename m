Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C68C43461
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 12:50:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10E56143F
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 12:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10E56143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A4124069A;
	Fri,  7 May 2021 12:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qfdo8G3EK7g7; Fri,  7 May 2021 12:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6555E40692;
	Fri,  7 May 2021 12:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52DBCC000D;
	Fri,  7 May 2021 12:50:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 330DDC0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 12:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1621D607B2
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 12:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ddYr5pcFh9w for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 12:50:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37E97606D3
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 12:50:09 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc9F52jrqzqTDj;
 Fri,  7 May 2021 20:46:49 +0800 (CST)
Received: from huawei.com (10.174.185.226) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 7 May 2021
 20:50:00 +0800
From: Wang Xingang <wangxingang5@huawei.com>
To: <will@kernel.org>, <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/of: Fix request and enable ACS for
 of_iommu_configure
Date: Fri, 7 May 2021 12:49:53 +0000
Message-ID: <1620391793-18744-2-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1620391793-18744-1-git-send-email-wangxingang5@huawei.com>
References: <1620391793-18744-1-git-send-email-wangxingang5@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, wangxingang5@huawei.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com
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

From: Xingang Wang <wangxingang5@huawei.com>

When request ACS for PCI device in of_iommu_configure, the pci device
has already been scanned and added with 'pci_acs_enable=0'. So the
pci_request_acs() in current procedure does not work for enabling ACS.
Besides, the ACS should be enabled only if there's an IOMMU in system.
So this fix the call of pci_request_acs() and call pci_enable_acs() to
make sure ACS is enabled for the pci_device.

Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
configuring IOMMU linkage")
Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
---
 drivers/iommu/of_iommu.c | 10 +++++++++-
 drivers/pci/pci.c        |  2 +-
 include/linux/pci.h      |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a9d2df001149..dc621861ae72 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			.np = master_np,
 		};
 
-		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else {
@@ -222,6 +221,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		/* The fwspec pointer changed, read it again */
 		fwspec = dev_iommu_fwspec_get(dev);
 		ops    = fwspec->ops;
+
+		/*
+		 * If we found an IOMMU and the device is pci,
+		 * make sure we enable ACS.
+		 */
+		if (dev_is_pci(dev)) {
+			pci_request_acs();
+			pci_enable_acs(to_pci_dev(dev));
+		}
 	}
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..4e4f98ee2870 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -926,7 +926,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-static void pci_enable_acs(struct pci_dev *dev)
+void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59a57..e6a8bfbc9c98 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2223,6 +2223,7 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 }
 
 void pci_request_acs(void);
+void pci_enable_acs(struct pci_dev *dev);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
 			  struct pci_dev *end, u16 acs_flags);
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
