Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33834C43334
	for <iommu@archiver.kernel.org>; Sat, 25 Jun 2022 12:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B024F83F78;
	Sat, 25 Jun 2022 12:56:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B024F83F78
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nn5SboMZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXcNQwQL-w0k; Sat, 25 Jun 2022 12:56:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D41D83F61;
	Sat, 25 Jun 2022 12:56:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D41D83F61
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 318F4C0032;
	Sat, 25 Jun 2022 12:56:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BB13C002D
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 12:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AA3360F27
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 12:56:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AA3360F27
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nn5SboMZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nk5tuj92KdF0 for <iommu@lists.linux-foundation.org>;
 Sat, 25 Jun 2022 12:56:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BDC060F29
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BDC060F29
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656161792; x=1687697792;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=S3kTFxDx/UlQ4ttkSgT0OD0LBtEA6KOASNkdzOFb+uw=;
 b=nn5SboMZSD6/aIioeilQDL8PKNsEklwtvSfxQw2nhUW5C36G7hiS3LQd
 ahfXGLriWGPK7ZSUAW45fRmO28FKvSBSvr2KOdRxePxaegqnjtoN368SX
 v41kpU3qpDHjFdCGalAj3/yUipSVuULOhNYtOIDt6DTgNOf4Yr8WqgfJM
 iT369HIwVf4ckDdF1Lt+gkAePCDq2FlJpJ/b9HCVOyXtq7phoelar8bkc
 QFofI3jSoI0ZSMe+IlCaD9R3ui/tzSkjH6ylw2R8zdgjgvYh2PQrl19a/
 Sv2RxJbpZqmIo5Qi5Yjskv4IIDbH787qD7ep13oPZKt91q9POD5j94TPD g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278727936"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; d="scan'208";a="278727936"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2022 05:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; d="scan'208";a="586890349"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v1 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Date: Sat, 25 Jun 2022 20:51:58 +0800
Message-Id: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <russ.anderson@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>
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

This is a follow-up series of changes proposed by this patch:

https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/

It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
the DMAR_UNITS_SUPPORTED to 1024.

Please help review and suggest.

Best regards,
baolu

Lu Baolu (6):
  iommu/vt-d: Remove unused domain_get_iommu()
  iommu/vt-d: Use IDA interface to manage iommu sequence id
  iommu/vt-d: Refactor iommu information of each domain
  iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
  iommu/vt-d: Remove global g_iommus array
  iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024

 include/linux/dmar.h        |   6 +-
 drivers/iommu/intel/iommu.h |  29 ++++--
 drivers/iommu/intel/dmar.c  |  33 ++-----
 drivers/iommu/intel/iommu.c | 188 ++++++++++++++----------------------
 drivers/iommu/intel/pasid.c |   2 +-
 drivers/iommu/intel/svm.c   |   2 +-
 6 files changed, 103 insertions(+), 157 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
