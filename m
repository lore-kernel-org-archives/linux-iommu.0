Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F53C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 14:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F17AA60BD8;
	Fri, 25 Mar 2022 14:01:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXAIUVqEv25n; Fri, 25 Mar 2022 14:01:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 25BED61089;
	Fri, 25 Mar 2022 14:01:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02299C001D;
	Fri, 25 Mar 2022 14:01:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 816F9C000B
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 02:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6EBA6843FC
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 02:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mbSFDW40CTwG for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 02:16:23 +0000 (UTC)
X-Greylist: delayed 00:06:11 by SQLgrey-1.8.0
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com
 [203.205.221.149])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40B148429D
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 02:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1648174579;
 bh=qFJ1QKKq9b1Aw/+2U+A/f4XMNjTre/xqecawonGmicU=;
 h=From:To:Cc:Subject:Date;
 b=WA5Cv5g+eBOFbsYmcdvuJeqBZ5Gojpn0Ussh7UDB8RU7yPbmzhfQ4AhyyxoF67pH7
 JuByMZAj8Yi7a1ov6UJk7LrXlw5/SA2z1KtP74U5L0coQay9EHTNuhKSXKpcotcPQO
 iRiHWWXhlcu0tEkG8mJBZzxVMUjXLWR1oaT6yxLo=
Received: from localhost.localdomain ([43.227.136.188])
 by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
 id 2390880F; Fri, 25 Mar 2022 10:08:57 +0800
X-QQ-mid: xmsmtpt1648174137ts0bx8q70
Message-ID: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8lE/Tdyw2QdmN7BJTJJjH0Xf57GpNlk+aLRpaqo9Tnc8vn9EBQE
 uvvSIu0IG7AIMyM9syJpW+UFUsF0XzpelbwexNj+dRaQz1b+wEbZLcV33BnfV3ZFaYdb4SAN6BA7
 DHVnEuGP7p/4MKiGIY03JT6ORxftcQPmsq97w0UR/2dhN3yosWyqvCW200Tv8YgLgABBZ8ziYr1S
 Wq/q0ILL9wyolxRXjgkKNRjifi5xYFD5ZksOFU5m89G6/hT12dA5F8y4IcFRzJ3qiWXlEtvZvPL7
 EVp6sSa1Qz1kz5CQ0Qrc954Nb9JGHJwRJzzJiih2Ez/5rRiQ5Aovou33zGKiACdln7iUKbGnRMcs
 vafYTT7VRn9cWMVhSy0qDJ/sekeKDfZ05TrkTUBWOhIIPe5WtmX/UAthmVPgXhSvH/2tkRHpitB9
 Eu5273yxRzQV8l73jZ6UVkB0roovZqrfwCgESGaxRrJzX6qCiZIe+YAtnTf+/epRg4ggoWgVt67U
 /N/vZRWgJcnikZUaA7vbWqOyTpspDruICg7QqYKn2uUFWacjcjNFSrmGYDnXgdSHwQd+7qDofgHv
 rtq5SiFsctWlsIz/3qhQcVZ9qr+L5urfyY2MbiMzp6PO2aQlEzJX1yWr0FHzvKoJsSI05NJegCHV
 4GK5jq8UwNr+Op+55VIup7WnfkLnW8DPmqQ13yvGZS/EUHUt8QOk/sgOCyyvHDw5t6DDQeZywoOW
 n+tmWbesNhLRv+7HiW2GENUQHOgsE0JWXw3JBJzWF1HWShUTXP3kBPsWS90Xxr0KnKtu1DMAby+d
 cFZ0sCjF099qShf5pJWNN7/u4fQPNXAfd9Efw7Lj3Vb8KEeFV387Afij9QnDyL7Yky8oSWAc9sE+
 FaubL/NuDy+bzfGv4mvkkxb8Gr5w77SVzxLU3c6x4wRcmUXQqiuYPEiWZB1a3NFNS1zZHCt5WZ
From: xkernel.wang@foxmail.com
To: agross@kernel.org, bjorn.andersson@linaro.org, joro@8bytes.org,
 will@kernel.org
Subject: [PATCH] iommu/msm: add a check for the return of kzalloc()
Date: Fri, 25 Mar 2022 10:08:01 +0800
X-OQ-MSGID: <20220325020801.3301-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 25 Mar 2022 14:01:05 +0000
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Xiaoke Wang <xkernel.wang@foxmail.com>
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

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/iommu/msm_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352..697ad63 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -597,6 +597,10 @@ static void insert_iommu_master(struct device *dev,
 
 	if (list_empty(&(*iommu)->ctx_list)) {
 		master = kzalloc(sizeof(*master), GFP_ATOMIC);
+		if (!master) {
+			dev_err(dev, "Failed to allocate iommu_master\n");
+			return;
+		}
 		master->of_node = dev->of_node;
 		list_add(&master->list, &(*iommu)->ctx_list);
 		dev_iommu_priv_set(dev, master);
-- 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
