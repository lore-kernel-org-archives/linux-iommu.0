Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE15DC282E1
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 12:31:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944A820811
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 12:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944A820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7BB01FD8;
	Wed, 24 Apr 2019 12:31:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 393C6FCF
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:31:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B298A82B
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:31:02 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Apr 2019 05:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; d="scan'208";a="167475678"
Received: from yiliu-dev.bj.intel.com ([10.238.156.125])
	by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2019 05:30:59 -0700
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	kwankhede@nvidia.com
Subject: [RFC v3 2/3] vfio/pci: protect cap/ecap_perm bits alloc/free with
	atomic op
Date: Tue, 23 Apr 2019 20:14:39 +0800
Message-Id: <1556021680-2911-3-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556021680-2911-1-git-send-email-yi.l.liu@intel.com>
References: <1556021680-2911-1-git-send-email-yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, kvm@vger.kernel.org,
	Liu@mail.linuxfoundation.org, jean-philippe.brucker@arm.com,
	linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
	yi.y.sun@intel.com, iommu@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423121439.rsCelFI6Gz2cQcMvqmFlncmlURLVBDq5OBYF4oG4gP4@z>

There is a case in which cap_perms and ecap_perms can be reallocated
by different modules. e.g. the vfio-mdev-pci sample driver. To secure
the initialization of cap_perms and ecap_perms, this patch adds an
atomic variable to track the user of cap/ecap_perms bits. First caller
of vfio_pci_init_perm_bits() will initialize the bits. While the last
caller of vfio_pci_uninit_perm_bits() will free the bits.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index e82b511..913fca6 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -996,11 +996,17 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
 	return 0;
 }
 
+/* Track the user number of the cap/ecap perm_bits */
+atomic_t vfio_pci_perm_bits_users = ATOMIC_INIT(0);
+
 /*
  * Initialize the shared permission tables
  */
 void vfio_pci_uninit_perm_bits(void)
 {
+	if (atomic_dec_return(&vfio_pci_perm_bits_users))
+		return;
+
 	free_perm_bits(&cap_perms[PCI_CAP_ID_BASIC]);
 
 	free_perm_bits(&cap_perms[PCI_CAP_ID_PM]);
@@ -1017,6 +1023,9 @@ int __init vfio_pci_init_perm_bits(void)
 {
 	int ret;
 
+	if (atomic_inc_return(&vfio_pci_perm_bits_users) != 1)
+		return 0;
+
 	/* Basic config space */
 	ret = init_pci_cap_basic_perm(&cap_perms[PCI_CAP_ID_BASIC]);
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
