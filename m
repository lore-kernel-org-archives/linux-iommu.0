Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBEE19DF5F;
	Mon, 11 Aug 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920334; cv=none; b=nIBBxOpFjkC8MNQl8bbKA1a1EUho0Q5vNvjhTz23uXzSYaSM5WKJu0fvUmbv0S62Cg1gfrQS4wMIvYU7g1cxJzrOFY6tOhKAID7x/SCIQoLcDdwnaw6st6CJkuZmKk8gKd0Diy/KURVE+DMRzojEM3MZ/8mTcqbr9fETLop2N9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920334; c=relaxed/simple;
	bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKbixWnh9kpQ6oFjes0rYOxzFRduzwCy131KeafCeA+0pWZzBabGrFbANsw4K/+WHcEhCbQMupai0wXm2RckJwbqeCBqt+mIUl+3fIVxW3HfnhAFuGb1e6mqZcI7h8ETLJtWbCwPLtJBDkIhMDFS+aeZPJdouKU4AfwwMSNSQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5CLI8bf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5CLI8bf"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2402b5396cdso26898615ad.2;
        Mon, 11 Aug 2025 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920332; x=1755525132; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=F5CLI8bfb0NRyIeoUVh1vPyNWMCO+vAerPB0l5lH4hA3+BvkZ9bhfS/eSzg9X4uKQO
         UfaUPE5kX7MkjZsA6Vnn2FJ8A00zfcnURpTzOUTvowXFXVO81I+WEsusQssmnXINjKFs
         Kei3WIDqr3xVKg2hB5HwgxZRfZh68PW1QSUSY8zHW64KPTq+wABJjD9AdCpkqnjOtHSv
         hCo75Ds1gx1CCHE4DrpIBsZuO9EuLrCYv28jifiGNY76stUbcKFR2JLuBunsSSbhcBII
         P/2YPXAKUyXrXu5Xhy0K3HZn9+byAzWa2sx0CIRyeYS0Fvh3N7DVAG+oJulUV/dcLlwj
         cOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920332; x=1755525132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=C/JGyEGTZa8TumdXFHAuYIudwMaKo1SqtUrdBNJ7ca0HTzfBURZ179TO4cQafIr1dq
         1r0/GHcd2LWQ6izg8o8LXtcy35jLgOhoebnBvkEeQFpeaZISWCv/8dzgGoTlpPL2bfGU
         OtQuGHnO8xz7/FOJROWw1860IQkcVGNdslvj1uqac9OXQimgPsSFTSZnJ1JmhMkqtwrQ
         S5orThVj21uv1FHXWwYpKtLnB6ejKc6auE0WebpO7jmff12f9cjFsHR+IAhGngFjlw6l
         iLDTXbA4JAuiwY5kk/lJa7eHktzOYSJVPHWBBMRxSbR55lL3J9v6WXjfWCq1LaNdfWB1
         32XA==
X-Forwarded-Encrypted: i=1; AJvYcCXtkcwrHg5UnQOeobNiHnTF9Vcmpmc1g9G7SSta0KlRMoH4EO2wRF1hWAp1YyEWvv8Q2IFt6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyfsDaVAXOucxyWuL5tk6wdLPtM99c7lzxEs2xE4aj6OShHEw7
	qoLhp6eRLf6/2KIFOa2rMS8uqPB/f2MrsmXHGYHdbFBHLbWVnBVUSyZO
X-Gm-Gg: ASbGncsU0d+qyCDlkopxFDp+t9YrILjbztabt8TIG3/4xctCnWOWIJYy3J+fBquzAGq
	UgibaKFWvGv3lH0pehsJdvjkbwDn3TjQVN/rA7tydsPuiG9Kqvzl7lwDlGpLBGPLwfbBewpmjDz
	K5pgDgqJxlk2UHF32g2yXwHHvCfDextkhZhEmzINuMsbCG6e4OcRdDuc19Eftl8kwE16Wq/vqCV
	VbwbmNEJ4gWibLSzhzTrHBI1WaWmkoOMxnsC/c4qq6dZtPzxIqMEPrzJdDhppUivIGCKgjwxaPK
	9Q7Gdm93x1TSofRmbx4u8BV4N6H5SrR9Qt1UG8cooeIvRlxeEEK6a+A8JMubBfnN3K9aztJjYyM
	5t0HW1SNRI2keY39Zkkm2gEC62EuG6nMuHXe39PNw+6zJcwY=
X-Google-Smtp-Source: AGHT+IHsxIyDM9j4Z56s2PC1p2LLkjNdobtNOeiBJ+4IdAtlR71OsGV/hp5bGiCrntnf6+2PClAPZw==
X-Received: by 2002:a17:902:fc87:b0:23f:ade1:2227 with SMTP id d9443c01a7336-242c1fdb174mr191343675ad.12.1754920331944;
        Mon, 11 Aug 2025 06:52:11 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:52:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:51:01 +0800
Subject: [PATCH 9/9] arm64: dts: apple: t8015: Add NVMe nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-9-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVRGHgf36cod0yWTvzYD2KxQiswdaxCj9aUt
 tnU+n5OXvSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JMovEACF05H0isL+zJmzsPyQ+OL+CT/ADfwinwpz+nd6NB3OCFBCrxMDJrsuBwHrK+qRDxrFkJ1
 MgPJTnTKHdAwcncxg0XAvPwwjkOw1mGsAlhdkfH0DB0PR7RBHQOnwn30fn72ANfuvmv5mibqJGS
 Nn0swtMKc5++lCZGmJCvsEohtABmLqP6NBTDOlw3R9iqYFARLmIThIO+G891QQkvmKHU4aE6FvR
 2lcw7W0MEMVTDi9HPA0IVC8FWoYEsiMeGm3GtSW5ih+1K0EK9YzJQjecCS8xhxEzi2IEWmDaJpY
 jpcBaoqzgBKLXU7haCecTUccUhDZGnr36FwEUG6QRye6WUNi1WFmdHHZRlWb4mhG4wokiqD0vSh
 TuA5lKdme1ZatKrQO5t1+3CgbWQrq74KScqjwSBm/LxHRw7gv7JMo0Xbv+a73FZ825cTjkNBj0X
 4kf8iE2o6Py54WsrEW5MlcWm0fTEGiTjmbwtcx+9Z3/ESNqTJ9kX52B8hqbbcfryK4SnPGmpsDD
 W01JLE+28XAeqkgCAHACHicCRA817HiQxJxK311b67cN1H/ye1nrD6EyF7qunCM3N3PPE0d1C/o
 u7pD3rg+pwSBVuwnLaYv+d6Elz0RWwHCtox3IaIF8aI+kv6mKysVNpZqVdd+5lbXGtrNeyavCD8
 CPIZJYWQS4uWqtw==
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

