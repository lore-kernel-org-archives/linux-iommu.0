Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746E3074B0;
	Mon, 18 Aug 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506637; cv=none; b=KM9+14cbFZYbwldrBjR4uGEcV121IixmJIxKp3dST931NA5SLoXJcTXvMP3VSklkN2SMA9WoDihgnXguojmPRch80VpPlT3U0mAY/eWqy9K+1lqkrxwtWm6fSfiUyts8zvnGgWzg+Sbo5RhF7+o+7gKNkJYmKE/wYX3jVbr6Bjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506637; c=relaxed/simple;
	bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imq18/ssEdv+Zaa3q3MoZKt2w050eQygl4Zuqr5aU7dca8Je8Z5Ofzr2B/45ctgslFzkE+GXBHBTE1RjSp3iZZrbWSsbR7//z1Q5ViVgzcv4aEfNzikq9TPL73wG9PvWKSx11uX8qRnQMwYaofjgGA/DdyOaQy0Karlj98mKtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK8USEd1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK8USEd1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24457f47000so31009365ad.0;
        Mon, 18 Aug 2025 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506634; x=1756111434; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=DK8USEd1w1z5ZF+uiZT1EiZlxvzwYvgUHwy3Gj4zmLJQlzxcVqL05bK1arsl9hIojZ
         4qqzmixmnLUg5nB1cA0RumecYsVDgN+sOBktZ3vCKTPVkcO6y3W04R5S4pwMa+topkRk
         pZLLamNBHdjV/IEO6c1vwkHf3/HmeFN0u56L5a/1OhZj0zJ30xcPW25UWZOKoZs0XWEN
         Ns92gigJoy4yMifzzGABU4IerhBlQfHYMqFrx0w7oyrn2Zbo+FSmD/CpU/yo37OYrhiw
         O/e7d72KT2u/dDl/sLVuoUyAMn1lx/wVoxmTmZS4iXoVAupGlM9z98nNxjt4pB2f2Mt1
         FIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506634; x=1756111434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=gKjK2PJ55OxlhwH0OEAddmAfWYQ5z7n/iJzykjkrJipG0aLGFxx+eVcbLjmv/qi5MA
         NlZknYZyLQRpjjeUYzoicl+o45NHchgZga+G225IWcFxjwggP/AJxMWFAmyzKwJUXdVq
         wdfipiIpcSEyTEVTe/9Zu50l5TLqo0TkkAep2cJwePPmPMkCNB0T79t+etf/XC0RC4Iy
         zL2YanUxrtslmhQ/wWAa2TA1hhfciydZeuCGyEX0ZDa6zJZwJmjWRmcWEPmEwjqF1S2t
         z1M5Ao/NLSpnao9oZ/PcjqeS000Ujk9xGdmMBDWY8FLA089AtTCj/wK92ROQbqNBgUk/
         ZA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUZ6iOzMUE6DisgLZkFA+mMsOutPZ4x5eEKe0XZSglijuWxRvLk6NmXh7PiX8CglftxtmPQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8AzH2+AHl0jau0aLRnJPi3/GoCFITmdq2Mz2yuHMVCsAXvVIU
	pRrJcKktHFe8muC1b67AIMi7A3rUb3j12vGPiomm1HRK+k2nBU0dINXR
X-Gm-Gg: ASbGncsGq4aKdJ/gnsv0XjBYQtIXNK80bRPWCjowsjCfFSCWWWK1xjTriIy6XCACp8f
	M6ggAr2oLPMpY+WMVYD+vVLXJ4FKVbH3lGuqfYe6R5pMzBR68ag/wloxH/lZ/4DPcYmaoBxcXu3
	tWIna3zKSkC0Vq8b9uT95Oq9VNFI5hzf2oxXShHbX82Kih7UTl9c1cEnijxcTVTNfKLsCEE+9Rq
	MTvWvtUnADKbfo9myDYIw7If/e/SdgrX7IDDtFFTgzY25oXoOc3dbkhTVGeF1X71VwHCXCGlTfA
	OtkpnRAn1akbaSRXC9PdMIRgGTKk4CTjVuQsGezlIudZtU4D2h1ui3fa0A83g/HTuEKvWUvecW7
	Go4VZn5Pao4GNOZoY1ggjwn3+VaJnuURDha84mntvMqpms6g=
X-Google-Smtp-Source: AGHT+IHZT2isaZc8TNK+Ul72AEXTJHFHaWWnaLR1o3EAxYeINyGXfuxT+CWND5sj2IAPUNrSMUB1ww==
X-Received: by 2002:a17:903:1ae6:b0:240:25f3:211b with SMTP id d9443c01a7336-2446d980b96mr146776455ad.51.1755506634073;
        Mon, 18 Aug 2025 01:43:54 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:53 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:58 +0800
Subject: [PATCH v2 5/9] soc: apple: sart: Add SARTv0 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-5-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouel7tB5pMk9ZRPwFi3VYfo+wHw0Ob6V61kt0
 cM9qXkKNL2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JAzLEAC3GE6E0JJaoSCxIkhKLQwRO5CQqJZORLUx2kZckZ15RN2ygxITFBkfPiprq86LvbbkbkE
 I0p7uritaNmuEOWjwLU0GLKgNMgDrdHOVr46dPQmjLA+eYyZdLDBWVcgPh19bhvkI3vNYiiiLNY
 T1aA0yScyUMImiJYFXJ7JetUa+L33QKyMVYEo3ahLtQgDpgM+N5xBWz5Qb7xczGySFHR3oymxd7
 CE++jb6XpkCJ65D3KUIx5UihSCcya0EdlU0a/wJJhXgBe3Z44PUuhxHibvVQNBk2BWZ0dCJG8Sk
 Lc6fUQA+mg8RiZlTyPaW0lfhWkkQm7gU4nIjhC+b8r1ZQ8/82kIxy5Q+zxw453asfjDntuEdml0
 Rx0YGtaqd6XTWiDi5jiZAEi6uJba+cmA39hS7G8LhGiTpsvI3ajeqaRAIaLXZXnJipyEIz1Bg67
 LhzLbIaK2SbgcfrU+I4LrZULDInsrjjSC0PLZ/sQ9ipvWIXLCzotPFR5IuzUaesLEueit8tmRjf
 SJhZOLzPmKai2LhRugKpEpD2OVRhzYZtHmFiZWoVmpIf/kLbXyT7sFaVgVfdMmkyOzbVgCs3gb3
 KuymzpXLz20+s/gEvuuKa9OXRnMfKHrDhUVNtdeZ93M/BJOGQ9QacRoQp0kNnlrtVcnLeIffl+E
 gNvlqFtZeOmGY8A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for SARTv0 as found on Apple A11 SoC.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/sart.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index 318f6e518a54f6edb8b97e320519df8f77c7f143..4ff1942b82a74cabeda99540ba63c6e92386986d 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -25,6 +25,18 @@
 
 #define APPLE_SART_MAX_ENTRIES 16
 
+/* SARTv0 registers */
+#define APPLE_SART0_CONFIG(idx)       (0x00 + 4 * (idx))
+#define APPLE_SART0_CONFIG_FLAGS      GENMASK(28, 24)
+#define APPLE_SART0_CONFIG_SIZE       GENMASK(18, 0)
+#define APPLE_SART0_CONFIG_SIZE_SHIFT 12
+#define APPLE_SART0_CONFIG_SIZE_MAX   GENMASK(18, 0)
+
+#define APPLE_SART0_PADDR(idx)  (0x40 + 4 * (idx))
+#define APPLE_SART0_PADDR_SHIFT 12
+
+#define APPLE_SART0_FLAGS_ALLOW 0xf
+
 /* SARTv2 registers */
 #define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
 #define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
@@ -71,6 +83,39 @@ struct apple_sart {
 	unsigned long used_entries;
 };
 
+static void sart0_get_entry(struct apple_sart *sart, int index, u8 *flags,
+	phys_addr_t *paddr, size_t *size)
+{
+	u32 cfg = readl(sart->regs + APPLE_SART0_CONFIG(index));
+	phys_addr_t paddr_ = readl(sart->regs + APPLE_SART0_PADDR(index));
+	size_t size_ = FIELD_GET(APPLE_SART0_CONFIG_SIZE, cfg);
+
+	*flags = FIELD_GET(APPLE_SART0_CONFIG_FLAGS, cfg);
+	*size = size_ << APPLE_SART0_CONFIG_SIZE_SHIFT;
+	*paddr = paddr_ << APPLE_SART0_PADDR_SHIFT;
+}
+
+static void sart0_set_entry(struct apple_sart *sart, int index, u8 flags,
+	phys_addr_t paddr_shifted, size_t size_shifted)
+{
+	u32 cfg;
+
+	cfg = FIELD_PREP(APPLE_SART0_CONFIG_FLAGS, flags);
+	cfg |= FIELD_PREP(APPLE_SART0_CONFIG_SIZE, size_shifted);
+
+	writel(paddr_shifted, sart->regs + APPLE_SART0_PADDR(index));
+	writel(cfg, sart->regs + APPLE_SART0_CONFIG(index));
+}
+
+static struct apple_sart_ops sart_ops_v0 = {
+	.get_entry = sart0_get_entry,
+	.set_entry = sart0_set_entry,
+	.flags_allow = APPLE_SART0_FLAGS_ALLOW,
+	.size_shift = APPLE_SART0_CONFIG_SIZE_SHIFT,
+	.paddr_shift = APPLE_SART0_PADDR_SHIFT,
+	.size_max = APPLE_SART0_CONFIG_SIZE_MAX,
+};
+
 static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
 			    phys_addr_t *paddr, size_t *size)
 {
@@ -319,6 +364,10 @@ static const struct of_device_id apple_sart_of_match[] = {
 		.compatible = "apple,t8103-sart",
 		.data = &sart_ops_v2,
 	},
+	{
+		.compatible = "apple,t8015-sart",
+		.data = &sart_ops_v0,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, apple_sart_of_match);

-- 
2.50.1

