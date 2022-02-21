Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FE8C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 05:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F542400D7;
	Mon, 21 Feb 2022 05:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uz7-mukSwbAS; Mon, 21 Feb 2022 05:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48A0040018;
	Mon, 21 Feb 2022 05:35:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16387C0033;
	Mon, 21 Feb 2022 05:35:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4C3BC0033
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9378D40886
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Khr3Z84IzoNB for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 05:35:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05BA1401C2
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645421719; x=1676957719;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PjTyE+w64eSZHOT3FO+xalbZipvVCEdyToiWTHcJxBg=;
 b=K91MKP+VXemDR+Q/Om4ZpnVqBGtV7Cg8TgpdRcbZdYekTxgcIu4UDyM9
 IBY7xMTFbxM8aOJdPQqeCpkKyaGMjuoxztrUfDNeNSLjtc4epGHcShWlR
 qU4dw4D4dbzvVR4WRmS/SwaKSqjs6MXBaB4sBtLdcG9Zl/JilstbSGNWH
 izY4uGJGLHGIIqABM5dpn3yZUnhh5RR0s2HP8pICLhm9NizHQqF7ckBFt
 MXTjOeUDA7HEFgkgfVgWJO3NLLjUt94JfGZ3SEo9CViYcFyw8IccfxvkV
 /c6ymHzL/VJbH+7tVLH4x41cY0vP5L9gQSfNxpuXnG8lpXDjR0R6vHTC6 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337870931"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; d="scan'208";a="337870931"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2022 21:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; d="scan'208";a="706130105"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga005.jf.intel.com with ESMTP; 20 Feb 2022 21:35:16 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/1] iommu/vt-d: Fixes for v5.17-rc6
Date: Mon, 21 Feb 2022 13:33:47 +0800
Message-Id: <20220221053348.262724-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

One fix is queued for v5.17. It aims to fix:

 - Kernel BUG() when VMD is enabled in scalable mode.

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu


Adrian Huang (1):
  iommu/vt-d: Fix double list_add when enabling VMD in scalable mode

 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
