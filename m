Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A1C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 04:16:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C21F2073C
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 04:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C21F2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B1EC320460;
	Tue, 15 Dec 2020 04:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LzwSbXuHp6OJ; Tue, 15 Dec 2020 04:16:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E34C2036D;
	Tue, 15 Dec 2020 04:16:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2558FC0893;
	Tue, 15 Dec 2020 04:16:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DBE6C013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 04:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 71CBA20004
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 04:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AuK3xb7CAQ46 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 04:16:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from zg8tmtm5lju5ljm3lje2naaa.icoremail.net
 (zg8tmtm5lju5ljm3lje2naaa.icoremail.net [139.59.37.164])
 by silver.osuosl.org (Postfix) with SMTP id 87F082036D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 04:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-Id; bh=aFnvhUbmFFRHDhH5UTUcQw+Cc0RvtAWozpc67AxYY88=;
 b=DITzt7dsocvuQgw64tC35NGRHUQGw9O//FOTBWbqWqMKjUIjMbXc5X8Xwvn3AP
 yk6oj5PLxX5BWufUxA8tebiwF7b85OApKL7UWk3vfyEzSts/xUVhgWEb3VF0Bm2O
 AaVuViwyC0OJAAp2rmvo0rtxeiICigl/DSVtvf8tgNkEY=
Received: from ubuntu.localdomain (unknown [166.111.83.82])
 by web5 (Coremail) with SMTP id zAQGZQDHO0NvONhfutFGAA--.33905S4;
 Tue, 15 Dec 2020 12:15:43 +0800 (CST)
From: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] drivers/iommu: fix null-ptr-deref bug of rk_iommu_from_dev's
 ret-val
Date: Mon, 14 Dec 2020 20:15:41 -0800
Message-Id: <20201215041541.47373-1-tzh18@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zAQGZQDHO0NvONhfutFGAA--.33905S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr48Jry7AryUJrW7uFWxJFb_yoWDuFX_C3
 4xur9xWr48Jr45C3Wjqr93Zr97KwsIvF9xWFyjkw4rJFyDXr1qkFy5Xr47Aay7Ww1jyFy0
 9ryUua1xCFW3JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
 rcIFxwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
 IFyTuYvjfU8EfOUUUUU
X-CM-SenderInfo: pw2kimo6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEKEV7nE7LiIgADsA
Cc: Sugar <tzh18@mails.tsinghua.edu.cn>
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

From: Sugar <tzh18@mails.tsinghua.edu.cn>

we should check the ret-val of function rk_iommu_from_dev to avoid null-ptr-deref.

Signed-off-by: Sugar <tzh18@mails.tsinghua.edu.cn>
---
 drivers/iommu/rockchip-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index e5d86b7177de..311d9eec06f4 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1064,6 +1064,9 @@ static struct iommu_device *rk_iommu_probe_device(struct device *dev)
 		return ERR_PTR(-ENODEV);
 
 	iommu = rk_iommu_from_dev(dev);
+	if (!iommu) {
+		return ERR_PTR(-ENODEV);
+	}
 
 	data->link = device_link_add(dev, iommu->dev,
 				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
@@ -1083,6 +1086,9 @@ static struct iommu_group *rk_iommu_device_group(struct device *dev)
 	struct rk_iommu *iommu;
 
 	iommu = rk_iommu_from_dev(dev);
+	if (!iommu) {
+		return ERR_PTR(-ENODEV);
+	}
 
 	return iommu_group_ref_get(iommu->group);
 }
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
