Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5959C433EF
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2DC61B62
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A2DC61B62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14A71823A0;
	Wed, 17 Nov 2021 21:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ZFsPP7v7x2u; Wed, 17 Nov 2021 21:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF41381DA3;
	Wed, 17 Nov 2021 21:15:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7907C002E;
	Wed, 17 Nov 2021 21:15:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5355EC0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F8BE60A82
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="UJMItec/";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="V4ZRFYTO"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nt03xtz7qqNe for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 21:15:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B86160A73
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:28 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id AEBA55806CC;
 Wed, 17 Nov 2021 16:15:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Wed, 17 Nov 2021 16:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=rDJmmzVKF8xgYuniWddaY4KG6e
 sEwkL+aJ6zJYHAFWM=; b=UJMItec/TlKbyg/Whl5WDkHIh9rMWnpzxMWgb2+J4n
 SlsxUz4WWwIF3wRG6RVkwOMrUmeffwyLrynIOcEgkzHouz1ITe4BzmttLM1xT0c3
 OrxKrlNv25+4ynyGi2e5Sw+fko+9X8laH1TDFDcAMQGxzS5p+Ytf8I1aCskNt0B9
 WqjvJhOuL8Mz1hWbYuDyZjTJU9p2VtC+60UXgweMQUNvwOk+mWWQ7U68dS0UwKtj
 05T7DmSLoiw3y+zzQXMVdxD5nrxf91J1BGocD8p8rMsGOHxJJIpKuBcyzDUXi7ir
 3TPTRjBFhqzKD1J71/XEkT6qAOQz9VJ6eVzdOzlUaowg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rDJmmzVKF8xgYuniW
 ddaY4KG6esEwkL+aJ6zJYHAFWM=; b=V4ZRFYTOs8f8/cNkvBdYERMmRvrGypksj
 kxaBFJDI+i7k4aXbH3vzgaXZjVlgtkMUFN5uLDndjxnZU/HEKOZlxXE2EFegvIZN
 DDQO0CAdsKLItUlHY0b7hGHyOPf9mu1dn9hV0uQ/aSyDms2pZFLQDozBImwAbcZt
 25r75XTtAlNZEP9nMD1ftMVBpNGk7odZ9Cf/BlrYCz1opxl27eZz+g/fevV9FPQf
 4Oq2tyC9r5cDDie0CCgmkusHjr1cgtPjYDKOoAeq2OZqqeRPxT0ouwZxSHanUcjf
 8mAgwLRLMo6fBKwkMVwlJVXu6KXTbWq5G6ttytbgz1ZqWyfwkhEHg==
X-ME-Sender: <xms:7HCVYcuDbdUVTi9gIpm9GUil_VFisDtWxUtozlREtr-5Ac8s4WxcyQ>
 <xme:7HCVYZebIxWzdBaQR9xeKvxgcADmbGYBLMjsAxWGMUfxcaUcuIZ9hNhn-VgEOM0Bx
 yVHRiIJufnO5rlhyC8>
X-ME-Received: <xmr:7HCVYXxBh1ZXu515jKoaCnBfoqWAccalLbBMvFyEbR_hSWxp1nk3fg2ICc8lAuSEFwpteDOf5vnJbfTJlf4dexOSul6hZqgL3xHx2eFas67vcPjmRedCpNqrdLyd3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddugedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
 thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
 epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
 ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:7HCVYfO1n4fSJz0zYGXvuHeMoycQqLmNHerqF8Ztmyq595UNwodSyw>
 <xmx:7HCVYc-OwO5NCUE0bVblKpfRreeD9-yxh7OWSUt1LfiU4RVSp991aw>
 <xmx:7HCVYXVkBVJuZBRqWRpxChZc8YiB9oqZB3a5PQf-QoRxKptBid4b9A>
 <xmx:7XCVYd1yNAaGYXtUGoSuOxYNwhVg6Rot3ZtLdFbbe3JK5b8ffc3Gmg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 16:15:22 -0500 (EST)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/4] iommu: M1 Pro/Max DART support
Date: Wed, 17 Nov 2021 22:15:05 +0100
Message-Id: <20211117211509.28066-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

This is a fairly brief series to add support for the DARTs present in the
M1 Pro/Max. They have two differences that make them incompatible with
those in the M1:

  - the physical addresses are shifted left by 4 bits and and have 2 more
    bits inside the PTE entries
  - the subpage protection feature is now mandatory. For Linux we can
    just configure it to always allow access to the entire page.

Note that this needs a fix to the core pagetable code. Hector already
sent a first version separately to the mailing list since the problem
is (at least in theory) also present on other SoCs using the LPAE format
with a large physical address space [1].

Sven

[1] https://lore.kernel.org/linux-iommu/a2b45243-7e0a-a2ac-4e14-5256a3e7abb4@arm.com/T/#t

Sven Peter (4):
  dt-bindings: iommu: dart: add t6000 compatible
  iommu/io-pgtable: Add DART subpage protection support
  iommu/io-pgtable: Add DART PTE support for t6000
  iommu: dart: Support t6000 variant

 .../devicetree/bindings/iommu/apple,dart.yaml |  4 +-
 drivers/iommu/apple-dart.c                    | 19 ++++++++-
 drivers/iommu/io-pgtable-arm.c                | 40 ++++++++++++++++++-
 include/linux/io-pgtable.h                    |  2 +
 4 files changed, 61 insertions(+), 4 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
