Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_REPLYTO,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF12FC12002
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 08:33:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516FD611CB
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 08:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516FD611CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F85E4040E;
	Mon, 19 Jul 2021 08:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rWy0HOIu7kgm; Mon, 19 Jul 2021 08:33:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BBDAF403CD;
	Mon, 19 Jul 2021 08:33:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88CADC0010;
	Mon, 19 Jul 2021 08:33:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7325C000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 08:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8895E401F7
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 08:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=fudan.edu.cn
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJbgX6sj3he7 for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 08:33:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net
 (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
 by smtp2.osuosl.org (Postfix) with SMTP id 8123140193
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id; bh=LQJ/uWS1bkesvu2LfTETnIJmmzVsArwDVgM5l++EPps=; b=v
 IdhNSiOeXoq/hJLGkGSUy3N+cKTk9okHo8uE6I0CYWxGuZzu0HZenxWD4D95i8lo
 Sipwxu44Gp9kt72SmwQXGTnXdSDnakzWtR1thDL6rbZ6R5hK1ETGseUtHkZMlXRj
 PCdqGu7l6nSHn6UICMK4WcT/CtjlP9fVoUKKuA1AKE=
Received: from localhost.localdomain (unknown [10.162.86.133])
 by app2 (Coremail) with SMTP id XQUFCgBn4Gm8OPVgcWHpBA--.3279S3;
 Mon, 19 Jul 2021 16:33:00 +0800 (CST)
To: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Convert from atomic_t to refcount_t on
 pasid_state->count
Date: Mon, 19 Jul 2021 16:32:58 +0800
Message-Id: <1626683578-64214-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgBn4Gm8OPVgcWHpBA--.3279S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZFykZr15Xr43KFg_yoW8tFyDp3
 Z8Kry5KFWrAr1xJrnrJw4UuF9xK340vryakr98t3y5JF1akrWFq3Z8XryUArWUJFWktasx
 Zw1j9rsIya13KrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280
 aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x0JUgVyxUUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Cc: Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn,
 Xiyu Yang <xiyuyang19@fudan.edu.cn>
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
From: Xiyu Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Xiyu Yang <xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/iommu/amd/iommu_v2.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index f8d4ad421e07..a9e568276c99 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt)     "AMD-Vi: " fmt
 
+#include <linux/refcount.h>
 #include <linux/mmu_notifier.h>
 #include <linux/amd-iommu.h>
 #include <linux/mm_types.h>
@@ -33,7 +34,7 @@ struct pri_queue {
 
 struct pasid_state {
 	struct list_head list;			/* For global state-list */
-	atomic_t count;				/* Reference count */
+	refcount_t count;				/* Reference count */
 	unsigned mmu_notifier_count;		/* Counting nested mmu_notifier
 						   calls */
 	struct mm_struct *mm;			/* mm_struct for the faults */
@@ -242,7 +243,7 @@ static struct pasid_state *get_pasid_state(struct device_state *dev_state,
 
 	ret = *ptr;
 	if (ret)
-		atomic_inc(&ret->count);
+		refcount_inc(&ret->count);
 
 out_unlock:
 	spin_unlock_irqrestore(&dev_state->lock, flags);
@@ -257,14 +258,14 @@ static void free_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state(struct pasid_state *pasid_state)
 {
-	if (atomic_dec_and_test(&pasid_state->count))
+	if (refcount_dec_and_test(&pasid_state->count))
 		wake_up(&pasid_state->wq);
 }
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
-	atomic_dec(&pasid_state->count);
-	wait_event(pasid_state->wq, !atomic_read(&pasid_state->count));
+	refcount_dec(&pasid_state->count);
+	wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
 	free_pasid_state(pasid_state);
 }
 
@@ -624,7 +625,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 		goto out;
 
 
-	atomic_set(&pasid_state->count, 1);
+	refcount_set(&pasid_state->count, 1);
 	init_waitqueue_head(&pasid_state->wq);
 	spin_lock_init(&pasid_state->lock);
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
