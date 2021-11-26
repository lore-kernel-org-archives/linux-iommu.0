Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776F9C433EF
	for <iommu@archiver.kernel.org>; Fri, 26 Nov 2021 13:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16E3B6079F;
	Fri, 26 Nov 2021 13:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id il_E1X6oaC-o; Fri, 26 Nov 2021 13:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FAE7606CF;
	Fri, 26 Nov 2021 13:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11D49C001C;
	Fri, 26 Nov 2021 13:56:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 411CAC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 13:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 185EF401D2
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 13:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GXcq8zjF6I1f for <iommu@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:55:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC1DD40160
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 13:55:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222538558"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; d="scan'208";a="222538558"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2021 05:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; d="scan'208";a="651106565"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2021 05:55:55 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 0/2] iommu/vt-d: Fixes for v5.16-rc3
Date: Fri, 26 Nov 2021 21:55:54 +0800
Message-Id: <20211126135556.397932-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

Update this series with a fix for an issue reported by Intel 0-day
robot. Sorry for the inconvenience.

Best regards,
baolu

change log:
v1:
https://lore.kernel.org/all/20211122032458.2549761-1-baolu.lu@linux.intel.com/

v2: For the patch titled "iommu/vt-d: Fix unmap_pages support",
    fixed below issue reported by Intel 0-day robot.

"
drivers/iommu/intel/iommu.c:1344:7: warning: variable 'level_pfn' is
used uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
"

Alex Williamson (1):
  iommu/vt-d: Fix unmap_pages support

Christophe JAILLET (1):
  iommu/vt-d: Fix an unbalanced rcu_read_lock/rcu_read_unlock()

 drivers/iommu/intel/cap_audit.c | 5 +++--
 drivers/iommu/intel/iommu.c     | 6 ++----
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
