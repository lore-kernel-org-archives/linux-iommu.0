Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5FAC433FE
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 13:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C493183E33;
	Thu, 16 Dec 2021 13:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXAuvL7kfcEA; Thu, 16 Dec 2021 13:52:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F52F83E2E;
	Thu, 16 Dec 2021 13:52:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 363A2C0071;
	Thu, 16 Dec 2021 13:52:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0580C0012;
 Thu, 16 Dec 2021 08:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 799DF60F20;
 Thu, 16 Dec 2021 08:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZjpmucuDemo6; Thu, 16 Dec 2021 08:39:20 +0000 (UTC)
X-Greylist: delayed 00:05:58 by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtpbg604.qq.com (smtpbg604.qq.com [59.36.128.82])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFAF560ED1;
 Thu, 16 Dec 2021 08:39:18 +0000 (UTC)
X-QQ-mid: bizesmtp42t1639643591t2wqagec
Received: from wangx.lan (unknown [218.88.124.63])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 16 Dec 2021 16:33:04 +0800 (CST)
X-QQ-SSF: 0100000000200090C000000A0000000
X-QQ-FEAT: 3uawQE1sH+3zorxK16b2U3h6zpzpeZk3B/nEX8RAutKOb06jgtfo0MhcLoUzX
 ntE9sw3AHToNqGmUa1vNX544/C5xpkLhwBAH2kMj0GjcU6/w7aV/wGYZJv+liXhkHXQIikv
 4SUIpGndU7eBB3TLkdS6h+U+kq5y+BIDi8G3J74QfXBU4kDF50keElPOSIrau2Ko8Nx/6WW
 dul0ix7j8+7621vzgdfkat5lfKuczi0vA/V6uKlB/bw0lfjoKChMC2TYbA0gmFEkuitN0TB
 iQdcpnWhGxqq+vJg80fq31EkwU3I2wUh3QxDWqxcRkKHf6dfsQGvy/CANIKlIbDr4+EFZQ8
 vvS8TEBCddi5I2v2U2412pX9La9Bw==
X-QQ-GoodBg: 0
From: Xiang wangx <wangxiang@cdjrlc.com>
To: will@kernel.org
Subject: [PATCH] iommu/virtio: Fix typo in a comment
Date: Thu, 16 Dec 2021 16:33:02 +0800
Message-Id: <20211216083302.18049-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
X-Mailman-Approved-At: Thu, 16 Dec 2021 13:52:26 +0000
Cc: jean-philippe@linaro.org, Xiang wangx <wangxiang@cdjrlc.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org
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

The double `as' in a comment is repeated, thus it should be removed.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index c9e8367d2962..162bd07e32fe 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -743,7 +743,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	/*
 	 * In the virtio-iommu device, when attaching the endpoint to a new
-	 * domain, it is detached from the old one and, if as as a result the
+	 * domain, it is detached from the old one and, if as a result the
 	 * old domain isn't attached to any endpoint, all mappings are removed
 	 * from the old domain and it is freed.
 	 *
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
