Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB22773C1;
	Thu, 21 Aug 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791864; cv=none; b=RsP4hHMsB1joGw9Kp/q4sxigcvEl8GCs5C0MYnA0UY/uuYM6lgB3GWUWbd68fSfNM2TURyHhdAWOP7I0O5mmdgoxK9pm2uu6+ld4ddnKi1YFjMVLiEI67u+Lq3daQoB9qoPlFVW8wjdGVlme4aPk7svzPmLnREbAXWnxH9j0Cyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791864; c=relaxed/simple;
	bh=SfdgOsOFi3dLK60ZgLb2wBFpqlY1bGwIVMJiWwSGmDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2Q/sXBakUahNeM5k+dK5kTZeZVI836Gwvj04+oZuQXDHXxVtsZV2BtlVxh70Kb2p47MzrTqoLUbim9dU7TJUEVqEXwt9/WA/DsF+QRQgAeVYgKXcGWz24dqhpiMRFNV/YpwSLjZQ4fp8UsF5foBvHUPiIZgDJ2TDISFv5Qpk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtMeUK3g; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtMeUK3g"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1453379b3a.2;
        Thu, 21 Aug 2025 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791861; x=1756396661; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=WtMeUK3ggxtJDFysX9DnhaYXWfeL5gJ3FDSJTlRLffKfUGaQe/PS3dSYc7K6QpgCum
         LRXqRLlyiwxK1VLoct6/Lw7Dlo57jQWylj9ODuBjexPpkIhG4+/gconCsRQsgDwA1lT/
         B/bJOzj0TZEtH9zlgLcknQ1285OM0CFpP9D0ShVnu3UYBKef15J7n08aSOH5Ve5WXnSs
         pCZz2+u6QDbWuTI2n2Ck46Gcqm09fPENxE3vsCQWyAU21gx/d0ERs2oeYx66XuoRExnK
         BMO4gGRaY2f4rl8qqyFgjEz/FdXDb2mzKgoFMyoE8iFqukfqNwTiFOOSDDfJ/PE4m7ZP
         +WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791861; x=1756396661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=TF4WvlAIabTCIreg6VpDIl7qKNXvxNyLumnc0eG+b/ZK+QR7Ru54cUSveDcu3oO+Po
         /H/MoOsHoOxl1mG16mNNNDaGSOqm+/qXKie/+Gd1LwjawQW/Ud/a6KqWx+nwHbE3cycq
         W5xRTTJuMZq0C0dw2cJZLd5nWzm9JBd3ffw2CT+jgS7JYito2GRYayJ4bbkr04qibDN3
         LjU+i6i9aIy5ebqwUVqKF7TFH2rXTOJuVO+cTmcQTIRXNEAV03jnj2M+KmnLzItZ4LHh
         R9nZ1irwYadeZzvgo5CJOzQ17OGj2xUwGfcHc5lxd15X3zXeP8tSb9FXwdGLAEfvKME4
         vFNA==
X-Forwarded-Encrypted: i=1; AJvYcCWVE9dttIlXMefH5Uw8ZsGkG5AdZAlLmKG+1yXForDlDowpPdCQnPK/yR3AtmnM+tyFfAax3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUwRhiwtF/TqylQt+RzZNlMs5JZOTZLlkvsNPHQp7yje4AspsE
	k9TShy0Ex5VAHVekANsMC9lzYgos/jNhuXkG3fhFticfWMnYzDRqA3nk7f32rA2D
X-Gm-Gg: ASbGncuwuoL4qSqE8yGmfHWNPEAZCtZHfCyR2llFQDTJ8Z02HYj959BykfdsyYKrK1U
	swopAgj7KksViszsANIjnS+Ae/QAAVSBZSHvM7HClSANaDKa1rg2r8CtS0ZiDcXsbEj5pMN/Orc
	R6xxup02Ve+YkSQFvkIutcW1W/RzFTBFl9ZVXTo2PWoaRdl5JJWJJiORlQs2y+lpJBakt+nNNfG
	ZpbuYBha2BUIQeHnvE7gpg+iIDMG0HQ0tl7USge4Xc0MoCKsEAZ11wcxWUkCW1KAwj7pn3RYklD
	PhmW0w8GOZXbZ5mbq8baVy/VgmXJXay+fKsRQA2xmKV25QrIASdg85fu+uiPOx3ZPZbTlzViej0
	CSB/r2Ow/eAUEOhGDnHXhyJHGAQiHhZe4LnqVFcZnSb3bAFU=
X-Google-Smtp-Source: AGHT+IFaU8yhtF4FFIW1hpaOV+kXnGjxNNTFWVUFtb6OBi3B+EkjNWrkNm8/OJ6NhTYEe/kYZZJ70w==
X-Received: by 2002:a05:6a20:1594:b0:23d:68da:e40 with SMTP id adf61e73a8af0-243307ca9f1mr4413857637.19.1755791861128;
        Thu, 21 Aug 2025 08:57:41 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:40 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:41 +0800
Subject: [PATCH v3 4/9] soc: apple: sart: Make allow flags SART version
 dependent
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-4-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=SfdgOsOFi3dLK60ZgLb2wBFpqlY1bGwIVMJiWwSGmDY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HU7NMtHnDkY5eAbeUg897zyDtXJql3NIamI
 rTb/5lcQeqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JMYhD/49jIthH6VQtzMK6W2zDSG32o6Id0W/AMPYXsqaYqU5n8yIYzQxh+q4gahOIF/mXdloZTB
 93x5zyPVbtFwwBEkANe4rDpwYqUKuuVMYxpWMd0Oye0wcvjNNkPtVMIar/d5dXEki1gGBk1RnA0
 GuA/y2QzBC4jfmur40VswT4HmEvN5T7/HXdaE3zS/uxQPfhatEUWjC9Tq9/16CcVISf5TUWyWGj
 sWcLbdSRtRYpO5KSAbxkzSVsPBEVZv2i55IIpa4g2FWcHSTuKQt3jJr8/6FXlGuPsc2+rvswJEg
 TL2Zrs4nI9nqA+mHcYLzq8DqdnMU4AiMQdSEK9/6EwSgGm0nLPNUb8VW6JpOTQSsFSZTira5e9r
 mE503tlw9DVn9n5tteADeet1LcNtQI1GUuEQZHWI9hEgEAB0pw/4PNSVLz29tJmBZBljQwCC13D
 Pgb2Sob83ISI9pVshvulPR7iRRF93g4NLV8MWWLwXH1Vfy55vDszY6L6xoH2yIpUhgpYE5OqipC
 6o6lWV4MgMbdOR7ovpubJDs5BWviByBYSSazFjlIX80CKPeViTNDsM/mwEtGQXQZfbfpx9USdJt
 no3pwe4OfZiSOWPoG68N4c0PVc/LkhvUm0sy4KesT8v7HTk1ipCminef5J+BzFWxsX6JkNdZxJC
 9oEqRbSmCDAQ3aw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

SART versions that uses different allow flags will be added.

Reviewed-by: Sven Peter <sven@kernel.org>
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

