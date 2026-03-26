Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8602F39A063
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547871; cv=none; b=agEBNxfDdne5aREcrdQg1MF1fCM5Cf9HhpG2VfGrsmcTYtbcatiUcn6CWrflAKawk+SnQZr4mhC8bKl3kwZxLwpa7PaJuNFnq46ox3ZNDhUxAHx3SCgw5V5ts8qDgNE8YEZSaTHcp2MDuf+ZnOOFlolcd8uHaTtVgKJd0IawxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547871; c=relaxed/simple;
	bh=vzSR8hdQ2QitcErliYm0rJHjNJoGlNZognK+JPn3/Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DiqH0b3q0NTsd5vGKL43XW2vpZYyaL8hozqkdLZKZbXC1LZM07c3kFJeUaqylQXHSq6c8GApEbAYCX/L8ORaM6pcxuRaSvsHZFiDSZ1zzwagd0nZ9pxZTijykerQ4IiigRfQH/6EgHhIaO6h9VX6Nz16XoMFGbTSbcP2BXgXnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSCKS6dD; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSCKS6dD"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-793fdbb8d3aso15056917b3.3
        for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774547862; x=1775152662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DkV/sS5NXQeiPjlp9UyXTqzIZIBKvql5Nx/cBjkpGbc=;
        b=GSCKS6dDac/HbxguA+KzHXGf1MDEcE7sv3+oizooVIGXJQxxiv66vYgOT/3GLnQY2L
         IR8TCPsXk5BcpQm6qRJMPqpnnefQcZmY1nS0u0TAgWX+mEm/bEuyhY0zVLCyreHSngIs
         iLRrydph1MnB4XveoHd4cN6ASY/MaHZsnzHH6xSLiFuQmcQEOtXzcEH8E3jvRN//a1yi
         UQqVIXo9s1A2nuPxVId6HpyeaePyBx+eHuLIYCxa4N4mr4JGdAkluK4tk0PIzMuvWnpc
         xGhuZ6YrkEqWLkPPdiKzQps8WYJ7GDwRHGtPN1LtkSuK0HDAKOncTd540qGcPZcbb8lb
         fItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547862; x=1775152662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkV/sS5NXQeiPjlp9UyXTqzIZIBKvql5Nx/cBjkpGbc=;
        b=bo9msCgWcQTyhn6613sOmcQqD7TnO1qrRRWPY83KhxZuhkkHHE5hocY/nX7H7C8pZa
         fPSV4R3P8Jvt2EgDyCL1qQul9gNAWhVjjsTZzEs1EzwlZdeUTHFTd0uhopfz/w81aoa1
         XHOPbTukoHTrxiBA+3dYuy5Z2Dqm+sH1gzTFOO9F25slIK2ZpUaLDRhCjfV/Utwmq1Fc
         bZJaWbb7qsN3JhUSqE7A8hk/dcoUM90lvZ8gRzEvisgRFANJBmvs5HOaNFrCI8A8/9Sx
         IsMxXlOkWAiCRQRuO3+Xl0irwD2NEwQC+/fwUw3wlgyxO7i/VcgZw9MkRBipFhQc6f27
         IkWA==
X-Forwarded-Encrypted: i=1; AJvYcCUubZZsDCwkM+rrUN5iGatENHY3voR7lLsoD+DrYH/Ps9kFUKmVi1hMvFkFm2/o+F7/1qXFIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBEQwaLcVnS8iZ7zMEqkIFKWEk5eLYQ3qklb96WG+WxyRcIkrB
	IWYuFQLvfzlVdtuGgwxyekt4zFXnovUe2HW8oxBZZJ6WJ/vImwfBR7v1
X-Gm-Gg: ATEYQzxoCQftYYHq56eLVgTg0I+78F0u8MBCzTLfngkKrwNGes0aYjhj19mZmUSOqaD
	HlZOFNlmt438NThJsjT1ljWYNmt/Z2K5KAe/Q2EdrgygeLV+aszTrKdaBFqJlktlC9f89xkoiOi
	nbdfCXKNaXzPukVGN99ZRHuxERg/A41IOfhtLcqosBtAoqckakjIRL53Wona9KV271S4SKKdt6s
	N3L5oG2bAm+ICxzMu70JJqonhk4N2Ps7/COFcfHkt3O8jloH/UgKlexmMLkvqAVlBFUiX1TdM3V
	COCbepdXpuS8S2CZ8/aoHKP7KYGctM7/0OwwQc0kbmXnTmdOgjnDabaBCi53DqIO2t5t0zhS6nY
	2enr9KvqT3VltDbGJn0yaMr/xCkqt3TQVp8R+PpWxgFTxm4DM+AbeERQo75tGgkgJ8jQmIkoA2a
	1D+ng897pB70TGBK+FF8AKmWf+e7tiuqfkMtyVUOASOmpjlLEGv5LxOrbO+4Q/b88zLofzGrjWG
	QENvVO0vdaIhlYrF7PCtgjg
X-Received: by 2002:a05:690c:e4e7:b0:79a:ad57:f93f with SMTP id 00721157ae682-79acf647c7emr72115717b3.39.1774547862224;
        Thu, 26 Mar 2026 10:57:42 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::17e2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e3bdd89sm16277137b3.29.2026.03.26.10.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:57:41 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v2] iommu/riscv: Fix signedness bug
Date: Thu, 26 Mar 2026 12:57:38 -0500
Message-ID: <20260326175738.750060-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function platform_irq_count() returns negative error codes and
iommu->irqs_count is an unsigned integer, so the check
(iommu->irqs_count <= 0) is always impossible.

Make the return value of platform_irq_count() be assigned to ret, check
for error, and then assign iommu->irqs_count to ret.

Detected by Smatch:
drivers/iommu/riscv/iommu-platform.c:119 riscv_iommu_platform_probe() warn:
'iommu->irqs_count' unsigned <= 0

Fixes: 5c0ebbd3c6c6 ("iommu/riscv: Add RISC-V IOMMU platform device driver")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
v2: 
- Add correct Fixes tag.
- Add RB tag from Andrew Jones

 drivers/iommu/riscv/iommu-platform.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 8f15b06e8499..399ba8fe1b3e 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -115,10 +115,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 		fallthrough;
 
 	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
-		iommu->irqs_count = platform_irq_count(pdev);
-		if (iommu->irqs_count <= 0)
+		ret = platform_irq_count(pdev);
+		if (ret <= 0)
 			return dev_err_probe(dev, -ENODEV,
 					     "no IRQ resources provided\n");
+
+		iommu->irqs_count = ret;
+
 		if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
 			iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
 
-- 
2.53.0

