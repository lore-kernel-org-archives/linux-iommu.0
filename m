Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52A2C43334
	for <iommu@archiver.kernel.org>; Sat, 25 Jun 2022 13:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D4184167D;
	Sat, 25 Jun 2022 13:38:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D4184167D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N9egSvcF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P2Dm9JL5fXNd; Sat, 25 Jun 2022 13:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D70B1415A5;
	Sat, 25 Jun 2022 13:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D70B1415A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEC85C0039;
	Sat, 25 Jun 2022 13:38:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D77AC002D
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 13:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 210EC40B06
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 13:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 210EC40B06
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=N9egSvcF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QHzCHXQJXPMy for <iommu@lists.linux-foundation.org>;
 Sat, 25 Jun 2022 13:38:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F05A40AD1
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F05A40AD1
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656164323; x=1687700323;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ShCcjEiIWTp1WOPFUN/yyEN1to8mx/823nND7TpXSes=;
 b=N9egSvcFHxLytZ/iPjD4/zu4cSMQBGAfdcYpPqsaq9wWh9IOaXsORqm6
 3avpfPQY5MsqMcVTjx0aOq4LYDNcyz7SRlQsggzP69d6q7LYYUzA/6xGw
 hDhqpmQx7hHXL55W4eXbE9+SMqIHpB/NAQOsm93xTJJHrjOKJc6RYhnfR
 FWTaWls05YmShAOXFHTZgBNJfrE3e+/CcSuhpNpZn88pp/T2zJmTLjx5X
 U198kYhGn8PTftWd+IMqVPstsbAX7WUDsWSfjUOCXTYZIHZGlJZZ5hdr3
 Xmcx2rjdfdemGICOKKHgvhGPqVhdxZqXaJgoJzx2VzMMKuSQiqwXI1JAs Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="342874556"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; d="scan'208";a="342874556"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2022 06:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; d="scan'208";a="645692698"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2022 06:38:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/1] iommu/vt-d: Fixes for v5.19-rc4
Date: Sat, 25 Jun 2022 21:34:29 +0800
Message-Id: <20220625133430.2200315-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Ethan Zhao <haifeng.zhao@linux.intel.com>
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

One fix is queued for v5.19. It aims to fix:

- RID2PASID setup/teardown failures for pci alias devices

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Lu Baolu (1):
  iommu/vt-d: Fix RID2PASID setup/teardown failure

 include/linux/intel-iommu.h |  3 --
 drivers/iommu/intel/pasid.h |  1 -
 drivers/iommu/intel/iommu.c | 24 -------------
 drivers/iommu/intel/pasid.c | 69 ++-----------------------------------
 4 files changed, 3 insertions(+), 94 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
