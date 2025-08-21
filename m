Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6327E7DA;
	Thu, 21 Aug 2025 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791851; cv=none; b=YJFXdX3gR1e8cRVhmNzEADhz4yWfN+HYF9Hy74fUGRh/s+b0ggbpRUW4A/fu3rLfEdkS7BBIIIzky+oWruHJkgwCJ09rAWaik5q3teXczrnpXu+uOft3RE8/2tH+WKDz/I1lXiSTuMkxoufnM7w1MMMvGQYPVpXz31tWYO+k+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791851; c=relaxed/simple;
	bh=svMsQbdVjQ089a4loHQsnYthHi7jkbh4sKxZEGMZ2G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5bj3KnePXErteEuFFuu52F+41ND4wPtK3Srygd7D2hqrM70SWnoq5h580BMk/MiSTHTNbMB06AW5/zAm/t5G42F8nkdnmmqJeJsKMHw+73cAbe8W4yUCDZe6tNZ7JTALmDtcsMdITpEiG0hC3MdIn6l5PMI4/32Ci0aJfc8Cm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM5sN6Ni; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM5sN6Ni"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1453139b3a.2;
        Thu, 21 Aug 2025 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791848; x=1756396648; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=GM5sN6NiGKUEVedxPf+3UBk3H328qT8gG6Q6xJY1k1KiGjtIpmR+J9pHXdo/BOYmYl
         Rz2UbBTYGL9Mc1CvbkQxpKZIe54zpBzgOnlXCZSogoTR/+kz2pGEZyzbr9gJFoKhXz5B
         PXzMUHnCST2jgCYhQcv4pqYa8PgOJ1QCUuEGYGnpsA+G8zN9sCJf4IwnbP3j7Uo9pMmj
         umBMSNd+H/U9nLj6tUL2nzFgzIKh2A0Eb62hnG2JAivwdGCE5CGwPsc6NhNj4ddIdP86
         sQFgCbFszQo6pjSmgNKrk+SCS0+lLq2fBw85fzhsypKH5M96H0FdbmVWMEfeUAZJpjsP
         c+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791848; x=1756396648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=t3osubHAG0QbFPsOh467dkIcukbtxpj/fC0gG6bvLGi5mCvr9SDfGXZ2skv36IsxKy
         7moxThRqFOu5UXhvSb8rT7TsNd7EHGVlLqIPg9Bco0V4waXDhd+DWkWjJp+VF3dMeGjD
         6msvh5jl9AZWi5V/BlrUpWuRmGX54BkIt0cRHUYxuhoPIPeb/cYUfXz8EgIhhmOSc7/a
         H91v2dUlAJNTU/V1205JO5ffRN5Max0ScfeXJWk3K1Ro3W15elcxY088tzKGWohvxvKT
         +nQa0hUPAu+evTQdCL5Cex7juLNmwI+hqi51aKqICC/1/mTDuNwOzHLR5oZwi3zG4rnq
         0KZw==
X-Forwarded-Encrypted: i=1; AJvYcCUET+zQ4uTG4apYC2tAmd34+ZtJ6DAl9/e/S0EyV12pD9ZCwrxQhs0Llhq4OzIp6Atey6D47Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkTCdet2rnqLkoE/Ye1FVSvqV5NMdPagg75+71H2ffmvTljceK
	igjmjptiUJkVVPP+zrhgdGfJrc7Ys0CmnVVEUtjiBQkapd+NV4ZGa53c8aI/ft+C
X-Gm-Gg: ASbGncviVpSSduNPZeCw8hwnnLx5qhZ+AVNsUMWETa5xqTZSOPARR8CAOeVCaQvLlPC
	13+EIoRM1HD8r1Frf3xxjCKRTVk9T9968d2E5TUerB/UfomRCnA70FeEO3jN1IzHZZAqDMB0O9m
	KO+eL2otrnX7BawN3aXc/Z8bSHbtSCmDSAWORoch1OzhoZanPpLJkywso4CV6dcj+bDJjeenfGI
	0QswC+VGTmb32qPiqwIcM7rikg8nXUOJzZOHVlesVr3Edb24uH4ihAALv5nVzkuFFER6LMt0HWk
	dNnd1t1AapG7PhwZ3UrzwteqhT0z53MvSD/UV3HjfxLE2GJyHQaL6EZdoEG8FiNfNi1FiNweL1L
	Duze/DDnUzXaEiMaTGEC+0riJLb+SdoXNfSa8HE4mvB2u07s=
X-Google-Smtp-Source: AGHT+IFJECtN2JBxWTnx/B5whjt3GAKIljMS7Cdf8bpeBXhuCcAUtRueDJJA33kBEPKfW+AfsuryVA==
X-Received: by 2002:a05:6a20:7349:b0:23d:ac50:333e with SMTP id adf61e73a8af0-24330a6922bmr4449826637.43.1755791848470;
        Thu, 21 Aug 2025 08:57:28 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:27 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:39 +0800
Subject: [PATCH v3 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-2-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=svMsQbdVjQ089a4loHQsnYthHi7jkbh4sKxZEGMZ2G4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUsDkeUyeY8L8Ri1VshHhDwApV456m3+yPI
 5Fi+gqjcEeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JPpqEACU9bzBFeE/CYD4VSK97ziuAegkJJYF/LPx5Ws6y6IIDDAhrhJKUyNxTI6OpltFHUqA0F/
 i4ANEHT/uMb2Y9iJr9Ydp6oP6s6bex2+Jr/xYe3OtGPO1cWitxqEhUORWZ4qViICtbJ6D/H6Cwz
 CZ2+GyBHtn6vggUsNFH0hJMJ2h32eRNBlP8i3MRI1k+RUasl5GQIQLwMRhlVuUJ/1mdkqzIqKEm
 0PiIXBv166RtN0aWa3cC/3Ck+vuK3Lc5pzpj1JLM6hyDTW0Xmhq7j3gR+f3GF+x2B2vQ+/tccQd
 Mn81SfmS7f37AcPsh1PfvmHs5xJjOl9T6ryDVFNIwxMwpPGf++ISMkgn0zvwj9x9jXfbhFhBiMn
 nCSOWlAI1/q+2hn1lbgtdVM0b4ZNWcoakAH9CVoOWOU47okzBVXfK9FKlCb86eYryM2KlvXfCez
 5utJZjQdIL47aXWOtrSh8U5avHWRj5Ondzi72vl01s3g9Kn4tYOzFh2g8mc90aOhgR0yUTYtycV
 bAn2p4vHQfOJZqLv6hXlzIyp5ROriNbr7tw0jaFRYtk+uVIvJr5/asLUQBAE2DX6J+XUWHr062o
 cUfoL0d1tyLIFPSuvZ6QstRD7eGGBfpd9g7IGp1eRPz5isuWprfzyC2alt+VrBhp7kmyErDogqW
 Ktfu26RYg2uDigA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
coprocessors in the system.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/mailbox.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 49a0955e82d6cf5eef83e5f63ba8d31194c65324..8f29108dc69ac964236121d439e86c923a441265 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -47,6 +47,9 @@
 #define APPLE_ASC_MBOX_I2A_RECV0 0x830
 #define APPLE_ASC_MBOX_I2A_RECV1 0x838
 
+#define APPLE_T8015_MBOX_A2I_CONTROL	0x108
+#define APPLE_T8015_MBOX_I2A_CONTROL	0x10c
+
 #define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
 #define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
 
@@ -382,6 +385,21 @@ static int apple_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct apple_mbox_hw apple_mbox_t8015_hw = {
+	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
+	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
+
+	.a2i_control = APPLE_T8015_MBOX_A2I_CONTROL,
+	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
+	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
+
+	.i2a_control = APPLE_T8015_MBOX_I2A_CONTROL,
+	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
+	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
+
+	.has_irq_controls = false,
+};
+
 static const struct apple_mbox_hw apple_mbox_asc_hw = {
 	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
 	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
@@ -418,6 +436,7 @@ static const struct apple_mbox_hw apple_mbox_m3_hw = {
 
 static const struct of_device_id apple_mbox_of_match[] = {
 	{ .compatible = "apple,asc-mailbox-v4", .data = &apple_mbox_asc_hw },
+	{ .compatible = "apple,t8015-asc-mailbox", .data = &apple_mbox_t8015_hw },
 	{ .compatible = "apple,m3-mailbox-v2", .data = &apple_mbox_m3_hw },
 	{}
 };

-- 
2.50.1

