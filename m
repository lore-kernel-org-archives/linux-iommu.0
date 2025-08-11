Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04EE2192F8;
	Mon, 11 Aug 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920305; cv=none; b=eeqctENh5d8Fg4ghaBLPz4rFP9qFzK/aunFcoZ9i1e0NOqIk3SGCASmpBpILvJbbSycuHtN+/HJasN/7WdcAg7hz5+AI+f7vgCasxoF9EHizPjKXC4jEq9BWvc5v4US2dQ5Y6RlSih1uzkWEP/r4Y45TKnPFoXhj6r3eqf87ggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920305; c=relaxed/simple;
	bh=qu53Npl9p1UJIa6YTj/hRvC8zr9mwt5eIRHVXIxtFxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxreepLIgLT7ryXJAP4bsC0iQzyObVJsgxTfyk5xZCDOSlsgWXoUX01L5XP9O3Ga6vTWrmdKmO9OeqV8GwE9VsuR9ryHy27xnvUO+Sn5xz7LJJ1zxVkXtwS8mUIgRWLx0BnSAhnVxjyYK+fpa5Jr9pvtKubzbTLBqyI0u53dTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0SuVPvu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0SuVPvu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bde897110so3441350b3a.3;
        Mon, 11 Aug 2025 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920303; x=1755525103; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z8PyP5sKcVvm50Lc4ho4ozdCtTBci5j1M5U5sqHCfE=;
        b=E0SuVPvuNdpXfaa9Dm+4hXO2G6jFBUntslrDuO2R3jFGOO0KI5qMXTJaqPF3wW1Acx
         BOPmE3TATRPV0PR5lA5BdayoB+F2ImCDQ5zuJuNjiBWFQUoe1XTQpmcJZX5v5VxvnWwk
         i7Jba2/fogBVY42LAG7WmTSAom9EK9+b4gUay7NtqGcEQDtiPIVbZti6iO2cu8/8VU2S
         TAbZsD+eZH7rKcR9i5JPWPPLuYXiHIwNSPj6q7gfDIe52u4p19p5I5QGmbbmEGGJfmq7
         HRv5K14yqbaLWmrskHgS4mgDFEZkf0B6h1eUV0TsjfAnBmI0qhA+b8Bj93FQifIbBhXO
         nH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920303; x=1755525103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z8PyP5sKcVvm50Lc4ho4ozdCtTBci5j1M5U5sqHCfE=;
        b=Va5l8Qt21tQY26qx/6NYqoY3N4frFviz/Zk/xq4E4gMXSp5D8FNFtY1iHzyyWrk8q9
         aYdfYXFpaP7nMIdjic2C+9FZYGyJVMpbrYJ+vToH4i2mdq6HCq4V9rc501eg6P/+dcuH
         pHNJzUXRTbLgJu2/jBNYSqxMJkH83qlaJH6fH/sIVdSHaXvMO8Xv5SPVssROlnoC7B3V
         LRlaJcMgKllIKMDNU+LDRvp50Gf/lyxbsFclv/w7pfyWfoQAwnZzJqjAYVfD7mhBwSbx
         9R/hXaYdjXN80hPBz6/Iwcabhvkd0Fgvl2FUvb4QJWBK/W12lIm0mnEBfst99SlfDDOS
         c9yA==
X-Forwarded-Encrypted: i=1; AJvYcCWmw3cLNQWq0OAEwwxWTilE5Dhai/+8ors7oZB9k5oJQjI+LUWZDXqRfrTdc9Lf2PyXNwkZhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfLf+wFxOYyGX2Drvbf31owyKsl3X1deuNVSiefHud7I9AZJKf
	zBW5AbgNx5IDV0JPRa51Hww80mkmZnh0tKk100iZRMKMfslmCDYo3uKU
X-Gm-Gg: ASbGncvEyPHS0ysiHIg0T9k0AHvKs9to/j0w1Y7LG2DKRQLjQeWc08nHjAcIaQPByIG
	tOv6xj2Ymd2TRB06Mcje1cnw/8lJu6kcRj5pb1B1ckPBy0bqxbFoIIUKAsKq1+tzzkIGZr1mDiL
	X/0EUlSu51wZjQZ6rftPR9bPREajEtxboDFWi4+V5Iwcff9ke5sX6aLHo0VcFpmAoKhpg4nDznC
	oGWTtFoakFfQMYdZjSUSR3r6UqZTh8IKuj2m1W24Yd1jt/mOp7C/vfIgiuR8qogG7fzLi/VEZE2
	eD677Z2X2OSzvdrL9y/gNQMofPU8JspM3PsRnl2F9BCWBC3saYKmbpXiZ9voqFlAcOyyWcFvVCi
	/UcNseR/ccwUqqNsHhey4A81Hb9MqXQWsC3kkp3J1s9PwQJI=
X-Google-Smtp-Source: AGHT+IHrA+7zJge9i962S6orPzAQDEhO1XUkEFQ5EVyEYNFg3sFEV8xqGFfQsZM23vmED8/k7VCvpw==
X-Received: by 2002:a05:6a20:3c8f:b0:240:195a:8324 with SMTP id adf61e73a8af0-24055015142mr19729554637.2.1754920302821;
        Mon, 11 Aug 2025 06:51:42 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:42 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:56 +0800
Subject: [PATCH 4/9] soc: apple: sart: Make allow flags SART version
 dependent
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-4-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=qu53Npl9p1UJIa6YTj/hRvC8zr9mwt5eIRHVXIxtFxQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVQh6mVaSEh/31vtj9Sp/TjrE7dHgIyGxnSV
 ZSHXuJG3rSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UAAKCRABygi3psUI
 JMdNEACdXz4QPo+kOUFthywvLIAGegRvepLxUfokbyfdsVmpojMj5j9zId3XrjZaa8HjvdpGKmE
 rZZGAFvoGvQfoE/WIO2Hn1MS26yqKsXPYsIxtkaQnAuObrk2MhZPxHCcka4i1aokE8sC9lAKL+/
 WwNhnJr/hD5WTXNy6wC+RBRn4tXEdiOI7/Ix6tts1yudkv7AhcmLE4u6G5QuDs+8t8FHIA9Y+wo
 AEmSOYgHvNYgA2jvkRzinP0p6ogaX10fBWbfMlN34q/OHGUN6MLsHWhrq/KnOlYnfdPuvWYCXnF
 j5b6JVgeZB8TJH7fol5y549AWuyPtfVkyrsCoPfRWd2kssvzwjmcYX+eTlpLhK9REMjWTTc0/SD
 jWQpFkqaYYAUrqGl8WozokSUmyXcVwyzC60zqOpAqPAbFuz3xb6fPkFatm7RB5/9KRQwnNmqQX2
 EU1RBIF/CxOMBhYAgMaL0GeQT+4xMMc8twKbo8+XNJwuZeY9E0cJfTLhEfJkUzfIpv6rb/iR7gN
 0zE3w+661aGxZ+mpWdJYw6kKLSJNdhAzEjrB+8vIGNF7GaAFIIHPBJa1MuafMfvTzAYRVZmJ3UK
 KzuQzPYuHQhNcKrimU/dsRcNl8OQyzso+9rPKwiTQaKpTuieMMwgj2cTa0fCYOA4Jd95hwZU1lJ
 OvHb0vAmQYyExsQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

SART versions that uses different allow flags will be added.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/sart.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index afa11173689979f100a63221af03214f4a928a7c..318f6e518a54f6edb8b97e320519df8f77c7f143 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -25,9 +25,6 @@
 
 #define APPLE_SART_MAX_ENTRIES 16
 
-/* This is probably a bitfield but the exact meaning of each bit is unknown. */
-#define APPLE_SART_FLAGS_ALLOW 0xff
-
 /* SARTv2 registers */
 #define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
 #define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
@@ -38,6 +35,8 @@
 #define APPLE_SART2_PADDR(idx)	(0x40 + 4 * (idx))
 #define APPLE_SART2_PADDR_SHIFT 12
 
+#define APPLE_SART2_FLAGS_ALLOW 0xff
+
 /* SARTv3 registers */
 #define APPLE_SART3_CONFIG(idx) (0x00 + 4 * (idx))
 
@@ -48,11 +47,15 @@
 #define APPLE_SART3_SIZE_SHIFT 12
 #define APPLE_SART3_SIZE_MAX   GENMASK(29, 0)
 
+#define APPLE_SART3_FLAGS_ALLOW 0xff
+
 struct apple_sart_ops {
 	void (*get_entry)(struct apple_sart *sart, int index, u8 *flags,
 			  phys_addr_t *paddr, size_t *size);
 	void (*set_entry)(struct apple_sart *sart, int index, u8 flags,
 			  phys_addr_t paddr_shifted, size_t size_shifted);
+	/* This is probably a bitfield but the exact meaning of each bit is unknown. */
+	unsigned int flags_allow;
 	unsigned int size_shift;
 	unsigned int paddr_shift;
 	size_t size_max;
@@ -95,6 +98,7 @@ static void sart2_set_entry(struct apple_sart *sart, int index, u8 flags,
 static struct apple_sart_ops sart_ops_v2 = {
 	.get_entry = sart2_get_entry,
 	.set_entry = sart2_set_entry,
+	.flags_allow = APPLE_SART2_FLAGS_ALLOW,
 	.size_shift = APPLE_SART2_CONFIG_SIZE_SHIFT,
 	.paddr_shift = APPLE_SART2_PADDR_SHIFT,
 	.size_max = APPLE_SART2_CONFIG_SIZE_MAX,
@@ -122,6 +126,7 @@ static void sart3_set_entry(struct apple_sart *sart, int index, u8 flags,
 static struct apple_sart_ops sart_ops_v3 = {
 	.get_entry = sart3_get_entry,
 	.set_entry = sart3_set_entry,
+	.flags_allow = APPLE_SART3_FLAGS_ALLOW,
 	.size_shift = APPLE_SART3_SIZE_SHIFT,
 	.paddr_shift = APPLE_SART3_PADDR_SHIFT,
 	.size_max = APPLE_SART3_SIZE_MAX,
@@ -233,7 +238,7 @@ int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
 		if (test_and_set_bit(i, &sart->used_entries))
 			continue;
 
-		ret = sart_set_entry(sart, i, APPLE_SART_FLAGS_ALLOW, paddr,
+		ret = sart_set_entry(sart, i, sart->ops->flags_allow, paddr,
 				     size);
 		if (ret) {
 			dev_dbg(sart->dev,

-- 
2.50.1

