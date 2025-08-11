Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39C1F873B;
	Mon, 11 Aug 2025 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920316; cv=none; b=HAHL3PaBwXFZCE2+vjfiVdoSwgUmDM07NbjeOahZls4LHer4xirYX72tB75kRn2Qon80v06jWNMnqgQhUYb5ZpwCWmfS7uCAoCicLs2ZRluexM1cZfmAov1JgN3+NqbLsdNGtHjJq1oZn7kq4rEs4HAS/StRqms4cZ0mXO6JSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920316; c=relaxed/simple;
	bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ca4aW0Q8KNSyardU89YFWkf+h1OQB2yWqZhpwHzka0uGxwCb7WanUHiMv4ugeinIuKzZduFUPLO6jYnKHtikC4dw4u4ALrRParkLgj1I9ECXPNyRlXxDivdvQ0HZ4mm5HvHzSwf7KWy9gL8NZpBSpZ7mVTGdpr9dbW/+tQNrt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EStYC6Qv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EStYC6Qv"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7682560a2f2so4418353b3a.1;
        Mon, 11 Aug 2025 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920314; x=1755525114; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=EStYC6Qva0KCOczaAuvtJRMZZpVd5eWJzp8y1NTVYJmhN77p/lT+4YfsiAcIi0EquJ
         5IhH543YSNTiue30YCb83sbn2G7W9O8GHSfjttgb7YEwMDF8HPoDOwmASDV4sBvUcRgA
         R9aqkHYxStqnS9uuuerLOECb4ajBPECekDcaPJrtuothgZpdEz2g7kElD0QdvUjeJGku
         ArEAY250Db6TlkCxC0Y+QDlzPGByayDqpHIFaBdc2A5Y7GucqQVXSYy9Io5s8f4Cz5tS
         tl9g6SJR7H5j3PeN9EFD+rJE68nyHVlm1onTb+K4PqKjEVVrCILbezrfyNw3R03mEW21
         IU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920314; x=1755525114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=eGrXkfGmfxNWicSnVJh6ZQX3hIuDZuxGTinW2t44U7GfYkq8Kqg9tNl3VCRWVhoQqk
         +DQYd0/DuatBbPqWr1WGuPuJAJeP1o1553kS0rJAeYENWyYKMahmA+QUXWUZ5s1M5sh1
         zHDOUSEZBi4wL/enQhf43XKhHjkbswft36i2WrC/7Hz77vWJw8Ofl6YXL13qez5Luobm
         DvOlRQt3B9cY2vIyCNpD1wdxnXNp9AkH+4kCwxLHTchLadf50yjj7I5cpn2mmhuoWM1O
         2cjfgOIxEtQ9/uprpzw1kW3MAFiQcFh+GMWRcnOo/ZMaOg0vCD8IgmXxKC/o801+65qn
         5/0w==
X-Forwarded-Encrypted: i=1; AJvYcCX6+pdBwkFlQzl6cVeU1kM+TrC7FUD5SFITLN94pcZWdjlbohdqCbJvdzlj6dtb34ybTzJhDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXYM4bAy3KPFxouzxRFAwAEgrNc++iOw55CaRmebfH3kFE6wrv
	PSCwJKWvyKjXR0FF7COQ9az2xfqaxHXBT/XOBLB4pYnWDaNzeIWiq3cKiBCduQ==
X-Gm-Gg: ASbGncuGUG3AYERzR/a8mirIRN8B8wBHbb7YvAm1K2yTEJHEHAXlY1C/OMZSIrYvEVv
	ERIaSI5gq8Qsv1fBfhPHwGzbdLqcQkAIv91I+6GVu4CS0P+vDFDinHR6PEHGMdX8ar3zjXBMgE6
	gA840FPkJk5H87SOqouIEOA5pEEv6PNoXTqr7KrGgPjrU90/69vG/oHSEszKUP1wVXoalDevz5M
	PKlhicOZi2WBgwVAW/rHujByQ4FPRZvtxiY/6IuuLsglEeOTCNWAS3PTYd2vZWLQc410TmQW7PA
	Yy+lCU1c2LnFVMnEnseRKvqQh45IC72VBuYcGD4pWSGKEl7Lsgi8+iDE/Dudgcw53XXtBwsq1wI
	JbiiTbj2qwnld54Bmkbs9USIzLvKKXCZadfyKCk2zmGOj950=
X-Google-Smtp-Source: AGHT+IGhE+hSwc9ysPvVz7jbqtKJ2dKarkpmwubjOr30BSYSqZyhNCYRQjTx26kCmxQPcCpm1AuJ8A==
X-Received: by 2002:a05:6a20:12c9:b0:238:abe:6363 with SMTP id adf61e73a8af0-240412d3d1bmr30536141637.14.1754920314461;
        Mon, 11 Aug 2025 06:51:54 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:54 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:58 +0800
Subject: [PATCH 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-6-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVR4bxz+MuUXxpiFshyYD6ViYMujQXc2DuHt
 +wsEwye3/iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JKqTEAC33mI1jzeS8VVyGFEq/BiQe/bhvXliEN4SdCe2Tf6qLrBRqeMCfat6HbLoCja4CbUVsSe
 Wemni/JKDF4aHY6dMInba1FQ5MCA8wxD3RTKkJEhbX9XWcY2DGJPEW+lBuwfq5IdtpdbGPpDpwj
 zkAFEHlpl8MUaWTG7GSm1OY0HqYFLEEuAIbYr6uEeKrBhI96Iwb0sg0WXb783y9dQ3ry3uE2UT+
 OMuetIm7TibCt2bAlSkvgDYC72Rdt/curbxJ5Mdd9fRVB8aICuA0yKN0tan1nViX97O4TqKukNM
 oVh2gJgU1zt4axuYbPHfR+d1Mj5l+C2FYEP+rm1sP+0yG2HgGerJek2XpOjzLKissSw852P4/Vf
 imtGgV1Mud0iXKrxkEGPdyFX9+xWpSuN46Cld2ktxXGZuXmWOf56m00c3X++7B2KXGpITfnMwlH
 OmMc7flr9uQ7l/f17nBHDf8n5nEee9ymqZVYaHPqLPv0B1jRy1D/ZM8rCursoteS3Ll0lE5U0nl
 cJP6/uXAnYMBiRnM31x7J8vJErU1S39eSCcNR6Oitlpa35p+W6q6VQjcqTXtKks/fWGUrQk1u6H
 COIuCWyD+4hp5tNOO9FRIZRJTLU9mDzqtvNvjp8QZt6nU8K+yYRcd5SI3f/opD8MH7GOhyJoNjU
 cXMFsGdgsiST1Qw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ANS2 NVMe bindings for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-nvme-ans2
-          - apple,t8112-nvme-ans2
-          - apple,t6000-nvme-ans2
-      - const: apple,nvme-ans2
+    oneOf:
+      - const: apple,t8015-nvme-ans2
+      - items:
+          - enum:
+              - apple,t8103-nvme-ans2
+              - apple,t8112-nvme-ans2
+              - apple,t6000-nvme-ans2
+          - const: apple,nvme-ans2
 
   reg:
     items:
@@ -67,6 +69,7 @@ if:
     compatible:
       contains:
         enum:
+          - apple,t8015-nvme-ans2
           - apple,t8103-nvme-ans2
           - apple,t8112-nvme-ans2
 then:

-- 
2.50.1

