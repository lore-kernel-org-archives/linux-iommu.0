Return-Path: <SRS0=tAyU=PZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01599C433F5
	for <iommu@archiver.kernel.org>; Sat,  6 Nov 2021 16:53:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7EA60EBC
	for <iommu@archiver.kernel.org>; Sat,  6 Nov 2021 16:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C7EA60EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48D7C80DF3;
	Sat,  6 Nov 2021 16:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gbAoj0NIWco0; Sat,  6 Nov 2021 16:53:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7295980D22;
	Sat,  6 Nov 2021 16:53:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54EF9C0019;
	Sat,  6 Nov 2021 16:53:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6F6C000E
 for <iommu@lists.linux-foundation.org>; Sat,  6 Nov 2021 16:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FCFE40267
 for <iommu@lists.linux-foundation.org>; Sat,  6 Nov 2021 16:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDO-v_IQf_fY for <iommu@lists.linux-foundation.org>;
 Sat,  6 Nov 2021 16:53:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr
 [80.12.242.129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46E9840203
 for <iommu@lists.linux-foundation.org>; Sat,  6 Nov 2021 16:53:24 +0000 (UTC)
Received: from pop-os.home ([86.243.171.122]) by smtp.orange.fr with ESMTPA
 id jOwRmPLTp2lVYjOwSmW8kS; Sat, 06 Nov 2021 17:53:22 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Nov 2021 17:53:22 +0100
X-ME-IP: 86.243.171.122
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 will@kernel.org, kevin.tian@intel.com
Subject: [PATCH] iommu/vt-d: Fix an unbalanced rcu_read_lock/rcu_read_unlock()
Date: Sat,  6 Nov 2021 17:53:18 +0100
Message-Id: <40cc077ca5f543614eab2a10e84d29dd190273f6.1636217517.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
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

If we return -EOPNOTSUPP, the rcu lock remains lock. This is spurious.
Go through the end of the function instead. This way, the missing
'rcu_read_unlock()' is called.

Fixes: 7afd7f6aa21a ("iommu/vt-d: Check FL and SL capability sanity in scalable mode")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative, review with care.
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
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
