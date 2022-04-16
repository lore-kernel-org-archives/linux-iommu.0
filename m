Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91163C433F5
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 12:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BD33840A1;
	Sat, 16 Apr 2022 12:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ffnif2cq9yCa; Sat, 16 Apr 2022 12:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED63683FAE;
	Sat, 16 Apr 2022 12:33:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C108AC0033;
	Sat, 16 Apr 2022 12:33:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 945FDC002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A01360E74
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mrKVl8Kxo4zw for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 12:33:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D022607F6
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650112412; x=1681648412;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7N6FnAhDTh9ImILbJI2DEaBF3CJE+gkTHPbZ8SbtD5E=;
 b=ZRVNxUiPOtPpVHVOya7lh1TOribN77gHynX/bc130zGyL75CxDaJG1CO
 XuB59Cz7JL79hyKKbyAmQBBxDgGbWdBzV+pzMVjs6Gzacqm4h8oFqXi6T
 rPnbg+bd/QDnDQ/b67PLzrjZMxS0IqN122NAG1cQGY265nun3jVOb8CzN
 DXIUqd6mJhfPBT9OiWIex1INQ8++4oHCuDwoOZG3tomnGd7h5srOsDV0f
 hgdO9A2iP5ILJEISIwpYQhlQDziJDFEtetB8JRhFkJFq9WZwXdb1ix6sF
 KgKCmjoAZPhJDApfIe4HUQ2AQH++QzwP9j82sZdNXm83r06bwFP9QzDhU w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263045791"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="263045791"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2022 05:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="701332462"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:33:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jacob jun Pan <jacob.jun.pan@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH 0/3] iommu/vt-d: Some fine tuning of SVA
Date: Sat, 16 Apr 2022 20:30:46 +0800
Message-Id: <20220416123049.879969-1-baolu.lu@linux.intel.com>
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


Lu Baolu (3):
  iommu/vt-d: Set PGSNP bit in pasid table entry for sva binding
  iommu/vt-d: Drop stop marker messages
  iommu/vt-d: Size Page Request Queue to avoid overflow condition

 include/linux/intel-svm.h   | 2 +-
 drivers/iommu/intel/pasid.c | 2 +-
 drivers/iommu/intel/svm.c   | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
