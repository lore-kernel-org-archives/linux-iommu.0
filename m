Return-Path: <SRS0=42j6=W7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FF7C3A5A7
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 06:41:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573E722CF5
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 06:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573E722CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 984511067;
	Wed,  4 Sep 2019 06:41:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B9BF1F19
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 03:04:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3578A887
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 03:04:24 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id ACDD0E8BC4200A95E5CD;
	Wed,  4 Sep 2019 11:04:21 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
	DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server
	id 14.3.439.0; Wed, 4 Sep 2019 11:04:14 +0800
From: zhong jiang <zhongjiang@huawei.com>
To: <davem@davemloft.net>, <herbert@gondor.apana.org.au>, <arno@natisbad.org>, 
	<joro@8bytes.org>, <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] crypto: marvell: Use kzfree rather than its implementation
Date: Wed, 4 Sep 2019 11:01:17 +0800
Message-ID: <1567566079-7412-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1567566079-7412-1-git-send-email-zhongjiang@huawei.com>
References: <1567566079-7412-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 04 Sep 2019 06:40:59 +0000
Cc: iommu@lists.linux-foundation.org, zhongjiang@huawei.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Use kzfree instead of memset() + kfree().

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/crypto/marvell/hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/hash.c b/drivers/crypto/marvell/hash.c
index 0f0ac85..a2b35fb 100644
--- a/drivers/crypto/marvell/hash.c
+++ b/drivers/crypto/marvell/hash.c
@@ -1148,8 +1148,7 @@ static int mv_cesa_ahmac_pad_init(struct ahash_request *req,
 		}
 
 		/* Set the memory region to 0 to avoid any leak. */
-		memset(keydup, 0, keylen);
-		kfree(keydup);
+		kzfree(keydup);
 
 		if (ret)
 			return ret;
-- 
1.7.12.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
