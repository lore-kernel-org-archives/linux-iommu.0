Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC2263C9E
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086472; cv=none; b=JOjWEYVPympdD63z5U62Wn0+KbBIWfDbGMoX7JvSMjWVrURrUkzFNRxSCYR5JkDJ9Om2807uPuednlQNH/v5C3pR8lbJH3ehb75cIDHMWOvs46wsYIi9xV4ONDo3TnLzUV9TWUBaubtBeUXC0p4VG2gvp5QxULjITS2NEez+YzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086472; c=relaxed/simple;
	bh=EeovTi/1CEJ8oPAob1Hj6uM2MPZDtSjBccEqrgz0EFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e3lGF03bFV+/Xb7PACrX2EDnIBFs6vHaLmdaFpVg5E3YoI7eW63wp19p2WbQZqFwcv1Q8Y/2/+gbgPkt1c6LorCeM9vAU8j3S7N2tMbL3P2Meum0iIZHBUxdtSr9PEAy9cNoDTjk7Gg3f07MwLZ4DnaDKvUYiA18FeO4qlnVQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3eUDYq9W; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3eUDYq9W"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28973df6a90so1932365ad.2
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086470; x=1759691270; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TH/9Jtoynp6nkNgBt5pZU0cN3mVwJHyFDfFaXLb+GfA=;
        b=3eUDYq9WsHrM+us0evOLjot3GQK9GsvmCOt9nLT11q9WyMkiN8K/f1j4Ext3pluhcG
         VQqb92eJkFm3K7V4InNxnNQNZyNM+wWH9V3lvDSz0oJvssT+t/iJC3w82xhhnnlY5u01
         Q09O82fSN4O4oKp+jVQ5s1sT96RNMxheYqpPFCnCoHbe3vwlEvk9FGSJI52CVnXb+1qi
         +HEFmzl5ye9NBeCpE2pbTn7Dfo85/94oUSXsJ/wWvEAMqAKKwjPK51TdBvQp5Tq1/As4
         gbRAVTR3qarloOFpfjjk2+Q5k9q2b/Ly5kzTUKYJAxKNrEce/FTgm6s19ItpkP0xBdSI
         ZLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086470; x=1759691270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH/9Jtoynp6nkNgBt5pZU0cN3mVwJHyFDfFaXLb+GfA=;
        b=A4dBIlPr2EuDrKOdNZYc0d2Ss8ZKHE/PggTCTWPe4sFXjsxs3Lr2G4M3SIDIbevKPc
         OJptAMBvYujPQ8n7nW/xEpaNyuvIrkxmJZS583ZI4ndaDrldltGqZs7r9S/JyvZ2r/k8
         IEmURe+pgjZST6PHLm62Qd72B3BK3kfz2OvSYmDSnE2wrRadeCHhH6HbtPlR6luNQquv
         KZNh9pfza9XNU4h7x0iCtZPo3OIjmnwPmJwu3e7rCXnOHCiuW42kmFtnovDV/sZd9nlH
         23WjQMD/8JsMVv4+2T9o0NnQFsG3qIQL3Umwu5UP8Go4/hekrPoVWZ/LJhSBlLWNdM4o
         bBSg==
X-Forwarded-Encrypted: i=1; AJvYcCVIiFvrcly8WRUta8ql0eT/h0mpJ/ZUsChZpajvhszvqmTHb1z/elHcvgQshM9pgAZtrioWHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKmaPFlidCxQFjMIu48THQh9LIT+prA7K8ZJKitmqYT7HmlqgY
	PlPLgY5a+T5Vwy309v3+pSpZ+5M4+YxPeRRGY4GcOljmW2hUWCLcm/03pAy0Y+KPhHZDO93ohFg
	1AEbu6FvKFq+CXQ==
X-Google-Smtp-Source: AGHT+IEDySm4AN2rcWd3tpaQUgR+ObHMHdJfAIbGRY3+AD4vHP4FnsnrIni5cOLhrFkNB0nMmOkCgtANf3ycPg==
X-Received: from pjbjx1.prod.google.com ([2002:a17:90b:46c1:b0:32d:df7e:66c2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f786:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-27ed4aab57bmr154999485ad.38.1759086470179;
 Sun, 28 Sep 2025 12:07:50 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:14 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-7-skhawaja@google.com>
Subject: [RFC PATCH 06/15] iommu/vt-d: Add stub intel iommu domain preserve op
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Add a stub implementation of iommu domain preserve for intel iommu
driver. This is required so that the iommu_domain is marked as
preserved.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      | 6 ++++++
 drivers/iommu/intel/iommu.h      | 4 ++++
 drivers/iommu/intel/liveupdate.c | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e236c7ec221f..7035ffca020f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4472,6 +4472,9 @@ const struct iommu_domain_ops intel_fs_paging_domain_ops = {
 	.iova_to_phys = intel_iommu_iova_to_phys,
 	.free = intel_iommu_domain_free,
 	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency_fs,
+#ifdef CONFIG_LIVEUPDATE
+	.preserve = intel_iommu_domain_liveupdate_preserve,
+#endif
 };
 
 const struct iommu_domain_ops intel_ss_paging_domain_ops = {
@@ -4485,6 +4488,9 @@ const struct iommu_domain_ops intel_ss_paging_domain_ops = {
 	.iova_to_phys = intel_iommu_iova_to_phys,
 	.free = intel_iommu_domain_free,
 	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency_ss,
+#ifdef CONFIG_LIVEUPDATE
+	.preserve = intel_iommu_domain_liveupdate_preserve,
+#endif
 };
 
 const struct iommu_ops intel_iommu_ops = {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3056583d7f56..6b69232efffd 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1345,6 +1345,10 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+#ifdef CONFIG_LIVEUPDATE
+int intel_iommu_domain_liveupdate_preserve(struct iommu_domain *domain);
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index d73d780d7e19..a15feef4d9ca 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -9,6 +9,14 @@
 #include <linux/liveupdate.h>
 #include <linux/module.h>
 
+#include "iommu.h"
+
+int intel_iommu_domain_liveupdate_preserve(struct iommu_domain *domain)
+{
+	pr_warn("Not implemented\n");
+	return 0;
+}
+
 static int intel_liveupdate_prepare(struct liveupdate_subsystem *handle, u64 *data)
 {
 	pr_warn("Not implemented\n");
-- 
2.51.0.536.g15c5d4f767-goog

