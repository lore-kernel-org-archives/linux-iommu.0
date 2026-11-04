Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776972;
	b=CY/D17QCf9epBZ/bLEyvP+JAt+Rama++ZuB6fEk84uxGxe1w0rlyQJxT+bTYSdBK2z/h
	 hnY6w9gALHmPBlchj+P8OzKFNfmHZI4dhsBpMruOIme+MUSxUVxoJ+5keb9HxTfxtYHVv
	 P4/a0rrzUPHBAzAMMwyU1bxjAP5QjO9RCIgT20cMQIyE7Vt0Dhgl3N58cQn0P3U62odXV
	 pd7IoyBKvwGTRMnygQMPsoyZ2sdQScFHgnufdiUV6eiXbwXiFFMmuqcwGLJeZewhUI88b
	 qtOnPcpiU9NuPypOza7JyYL4mbH0V9Gxx2F8sSpBi2NOV+DTntQjG988YMBTwv0KGmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=amOqrW7TRxDYFxl6iI/KQH4BpM0KC+sLlSW8sb3QrDE=;
	b=4tFWcMEBV5C2yJF2hiNJR4p8yH+1zoDltPPvTOSLEbcLrKCfKcMSxPbLr4RWjLDwjH+N
	 iMuW/Ts64vWN6Q0k/IOVEWuDPpQ1znGxhk4X5/gmBL2JqeH9q9xUGeh+OEesza749w+rw
	 Lr3VONfcsH53oyDIMZEJq7pzMFIfRP6vZXZ2UDcJ0qzsSnxz08BsvYypMMqzqTEtPvgn9
	 cFbgxWz7bA7YvvToRIF8PKmQNakHBPt79weQqaew0tFpQ28MK1z0+1S4i0k1mylVFhEPB
	 Y9iq3D2Q4Bvz4lsP9x6Irxu4RegJYUGR8SlSkr05qzWYfzNDAUUgOvZzUW7IOrUILog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6+LEF8y;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C38606A33C
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 07:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C38606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6+LEF8y
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae1a9e187aso74862a91.3
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 23:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793776971; x=1794381771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=amOqrW7TRxDYFxl6iI/KQH4BpM0KC+sLlSW8sb3QrDE=;
        b=w6+LEF8yUZtmrL4TJxMYKzwmRsfEaPzw8sxjm1vz3aGVsdWAQwyRT3SViyNmZ5EFBU
         N6vXH7AXEVTOk1HmahU3VdFGxRbCK+hRkSbrCpi0giKs8wVQpU3ZacXX6lG6epEWTrCD
         Nk26Q9SlbZ3PWmeXGUoFAfn6WcBFRQ3hl66qj92gjznqeXIthp+85nuCWx/QS1oEmDb1
         fqUM1Be2Giqnatwt6vBCbFkUEoH7xr4yDUhJTt/zOMwmEGHCOsLKzedvqHPfUL+W8PT/
         ATWfRMtPeZQvRexN6gVD5V7elzxjSjU4dD1gihRPrl99SpBw685FKuS4rwlRGPhm7zms
         +OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793776971; x=1794381771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amOqrW7TRxDYFxl6iI/KQH4BpM0KC+sLlSW8sb3QrDE=;
        b=vMzMJ0xUgXAb2nBSQxWmeFSv16bz93dxRdxM8K8HG+6tx1n9Smc3u0OGhtVOUJUgA9
         WsPEpwHDpjeoEXfF5EA9gfxJQYCx2HcZr+7YDgtOPXjkUQxRHCBzfsbXTds1C36PKBq9
         Z8z/L638HFqfra8R55ucvhiFQHvddeRHa0NIkLgCjHP8KKgpIQI920J8RQhUl8QcrdDO
         Iz9wZeHn52/M1+cyKyuQ3+/4fGRbDhgks7GE9ILOrHF9InrshGpw9ouaFXsf7oHi38wO
         qLW0imqjGugnSsro1eQa5gWs2wT9AfvCtu+QcjvjZCKMXVBAenXPaqfcwABtnrwe5w8r
         E5hw==
X-Forwarded-Encrypted: i=1; AKwUvBz1N0MQn3tUTeuGtQY/H9VcqnVODtpgZazzRA4uz5ydNtZzhTHWSatiCpE3hNkSbSTqFfDMLQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z98eiF2nN2mhukewKO/yCymQaDB8pdUQp/s+BE4SISAawTr6fc+
	uBZ9JziuEL+hNbmq3IIsY2kKxi4T6noAtsFV2XhTOsq5jbd1Y6nJyvIq
X-Gm-Gg: AYBFou1UmSQ3UBWyxlXKa55AZ6l2PB0EMnCfe0UXHsLj0GLzxt5GGUgWkAx0VGUoeWO
	4BzmSTZ5HB8btwRXfauFBuTpBlj7JVT2mBouPVdZgRO08WkX+Q36zGWPAWEwwtfGrN8in66wSFI
	3gwmmsyMgHROW/1IaE4ZluaAzYYn7mAvaup2MiBUJiKBxvKqEzJuBAJDDMBscv21bBQVUxTs3ZS
	U3MTwiUEsvOYW7Zj9ru9tvEfaGxzg0wqdII2zovFIljFLGat7T0sCGHhHdN1Dz2ZsKude+Fg6r9
	AleywHyAPzRwtWlpQYtPAncQSf8Z6SjQql7alPTeYtBFbsX9ONiVWLnvk97F6MTJuPqcf4l5ZIp
	fcsDnFzmhGvLvk+MRD6c1nZ1E4Cv78eZ5/9No4Fm7YdJ1QlK03KO2jw38eCmpncRvQ7675ddq29
	ASieM3CuMtOwbQeY7WcwV8nNoaybIVIM0Tq2myLxYvvE/IMr3bpOg18yHz+kWi+vAfXb63D+KTu
	KLIZIPxMlegnHA/n0QpCz4wTa826fBh9ZMu1s8OfkgsXcar/6k4/wtKAowXj6NEeMCSTfEmxgMP
	PfPVdrhcdZV0uGvzAY+9012JBdcJMMQdtQdT4TDEAg==
X-Received: by 2002:a05:6a21:f107:b0:3e2:1823:2b39 with SMTP id adf61e73a8af0-3e9288c9c22mr18484635637.2.1793776971244;
        Tue, 03 Nov 2026 23:22:51 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b097fe109fsm533533b3a.8.2026.11.03.23.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:22:50 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	iommu@lists.linux.dev,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/amd: do not remove the shared IRQ domain on intcapxt failure
Date: Wed,  4 Nov 2026 15:22:41 +0800
Message-Id: <20261104072241.1617661-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_get_irqdomain() lazily creates a single irq domain and caches
it in the global iommu_irqdomain, shared by all IOMMUs.  Both
failure branches of __iommu_setup_intcapxt() call
irq_domain_remove() on it, which frees the domain, but the global
pointer is never cleared and keeps handing out the freed domain.

The failure does not prevent reuse: register_syscore() runs in the
IOMMU_ENABLED init state, one state before
amd_iommu_enable_interrupts() runs in IOMMU_PCI_INIT, and the error
paths never unregister it.  On resume, amd_iommu_resume() re-runs
amd_iommu_enable_interrupts(); for an IOMMU whose setup failed,
int_enabled was never set, so __iommu_setup_intcapxt() runs again,
gets the freed domain from iommu_get_irqdomain() and passes it to
irq_domain_alloc_irqs().

The shared domain also makes a single failure affect the healthy
IOMMUs: if IOMMU#0 set up fine and IOMMU#1's setup fails, the remove
frees a domain that still has IOMMU#0's irqs mapped, tripping the
WARN_ON(!radix_tree_empty) in irq_domain_remove().

Keep the domain alive on failure; a later attempt (including the
resume path) reuses the cached domain.  The request_threaded_irq()
failure branch still backs out the allocated irq via
irq_domain_free_irqs().

Found by static analysis.

Fixes: d1adcfbb520c ("iommu/amd: Fix IOMMU interrupt generation in X2APIC mode")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/iommu/amd/init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa3..78b11b04dd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2522,6 +2522,13 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 	int irq, ret;
 	int node = dev_to_node(&iommu->dev->dev);
 
+	/*
+	 * The IRQ domain is a cached singleton shared by all IOMMUs; a
+	 * setup failure must not remove it, otherwise the global
+	 * iommu_irqdomain is left dangling (and a shared domain could be
+	 * freed while still mapped by another IOMMU).  Leave it in place
+	 * so a later retry (e.g. resume) can use it.
+	 */
 	domain = iommu_get_irqdomain();
 	if (!domain)
 		return -ENXIO;
@@ -2532,16 +2539,13 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 	info.hwirq = hwirq;
 
 	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
-	if (irq < 0) {
-		irq_domain_remove(domain);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = request_threaded_irq(irq, NULL, thread_fn, IRQF_ONESHOT, devname,
 				   iommu);
 	if (ret) {
 		irq_domain_free_irqs(irq, 1);
-		irq_domain_remove(domain);
 		return ret;
 	}
 
-- 
2.25.1

