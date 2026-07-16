Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0728505E
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211398; cv=none; b=I5YcvtG5xRi2NWwsW59Ascf9Yx9XRFterAJGqmSYr1zeDvNi/U73epNUNr6cZXrHIG25LrI1bX3FAG3SwYPUyYTt4Oml+u74BAcOBddaWkCyF8gVjsFQICIlGUxvD57nrkRH79ShvE9U3zDZAHCtpTi+yliVYcblI3ZxqfSY30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211398; c=relaxed/simple;
	bh=N+7pjRW1tuhPKgkpz7OzIph9F0h5cCIccqbaotKijyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0Uj9ubINH4pUVAuzkcv3Drfwl1CCzH04hGoF8kLGDrTcN0h2p0sMW0EaogyrtZ4m2vsDDl+j8Cb0gEMRhpFKkLp3T21Y0T/5FUKgVzeRHLRtMCWp9hdiH3WKPHdnI6UuK0OMSdYD6hCTTY3mjXa6IkGogupXQnZJiDwkyTdm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OSqUZDiK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OSqUZDiK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784211392; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BCvAwzijvW5sRoiIdXTHbt+OSeKE9DumY49CT3tqIg0=;
	b=OSqUZDiKZ6tW4XIBGxLqxJp2NEZwtGtNijjgEVAhvX1vObMT/fTgy6BrNmKfSxoEJy2DcRKEXrneFnz1ChhTgePnvtVbNyepW6yjEhmzaaHDCBaOXsKSgVIy/2XiAzuRwr0U+NG8tArWnZKQNNN4Eb00eMlLU+vjuroF/74t7XA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X7EXKpH_1784211382;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X7EXKpH_1784211382 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jul 2026 22:16:30 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH] iommu/amd: Wait for completion instead of returning early in iommu_completion_wait()
Date: Thu, 16 Jul 2026 22:16:22 +0800
Message-ID: <20260716141622.325032-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

need_sync is a per-IOMMU flag shared by all domains and devices behind
that IOMMU. It is set whenever a command is queued with sync == true and
cleared when a completion-wait (CWAIT) command is queued. However, a
cleared need_sync only means that a covering CWAIT has been queued, not
that all previously queued commands have actually completed in hardware.

iommu_completion_wait() read need_sync locklessly and returned early
when it was false. This breaks the "block until all previously queued
commands have completed" contract in a multi-CPU scenario:

  CPU2: queue inv-B                  => need_sync = true
  CPU1: queue CWAIT(N); need_sync = false; then wait_on_sem(N)
  CPU2: read need_sync == false      => return 0 (no wait!)

CPU2 returns without waiting for any sequence number even though its
inv-B may not have completed yet (CWAIT(N), queued after inv-B, has not
been signaled). CPU2 then proceeds to, for example, free page-table
pages while the IOMMU can still walk stale translations, opening a
use-after-free window. This is a logical race in the meaning of the
flag, not a memory-visibility issue, so barriers alone do not help.

Fix it without losing the optimization of avoiding redundant CWAIT
commands: take iommu->lock before testing need_sync, and when it is
false do not return early but wait for the last allocated sequence
number (cmd_sem_val). Since need_sync == false implies no sync command
was queued after the last CWAIT, that CWAIT is FIFO-ordered after every
not-yet-completed command, so waiting for its sequence number guarantees
all prior commands (possibly queued by another CPU) have completed. The
common path with pending work is unchanged and no extra hardware command
is issued.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/amd/iommu.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 563f9c2672d5..29dc18d3d22e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1450,11 +1450,23 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	int ret;
 	u64 data;
 
-	if (!iommu->need_sync)
-		return 0;
-
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 
+	if (!iommu->need_sync) {
+		/*
+		 * No command has been queued since the last completion-wait.
+		 * A concurrent CPU may have already queued that CWAIT and
+		 * cleared need_sync; need_sync == false only means a covering
+		 * CWAIT is queued, not that all prior commands have completed.
+		 * Wait for the last allocated sequence number so that any
+		 * command queued before this call (possibly on another CPU)
+		 * is guaranteed to have completed before returning.
+		 */
+		data = iommu->cmd_sem_val;
+		raw_spin_unlock_irqrestore(&iommu->lock, flags);
+		return wait_on_sem(iommu, data);
+	}
+
 	data = get_cmdsem_val(iommu);
 	build_completion_wait(&cmd, iommu, data);
 
@@ -1464,9 +1476,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
-	ret = wait_on_sem(iommu, data);
-
-	return ret;
+	return wait_on_sem(iommu, data);
 }
 
 static void domain_flush_complete(struct protection_domain *domain)
-- 
2.43.7

