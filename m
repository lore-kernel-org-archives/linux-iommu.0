Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5876DC432BE
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FB360524
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 15:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9FB360524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D2CD40205;
	Sat, 28 Aug 2021 15:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8y4Pbf6WYVxA; Sat, 28 Aug 2021 15:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BDC9B4012B;
	Sat, 28 Aug 2021 15:38:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91E8BC0010;
	Sat, 28 Aug 2021 15:38:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31A8DC000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B48340155
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FOFfkxkJUS8i for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 15:38:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 510634012B
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 15:38:15 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 6BF45580A6B;
 Sat, 28 Aug 2021 11:38:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sat, 28 Aug 2021 11:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=Ir6zYPhgUh57BI7mV5KU6yepjS
 2qUU8+bficl9p0lPg=; b=ZzqtN+xtBikn+rG2Af9z4cjrVsDvKJxCwzO9123bSk
 pqNYi02jgREEdC3Ty7ZZWni9O0fwjxzHeIswiucb7WUL6uelpXtLOmCeVuzMhoEp
 Dz4/0aKGZIWD59YT39DCkU0LDAEHPFtwrADIbvQR+5OCFdWO/AombyleJK4vPBYu
 o2OeKhxK34EbY+GyfriNm7+/IB5KjVB8OGPqDhd/a/vKUI0HRYqAH3l0g/PpjrYc
 xGT04Hyb2CmgAgmtEqI63TTrNuluR15Dn1UnK7KFYPDNIk+3XfZ2jwsAHG8i/PqN
 eUbHYo7DN9E/YCwcThx+Mw5+RGAzp27FOzwy+KPwy+lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ir6zYPhgUh57BI7mV
 5KU6yepjS2qUU8+bficl9p0lPg=; b=P6S4b/wGEncaiDS5vyzG1TU63TRTfOr/H
 aOzU0Y0kbTdO+qonIP5uWUE01Tpa74bsnvSuoZJnlqAxYeZfJEwVkvF+d2z98hDF
 4MLXetPamxLvlMIJg8bJm/npGEKX2kdIjesLRzzivyj2e5u7Wv7FYIet2BcoD6s4
 8Hd35pKzxEkdDhyvF9ZdZA9mvco25XQarujj4oCR6p1YuJR+zSF7ge3JUyV7zLA9
 MgMVi3L0JWphoCXtDu4t14aeeWZw1cLKspFadxsUatCVW9tlh4tS7ALYmRelvOYB
 Dkgbg+P7atQXyUe1WX/MKyuwfLE0IkAqjoTyvjg4DG+Xtiyl9ML0g==
X-ME-Sender: <xms:YVgqYRRfbMZ7h0R5Tnf-A1IsbH0SZw0uE_2GS6f_5xw2PTAtGw_aww>
 <xme:YVgqYayP9h_IzZqe_vobJuT4skLKb59PkhbeJApwaZ1sI5sECXxPnYXQ1-XxvKXm6
 w6AGgIcAJhfi_VVLSE>
X-ME-Received: <xmr:YVgqYW0MALMAJJJ-37F113Qe0oQz5QJ5eD0OlQAlVQ3xnEqx9LsgcsK_gXg4R13AJ1kOhL1wOBZUF5gzJRy311N2cv36yY8R93QEoi-nA42azmLIb1JiEOeUKosfAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
 thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
 epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
 ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:YVgqYZCkjoHfAZjHUHRjsGpf6eu4y5KGmVhMv1eZkIROsjLR0Uheag>
 <xmx:YVgqYag1mSKV5Opo0Tg3571o05_DbIRldFdk7Ic4yK0F4H8ifYndyQ>
 <xmx:YVgqYdpkNwnOTVt9SDUiHu8kPVpL-KnnlhzcaJLS8XrB5md7uockyw>
 <xmx:ZFgqYVMJ1rBpesOPvK3NRXWX-Ts75loxeMxpl2Mm8MJbscHK8WWGcg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:07 -0400 (EDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/8] Support IOMMU page sizes larger than the CPU page size
Date: Sat, 28 Aug 2021 17:36:34 +0200
Message-Id: <20210828153642.19396-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

RFC Patch: https://lore.kernel.org/linux-iommu/20210806155523.50429-1-sven@svenpeter.dev/

Hi,

After a very helpful discussion with Robin Murphy on the RFC, here's v2 that is slowly
starting to look sane.
I've been running this code for two weeks now and mainly tested it with usb storage devices
connected to dwc3 and to xhci over pcie on the M1.

Some background: On the Apple M1 the IOMMUs are hardwired to only support 16 KB pages.
We'd still like to boot Linux with 4KB pages though because that's what most distros
ship these days. This patch series adds support for that setup to the IOMMU DMA API.

This is essentially done by always mapping the encapsulating IOMMU page and adjusting
the returned iova offset. There are also changes to only allow DMA domains to make use
of this and prevent UNMANAGED domains from encountering unexpected situations.

For untrusted devices the allocation size is simply aligned to iovad->granule if they
don't already go through the swiotlb path. I have not been able to test that part
so far though since there's no Thunderbolt support for the M1 yet.

The series is based on top of iommu/next (and without the last commit probably also on
iommu/core). It won't apply cleanly on apple/dart since it already takes Robin's DMA domain
cleanup series into account.


Best,

Sven
 
Sven Peter (8):
  iommu/dma: Align size for untrusted devs to IOVA granule
  iommu/dma: Fail unaligned map requests for untrusted devs
  iommu/dma: Disable get_sgtable for granule > PAGE_SIZE
  iommu/dma: Support granule > PAGE_SIZE in dma_map_sg
  iommu/dma: Support PAGE_SIZE < iovad->granule allocations
  iommu: Move IOMMU pagesize check to attach_device
  iommu: Introduce __IOMMU_DOMAIN_LP
  iommu/dart: Remove force_bypass logic

 drivers/iommu/apple-dart.c |  14 +--
 drivers/iommu/dma-iommu.c  | 172 ++++++++++++++++++++++++++++++++-----
 drivers/iommu/iommu.c      |  36 +++++++-
 drivers/iommu/iova.c       |   7 +-
 include/linux/iommu.h      |   8 +-
 5 files changed, 197 insertions(+), 40 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
