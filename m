Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EC2E1F11
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400752; cv=none; b=oblL8EKjd1pW/NY4AWBCk8Xbb5sDA+hqLZPL/SCiFO+l/nAFkI8+lkZbpTURk79Pv7f+0fU4tYadQ2c0xwgIZGUsOIve3XoYgh16yV1baloiuEWZFylJeqbdK3Z3LCNdYIJltaBHAaIIg8Pi1egVyA3RzPzBtYXDsZegRz9x9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400752; c=relaxed/simple;
	bh=Hg34JU7YAR3ovVopvNeMy/UYrJOofzU+xpM0EejLzeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QImxCT73ZVaqqPS6mKDknvPGEPxa57shrxwQVa7s19wa3tDxvYKYfx+Hv8hFy1Oe2kZEKYyVY3RgoH31a7CjyEqRS4Uyt2sYULwncOCMRf7biZBhb9sN7LzdtfnAoCJwSLoWzvEci5pcBG1UowLGhz4DFPbGoBvu9QXfFL0Bcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=faZ1CiWO; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="faZ1CiWO"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42403719c73so34187645ab.0
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400750; x=1759005550; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiJg8ON0boDhCQorG+j+Xw5gw12MCBbaI74+jnmrMFk=;
        b=faZ1CiWOj/bQht72uzI/dz24tUX6dSvV8DaukMMYM8e6chQxPBx8+kQDctks5hjHtI
         N31jZYH6vmEoqGuI/iQ3YWnNEpKMKdDaOyXn4rlvqxzmOs6nl6NcbgdNT9pWRmjgUrZe
         6lH8glLhSxLegCs2nTop/XRXza2VEd72bjfZEp6/EsuCHhtMBSYGPZBCp3c3DHeDR4ks
         SepiYpJeIh7KwbfQ7tEMiB2fby2Rt/whp67Yh/VdUTeQrI2Zllfsc1NB9sdcWmbR0z+k
         IPa3eZQoLohKKIk+rk3R6k962EwbfdOyOvNzeDWUzFqGcWaDztxSw8qgNh9siyiD17LY
         J5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400750; x=1759005550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiJg8ON0boDhCQorG+j+Xw5gw12MCBbaI74+jnmrMFk=;
        b=VUovl/r93S9L2PiofkbVJxjHVmj3fl9g3dyt0hKTxuPZVdyv6vQIU4koyl10xXKiyu
         zWoiTg7puQKWerjRXEdV8tFzr3KW8SJQWPeXcUgeviKzqp4S0w1C9/3D3LueJiuSNCPa
         vrgA+3G5MYCZo5z6Iiy+AK0YaYWCnMy4FlqIkYXX4hjwAwY9y3cl70OeIjV/1n1Zgqot
         k1p96nBly73e3O9oXy/8EmHwt5c1+3CbWxz6BHLAww7WGyr6I8ZJDYm6YISRc/g01r7q
         yiXzF7n6jiGiDy8H+mV4B2qmquRo4yeS3Zhme+0x+HpUl16xrwo+844nviFcdDcv6Amq
         YSOA==
X-Gm-Message-State: AOJu0YxhWsF2ovpiP2P9RF7rTQXiwaCxQv4OOPJfG4sRpJ2JzkE3hcld
	umpDe7qp3Zzftz3E+d8Q0n0sABbob+u+LYdWXMmaSBF2Vq+QgpGkclv4ADENy0YUfcLfAmbfsoV
	Gd5CifR4=
X-Gm-Gg: ASbGnctCYrgSFpXTz8jKIlc7Ge4Y3gqorgXbTdl4G94JqsrjkPqCiwkWOTGWPh2q50Y
	llsuAeuPQRst67hHjA2qSVY9j8HL4uQQlvYv5aIkctrRkxt0ybkyoCyGi/hIcHdy06eDpCI8aJy
	JUqdGwdI2kLGQq1Uhyfrfwss18lx8S+tfcfq3ZuxeE52Lq3ERbyuvp4Zc8lXRuZrzeiK18Q2kKm
	2EzjMf49PIOqgCXaqpFgO3DMx5G9csTwnr1rREgbVmT0rIPRe6bnSV1PfJwi7TrV4uEBmPRZeoB
	rRlZ+HK6FZArcdUmeDq7LT6Ontw7mBnNBHYpcu+7GxDqTD5d0xeGckFeS29IXCXV68hDT8b5l3i
	lmpqegibXRRdW0YTVtrn4BNH4
X-Google-Smtp-Source: AGHT+IFsmriwC7sM1H4SekuoxTk4S0bUk4TUqEUdLP6mEpfm4K0KojSVb0TkIY/Q7lu1c7nixhkmrw==
X-Received: by 2002:a92:c24c:0:b0:40c:410d:dc35 with SMTP id e9e14a558f8ab-424819709a7mr96072735ab.21.1758400749673;
        Sat, 20 Sep 2025 13:39:09 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4248a975078sm17095365ab.17.2025.09.20.13.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:09 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 13/18] iommu/riscv: report iommu capabilities
Date: Sat, 20 Sep 2025 15:39:03 -0500
Message-ID: <20250920203851.2205115-33-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Report RISC-V IOMMU capability required by the VFIO subsystem
to enable PCIe device assignment.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 02f38aa0b231..5a0dd99f07d0 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1452,6 +1452,17 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		/* The RISC-V IOMMU is always DMA cache coherent. */
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1531,6 +1542,7 @@ static void riscv_iommu_release_device(struct device *dev)
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.49.0

