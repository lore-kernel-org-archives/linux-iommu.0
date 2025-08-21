Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFCE2DA75C;
	Thu, 21 Aug 2025 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771379; cv=none; b=UXzRtitsS4ADwxwiiyIUzjAvS5azI4PjT5GLawUAevayOexpiACbaWcRexl5+GYv8M6aLeqMoVpLOUniY5aaCE1zx/1N/5yqrM19BknEfC5PTBRZgWjBf4I9JJFucH+sZmqyNUSxrq2sbjcred3/IKcCVBER+HloAlA829FMWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771379; c=relaxed/simple;
	bh=81dIETnKdhEegyn9WN4E8PQ6unPex6tFDmVph6+TWhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALNW+vpM2gQh5h7shyvk+lDkrEd32gw4joOJNbyo0Ds8Tme7JEUhwUsKajBFbcXNLMV9KsBX/ZhvXyFjyb97oA+WGLTtGVmi8mYvOqsisVKaygJe+gC/27zCSvVMuJfa8bMwKbU75gDScotUMfXaEeuUDmKpZO7j8odHnNEzqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=qpFOwpnt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GddRYwZg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="qpFOwpnt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GddRYwZg"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B48A1EC02C7;
	Thu, 21 Aug 2025 06:16:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 06:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755771376;
	 x=1755857776; bh=SiHsgd7okzHZC7sahAk8guYsKY/WDcCKla/MqikhROQ=; b=
	qpFOwpntq8Vt9Z6FF+ifj+ML13AVh4RY6H52o4rskHWYkSNGTeK4590yq+srRMZf
	jZ983Z+cYG/jnuDpi7gH4M9qrJH7NUvUG9bk3+da7FJMC32ac4aIukxliIKZszeH
	jNTSAaUI2miF2mr5cmJX/BrSN7vpHnWIBJfI3Fv8t6imYZOMNy7Wi1QRpfsI4UvG
	vIxqSFFw7JccoDynL7Qzdf6FnWOsyBJY55BZriOUX3Py9XUnwmn5hdwol4t0hkkk
	Bbe0VWd0Bxr+97DrIC+Xvw5nuLw2cVd3z+Nloi3zV8wFitN2bLT/s0Jr6siuFtxj
	3mwXTLQ2gmiLw29MQtsV2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755771376; x=
	1755857776; bh=SiHsgd7okzHZC7sahAk8guYsKY/WDcCKla/MqikhROQ=; b=G
	ddRYwZgRn9bRFOwiFxFLYLlu9aCfe5ClsAx1KrJ+dQyUg4m7YJ+zludS6Qy86q1u
	7n0W15eL6ISrjDMSyTvEyHW3ZCfiRrKFZ3PNnjXHv4otBP+3PvhjEwvvGLUBDHoT
	GFwEafK79jmVxjA/nofpQmmVUaHiZN/85n63gMIeT0PJL3AzMKF+DjroBu6fIRYC
	OiFzvMRM/OUES1bFVMcLcuNDbDdZlfqee1aWIyJX+l8Ndc4WbyiBZWLz8mQhU8Jm
	gB8OEdITBvY/fEuaSnwLaCe3Sep5csXPiVAZZ8Q8Fxnzok++5JKSfoUQB9lszbvS
	WbGSX71a/qx9EyXwA2I6Q==
X-ME-Sender: <xms:7_GmaMBzseDvlyN30MYQbsV1F0ZjsqxJJaVmaKus-0ny5_jqKhLKQA>
    <xme:7_GmaEfqfMtjrLd1QCptHQEuIHs8rhFfWVy9Kv7pZ-GKojSHkzFa7_-ULMk68tFJb
    E82sKEJ7b0eJMIl27w>
X-ME-Received: <xmr:7_GmaMspjc8TM7aYSR1sGd5YjGto5HZFy7XCVK7lchSVN69VvBojs5sSehzVCOW0KsVS1GeR2OmAyMiduW02zi18tVF-rpgHfPU-uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgr
    rhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpth
    htohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinh
    hugidruggvvh
X-ME-Proxy: <xmx:7_GmaDg4tVyIAzj-hh3Q75ifDrjp4uyCvGYVnCCbHioPdOQKYoHjWA>
    <xmx:7_GmaMuL9brG1KfGjBrReUZvPnu5wTrlXAFkS6y334bEqjNuWzJCIw>
    <xmx:7_GmaG_KNpkoTmBpL5paOtRL2oVaopsLafA79lpztvURwE49g9jBcA>
    <xmx:7_GmaKbeTfT_h9r9NDlv_MBzRJr57UXI8v3QdrvKJc2qRPxmBLmzlg>
    <xmx:8PGmaNSlEas4dUIKSOdiSoFlbSx48jiCGIVjFPGG0p8cH79ufZND07Ya>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:16:15 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 21 Aug 2025 12:15:58 +0200
Subject: [PATCH v2 1/3] iommu/apple-dart: Make the hw register fields u32s
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-apple-dart-4levels-v2-1-e39af79daa37@jannau.net>
References: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
In-Reply-To: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=/GMtF5Ozy2rc1sRrdEpBEK+lPwuPIjVdY9ROyd4UtjM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoxlH1+t2/52ySwTUWvOSwUBtyYUsv9K4lRasax74V6P8
 tpy//gDHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACai2sPIsFjml3XpjyKvpmuH
 +NVf8/3O17/RoKEk+E/r1j6lE8duPGZk6Gd6VSJfNHvSBt4/v7u+Pfc4Wvfpm7vLlFDOAw0v/CX
 bmAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

The registers are 32-bit and the offsets definitely don't need 64 bits
either, these should've been u32s.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Sven Peter <sven@kernel.org>
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

