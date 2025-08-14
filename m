Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CB2D46DA;
	Thu, 14 Aug 2025 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160856; cv=none; b=F18pYwMyznwnCmFwyugCYDnThf6THsnEo6fbmxLsOnGMflEcPiBcpE00EpI63qd14XyKsMa9cxeYThtmwUwpbXMOSK2JEHWGejp8443cO/ABcXGkv5VpnoUaWVCqOBl7sIvCwdXjuWXlO7RKEhMKUAETkdbc0E2G2dYRqucWHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160856; c=relaxed/simple;
	bh=mpHvjrYtpy7asIuYnTB4flgke7dzGuWpfolSDHarVSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWHrZgh06ragGhL3c25NIj4ldyFSdK+f8Ny65zQWb0ZHKdmzA4S4/ExpL7gz6wKc082SyggfA72SFAyERDrfsiOKguUqv9fWRlvsvKwkkdKdFyEdyT6JHrMGoprP+dRG3glpF/Gxcx98hSoETcORhOi5dPiLC1e2u79LbnPONeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Lko/orpi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0G/73GG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Lko/orpi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0G/73GG"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B36D5EC020C;
	Thu, 14 Aug 2025 04:40:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 14 Aug 2025 04:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755160852;
	 x=1755247252; bh=dInGrJE+Wye5FBXM3QXXiTdcsGBJk2tEBTfaT2DZ2P0=; b=
	Lko/orpi4SK6byknfmhH4e98miSBxF84PL7TaHkXdNJcTZkiL+mtDS6ENTs8jY4W
	frcJ2jPFiZ6cP2ueYCgdW8bQO2/gxlqA/cqcrPOLkbzdDEP47rqctEi7XNyI+5Tj
	/Qs29MGL7wt0vk8WF0Xf0Jb2v4yXxefP7qFk9/8StJs2H6uSsqVGJta9/+ssOn7j
	7q/Zq/RjuwkxuVY+jpJRmrW13ZqjVBvxuBDgaQhhOkqHeb5hWfnE2j0Bh9/PiezR
	T7JrGEfYsShE5L6JefI7FL8oRZdz1uw+pjEtcfti5oilRA6aIVZDl81136M/uwAB
	3PU+Q8zeC6AqvY4Fqaz4fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755160852; x=
	1755247252; bh=dInGrJE+Wye5FBXM3QXXiTdcsGBJk2tEBTfaT2DZ2P0=; b=b
	0G/73GGv25R4Dn57qSO1jTgpX7OXss73gTjqFM7Oo3rBZ5BGDq4jzLtwdLcgOanY
	bjp5QjzyzBT8cykXLBCOmP1FQqtA+tIzLXbTjQUP0DHHQu3aFQd86c9yWe7q73hr
	BdpTW7Njh+nSaI5w1bXHphvxRSQP4lny15JFDRavBg2433A+tBtKcybfBchSG9Us
	yHUtXm5g9kV99OoJYEy8S0apSaF/ZQVN2ZJadLIUqG5XwzYXAsFOhxkwJIzWtYxC
	ieK+ZzAl+nriRFYqMtrirzltak4flimoH1+06LqNMarczUWKYynqw7wRABUueejm
	7kH9AWIvedwKZbhpYMSQQ==
X-ME-Sender: <xms:E6GdaEnqMQwD_5dvyZxxPdb-CA23pmcwlgSuyvYsrGcs1IacO3I6_Q>
    <xme:E6GdaJx4-s8tuXuKdl_RwAl5_es-lHyDLLNQ93XJ-RS_IHjeZKy5nlmvx9vgq8EkO
    ujWwXHB4RuleeGmMBg>
X-ME-Received: <xmr:E6GdaPwhP3P5xGk9pkKNxrmIZLH6vmcYYxprQtFZuwx6-1eEchNujbvwn3MP7a-bmdqJiEp9wlpMkcGdD0iaPWKYhSAHHXqHZxpPYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhgrrhgtrghnsehmrghrtggrnhdr
    shhtpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpth
    htohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvg
    hlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhgvrghlsehg
    ohhmphgrrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:E6GdaBXroz8lPxjww_1gpBAT_vuCq1zxaGWsfN0w-op29NwH-9_wVg>
    <xmx:E6GdaORBBlmqCZyayryKfGCygdHeRDuRkYa5zGyeMI_Z_Ab78ZhfbQ>
    <xmx:E6GdaBTJ-nZo50ho-eHIU87xcmcdXu6mdEb8GM9imWYLBRoZ9gRSgQ>
    <xmx:E6GdaOeIpU34LfxYAbzvwPp1xzoS5giolcmwtzYseE3zlnYxgGGtCw>
    <xmx:FKGdaH2mSOs3f8J27TU-24IOAwytsu9nMTjxo5VO-bVL66M-t36_Xc4->
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 04:40:51 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 14 Aug 2025 10:40:24 +0200
Subject: [PATCH 1/3] iommu: apple-dart: Make the hw register fields u32s
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-apple-dart-4levels-v1-1-db2214a78c08@jannau.net>
References: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
In-Reply-To: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=Ah2FtuAI2Pz9rAwG3UdfiegkoAw7DTu7B/zqezSouiI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoy5C/lm/zDfVRph9d3OmFnl3Qox5ramw3xB3WnW0k+PW
 19PLNXpKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJEFWgz/fVoq+NS6AxoKJN5e
 knb75SSVz7j72+tXuYv5/73SXcn6jJFhV1DhUYYXrw7tf+Yl/OjfxDvTdPWuF8TWmktYRbRuSD3
 PDgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

The registers are 32-bit and the offsets definitely don't need 64 bits
either, these should've been u32s.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/iommu/apple-dart.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 190f28d76615159527649cd288df395a50d950ef..e72a93e78e26ca61b233c83d439dbdfadf040fc6 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -166,22 +166,22 @@ struct apple_dart_hw {
 
 	int max_sid_count;
 
-	u64 lock;
-	u64 lock_bit;
+	u32 lock;
+	u32 lock_bit;
 
-	u64 error;
+	u32 error;
 
-	u64 enable_streams;
+	u32 enable_streams;
 
-	u64 tcr;
-	u64 tcr_enabled;
-	u64 tcr_disabled;
-	u64 tcr_bypass;
+	u32 tcr;
+	u32 tcr_enabled;
+	u32 tcr_disabled;
+	u32 tcr_bypass;
 
-	u64 ttbr;
-	u64 ttbr_valid;
-	u64 ttbr_addr_field_shift;
-	u64 ttbr_shift;
+	u32 ttbr;
+	u32 ttbr_valid;
+	u32 ttbr_addr_field_shift;
+	u32 ttbr_shift;
 	int ttbr_count;
 };
 

-- 
2.50.1

