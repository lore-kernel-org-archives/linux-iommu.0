Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44C2C28CC6
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 14:58:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FFB27B0B
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 14:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FFB27B0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 77867B59;
	Mon,  3 Jun 2019 14:58:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E8BEE481
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 14:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 9796C5D3
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 14:58:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A66980D;
	Mon,  3 Jun 2019 07:58:37 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AAD03F246; 
	Mon,  3 Jun 2019 07:58:35 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com
Subject: [PATCH v2 0/4] iommu: Add device fault reporting API
Date: Mon,  3 Jun 2019 15:57:45 +0100
Message-Id: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

Allow device drivers and VFIO to get notified on IOMMU translation
fault, and handle recoverable faults (PCI PRI). Several series require
this API (Intel VT-d and Arm SMMUv3 nested support, as well as the
generic host SVA implementation).

Changes since v1 [1]:
* Allocate iommu_param earlier, in iommu_probe_device().
* Pass struct iommu_fault to fault handlers, instead of the
  iommu_fault_event wrapper.
* Removed unused iommu_fault_event::iommu_private.
* Removed unnecessary iommu_page_response::addr.
* Added iommu_page_response::version, which would allow to introduce a
  new incompatible iommu_page_response structure (as opposed to just
  adding a flag + field).

[1] [PATCH 0/4] iommu: Add device fault reporting API
    https://lore.kernel.org/lkml/20190523180613.55049-1-jean-philippe.brucker@arm.com/

Jacob Pan (3):
  driver core: Add per device iommu param
  iommu: Introduce device fault data
  iommu: Introduce device fault report API

Jean-Philippe Brucker (1):
  iommu: Add recoverable fault reporting

 drivers/iommu/iommu.c      | 236 ++++++++++++++++++++++++++++++++++++-
 include/linux/device.h     |   3 +
 include/linux/iommu.h      |  87 ++++++++++++++
 include/uapi/linux/iommu.h | 153 ++++++++++++++++++++++++
 4 files changed, 476 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
