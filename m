Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0942DC781
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400746; cv=none; b=sGyRRR0mQk8wpUJN6YOkZ/xySm+yUBx4XRw1YpKQKZbtahPsCOElGYaPtEIxH/Iifpe3P6pfwZakZtKidq4o7KUp/AlNckgDZhzLS8PJ+6nMFV8ETQbfzIgL6QmXcQdRHTOnqGT3ngMvpA14yjd1kLslykfVWVHckqcSdzUvvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400746; c=relaxed/simple;
	bh=EtUHAW01dG26USQdIfV+Yy6SqNqw0Y7AlTfeDTcH4mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+MltpY68KLxsLNtJ+ivAr7aRF863KaBcNrZYUF0tb5hQUYnnrY9aXFlpEGTMHeaYC6uW6JudbRXi7S85zZFUSchYNCjhHGsljTKResxToX9icLIDKP8J37KuNHYPuClZk5sYxOTR05Ql309V7JhifwzAkyAz0368psA7RkO7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FA2Sa0+T; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FA2Sa0+T"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4103fb72537so28729975ab.0
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400742; x=1759005542; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6f7KZQEISNEv2FyFAI35jNTdGKnVk6r1+8ZxOPZeRc=;
        b=FA2Sa0+T0nygX0QF3T0Mbh+lMZY2pni0Xll3D34mSMyT0D3reIU7sJh1p8j72Wh39s
         WEO/DI6SriqXLd9OLHbTEVuUHnt5K1VZct0K3+Nh6+wUqk2X52X1f4nXOKhkULRbd/XH
         K8MRafueAmGAmoHn5v2qgDfsJYEd0yB8aXk34u9i0bH38sy3BS56ys6pFkD8hsqEOo81
         3/FjF/Lq2XXP7PldUFegS7FLh5d6wXSNlNSOP1/b5U2lK5Bbtt+4qML3VVzWtOG8QcVs
         KGkjhGdL5CdkRvlhJvrhVl5VG3X7Oeg2lsxnMo2gYmZyi0+uyNu9r016YPM1qyeJf83o
         lbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400742; x=1759005542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6f7KZQEISNEv2FyFAI35jNTdGKnVk6r1+8ZxOPZeRc=;
        b=TaFULWLB0aUaBjKBXMDaQYjiI/cNX3atX5fE0N8kIuaH/NoaS1GN/du3WWDneLCofP
         25e9Abox+YG0wQnGwFdMcfuhApvVn5ksdLR9+F21Tl7T8ZO456aBA321rI1mV1bPd22b
         hDJoL9g0He77mtlDRH1wLBNyfWhsW/Uxe/3ELAAKGeHbL4mruHFpWtASkAX53DC6oRcM
         GeqdKEHVLXm2gCdwrKmsjmBuH2k49euAoNzt//BhurmnmDIBwsQ1X9LA9c4GmpqTUb2o
         UwzojjXoXnt7wUwyAHMVEXuvKz36OV9Fwi+D+WXDgNpfFrP3in5f1C0lr1EQnlgvKIXd
         TMXw==
X-Gm-Message-State: AOJu0YyQUJIhrGNmSjbojVc79UkdKqhJ3PzC/mfHNYgPNnzjoNYZ6GKU
	3AGwE93mmQMpx2LDvRp+xOzy5thvh8LBxeqY/tpedrNTqlZdlZ2s79KlSwzGu52iBWqacGIaAKh
	kr0HSCz0=
X-Gm-Gg: ASbGncsf35Ec6qOuDj22RmARgJfYKReuB5tO23/yBw9I6Z8ilx+H/uFPptv0/XSncdp
	FTPPySvs8zYCd8P3/n5Bi5bzllgxy1S2N7mdIrGA4licU+N8StFrG9+h9FgAqzjzBnztMfhLQ90
	8j9/5Q5qVao+SHcj/dTJkdZMOuvX0xVkqUhU+wfJW4vq9fTRi22O1aDVjjPHU2rAqq/2HDJQL6K
	oOXlQf/D8RNhyoMQqqc0xcsmlVCrMruiuiCJZOjGftViZxMIOjtqCdhmHNj0L1Oe7zhdPR1NvAP
	LomdC032auGCJC8iRwhDtTvVySXuUQ5Eq8/5ADrSb6XhkQtTyKN3wkzPGYbDWyQuXAr1kVxAZnq
	u3OST6iaY1IrxtpLjoV6lYTA8
X-Google-Smtp-Source: AGHT+IG6qvYE0BGeOGDeP/XzQJiC5ybLNPiJhBG7MlSgnnXrk46BBkVe1V+3lVgHEoHjnN1GIShpVQ==
X-Received: by 2002:a05:6e02:2188:b0:424:8c2d:ca3b with SMTP id e9e14a558f8ab-4248c2dcd57mr47940475ab.28.1758400741904;
        Sat, 20 Sep 2025 13:39:01 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5505433c271sm1648409173.78.2025.09.20.13.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:01 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/18] iommu/riscv: Export phys_to_ppn and ppn_to_phys
Date: Sat, 20 Sep 2025 15:38:57 -0500
Message-ID: <20250920203851.2205115-27-ajones@ventanamicro.com>
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

The riscv iommu uses a specific set of bits for PPNs (53:10). Export
the translation functions so iommu-ir can use them as well.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-bits.h |  4 ++++
 drivers/iommu/riscv/iommu.c      | 14 +++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index d72b982cf9bf..d3d98dbed709 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -36,6 +36,10 @@
 #define RISCV_IOMMU_ATP_PPN_FIELD	GENMASK_ULL(43, 0)
 #define RISCV_IOMMU_ATP_MODE_FIELD	GENMASK_ULL(63, 60)
 
+/* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=> PPN[53:10] */
+#define riscv_iommu_phys_to_ppn(pa)	(((pa) >> 2) & (((1ULL << 44) - 1) << 10))
+#define riscv_iommu_ppn_to_phys(pn)	(((pn) << 2) & (((1ULL << 44) - 1) << 12))
+
 /* 5.3 IOMMU Capabilities (64bits) */
 #define RISCV_IOMMU_REG_CAPABILITIES		0x0000
 #define RISCV_IOMMU_CAPABILITIES_VERSION	GENMASK_ULL(7, 0)
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 7418e91d8edd..440c3eb6f15a 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -30,10 +30,6 @@
 #define RISCV_IOMMU_DEF_CQ_COUNT	8192
 #define RISCV_IOMMU_DEF_FQ_COUNT	4096
 
-/* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=> PPN[53:10] */
-#define phys_to_ppn(pa)  (((pa) >> 2) & (((1ULL << 44) - 1) << 10))
-#define ppn_to_phys(pn)	 (((pn) << 2) & (((1ULL << 44) - 1) << 12))
-
 /* IOMMU PSCID allocation namespace. */
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
@@ -165,7 +161,7 @@ static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
 	if (!queue->base)
 		return -ENOMEM;
 
-	qb = phys_to_ppn(queue->phys) |
+	qb = riscv_iommu_phys_to_ppn(queue->phys) |
 	     FIELD_PREP(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, logsz);
 
 	/* Update base register and read back to verify hw accepted our write */
@@ -608,7 +604,7 @@ static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iomm
 		do {
 			ddt = READ_ONCE(*(unsigned long *)ddtp);
 			if (ddt & RISCV_IOMMU_DDTE_V) {
-				ddtp = __va(ppn_to_phys(ddt));
+				ddtp = __va(riscv_iommu_ppn_to_phys(ddt));
 				break;
 			}
 
@@ -616,7 +612,7 @@ static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iomm
 			if (!ptr)
 				return NULL;
 
-			new = phys_to_ppn(__pa(ptr)) | RISCV_IOMMU_DDTE_V;
+			new = riscv_iommu_phys_to_ppn(__pa(ptr)) | RISCV_IOMMU_DDTE_V;
 			old = cmpxchg_relaxed((unsigned long *)ddtp, ddt, new);
 
 			if (old == ddt) {
@@ -683,7 +679,7 @@ static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
 		if (ddtp & RISCV_IOMMU_DDTP_BUSY)
 			return -EBUSY;
 
-		iommu->ddt_phys = ppn_to_phys(ddtp);
+		iommu->ddt_phys = riscv_iommu_ppn_to_phys(ddtp);
 		if (iommu->ddt_phys)
 			iommu->ddt_root = devm_ioremap(iommu->dev,
 						       iommu->ddt_phys, PAGE_SIZE);
@@ -730,7 +726,7 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	do {
 		rq_ddtp = FIELD_PREP(RISCV_IOMMU_DDTP_IOMMU_MODE, rq_mode);
 		if (rq_mode > RISCV_IOMMU_DDTP_IOMMU_MODE_BARE)
-			rq_ddtp |= phys_to_ppn(iommu->ddt_phys);
+			rq_ddtp |= riscv_iommu_phys_to_ppn(iommu->ddt_phys);
 
 		riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, rq_ddtp);
 		ddtp = riscv_iommu_read_ddtp(iommu);
-- 
2.49.0

