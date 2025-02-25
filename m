Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69476257436
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466129; cv=none; b=q2I8sNDu4i4XFkn77q9400vIhzDvlfBTOiZBd3BZTCGk8pIFBi1jl8J3KwcSnifwY3dEPpvjulokiUUw5wUFfJRClqSnF+BZhX15hptkA8epphhcURA9wFjVdzJq79Mz7fzfvjqDY9nAa5/yJdYusOdNY13O6s1R6CxyEV5Mv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466129; c=relaxed/simple;
	bh=qkNshxsIu1VNvGOtXlviStG5GAuRjYKkl0IXRJMBtiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h81XWtzpCaK5RT1Ne4o6VNVinyRcKjdFMKJbdmfbX3Ry4fan2PsinivjaEyjVxhU6QCRjjINeXaIwvPJ0iQ7mhZijYc2NgDV9Obwo1N+H8VMh4sTVH5DLB0EuEYO0A0xMsNfpGPi8rGEkypUtqS6drn2IeGXfE5mP1bTWA3XxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qxo9f3hQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qxo9f3hQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22113560c57so20701915ad.2
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 22:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740466126; x=1741070926; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ0t40lf3Zpqp9U9xvw/UOaqAJ7hNs97Z58vlfZM6bM=;
        b=Qxo9f3hQzvnpeGkcCebp/XpnXeyset/JCVbM0HQXM183NAc/DeMt909WIdL86vHhDL
         mr5c1+IbvKOqzSsDPqSpCJC67h4/0q7G1FDyztah2YWryD0z7LJwJCnNJl4LWjyiosyH
         9Gw3wE/+4osSx/nyheLGmOcDcS0/I1BstqXhsQMluwYjXongdNb7oyyHuRE1O8hxQqVO
         sKvVWZMmlJQCkEOVH6ekTTIbiDWaw+j0RpRPho9Jvwg9FLlkY4hl6PxQHBsM5WNSEJ1Z
         gXr1uuLNcQd+XtTWydZXC3+vWz+Vd+banJC+CkX2febG5F+hrQL+mr2trYUv9KTmxqm0
         L4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740466126; x=1741070926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZ0t40lf3Zpqp9U9xvw/UOaqAJ7hNs97Z58vlfZM6bM=;
        b=Ge3+tHpSLgc4aP2eP+MMUWRvIWhblvdbrgHFHPFXVx3wlDJs5uRACWZPnfogBlDh0f
         nVUo6Q86huwsSI9Z8slq7o642OVX1pzCtaUYfT2XRFbqNvg0tJ1Ncpa5emHTSWUX35qQ
         0czy8/ZPDOJmlr1OIupnGXIFUaHfbaNm8tvI7rXSFOUERk0Pk6P6JytUUBEKRf4yOIBc
         XI33K/6pvdIp2gCk015XKUXiCpbNIwp+ILmPegXCSghzBGvIa+aTtswGGH3gdIgS7fQL
         3BR28pBsK85/4pgaMBufmcapXIEiU2PvUr1/ee8EayXPgqXtXJLe1H+bogBb7NK8asRK
         EAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtG25r34tF6rCrMxKUSGI4wINw7Q/3NfFDTDsmSExnVZ3c1fz9FCKyhDhrdTBVXFsSqbuc2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4lbBTlmvIRHe6dzCX8h2ytw+5c+eboPsf3lK4tJg+CFPIzOGj
	tJ4P/bnJH+FtA2YHLynwR5lhKiCCLaA/xXy9qg45OuFCpMGDaQvwP72L+Q6728Q=
X-Gm-Gg: ASbGnctdA0nZxC432NcjGgqjBAM34sJaDahMFLonjqf/jzqMvZC2YOtFQZk+9kmkHMh
	LgCtlv2XHHdnXK6hT8oybW/BFcbj2ek0IpOzAYoe2R6XtUPqFThpEN8sgQ5nUvLFCEd99FIHBoi
	5XtZMXasedYCpeadbh/+QOZDsR9myTqgyUR4WsDaJnEg0rC4F7QAYgqL+xXCs8ZYwEpAnpCnm8l
	+MzZbiHFu2GXM88yUICAEWNIvyJOFs45Rp1qpOhAiH+jipL8eDS4MOKqhMFdHhURDBT08P79PVN
	2qPTEZcYUDDnVuHu8OS4RL5kiUHe5fSBCNGlWH59afAbP9z6yZgMNgDBSbA8
X-Google-Smtp-Source: AGHT+IEmF+kunrtV4SwQahUfF+lqeGQraTMFNE8ukoY7seNYajrO7afhAsgjmW/AtFIgoZ9t/QM0lw==
X-Received: by 2002:a17:902:cec8:b0:215:b190:de6 with SMTP id d9443c01a7336-221a0ec33a0mr200283845ad.3.1740466126612;
        Mon, 24 Feb 2025 22:48:46 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00a8fcsm6903775ad.53.2025.02.24.22.48.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 22:48:45 -0800 (PST)
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
Subject: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
Date: Tue, 25 Feb 2025 14:48:31 +0800
Message-Id: <20250225064831.63348-1-cuiyunhui@bytedance.com>
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
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..6d9f2e56ce88 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2871,16 +2871,12 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
 
-	down_write(&dmar_global_lock);
-
 	/* Disable PMRs explicitly here. */
 	for_each_iommu(iommu, drhd)
 		iommu_disable_protect_mem_regions(iommu);
 
 	/* Make sure the IOMMUs are switched off */
 	intel_disable_iommus();
-
-	up_write(&dmar_global_lock);
 }
 
 static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
-- 
2.39.2

