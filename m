Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57527C43217
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 19:55:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F24861B51
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 19:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F24861B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35AE1607BA;
	Mon, 15 Nov 2021 19:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAClqentNJvK; Mon, 15 Nov 2021 19:55:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E157A607BB;
	Mon, 15 Nov 2021 19:55:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17926C0032;
	Mon, 15 Nov 2021 19:55:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC56C0012;
 Mon, 15 Nov 2021 19:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 878DB80C79;
 Mon, 15 Nov 2021 19:46:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="Ed1fz5Ur";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="A4kmEJ1u"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kWm1L0j_ZgQm; Mon, 15 Nov 2021 19:46:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83BCE80D44;
 Mon, 15 Nov 2021 19:46:00 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id E184A5805B1;
 Mon, 15 Nov 2021 14:37:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 15 Nov 2021 14:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:reply-to:mime-version
 :content-transfer-encoding; s=fm2; bh=orTWr/BdFPg59h4hngLif2VhgL
 B0bl+rFHZpRRyIkS0=; b=Ed1fz5UrkY2HQYKDvFsL0C7TFBad1qpGnzrhTYEF98
 KYuyT3C6YrqBfrBYHy5ug+pBvAyxQ9UGWT2ebj7Q05NFslhNaL7PQda+4qZi8H4j
 UmX2z3ghjiwLir/83wjyS5DiCKwP1f0PVZsqJ5vC97JLFBZGIC9tgqeyvT8nbAoG
 j15IXPObAN8p5piwWNUyljS9qw1IbngUmC5K5eC9j223Q0beaRbwr7U/UnjbjDj9
 T+UoBHPE2Iyd5z++uBPQ2sVHoVFSnMfTfD5G5LUyv0oLN2Qv1oBvNxOJFHP/vJWh
 ZREZtNLZ+aeqDWNSZ325NYGpEDahpCeefqEXz3idyzKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:reply-to:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=orTWr/
 BdFPg59h4hngLif2VhgLB0bl+rFHZpRRyIkS0=; b=A4kmEJ1ugobNUsOlhtU9Ik
 Vb7h5/Y2ujIFuSMek1uU+5yqMBc4Zk8fQgiFUYIrt1EeSXvzeTWMqOZMgwFbg1jX
 H6CFQswsi6GNSyIfemmH4VETAewa4eEpVybaxyQ5Wkeg+Wi5Es0i9W73AqcEbetT
 YncaPU0a3cxLloc4ujX4Xf/vBA1j51tonN1oD+5b0bdDrIoRi1MhmZ0ELSBuM11G
 w4hcEHpAFl5VRHqnSGTA9Mr5R3bLIl8qnelTsIrcnpHryU7BOKQG6DoOR94mOdkH
 zh++T/Fm0ls+BQmlMwPCffSNO3tQmODoFvG9tE6yVnf1U8X/HepwE8u6EipnVZhw
 ==
X-ME-Sender: <xms:C7eSYVXFk7JmR9-1n-lfZNecRv0L2HfJvcd9GZIEJeaEcwTxkcY5cw>
 <xme:C7eSYVl_h7QJsI-RfFnobMcPfT7N8UNLbsLNZuKe76VIpV9nfWCWWOg9Q-kCQlxbs
 seUqVGwX7mU3oTSXA>
X-ME-Received: <xmr:C7eSYRaHhyU-FxOxc_yzKNnpWM8qbnNEeyNn_Bg_on1LJzAk0pJr1s447nOnDYdGZ6B6AweR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
 uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteeiiedtje
 fghfefueekjedvueeftddvudelhfetudffiefgfeetheeghfdvgedunecuffhomhgrihhn
 pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:C7eSYYW0PZ-OaD6zFoQJg2937ANlsMaGnaz86EkAFahT-usXJa0ssw>
 <xmx:C7eSYfkeVTrkSW9plAacUahXN7oJnoopoWkV6nDN80Fcwuvfih28oQ>
 <xmx:C7eSYVeChEzqCpejz1a6-1nlYfnXpTIZR_hoK4SVdTUqtd3rZdDfow>
 <xmx:DLeSYYgAbbOso3y3JuXIID0BiejBpUjgP3A8s-Tdof442Ed_vIBzYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Nov 2021 14:37:47 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/3] Use pageblock_order for cma and alloc_contig_range
 alignment.
Date: Mon, 15 Nov 2021 14:37:21 -0500
Message-Id: <20211115193725.737539-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
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

Hi David,

You suggested to make alloc_contig_range() deal with pageblock_order instead of
MAX_ORDER - 1 and get rid of MAX_ORDER - 1 dependency in virtio_mem[1]. This
patchset is my attempt to achieve that. Please take a look and let me know if
I am doing it correctly or not.

From what my understanding, cma required alignment of
max(MAX_ORDER - 1, pageblock_order), because when MIGRATE_CMA was introduced,
__free_one_page() does not prevent merging two different pageblocks, when
MAX_ORDER - 1 > pageblock_order. But current __free_one_page() implementation
does prevent that. It should be OK to just align cma to pageblock_order.
alloc_contig_range() relies on MIGRATE_CMA to get free pages, so it can use
pageblock_order as alignment too.

In terms of virtio_mem, if I understand correctly, it relies on
alloc_contig_range() to obtain contiguous free pages and offlines them to reduce
guest memory size. As the result of alloc_contig_range() alignment change,
virtio_mem should be able to just align PFNs to pageblock_order.

Thanks.


[1] https://lore.kernel.org/linux-mm/28b57903-fae6-47ac-7e1b-a1dd41421349@redhat.com/

Zi Yan (3):
  mm: cma: alloc_contig_range: use pageblock_order as the single
    alignment.
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |  4 +---
 drivers/virtio/virtio_mem.c                |  6 ++----
 include/linux/mmzone.h                     |  5 +----
 kernel/dma/contiguous.c                    |  2 +-
 mm/cma.c                                   |  6 ++----
 mm/page_alloc.c                            | 12 +++++-------
 6 files changed, 12 insertions(+), 23 deletions(-)

-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
