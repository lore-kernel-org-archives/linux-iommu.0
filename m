Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A478C433F5
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 08:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA54460D58;
	Sat, 23 Apr 2022 08:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pIYsLCXwOJuu; Sat, 23 Apr 2022 08:26:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 966C460B68;
	Sat, 23 Apr 2022 08:26:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 676FDC0032;
	Sat, 23 Apr 2022 08:26:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2296C002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF9C64198F
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M9tzpIA9BFez for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 08:26:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F02D64198A
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650702373; x=1682238373;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KraXt0tfhPwQxuNSx2H3KI2zx8bVIwpQWZa+QsEo2SI=;
 b=KK/x8Fx8NBn5tsM7hVX3e7oedCfl1OqjkFFNFhuPhONN+5mWur+8614S
 oiW0D1ti2YnjvIAo3Lk9wuGj9+YlVHgDrSCjk4D76iOk2FAcifcY1mqle
 SdvM9TFmE1PwnATWrLrxPwHpEHWfecde2wpMrgNXUa5HKNAX13psKzlWm
 a7mTRs29JRYm9HAwzpE8v9KPCPCK93Zt2ax+KuZGhV6a0RnOPe7MifDSq
 9WaCL6/f9p9VrQhpbIbZaqzBHdwRcQLNc1w+M0llfpOMXNOouN2yDZQ15
 29SsNBw3Wfz4CsYG9lK+KBHwFygMLkMHigRSe1JskA4lFXcYateHzk+Sy w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244794795"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="244794795"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 01:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="703866201"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2022 01:26:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/1] iommu/vt-d: Fixes for v5.18-rc4
Date: Sat, 23 Apr 2022 16:23:29 +0800
Message-Id: <20220423082330.3897867-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org
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

One fix is queued for v5.18. It aims to fix:

 - Handle PCI stop marker messages in IOMMU driver to meet the
   requirement of I/O page fault handling framework.

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Lu Baolu (1):
  iommu/vt-d: Drop stop marker messages

 drivers/iommu/intel/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
