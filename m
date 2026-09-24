Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A602F34D926
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232449; cv=none; b=srggza5YwwEmvv7hhaAbniKCF4idRqsd7x0TkRJHVqRyPHncg4FrzkJ2F5CJDS/n/uuCdwQzBHtmsCcYDngv7Ql2vUt2nQ9jnxt51KORkyrr/x3KW/llWvX8nNVV90jHUgYLBtusfuLajAH4K06Ccp6FIL+7AN6uCD48dPBhAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232449; c=relaxed/simple;
	bh=Zlpu0K1WgMqcj6t/bYJhYwZv1GKcvCObCFxMVSWl0Zs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z31F98t0dnTTExTN8O9QF0Dt0bsStZzASy9FJcntk7aDV0dfCVnp8Fkfo1zmP/zPLpqbh/Jpo3P8PhwNgGzCLUDeqVmUrNAtkeemq7+BZgNTK6VkbYCHgTw4VOZ8ng1Gy+32XftxNR5/giT5GQBJuxv4+ltzZemgyLFBYbe4Px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=f+ExBF2g; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="f+ExBF2g"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/amd: RCU-protect iommu_ga_log_notifier
Date: Thu, 24 Sep 2026 14:47:09 +0800
Message-ID: <20260924064709.2194-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790232439;
	bh=r2zz97bAUXGhfmlXsFoLlOLLnieQurAEkz2wsJ0Hed8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=f+ExBF2gk1na3JBst6rNG4FW+mh57dNwALfacB4K/Wfa3hKnwMidvn5VndE2m2809
	 N7Pf8So6N9z9y56IJpvPAENZMG+1UpSHLqDeFjzTCMK+/Pz24a5xn/u91nOtRXXHP9
	 kNOIEfmDtv4V6kfS9eaeoZDICBI6nXrceXp71kYZhEL6o+xL742/RJ+e0VlDZJvCIZ
	 nYGC5ZOzQbFWRXNNEUkA7v9P9igJ831XUORSURWZwLVLSUAF/h6wfEkaKiyjdd290g
	 x/aD9v90iTx+HP/az2XHMoALd6uU0wm4Q3sGo1pLFSOANHWPBfsFnD+ysCkxHdctyc
	 rTAxbuy1bfD8Q==

From: Li RongQing <lirongqing@baidu.com>

iommu_poll_ga_log() accesses iommu_ga_log_notifier without an RCU
read-side critical section, so synchronize_rcu() in the unregister
path does not wait for an in-flight notifier callback.

Use rcu_assign_pointer() when updating the notifier and
rcu_dereference() under scoped_guard(rcu) when invoking it. Load the
pointer once to close the race with unregister.

Keep the RCU read-side critical section minimal: only the pointer load
and the indirect notifier call stay inside scoped_guard(rcu). Move
pr_debug and pr_err outside the section so that logging does not extend
the window that synchronize_rcu() must wait for.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a06cd61..a31464a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1054,11 +1054,11 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 }
 
 #ifdef CONFIG_IRQ_REMAP
-static int (*iommu_ga_log_notifier)(u32);
+static int (__rcu *iommu_ga_log_notifier)(u32 ga_tag);
 
 int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 {
-	iommu_ga_log_notifier = notifier;
+	rcu_assign_pointer(iommu_ga_log_notifier, notifier);
 
 	/*
 	 * Ensure all in-flight IRQ handlers run to completion before returning
@@ -1094,17 +1094,25 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 
 		/* Handle GA entry */
 		switch (GA_REQ_TYPE(log_entry)) {
-		case GA_GUEST_NR:
-			if (!iommu_ga_log_notifier)
-				break;
-
-			pr_debug("%s: devid=%#x, ga_tag=%#x\n",
-				 __func__, GA_DEVID(log_entry),
-				 GA_TAG(log_entry));
+		case GA_GUEST_NR: {
+			int (*notifier)(u32 ga_tag);
+			int ret = 0;
+
+			scoped_guard(rcu) {
+				notifier = rcu_dereference(iommu_ga_log_notifier);
+				if (notifier)
+					ret = notifier(GA_TAG(log_entry));
+			}
 
-			if (iommu_ga_log_notifier(GA_TAG(log_entry)) != 0)
-				pr_err("GA log notifier failed.\n");
+			if (notifier) {
+				pr_debug("%s: devid=%#x, ga_tag=%#x\n",
+					 __func__, GA_DEVID(log_entry),
+					 GA_TAG(log_entry));
+				if (ret)
+					pr_err("GA log notifier failed.\n");
+			}
 			break;
+		}
 		default:
 			break;
 		}
-- 
2.9.4

