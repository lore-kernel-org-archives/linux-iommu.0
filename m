Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FFBC433F5
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 22:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0B4A40A72;
	Thu, 13 Jan 2022 22:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGG_v0vCxpbT; Thu, 13 Jan 2022 22:13:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6E76E40123;
	Thu, 13 Jan 2022 22:13:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52217C002F;
	Thu, 13 Jan 2022 22:13:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF30BC001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 22:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7831824F4
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 22:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l82jG4nSp9pM for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 22:13:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0271782690
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 22:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642111994; x=1673647994;
 h=from:to:cc:subject:date:message-id;
 bh=BRcMWiTvAIYEWm6nRi08D8xbfePlAJ2/c+iNxGqgvx0=;
 b=RgGCjByFDmMp226p3NRMWnUK3QIrsE3S6OYLbzEEvD33zwJTVkj93RL7
 gKcqZMSLe+CAuCGM8LktjY32r54t08VmdAW0d92Ue3UmOs8vZD7AK8/gb
 Fb0D5kU9WPzygI4nJuAOFykMmRVA07ivpuVZ/p9/qcHLckk+9wpPUxgGU
 1ZB76o4oh9dY0qNaCHXXjP702hpTJinrZk+i2aoL/l3ZgK+X5HnShSQfI
 NAnRxpZXQGnkHrCT6IpShBF1htzhHOvlmyMTX0UcrS4GcJ8gfDrGSN7EI
 oNOR2DnwfLgqIlhQ2rias6de7FLk+4Bzgi0uNotD/jd1E5GDwO71+nzfT A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244079727"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; d="scan'208";a="244079727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2022 14:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; d="scan'208";a="491283174"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga002.jf.intel.com with ESMTP; 13 Jan 2022 14:13:13 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
Date: Thu, 13 Jan 2022 05:23:18 -0800
Message-Id: <1642080198-10971-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Raj Ashok <ashok.raj@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

During PCI bus rescan, adding new devices involve two notifiers.
1. dmar_pci_bus_notifier()
2. iommu_bus_notifier()
The current code sets #1 as low priority (INT_MIN) which resulted in #2
being invoked first. The result is that struct device pointer cannot be
found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
device is put under the "catch-all" IOMMU instead of the correct one.

This could cause system hang when device TLB invalidation is sent to the
wrong IOMMU. Invalidation timeout error or hard lockup can be observed.

This patch fixes the issue by setting a higher priority for
dmar_pci_bus_notifier. DRHD search for a new device will find the
correct IOMMU.

Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
Reported-by: Zhang, Bernice <bernice.zhang@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 915bff76fe96..5d07e5b89c2e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -385,7 +385,7 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 
 static struct notifier_block dmar_pci_bus_nb = {
 	.notifier_call = dmar_pci_bus_notifier,
-	.priority = INT_MIN,
+	.priority = INT_MAX,
 };
 
 static struct dmar_drhd_unit *
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
