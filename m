Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899E18DB0B
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740983078; cv=none; b=R7B6TlDi3jJbZy2ubP4qO0sbzSbvuDvFV3kRhV3tL1QdlyXfjPSMAu0w4LXBuM65T8EHb+UZiOiqa9QiaqGbIKh9180IVdUN7TmziNkVg2mfQV1MWaf4+QCGNPWLMiK7YgT/LGZ9u6g5mxmkSGlRNfqOT4jrVcnwt7kJq+3neTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740983078; c=relaxed/simple;
	bh=EFHcnY604PxZcDX9hfXViUWhnTcEbotkGUIzzO6QMHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DxXK1wNv0gFfiEcoU0S82RUp2Cbvmrj5Wn+W04fVdJosWDgC3RcIERlE3M2WKV9JJ+7bVg8KG8lFSoDfvMEPSWrttlGZTDxIvMvzPIRXVGfeGSsdnev5pStNv7Jq0DbYhI5W+p33zGw8iXMtqktGeC9YqKrr4NECETMWRMQetxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hQ+V+jBc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hQ+V+jBc"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2238e884f72so18584755ad.3
        for <iommu@lists.linux.dev>; Sun, 02 Mar 2025 22:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740983075; x=1741587875; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FRPqvj/QlUv2dtShmOMDUHzRRPiCU0B09cpBuKE4KUk=;
        b=hQ+V+jBcE2kTaFoHfh89OIb/PuuW1rG/rw/DrLUP7u1rkRQAodMHJ8mKK2UjTgxtry
         Kt9NReKSL/yJuZP2D7+q0hJuGLJkPCVWB1V9wiLFkQrCDmwxyxlLp0rHIIqPLLN8qd41
         y/3zA+xVevY15Wcym/d+C1jAhejFJqyko0ZipgrObQFcKhQGsmzohYMyJ+SkPMF0ISph
         ouoKqSYfiEkKfChr5nr3TWkmfBfCn/+hZMKpEgaVpVCyL6t7WSXqA7pqvmUNn/Xoy9BH
         6Yhx5QF1/h67F57YVWvF67mSn2I+VDW8uXPHOBoLB+mR3bFeEamA0fNZbweZidTN8TnY
         nqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740983075; x=1741587875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRPqvj/QlUv2dtShmOMDUHzRRPiCU0B09cpBuKE4KUk=;
        b=nCE70r4eFS2yO8B/1wZgmfds3i3/pOWXo1ZcuHviJVZMfm35vPEAOdsZZogmXa9nEn
         FG9iPamKjh5PNs6jRmnpkizkekQGEdZFe8J3/hB6TDJ5Rii/kycFbX2VTrJTuByGDDth
         rNyvj3NQJh1Q/yGxkfDuh1t2mx82fnT8RdH1jNutg46DZiPfzxpsd6vF4YoagVIC9tTp
         +Mj5uvERlmupZrCQLQyBzLFVGVDPZqjzzUQzQ9Nk+viNePabRvB2ezJewQCNiRZtgulJ
         EsfXaR6/ZyX7EpodETYYiVqS/5tPlC3WyDwser33M0l7b8+4DCOt03EbnOmMZWOZ6a3l
         dKEg==
X-Forwarded-Encrypted: i=1; AJvYcCUz7vDbNJLcZX+m7ByHq9ywwRNVPa8Xj5uG35Xp5GZVPhwHRH4Nb3hJCOA5Dj0Fw56r400J6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQsZSQQ3kLn6n5p+9EXi4ezhRwPt8P5JDbY3mFEcM1//+Rg63l
	lYUHwDR0ggiWJM2G5i4cpsyAoZsXhKotUaMUBrBpKD/BtFxchcm4DwI/LQ5qF7I=
X-Gm-Gg: ASbGncuh2Cu1hNxUcs4JifWJAcZGDocjVkmmDVbWRgOFq99/reQZlNUM1cZ4pwoRVOB
	puky2FK4lzkrW1sOU/Z+X2i23poDJCKypX4k7R1w3y2txrC4iLvW5IB8pk469AmmXEmksWpO1fE
	VEF1dKSZcI9nFhyzae6ryFZqPMMKxICDElnHwNg7YaC7iYzg0fk3/lrxLscS3o2c4bFXdp4w86t
	VHlXIXCLdmS5PMj13BJCzD2V9cxViZoM+IDs4snV9G5iCBkwx1a+cdtIb2Pv5/rAaZ2/t+/Th/C
	Z9wx/A0c+M/oUIoQA0IZhys6tlKQ3reZb68nXjIdqQ+jN34qciaqQjwudm79ljgnMbKDgGEgSt9
	Snva+5SKy
X-Google-Smtp-Source: AGHT+IESh4grNErcs4++ANOa0SJQc7p6X5v8H9Dq1ufSFbL0K9GWmhRDomZrzfEl3a6jzkJkwrNomg==
X-Received: by 2002:a17:902:e752:b0:21f:45d:21fb with SMTP id d9443c01a7336-22368f61965mr152240345ad.3.1740983075253;
        Sun, 02 Mar 2025 22:24:35 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d329dsm69791145ad.27.2025.03.02.22.24.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Mar 2025 22:24:34 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v3] iommu/vt-d: fix system hang on reboot -f
Date: Mon,  3 Mar 2025 14:24:21 +0800
Message-Id: <20250303062421.17929-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We found that executing the command ./a.out &;reboot -f (where a.out is a
program that only executes a while(1) infinite loop) can probabilistically
cause the system to hang in the intel_iommu_shutdown() function, rendering
it unresponsive. Through analysis, we identified that the factors
contributing to this issue are as follows:

1. The reboot -f command does not prompt the kernel to notify the
application layer to perform cleanup actions, allowing the application to
continue running.

2. When the kernel reaches the intel_iommu_shutdown() function, only the
BSP (Bootstrap Processor) CPU is operational in the system.

3. During the execution of intel_iommu_shutdown(), the function down_write
(&dmar_global_lock) causes the process to sleep and be scheduled out.

4. At this point, though the processor's interrupt flag is not cleared,
 allowing interrupts to be accepted. However, only legacy devices and NMI
(Non-Maskable Interrupt) interrupts could come in, as other interrupts
routing have already been disabled. If no legacy or NMI interrupts occur
at this stage, the scheduler will not be able to run.

5. If the application got scheduled at this time is executing a while(1)-
type loop, it will be unable to be preempted, leading to an infinite loop
and causing the system to become unresponsive.

To resolve this issue, the intel_iommu_shutdown() function should not
execute down_write(), which can potentially cause the process to be
scheduled out. Furthermore, since only the BSP is running during the later
stages of the reboot, there is no need for protection against parallel
access to the DMAR (DMA Remapping) unit. Therefore, the following lines
could be removed:

down_write(&dmar_global_lock);
up_write(&dmar_global_lock);

After testing, the issue has been resolved.

Fixes: 6c3a44ed3c55 ("iommu/vt-d: Turn off translations at shutdown")
Co-developed-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/iommu/intel/iommu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..47c74b20d342 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2871,16 +2871,19 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
 
-	down_write(&dmar_global_lock);
+	/*
+	 * All other CPUs were brought down, hotplug interrupts were disabled,
+	 * no lock and RCU checking needed anymore
+	 */
+	list_for_each_entry(drhd, &dmar_drhd_units, list) {
+		iommu = drhd->iommu;
 
-	/* Disable PMRs explicitly here. */
-	for_each_iommu(iommu, drhd)
+		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
-	/* Make sure the IOMMUs are switched off */
-	intel_disable_iommus();
-
-	up_write(&dmar_global_lock);
+		/* Make sure the IOMMUs are switched off */
+		iommu_disable_translation(iommu);
+	}
 }
 
 static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
-- 
2.39.2

