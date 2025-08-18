Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA354304BC2;
	Mon, 18 Aug 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506642; cv=none; b=Dy1ob3xvJLokeZIvHWdSCNGK4p6yMo7c0Z/1f3a2zGKw99ZMTP4kphFtRXyXTUbTTxS2WBjgtQ7wwE4iouDUXX7BamrbV7RvKhBu6K13HaiWMDmUjP8KuDAA8FAqdtiDPY4JGntCcHjL+F/xLF7vSm3Y3OZPUY17v1k42NneDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506642; c=relaxed/simple;
	bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bV/kNr9zg3OzGFGC88/nEeghaSVZ9CLfpA58GpvIpElVD1iqnbliuHQSl0h+k5YtSGNwlsnUpdhSXfzWMubDd11Uwad2HQH1W55WM1tGYGztmsbVcGx6jZGBCS7zpYYpQMoX4pd0nB5bivGZnN3P3iAqMwirWXUUsAVWs5PK4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjies7GY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjies7GY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24457fe9704so28255285ad.0;
        Mon, 18 Aug 2025 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506640; x=1756111440; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=Mjies7GYIfccIzf3ggOYyPxC0NpPj4tKgKMWy2YkKZYzpfR0m6SaK6yfIfuXXkteaO
         CJEkYtAX89/l80ZxaSDt4v2QIP3pKmo+ShajLDEXu8LoYXed8+9Ws6DU6RlszbhEcLB1
         1UzypVui1GAfhiCNwuwc2Z5ivK5okhcBfrubisIoALxSNi+fHtOo41aduUq4apRGaCaZ
         uGS0iwxA/LllBl8LF0tXpYCvyoesATYvqr8MIK5C8Qv2ZQ6b1bMhYa/vvLtmTgHMynbh
         RXKmbl4QIzipcdjXV+C+IoXGqddIPUZ/wUXnDX8szoSMjL/ATtNwaYMNXS3m2xgtfNHC
         Em9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506640; x=1756111440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=ZVXa9kZVfGkdKeyjRDj5HfglQJ0zwgtathWgqgdVSEFH6zmCoWOJk+WMFTYAhd+vdf
         Ok55Fmo7Y+Pez9yjuJpUg3+y5vcEsBuY2Yy96/7VVWue5qgJQnSiX2lyqBUyJre0v8x8
         yzuZVRvaVlo5OTmZUe+2mRaURfcKkrAFmFmNK36fk4cKsssw93/SAmzGSez0uo1Q92re
         z2f4F45S2qE+eDCUgXst4TdTOAHotQ/DeWlNK7WDAXV6lizg6/rXHRZKYRe1JcJmZxy0
         4dUgVjD2tkuxnbb+3wGCn+J17INCqDXNe6+F/OIfu5mAXFyXGA6jRq10bC6l5+3CuPKc
         H6hw==
X-Forwarded-Encrypted: i=1; AJvYcCXg9UEWP0RWIMnYL4I1jeyJ+8dhdWqrOHVp1uZ1k08OdFrc+21jVxvGgp0S/13ODLzSZqoicg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLnYzG8wVIL1B8X/wsdpZBGx+eJTrOf9YuIlhAmqc6oUWb8RJK
	q7bwbmLEcgw2F8mTyeDHWRSg5OXvXzWNjC1jPVMZhmck41QIX5iUZaBd
X-Gm-Gg: ASbGncssLiNeZF1eh6BcFdxMiTOkm0PqGC5XOmHehgLf1m7ogoDZuBGdGmX14JnWQVF
	/4xp+Gb2QP5FtQmglSsnpiqKdClm2nxwGfDtN2H4jxUYsX2oJt0eGntBD2hj1ka2OfsH3EvR936
	IXHNxeVh5qunE509Vr15dl+uqWhL72MdHPz/Xtkw+faEkXvbuXm5yQGCG9MZrm3cVR7kvmcFg66
	fDhJHfUDDfGNUQpILzqCMQIIXhNLcDCUxMx201fv6QCwZWQ3oliA4KjOe2UW7nifC/Z07AF/0Be
	HfvItC9fuGEYBchNHf0Msrzx6rj6TxlFRSgOILt+xgUba36Iz17un5Hr0oge6pmtlxLFVRi+zEN
	GggrxoKRHsUTEMi7q3nKADk4yMTDhVhLyh6QXL0Y4diMJCFU=
X-Google-Smtp-Source: AGHT+IE41TgaDK6U7fh0y68RK4M9hHY2iTY9/syz4IuIq1e5ai42XH7ZdeIfRSVEhQVGfnthb5LW2w==
X-Received: by 2002:a17:903:2304:b0:242:b14b:15ab with SMTP id d9443c01a7336-2446d8db8fbmr133100255ad.42.1755506639947;
        Mon, 18 Aug 2025 01:43:59 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:59 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:59 +0800
Subject: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouel76WKJHT6a2iEtG2nIQSl6p8GRmIT4TNIr
 Xm/tahu1kuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JH+QD/4iOQllLnnWwQJNPY5oL2ee4utIpCyxF094977VkZE8cu11GVaSzIu+vwks3UlOctE1/vh
 3M5vIVvKzCAQdKgP/hteJAXI4ORPUYXNdTy0OGn0Fj0uB/xNFWrkC9sMhtE9lnNb0GBc+lL5PzX
 RGnyCP5QXVmM23oBXVe1OaGgjfnOtpIbNAv06wWJv/Bl4qucj7bb2LyFmK8cXM1IEcT6agBzpv7
 b3foA51U1DraEa+d9Jq5zfc7R8mc12vXcAhEpS5o2iTxChjW7Tb7L+sKi27pyQaOzUJE6UjNRqR
 9gzojiBQzVjS+o2+JfTYJc51+fpoY1nNpg+nzXM8Vm5Ab21EQQqPAPdfEPWFcyGN+suIvZzPjVq
 0yN1QONYRLODY4YCVDVoM3inRzp6FzDavxwbyWiAhvX7vjEK9iIRXsLK5rDDAJC3HshOp9sKivR
 RLSUkoEnaJXWpCp5ImXwpGlIH+10suCQBDMDaumHOdCRrVXFOeKa8dl+cIYlw0zCoYk7aocXFtM
 grLxE9ZmZj0ZN3tyetAIMhWlwioazCLlA1Qnf9BSbpYmaZWjWfK6hrPH9WQ5SZ0zlL6cIlOdf8Y
 NVJIkscN9u+moAMEN118ut8e2Id1o37RLIs4oxboX6NH+MJLeeNQkCp3eHUzWET5DP8N28r+TIY
 vfsSluB8+N4II0Q==
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

