Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE6FC433F5
	for <iommu@archiver.kernel.org>; Sun,  1 May 2022 11:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5426782656;
	Sun,  1 May 2022 11:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qXSziQFTW9T6; Sun,  1 May 2022 11:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C634825C7;
	Sun,  1 May 2022 11:27:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06BD6C0039;
	Sun,  1 May 2022 11:27:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAE81C0039
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90E19408A0
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qgu6KJkfjscu for <iommu@lists.linux-foundation.org>;
 Sun,  1 May 2022 11:27:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E590240886
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651404468; x=1682940468;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6JDcNykVMFEeo9gQEenBDZWl7d/DyNiEOKcrygbNnmA=;
 b=bWya1ZafWr6/hrbNWndBJedp6cjEH60MRaMy/MzXR+fUHr5EAbIem6yw
 HL72/6wn4CC9t2E346J0n9QB0KkYf3QY8UVLRbj2jacO+4VW4z5nhi8B1
 yUSeprFsvSIew0mDEtZ8I7dTTmPcf9a7enw6+KJzgNuhVzSJDaoerT/f9
 fW8IK8479OGBycwqv2rrzGcsoLuzxh7EJ8glHnFYHKqhAs15AtcnNW/o2
 bLpYzMWlmJMKANdDHaw6sz0B3XFGZDdpcFnfT9VBVK5KmqZBw27fydTUL
 V1ov0eNL6uZRCSo7L7p5do1KYwSnl9NF8Ge405Jr/dxastW3LpYY/CW2I Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="292178341"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; d="scan'208";a="292178341"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2022 04:27:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; d="scan'208";a="545114784"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga002.jf.intel.com with ESMTP; 01 May 2022 04:27:46 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 1/5] iommu/vt-d: Block force-snoop domain attaching if no SC
 support
Date: Sun,  1 May 2022 19:24:30 +0800
Message-Id: <20220501112434.874236-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501112434.874236-1-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cf43e8f9091b..d68f5bbf3e93 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4354,6 +4354,9 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
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
