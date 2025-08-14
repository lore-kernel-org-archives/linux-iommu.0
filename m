Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC7A2E11BF;
	Thu, 14 Aug 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160853; cv=none; b=TDZjvfLl9cSbzh0QyKGm0VkcvTNnrcE6U9KtrMd9gwe30Zy6EBbHQvVlFWJObU/FDXmsFmADuU9XGAMjYO9fqjeekbuCe+i4SbthQ2wlzCcj1M59BDHSHgG7RUl1wdlhaz91ajN/odDundRKfXLdBWRmpdryDIzYAygUbfu48W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160853; c=relaxed/simple;
	bh=ZV9g15yATwUQ4KRLeEZL4tJS6hLbRv80h5AbIBbK0Wc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bAZ1D+9XSppNd33x/rtG36/HMMoKB9NABFVHUVLp8vDmz1M8Z4sH83Jk9yXb0SE7p+DQ3EXWv4HDbEybe45K6pGZLjwHPLSK+I+KIM3rDc5W74NUPzCRaann6nQUuJyPfOvByHBHUSvlkHa5Z4PstPWtN+U0+MnL+bqiQm7yj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=jamsIrHa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUwzqnsp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="jamsIrHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUwzqnsp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B59F14001B4;
	Thu, 14 Aug 2025 04:40:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 Aug 2025 04:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1755160850; x=1755247250; bh=vV
	TgLcT5IoFf0DgDdDv2GD6JnpUqRszQ9RbVmywYabk=; b=jamsIrHaBsps8Yw1bx
	raYGHW7I75SD7qsxWM4SSRyiWhqhvweu8rxP1BIrqmdP0DBMF2Gy2vXdZ4PowCzi
	GLajaXAtUhaJ2WgAm6oAyKEBm+XJ4ggbajTrI3/d9WknT8uO/bkfEYrc7AtvBKRU
	ho9K97dkK+fWLtUc0vu8f3h8ZoHNn4+4/tCnugLPczqk+kE4zixkmD7/wJneV7XZ
	mexPxQasxSQJOxU9pKucATy67ge0b4hGhO6A698MJeUPK4vPC2dbfCHSALpO/1C9
	1MnbToxyABzjFnShEzEUzgVnjLGuzCRoF5SQX4oyOvBhu9s2/8fTLmAc8MEPp6n7
	1Kdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755160850; x=1755247250; bh=vVTgLcT5IoFf0DgDdDv2GD6JnpUq
	RszQ9RbVmywYabk=; b=MUwzqnspf82PC87Yp5R0aovZj7msskrjaIeASNmGF1sn
	9i/QcLeEi1LgzadCFD33tDXToj8ZebKdELT5/gCo1Meq+6kqad2RFjGip2s6IA+g
	nTiC6csLAgYTINq0cmRAiQTFsrykRsuraBvt8L5LInHDzc4ZQr9+wZ1R9Q12qP/D
	opIO5yfOj2WqMJP7wRMelUCTWK/+Ez73x0HtQG8a7hsUszG/4K96ULGiYa+N6EIy
	S7T9wXgeIcaQHUfjRk+zk87qNOQXfheoRqsiJsL92oO2Ks4npsctfokv+3u1rGSg
	7BNE94ZD/+gSJrRWX5kSWcDnx+BYuQ/RN0MMrCnFbA==
X-ME-Sender: <xms:EKGdaPkhlJQh62dE6OodIez8UJeXp33Dgjic4ZTrgfTRXQu3S4L4uA>
    <xme:EKGdaIxOFBaW2URHtdczN8iBIlorqL7DNLFTDr4Ltg0YZBJX74toCLWpLRCiKhas2
    Px0P4VKC6Dtj_JbU4Y>
X-ME-Received: <xmr:EKGdaCzZtNulyg04eaIGQ5ueAhdGYymJ4QMmNwTfJiQ8gVxeEJ50h2Qf1Uwth5UevBdL5AEeCD7HsU_6eytegT63K8baltdbmkd9tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhephfdtue
    duleejffduvdehkeeutdefhfdtvdeiieegheffleefvedvhfeggeegffefnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
    hnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhgrrhgtrghnsehmrghrtggrnhdrshht
    pdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtoh
    epjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhs
    rdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlse
    hlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhm
    phgrrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:EKGdaIUKmPxTuOIURS0yoVF5PSqYJ1R_zOe_Sng_hLqB5W3Jn-hcOg>
    <xmx:EKGdaJREdjzSYfD5xoDZ1C9UMNk8ADbLHWsuqIKbsepoP54gWCsCrA>
    <xmx:EKGdaAQOVgpBMUP839qnZVrV-u9QNJMCYcf4viXjthJUODE4HaQLvw>
    <xmx:EKGdaBeDsbgdTpG6P3KZFW1wDVj_eDzL8kdLqx8-OOy-qYbD1q2xyw>
    <xmx:EqGdaC2EAjQZsslXUinEzZDPPAa4TbUIM0wnFZqCEG-a1sqJskyq2lOJ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 04:40:48 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/3] iommu: apple-dart: Four level page table support
Date: Thu, 14 Aug 2025 10:40:23 +0200
Message-Id: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPegnWgC/x3MSwqAMAxF0a1IxgasH6xuRRwEfWqgaGlFBHHvF
 odncO9DEUERqc8eCrg06rEnmDyjaZN9BeucTGVRNoU1hsV7B54lnFw7XHCR7dIJrEymqltKoQ9
 Y9P6nw/i+H3C0rOJkAAAA
X-Change-ID: 20250811-apple-dart-4levels-8f9ae8ac1347
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=ZV9g15yATwUQ4KRLeEZL4tJS6hLbRv80h5AbIBbK0Wc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoy5C/m8XQ59ip4p/j33DvepbJ3ftzPmHdcRW39g++EuB
 q2bDDemdZSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZjIZBVGhnMvtWu2vn/ruinq
 /fqnrtNXCFe2X/qy3GtV1/8C1nWZC9sYGfpMuJWFKzQ3FMRxmbJGJgWbqHNemSe2VM3gddA0V8N
 XHAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The DART instances found in T602x based SoCs (Apple's M2 Pro/Max/Ultra)
indicate an IAS of 42 bit. This results in alloc_io_pgtable_ops()
failing as io-pgtable-dart supports at most 36-bit IAS.
The t8110 DART design supports 4-level page tables. Implement support
for this in io-pgtable-dart and mark DART stream with more than 36-bit
IAS as 4-level page tables.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Hector Martin (3):
      iommu: apple-dart: Make the hw register fields u32s
      iommu: io-pgtable: Add 4-level page table support
      iommu: apple-dart: Add 4-level page table support

 drivers/iommu/apple-dart.c      |  47 ++++++++-----
 drivers/iommu/io-pgtable-dart.c | 143 ++++++++++++++++++++++++----------------
 include/linux/io-pgtable.h      |   1 +
 3 files changed, 118 insertions(+), 73 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-apple-dart-4levels-8f9ae8ac1347

Best regards,
-- 
Janne Grunau <j@jannau.net>

