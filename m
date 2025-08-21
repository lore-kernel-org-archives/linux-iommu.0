Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD614283FD3;
	Thu, 21 Aug 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791895; cv=none; b=ggvHTrX0v5n5/kKAurcFpfOI8zm3zwoE854kdnYbUL9+mnA9jIwdCQeuVOK8GnYRR/f3z4+unLDObXYDBZMeu2VpH6sh/VrNB1Q1Q641ywRZiswIv23T+nom8TJtK00PONqeO0BVECvwY1VfyuLk9fjKEhMCtsB6c8liiCz5Mhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791895; c=relaxed/simple;
	bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qvb4uxqrDwLcpsbWoPg6q24+PTzPPV9KDTw8s2laXALL7tglKbf26xoMqJ9KjWEYfl/Q6i/zuzYWX5Z2Tq890JSAU6PEikj0npHyVhVwHP/51Dp5cutSR5yxzFQCZ4LMDC0Ac0A803QyeqHO4JriiJKPk1FirC1uJ+gMqGsKznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwBJa4/J; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwBJa4/J"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so1153350b3a.2;
        Thu, 21 Aug 2025 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791893; x=1756396693; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=gwBJa4/JtS7Zb/sFWlwlGAFjfMx5Rek1t/LpbF2NJ83nPTCsA5Clu/bB/ogAKo05SU
         RYrB3BZIl6OzCDd1JXWM01fvp28lj/moOyChM7PrBq+9oKwg4LNqwvm88Y+QgaLkeOBw
         f7yNOwABq1XhJB1ZNd3GwGHQPJmuY9wsrshBnIogd1r/HSH7vps1MdI5BoI/FzETdLLG
         HCBrUez3G+65UKV73mq/b1s/imBzvVFBtw+2rGjiGlP7KF/EQYzsc6WU7YKXVS4veINU
         pdqqBX4mpauNyuzKDb3hrgPu24iEtxkFb4NGWu5bLOIA6DelrdO2YGNy9mDqBXwwlDbZ
         3Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791893; x=1756396693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=BzeOyOwOwFcSCRmlKJxWTIYhMMeLC20ZSgj2nCHGVgdMhOEg3h+LF+XAMD4UolXie4
         cwKcJbY/KHzAjyzD6MRmtNIbK4vAu+RVth6fLlNJhTXE9v60IVAoiHLdtnsEYDnwdMaj
         NMwnui3EueTuyHnb7vYSswT6dGG8xrWOZMkmN69ybG8cFLgT1ztUR/hxy9VyI16YvBAv
         QrZTPt55/DVgM1+MXww8yJUFg1OH1IKTypp5bmsI/5vfNLFT7mzcTc4owBDLU8YcpVZM
         6PNKqE2AqS+nSnb/7FFd7cB+YUpXPCdGoKNjcqTnpSDWDd3mmZxquvJUl/Folb9EeggI
         UCOg==
X-Forwarded-Encrypted: i=1; AJvYcCVlCdvLqxQ25sFA7ZPo+4ToH3nvnmUBHGoIs08inRC/jzaHYBaStkhUy5RD19BcG5+QaBS14A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj8L1j/mcsAAiTiJYAp4kxJzOTyRSAXWE38z4GpxgpLit+KNFw
	jAY2p/p4MnilyAoWKDousWJN8fQodenUSZywTZrdXaQic2RbeB57p5SK+aB08p3O
X-Gm-Gg: ASbGncvAP4BKY16TtzhtwjOE41W92Qoqc7qNXsmB8aThefujFLq5WS7EV5Hm3wi9WMJ
	t2lx31w57vLmEAfuY24nFV96LhPc07EXq1kX/1sSa3gIh3XhqtNtKkXURia0s/V9Fs+Ix/DsNvL
	8C/GVRx+yGzpM5dR1K0fLpaEqJNHH8+mPeExuUu4Sy1tX6YlM0MZpKqMqCRj5OGYtUzN2RAaagN
	9DIcE7NZHyc2xBUu6jO1yqZoRBwSDj6cHGZ0gbdoen/YAkwZv42KoSMfjweNzdtykdXiLJawcdG
	EppDKuDJvVlmzT9kqTheRgKp9Si0vEsrHn80E0nNNpitrMhUcUp/4uSy/sepa93s1ckoNXIvyjw
	jwqLu8FtYUVxsfIItNlBgV6WfhzKVqPaFjNsWNqTNvQs9EmM=
X-Google-Smtp-Source: AGHT+IE1q9OtVvcB7jD7CQCK6LT73Fkhhe6O1oTYoqIaF9COWn7bTSzZtptOlx0VklEzRU+W2Yg10g==
X-Received: by 2002:a05:6a20:7d8b:b0:240:387:cee with SMTP id adf61e73a8af0-243304a2ddfmr4276481637.0.1755791892695;
        Thu, 21 Aug 2025 08:58:12 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:58:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:46 +0800
Subject: [PATCH v3 9/9] arm64: dts: apple: t8015: Add NVMe nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-9-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVNEQSbAL3+tZjzyN2WWJPuPis7prsUJE4e
 r+/j8uvOM2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JHtuEACKC0KzhrgUSgUD0OWXRKnND+KJS6S49TEY4jfE8wS0+7bDXXPBH2LHqwFwyEyUHh/y45R
 QBMjGqJsVuFtjLjuAqJea9McDOJOf4anhYQck9UPhKFl5+COnr9pw9/Hw9HrvMN+hjML603tkJW
 MW3sW4RscbE5AOdDH1+W3o7Ib11FaiVAnEbu+XX0IsRfOgEVCg4QdPWM/UCcaBk3FZGMS3abXGn
 r6lqK/zwO72cRcZg27mdKqnitSyjbmqBF8ojB9aGNnET/9OeyaH3tn7JSIASY1wlarATt+z3GyB
 zkuVbwthmU8wJHm3xeq2bzEdpAdRxY4qn/OY08yzrXaJKnJi+Ex0yiqW5eHXXyxWQylH62oUP//
 3YBFV4eFtDyGy7ApLSESHfrQ5ch3m/1J21oOOR5+LB2yzcOUajZkbCK1AzgzPHb7cz6cZI8LQeJ
 5QKjLbi7r2JRXTjlszmvxMpi/0Eq3ap3uCeV+rs3FQn/N0N4Bau3X+joy+3xKmTHGCR3GEhqGgx
 8rRN5rSrgf/UTKqsiUq0C4XPwE5nCOvg6WczE8UW5ORdm7z3B3ls0HvvzZRJsnDL2mhYYlRQJ7z
 l+TYMXGGRm7oI5MJfKau2yTunT+RcXdSK6+6kA2NjHOcNyRxOs5UeT9TLiXcEDyZYFFJQ8fPDDG
 iFMSRxoy6aoLIKw==
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

