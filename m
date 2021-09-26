Return-Path: <SRS0=RzN/=OQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB62C433EF
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 11:49:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81857610A8
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 11:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81857610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 536DA6068F;
	Sun, 26 Sep 2021 11:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3Q9rSUfPzqR; Sun, 26 Sep 2021 11:49:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 90DDE605C9;
	Sun, 26 Sep 2021 11:49:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67174C000F;
	Sun, 26 Sep 2021 11:49:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19E97C000D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF33F40301
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jm0PSsXxmPod for <iommu@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 11:49:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D91EE402EF
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="222450216"
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; d="scan'208";a="222450216"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 04:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; d="scan'208";a="475640098"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 04:49:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 0/3] iommu/t-d: Use SL for GPA->HPA translation
Date: Sun, 26 Sep 2021 19:45:32 +0800
Message-Id: <20210926114535.923263-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

v1:
https://lore.kernel.org/linux-iommu/20210924022931.780963-1-baolu.lu@linux.intel.com/

Change log:
v1->v2:
 - Split the cleanup into a separated patch
 - Add a patch to check sanity of capabilities
 - Consider capabilities when determining FL or SL

Best regards,
Baolu

Lu Baolu (3):
  iommu/vt-d: Remove duplicate identity domain flag
  iommu/vt-d: Check FL and SL capability sanity in scalable mode
  iommu/vt-d: Use second level for GPA->HPA translation

 include/linux/intel-iommu.h     |  3 ---
 drivers/iommu/intel/cap_audit.h |  1 +
 drivers/iommu/intel/cap_audit.c | 13 +++++++++++++
 drivers/iommu/intel/iommu.c     | 21 +++++++++++++--------
 4 files changed, 27 insertions(+), 11 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
