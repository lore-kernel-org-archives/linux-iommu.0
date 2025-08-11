Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373A1F37D3;
	Mon, 11 Aug 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920288; cv=none; b=h6cWfnmvMB8l052eMldo/NVDh3UyEhwQqyw/vbNyznN/S3tccqytkFc6kyyhaRt+rL+3dFshBkL4XmEBhqPFNRvAVacbMvEbk/aMNG11zx/tOkpa2hhnHnGk0mJPrNWF4A8L7rc6EPHlJqJ4RCY6z5yG86D87j7BWQQMiXw1zaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920288; c=relaxed/simple;
	bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4LcRUxlUYvZTh+xOXtB+qMxIpRt1xexEoj0vG5z5ScEOWP05Ffx9Sh/CziS9s2tRqqm3rgO5cP18QvToT/vTLmwGNvA2jlDFQE3x0jvuhZ2c7fi/YO+ZlIQ6C+94ULD1IfnQSQ2pbJaN0IecOOrUgLUa8yJEO/H+vKjgS7Kbyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqgFgp1W; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqgFgp1W"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3638845b3a.0;
        Mon, 11 Aug 2025 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920286; x=1755525086; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=GqgFgp1Wg6wnN8kPguWj6mtqFvTKNnHEFWQtWBrj3/OkhOUycT5untBvUhEZPIjoAW
         1WJ9mRfPx2xKLW4o17ReBEZ0TUFXuo5fZ7DYuWbpISONxnyED4rsQF2MpP/sTEL7eQrN
         YzYwUe4JxnCrnwIah4HGymrUjxZsArRI0HKFww+G83KR4whMvr3k3UXWMZPs6jqibEaS
         dWnBiZCWWQTKNoqepA3shYIursUn4OhfnIVYmD90MekOnAwLyoeHfu3zelcl7/quTxaU
         9x8wBZZcgzt0mJD/Jfzjyw4QZNBkl2cpOdRecAY3YpSGEblQ/ObH/HAK1nnK2A8XoKjB
         8sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920286; x=1755525086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=WM95NdZKL4rafYjjU8OT05xS8SNi35+3oL78c4szpnL8VUQr6p5QINtE6FYvTxhiuU
         vjF1TOvi1TUhsZE1jlXUcDpjmrhd4b4B4t0KiETR3fJuwbG5M4DUVkfGIy6wvkzHvZUt
         NYzz3qUgpMGv8EuH4BnJfm+DJcqLq1pmDOXkgtw98R75GOHz09kmiKu2sun0L5hVC0jU
         8MkjU89iDl6mPeFLtXArazzfdQVqbGrURoAElbkd20v86O9rjymgERxTK/Seb9iOJ5oN
         0jWW0pL+Uc4H++uSVdw23OQoGODyfGgl2Hzwxl3QpQr9PGnswABVBgvOC/xSsRX46f2/
         zocA==
X-Forwarded-Encrypted: i=1; AJvYcCXL4kQw80bJOFU8MBMrkHFQxwp54f7cA0d1Ris5yNAwmaAAxPWsDVBsbZT0iVwddEja4A2XIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEoOvQ6SJxLFytHAvzbCDykDXBQjcApKVvAFXtUxU1RCfXfTBs
	ksxRuKNyPiMolre3fDzLb0Zvx4d6Vc73yr7aWByBRRxZL0KayqwJNhZH
X-Gm-Gg: ASbGncuqAxC+mCR5dufbJQGNIS3JMER0gTN9BbRkTRsvOcx9y4yiqieTpaVVxCdQvbZ
	ts+W3Txy4+itNo4UGwf6uPRBz47IB8OAi3E5cUzkj0yRGgNMYdNZCWvIEH444VuA3nMfPDuqY98
	sObnGk6U9ZPeDu2WnKzGzRWxnFJI+Fp1RoSy0B+iIPUXX5NEHxBa+I8SWNMyj5SI6rR3CioycDM
	tnC16VF0/Hns6FRVo+voTtAfEwYKdKS8F61q44Y58ED9JMl5TASv9sSTLTjbhhAGbHgg6343YYa
	86NgnUtoBN55lvwnIl2vHLMPwrWXB/L0/AOqSTmMfJ53R1Nd3mJ2ONnrJQem+4/dAf3Zjf/7bE3
	sPPDGgY9ku6icFwEmFvdQwoH2O1l4wdPFNACgtGx2SvrBdew=
X-Google-Smtp-Source: AGHT+IFww40/ClkPYxA7P/SDXLTgj031HhNn9dtfaoB7f1h4Mue1IW6LCE6otocYEXgs/2Rx3IFTPA==
X-Received: by 2002:a05:6a20:939d:b0:240:2473:57c5 with SMTP id adf61e73a8af0-24055160423mr20825244637.26.1754920285410;
        Mon, 11 Aug 2025 06:51:25 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:24 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:53 +0800
Subject: [PATCH 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes
 on Apple A11 and T2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-1-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9VCg1SNuFuRtQYHU7Ko65u2SjlDXr67OxKAIlhnOA/x9P
 YkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVQAAoJEAHKCLemxQgkVBMP/3AD
 XG5579GsnDv3PE0P38gtqmvfnHLEICpLLgy06SxvD9gt89Wf72i8W6pLjr2QrSMjg1oHxD0i8UR
 jjfw2UXKN/IgSe4jLH3loLBm1aLil8sAF7P30v6N7OEuleofgtcDs4sH+Xb1vTuKOVUllFKYXcF
 l+zW7wJYGcXoLu78dlryBBAx53zZ1IDjFh6UoExBhCN8Meikn85tIlyDM1XKYU2fu/AeUhCGBjw
 +iNQC7imeTw9GsWyQ8E5sftOFV9XkcDJnOA14AS3in7IJD8DxXCWDtXwPDwUXBVBGytTaEGece0
 Ogzhyp+d7EE+GEPBNGbuhr35SAozALWljqHhmf61mILsdozH2ANgks5tVF2aD1qEjGFtQFkjWry
 ZDWoAHASPCJ5T+sAV+jp56pR/1tOU/xnQpJ4+ELmnn8MMAxS5bDd7eKUMXkQHLze8tvnwFiF3vn
 XqQ/B+RaqT7KM/Lf2mGO5JanAykB50OuQX6ccnpeAv7VU15GHKbbAXXcssCnV8HQp43WwjDvkKu
 etjdjXDbL38FRe8qM8xYloXU14WYw0svs1nYorwUEssHYemtpIJ7eC1JxyrlXOeRWP1a2CPZBYc
 7/RUGQYSK9M01WXO1lr1Fbl15K3rfRH8FvCPdvTwknAJ+9N2YauKyzdeW6ASol54Dnb7R1zDkG/
 /DWz0
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

