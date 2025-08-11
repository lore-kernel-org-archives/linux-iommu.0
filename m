Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F222A4EF;
	Mon, 11 Aug 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920328; cv=none; b=gZLceIxEN3pI/b2NJYyg1Yfrhy+l8HNDNlSwlvl5DIkt0Jq4MFjJtBdc+d5RcRpfG+EeG3HPU+qNH+FvuPYmKU559B6Lqvo08hFNRygdbV4D9yGFglr1p1f8fcIA7OTbeKdFCO7LjnhYXThJ7FRXxKlVGsPKkIlaKvURFauidUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920328; c=relaxed/simple;
	bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmNpqL8hHDC+MzmVtdMG14HPNCTWD7Fk1YcuwYxtbJNHDXgr6ixzVR6yYq0h03hHk4/j1OaTLJ22csA/MOpPy+vD6do/bvcmGYdcNOgHf8sTndNGcY9blKOPkIl5ji5s+QIpYNIyIjRHXyi/c/xvxNd0AtlWW2pQT0XPNqmdE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD/oh7zu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD/oh7zu"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24063eac495so33040325ad.0;
        Mon, 11 Aug 2025 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920326; x=1755525126; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=SD/oh7zuIAJGko/+bGC1FgHurWkTI8r5IGXoyo4cSaE3Yccwung2cKl9T7xlCC4wLc
         79I5mNG5uGmhDmN54H3+VwKkdrw5I15jKxZcRQFq/CuM6YQf+161kuZ/pAb1F5egr36G
         HEvJwyrgDl6A+deOK+QW59VlxlEaSoBI293GxtIHjynr1CuoQIE81xZ1TvjQbRbRBlg4
         DaiEJM0IKvoInRCmZUcav0v3R0ibIzFHrzWNIxwVNnX3W/UEdxpW9lXZhNqjVZ4yIoQ1
         BX4PSjzuWL/eBxIO3/5heMplTyaVHSYl6OsS+WfNeuFXZ6Vll+2pQMRD5XI0ebniqIBZ
         khsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920326; x=1755525126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=w4h/Vdsmnf2y3PjvMo8UMe5e8jNXVPENle1UIUpMpKKvyxI4awxlFuuVzY9RGSEiyp
         gYI9o+wAMjDRb4nyybE4E20bvstjXvmUmazUQPiQuwg3bzhbru3ODjwDCv6S3zSVIgfX
         oEwccoUpMc3RsJqhk8YS7gcJtB5GpM5gTkFxFU2M4Tfnj1V07Ighv/fUYX0+4R0ISHTO
         1SY/uWh9p6FcHWYxQosVM6u/Fq9xejHRtxzx8rksAL37bWDf8FKkiYicS/cXgVxujrgH
         f80WA+6Coboahj4sX+AkPN79PW+3raDZNuYyuH3OUzZ+S3mHPMONija96ksmOIrctW1v
         xRuA==
X-Forwarded-Encrypted: i=1; AJvYcCU73Fcx6ljGiHRCvkPgoqYvwquLBLabvNVDf0ExNmp1joGvyFZAe8tPJ9Dt1XOhaeHJyKw1SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDxkc1lWVwdakTvzz8IXMTIzL65ZnDWUHwFXMxTWen7tRjP+mz
	JAwvX+O/A94x0Qg/tpt/9RpT9SNi/pSiHELTd1aZDgKArukN3eEpRA5Y
X-Gm-Gg: ASbGncu7jKS6uQVP9nrYfVZT/B6UprFEiuz70kma6v/xGVRNu0F4BjicKwxC3NOZVFK
	howOPZ10nqqiyxqmtegFcz8hrbwQr6SMY7I+l2IC3vayNGCTSKoaSLCwzpfCZnah2o0GpS+bVlK
	tX0tcDftWn4K+U5aMD6cs8MMnE6Vvg9Q+/E+1k1PLZpL9rk2/Ni+6dHweb9M/huF0SwWFwDgP1E
	NXoVpRWwu9rUIenQ19KWVw9f9d+SLQ1b2ioF2N/mIVSOtY5rZpUzqDUtipDI2H1D3WS1WEeeWrf
	oUyCFndcafEhjpX5t09KvBj2br/wo9nNdJ6QbQgmOXkyXSSv0+sGt7PZZtP7WF0b+GPb0fvJ3M8
	/d4TlFMRZAfFxst/V+tsJ63KnfIzC8UGhn3CMsXl4jiBgjZE=
X-Google-Smtp-Source: AGHT+IFgm4RzzzE6J5r3iBNe2NZOigsbOyh949b8qoEAVuFdNMyuLJZ2th5tpGzARJNLzEYMcYkYag==
X-Received: by 2002:a17:903:4407:b0:240:1f19:d35c with SMTP id d9443c01a7336-242c2209b65mr207786575ad.39.1754920326147;
        Mon, 11 Aug 2025 06:52:06 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:52:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:51:00 +0800
Subject: [PATCH 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-8-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVRpulWh4MRp5/M2zxFrKVaLRt4h6MaA0rMR
 +QTSNA7W/uJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JIJaD/4ole1VdYaF3B3syLR82Nf1oZ+zvyPX4nskCUA+dlYnOPXR/DgGgwNxxRkSfTJkWvTjxEf
 b/sUDSZQzdnbdO60VfzpXw4yaBcWWMvjnMcisU/kBxYW90no9davink9VsL/5jjY+X9DegWBdsx
 I3DTjjBi7hIUc90SZF/sd6SULA87lmyM0rrfNORPgcTKNBalPldknE+rIs0Iv5fBdNId9vdsmAX
 4UDOjEE/PMVO4cOYCth+kP1Iz0I50BftFGakkSEObwVzMkbXnt9NcaQYmnLmmqwhXtTHuJ7NY3n
 Fwlu9wDTRKWV8rsMB6gwlDC9ZnuMi0Ndlnc/1zHfkDi1YqAUa3vK3qZd8qsvPAHe+iUzjpq0gGD
 5jVIga74uOTkS2de52aBK1M8Cpn3Ln3xyWrRhyPEdtUzjx0DlmRnXcGjUt0V+ObyGINdSbs6BEc
 Ab6qBtZpNDDYaqUqxnC5V/o7qCHfK7RlXPVVw/NPISdXxDbkhvrOIqmXJW2FuN7mFgb0iRpPXuA
 6VMBCnxr5sWvKMPlEV8vyGAIZE7JuznOvv4DbzUwedcsKItgSQ5KT6mujiB8nloLKwI4hWJ8/f6
 0MTe4J1fFcTItTHtf341IPux0FyNTG62adT4oNHIWATLDI/I5In4VM9rm4UHUmADSeqjBqTeLrA
 yu74lDeSmi/0JkA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Fix the dependency topology of PCIE power domain nodes, as required by ANS2
NVME controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
index e238c2d2732f7944dc1f984a4eb647ba212b9ea5..1d8da9c7863e5b7a732888342de9d481f309edd8 100644
--- a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -658,6 +658,7 @@ ps_pcie: power-controller@80318 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "pcie";
+		power-domains = <&ps_pcie_aux>, <&ps_pcie_direct>, <&ps_pcie_ref>;
 	};
 
 	ps_pcie_aux: power-controller@80320 {

-- 
2.50.1

