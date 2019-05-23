Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6402DC282E1
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 18:07:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455B52075B
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 18:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455B52075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3102FF2A;
	Thu, 23 May 2019 18:07:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 461EAF25
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 18:07:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F274887A
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 18:07:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8924374;
	Thu, 23 May 2019 11:07:03 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AC1A3F5AF; 
	Thu, 23 May 2019 11:07:01 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com
Subject: [PATCH 0/4] iommu: Add device fault reporting API
Date: Thu, 23 May 2019 19:06:09 +0100
Message-Id: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: yi.l.liu@linux.intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
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

Allow device drivers and VFIO to get notifications on IOMMU translation
fault, and to handle recoverable faults (PCI PRI). These four patches
are relatively mature since they are required by three different series,
and have been under discussion for a while:

* Nested translation support for SMMUv3 [1].
* vSVA for VT-d [2].
* My generic host SVA implementation.

I reworked patch 4 according to previous discussions, and moved the page
response structure to UAPI. For the other patches I only fixed comments
and whitespaces. Please have a look and see if it works for you.

[1] [PATCH v7 00/23] SMMUv3 Nested Stage Setup
    https://lore.kernel.org/lkml/20190408121911.24103-1-eric.auger@redhat.com/
[2] [PATCH v3 00/16] Shared virtual address IOMMU and VT-d support
    https://lore.kernel.org/lkml/1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com/

Jacob Pan (3):
  driver core: Add per device iommu param
  iommu: Introduce device fault data
  iommu: Introduce device fault report API

Jean-Philippe Brucker (1):
  iommu: Add recoverable fault reporting

 drivers/iommu/iommu.c      | 218 +++++++++++++++++++++++++++++++++++++
 include/linux/device.h     |   3 +
 include/linux/iommu.h      |  91 ++++++++++++++++
 include/uapi/linux/iommu.h | 152 ++++++++++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
