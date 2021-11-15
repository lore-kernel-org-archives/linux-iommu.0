Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6C1C433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 19:55:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B0C61B48
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 19:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68B0C61B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B6E8607C0;
	Mon, 15 Nov 2021 19:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WH_vrpnO9Fl8; Mon, 15 Nov 2021 19:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0FD99607A7;
	Mon, 15 Nov 2021 19:55:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92247C0033;
	Mon, 15 Nov 2021 19:55:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71FEFC002E;
 Mon, 15 Nov 2021 19:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C5A880D45;
 Mon, 15 Nov 2021 19:46:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="BKmBzgqZ";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="kiuzRyPO"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vEUsogzJr3k; Mon, 15 Nov 2021 19:46:00 +0000 (UTC)
X-Greylist: delayed 00:08:09 by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B8BC80C79;
 Mon, 15 Nov 2021 19:46:00 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id B7C18580602;
 Mon, 15 Nov 2021 14:37:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Mon, 15 Nov 2021 14:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=a+9SaU26Y1rPF
 GyS1WzVkAI8ORDjkq5xA8lNQwfmk18=; b=BKmBzgqZxXa0J64ox5NeMlhY+r2yw
 R7bd+SoJsM07Gtya2kdAsY2E43ShHDOPFExljfox3WCyWzjzdDL5p2mrKF5GqpHP
 EObQqiXRjtjWVrsOX6YPkS+EMZ/Dj9HyqVoyNzLOyG790gnrLGvaaLbFAYi45Cv5
 9d4Iysn8ddNcWWzrt9fAG+AGLcuGN0YxSzV+B3GjRSB9+WcSU6ReLQAmMnrc3ivN
 d3wEErrq6pvDWWQPgGkKkxQB6QC0Ox2agMWjFM4eO7PMi5v8RXaVeaRHOCVkLNf7
 lPd2C9zHaqpGhHiT3UjS/hRcPsVLqELMLeKiPpSnTvFVFaMermpNezFUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=a+9SaU26Y1rPFGyS1WzVkAI8ORDjkq5xA8lNQwfmk18=; b=kiuzRyPO
 ZvY8tTz378QI6W857EHDaRr/YZqlK7ZoAdCzorKlaow6J3+fsrwydSdhi8+BRTsi
 1pDUppUkgJUqc/kbd4oEcIYHRVOAyr2qyQIP2GLMq5f4579qt5KNqvZCgAVVpChB
 8EwJH6CagIi1WGMi9ueeQRXFlHao/J0GEWi5P9oor4kBww8Szif36j8kilN4m+UV
 yBCrAc3TR743FGxC14RxW7Eb3jwuX3L8AaZt3GGEGmh8gnTyYIigz24PvCSY1e6w
 SoCSHx7TI65v0BeW5vUFh8gkEs7ol37xzFQrfMcNSwH3MOL88eRDQlXukZ9iCxFO
 ybvB29K1ccjjkA==
X-ME-Sender: <xms:DreSYfIJvxvEnKnv0iXTG1ZnHqaExBbS5dNXkEqMEHcBSPwAZHcSXw>
 <xme:DreSYTLEVMKzLfC28MKFRjZfWWLmfwTsYI3T8DD60qsDF_nH2HJBQJuA0hVN36EQl
 ee0MKvlgCsIcUJkPQ>
X-ME-Received: <xmr:DreSYXvN1Bcf2Ojx9gLX1ndEINBNzlIYzFjpOVr5cMjaET2dnTWA3z4J7x4-zRVYWJVIPAnu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
 rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
 dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
 hnthdrtghomh
X-ME-Proxy: <xmx:DreSYYZrf7Lfn5Vv9aYD6fkO9UoSrAsOc0IMHQAQr_cenSefDMXG1g>
 <xmx:DreSYWbwpgoZtno8I5evDy4BZOmNuGbCTNHZYpJeKYTie26UmV79Yg>
 <xmx:DreSYcCb_hfqQy5bN6Km_KELJY0_KEpCiFxpX9bLUp4NRRMDwlt5ZQ>
 <xmx:DreSYcl5_mYIwYB3XdeySsJ8bS2SjPe0IWRpY4aUTo4U0rsabXItSQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Nov 2021 14:37:49 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/3] drivers: virtio_mem: use pageblock size as the
 minimum virtio_mem size.
Date: Mon, 15 Nov 2021 14:37:23 -0500
Message-Id: <20211115193725.737539-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115193725.737539-1-zi.yan@sent.com>
References: <20211115193725.737539-1-zi.yan@sent.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 Nov 2021 19:55:29 +0000
Cc: Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Zi Yan <ziy@nvidia.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
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
Reply-To: Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Zi Yan <ziy@nvidia.com>

alloc_contig_range() now only needs to be aligned to pageblock_order,
drop virtio_mem size requirement that it needs to be the max of
pageblock_order and MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 0da0af251c73..a0a0994b42e2 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2436,15 +2436,13 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
 
 	/*
-	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
-	 * pageblock_nr_pages pages. This:
+	 * We want subblocks to span at least pageblock_nr_pages pages. This:
 	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
 	 *   and fake page onlining code (virtio_mem_fake_online).
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
-			pageblock_nr_pages) * PAGE_SIZE;
+	sb_size = pageblock_nr_pages * PAGE_SIZE;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
