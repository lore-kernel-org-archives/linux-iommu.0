Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DC2DA75C;
	Thu, 21 Aug 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771376; cv=none; b=G4OE6ShMsIUpyl1XEzB25qIxS4Yp5XD8ZIkHgrLLVEaxoJftSoy0TpbvY7PGN//BuDYnWI0zCC/qCsC5NPH0WxBc/+Ip1BMfbcyhRDuf2PyFir7qW9rv3WSR1Ow9vsov/pkKgAh1vtNODS+E8NihP1BDCphSP9ze5JJ1OddC3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771376; c=relaxed/simple;
	bh=auWALS/dLuHWQDeiIFyYlRDyLX6NaNs8haeqQs75+vM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dGpQqDpFHcHkFqhLUGumYJ+FCvMMRuwbo7CZpI0wJBNAZYXTKPXBFDWr1NCAEV9w1w5UUBnQ3PazHMzYMx4Acc1T0hMAn6b7/1bA7rWtbJawYoiz/LiyX/Hx3smog4bQm7QN4HV4wSCNsm6fqmaIE9SKyiPBzchQwfuWSX6cgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=huQDxywL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlaR8Wcr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="huQDxywL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlaR8Wcr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 16CEFEC02C6;
	Thu, 21 Aug 2025 06:16:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 21 Aug 2025 06:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1755771374; x=1755857774; bh=lW
	lZ1B7dnoL4FI5VN9DHIWsW/7JnMjvkUJjcADTwd90=; b=huQDxywLfHt+W+uIEO
	5gagn2RXv1C7a4LvBK+0Pdq3pi7SCACOlo4xm2pvIE7vpt2kEwB5Q0M3l3q19kMx
	AO1gvSdHKkzMCn91bja+4zSjr7foPE6/+I90crEKiCdfaVIJTVZPWxds8z9vxzaG
	Cre6I76ZEsSbvO0XmiLjKxg6tsZcp3dn+4+VqgNzUBrJutrP84GAXiA5Zf6XEQpD
	RIheiXlZBHyXIjTK1DQ2qmFi4pmnkx5cJxdLefIEvOIrX/gZWWKmNzhAoe01iI4x
	Cg6F/gx3RKwdddQQjhFCuwGeYsy6+Dxwwk1ugf+LD8AL/za4Ad9nv/ht/6blm9e8
	kvrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755771374; x=1755857774; bh=lWlZ1B7dnoL4FI5VN9DHIWsW/7Jn
	MjvkUJjcADTwd90=; b=GlaR8Wcr7x31iyLKiURP7vS88qLsQ5M8025shevtxFGY
	zwZcYIAUdO/pFf+kuxDsPhLpGVOZ8tpDYbH+4jFAwZPg5qBsfptfwfVHgujJRRF0
	Gu+qS7KMf/MQEB5w6D6S7/u7td+g0sjlK41qr4gk4cwF87WmcGghGyoznKYmkw4E
	MoIkiylXS+m3xz3/jV+5sD8PeV4yydpJL20AALUsnNglzJMtdbVbFsfq7r4+l2M+
	caW5k42FIqw1kDKZxbaCxOhz+cVVMNnerjCbRkj2SW3KYHzJAyjuje6RTW9fF+eT
	aNQifwrikqxNTESLPr7orc9HGfAlmYg1KHtWUYU7pA==
X-ME-Sender: <xms:7PGmaCFdo0R34itlpGy5C-S4a7NOSqdu33ZMg-3FmNPsjgDX6rohRA>
    <xme:7PGmaJRulvTTTr7E0_F5_Z1PNrYI5R1-qSBSnsElMHat7NklsAD-30Ny1oci0XfaU
    Q-_v4XV3uFmS8FfDOI>
X-ME-Received: <xmr:7PGmaJSsQ_ly5zSo8z4oDaI-jLbfAz11LvpAkqDFq2riFqKJevoPP0WPLYRvPNqTgOWkSG1mwGaro68dj_qlm355sgDrRwGOvWTBhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepueelgf
    fhfedvgeelfeduuefhfefhjeeihfffueefjeeihffhheeuteeuvdeuhffhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghp
    thhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuh
    hrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhg
    pdhrtghpthhtohepihhomhhmuheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtth
    hopegrshgrhhhisehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:7PGmaM19N_gPBLyS-ZA-APYQAIWaRj9ttkDptLk77aIe8x6chZ11vg>
    <xmx:7PGmaDwKTVeIWou-EhCwXFRx8OyLY1jTO4bBbTRaQk5HMYXUd1Vifw>
    <xmx:7PGmaIwmPVR-CKkG4T6L4VfXY1gZxM_5Fd4QcdXBJYX21B0oQ9-GPQ>
    <xmx:7PGmaP8kgV3aT1K__hUzITgOsMWC5m4IrfoSEKzdGQplPfrTmOVgcA>
    <xmx:7vGmaFXMF_UyvY6jzdtOtSSW0qYTfkpGjUoqP4oaysw2h3pvEHrIwcgy>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:16:12 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/3] iommu/apple-dart: Four level page table support
Date: Thu, 21 Aug 2025 12:15:57 +0200
Message-Id: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN7xpmgC/22NQQrCMBBFr1Jm7UgSI42uvId0MTZTGylpSGpQS
 u5uLLhz+R7891dIHB0nODcrRM4uudlXULsG+pH8ndHZyqCEOgojJVIIE6OluKCeOPOU0AwnYkO
 9POgW6jBEHtxri167yqNLyxzf20eWX/vL6X+5LFGgvSklNbWmF+byIO/pufe8QFdK+QAluDO+t
 QAAAA==
X-Change-ID: 20250811-apple-dart-4levels-8f9ae8ac1347
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=auWALS/dLuHWQDeiIFyYlRDyLX6NaNs8haeqQs75+vM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoxlH1/ODIq+/zfwTPXple+sF8ZPVFPt1L7lVv29Vkm2V
 demT42no5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwESOP2JkmHPZzIV1bsH1fNbF
 26W6NmwPV5Hm7FOawCrz4Me99OLPGQz/Uy+87ruWJZ0gIPDqh0KvevicXcXtOzhlNU44Tn6x/Hg
 FKwA=
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
Changes in v2:
- simplified 4 page table level use in apple_dart_hw_enable_translation()
- use "iommu/{apple,io-pgtable}-dart:" as commit subject prefix
- added Sven's Rb:
- Link to v1: https://lore.kernel.org/r/20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net

---
Hector Martin (3):
      iommu/apple-dart: Make the hw register fields u32s
      iommu/io-pgtable-dart: Add 4-level page table support
      iommu/apple-dart: Add 4-level page table support

 drivers/iommu/apple-dart.c      |  50 +++++++++-----
 drivers/iommu/io-pgtable-dart.c | 143 ++++++++++++++++++++++++----------------
 include/linux/io-pgtable.h      |   1 +
 3 files changed, 121 insertions(+), 73 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-apple-dart-4levels-8f9ae8ac1347

Best regards,
-- 
Janne Grunau <j@jannau.net>

