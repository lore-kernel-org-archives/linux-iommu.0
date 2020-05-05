Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418A3C47257
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 04:42:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D88206FA
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 04:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D88206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CFF5422803;
	Tue,  5 May 2020 04:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cudTfiNU1Ky; Tue,  5 May 2020 04:42:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D05D02049C;
	Tue,  5 May 2020 04:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4B88C088C;
	Tue,  5 May 2020 04:42:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E19B0C0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 04:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C9BDC86B65
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 04:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H7DBAGkZN03M for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 04:42:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CDD7486AA5
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 04:42:24 +0000 (UTC)
IronPort-SDR: 7/8VMJqjA8AxlywDpv96JcOyHezoRXmzA26jS6XEnxZ1ADqi49yKFJwXhjMzXlCTC8hHksIjFv
 Cht43azfAu8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2020 21:42:24 -0700
IronPort-SDR: 2vIZbgyyOTKoUofCWTRr5FoIBJMndkLa8KAwbvQPrJky7jEpaWFyNCw9V4ILMLpIlc09XkNhVE
 kNVSTqXkB9xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; d="scan'208";a="369299546"
Received: from otc-nc-03.jf.intel.com ([10.54.39.25])
 by fmsmga001.fm.intel.com with ESMTP; 04 May 2020 21:42:23 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Date: Mon,  4 May 2020 21:42:16 -0700
Message-Id: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Ashok Raj <ashok.raj@intel.com>, Darrel Goeddel <DGoeddel@forcepoint.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Scott <mscott@forcepoint.com>,
 Romil Sharma <rsharma@forcepoint.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PCIe Spec recommends we can relax ACS requirement for RCIEP devices.

PCIe 5.0 Specification.
6.12 Access Control Services (ACS)
Implementation of ACS in RCiEPs is permitted but not required. It is
explicitly permitted that, within a single Root Complex, some RCiEPs
implement ACS and some do not. It is strongly recommended that Root Complex
implementations ensure that all accesses originating from RCiEPs
(PFs and VFs) without ACS capability are first subjected to processing by
the Translation Agent (TA) in the Root Complex before further decoding and
processing. The details of such Root Complex handling are outside the scope
of this specification.

Since Linux didn't give special treatment to allow this exception, certain
RCiEP MFD devices are getting grouped in a single iommu group. This
doesn't permit a single device to be assigned to a guest for instance.

In one vendor system: Device 14.x were grouped in a single IOMMU group.

/sys/kernel/iommu_groups/5/devices/0000:00:14.0
/sys/kernel/iommu_groups/5/devices/0000:00:14.2
/sys/kernel/iommu_groups/5/devices/0000:00:14.3

After the patch:
/sys/kernel/iommu_groups/5/devices/0000:00:14.0
/sys/kernel/iommu_groups/5/devices/0000:00:14.2
/sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group

14.0 and 14.2 are integrated devices, but legacy end points.
Whereas 14.3 was a PCIe compliant RCiEP.

00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00

This permits assigning this device to a guest VM.

Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
Cc: Mark Scott <mscott@forcepoint.com>,
Cc: Romil Sharma <rsharma@forcepoint.com>
Cc: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c..5744bd65f3e2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1187,7 +1187,20 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 	struct pci_dev *tmp = NULL;
 	struct iommu_group *group;
 
-	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
+	/*
+	 * PCI Spec 5.0, Section 6.12 Access Control Service
+	 * Implementation of ACS in RCiEPs is permitted but not required.
+	 * It is explicitly permitted that, within a single Root
+	 * Complex, some RCiEPs implement ACS and some do not. It is
+	 * strongly recommended that Root Complex implementations ensure
+	 * that all accesses originating from RCiEPs (PFs and VFs) without
+	 * ACS capability are first subjected to processing by the Translation
+	 * Agent (TA) in the Root Complex before further decoding and
+	 * processing.
+	 */
+	if (!pdev->multifunction ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) ||
+	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
 		return NULL;
 
 	for_each_pci_dev(tmp) {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
