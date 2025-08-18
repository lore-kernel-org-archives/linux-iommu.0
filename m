Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE97260590;
	Mon, 18 Aug 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506612; cv=none; b=qfdZXIT6lBzFxXHbRRas/l9Zyy/Tq9rcIgtvvO9cgwrni9P7N82m8Nop10S7l4K2QVIhpB/eCzckCvVP01Og6X4hWwJBmGWY/D+CQ5ATqN+ay5+3qX8rQ7JbV1IDjhyzqDjPoglNfUn74m3v+31XMRoyVTg4sRC7X7TQJTMKB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506612; c=relaxed/simple;
	bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqfwJwWDnGP2DdYwiaY7NNeYdB9U14xGDE0YqKh06SUCguQWRD23uS1J1EBVMbs9ZWlBJE5565YXYBKIEh1+i2tU7EbI0AdLZxKHAeg/ob6Av/fHen2Ce0iTpaJNvr7a4F55M13AI2wopNTnMgXIyESDoLNhPO08EoyxEeC6tEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnbBzWWu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnbBzWWu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24458194d83so26495145ad.2;
        Mon, 18 Aug 2025 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506610; x=1756111410; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=lnbBzWWuhA6pUJR5ZPY0rE6MALRPlsn5CuoAlDcElrLyZHnHLYQsA1W3f2doVZnCkV
         QLmWU8MdGJR4ntjRYWHR3zOpZVT+U4bI7jGE6ufRriTxsAzXGpVf0hsrinNJlVH5UlaZ
         ddN/6mFZ97HkMpUdTin1LAiWs1IZWZ2qQM9rUTBt7kU7Jh2jNUm6H6IzA+BBDpqIQF+E
         XLGy5TgpruuljqbwaVvQqYEHc9t/+Ss9c1wSj8F2H7uSE/5kCyylVxge+5Ho6j5ZKxVt
         JGtg/ujeEB0ydYXxCkve9zFA9YMeqvZxjCgLhkumibHHgAydYIJNiBfCoKfbvgXU4oRL
         Jtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506610; x=1756111410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=XSV85Ni8XiLLvmUAqEACCGu/2148QJA5W7egGlaALY4I1ghTLSifTPnNnziSp3PogU
         uWWFzImNIOM2rUfCki7hm5zg4kKhUpe5rYvfxXEo7QLMtXEj6MLnSwSSINnfk+8+S/GS
         nMo4+8KDYh6FzaP18QcrLCiskX7lPfpjpjTPxB7b05iL9RAgp7iVH1VaFcXqRTPSvgoc
         4lHUL9gMxdPejtvkmxpssqrtgX6iFr8WEfWIieACjf/K3yxXn6CdDhfCw9b0iszHzONl
         o1X1E5TLYsjTyUMyvB/VSsEN3wQG6wCIkKZ1hjTXyfpnpFZq/ASZw7mj9v+LclzN0zVn
         ZzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyAHbmAjJSgKk/ojdUgpL+pYIvc9LgLWpvFeofv8xPDx5jkvCjK4lzae5XH5foh80dvmeR8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAb5k2RcbmmmykxG8UymQihdNaD/Kus1SM4IOoKwPMR7N5iM+I
	XgM3MyPBk2Ij32qzcTkTBgD0r2q+08hh58DkBYMzSIo8sweS7ti7NZU8
X-Gm-Gg: ASbGncsD4XTAKTvHnPTOsW1AtCaKktcTYzdp/8GOdDZUSrViIeEt3DISr9JFBbEbYnS
	D26N/gFqTL9AcdDIPkBk3wKmo7JZWe/Kpgjb5ZExllellQlV1e5+TYatmq4XWsQY5G3acfgtJ5+
	QUh6xnxf3AKlDH24QFPkDrSm4BaFAynlTt12tJMSB5j2A/IC3naH44qCEQSPj9JzzHUX8NQwoIz
	W1X7p90n4w4G/iY7UbMh3PkpKu8m6zOOYdsM0fwqRUKtd14CiAfwxCyimX9yUcyhaO9/lqYs3BK
	yD+fm8xU9Zdw/WcqRXDOfiF9ElaoH0Vspv+xDtguILndrenkiCtvEyZ8hTRZ0VJGcHa/KYV7Q8i
	v+9XXWiY11BWaamJ+0WUj6EWZEIKlP5LnueyH2/IgzwbPyZU=
X-Google-Smtp-Source: AGHT+IH3faNDzylzD0VDv8Y+qqSpzsBrx/M1k4bGkBOGU1VP2ePH7Sqk6RK7FHzo52EeYG4HYqUC7g==
X-Received: by 2002:a17:902:ec8d:b0:242:1ce4:e4f9 with SMTP id d9443c01a7336-2446d9c64admr141732475ad.53.1755506610186;
        Mon, 18 Aug 2025 01:43:30 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:29 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:54 +0800
Subject: [PATCH v2 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC
 mailboxes on Apple A11 and T2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-1-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouekHBA3JNgEkbcxb1qrPDbRHzmVLLnTVmcky
 5RaLd4oGx+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpAAKCRABygi3psUI
 JGAUEACHsbI+FHcbJBapYoOszX5QQh6fS6dV6ukZSZpH5IJsuhx+4NIp7tg2wqpS7YRCuEjRQOX
 YJJx16lKWjQwFpzsR2omcDJfxqXcUA+Tm809iYgdkDNPSeScAGBi35AtLvk8KNbiFfzSiJqsHaR
 PJDnR7MVMOb5BK5nZdhPLXySqzEiZkvUxb0WPJDXZOJ9ErQygRKAkUPLqvBMb1MrGT78MhbwBi8
 Giwd6FiFoUWf/FrtIzXWZcEvuwIX29x3z6yqZAbG3eiPV3waEr/Y51xMPzw1zGVJQruMb6WYBq2
 tlZwPAv1Moo8n/KqnzswCvikGRj8mc8oGLkRjPUz9QW4pu0l9qbJ5yc/DsR4YRNeTUpPqCmNE9d
 P/YmSyW1dIjehZHUL/XjGW3LCG3zekN15tXLXATKCG5m0E01P7t32G4v0S3ngjLsLRM5jXUATSn
 jT1oKiGokPTrlyOCZummYN8+6YdVnJJnZezLFkRmKD0GICTrZCWyBF/fqxMHTKOXY8nEZUEy+3m
 j7Sl6vgoelGCbSa2ENOE6qoIDvMZAgWMsH6fafFmgmJNaytYz5WpwQzRMjrPqpfIJ/fXnQQ7laR
 l2K+A63zdf0GLp67J5koiVNxxGmAoaCwdtMQyyA+dGfWKAN40Je5L+N+PP0t9HyMSKaNPa33Lly
 XO53R8O4FyKKNUw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for ASC mailboxes as found on Apple A11 and T2 SoCs. These
mailboxes are used for coprocessors including Secure Enclave Processor
(SEP), the NVMe coprocessor and the system management controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 474c1a0f99f34777e1bed7fc0a34f89320a93b7c..bdf58f03b84833ecd93a34b91f6262d1706a002d 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -33,6 +33,13 @@ properties:
               - apple,t6000-asc-mailbox
           - const: apple,asc-mailbox-v4
 
+      - description:
+          An older ASC mailbox interface found on T2 and A11 that is also
+          used for the NVMe coprocessor and the system management
+          controller.
+        items:
+          - const: apple,t8015-asc-mailbox
+
       - description:
           M3 mailboxes are an older variant with a slightly different MMIO
           interface still found on the M1. It is used for the Thunderbolt

-- 
2.50.1

