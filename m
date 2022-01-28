Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDD4C433EF
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 03:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDBB260AD8;
	Fri, 28 Jan 2022 03:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wtEdMNg7p2bp; Fri, 28 Jan 2022 03:11:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B764F60AB3;
	Fri, 28 Jan 2022 03:11:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 868D0C0011;
	Fri, 28 Jan 2022 03:11:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A779C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 03:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 534B560AB3
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 03:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q0V0sAkU5A2E for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 03:11:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50BFD60AA7
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 03:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643339473; x=1674875473;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ow+O/a1JkFp3o2QrLICOiORrZkHZmJT/ywUsmWPw9mE=;
 b=Wx1DTvI3k4xtDptIgy2FD5MPE2210rasnJ552loYWSyb1OOKfYqq1yl0
 yXwltdIKQsbaga1utJJVfiLDpazj/XHqr/0Y+tcvo5CJqOADpg08d7S67
 pScmG6nyQneiy/6p1/IhXZbRGboLXz6AkxBj6AavsOURCo0CCdevMyMOG
 yoRsrB93329i0StN3rVs7vMuk1eYmpQ/DlYnSM/4POzXcw4G8GrayWIad
 kTt/xHDk4vGAzw+ShpNxify1/SRYbG1Wp7/4+kr2ZfzK+dLCypIhNd1nC
 o9h/+5EEeDWnIOHxolQzCR0K9xEi6ylKWxRjauod4ApX8H+5RsryWK7yk A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="245873425"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; d="scan'208";a="245873425"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2022 19:11:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; d="scan'208";a="521513405"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 27 Jan 2022 19:11:10 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/2] iommu/vt-d: Fixes for v5.17-rc2
Date: Fri, 28 Jan 2022 11:10:00 +0800
Message-Id: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Guoqing Jiang <guoqing.jiang@linux.dev>
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

Hi Joerg,

Two fixes are queued for v5.17. They aim to fix:

 - Fix PCI bus rescan device hot add;
 - Fix potential memory leak in intel_setup_irq_remapping().

Please consider them for the iommu/fix branch.

Best regards,
Lu Baolu

Guoqing Jiang (1):
  iommu/vt-d: Fix potential memory leak in intel_setup_irq_remapping()

Jacob Pan (1):
  iommu/vt-d: Fix PCI bus rescan device hot add

 include/linux/iommu.h               |  1 +
 drivers/iommu/intel/dmar.c          | 71 +++++++++++++++++++++--------
 drivers/iommu/intel/irq_remapping.c | 13 ++++--
 drivers/iommu/iommu.c               |  1 +
 4 files changed, 64 insertions(+), 22 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
