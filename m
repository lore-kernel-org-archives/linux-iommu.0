Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772393;
	b=OKKadzZa6z/S6PAegCPQq91o2nocCUG9+llxeebeDbl9KlT5FrGmaNSUNdn/HGK1Ifmf
	 1OtYTATlcE/1I0+3SmRyijhVCDI90dWsQRJk3ML4r6lYd4NU7zboaHU2FDZS6MPJhnkgY
	 D4rDfKiJRF8Z8vl0AAUjDRvshwxG0UOM2HqqKy40J1rNjXxXjYnB9TN2LlVmQCBQgxXw2
	 N4WcBJPeETr2qd0ECe3iQSym/3CwfLdccJwv+87PP8eXyBTKXDGiFjd8tw8JTP2zWN6A0
	 YTYiSKxWE40L6ecHsBQxDmBEb4CxTYxU33V6pLGY0fSBwjgovD1Ufqx20WoWsfWlUgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SVK9o+TEy+mRM7Y9b0GBxL1NkApW4WyeZVqrEHMtafo=;
	b=hwERhpSrVYF8tSjrELF8yT8zjhdDbqAP7Kec7TsoMNkzplLnAq3oNv8fNUKNQcDrV4Dn
	 y01VWssn1YXEjYzkM0IDoAHzlKPZIi5XkCe1tZG9AqDYtGs1M408kRL9kw4qGLqMpNZaP
	 PyNXV83lwYUJU3qK92iAnEQCD6i6aJ3dpbA9DpRtRDo8+atTquir2+iPKqXvSkc4M7Shv
	 PX6BcP9rtf2Ckfnr/tJ0V6g79KrRiHERBXuENpKvALCu/fdTgoTpalVaoJ0U7aGU+bMc1
	 HnH5aaPGH9EvUWDRKX2Zot/Tcvqkr2jMMBKAqiPlqUgRHFXn/Yn9XrwKU8URaC2Fsrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dXcl4Pk3;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724C606A323
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 09:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5724C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dXcl4Pk3
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso7083518f8f.0
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795772392; x=1796377192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVK9o+TEy+mRM7Y9b0GBxL1NkApW4WyeZVqrEHMtafo=;
        b=dXcl4Pk32cfbMhCrOl8J/p+nK7vgb1c4YBS7G5G8PBLmnUg6P7ML4WMuDiKtmUQ3d8
         yE8hXrAhCkCDDMrva2KT8788tTdpMZbMYLFfmGNOtK912rIZ7hSPHFD3fIllHLrwh6Zm
         ePPDcuJb9oks5d3OQ1II5RK0kCF1vUl/Gip1Ro+vB5FvDY3loNbM5Oq3o+dB+GwUeFhb
         auqacQpEMq2bagu3mB+k4QI8BOinv5q59Ht3ZFR0gYhD5HNujulLfuMvn0Bj1CsO7Lfm
         OC5/jiyE95UQiUikDriLCKTix00yVjsEvLxkWAxo5sbdUtvijAoxTQm/5zZ8a1+QlPAB
         Ni2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772392; x=1796377192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVK9o+TEy+mRM7Y9b0GBxL1NkApW4WyeZVqrEHMtafo=;
        b=BGHqVELYhOyOcEKy3LR/6LXdMmwcBXjtEweULOSbaFEUA3nJ46agJtrUUTDN9JRjkE
         0OsdhM5rlI4ZpnM9LiCCEDEXXF9xOvR9huQIMmG7lXzIdbqkW1XNrl/ZfEylEi1l9U24
         78y6uc/13XdjgblgctBfKo3nWTG/8BfrGvgtpUbjKfttSQCWBL5qKGBfNU9MZTOFQ0Fe
         9Cvz4JXpFCewJmLKiT1s3X0KLSjLE3N4V6yqWIFic9NNPyppYhyzlm6jpnR08Zq4Dr7i
         Tq/eMkCOTPiTa3L6xpt7VvKkdmVmof0v9zoAEZi2ZLmbiLH77zSwp784VBh/OyZWwp3i
         YfFA==
X-Forwarded-Encrypted: i=1; AL+hErGvoY53s3un5bI3x7HodF61CD8j9mOnwj3WtAQr99IyiuHSmipI/WXAeiLWEoebylFxda7tEg==@lists.linux.dev
X-Gm-Message-State: APuU4Z80o4By4EiXPriCwF8CHOcqhSdNw2AgDgJBtYDJiK3p1ntFE+7m
	YT4f5r8YJLDMQNtj/9De3aXuysTvKh5adVvYWLtwpu8CPv3nnf9d7dqS
X-Gm-Gg: AZFdTZfo6P79K2+D5s6uuvK1DjKuHxO/347xJTMd/h1VGN+IiT3Tvu52219AoaESnUm
	uNIw8okUxhe2fbu873S1tv5iZVsvV0J1SKRCdbWWd4jJaI/1eVf56qlXH6TXfR/cXkfU70AsckP
	T6WglCQInBiBhntc3n9itDqfKwWooeQDI2yb1VlAeGT0YB1TnUurct32haKmLcbwWucOcoiw17+
	rMQ5XczBoE4Ssxkfm3MLVfvYgqXXC+/5/LbRnXOMxLOZdw91Td4RJZSGZkzLiuF4QRZo23XIR6y
	BuPgqIqrKRilZIXMnR5StHVXi4+RFazUwtJo7WCRI2+EuZil5If/McoNn+tI9Pxz/rPIW9d5ysd
	zvePqLRxMcwpHG6aSL3t90NS5V8F+9FSebLxlSEy/mcpmjKlkPgTGacW1APTxEu7peR/wrFLosy
	BIbIH2yGptvCxF9PQvWXoRhesC64lKqsOZXp/5RfDyz8GZimTsfPHJHWXB1T7vXRCZq+qtHGuuT
	x939Y51+9pcIzs6gBmYROV0sin3FsBzHFXMVC4lRzRGzxVz5PjIiJsAsmEbgi1rx3W4Hhna3E1C
	plBtsNQqEBiw87zcs34ykFIefQ4a8l0+Wl2K1ATttF/ORIIPzQ3cSQRHvIT3whjH7+WP
X-Received: by 2002:a5d:5f53:0:b0:4b7:6ea2:54be with SMTP id ffacd0b85a97d-4b76ec0df5fmr25970915f8f.14.1795772391607;
        Fri, 27 Nov 2026 01:39:51 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm55531185f8f.21.2026.11.27.01.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:39:51 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH] iommu/apple-dart: Properly check the error
Date: Fri, 27 Nov 2026 09:51:18 +0000
Message-ID: <20261127095119.1342988-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The apple_dart_device_group() function expects pci_device_group()
(or generic_device_group() for a non-PCI device) to return NULL on
failure. However, both of them return an error pointer instead of
NULL. The error pointer then is immediately dereferenced by the
iommu_group_get_iommudata() function.

Check for an error pointer instead of NULL and return the error.

Fixes: f0b636804c7c ("iommu/dart: Clear sid2group entry when a group is freed")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---

(Found accidentally, while working on BPF stuff.)

 drivers/iommu/apple-dart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index d8302128b465..36ce5ac39b7b 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -981,8 +981,8 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 #endif
 		group = generic_device_group(dev);
 
-	res = ERR_PTR(-ENOMEM);
-	if (!group)
+	res = group;
+	if (IS_ERR(group))
 		goto out;
 
 	group_master_cfg = iommu_group_get_iommudata(group);
