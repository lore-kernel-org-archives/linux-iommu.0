Return-Path: <SRS0=W7UB=FK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D89EC433FE
	for <iommu@archiver.kernel.org>; Sun,  6 Dec 2020 14:58:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C7B22D08
	for <iommu@archiver.kernel.org>; Sun,  6 Dec 2020 14:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C7B22D08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7C95686D06;
	Sun,  6 Dec 2020 14:58:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zHGhWsCf7D5c; Sun,  6 Dec 2020 14:58:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC2FD86CEF;
	Sun,  6 Dec 2020 14:58:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD875C0893;
	Sun,  6 Dec 2020 14:58:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 317F5C013B
 for <iommu@lists.linux-foundation.org>; Sun,  6 Dec 2020 09:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1C24A86A5D
 for <iommu@lists.linux-foundation.org>; Sun,  6 Dec 2020 09:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bo_cQzdSRmoW for <iommu@lists.linux-foundation.org>;
 Sun,  6 Dec 2020 09:50:21 +0000 (UTC)
X-Greylist: delayed 00:06:22 by SQLgrey-1.7.6
Received: from zg8tmtm5lju5ljm3lje2naaa.icoremail.net
 (zg8tmtm5lju5ljm3lje2naaa.icoremail.net [139.59.37.164])
 by fraxinus.osuosl.org (Postfix) with SMTP id B6B6986A5C
 for <iommu@lists.linux-foundation.org>; Sun,  6 Dec 2020 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-Id; bh=Rn+s176T+b0b7abg9LOATZ7bU+jEonK9aGIm4/7ezkM=;
 b=b1VT2DEKouHoJ6Fx8Obex1aWG1jSzBmZr2z/Rr8TS+zXvLb4Y9SUTyjYaQR3lb
 y5CN7UJiJ83phxJKGWOUMZ5rLeuKQ1JZ1q4SBv/Z9C0/1KqKBtl/xeYKRjAwYsjo
 GO2CWsP4yMo6yicBC0ZT9M3uzkmLdI/0tjdXkkNPKedcA=
Received: from ubuntu.localdomain (unknown [166.111.83.82])
 by web3 (Coremail) with SMTP id ygQGZQBXPgrYp8xf5chCAA--.59458S4;
 Sun, 06 Dec 2020 17:43:52 +0800 (CST)
From: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] drivers/iommu: fix a null-ptr-deref bug in msm_iommu.c
Date: Sun,  6 Dec 2020 01:43:51 -0800
Message-Id: <20201206094351.47860-1-tzh18@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: ygQGZQBXPgrYp8xf5chCAA--.59458S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1xZrW5tFWUtF4ruF1kuFg_yoWfJwb_CF
 yrZr97Jr17JFsrCF12vr1fur90kw1vvrn3GFWvg3Z3WryUWr17J3yjvrWUGay7urW7XFyj
 vr9rCF1fArW7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
 1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
 4I1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
 ZEXa7VUjCD73UUUUU==
X-CM-SenderInfo: pw2kimo6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgICEV7nE6Rz3QABsy
X-Mailman-Approved-At: Sun, 06 Dec 2020 14:58:51 +0000
Cc: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
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

At line 600 in drivers/iommu/msm_iommu.c, the ret-val of kzalloc should be checked to avoid null-ptr-deref bug.

Signed-off-by: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
---
 drivers/iommu/msm_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3615cd6241c4..e3c576e5babb 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -598,6 +598,10 @@ static void insert_iommu_master(struct device *dev,
 
 	if (list_empty(&(*iommu)->ctx_list)) {
 		master = kzalloc(sizeof(*master), GFP_ATOMIC);
+		if (!master) {
+			dev_err(dev, "Failed to allocate IOMMU context bank instance\n");
+			return;
+		}
 		master->of_node = dev->of_node;
 		list_add(&master->list, &(*iommu)->ctx_list);
 		dev_iommu_priv_set(dev, master);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
