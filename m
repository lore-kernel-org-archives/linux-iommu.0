Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30C4EB38
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927657; cv=none; b=Oe/uqBob00IiCuDGpNZQa6v0MBpCeJA2abbh8J4bGEwtzJqPPbiVvCNJslQOVThMvqH/TA6IFoIzdUA5yt02e2kvYDKrCRmjhuIsRxHJBGGcRyoXq5LhzcU5ODW/dcTGGNtEAlf4r9Gq0y/yynWv8A32NQnwncaejBPEXY9+MYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927657; c=relaxed/simple;
	bh=mHoaQT1JoyG6LkyzWkFbXUPdVaWzkJTm5hCach2QWbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxVLtz9B0IHJp3B0j9epa0c6W9EtOQ0sMagg0RVndyqczLf6FzCbZleOdAC4C2pykkmnFIyIQWXiEZNqz4w6ALVCchbXKJnCQc7i3XQqg78FHD316aig9nxKBzUbr4a7CQufwviTfpj/yAXjVdoxmL4A8wjUDcYGp57oT0pGL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbpHdh/o; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbpHdh/o"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b6c311f62so4118165ad.0
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927655; x=1728532455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tDuFxybHODEaeVrwvh+oodf/QVAaDeDVDDTRMXteliU=;
        b=bbpHdh/oRuS4ne90zFpEbMi3+ZaPf8REi6NdFgFeQbFkwntsqJHt+5LFhgLy0WLi3D
         pK1HooX2YpGvt6OpSStVLoYZb00mttnm7ev3droKOWI2WwWesabkQJ/h5c7+amEkEeiw
         WOJw0jXNN/l+987OYK0qs/Qk+OjyndJ/Vu48XWbCzim/sxoLpXAjgeeiXwGRnAsVzfiq
         SLus2pOmnnqsaYC+wsYjGRglZWKSxzQJcRXB6uGvwuNjIlbiLJNGgBrQI2ZjWYNOWgRX
         PJJPhnLhOxXwChWyjI/QuHMYAvQGsKsCAh8ZQd5M0iidQth/99cyZFl7EQTGL6R8/xNy
         lAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927655; x=1728532455;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDuFxybHODEaeVrwvh+oodf/QVAaDeDVDDTRMXteliU=;
        b=e6GItZior6JNqHsSsG/ouw2bwbupD5+5jxVGNSERd5x0IaVIVoXId1aMjTKO/PVTY4
         uGczvB3IRte/3sQ0aLGCPGEoJk4HggL1xEvWS/VYvXu9mltwKW8eUHah00mijkjdTayJ
         UCb6qFjaxPhvO2M+6Qn+mZPyeZII1yRfU/G01nyHnxJjpN3ZfO22DlZKJdwhcLiwA9Z8
         lYf/nvmKTZFNm2TfLMX0sKUnWt1IfOjWI0NirQc3WiBy6fbfc8ABq8PjLVKAWsmFq/T/
         FpxtE50N7c1H/UMzta6xjg5jltDvQtYXZFRDVRLq6dqokt1t7Vm5qrSdGnzvWArSWYSb
         04kQ==
X-Gm-Message-State: AOJu0Yyu954wJErfSHv1Ldam4NzRZaA1xkxK55s2s/CgMqLHr9AlAbMw
	kCkmXDTppWpAVKQu1Z9KBEwbKmKEPUgTfC+X4r5PXtP9A0nMePmd
X-Google-Smtp-Source: AGHT+IFKLPlcSp9SUFRml4GIrUDRe7i+pHx0/lLBWbzLd4R0zTcKVcErbP/p5ZwNke1aAWlNDTBqqg==
X-Received: by 2002:a17:903:c5:b0:20b:a431:8f2f with SMTP id d9443c01a7336-20bc5a701bbmr52713415ad.55.1727927655583;
        Wed, 02 Oct 2024 20:54:15 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:15 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 3/5] iommu/hyper-v: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:31 -0700
Message-Id: <20241003035333.49261-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003035333.49261-1-mhklinux@outlook.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current code gets the APIC IDs for CPUs numbered 255 and lower.
This code assumes cpu_possible_mask is dense, which is not true in
the general case per [1]. If cpu_possible_mask contains holes,
num_possible_cpus() is less than nr_cpu_ids, so some CPUs might get
skipped. Furthermore, getting the APIC ID of a CPU that isn't in
cpu_possible_mask is invalid.

However, the configurations that Hyper-V provides to guest VMs on x86
hardware, in combination with how x86 code assigns Linux CPU numbers,
*does* always produce a dense cpu_possible_mask. So the dense assumption
is not currently causing failures. But for robustness against future
changes in how cpu_possible_mask is populated, update the code to no
longer assume dense.

The correct approach is to determine the range to scan based on
nr_cpu_ids, and skip any CPUs that are not in the cpu_possible_mask.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/iommu/hyperv-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8a5c17b97310..2a86aa5d54c6 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -164,8 +164,8 @@ static int __init hyperv_prepare_irq_remapping(void)
 	 * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
 	 * into ioapic_max_cpumask if its APIC ID is less than 256.
 	 */
-	for (i = min_t(unsigned int, num_possible_cpus() - 1, 255); i >= 0; i--)
-		if (cpu_physical_id(i) < 256)
+	for (i = min_t(unsigned int, nr_cpu_ids - 1, 255); i >= 0; i--)
+		if (cpu_possible(i) && cpu_physical_id(i) < 256)
 			cpumask_set_cpu(i, &ioapic_max_cpumask);
 
 	return 0;
-- 
2.25.1

