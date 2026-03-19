Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153713F7E7F
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944810; cv=none; b=cSDHHk8vNCF3pjflVpkHepQzsDacdF3TWifdaC3wQUfldAEhzCTDFerQgibXslry6ia1co37Psle2qGqbsFygElFl4+tzEmFevNRkfjeAe5QKIRdItUBRbqvEYw6bgWwnbG4aon7q0urjLK4eTONjnhL4tFbKElqOQwU5BXIqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944810; c=relaxed/simple;
	bh=QXZGMcpmZbzNg3hyxDf6KMIQeGRJjuDFH4p3lmFtu2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8QCJuJbX0ABE90Lnc7sqlWVo9fiqK5OVESQzRAoU3UdehMu7oMU2BNostpnZ95/FyRyD8Q6Skk6ZCXJLMgcfa0i311Qq5QWC5UjrOiIPsAtduHSi2L5unTUzeFfg8tDmMdg3vjpo6Vv3laSL75vI7hFUKRM1OWkMmRqFBoDl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEeAPNj9; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEeAPNj9"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c9707fc11so1069838d50.2
        for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773944807; x=1774549607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox9Bm2DTgdL2bUs58qghbxpirayQX0irvQhOZ6BdA4A=;
        b=QEeAPNj9V0LCyzPQusOtNh2VrOg4XAk0KZUZkqfM/4vGFFZvDAo7lyEQQ6lfuF1BfG
         FFBL8agyqpyLtQHQtIyXldIqMheuv2j01jWMhsanKktOa8QL2tXuUVWaxzQecOXX19rD
         5eoQSQ/FiooP0xhAaV/kCfpvsTE+xUoLXLcvC8Jo5X8vR7jA2ccP75g2JDvW0hEfd5rG
         Ni6LBpI50T81s7m8gdAHDZSHpqsvNsxTnbhMoPHRuPX2HiPqas3d8UgWrl/n+Eimucex
         esBwYPFPgw+i7m7AoiFaBrkK8kM4I1a/Qw6QBzc21hgM2z0OApMP8EoUQXy8usL2xbQy
         HsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944807; x=1774549607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox9Bm2DTgdL2bUs58qghbxpirayQX0irvQhOZ6BdA4A=;
        b=tX9YwE8ipZyVUTQ5l4re/sZ4dJW0Hj2v+fyxO9j8/0YFbjPx9Jwpm3NHkHBOW5Go75
         pfUxDA+29IHo5TZSHE5AmXaz/DmAsjSy87CWMywVjHiA6RbGOQHvfdPd6OuiY18kR/1n
         yj+WV8rRVdN2kJ5Bz3SHQsAqAdxNTPl+xT8F4Wz8a3lCqLfPJWf/ajUlDoWDMXFnDYBK
         aKl2G7mN5ru0IhMaNEqQSoWyhVDdzBZyg9l02ujuy2CiDCSG+R2z4lLA97AEald4ziVT
         eQ8FDLbuEDpuJmDcL6lyuZh7nlpSLVoGtts0kZLSO4c+RHVHdLfhokws9j00eqXOz+9h
         Kpnw==
X-Forwarded-Encrypted: i=1; AJvYcCUGcBLzjY1yUpP4QE4kV+dDg1HTRCshqe0LO2LYGcj5MEqcwTzRKIsUp0ke0MUv7ZgcfM5sWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXZ7ca0TqE7N6SVDBKts3vOo08XzUFvpUAbEN4NIBpuhsC65Ib
	icjsZ0OC5K+dPMbRVETplfrIn4vEuNNvDlAALmymS6+iMDDUkqOHMku2
X-Gm-Gg: ATEYQzy988sAiAuW7XoywWEC3Rnw/ZjMvXRjvJky+PpiHvk8Nnz+YjCsKvlsZYwGCla
	8CBIE4jKtGcHLi1NOQ8f7se+r9jjm/uA1K5TIVb+7z+Z3J8SbC5lKS4XmIinKTe+21qtHOQSz14
	/KS+/FscH1aIXfUzHa2y/Ss02JUL/KZUSRwqCL35OrwbfOBVTOVnNqY8tBEZb0zU14Lz1kJjKL2
	ymd1sCOO4fhCXovYOYuR0yv4X3BnU+xHSS5VUJR3fX2KeD4GMQX+6vlDzWgtO2hIpcBCKnYjKYV
	8sp1oOTf0pOpd3ZkLdQWesn6hRHcCw4yep/kBon/aKNBVUhFFNwetgmkvQt2rJBUGqPDZBd9iK9
	+gZDx6wO2V9Lb0jvpzAAEQSYl+6RrZSCD+pL0u5OcIKmwej/A8gbstqMsZ3w3WF71DHEo69tzHZ
	NwJBnwsuzY8zLDWDmGqokfxKZIM+da+RUEywQg8P+Z/TP/vWlZ12e/tsKjBtji4bJlI49xw+AB5
	yKgXFtpfrhBkdNqDjPlC9hc
X-Received: by 2002:a05:690e:439a:b0:64c:bfd0:ad6f with SMTP id 956f58d0204a3-64eaa718e40mr465746d50.33.1773944806815;
        Thu, 19 Mar 2026 11:26:46 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a97003sm3904920d50.9.2026.03.19.11.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:26:46 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] iommu/riscv: Fix signedness bug
Date: Thu, 19 Mar 2026 13:26:44 -0500
Message-ID: <20260319182644.1082740-1-ethantidmore06@gmail.com>
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

Fixes: 7217cee35aadb ("iommu/riscv: Skip IRQ count check when using MSI interrupts")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
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

