Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F4C43331
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB032076A
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB032076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 73E8225C4F;
	Wed, 25 Mar 2020 23:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nF5T95qAZ3jb; Wed, 25 Mar 2020 23:11:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8747225AD0;
	Wed, 25 Mar 2020 23:11:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63E87C1D88;
	Wed, 25 Mar 2020 23:11:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82864C0177
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6D29587ED6
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xVdksJ9DNrKv for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 23:11:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7E3B187DC1
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:25 +0000 (UTC)
IronPort-SDR: wxKu6xcfcp/SnSPVKAPwyx1thfAamrq9Xm28ObPvOONjFwi8FWo2LDOk3GfuS1EdEu5mDDsKQI
 LDp4MfgSlrQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 16:11:24 -0700
IronPort-SDR: w231FeYMX1qlC26S1fobhpS9w1G2THEmgk6xNgH7LXe0Z9HxNZ77GcXYtv+d1jHOU6Ca6tjMw/
 jLHcWy2nOa6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; d="scan'208";a="236083686"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 16:11:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 0/3] IOMMU user API enhancement
Date: Wed, 25 Mar 2020 16:17:04 -0700
Message-Id: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

IOMMU user API header was introduced to support nested DMA translation and
related fault handling. The current UAPI data structures consist of three
areas that cover the interactions between host kernel and guest:
 - fault handling
 - cache invalidation
 - bind guest page tables, i.e. guest PASID

With future extensions in mind, the UAPI structures passed from user to kernel
always starts with a mandatory version field (u32). While this is flexible
for extensions of individual structures, it is difficult to maintain support
of combinations of version numbers.

This patchset introduces a unified UAPI version number that governs all the
UAPI data structure versions. When userspace query UAPI version for check on
compatibility, a single match would be sufficient.

After UAPI version check, users such as VFIO can also retrieve the matching
data structure size based on version and type. Kernel IOMMU UAPI support is
always backward compatible. Data structures are also only open to extension
and closed to modifications.

The introduction of UAPI version does not change the existing UAPI but rather
simplify the data structure version and size matching.

Changelog:
- v2 Rewrite the extension rules that disallows adding new members at the end
     of each UAPI data structures. Only padding bytes and union can be extended.
     Clarified size look up array extension rules with examples.

Thanks,

Jacob


Jacob Pan (3):
  iommu/uapi: Define uapi version and capabilities
  iommu/uapi: Use unified UAPI version
  iommu/uapi: Add helper function for size lookup

 drivers/iommu/intel-iommu.c |  3 +-
 drivers/iommu/intel-svm.c   |  2 +-
 drivers/iommu/iommu.c       | 75 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h       |  6 ++++
 include/uapi/linux/iommu.h  | 62 +++++++++++++++++++++++++++++++++----
 5 files changed, 139 insertions(+), 9 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
