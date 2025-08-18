Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E6E308F37;
	Mon, 18 Aug 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506659; cv=none; b=iMvSJICBDvoWX7UJtUf4j7QA8XTqtr+Dhp8WJK0+J7be8VBe4kwQKjJbPUxS5VYMd852nrTN0MjIx+qXJY+w6AVxMqxrpbXBr4YSekRzwAsLgDAfrRZdYUjLHYaZpUtf6Thyp9/sR1c+r2toDObRdo0jy7ZD++NDZtHv1d388ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506659; c=relaxed/simple;
	bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7ImswJCE/G8BoxgojNISMsEaGOhnvKJKJ/HGpjp3NMU7+rxDYKnRI04Q3VIGqdXWEEbUTS6MnzWnPGSwWVLAYbEXg5bmBia6+rKtlWbhfZI5nOc1Xz361QeLOgyfL2TP13NxFZrp+1rpzdk37KuwsseU5auw3zccCbWz2DQYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuZlDMqv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuZlDMqv"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso2292426b3a.3;
        Mon, 18 Aug 2025 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506658; x=1756111458; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=LuZlDMqvQ5WtI2Ennaqt5o8SZ/eZPTDHHYdOCDixv0I97nGIe2ynjhqdVwb7dSd8HB
         vxlySf0Gzv1s5ryhd0mlMoI1Bv+cmEiMl5YwGgt6+tfthCUL1G9Clmor9669GghnVyNp
         N4cedf55CS4uIaqpmc6tsrJfJgM8acVyPINNcUAbrHj3hb5fhrodEBdqq55+Y4RkDvdD
         vl5XKhZK3N7T2Q9Qa+imu3wEwLR96zoMu0uhYT3vIbXJ5jtsc8PYfpKMjtePyHd6T+Sj
         bYGVyhoo2q1C5h5pp/MbfW1J8jRPdEkyhJE8cxZzqTITQZTz0BFwmVPFPL67xS6hzbAY
         LNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506658; x=1756111458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=rLotHsI6J4V7Bf1rRUZuT/msDgWu83cMPHyp7KVZ9y8LGc4HlNgLOeAXvI1ovcjGUw
         D59leKwovLRHrPvZPBaK0qcSIT4LF9fJHun+Ei5a39mvV48TIMcgxnUjDJMjVDKynJA0
         SIM69oCzzDexh2FbjWkMxfIh7sXxPV+hdfydp5MCToTfmQ41Z5z/iPViESm1znXAdZMU
         zKPbHoMLhp2a+tJR9u6uZZHLGY0H12fmvA6ecNEwuMiCBjJdNV2h2LIUJBz4vm+kWwyh
         tkIl2TiDusfsA46UhYc+PzVD7YfgsMdxOOofjfkUSuEQfgC/fq9S01LK/NZ4jB5WpRnx
         dEog==
X-Forwarded-Encrypted: i=1; AJvYcCVi+bQJss1ZELyRuAPRHakqqXxjmjn1KW70GLoLFlFiBplBxXlWadXSoRRHDKCLrWc73m5Jmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQFKcmMvxbKMeF4bkJvjpLJRF0vgY/Lpvadba6Po5gSegVmw44
	ZBSMw7TgAc6pl20Lkd+Xq21ITeSfE0McUQM9caI0P6TOviezaJ7LfPeV
X-Gm-Gg: ASbGncu9grnEHq3PzkZlK8lAF6wUyNd2t8YhtmSFpogM/31joEz7jJHUqbcNfNDdgmR
	uNeqM+jjcQ0xWSF4yK8QrcNknwnRWjdZxwOm5aXoi27tSTxfixCRPOarVpAORSjXn4a7wRg3QGm
	W3mJcJt+nBzPQNm3v20GhJjOOpCF0f0u6tj7WEcylZpWPETP4mrs4CoZMZJmOLzg39EeU52DePX
	r2BTbQPzz+klw9pjjU7URmEGQdAl6sXAjomZt8nBsMe1raE6JDpNXaMPjQ9LaqEvWQ0wlTGQvz2
	LD51aHRwEnmDzgW5LhYfDM+7wqEUIj2KAaeXIMDEEsML4LLHxuSo7A/NXtdXnnLjxS007vIe96D
	fo+r9t6YtaJPsrR+SgvEv0XJcwkYQRo4hCtTeVVD3BeoEsCs=
X-Google-Smtp-Source: AGHT+IEZ7SgzaIcViACMoklHwNzXuNrvR+dLxWbWKBIt+/2PHm1FePLfHPE2fOsDswTJBK1kq5uTyw==
X-Received: by 2002:a17:902:d2ce:b0:235:eb8d:7fff with SMTP id d9443c01a7336-2446d8b1f83mr145333235ad.28.1755506657783;
        Mon, 18 Aug 2025 01:44:17 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:44:17 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:43:02 +0800
Subject: [PATCH v2 9/9] arm64: dts: apple: t8015: Add NVMe nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-9-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouemdDCDE0LTPBZa3djToJLXtZ0KFQccDpzbs
 4vZ5ZKiW8qJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpgAKCRABygi3psUI
 JCcpD/9Le073yzzucsbRvbZQOWl8EyMIsowsDZurct6uSh3G+LuNqc6CeLAdNkl3NfDZNbBUP5l
 dYqY/G60ao58ZeHJqd5L2pzXiBiW3uIN8TXATozENYrsBjP4+JcMqiGIId5LbEgukc/IpIeYROm
 2D5Xz7ETB0KnIg42np4fpZpljQ/QZOST9qi/n5W32yCkGIwhRLVLBM5T9pI2NfF9nUHlUcW6Uo2
 61haY/NF6qVhXOWYkfZ8AD5I7RM8H6yub1MJIg8p4nfGw75KqhtLOem59PYVel9NhammZesVXKQ
 fdUvePBRwAymKhbqhwA2VCdEfDviP8X0ENV5Mw3SrUujPvKVEE/IYLT4lOUmshWOxJwcBeWU1UM
 6QyogMYmueE65OPCkaSgQxk/U23yje4L++Zi6Yg7HDL18bZKPAXtsK/K6WrHBdsgDjaS6U2rXOa
 K8tRg04xb6dImHo8juZWVa5NgdDYJqE8Nn/yp4kAdyTeY4BuHIIu870gQo/nahWQ55hoDgTrPAI
 0ov+tkD3RHIVZZocP1JfIUVVn3D9vP3vceW2FIVbPacvpMDfqsKq3muKQBWfv/giMMohAMDlAjv
 sQHf+xvgWftQp6HsVC9TK1Lm0SJkWogXCRVUO/QJc7X8mZ2hx8rl/8scVQITbZ/B7Frp40Vxu7d
 yIEr993vDlfzcPg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add nodes for NVMe and associated mailbox and sart for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..84acf2839fb6279dcc956e1f4cee1afa909d2f27 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -402,6 +402,40 @@ pinctrl_smc: pinctrl@236024000 {
 			 */
 			status = "disabled";
 		};
+
+		ans_mbox: mbox@257008000 {
+			compatible = "apple,t8015-asc-mailbox";
+			reg = <0x2 0x57008000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 265 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 266 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 267 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans2>;
+		};
+
+		sart: iommu@259c50000 {
+			compatible = "apple,t8015-sart";
+			reg = <0x2 0x59c50000 0x0 0x10000>;
+			power-domains = <&ps_ans2>;
+		};
+
+		nvme@259cc0000 {
+			compatible = "apple,t8015-nvme-ans2";
+			reg = <0x2 0x59cc0000 0x0 0x40000>,
+				<0x2 0x59d20000 0x0 0x2000>;
+			reg-names = "nvme", "ans";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 270 IRQ_TYPE_LEVEL_HIGH>;
+			mboxes = <&ans_mbox>;
+			apple,sart = <&sart>;
+			power-domains = <&ps_ans2>, <&ps_pcie>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans2>;
+		};
 	};
 
 	timer {

-- 
2.50.1

