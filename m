Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195F3E63B5
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139070; cv=none; b=CoXWFi3NcH8M7LA0E5d3IfE4ZhzSiKfXOXVnPgDieKefCD/313K0Trl05o2yg6tMFKSVf94wsP6SVjf5Tglcevel4q0TSa+oIqEKuta+k2hwnXWTdoA//dPKJijRAWbuUXbiEVrlYMzRD0bCcD5thOR9G1IbpxKbpPTTTbh6iHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139070; c=relaxed/simple;
	bh=MPUb4Jcw0khVVnkcTIA3BNp03DgeMWQmGjHIAMMxg10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SasHGx8Lf6HjXbU/BTcz8dS7lg8hbmyTs07GOcoZzcFTq5Z93NJ7afvfELD3azXAaTO/yshjboG1WOpjxWkJPiUkdFlrokr0HNCCTJM6JX5mEDekyNR836qufF4OK8e9dQpf8DfNdha9yyK0DyVE/j9K/gMQkcCj6n//F0kJTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=THpCC6ak; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="THpCC6ak"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so9690325e9.1
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1775139064; x=1775743864; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+ekjncP59XWcpI8woAJDAw1Fg3HF0fV5kIcIgDAtdU=;
        b=THpCC6akn6yvWNMFW5zZ6R2rulgkZUDlDOpxZMyVbw4+qa5Gd34jPIa0qr+/ly6hYj
         1DkWqzyktunh3tCX3NLqZ8ZMZrks8u45zrlN8ZYa7r3GODLj/xtawMMsCtauBIJM6mfa
         4VM3QAAKq0Z/vLiWReAiiJCCB/skU7Kt0zu2Ke1u8kJGUkXbVp3CIzV6Pi1EGtiTLFiD
         9/iBMql0V4bj7rXS2z53QSZVY0ilA+kY5yzJ82V0nfGer3HEgi9rpqC6g6We295wwVGO
         1LfnjYo5sw85u0JxEmo9yx6wFqUcuM1Mk+QVgYZEtGw9bJ5Z9iWqfRi3CkltTwpUxpNN
         UdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139064; x=1775743864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+ekjncP59XWcpI8woAJDAw1Fg3HF0fV5kIcIgDAtdU=;
        b=a9OfaRwKv0cQVXXBn4WwlYcUPz4gzmw5VJ/RY18QgdAjxDMr3rupOjHEB00aYdxyPg
         gZJwMRFdBxt8YmXEVZSI5olpKuQl3QW1NjSYTwJJ1SEe8/8rtZQrmBS5zlGCpbpOvRE7
         hMXBjrFAB+Wgw1x5ozQOYy4//+5cAUanESaIKz/7Do5hDRgOnxlRWXjRvOgsnE+cGTXc
         0BQMEkjUvRw3P4RuKidGnlvQWOWyVVojkXxdl9Tgn0edEZa7/2MxQnXWqwzb9JpQjt6W
         tRMlepKLZhFc4vXNXGfsd0+knubA5jb318yAJDhlAwZKqb8KrMOgB9K9dwvkcJ2pCEb6
         Fhnw==
X-Forwarded-Encrypted: i=1; AJvYcCVIFA46UonZOSf26YTFr6BOo9+EiY3/tvQXhAHY1PdQRDsZu6yPx9Cj6GSHn8+cvpj8w5DliQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQG7V7TWo1NmcjK1LsZSzW2HanzQLC5VC1DzakxjT0UEpGtmdM
	WR2OcFIXgKyckYfBGAiXDwEgPUxZTIm6yRPGQqdn+Q5TDVLiZS1EIRTOHQGsEE0pTXk=
X-Gm-Gg: ATEYQzx7LcZvtAagLRTtrSjymeMkyNvwbONPBMyAU26374EU4xNBd/+DbHu4CY8xSZ3
	vz+QFUzld09oilzaW3zHjKFgMdl3+8W40zyu+uiJck3D1ma28a/59UvxFcHGCN2jA4/THkGAoi1
	TF/zWAMYOG+4FP2+TIUospYeC8DP7EnMuOU6Aa8eV+SkTRxQb+8JJyvnOknKJ3eJeihG8lhXqcp
	/PY2pBiNKBqpXqQ2RTIQI07LzdZHxmFvUERHWDyUMfcRKEDIHb7nMbAM+rvt4LCUAQsQQwGq4Tg
	ytimIqqb9Q2OyFTyrobvzBv8rEmQNqAfjb3mpogQzLeeBT+BPIL74VqN/qaccOAnpW+0s+WOKYk
	r2nyPFM+I3MaQ533tehGjmn4GAST9EzvV/cTNHk2CggyEv5MEcJqPxi0ZkUy84RzhQIzCdD0OtN
	zEeU9tP7u5Vb0dbA==
X-Received: by 2002:a05:600c:8708:b0:486:fe83:861c with SMTP id 5b1f17b1804b1-4888e064a89mr45823005e9.7.1775139064484;
        Thu, 02 Apr 2026 07:11:04 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48891d5437fsm20447355e9.5.2026.04.02.07.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:11:04 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	christian.koenig@amd.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	sean.anderson@linux.dev,
	ptesarik@suse.com,
	catalin.marinas@arm.com,
	aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com,
	steven.price@arm.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: [PATCH] dma-buf: heaps: system: document system_cc_shared heap
Date: Thu,  2 Apr 2026 16:11:03 +0200
Message-ID: <20260402141103.598495-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Document the system_cc_shared dma-buf heap that was introduced
recently. Describe its purpose, availability conditions and
relation to confidential computing VMs.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/userspace-api/dma-buf-heaps.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
index 05445c83b79a..591732393e7d 100644
--- a/Documentation/userspace-api/dma-buf-heaps.rst
+++ b/Documentation/userspace-api/dma-buf-heaps.rst
@@ -16,6 +16,14 @@ following heaps:
 
  - The ``system`` heap allocates virtually contiguous, cacheable, buffers.
 
+ - The ``system_cc_shared`` heap allocates virtually contiguous, cacheable,
+   buffers using shared (decrypted) memory. It is only present on
+   confidential computing (CoCo) VMs where memory encryption is active
+   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
+   bit cleared, making them accessible for device DMA without TDISP
+   support. On non-CoCo VMs configurations, this heap is
+   not registered.
+
  - The ``default_cma_region`` heap allocates physically contiguous,
    cacheable, buffers. Only present if a CMA region is present. Such a
    region is usually created either through the kernel commandline
-- 
2.51.1

