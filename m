Return-Path: <SRS0=OQ2u=LU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EECC49EA7
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 07:27:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C833861883
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 07:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C833861883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B0B460645;
	Sat, 26 Jun 2021 07:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1J2BMJ8Ayz6X; Sat, 26 Jun 2021 07:27:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 974536064D;
	Sat, 26 Jun 2021 07:27:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73EAEC001A;
	Sat, 26 Jun 2021 07:27:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7344BC000E
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 07:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52784836EA
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 07:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5dMfNJ7ybD1v for <iommu@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 07:27:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4851836AE
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 07:27:08 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBljH58MFz74Wq;
 Sat, 26 Jun 2021 15:23:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:02 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:01 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/9] dma-debug: Use memory_intersects() directly
Date: Sat, 26 Jun 2021 15:34:39 +0800
Message-ID: <20210626073439.150586-10-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

Use memory_intersects() directly instead of private overlap() function.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/dma/debug.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 14de1271463f..8ef737223999 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1066,20 +1066,10 @@ static void check_for_stack(struct device *dev,
 	}
 }
 
-static inline bool overlap(void *addr, unsigned long len, void *start, void *end)
-{
-	unsigned long a1 = (unsigned long)addr;
-	unsigned long b1 = a1 + len;
-	unsigned long a2 = (unsigned long)start;
-	unsigned long b2 = (unsigned long)end;
-
-	return !(b1 <= a2 || a1 >= b2);
-}
-
 static void check_for_illegal_area(struct device *dev, void *addr, unsigned long len)
 {
-	if (overlap(addr, len, _stext, _etext) ||
-	    overlap(addr, len, __start_rodata, __end_rodata))
+	if (memory_intersects(_stext, _etext, addr, len) ||
+	    memory_intersects(__start_rodata, __end_rodata, addr, len))
 		err_printk(dev, NULL, "device driver maps memory from kernel text or rodata [addr=%p] [len=%lu]\n", addr, len);
 }
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
