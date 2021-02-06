Return-Path: <SRS0=mSd7=HI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7B7C433E0
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 03:35:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D025F61606
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 03:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D025F61606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1EAA4203D8;
	Sat,  6 Feb 2021 03:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fptGD5PNjZq0; Sat,  6 Feb 2021 03:35:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5A032203D7;
	Sat,  6 Feb 2021 03:35:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DB58C08A1;
	Sat,  6 Feb 2021 03:35:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BC5FC013A
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 15B18873D1
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bzig40wTffT1 for <iommu@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 03:35:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1F321873CC
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:13 +0000 (UTC)
IronPort-SDR: GvMiLWkP65R2UFLGfMWnddA1KKiYWoR64Y8qYdQRLS2V0+Wu2AyNmBW0vFylM0xmWhAMdj+iZp
 /4raBQBNuwEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200534596"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; d="scan'208";a="200534596"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 19:35:12 -0800
IronPort-SDR: 45plgOWjxXoSgKZ9Lpg7N2xYOHrLJi70ic3mz6JaGwYXS/VqsjjaF0RNTPqylM1PCpbcdD7klB
 9PpKCz63cI2g==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; d="scan'208";a="576921846"
Received: from rgrover1-mobl.amr.corp.intel.com (HELO
 jderrick-mobl.amr.corp.intel.com) ([10.209.102.94])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 19:35:11 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH v3 0/2] VMD MSI Remapping Bypass
Date: Fri,  5 Feb 2021 20:35:00 -0700
Message-Id: <20210206033502.103964-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Nirmal Patel <nirmal.patel@intel.com>,
 Kapil Karkra <kapil.karkra@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
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
devices, it has its own MSI-X table and transmits child device MSI-X by
remapping child device MSI-X and handling like a demultiplexer.

Some newer VMD devices (Icelake Server) have an option to bypass the VMD MSI-X
remapping table. This allows for better performance scaling as the child device
MSI-X won't be limited by VMD's MSI-X count and IRQ handler.

V2->V3:
Trivial comment fixes
Added acks

V1->V2:
Updated for 5.12-next
Moved IRQ allocation and remapping enable/disable to a more logical location

V1 patches 1-4 were already merged
V1, 5/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-6-jonathan.derrick@intel.com/
V1, 6/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-7-jonathan.derrick@intel.com/

Jon Derrick (2):
  iommu/vt-d: Use Real PCI DMA device for IRTE
  PCI: vmd: Disable MSI-X remapping when possible

 drivers/iommu/intel/irq_remapping.c |  3 +-
 drivers/pci/controller/vmd.c        | 61 +++++++++++++++++++++++------
 2 files changed, 51 insertions(+), 13 deletions(-)

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
