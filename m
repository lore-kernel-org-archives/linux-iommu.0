Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC6C4320E
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 15:57:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310F561165
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 15:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 310F561165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BBA840556;
	Fri,  6 Aug 2021 15:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1uTFYABqOVc; Fri,  6 Aug 2021 15:56:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D408A404C4;
	Fri,  6 Aug 2021 15:56:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DE23C0020;
	Fri,  6 Aug 2021 15:56:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC5F5C0010
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 15:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5F9F6072D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 15:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="W22TqInL";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="XPy1aHZ+"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wC3qMfELdhRk for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 15:56:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D46636076A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 15:56:54 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 2F40C5C013A;
 Fri,  6 Aug 2021 11:56:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 06 Aug 2021 11:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=AMIOzmTfbBjLJtVqM5GdDt2D0a
 Em1Dq2sbSEs5dHEbw=; b=W22TqInLdC00j1f6nJhAgVRbAX1a68lSjGMlPqh+JI
 1UakCqLOTuNSGitf5mC+Fu7sq0uM00zjF82JiCpJxnyQov/xUUNWZrLnX7Rn1jq2
 EWLwPrif0NNyqmJjxrPntNOven8r8lBDhzVlIYyKfwQesyUPrR9VbOgu1zp1F/G7
 b5vg9qYZ/Yyjy+uxFzgq3HiM2sZSgukyT5S7Dw5fn1z7MTc2lQCxlvkvNvdu0NRI
 nob+CokYB9KXNqXU/wwSOzlgK8x27/Y3+1sqqwCNLXnJVzB7end9iPK4D1iLhfNG
 tmRr3L3EBj4xkJOD6ryRbQeW3HaYock84CNskLZpJu1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AMIOzmTfbBjLJtVqM
 5GdDt2D0aEm1Dq2sbSEs5dHEbw=; b=XPy1aHZ+0oFvvrKldeXJnEA2YDVx5y5Ec
 sA5Q0WnThLnwGzGV2M6ap+qwjgVtKYGZiR2fHbKJdzDAvonkZdM+XzPdeGfvOEV5
 l7BwwqTjQTW0ILw1M51oY7c+K6eq/gbfXxq9SrhP3gDddQvbIC7biuzbnv824dG2
 NKdmjDjdGY6j7iEagWA5RjUj1sgOdsuUFhpJNinffOAuPLgm9IEhZcIy4ZC8PmJ7
 xG24KF4VKggFRnI276K2SPlXxcbvUdIbZtAQEhEUgzg4oDdRAjG9XREZowY0IBk1
 0h1zVotBvsZAum0Gz18LxvPJ4xpXUU8Ob+NHD40MmWqdouM9L49sw==
X-ME-Sender: <xms:wlsNYdu1-rJMh7xWqRrLrNisyroDdSMjS8nrumKMcl0q34ty1hqVcQ>
 <xme:wlsNYWdM_EvUwIOW-NDf8XvriW83ceN1CAhFoRgfvwip5f9_LxlRyn_9WcM8fZW8m
 xkLt0TnIrlGUcC6InM>
X-ME-Received: <xmr:wlsNYQxqZb-EhZxxsUIjKwVQ6Egi108SPv08ZJULrlty-QpRlK-hWfW_6N6YkleffQYMpkGmhnTzlSH-vKvBdJ9EcZzHkZj_b1A9yBZ9k-dWIElTfqX3NrUbv5QUbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
 vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
 efhedufedtvdfhhedvudehtdejjeehueduffdtgfdvkedvleelueevlefgfeelgfenucff
 ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:wlsNYUNbaAsiJnd86P2N3hj3aOpJlsaZUtEuOuForfmiD4pk0E5IQg>
 <xmx:wlsNYd_RdBXYVL4ISFMIVX0dKrNCTqjL26_Q1E5x0vPqJL2hsVR3FQ>
 <xmx:wlsNYUVSxnM-RH9cuKHRJrTaZ8m52cn5EroLPTXiDRRHC2u1jADVvg>
 <xmx:w1sNYZTtsihgCZvt011YV6f4dYnnl02Gso1BrmFlzUXQygo_NldMjA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 11:56:48 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH 0/3] iommu/dma-iommu: Support IOMMU page size larger than
 the CPU page size
Date: Fri,  6 Aug 2021 17:55:20 +0200
Message-Id: <20210806155523.50429-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On the Apple M1 there's this slightly annoying situation where the DART IOMMU
has a hard-wired page size of 16KB. Additionally, the DARTs for some hardware
(USB A ports, WiFi, Ethernet, Thunderbolt PCIe) cannot be switched to bypass
mode and it's also not easily possible to program a software bypass mode.

This is a problem for kernels configured with 4K pages. Unfortunately,
most distributions ship with those by default.

There's not much that can be done for IOMMU_DOMAIN_UNMANAGED domains since
most API clients likely expect to be able to map single CPU pages.

For IOMMU_DOMAIN_DMA domains however, dma-iommu.c is the only code that
uses the raw IOMMU API to manage these domains and can possibly be adapted
to still work correctly.
Essentially, I changed some relevant alignments to happen with respect to both
PAGE_SIZE and iovad->granule. The sglist code also can't use the optimization
for a single IOVA allocation anymore since most phys_addrs will not be aligned
to the IOMMU page size.

I'd like to get some early feedback on this approach to see if it's feasible
to continue working on this or if a different approach will work better or if
this setup just won't be supported.

I'm not very confident I've covered all necessary cases but I'll take
a closer look at every function in dma-iommu.c if there's a chance that
this will be accepted eventually. The current changes are enough to boot
from a USB device and use the Ethernet adapter on my M1 Mini with 4kb pages
though.


One issue I see is that this will end up wasting memory. There's e.g.
dma_pool_*, which will dma_alloc_coherent PAGE_SIZE bytes and stuff the individual
allocations into those buffers. These will get padded to SZ_16K but dma_pool will
be completely unaware that it got 4x as much memory as requested and will leave
it unused :-(

The other issue I'm aware of is v4l2 which expects that a page-aligned sglist
can be represented contiguously in IOVA space [1].


Best,


Sven


[1] https://lore.kernel.org/linux-iommu/0d20bd6b-d0a1-019c-6398-b12f83f4fdf7@arm.com/

Sven Peter (3):
  iommu: Move IOMMU pagesize check to attach_device
  iommu/dma-iommu: Support iovad->granule > PAGE_SIZE
  iommu: Introduce __IOMMU_DOMAIN_LARGE_PAGES

 drivers/iommu/dma-iommu.c | 87 ++++++++++++++++++++++++++++++++++-----
 drivers/iommu/iommu.c     | 36 ++++++++++++++--
 drivers/iommu/iova.c      |  7 ++--
 include/linux/iommu.h     | 14 ++++---
 4 files changed, 123 insertions(+), 21 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
