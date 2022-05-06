Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B436C433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 05:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FDB9404C0;
	Fri,  6 May 2022 05:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Ev_7pufVCNR; Fri,  6 May 2022 05:30:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 254AB409E0;
	Fri,  6 May 2022 05:30:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EC26C0032;
	Fri,  6 May 2022 05:30:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4535DC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33E954157F
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:30:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KNIyL3XB79Qd for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 05:30:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B5D14158B
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651815029; x=1683351029;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ss1Py9xKSsfOz68o9vHCUmEfR+D8C1SL1jYJcqrSmD8=;
 b=bmCUgMtU5b28+yxsurdnLKGT9yW3ipwcx5VOegBz+Ohn520N3WK+91Rc
 FE3KBnKe2PXZnOeSJmstC53tSUD7SWJTDsKa7Wdj3sv4iZSmJql05i4P2
 yP6vR8KaE1jgm3yqeKT8zsGJrhjv0VYWhTikJvPHjE1DiowUFjKgLQ10D
 O0xY5AHVVvr+S5G/AKXrYJJCEutL2d0k6QMDJ51Hs+1rBtgkWw+Psjx6w
 5lCdsRb1wK+YyYnSPfmRbISQySrRqyBaNe/2mvmTKT5iRPUnVwvFLzBoM
 T85Pn6lg58qNGDepeGS89c2l234BRhFpneUMm5UXNW/yY8EGNndmGBdUP Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354790950"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="354790950"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 22:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="695011051"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 22:30:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v3 1/4] iommu/vt-d: Block force-snoop domain attaching if no
 SC support
Date: Fri,  6 May 2022 13:27:24 +0800
Message-Id: <20220506052727.1689687-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
References: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 linux-kernel@vger.kernel.org
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

In the attach_dev callback of the default domain ops, if the domain has
been set force_snooping, but the iommu hardware of the device does not
support SC(Snoop Control) capability, the callback should block it and
return a corresponding error code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2990f80c5e08..b4802f4055a0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4367,6 +4367,9 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
+		return -EOPNOTSUPP;
+
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
