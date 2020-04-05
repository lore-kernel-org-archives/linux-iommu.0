Return-Path: <SRS0=HSJZ=5V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC0C2BA19
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:33:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C080820659
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C080820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 94D4D858D3;
	Sun,  5 Apr 2020 08:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jf8zZCN_098b; Sun,  5 Apr 2020 08:33:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7F8F78539A;
	Sun,  5 Apr 2020 08:33:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C47C1AE2;
	Sun,  5 Apr 2020 08:33:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C22EBC0177
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9B36620242
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vFZ5-5LHLJT5 for <iommu@lists.linux-foundation.org>;
 Sun,  5 Apr 2020 08:33:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id CC52B20133
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:33:53 +0000 (UTC)
IronPort-SDR: 1XIq37bOREVGI1mO7wPiFzGu69B3P6TYJCssfx6yQxfv6lDFpzeB/SxFHJ+m6ky1lseMcZDZcu
 EEHsARBdsqlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2020 01:33:53 -0700
IronPort-SDR: xXplkE9fuggqWMUFIofyhr39x1/Jumd23Nh09wZMhPDNKVw7ttmTV+E4fzSo9ywGdoAqqhBHwZ
 synuJjM6zGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,347,1580803200"; d="scan'208";a="397179308"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga004.jf.intel.com with ESMTP; 05 Apr 2020 01:33:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 00/19] [PULL REQUEST] iommu/vt-d: patches for v5.7
Date: Sun,  5 Apr 2020 16:30:34 +0800
Message-Id: <20200405083053.17865-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org
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

Hi Joerg,

Below patches have been piled up for v5.7. They enable below
features:

 - Add support for configuring per-group default domain and remove
   private domain code in the vt-d driver.
 - Nested Shared Virtual Address (SVA) VT-d support
 - Replace Intel SVM with IOMMU SVA APIs

Please consider them for the iommu/vt-d branch.

Best regards,
Lu Baolu

Jacob Pan (11):
  iommu/vt-d: Move domain helper to header
  iommu/uapi: Define a mask for bind data
  iommu/vt-d: Use a helper function to skip agaw for SL
  iommu/vt-d: Add nested translation helper function
  iommu/vt-d: Add bind guest PASID support
  iommu/vt-d: Support flushing more translation cache types
  iommu/vt-d: Add svm/sva invalidate function
  iommu/vt-d: Cache virtual command capability register
  iommu/vt-d: Add custom allocator for IOASID
  iommu/vt-d: Report SVA feature with generic flag
  iommu/vt-d: Replace intel SVM APIs with generic SVA APIs

Lu Baolu (7):
  iommu: Configure default domain with def_domain_type
  iommu/vt-d: Don't force 32bit devices to uses DMA domain
  iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
  iommu/vt-d: Add def_domain_type callback
  iommu/vt-d: Apply per-device dma_ops
  iommu/vt-d: Enlightened PASID allocation
  iommu/vt-d: Add get_domain_info() helper

Sai Praneeth Prakhya (1):
  iommu: Add def_domain_type() callback in iommu_ops

 drivers/iommu/dmar.c        |  40 ++
 drivers/iommu/intel-iommu.c | 788 +++++++++++++++---------------------
 drivers/iommu/intel-pasid.c | 353 +++++++++++++++-
 drivers/iommu/intel-pasid.h |  23 +-
 drivers/iommu/intel-svm.c   | 330 ++++++++++++---
 drivers/iommu/iommu.c       | 103 ++++-
 include/linux/intel-iommu.h |  70 +++-
 include/linux/intel-svm.h   |  99 +----
 include/linux/iommu.h       |   6 +
 include/uapi/linux/iommu.h  |   5 +-
 10 files changed, 1191 insertions(+), 626 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
