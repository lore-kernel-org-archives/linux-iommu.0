Return-Path: <SRS0=JP6a=XN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421D5C4CEC9
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 23:22:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D95821907
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 23:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D95821907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B6E1EC77;
	Wed, 18 Sep 2019 23:22:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 547F2C4E
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 23:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CC27E76D
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 23:22:34 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	18 Sep 2019 16:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; d="scan'208";a="199210209"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 18 Sep 2019 16:22:33 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 0/4] User API for nested shared virtual address (SVA)
Date: Wed, 18 Sep 2019 16:26:30 -0700
Message-Id: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This set consists of IOMMU APIs to support SVA in the guest, a.k.a nested
SVA. As the complete SVA support is complex, we break down the enabling
effort into three stages:
1. PCI device direct assignment
2. Fault handling, especially page request service support
3. Mediated device assignment

Each stage includes common API and vendor specific IOMMU driver changes. This
series is the common uAPI for stage #1. It is intended to build consensus on
the interface which all vendors reply on.

This series is extracted from the complete stage1 set which includes VT-d code.
https://lkml.org/lkml/2019/8/15/951

Changes:
 - Use spinlock instead of mutex to protect ioasid custom allocators. This is
   to support callers in atomic context
 - Added more padding to guest PASID bind data for future extensions, suggested
   by Joerg.
After much thinking, I did not do name change from PASID to IOASID in the uAPI,
considering we have been using PASID in the rest of uAPIs. IOASID will remain
used within the kernel.

For more discussions lead to this series, checkout LPC 2019 VFIO/IOMMU/PCI
microconference materials.
https://linuxplumbersconf.org/event/4/sessions/66/#20190909

Jacob Pan (2):
  iommu/ioasid: Add custom allocators
  iommu: Introduce guest PASID bind function

Jean-Philippe Brucker (1):
  iommu: Add I/O ASID allocator

Yi L Liu (1):
  iommu: Introduce cache_invalidate API

 drivers/iommu/Kconfig      |   4 +
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/ioasid.c     | 432 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c      |  30 ++++
 include/linux/ioasid.h     |  75 ++++++++
 include/linux/iommu.h      |  36 ++++
 include/uapi/linux/iommu.h | 169 ++++++++++++++++++
 7 files changed, 747 insertions(+)
 create mode 100644 drivers/iommu/ioasid.c
 create mode 100644 include/linux/ioasid.h

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
