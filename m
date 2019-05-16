Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33739C04E84
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 08:47:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106E1205C9
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 08:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106E1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DB036C3A;
	Thu, 16 May 2019 08:47:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C387ABA9
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 08:47:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 72587878
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 08:47:53 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA5E159464;
	Thu, 16 May 2019 08:47:52 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4BC5778558;
	Thu, 16 May 2019 08:47:38 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	dwmw2@infradead.org, lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
	will.deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Subject: [PATCH v2 3/7] iommu/vt-d: Introduce is_downstream_to_pci_bridge
	helper
Date: Thu, 16 May 2019 10:47:16 +0200
Message-Id: <20190516084720.10498-4-eric.auger@redhat.com>
In-Reply-To: <20190516084720.10498-1-eric.auger@redhat.com>
References: <20190516084720.10498-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 16 May 2019 08:47:53 +0000 (UTC)
Cc: alex.williamson@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Several call sites are about to check whether a device belongs
to the PCI sub-hierarchy of a candidate PCI-PCI bridge.
Introduce an helper to perform that check.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 590a0e78d11d..15c2f9677491 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -736,12 +736,39 @@ static int iommu_dummy(struct device *dev)
 	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
 }
 
+/* is_downstream_to_pci_bridge - test if a device belongs to the
+ * PCI sub-hierarchy of a candidate PCI-PCI bridge
+ *
+ * @dev: candidate PCI device belonging to @bridge PCI sub-hierarchy
+ * @bridge: the candidate PCI-PCI bridge
+ *
+ * Return: true if @dev belongs to @bridge PCI sub-hierarchy
+ */
+static bool
+is_downstream_to_pci_bridge(struct device *dev, struct device *bridge)
+{
+	struct pci_dev *pdev, *pbridge;
+
+	if (!dev_is_pci(dev) || !dev_is_pci(bridge))
+		return false;
+
+	pdev = to_pci_dev(dev);
+	pbridge = to_pci_dev(bridge);
+
+	if (pbridge->subordinate &&
+	    pbridge->subordinate->number <= pdev->bus->number &&
+	    pbridge->subordinate->busn_res.end >= pdev->bus->number)
+		return true;
+
+	return false;
+}
+
 static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
 	struct intel_iommu *iommu;
 	struct device *tmp;
-	struct pci_dev *ptmp, *pdev = NULL;
+	struct pci_dev *pdev = NULL;
 	u16 segment = 0;
 	int i;
 
@@ -787,13 +814,7 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 				goto out;
 			}
 
-			if (!pdev || !dev_is_pci(tmp))
-				continue;
-
-			ptmp = to_pci_dev(tmp);
-			if (ptmp->subordinate &&
-			    ptmp->subordinate->number <= pdev->bus->number &&
-			    ptmp->subordinate->busn_res.end >= pdev->bus->number)
+			if (is_downstream_to_pci_bridge(dev, tmp))
 				goto got_pdev;
 		}
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
