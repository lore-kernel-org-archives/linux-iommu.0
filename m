Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA036C433EF
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 01:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86425605A2;
	Sun, 10 Apr 2022 01:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cotu4vD2RlYU; Sun, 10 Apr 2022 01:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7DDA7606C6;
	Sun, 10 Apr 2022 01:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CCE0C0084;
	Sun, 10 Apr 2022 01:38:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B502EC002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 01:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DD3082AF8
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 01:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hF9qLgIKKyDL for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 01:38:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16C3F8291A
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649554719; x=1681090719;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6IxqFkFMS6ZG4u+dtN73hUKlEN9IrYrHfMdKIbOkzLA=;
 b=F6cmYNrBb6X9WhvHAES2KhkYSTTQQZzJ+VY73vvS5Pmh/AgBFJLkt4Dc
 QRh+W+pNJazHoYgKs23g/IGSSB3r9TXdIQ2A957AbkH9IcmML0JZYxcxT
 qb7toFfg6DNzPrpLwrV0RSmNmXnvTYVjczSpgwmZjCybqlKZZWb6YtBpI
 cMWoAvPyJwY3YdTNPcg/dg2uAZKIjEz82dZG1Iv/0TVvS3kv4BGmMakNM
 urW0q8PckFrQ0AiQIudHqh3vLbm3SGj9vlKajihJ1muSCJHPOqvLBE/iQ
 /tEI9tkcB1LI8uL4B52SBgSvT5n6H7Px62lYVHW12Y4gre06yWy07ufGr w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="259524672"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; d="scan'208";a="259524672"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 18:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; d="scan'208";a="610529701"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2022 18:38:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/1] iommu/vt-d: Fixes for v5.18-rc3
Date: Sun, 10 Apr 2022 09:35:32 +0800
Message-Id: <20220410013533.3959168-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, David Stevens <stevensd@chromium.org>,
 iommu@lists.linux-foundation.org
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

 - Calculate a feasible mask for non-aligned page-selective
   IOTLB invalidation.

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

David Stevens (1):
  iommu/vt-d: Calculate mask for non-aligned flushes

 drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
