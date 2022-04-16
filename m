Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1B3C433F5
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 12:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34FBB41860;
	Sat, 16 Apr 2022 12:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k9GnGT6IrOH3; Sat, 16 Apr 2022 12:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C494541829;
	Sat, 16 Apr 2022 12:07:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A152AC0084;
	Sat, 16 Apr 2022 12:07:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3587BC002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 214CB409B5
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9IkgBtrObs9J for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 12:06:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39B8940002
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650110818; x=1681646818;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N6O3WAqflFvUaurGVy2ANhSTC+TytRBU/esQzdWhthI=;
 b=Fv190fPmVB8mFfHVcgJmVvdrhICIwt/oEjj+dXEVCZ8B66awcZSwuAzR
 R006cgYA5KaAGksNY7ubOSoxRkizptbUBt5EggQsJS+al/78eLod1Wycu
 S+8fiCMSgSap/dKavHlDAySY8n1WPWO6leHReSc7lM3Jx9+ApR/uyOjGm
 eeWLJSwMPo4p/2FtoLK/RMr+iHsLLXYtWsQjjXHckZwUOtvJAWc2Fxast
 hzLfWjBgDe0NZ/K11ZXcimW44+6Xk6l54h7enlwwqxgaAdjRSVuCuljTX
 pUZM6ZHtdgQKjHbZIRxtGXFdoaR4lj0NZJm0h75TzzN7IxrcDbaRHdmua A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243219639"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="243219639"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2022 05:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="701329034"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:06:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/2] iommu/vt-d: Minor cleanups
Date: Sat, 16 Apr 2022 20:04:21 +0800
Message-Id: <20220416120423.879552-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
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

Hi folks,

This series include some minor cleanups for the VT-d drivers. No
intentional functional impact.

Best regards,
baolu

Change log:

v1: initial post
 - https://lore.kernel.org/linux-iommu/20220409133006.3953129-1-baolu.lu@linux.intel.com/

v2:
 - Add a new patch to fold dmar_insert_one_dev_info() into its caller.

Lu Baolu (2):
  iommu/vt-d: Change return type of dmar_insert_one_dev_info()
  iommu/vt-d: Fold dmar_insert_one_dev_info() into its caller

 drivers/iommu/intel/iommu.c | 111 ++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 62 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
