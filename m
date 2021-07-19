Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_REPLYTO,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02D7C12002
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 06:01:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C9E60FE9
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 06:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C9E60FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38B63836F1;
	Mon, 19 Jul 2021 06:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vhlos5nYGpIz; Mon, 19 Jul 2021 06:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2B402836D5;
	Mon, 19 Jul 2021 06:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEBC2C0010;
	Mon, 19 Jul 2021 06:01:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96259C000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 06:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F10940407
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 06:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=fudan.edu.cn
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50-OYZHBre8b for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 06:01:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net
 (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
 by smtp4.osuosl.org (Postfix) with SMTP id 00212403AC
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 06:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id; bh=OHtXPeheLKt25R6qdl+TNvmKAmxTmqb0MxhK2ixgViI=; b=X
 IbDjUKJcxKOQTCFX0mso/24KvENgvOGgZ2lbFLgvHyKIJ9x6OH89tPvmd+7JGKgJ
 ZiVD656QfGsMr9LNHF90JXGz63zH0Q3ijIF5S63EG1cL8xB2lE7J04HGsjJe9JXI
 JGFn+aGJyLbDfCtp1LzFS2DxMz+9nbdeXC0H0BDFQo=
Received: from localhost.localdomain (unknown [10.162.86.133])
 by app2 (Coremail) with SMTP id XQUFCgAn32gHFfVgD0joBA--.1817S3;
 Mon, 19 Jul 2021 14:00:40 +0800 (CST)
To: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Convert from atomic_t to refcount_t on
 device_state->count
Date: Mon, 19 Jul 2021 14:00:37 +0800
Message-Id: <1626674437-56007-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgAn32gHFfVgD0joBA--.1817S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZFykZr15CF15Jwb_yoW8Kr1kpF
 4DGFy5KFW8Xrn7Kr13Aw17ur90g34kZ3yfKryjy3s7KFy3J3y5K3WkZFy7ArWUJFZ3Zry7
 X3Wj9rs5uayjgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x0JUqFALUUUUU=
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
 drivers/iommu/amd/iommu_v2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index f8d4ad421e07..15d64f916fe5 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt)     "AMD-Vi: " fmt
 
+#include <linux/refcount.h>
 #include <linux/mmu_notifier.h>
 #include <linux/amd-iommu.h>
 #include <linux/mm_types.h>
@@ -51,7 +52,7 @@ struct pasid_state {
 struct device_state {
 	struct list_head list;
 	u16 devid;
-	atomic_t count;
+	refcount_t count;
 	struct pci_dev *pdev;
 	struct pasid_state **states;
 	struct iommu_domain *domain;
@@ -113,7 +114,7 @@ static struct device_state *get_device_state(u16 devid)
 	spin_lock_irqsave(&state_lock, flags);
 	dev_state = __get_device_state(devid);
 	if (dev_state != NULL)
-		atomic_inc(&dev_state->count);
+		refcount_inc(&dev_state->count);
 	spin_unlock_irqrestore(&state_lock, flags);
 
 	return dev_state;
@@ -144,7 +145,7 @@ static void free_device_state(struct device_state *dev_state)
 
 static void put_device_state(struct device_state *dev_state)
 {
-	if (atomic_dec_and_test(&dev_state->count))
+	if (refcount_dec_and_test(&dev_state->count))
 		wake_up(&dev_state->wq);
 }
 
@@ -765,7 +766,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	for (dev_state->pasid_levels = 0; (tmp - 1) & ~0x1ff; tmp >>= 9)
 		dev_state->pasid_levels += 1;
 
-	atomic_set(&dev_state->count, 1);
+	refcount_set(&dev_state->count, 1);
 	dev_state->max_pasids = pasids;
 
 	ret = -ENOMEM;
@@ -856,7 +857,7 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 	 * Wait until the last reference is dropped before freeing
 	 * the device state.
 	 */
-	wait_event(dev_state->wq, !atomic_read(&dev_state->count));
+	wait_event(dev_state->wq, !refcount_read(&dev_state->count));
 	free_device_state(dev_state);
 }
 EXPORT_SYMBOL(amd_iommu_free_device);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
