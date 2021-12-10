Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3423C4332F
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 17:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EA9942393;
	Fri, 10 Dec 2021 17:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uvDIYZqqGjwE; Fri, 10 Dec 2021 17:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 58A074238D;
	Fri, 10 Dec 2021 17:55:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE1EC002F;
	Fri, 10 Dec 2021 17:55:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45672C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23C7840385
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id adjtQagvwpXU for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 17:55:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0CAFB400E8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3916613A1;
 Fri, 10 Dec 2021 09:55:03 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE04F3F73B;
 Fri, 10 Dec 2021 09:55:01 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 01/11] iommu/iova: Fix race between FQ timeout and teardown
Date: Fri, 10 Dec 2021 17:54:42 +0000
Message-Id: <ecea6835baca75b945bd8ecfaa636ff01dabcc1d.1639157090.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639157090.git.robin.murphy@arm.com>
References: <cover.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>
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

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

It turns out to be possible for hotplugging out a device to reach the
stage of tearing down the device's group and default domain before the
domain's flush queue has drained naturally. At this point, it is then
possible for the timeout to expire just *before* the del_timer() call
from free_iova_flush_queue(), such that we then proceed to free the FQ
resources while fq_flush_timeout() is still accessing them on another
CPU. Crashes due to this have been observed in the wild while removing
NVMe devices.

Close the race window by using del_timer_sync() to safely wait for any
active timeout handler to finish before we start to free things. We
already avoid any locking in free_iova_flush_queue() since the FQ is
supposed to be inactive anyway, so the potential deadlock scenario does
not apply.

Fixes: 9a005a800ae8 ("iommu/iova: Add flush timer")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
[ rm: rewrite commit message ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New to this series, picked up from:

https://lore.kernel.org/linux-iommu/1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com/

 drivers/iommu/iova.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9e8bc802ac05..920fcc27c9a1 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -83,8 +83,7 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
 	if (!has_iova_flush_queue(iovad))
 		return;
 
-	if (timer_pending(&iovad->fq_timer))
-		del_timer(&iovad->fq_timer);
+	del_timer_sync(&iovad->fq_timer);
 
 	fq_destroy_all_entries(iovad);
 
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
