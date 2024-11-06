Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834282071E2
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915469; cv=none; b=VwnDDycnV6T7H+4zIBsM73jR3RHzWf9yX+GHQOEY1h7n5KnwMthbIiCNOQcFwHOJHJ6fZcCm8t+Gu/BNfpULbwhL0jF2PfDKqouPr3OOYOgjfXX2AouX86AbYichvFE2LZubXJm3eQsUuzkSvOoWVreCXs4gsDdI+10bPJPfP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915469; c=relaxed/simple;
	bh=kGFqsIlFumYIKvxXpVDJi2uzeK9bhsdbBadYRpJVUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB+GfaR3BWE/gzb/Ey+hk6PLmqCTQ4HTCNKBtPIqMY/qG5w4eAH324npLnU5Xo5gL64Ly8W2rVUoq4n8i+DGFKsMiEQtHDHbLrPjT5RTzH/1xoQ3n0NU4QW4DL1K9ggleeGZrbU1EK28Q1gVwsXGyYPihUpIHqzcmIfAvc4/69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KxzGvW4p; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KxzGvW4p"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso2102865a12.0
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730915466; x=1731520266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g96IwKhGkFLWIqbkT7NwpHd+U4DZ81t2GIHo2pf1780=;
        b=KxzGvW4p34xuwg2UQq3dpynPqkvqkyRy3RL0s+FnPuipaKTy67l6tfJLc7Zk1qw4CB
         Z4zS27EtgbMJn2+nP1PLpdNKFsBkubwokaGyszWu4eNuBv3rEzC0HcfnYVZPAdc/6g/B
         lGjNMNwVoySTodPSbtq8uC3VJFzziLPyXFI6ZD0zEXEbg+Agk+87gReyU/cdVWS2yOud
         0tBNO2qV3AFkfPXDVsBxek8lx4S2++9OrXs2qonnV3bpql3f7ylhrVLRkWij+eno69Iu
         NMu+RHMCkW1vXuCUykDFerkYXxuxPxbPfD3QBZer+gJXDX8NFIK25TRZhxWmhEhvd9k9
         PdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730915466; x=1731520266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g96IwKhGkFLWIqbkT7NwpHd+U4DZ81t2GIHo2pf1780=;
        b=RFZovecj0kqsaBHmeg04WcdDEkY8Wmk7mubXc7iB0o0va17NP/WIqysC3P4uOIw4UO
         4wY4SRCrQlU/3KsN2hmX3Ofek+oE/lYPBwzyw+6mfcCPEBsJCJ7braodknxIKSIE6sXc
         k//ws6jS0JLjtLF4cTipwzrZaFyJWXrXvdTZFWPUwoNYfmRB0diGnjXiJlBl6xLQalJ5
         6Em96ItPIV0e0Tbae85g6pciBRL/foO/KVbGu0q7qQueH9+9Qc7KmobBn36ym9B5dz29
         4OY2SvRotlsa1yy/LK3to0wvojH0UWf65rern/YXHca8l/DD+ZyymgdCyONStnqbzLzL
         wgtA==
X-Gm-Message-State: AOJu0Ywot68k7PYGNHElQ8tKohnN34eLtwgTSNxCwmCLWS57YOhpoI3b
	pqtfM7emKcil/D6n7je8w+twHxWXa8j1KI6kxg5y3wPXxMt9pukl7RxzeWNTMdU+6+o/cSKwHBe
	I
X-Google-Smtp-Source: AGHT+IEFqB7EqZ9/qt6Tv+l9s3WePIJJrBkQGmuE+wise2peEn4wuYWmsni9+gmk+GDjL44CfjLWRg==
X-Received: by 2002:a17:907:948d:b0:a9a:597:8cc9 with SMTP id a640c23a62f3a-a9ed50cb67dmr4422366b.12.1730915465830;
        Wed, 06 Nov 2024 09:51:05 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d4d6bsm309041166b.44.2024.11.06.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:51:05 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH 1/2] iommu/riscv: Free irq vectors on pci remove
Date: Wed,  6 Nov 2024 18:51:04 +0100
Message-ID: <20241106175102.219923-5-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106175102.219923-4-ajones@ventanamicro.com>
References: <20241106175102.219923-4-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv_iommu_pci_probe() calls pci_alloc_irq_vectors() which
states pci_free_irq_vectors() must be called on cleanup.

Fixes: 68682e9578fb ("iommu/riscv: Add RISC-V IOMMU PCIe device driver")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
index c7a89143014c..25a27e627a0e 100644
--- a/drivers/iommu/riscv/iommu-pci.c
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -99,6 +99,7 @@ static void riscv_iommu_pci_remove(struct pci_dev *pdev)
 	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
 
 	riscv_iommu_remove(iommu);
+	pci_free_irq_vectors(pdev);
 }
 
 static const struct pci_device_id riscv_iommu_pci_tbl[] = {
-- 
2.47.0

