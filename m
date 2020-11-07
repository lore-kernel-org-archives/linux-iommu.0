Return-Path: <SRS0=7JV3=EN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB1C388F9
	for <iommu@archiver.kernel.org>; Sat,  7 Nov 2020 15:34:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A52220719
	for <iommu@archiver.kernel.org>; Sat,  7 Nov 2020 15:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A52220719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C01F4845DF;
	Sat,  7 Nov 2020 15:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iV3eDOZm2gJr; Sat,  7 Nov 2020 15:34:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5F15A845A0;
	Sat,  7 Nov 2020 15:34:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CBCEC0893;
	Sat,  7 Nov 2020 15:34:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6B56C0889
 for <iommu@lists.linux-foundation.org>; Sat,  7 Nov 2020 10:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9CE7683241
 for <iommu@lists.linux-foundation.org>; Sat,  7 Nov 2020 10:09:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bSxYBE9AjSsB for <iommu@lists.linux-foundation.org>;
 Sat,  7 Nov 2020 10:09:01 +0000 (UTC)
X-Greylist: delayed 00:05:25 by SQLgrey-1.7.6
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by whitealder.osuosl.org (Postfix) with ESMTP id B1F6986A1E
 for <iommu@lists.linux-foundation.org>; Sat,  7 Nov 2020 10:08:46 +0000 (UTC)
Received: from linux.localdomain (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx79PgcKZfrT0IAA--.19813S2; 
 Sat, 07 Nov 2020 18:03:13 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] dma-pool: no need to check return value of debugfs_create
 functions
Date: Sat,  7 Nov 2020 18:03:12 +0800
Message-Id: <1604743392-21601-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx79PgcKZfrT0IAA--.19813S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtryfZr17Ar1DGFWrur13XFb_yoWfWrb_K3
 4Iq348KwsI9a42qayxCrWfXFZ2g398KF4093Z3XrW5Kan8GFZ8Jr4xZ395Wrnxu34ktFWY
 9a4DJFZrJr1fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
 Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4D
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
 W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjhL0UUUUU
 U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Mailman-Approved-At: Sat, 07 Nov 2020 15:34:48 +0000
Cc: iommu@lists.linux-foundation.org, Xuefeng Li <lixuefeng@loongson.cn>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/dma/pool.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index d4637f7..5f84e6c 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -38,9 +38,6 @@ static void __init dma_atomic_pool_debugfs_init(void)
 	struct dentry *root;
 
 	root = debugfs_create_dir("dma_pools", NULL);
-	if (IS_ERR_OR_NULL(root))
-		return;
-
 	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
 	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
 	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
-- 
2.1.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
