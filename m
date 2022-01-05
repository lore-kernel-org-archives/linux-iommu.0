Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424F2C433EF
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 21:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E689540235;
	Wed,  5 Jan 2022 21:48:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9yzlb0zc89aL; Wed,  5 Jan 2022 21:48:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A2F9A409ED;
	Wed,  5 Jan 2022 21:48:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79D72C0072;
	Wed,  5 Jan 2022 21:48:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F673C001E;
 Wed,  5 Jan 2022 21:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B853D428F2;
 Wed,  5 Jan 2022 21:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="W9rMnsZR";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="kO2uSSXr"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id koc7vtGf3a8f; Wed,  5 Jan 2022 21:48:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A9B7428F8;
 Wed,  5 Jan 2022 21:48:29 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 73DD3580569;
 Wed,  5 Jan 2022 16:48:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 05 Jan 2022 16:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=kJxpjApBzoVvC
 kd49IN11sRCxgdbdXjwUm6fGe2ajOg=; b=W9rMnsZRyKPY8hxaUtB1n45xh/WyS
 fg4Hd6Wv7LLs3JFu45mfiZqlQkvgxYzRQXfumen4MEH/Jwzlli73/5/pvMeraycO
 9eKEoyFnpmYyLHznxRj6xK++R6NCUXFAVU8oXlPGXgxRR2Wgg3+oF6b6ZDvMahUV
 GpxYVYWNEkOoKLXIkG1rE+Bw44KmtUlQZzw9Ofns2eNpZrNWcpNgy6pLxxJrTvgU
 TVw/gddpMjYKFZxlwg7hzcuzu3rmYBYAnkK+TzJM6TLXsTeaFrdv+ytH17+QQyu5
 EiFrxm4fmZSmrLIj9T2ZcfRdSl4RWpD9X5ZT7XnA6zxCyKnNedvOIXE4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=kJxpjApBzoVvCkd49IN11sRCxgdbdXjwUm6fGe2ajOg=; b=kO2uSSXr
 joqeXbL1xK0ixZIGTvPiqETF+2nWYNLoYKVIwY6GFJd5q7eyqoaLTSADlAqszsgE
 4xC/fNTrHhSs9Nwjdv6/bJBZ/OOKplWUVcto1VtAd7FNtVL1wsjtsyWNEW6PzXDr
 lq7NT6H1BtpUP0ZnYTMnoJrAdSVOE/AdkxGW6HtbYC8YoY759LdF8HcZNChLieK9
 3eu4QU+b1qTGTIXi7R5S+K8CnkmU5UWP4pugbG6M3uA0XOPIPbcYtzJ19FwsUBsv
 5QqK9zyUkYcjCvYWg+6Pz8yZ2OWlB7yPjORFhAaPt5LxBT7V2xhsma2gSya5PG3R
 xRuXzouDZOqy8g==
X-ME-Sender: <xms:LBLWYWb8pnt3gJlcg5g-T6u79E_2Af2rLJp4znktJAE-__pTi_VPaQ>
 <xme:LBLWYZY32xYXACJ4iOhznsEnObo5voZMbZRENDWw99oD4CB017Q1TeYxO5ZY-aTp5
 cWOy6PF8b-CpdAl9Q>
X-ME-Received: <xmr:LBLWYQ_H7_hAoPoFCDBCDNBQ1XI9Qz4wuBPjK0lRmGmKoy9nzsF03AZh-zJHed0fsu2PyV1R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
 rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
 dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
 hnthdrtghomh
X-ME-Proxy: <xmx:LBLWYYqnpjM7X2z35zJm-t3130OJYUFdHO_tlxXOnhVsD1TQSGkztQ>
 <xmx:LBLWYRoW9xO3w5MQXAA1bKujGIT5_Vyhpt5YXAhpmYOM45KLBt0fNQ>
 <xmx:LBLWYWRh7uqZcmsFVJGEhb2_FFELd-RgKAJPImwBsvjCWvgwqQiRJw>
 <xmx:LBLWYfhbO5lBwGfRQ-bwsvZ5ndMJXiTlSy3f-Bq-4hnr6O5Rg9HcPw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:27 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 7/8] drivers: virtio_mem: use pageblock size as the
 minimum virtio_mem size.
Date: Wed,  5 Jan 2022 16:47:55 -0500
Message-Id: <20220105214756.91065-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105214756.91065-1-zi.yan@sent.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
MIME-Version: 1.0
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
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
 drivers/virtio/virtio_mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a6a78685cfbe..2664dc16d0f9 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2481,8 +2481,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
-			pageblock_nr_pages) * PAGE_SIZE;
+	sb_size = pageblock_nr_pages * PAGE_SIZE;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
