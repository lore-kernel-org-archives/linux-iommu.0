Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E22D542B
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400738; cv=none; b=BGSJnGaCNbffOMFei1PpOqsy1d4HgeCziKQ+nE1JQFjqqfwgluEEuTurohGo9q99NAN3YqkQq5W4/NJLR7hUhcFNrys6mf1iysIJR7ENvdIa1/NcK1muvqgAtM3EOXaLDp/NEzuTuDw7I6vUBcOlAIQs10/cGrQwb4dvOH3vUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400738; c=relaxed/simple;
	bh=OuRQ1dQeehiLZyRtEdjZyrjgSkJSYGgZCnUoVwKEy5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPDCPbRwS0yrBwcvEzPXoFpoi3ax1NSYqU9lSCQr9QCN8YmhktRsASeSgwCwasFJ72Wdviw8unVqQ5wMtzty5LP+pLiz5p6z9hrhYo+SWRAiUEn0uEjEyDxq1/jM2HrYM4uJhmYYgWdJaiHey7KQHO64dnBLzqur7N7GMuVQ2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Sxg1aElS; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Sxg1aElS"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4103fb72537so28729415ab.0
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400736; x=1759005536; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6NLd7h8COmFlKXea5yNf3+i/groQ/UZ03coZlB4lvw=;
        b=Sxg1aElScOxn2kRUk8tRQcTm+RsOlsHZqZqjk+d3zY4oJSbLyFK9fsjgdrQOKUj/sD
         Z+XBAKx1G/pctHKY2steqaRsmwJUyzdTGLXUFWiqPhD7NxxQwC649Bw0kW1yrtthFaon
         7QRQ2Ji4qxxtzxL5m+uu2Im2PcWWdUMuCXa7ubzWoJZ71K5vofuqW2hJvsZlsg0r5zqo
         jOdN+1h1qEWGdO8wfCB4gQtNp7gf0sYDbXefgddSTHtT+gVR2w79HgYaaLaZY31Lc3Sp
         9ji3GzF1Qd8wnmJXIbEEnQd7Y72mXCa9fVqVPDxJq73Sw/ljZ3Yae2ELoaw5Tjb/idKY
         ELgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400736; x=1759005536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6NLd7h8COmFlKXea5yNf3+i/groQ/UZ03coZlB4lvw=;
        b=MYYZyL5XVw3Bwv33eyPmWIlFv6OqeG65vwloPdhiXUs2q+Fepswb9DI1RRQbqB2XnR
         jtbGHm5VsLCpGWadW3bVuwMXTYLtNISLpumQSqbpCxqeaq21YjmFLEE8vpuvPCWU1GkQ
         iHwEibUfXVbxDuUwjvKtH5FFXM5BtkR9DN0QI4gQGIrOsDfQcCzluFN+p6LsDUDb0gPI
         nVgmAhRwP0ptCNnPypVhKiqAT2ohGHb9imN+MYWuHpA9/OWqW3YevpOETPaBTjT0RSuS
         xI3VVCPhZn3eyf30WO+E+D6UrIi7aWta/rsH62OoeYd50bG4juqZjR6iDq9wGDCshp8l
         kz6Q==
X-Gm-Message-State: AOJu0Ywmo0XodiMANW7isOErw4jHj27KK6QhbXl8vciqGkbaP/gD8+ia
	fK30Bu8x4YN66m9fOKLv6g6M7LPTDQi82bT9vD2lzoMkftMNJvhqciEGfJN1h+bLViLaTqgMtaP
	L7q38290=
X-Gm-Gg: ASbGncvnrPSm/SeXFlhnO919awf0bcvKRN2jlCn4GHtKLlkZFSaHIAurdxU//DJCmlI
	U1UiVrKIamXKkcXHO83BVjjrnMq0Np2djrao3q4VDRXhWzkpf3BPxwLFVVNOFiU8cFkNlpyzxZo
	nyULi6L1c7Q8iPisj7h3jPGeMc6wU734fXSFT149M/wFNul3HPgyniSS+3CqdlAqihR3vBLGBHi
	TOuT8mfoVgmucNVJWmLg2b+FSCKgP2k9YNnqdBkdL8EYII+IqIry0fCReqgzzQFKOWKPtNE9uMZ
	j3L7W1BDgutX32kII4I07arbhlZyIhlmSesnSu05Xg2i7scR0h6WZ4FU8vq9Vc+A/8Dc73SUgex
	E1RhnVTSeGGMg9nT9rK1Dveuf
X-Google-Smtp-Source: AGHT+IHbDh/psntZAQrwhmgYfdd6+QUgFKcczM818cmbTUp9YMR8lJJAeTz4CAy+PPiDGOALUnKI9w==
X-Received: by 2002:a05:6e02:2305:b0:41f:5e50:23f1 with SMTP id e9e14a558f8ab-424819af385mr128428775ab.25.1758400735680;
        Sat, 20 Sep 2025 13:38:55 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa5f44sm3758324173.49.2025.09.20.13.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:38:55 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/18] iommu/riscv: Move struct riscv_iommu_domain and info to iommu.h
Date: Sat, 20 Sep 2025 15:38:52 -0500
Message-ID: <20250920203851.2205115-22-ajones@ventanamicro.com>
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

In order to add the interrupt remapping support in a separate file,
share struct riscv_iommu_domain and struct riscv_iommu_info through
the header.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 20 --------------------
 drivers/iommu/riscv/iommu.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 0eae2f4bdc5e..901d02529a26 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -38,9 +38,6 @@
 #define phys_to_ppn(pa)  (((pa) >> 2) & (((1ULL << 44) - 1) << 10))
 #define ppn_to_phys(pn)	 (((pn) << 2) & (((1ULL << 44) - 1) << 12))
 
-#define dev_to_iommu(dev) \
-	iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
-
 /* IOMMU PSCID allocation namespace. */
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
@@ -802,26 +799,9 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	return 0;
 }
 
-/* This struct contains protection domain specific IOMMU driver data. */
-struct riscv_iommu_domain {
-	struct iommu_domain domain;
-	struct list_head bonds;
-	spinlock_t lock;		/* protect bonds list updates. */
-	int pscid;
-	bool amo_enabled;
-	int numa_node;
-	unsigned int pgd_mode;
-	unsigned long *pgd_root;
-};
-
 #define iommu_domain_to_riscv(iommu_domain) \
 	container_of(iommu_domain, struct riscv_iommu_domain, domain)
 
-/* Private IOMMU data for managed devices, dev_iommu_priv_* */
-struct riscv_iommu_info {
-	struct riscv_iommu_domain *domain;
-};
-
 /*
  * Linkage between an iommu_domain and attached devices.
  *
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..1d163cbd9e4d 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -17,8 +17,28 @@
 
 #include "iommu-bits.h"
 
+/* This struct contains protection domain specific IOMMU driver data. */
+struct riscv_iommu_domain {
+	struct iommu_domain domain;
+	struct list_head bonds;
+	spinlock_t lock;			/* protect bonds list updates. */
+	int pscid;
+	int amo_enabled;
+	int numa_node;
+	unsigned int pgd_mode;
+	unsigned long *pgd_root;
+};
+
+/* Private IOMMU data for managed devices, dev_iommu_priv_* */
+struct riscv_iommu_info {
+	struct riscv_iommu_domain *domain;
+};
+
 struct riscv_iommu_device;
 
+#define dev_to_iommu(dev) \
+	iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
+
 struct riscv_iommu_queue {
 	atomic_t prod;				/* unbounded producer allocation index */
 	atomic_t head;				/* unbounded shadow ring buffer consumer index */
-- 
2.49.0

