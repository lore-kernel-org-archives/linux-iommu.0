Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047FEC47404
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:46:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C282190F
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAQZDCIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C282190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 77D92DA6;
	Wed,  9 Oct 2019 22:46:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 69B15BDC
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:46:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 263F214D
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:46:35 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7882920B7C;
	Wed,  9 Oct 2019 22:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570661194;
	bh=X4MnfuIslLW8blcOn4yQwQq8QlC4Uf+as3cLP18fUQI=;
	h=From:To:Cc:Subject:Date:From;
	b=YAQZDCIMKr0xvp1BCRV8R3czGYmhTwPYvtPlXjdmDagf29hifU2QtsQOGvEkD/Yf0
	BvdjTgSXdPoCd9eUT91GNFqh8p5vmX+6Yj4S49nyuXpDoE3IdlwcozlNUgF2OJi8Id
	TikkS8ndWH0JWv2gbWpMTfJk6adpqFpp5mhOnFv8=
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/2] iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
Date: Wed,  9 Oct 2019 17:45:49 -0500
Message-Id: <20191009224551.179497-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>
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

From: Bjorn Helgaas <bhelgaas@google.com>

I think intel-iommu.c depends on CONFIG_AMD_IOMMU in an undesirable way:

When CONFIG_INTEL_IOMMU_SVM=y, iommu_enable_dev_iotlb() calls PRI
interfaces (pci_reset_pri() and pci_enable_pri()), but those are only
implemented when CONFIG_PCI_PRI is enabled.  If CONFIG_PCI_PRI is not
enabled, there are stubs that just return failure.

The INTEL_IOMMU_SVM Kconfig does nothing with PCI_PRI, but AMD_IOMMU
selects PCI_PRI.  So if AMD_IOMMU is enabled, intel-iommu.c gets the full
PRI interfaces.  If AMD_IOMMU is not enabled, it gets the PRI stubs.

This seems wrong.  The first patch here makes INTEL_IOMMU_SVM select
PCI_PRI so intel-iommu.c always gets the full PRI interfaces.

The second patch moves pci_prg_resp_pasid_required(), which simply returns
a bit from the PCI capability, from #ifdef CONFIG_PCI_PASID to #ifdef
CONFIG_PCI_PRI.  This is related because INTEL_IOMMU_SVM already *does*
select PCI_PASID, so it previously always got pci_prg_resp_pasid_required()
even though it got stubs for other PRI things.

Since these are related and I have several follow-on ATS-related patches in
the queue, I'd like to take these both via the PCI tree.

Bjorn Helgaas (2):
  iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
  PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI

 drivers/iommu/Kconfig   |  1 +
 drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
 include/linux/pci-ats.h | 11 ++++-----
 3 files changed, 31 insertions(+), 36 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
