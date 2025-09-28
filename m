Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE810269CE1
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086475; cv=none; b=Ryvy8+vdSF9oIY83P8PSsSaBzoU9cAteTjTk8YXB4siWVpwNcD6v3hQBLzYfac6EEJ7buSCzijkqsBSyQrFP32Wg6sBkI6P1pIwa0Ewd5wNtS/0cMzj0MBdTsNv9DzKEFhNfVOgtlUYu6wLdABK3psAJFIuLhgyHivMkUfx2nfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086475; c=relaxed/simple;
	bh=QR2Gs/iwXVTCtcLMACOzt1mygqy+KIwEpFthZZnCaC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tN0RsExJl608HvwFJGZlxh2LQkTzj/JkSYTDPIsLgXgrQ34PMU/K/KBN++DLasnwCl5S3aEWH4S518gP3LRqOvw0jJdVbv4AJt8Spc0+UWZjTdDLDCR82JnzvxNWxo3XSUNcWbVr1Bq5cRf36QFkRKArn4DlP8GfpAnmtHuB6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9KZE1Gt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9KZE1Gt"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78427dae77eso403507b3a.3
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086473; x=1759691273; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcKsX07BcsLgJUGWNvmQKTHOi+pK9yuzTPJl0W1HDJo=;
        b=Z9KZE1GtODkXzrTbNIjTClBbxdS8k/LtGemKdL+tjFdPc6WLaqHtKjE1uw/53beXAb
         X012AhIZXHNPhM8EafUklvVzFGtIfjZUfB5y/H2UNb/BIlZ7fxLZfomvIEt6MvhDzjbK
         UZer0tTof9UNrDG6vqQjodZGKDbZidbAOAK4uhNc84358OUk4AsFb8jXI+Z6yev9k9VR
         324Iw48AX5tiJIdMPIo3fawKyq8ai5Sqg33rVNGjNf0O/2zeUBcIQiOFWqAvGCmR/CFr
         ExbnApXc1pUJrTnYgacvEXxKutKaY1XkagdNAaOmBlWP0Yo5Om/Fh+CiULkHxZORfV+E
         TB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086473; x=1759691273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcKsX07BcsLgJUGWNvmQKTHOi+pK9yuzTPJl0W1HDJo=;
        b=kZOlqQaWNhEwsK65+/LGvCIC3qy1oD7hKHkr+hfKFKuz7/NODCUypNjTGrc6XyYMKA
         6pupET3Jone31ZZJtvX24Z7cIyXb7HMChzZ9rIzoiIt+QRGJG9INnszVFxy0QwcMZDMu
         Eds7sj6FxDe/vsJ5klwXA0J1elYgNoyt75HxclxwGJku+Ncl71EE0W96sefKgcsVG554
         raZ+Q/vE0Ajli6gOKiw13gW+qkO2+wl9EZNJLNOke1CwGe92MXEK8P5eN2LAPwzyd9wq
         OD1ASVjF/3NSfnsEq3Gei9cUySMlSsU8ITDHZBVLCyMKHPz5F2WUqmsC4hgy0kTPqcX6
         duVw==
X-Forwarded-Encrypted: i=1; AJvYcCU3PxzfDJz+AYmm+zrhkEZCKPMoUdSurCk1qsauqrs64bNlfIIZVUtjyVU/DrvZzB1O9u0Okg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNIfeLXsmmWN91edRDXPl/4JG86hPR8PfZWagfyyKEJMewlPh4
	1LQZPdLUBhcuE7VL50Cp8ECaUaSoE65tT5Q1Lst7CQ0BiI9TQT+S2347M2d0rBgnF7YU1OuBQZE
	yYu4Eiap1Md40XQ==
X-Google-Smtp-Source: AGHT+IGFAKSNmw8iYSKRrK9GJvSB49WtExb49RjLckPU3ZxW1Xt1iEJUBMJZeDOD3UW4tcj2DZSh10gOcwSWPA==
X-Received: from pfbf6.prod.google.com ([2002:a05:6a00:ad86:b0:77c:37c1:4bef])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6d5a:20b0:782:ec0f:d279 with SMTP id d2e1a72fcca58-782ec0fd804mr2724979b3a.10.1759086473198;
 Sun, 28 Sep 2025 12:07:53 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:16 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-9-skhawaja@google.com>
Subject: [RFC PATCH 08/15] iommu/vt-d: Implement live update preserve_iommu_context
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

Add implementation of preserve_iommu_context to preserve the root_table
and the associated context tables. Also mark the iommu unit as
preserved.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  2 -
 drivers/iommu/intel/iommu.h      |  1 +
 drivers/iommu/intel/liveupdate.c | 80 +++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7035ffca020f..caac4fd9a51e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -67,8 +67,6 @@ static int force_on = 0;
 static int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
-#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
-
 /*
  * Take a root_entry and return the Lower Context Table Pointer (LCTP)
  * if marked present.
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 93ac55eb49f0..273d40812d09 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -556,6 +556,8 @@ struct root_entry {
 	u64     lo;
 	u64     hi;
 };
+
+#define ROOT_ENTRY_NR (VTD_PAGE_SIZE / sizeof(struct root_entry))
 
 /*
  * low 64 bits:
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 94aabf025a60..fb214736aa3c 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -59,11 +59,87 @@ static int preserve_device_state(struct pci_dev *dev, struct device_ser *ser)
 	return 0;
 }
 
+static int unpreserve_iommu_context(struct intel_iommu *iommu, int end)
+{
+	struct context_entry *context;
+	int i;
+
+	if (end < 0)
+		end = ROOT_ENTRY_NR;
+
+	for (i = 0; i < end; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			WARN_ON_ONCE(kho_unpreserve_folio(virt_to_folio(context)));
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			WARN_ON_ONCE(kho_unpreserve_folio(virt_to_folio(context)));
+	}
+
+	return 0;
+}
+
+static int preserve_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int ret;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context) {
+			ret = kho_preserve_folio(virt_to_folio(context));
+			if (ret)
+				goto error;
+		}
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context) {
+			ret = kho_preserve_folio(virt_to_folio(context));
+			if (ret)
+				goto error_sm;
+		}
+	}
+
+	return 0;
+
+error_sm:
+	context = iommu_context_addr(iommu, i, 0, 0);
+	WARN_ON_ONCE(kho_unpreserve_folio(virt_to_folio(context)));
+error:
+	WARN_ON_ONCE(unpreserve_iommu_context(iommu, i));
+	return ret;
+}
+
 static int preserve_iommu_state(struct intel_iommu *iommu,
 				struct iommu_unit_ser *ser)
 {
-	pr_warn("Not implemented\n");
-	return 0;
+	int ret;
+
+	spin_lock(&iommu->lock);
+	ret = preserve_iommu_context(iommu);
+	if (ret)
+		goto error;
+
+	ret = kho_preserve_folio(virt_to_folio(iommu->root_entry));
+	if (ret) {
+		unpreserve_iommu_context(iommu, -1);
+		goto error;
+	}
+
+	ser->phys_addr = iommu->reg_phys;
+	ser->root_table = __pa(iommu->root_entry);
+	atomic_set(&iommu->preserved, 1);
+error:
+	spin_unlock(&iommu->lock);
+	return ret;
 }
 
 static void unpreserve_state(struct iommu_ser *ser)
-- 
2.51.0.536.g15c5d4f767-goog

