Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35629D29B;
	Tue, 26 Aug 2025 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205849; cv=none; b=mHsW5cMYNIPMNmTww867ulyv66lm5s8l7Uei0zlmGpe2KQ8muztXhgXzb3UZ8x+otMZv42C8AU8E30suldNeyms8GRU8gejFovl7mNZl96cT7w28bfJ1YeY7ReEJAEWC9/yumcRpk3ukCft6lzS5w1sBXzybLHSP2orHauNE5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205849; c=relaxed/simple;
	bh=vqIXBBy6l7WeM+eQwbRZ36QCEnQMWRyIbe5aLB4ko/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rRqiK0i/6w6eAjZSNPF0MKAxoGrFHDNNFHLlvJjv3+WeH3sNTggyp90NM9W8u2+N+4aOAKknMiuVLXTzyMGWXIzWDrruJTydarBMQox5i5kiU2CZBUanhJUlvvl3Cb9WBP7mA4PH7xvEn/z6Q4bwgZbpeEjxaBld8cMvrJfSyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=va85Wh+y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dW6dIDvP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="va85Wh+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dW6dIDvP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD2EB7A0114;
	Tue, 26 Aug 2025 06:57:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 Aug 2025 06:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1756205845; x=1756292245; bh=fw
	B+02lU1oU9CXZnCCCtUhP4HDlWfmGUMKuT8KEB068=; b=va85Wh+ysvBQIYulnu
	CVLCgGJ0bPS2U1vq22hO1UoNViElVV+6TAnbcE8dtREnZoaoLsYoYdvd9zI7Gp6I
	+h0WbPTGFwoQmtzjvuq78U2+tHBx8B5sHhdN0LS+fh0ubpP23HewLRbjdR9YwX+c
	B4qd6c9SwVooGtrv578IIsgSukgiHByHQCdCb5l2DKGWYaLVhO54tLQUuk/1S0X7
	GI/PfcP2m/bfXohHL0LW4+rXbKNzh5qjoNwrRCW/WGI7Y4mmXQ8xpXOaWyXYRpfD
	6nttWd9Lv6PSO57hL/zfllfgvyFy8n7xNWiFFeBVEjA534GiL6H0DvLncL2mT8ru
	T9qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756205845; x=1756292245; bh=fwB+02lU1oU9CXZnCCCtUhP4HDlW
	fmGUMKuT8KEB068=; b=dW6dIDvPFMoHmNzUSWPUsW0yoNkhM1iuZrPNyJOTGY7t
	zprvoh0ZPuBAGtzfrlKvX+zIC9yjgqA6kS0ObAS2iiTOgAhj3Btq4RBXfGOqN1ZJ
	InE+dF9p41LsgisNC7OoV9R/xpXkVFFYtXzxWu+fgJGSwtxOsT61tbnDAHW9O9E8
	qRzDg0o0EkL08J0kvMEaJJTD9DIF8mhYG6m87zTyIa2a028DvpVY/0uIQt9TculV
	7bDwiEmWcG6x2Y055tUKjD+tY0L9N4uhbsfuusp82tWFUqnavWYHPVyDPLknAg5+
	PsYAoF/FSTsPRpQ6AwiM4xhJ4RfMaiCXbYVSsptwHA==
X-ME-Sender: <xms:E5OtaEjotktW0NPsBmRR-kLRNe0I7Ta6Io-8lw3REZoKGXDwDgSGRQ>
    <xme:E5OtaC-44aDJbK2vP7MKcwenLzsTSWEoEbjTtUESASot52xkONhg7zVlgs44Y1E5x
    ADIFZ-AN30GD6KBE8g>
X-ME-Received: <xmr:E5OtaJNFVz62-EirZkhI7TK2DCv342zDJTqVGjEcaz4UIC71iuvvqUI1zlxEFLsh4BotMCIWqq56JVOI7pr9NcU5iI4Z0g3T6Gni_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfeehle
    dtheefteejfedvheetuedttdetleegudeuteejveetieefuedvfeffvdeinecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhhorhho
    seeksgihthgvshdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmh
    drtghomhdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopegrlhih
    shhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehiohhmmhhusehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhvvghnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E5OtaGC8GCpdgGNv4VW9HQdcuScqETNP_MVUCKoGFYu6WiGoGcDo8A>
    <xmx:E5OtaNPA8Bud0K2fgKF7bDOWALCVkEdIajVeSPZlS72brXD5OVVFyw>
    <xmx:E5OtaNeOMWmZE2c3fiHkmAfDZcu54yqVc0AymoU0-Wg6jOgGYZGo4w>
    <xmx:E5OtaO7uaA6YN4jiMKM_EMkUBFjVojrSeYLD1TFRF7WUbOWwQ1rgsQ>
    <xmx:FZOtaFyzryjsiaGiY6hvEuX3SQcVsV_HDBkcPGnGD4v9uuWC9BQsrrG3>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 06:57:23 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Tue, 26 Aug 2025 12:57:18 +0200
Subject: [PATCH] iommu/apple-dart: Clear stream error indicator bits for
 T8110 DARTs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>
X-B4-Tracking: v=1; b=H4sIAA2TrWgC/x3MywqAIBBA0V+JWTeg9iD6lWihOdYsejBKBOG/J
 y3P4t4XIglThLF6QejmyOdRoOsKls0eKyH7YjDKdGowPXorCdOgtcKYhOyOJHIK6sU450IbXN9
 AqS+hwM9/nuacPzMLNWRpAAAA
X-Change-ID: 20250826-dart-t8110-stream-error-1c2bbbf4fb63
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=k9X6j7yu0itBb/72muBj/YHUjNWTT3JQlGmlwONFySc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoy1kwX/MXGWxs1W/iErZl96MfzdvkqNCSmXq5a1dW28a
 2P0ZfKpjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABOxi2H4Z3EspWl2YohmlNsD
 6yN7jJyS+Eq3zYs7P+Vje/Ta/OOvnBgZNhnm3ZjKz+jk7d/Kns6bcfthpf3Fom/HAmLfZLI/FZd
 kBQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

These registers exist and at least on the t602x variant the IRQ only
clears when theses are cleared.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
---
I've overlooked this change for the 4 level page table / t6020 support
series [1]. There are no dependencies to series so this can go in on its
own.

Janne

1: https://lore.kernel.org/asahi/20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net/
---
 drivers/iommu/apple-dart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 190f28d76615159527649cd288df395a50d950ef..8b1272b7bb44a1ebc03ca4ddf3be43a1e42c97ed 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -122,6 +122,8 @@
 #define DART_T8110_ERROR_ADDR_LO 0x170
 #define DART_T8110_ERROR_ADDR_HI 0x174
 
+#define DART_T8110_ERROR_STREAMS 0x1c0
+
 #define DART_T8110_PROTECT 0x200
 #define DART_T8110_UNPROTECT 0x204
 #define DART_T8110_PROTECT_LOCK 0x208
@@ -1077,6 +1079,9 @@ static irqreturn_t apple_dart_t8110_irq(int irq, void *dev)
 		error, stream_idx, error_code, fault_name, addr);
 
 	writel(error, dart->regs + DART_T8110_ERROR);
+	for (int i = 0; i < BITS_TO_U32(dart->num_streams); i++)
+		writel(U32_MAX, dart->regs + DART_T8110_ERROR_STREAMS + 4 * i);
+
 	return IRQ_HANDLED;
 }
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250826-dart-t8110-stream-error-1c2bbbf4fb63

Best regards,
-- 
Janne Grunau <j@jannau.net>

