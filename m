Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99852C433FE
	for <iommu@archiver.kernel.org>; Fri, 26 Nov 2021 13:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5908F605E4;
	Fri, 26 Nov 2021 13:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lf9-DKc6COb7; Fri, 26 Nov 2021 13:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E7E460799;
	Fri, 26 Nov 2021 13:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43D80C003E;
	Fri, 26 Nov 2021 13:56:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C861EC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 13:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE9AA40160
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 13:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NrV_-NG4Pxz0 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:56:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E819640185
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 13:55:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222538559"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; d="scan'208";a="222538559"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2021 05:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; d="scan'208";a="651106571"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2021 05:55:57 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/2] iommu/vt-d: Fix an unbalanced
 rcu_read_lock/rcu_read_unlock()
Date: Fri, 26 Nov 2021 21:55:55 +0800
Message-Id: <20211126135556.397932-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126135556.397932-1-baolu.lu@linux.intel.com>
References: <20211126135556.397932-1-baolu.lu@linux.intel.com>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If we return -EOPNOTSUPP, the rcu lock remains lock. This is spurious.
Go through the end of the function instead. This way, the missing
'rcu_read_unlock()' is called.

Fixes: 7afd7f6aa21a ("iommu/vt-d: Check FL and SL capability sanity in scalable mode")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/40cc077ca5f543614eab2a10e84d29dd190273f6.1636217517.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cap_audit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index b39d223926a4..71596fc62822 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -144,6 +144,7 @@ static int cap_audit_static(struct intel_iommu *iommu, enum cap_audit_type type)
 {
 	struct dmar_drhd_unit *d;
 	struct intel_iommu *i;
+	int rc = 0;
 
 	rcu_read_lock();
 	if (list_empty(&dmar_drhd_units))
@@ -169,11 +170,11 @@ static int cap_audit_static(struct intel_iommu *iommu, enum cap_audit_type type)
 	 */
 	if (intel_cap_smts_sanity() &&
 	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
-		return -EOPNOTSUPP;
+		rc = -EOPNOTSUPP;
 
 out:
 	rcu_read_unlock();
-	return 0;
+	return rc;
 }
 
 int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
