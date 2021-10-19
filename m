Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC84DC433FE
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:38:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFA661260
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EFA661260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D16B600CC;
	Tue, 19 Oct 2021 16:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9eCyjHcjbj0a; Tue, 19 Oct 2021 16:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32678605B2;
	Tue, 19 Oct 2021 16:38:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 072C5C000F;
	Tue, 19 Oct 2021 16:38:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12C26C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01B7E82D12
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="J2L3osf5";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="LSwMOpqk"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hn3dzw7vlG5A for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:38:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 117FE80DF4
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:38:50 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 17E5D580FA5;
 Tue, 19 Oct 2021 12:38:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 19 Oct 2021 12:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=i44Zg+dk2G8UzNjKJx/clmoHyO
 7G3q1KIpDDZTV8ztk=; b=J2L3osf5Ze6kpCYL57tdnuL4nc0bObyqpKRSxx+bPe
 eh2+f/AY2OxGYdyXXlT2wjon9VI9jGfiDyTeMMF9opD890dzHeoIXehAMfss3x5O
 I+kWXK6Yawym280LGgZNIqirV63EGRx+Mi0DZlMdXTUxuLMMq0Nm6tn88aWgzsxl
 gyBwaCADxK6je+pBpp9qWzvdeVZ711VdF6SSeAmjQ18eoxGgM3HH/XbmESdLzVCF
 dNXAIrGAHRv72aPwumKF6orzsw93wv8eSLDRy6HA3F7BwsTXp2plSXBUsH4+ODjr
 IvjxJ3Q7S0whoTaUf8Ee/EObVqQ/I1TebGPEUxFxcHzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=i44Zg+dk2G8UzNjKJ
 x/clmoHyO7G3q1KIpDDZTV8ztk=; b=LSwMOpqkjE94C0FXnJLpyFfkL8ue/1aKV
 Llso7UU5GE6k3bftdiTVwvwuDQkICATTvt/Y0NnJv650UVgkP3UFY0LEsDa4hiCS
 pKcejmELgIVerx1AgCN1ZRIZY9wu6d4jq3vEXK8VcCvKXuNA0KHxnNH0K2pITnSm
 EbxRGt2gJ1JYb/a2x2SiLwLsp91eSYRJzginDAvNBzhvxzEueM+q7eXt16aQ5LcG
 yFmXhqkTlhxKqjyYD5ZAcupQoalGAsaM+f6ZMqfL1hpqxDSAduYPjt9hvdnrWmlN
 2FZWOirryxvd0WeJmhauOPfosq1nbGhSd1UhQ3NaVQmwVP8SsXZGw==
X-ME-Sender: <xms:mfRuYbEUK9xq7NgiLhca8Dn9S8KLaJzLo7oK4Ow-bdX0cHgaf-V_UA>
 <xme:mfRuYYXxEEz2sWZ1k8xep73_ScNx0a4w4Lv6InLNA5Uc0BM0ihTxrGUUJ1lT5LU4k
 6rydvpWF0-JkSmZCu0>
X-ME-Received: <xmr:mfRuYdKrMJB_BqVJkxrSvz-oJIq2CwBHFXwIK5NmS-EKoGf08h3rtqOFjrse2ke7uW2rRJwpUlbRRXfopRUqcSsvfVcW6kqVS2M3HnuwU1DSdEvxCYYanAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
 thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
 epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
 ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:mfRuYZFAk-VVY5zeIPV8kQwQaCW8hF7RjxM1xECCnIiNbVbKB3GaSg>
 <xmx:mfRuYRWIpIulohQCa2EPey_PsX172KUt0h_2K_rO3XERcnd_itSAjA>
 <xmx:mfRuYUNrk3FklWjIVO9RFd5TnJrYDHts49ZUY_RuxigpJ0z0YjXeTQ>
 <xmx:mvRuYaNJwddulYrMwAHmiECV5rSYanq4IlXAQMa5L1vAGOmuQrdAdg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:47 -0400 (EDT)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 0/6] Support IOMMU page sizes larger than the CPU page size
Date: Tue, 19 Oct 2021 18:37:31 +0200
Message-Id: <20211019163737.46269-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

RFC: https://lore.kernel.org/linux-iommu/20210806155523.50429-1-sven@svenpeter.dev/
 v2: https://lore.kernel.org/linux-iommu/20210828153642.19396-1-sven@svenpeter.dev/

Time to revive this series:

v2 -> v3:
  - Dropped support for untrusted devices since swiotlb currently does not
    allow aligning buffers to granularities bigger than PAGE_SIZE.
    Getting this to work is possibly but a bit tricky together with min_align_mask.
    Right now there are no untrusted device on the M1 anyway and this series already
    feels big enough. I've therefore decided to address this in a follow up.
  - Replaced phys_to_page with pfn_to_page(PHYS_PFN(..)) since not all architectures
    define phys_to_page
  - Replaced the PAGE_SIZE > granule check in iommu_check_page_size with
    domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)) as suggested by Robin
  - Rebased on the latest rc which required to introduce sg_alloc_append_table_from_pages
    since __sg_alloc_table_from_pages no longer exists 

RFC -> v2:
  - essentially a comlpetely rewrite of the first approach which just padded every
    allocation

Some background: On the Apple M1 the IOMMUs are hardwired to only support 16 KB pages.
We'd still like to boot Linux with 4KB pages though because that's what most distros
ship these days. I've been told this also helps with Android userspace compatibility
and x86 emulation.
This patch series adds support for that setup to the IOMMU DMA API.

This is essentially done by always mapping the encapsulating IOMMU page and adjusting
the returned iova offset. There are also changes to only allow DMA domains to make use
of this and prevent UNMANAGED domains from encountering unexpected situations.


Best,

Sven

Sven Peter (6):
  iommu/dma: Disable get_sgtable for granule > PAGE_SIZE
  iommu/dma: Support granule > PAGE_SIZE in dma_map_sg
  iommu/dma: Support granule > PAGE_SIZE allocations
  iommu: Move IOMMU pagesize check to attach_device
  iommu: Introduce __IOMMU_DOMAIN_LP
  iommu/dart: Remove force_bypass logic

 drivers/iommu/apple-dart.c |  14 +---
 drivers/iommu/dma-iommu.c  | 134 +++++++++++++++++++++++++++++++------
 drivers/iommu/iommu.c      |  40 ++++++++++-
 drivers/iommu/iova.c       |   7 +-
 include/linux/iommu.h      |  18 ++++-
 5 files changed, 174 insertions(+), 39 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
