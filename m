Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C929BC433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 11:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 716B141B8C;
	Thu, 21 Apr 2022 11:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qjylLiGUd5f; Thu, 21 Apr 2022 11:38:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E655E41B3C;
	Thu, 21 Apr 2022 11:38:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8C29C0033;
	Thu, 21 Apr 2022 11:38:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 888FFC002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6730340592
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PSN3E1fwKzvx for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 11:38:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 438CF40272
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650541124; x=1682077124;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MVIx/sHIEgO1dkAuJU+YX9nK4jl1uGAeDl15aPmqOWY=;
 b=k5t7lchb5IpDgdX4mpaOfVK1emWMf8/8YVdtJadKkDHZMCdUk2UsdZ5B
 cvtpVrZWbBqqJeYpIE1zcVXQobm8bIVURsvUVs+UdpgzzGEsrr2V0wHNC
 M9dbjZY/uKnAYdo94Mj0DTadtePWxMsFXV31K/tosHVnJJrPmTVJWvYJt
 rEYG3XpOZcyUs6qmFOWQph02+AMWq45f5b5z6P0vxtLWYOalE84+NnnFM
 hZy8mbX/xUEPRdF/cwO7xwGo43qmLVNaJbKvgmUf4fwvLv2/IM/JcuNcK
 KxZCRBy6YZRGvfi43b1I4VUoZPMj1AtOwMRCuOmp+Nu7ATmmuHaLmiWb8 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263790086"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="263790086"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 04:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="703047905"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jacob jun Pan <jacob.jun.pan@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH v2 0/4] iommu/vt-d: Some fine tuning of SVA
Date: Thu, 21 Apr 2022 19:35:54 +0800
Message-Id: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

This includes several tunings of Intel SVA implementation. I plan to
target them for v5.19. Please help to review.

Best regards,
baolu

Change log:

v2:
 - Move snoop control capability check into a separated patch.
 - Return false if the caller opt-in setting PGSNP with a flag.
 - Add a Fixes tag for "iommu/vt-d: Drop stop marker messages" as it is
   required by the iopf framework.

v1: initial post
 - https://lore.kernel.org/linux-iommu/20220416123049.879969-1-baolu.lu@linux.intel.com/ 

Lu Baolu (4):
  iommu/vt-d: Check before setting PGSNP bit in pasid table entry
  iommu/vt-d: Set PGSNP bit in pasid table entry for SVA binding
  iommu/vt-d: Drop stop marker messages
  iommu/vt-d: Size Page Request Queue to avoid overflow condition

 include/linux/intel-svm.h   |  2 +-
 drivers/iommu/intel/pasid.c | 13 ++++++++++---
 drivers/iommu/intel/svm.c   | 13 ++++++++++---
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
