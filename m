Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BA1C433DB
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 01:38:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED38923442
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 01:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED38923442
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 66FB386A14;
	Thu, 14 Jan 2021 01:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pcHMtI7Sn15q; Thu, 14 Jan 2021 01:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B046686958;
	Thu, 14 Jan 2021 01:38:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A091AC0893;
	Thu, 14 Jan 2021 01:38:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FEF9C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 44466869FE
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z31_Sy3N7SUz for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 01:38:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0936D86958
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:38:21 +0000 (UTC)
IronPort-SDR: fnAXyulO/IoR7HDw5WJtE6wDkhY2G28xgvLolUFINx34nod80CohX/qgVTEE43LzkzLi4a4MC+
 6csssq1AebXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="177516452"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; d="scan'208";a="177516452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 17:38:18 -0800
IronPort-SDR: 70ByEuj6ZUTxoobpwmM7DnqLWj+gPglSHAzdk1Zcl51BXOPdoBO9ptYytiJ7aJ9FshTQjUNI11
 332Cn7+I7AeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; d="scan'208";a="569582482"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2021 17:38:11 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: tglx@linutronix.de, ashok.raj@intel.com, kevin.tian@intel.com,
 dave.jiang@intel.com, megha.dey@intel.com, dwmw2@infradead.org
Subject: [RFC PATCH v3 0/2] Add platform check for subdevice irq domain
Date: Thu, 14 Jan 2021 09:30:01 +0800
Message-Id: <20210114013003.297050-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, linux-kernel@vger.kernel.org, bhelgaas@google.com,
 kwankhede@nvidia.com, will@kernel.org, leon@kernel.org, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, parav@mellanox.com, alex.williamson@redhat.com,
 samuel.ortiz@intel.com, dan.j.williams@intel.com, tony.luck@intel.com,
 mona.hossain@intel.com, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, dmaengine@vger.kernel.org, pbonzini@redhat.com
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

Hi,

Learnt from the discussions in this thread:

https://lore.kernel.org/linux-pci/160408357912.912050.17005584526266191420.stgit@djiang5-desk3.ch.intel.com/

The device IMS (Interrupt Message Storage) should not be enabled in any
virtualization environments unless there is a HYPERCALL domain which
makes the changes in the message store monitored by the hypervisor.

As the initial step, we allow the IMS to be enabled only if we are
running on the bare metal. It's easy to enable IMS in the virtualization
environments if above preconditions are met in the future.

This series is only for comments purpose. We will include it in the Intel
IMS implementation later once we reach a consensus.

Change log:
v2->v3:
 - v2:
   https://lore.kernel.org/linux-pci/20210106022749.2769057-1-baolu.lu@linux.intel.com/
 - Add all identified heuristics so far.

v1->v2:
 - v1:
   https://lore.kernel.org/linux-pci/20201210004624.345282-1-baolu.lu@linux.intel.com/
 - Rename probably_on_bare_metal() with on_bare_metal();
 - Some vendors might use the same name for both bare metal and virtual
   environment. Before we add vendor specific code to distinguish
   between them, let's return false in on_bare_metal(). This won't
   introduce any regression. The only impact is that the coming new
   platform msi feature won't be supported until the vendor specific code
   is provided.

Best regards,
baolu

Lu Baolu (2):
  iommu: Add capability IOMMU_CAP_VIOMMU
  platform-msi: Add platform check for subdevice irq domain

 arch/x86/pci/common.c        | 71 ++++++++++++++++++++++++++++++++++++
 drivers/base/platform-msi.c  |  8 ++++
 drivers/iommu/intel/iommu.c  | 20 ++++++++++
 drivers/iommu/virtio-iommu.c |  9 +++++
 include/linux/iommu.h        |  1 +
 include/linux/msi.h          |  1 +
 6 files changed, 110 insertions(+)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
