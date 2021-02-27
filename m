Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44417C433E0
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0164864E02
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0164864E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C2D1C43344;
	Sun, 28 Feb 2021 06:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GS24fpI-hDCR; Sun, 28 Feb 2021 06:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB917433BD;
	Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE224C0010;
	Sun, 28 Feb 2021 06:33:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA05C000E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EF446F82D
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pEEATFlz8B_X for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F9576F95C
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
IronPort-SDR: shCqXYyoDhIqAgSWHHIZEQOub8QBt6HhsTT8JCuWAC/M0z7hkn8JcJoi3T46z8AY4X/OXrN8RN
 LMfYkyfmBlKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="247624818"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="247624818"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:10 -0800
IronPort-SDR: /Vzm0YxkFjeFo6ut3o7v8+CqkNKZmbSAXqjq6gYi8tI9Cq3f5u00e2T2qIXbb6ACQZFeTKeC4p
 4bI+20WBl1Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029743"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:10 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [RFC PATCH 16/18] iommu/ioasid: Consult IOASIDs cgroup for allocation
Date: Sat, 27 Feb 2021 14:01:24 -0800
Message-Id: <1614463286-97618-17-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Wu Hao <hao.wu@intel.com>
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

Once IOASIDs cgroup is active, we must consult the limitation set up
by the cgroups during allocation. Freeing IOASIDs also need to return
the quota back to the cgroup.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index d42b39ca2c8b..fd3f5729c71d 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -782,7 +782,10 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	spin_lock(&ioasid_allocator_lock);
 	/* Check if the IOASID set has been allocated and initialized */
-	if (!ioasid_set_is_valid(set))
+	if (!set || !ioasid_set_is_valid(set))
+		goto done_unlock;
+
+	if (set->type == IOASID_SET_TYPE_MM && ioasid_cg_charge(set))
 		goto done_unlock;
 
 	if (set->quota <= atomic_read(&set->nr_ioasids)) {
@@ -832,6 +835,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	goto done_unlock;
 exit_free:
 	kfree(data);
+	ioasid_cg_uncharge(set);
 done_unlock:
 	spin_unlock(&ioasid_allocator_lock);
 	return id;
@@ -849,6 +853,7 @@ static void ioasid_do_free_locked(struct ioasid_data *data)
 		kfree_rcu(ioasid_data, rcu);
 	}
 	atomic_dec(&data->set->nr_ioasids);
+	ioasid_cg_uncharge(data->set);
 	xa_erase(&data->set->xa, data->id);
 	/* Destroy the set if empty */
 	if (!atomic_read(&data->set->nr_ioasids))
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
