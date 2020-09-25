Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3956C47423
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 14:12:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D72208A9
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 14:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c5dlImAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D72208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4826C86CC5;
	Fri, 25 Sep 2020 14:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RmBSYDPNFLCT; Fri, 25 Sep 2020 14:12:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7DA6686CE0;
	Fri, 25 Sep 2020 14:12:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69F84C1AD6;
	Fri, 25 Sep 2020 14:12:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06569C1AD5
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E888D875EE
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GWWwoibb3Lb for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 14:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5FC66875D3
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:12:38 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200925141236euoutp025b09f30314e3456a599354d6cd13d830~4DEShNhfs0580805808euoutp02B
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:12:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200925141236euoutp025b09f30314e3456a599354d6cd13d830~4DEShNhfs0580805808euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1601043156;
 bh=A2laEXZodce4y5WBoAT6Pjadi2R3gn3tegjGhZC+nCo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c5dlImAAGjXOLALkzLSxco9t+hTfogWjaJOeNlQGh/CgYJrjw6R1p5pLqLivUlPcX
 Kt6aPDPww8d7smnGyynpZya+ZyDxqhiLYVK8fJtXndWO6fLSJOiWe4u3ZoLiMfilnp
 Q/cnMeLsA4XspYMcPoV9wWiYMaLush7x3iSeRnkM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200925141235eucas1p2c0fd6d41a1e32313a7f76616c49dff0d~4DERuK1tA3259232592eucas1p24;
 Fri, 25 Sep 2020 14:12:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 0E.49.05997.3DAFD6F5; Fri, 25
 Sep 2020 15:12:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200925141235eucas1p17c6aceae82acfc424cdc7521938c1510~4DERWTSVx1940819408eucas1p1q;
 Fri, 25 Sep 2020 14:12:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200925141235eusmtrp2e2c691b27fc90284bfacfb0221b2003a~4DERVo8Ja2568825688eusmtrp2K;
 Fri, 25 Sep 2020 14:12:35 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-0a-5f6dfad3ea5b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.49.06314.3DAFD6F5; Fri, 25
 Sep 2020 15:12:35 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200925141234eusmtip1f8fd73db4a18c7c8418ebe0d2e207e9a~4DEQwxQIX1229912299eusmtip10;
 Fri, 25 Sep 2020 14:12:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 8/8] media: platform: s5p-mfc: use DMA_ATTR_LOW_ADDRESS
Date: Fri, 25 Sep 2020 16:12:18 +0200
Message-Id: <20200925141218.13550-9-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925141218.13550-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87qXf+XGGyw/KG+xccZ6VouVq48y
 WSzYb23ROXsDu8X580Di8q45bBY9G7ayWsw4v4/JYu2Ru+wWBz88YbVof/qS2eJz6z82Bx6P
 JwfnMXmsmbeG0WN2w0UWj02rOtk8Jt9Yzuix+2YDm0ffllWMHp83yQVwRHHZpKTmZJalFunb
 JXBlTLg6kblgO0/FrKM2DYzbuLoYOTkkBEwkrq87wdTFyMUhJLCCUeLp8pmsEM4XRomrv/qZ
 IZzPjBKPfs5nhGnZfHEpG0RiOaPE8lkHGOFaXu6fyA5SxSZgKNH1tguoioNDRKBEYtkJPpAa
 ZoEnTBJ7/i5kAqkRFnCX2Nj/Hmwqi4CqxKZPk1lAbF4BW4lHr0B6QbbJS6zecIAZxOYUsJN4
 eBFimYTAKnaJn4ufMEMUuQAl/rBC2MISr45vYYewZST+75zPBNHQzCjx8Nxadginh1HictMM
 qIesJe6c+wV2KrOApsT6XfoQYUeJfY9fsoOEJQT4JG68FQQJMwOZk7ZNZ4YI80p0tAlBVKtJ
 zDq+Dm7twQuXoEo8JJ7O8QcJCwlMZJSYNN9/AqP8LIRVCxgZVzGKp5YW56anFhvlpZbrFSfm
 Fpfmpesl5+duYgQmnNP/jn/ZwbjrT9IhRgEORiUeXoWnufFCrIllxZW5hxglOJiVRHidzp6O
 E+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoGxWW3j5sf9
 Na7qCp8/b3kf/HAh6557Qi/mlvh823YxepaHlr8UW9txhboWjQuXZrJxnzWaX7T33tytkixu
 WvfTd6/srSr5xZckf/OZ7pHjmbf5p4pm/VaZn3znS9lc1VtOvGVXXm0X39hx7NkL/ev/JQUr
 z4XWzHcx7H2VK/jn54T+1d/ruu7NUmIpzkg01GIuKk4EACwFlBw0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4Xd3Lv3LjDdr3M1tsnLGe1WLl6qNM
 Fgv2W1t0zt7AbnH+PJC4vGsOm0XPhq2sFjPO72OyWHvkLrvFwQ9PWC3an75ktvjc+o/Ngcfj
 ycF5TB5r5q1h9JjdcJHFY9OqTjaPyTeWM3rsvtnA5tG3ZRWjx+dNcgEcUXo2RfmlJakKGfnF
 JbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZE65OZC7YzlMx66hNA+M2
 ri5GTg4JAROJzReXsnUxcnEICSxllFh9+iwLREJG4uS0BlYIW1jiz7UuqKJPjBLnLz1kAkmw
 CRhKdL0FSXByiAiUSXRc2coMUsQs8IZJ4u6rH+wgCWEBd4mN/e8ZQWwWAVWJTZ8mg23gFbCV
 ePQKollCQF5i9YYDzCA2p4CdxMOLB4DqOYC22Ursf+g0gZFvASPDKkaR1NLi3PTcYkO94sTc
 4tK8dL3k/NxNjMAI2Hbs5+YdjJc2Bh9iFOBgVOLhPfEoN16INbGsuDL3EKMEB7OSCK/T2dNx
 QrwpiZVVqUX58UWlOanFhxhNgW6ayCwlmpwPjM68knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC
 6YklqdmpqQWpRTB9TBycUg2MDi373oU+l+O6xWgu3sz0qKb1hZG7OG/0PLVf7tFsfbduWpps
 fdvqHs2zSrYx5jdHnMK6OCNDq2NRUx+sr2iZart96jEBw7RPH39P310/Kf/q9kz3QM+nNoHG
 8W0skjWztdI4V02Mqzf6pXzP656faeHd7i3vrp8ItZ9luUXweHrshemlLzuVWIozEg21mIuK
 EwHdk2WglgIAAA==
X-CMS-MailID: 20200925141235eucas1p17c6aceae82acfc424cdc7521938c1510
X-Msg-Generator: CA
X-RootMTR: 20200925141235eucas1p17c6aceae82acfc424cdc7521938c1510
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200925141235eucas1p17c6aceae82acfc424cdc7521938c1510
References: <20200925141218.13550-1-m.szyprowski@samsung.com>
 <CGME20200925141235eucas1p17c6aceae82acfc424cdc7521938c1510@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Sylwester Nawrocki <snawrocki@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

S5P-MFC driver relied on the way the ARM DMA-IOMMU glue code worked -
mainly it relied on the fact that the allocator used first-fit algorithm
and the first allocated buffer were at 0x0 DMA/IOVA address. This is not
true for the generic IOMMU-DMA glue code that will be used for ARM
architecture soon, so limit the dma_mask to size of the DMA window the
hardware can use and add the needed DMA attribute to force proper IOVA
allocation of the firmware buffer.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index eba2b9f040df..171fd9fd22e4 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1199,8 +1199,12 @@ static int s5p_mfc_configure_common_memory(struct s5p_mfc_dev *mfc_dev)
 	if (!mfc_dev->mem_bitmap)
 		return -ENOMEM;
 
-	mfc_dev->mem_virt = dma_alloc_coherent(dev, mem_size,
-					       &mfc_dev->mem_base, GFP_KERNEL);
+	/* MFC v5 can access memory only via the 256M window */
+	if (exynos_is_iommu_available(dev) && !IS_MFCV6_PLUS(mfc_dev))
+		dma_set_mask_and_coherent(dev, SZ_256M - 1);
+
+	mfc_dev->mem_virt = dma_alloc_attrs(dev, mem_size, &mfc_dev->mem_base,
+					    GFP_KERNEL, DMA_ATTR_LOW_ADDRESS);
 	if (!mfc_dev->mem_virt) {
 		kfree(mfc_dev->mem_bitmap);
 		dev_err(dev, "failed to preallocate %ld MiB for the firmware and context buffers\n",
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
