Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D5C43214
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC3360F23
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBC3360F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABB1F83AE9;
	Fri, 23 Jul 2021 21:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6K1RhRfTMdTP; Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84AF582F92;
	Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 637E9C0010;
	Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98E03C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83CE460A3E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BvJbtgihEl30 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 21:40:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1573A60720
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1627076436; x=1658612436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TtAadJ6hGLCmc033TEnWfjUBgRsF/DZxBUrEEIez1Fo=;
 b=f+nu0/CdxWwarErcZi4FgffE9SA7p80eptXiZ/Z1mdzqrCrwKsmi7HMS
 8Yw8Xrwz/h/bHq82XXP9hUxjjl0JLozLp/WcXMGcL5eDtGCUyoyP4uTAq
 2pMzWvVKt00TQ7UF6AlcvUHfkUeMvjzZKavIUXr5MVCH9RpNG2gsWCsaY
 /tCDYDc27fjwCuPPglupMUAoNu0J4HAmd2GXcbQNMPM7vJfOqu2ftix+B
 wgFgadYzCD8r1EFR1tqZHf0AK5OkNVc/vsuDv8VE+9Ck8wf6WH4SgLWjU
 L8zGks/8yHE2bqk5SlyhYD7TQByNmQlsoftAgh118OA6G/0YMUxWMi04b A==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; d="scan'208";a="279198455"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:36 +0800
IronPort-SDR: MEtxWDUrR7OY2iqDlN2CpqmRA2klWW1vVLyTHp8zwRmlS89ictk3j+ZOa7fgugiwZdy5Xbnj9+
 VGjJV3QDmJhjywKg/e6551Fnfl9B/kZH6AvQp9wdXUGPhj2aLHUhZzl+Ux1rkIwiCnSkutnVTh
 4e8dEoL7YsjMoDNtaI3VwqDfegf2jDIiyXHfh6mGik2nPAea3/HZ6Ujz74uCpjwYdV5OLxkRdI
 zQKJ+1MblqlDnUtXZijNI8mOT/FFYc3ZNnIapvHknZAoM+hc7Jgbcx28sWDdru3XRbye1CQvmy
 3fIctP2RxqdkfxffE5/+0oVt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 14:18:25 -0700
IronPort-SDR: iht1k14TXaRgYuHcExQMxXDvBJ3lM+d2qFu0HNLMP/m1Lxt3+sb+N39um9cWnSgGv+xK+oULw8
 GD+comDzjiA03Yi/yzbvF1tLI9LK7/uFKDc61+UxJ+unNE4NlgItR+mWHeop/k1FW+LDY1iGkv
 bIRs/GghVxg/KlDKAwSOAE56h8UurPmyEwvBnYOlWDOK8rQ6pIUqNcTdfmUWYQvtbTUB8AstNj
 ybmzgG1fG/v3JWXcN82OQ0gkWAp2DRz2Ef6vAOkDxAxJMNcx1b1yxxQEbRI/2TozKavkbY18h1
 UWw=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:36 -0700
From: Atish Patra <atish.patra@wdc.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 2/5] of: Move of_dma_get_range to of_address.h
Date: Fri, 23 Jul 2021 14:40:28 -0700
Message-Id: <20210723214031.3251801-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
References: <20210723214031.3251801-1-atish.patra@wdc.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Tobias Klauser <tklauser@distanz.ch>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Atish Patra <atish.patra@wdc.com>,
 iommu@lists.linux-foundation.org, Guo Ren <guoren@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>
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

Currently, of_dma_get_range is kept in of_private.h as it is used by only
OF support code.

Move it to of_address.h so that it can be used by the code outside OF
support code.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/of/of_private.h    | 10 ----------
 include/linux/of_address.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 631489f7f8c0..f65f801e3aae 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -160,16 +160,6 @@ extern int of_bus_n_addr_cells(struct device_node *np);
 extern int of_bus_n_size_cells(struct device_node *np);
 
 struct bus_dma_region;
-#if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
-int of_dma_get_range(struct device_node *np,
-		const struct bus_dma_region **map);
-#else
-static inline int of_dma_get_range(struct device_node *np,
-		const struct bus_dma_region **map)
-{
-	return -ENODEV;
-}
-#endif
 
 void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 45598dbec269..0e20f85850fc 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -154,4 +154,16 @@ static inline const __be32 *of_get_pci_address(struct device_node *dev, int bar_
 	return __of_get_address(dev, -1, bar_no, size, flags);
 }
 
+struct bus_dma_region;
+#if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
+int of_dma_get_range(struct device_node *np,
+		const struct bus_dma_region **map);
+#else
+static inline int of_dma_get_range(struct device_node *np,
+		const struct bus_dma_region **map)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* __OF_ADDRESS_H */
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
