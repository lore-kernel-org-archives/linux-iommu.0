Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366F1E3DF8;
	Mon, 11 Aug 2025 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920299; cv=none; b=tB8jHC4fu9JK2fgWXrBG3hLZLGp9rRiFhbOJKTY5EpT/C51ciiuBNPcr/tZ3KbrCD8f4fe8LAg2Q2Akoft4NFMoLqIhNGvc8Rs2qeWdMArB8RnPRhJP9Y7w3DH3gTYJj8gDET0f8fL9j9v9AoWSwQh7ONbQdOHh/sVPhHTsCmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920299; c=relaxed/simple;
	bh=WsW9yxxkWE67nB6JIFQv5v8viYACQD+qfWrPx8gpdkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkJkpfUI8pnkbJzh6lBnMiXR7blML2t7ZOx3r4Y3xphXlzDyqoqGlEmcoVaLSOCtOJuwL82sRoUdzh6y2oYaPSuEGbhfFOQ3qSGAUQtq1en8mXnU2c/sxh1DmNfzKMVkHSzu7dxM4oQQt29isnBd8Jww99mQxvKQn/8mIO1b3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc8Yp8Wn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc8Yp8Wn"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-321265ae417so4879952a91.2;
        Mon, 11 Aug 2025 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920297; x=1755525097; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD/WrxSX1/EFla87ahcJA+QqQVIM1RkgY0PCe9xlzK0=;
        b=dc8Yp8WnNQQJ5hYEbwH+w2GFAGD40mIBefvdX8obHQonQn66uXzE42H9+VtcngLJp3
         wlVfpGG7XrVGitM9ePUozBXnzL9MdDXBEn7M76HGXUVWlYHHiO/s2t1VZFOzE9sPCWNf
         FlVpDqmmUuHv0ce/0SNOZGh+00tsV5rxNKroD2hwqTq1lJnS5btzXulgX8/VxPzeNeM2
         bGxiQ1/KDACttng6PEBAQ+5ba/OfKNBneZkLWX8mOtJ9AvKk4g7ed9W+mMqTZn0iYdtn
         gN1c03JrOBayCuhUb21aaTwqeNenqdtEZCPbpRXTCZhfg9o1gupkDF1qFDsVjG0USTW6
         t8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920297; x=1755525097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD/WrxSX1/EFla87ahcJA+QqQVIM1RkgY0PCe9xlzK0=;
        b=SUbVqYSoGi4/1dHCM8Iyv5sk9XQqJfdiklfJag/iwaYGX5DhyItY85WYrNpB6tgqMZ
         ULFieAENrsNCDPPVi8fdgE8nc6XMqjCAuLbPkgdiQXjiuZyANlXYOY6tihJNhCqMEKe0
         rOSRasQwD+ZkTSJKitRObKYGwc4putUl3GnU0Ac/djhJdEOI1QYF2v+36+yX4qR3YLCz
         5nsovfDJdeOYFN8bNC1ZfpQPhDCa05YQYHDK+An+ttDFeIwE7PKm+SyVYrFJOGMvlYUy
         Bt6w+GtUBRpzl9/d/2wF4fv8q1BwrpUVrtdFPF7mcpeRw0vT5WbNvLR423m4nSRyO1Gu
         +/DA==
X-Forwarded-Encrypted: i=1; AJvYcCWKyigwcS0Ftm0TMZz3yDhMz2Lv3ZUyJRqw9T148QALH12N6s5JXDC756Np2HiWDZlOX1YyhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuqDK7IP3ITzr73fAe+3jesNtYdB2zMy1otI47laX7A5KAOKIK
	DOJD9ZN/IJHlu5TGAmmexbB/slifSu0X//uyql+BPjATBhNn9h5ty8Dy
X-Gm-Gg: ASbGncuHGdWMrc1o7FUq4CGEBl/c4B+wEAKQsIRtiD5DVjNdSQ06g9lVdWDp5yHjKUP
	6klPZ/n95Vyqbsb9Z1VqVAJYqVgHDKCO7HW6Yw64lGbAVYdnpgfsaHdnwbLH+ukXD2hcipv4RPa
	SX7a3yKZ/7OK+uFZgfmY3seZ3fAU4rZiYLu//5dYCWXIvzqteorl7+Egie/bNS6BlqY5v7o1W0k
	RsRoJIdYF2KemN1opGEr42z/iX1nUWXeWzo6qrtLWooEvi5cIQzN54PmAAn3fQBAA+Yev3qEao9
	CMHVUmUwpWPe/reLHeuORVq571S+2YN6svF56lmtPcBs+fcJ+y5/owBFXv4X2Y7tMPxusyoliTS
	KW5skfcN/dZEt7A1FhjWkpQNwulHGTYZTTQq175CPuoblEg8=
X-Google-Smtp-Source: AGHT+IH9KDpx03ywNJvdLzBAfBlJLI4oeKmVAO5UR+drZaqVUoplxQq1MfoVtn8zvLDNwTwHUy4OvQ==
X-Received: by 2002:a17:90b:3c49:b0:321:75c1:65b2 with SMTP id 98e67ed59e1d1-32183b45760mr23917637a91.18.1754920297041;
        Mon, 11 Aug 2025 06:51:37 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:36 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:55 +0800
Subject: [PATCH 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-3-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=WsW9yxxkWE67nB6JIFQv5v8viYACQD+qfWrPx8gpdkA=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9VCgpq+sLCPb6h7skrPDQfu6PKhvLP5vmejwncunolc9M
 IkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVQAAoJEAHKCLemxQgkx/AQAJyL
 UoiKJly1Puh26oQIp/eE1rItZVtYiLLcwoNLwy26TFIVgQpbz6CwutVT7YMNMFjKRGST/KXTVUG
 nNOAq9f+JPjb0vKn35FO3X2RTUudGt5tBsN7gP1WAuHwL50pVLUpwlr5mOmUEnPoxECo3su4Gpl
 u6D2Q+RHjZKv4m8wH223Xlww9RFi7gOYF1LDYJg0Ijn2n6NsoFB8NnSGyN4R3exhrXw3s5ByJBt
 MPiEHWglVMs29eju0clMKjW9fk8/3C/7UP+rJ00B0z7tbymKxWlf7joJREw8NY9k8DMow8DkL6e
 VXRkVr7XloyJiCxp7K3knbiafjV305yNWNHCFKyBPdySFHfSdGdac2y30TXDK2t02z0vQyE3ily
 7jGglW73k7b+fiU7tn89oiTUbdh9u4JbjrXLYuLejcmBZRpUyY4D4K+HX0mDeGy1NxIMG19xZRn
 7g8sNiuG4nsROjMUz4hvB6p8FxHhHtT9AFVtEwYn1sbtvrZSiLTKKt4PrVyP4C3OWUlkOFwFAoR
 RhLj/kT8mq0Knaubp168KQbr7/vRLh2CvOu5/HVVjNsR9hRT4u3udves1TxU/nW8kKzsc/YFt0p
 TTYNHDSVKn/R+NaPaAVYFQqZOwMjKMB9LHIgLvQsqLD9rgK8AaxdU7MR0iKg7wjOvLYTGfAXd3H
 cYc+Y
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for SARTv0 as found on Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index e87c1520fea60a2de549aa8a469fcded52e3b6e3..95d55ec688779bd52b8aef316a4c1ba7b7449574 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -29,6 +29,7 @@ description:
 properties:
   compatible:
     oneOf:
+      - const: apple,t8015-sart
       - items:
           - const: apple,t8112-sart
           - const: apple,t6000-sart

-- 
2.50.1

