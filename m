Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E122B8A4;
	Thu, 31 Jul 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002267; cv=none; b=CswQt58gHrWMZD3WugY+m2VjtNcdze+6fWrPf6csSyu6i4gxYgPMk6w27uha6mveXcN4cZfmkTEGvvGPMLW797wfDfcTD893JRPInnGGrGLNv+yv6sPuDofaQ9dE2A3/Yffg2aPFUujP5XKzrRB2SS9xYpOUDGWL3jPXex5G0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002267; c=relaxed/simple;
	bh=KkcxjOXc7+CTAwF08gBNE8VfSajbR19kNgI7NYDtjX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJFwrj3Hck2Im1kod+AdQwQUV9e2NbMv/PUap4YIKiXB983SZoUXCJAZyvJWmiWE2ciEGAvAecEXxB7K6kE3RI+g3hFq43b4RrAk2NeKypHsl3xTu12eb8qhjGQAx/roNC9ubOoIxZhNDV9eD+nyR5pjIFKeqNZWgAcSdbgXGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8zrG/jI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8zrG/jI"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab6e66ea68so18546951cf.1;
        Thu, 31 Jul 2025 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754002265; x=1754607065; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BacIjUI5j5irCjGWnkKtBCyvI9Gfht+wak48AY934y0=;
        b=e8zrG/jIEwJuQJUnLMLVjkD1aN52TizFDBKtCrea1W5RwBPibVMFHytsfizI4zOtnS
         CzHr8dDgPtyopJ513hcT8jlBKwymY2Deirc3T4QLBb8zgzpr9b5X9fIWKMjyqEfCtqpJ
         2/Iv8A0dLMoc7CsNP9m5hB036xD2iaeZ8K/5y7pTA/0Xh/FOVqzPM2qkfS67VJpi7Br0
         ca5sFiVAlY38Cq1vlWzhG6cVn7DberyzPQKy7KXhZyDEceVNHjr6WeVteNbiKpKH0rJs
         RoZszZdoh4BGCkwskdiL7/KF5UopmWZFdSJkAiESwAV31Q8eyOTL5Bq4WWNRzgfbnl72
         Mgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754002265; x=1754607065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BacIjUI5j5irCjGWnkKtBCyvI9Gfht+wak48AY934y0=;
        b=QQCrJZBA6CyX80YGHO8Oa8HHUYTosEOScGk5RSpkYuuFTpc1mW9YL5WrGuKIbarhbp
         AeFEvB+Og1qA0Mr1HV+uYGT93UK+O9OvBYAfJgkjsgvtMG9KE9+1iTRGLuq16iW13hRT
         UHMegQQtvWg9kI6rMRRIRRy+qJZ22Zm6WoNHHD4srkLlt8Q3QpRxyq5cCxlAOG1fnWqG
         gUblObDcfG4wNRJLuTdFWW0z9SxM0viVi//iAYA9c64o3L7572+oz5zCBQm910r6rUxs
         nD8JkSyTVDMTL4KTW6C1CVqNaI4XsBzFTy+0zc15bf5JmfKKKZdewd+tOiQDqcZkb0vU
         FMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/tQJa+4xul6z9bs79vXzoDLNxMdU+t74igbhPfu6b1rJjbQmNvYUJjpD+MF3khgJPv9R/jhScdWyaa36DDhaTlvAF1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEQ+4qW/FSy9See8IcluBBvwPfudCTPUFsK6AsiDwqwjgOUryO
	1j/EyUvbpHxi7RC6Hi89g1ktU8fDKGfCCtgqCTwxKQMK5B/REd9uYbF+
X-Gm-Gg: ASbGncsG+fmlD5Gv1vcEyzUBOv53MX54GG6etI52DdV9le0rM9xbIbuKOMcN42Od3wV
	bsxkzxs58Pi7bZJxiVi8gwGH6nP9PiPgyDu+tUXZHY25fATLfEBqqoFV3xheEfcSfRzRoQ11Iz6
	WG31nEXnJjpFvY8X7I7fjJjC4SlNvtbKjyQbFC6SK0e1ES2/gEQNpqLoP2f0xN7VOibPjczDuEB
	dXIN17axzaR3sElm6FjUemwqVaSSY8/HAfpx/rfME0C/wntlYSFaalS1ybOMV638hFk1soffAyT
	slJkMzOxkS2rUZxlxzYHUaKlaX7cwSAGyi/LzAl15fDWTJKx7pPB4yaQbw6Lx1Mfo3490K3o/QO
	NdPfKRZjZgY5OUW2iH8GhRA==
X-Google-Smtp-Source: AGHT+IGEvcLf+uHQE2HUx5wsDP+6Qu8CrTw9fgYQNF2HHdCJeuoHSeknHkmSpDe/9TWgZDJ2PqYdzA==
X-Received: by 2002:a05:622a:118e:b0:4ab:651b:5f17 with SMTP id d75a77b69052e-4aedb99c9a0mr146640581cf.18.1754002264517;
        Thu, 31 Jul 2025 15:51:04 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeee0eca8sm13756151cf.56.2025.07.31.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:51:04 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH v4] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Thu, 31 Jul 2025 18:50:47 -0400
Message-ID: <20250731225048.131364-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() returns the number of bytes that would have been
written, not the number actually written. Using this for offset
tracking can cause buffer overruns if truncation occurs.

Replace snprintf() with scnprintf() to ensure the offset stays
within bounds.

Since scnprintf() never returns a negative value, and zero is not
possible in this context because 'bytes' starts at 0 and 'size - bytes'
is DEBUG_BUFFER_SIZE in the first call, which is large enough to hold
the string literals used, the return value is always positive. An integer
overflow is also completely out of reach here due to the small and fixed
buffer size. The error check in latency_show_one() is therefore unnecessary.
Remove it and make dmar_latency_snapshot() return void.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
Changes in v4:
- Removed 'ret' in latency_show_one() since it is not being used anymore:
https://lore.kernel.org/oe-kbuild-all/202508010632.WB0CM5Bz-lkp@intel.com/

Changes in v3:
- Restored return type of dmar_latency_enable() back to 'int'. It was
  mistakenly changed to 'void' in the previous version.

Changes in v2:
- The return type of dmar_latency_snapshot() was changed based on the
  discussion here:
https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/


 drivers/iommu/intel/debugfs.c | 10 ++--------
 drivers/iommu/intel/perf.c    | 10 ++++------
 drivers/iommu/intel/perf.h    |  5 ++---
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558d..65d2f792f0f7 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -648,17 +648,11 @@ DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
 static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
 			     struct dmar_drhd_unit *drhd)
 {
-	int ret;
-
 	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
 		   iommu->name, drhd->reg_base_addr);
 
-	ret = dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
-	if (ret < 0)
-		seq_puts(m, "Failed to get latency snapshot");
-	else
-		seq_puts(m, debug_buf);
-	seq_puts(m, "\n");
+	dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
+	seq_printf(m, "%s\n", debug_buf);
 }
 
 static int latency_show(struct seq_file *m, void *v)
diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index adc4de6bbd88..dceeadc3ee7c 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -113,7 +113,7 @@ static char *latency_type_names[] = {
 	"     svm_prq"
 };
 
-int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
+void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 {
 	struct latency_statistic *lstat = iommu->perf_statistic;
 	unsigned long flags;
@@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 	memset(str, 0, size);
 
 	for (i = 0; i < COUNTS_NUM; i++)
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "%s", latency_counter_names[i]);
 
 	spin_lock_irqsave(&latency_lock, flags);
@@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 		if (!dmar_latency_enabled(iommu, i))
 			continue;
 
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "\n%s", latency_type_names[i]);
 
 		for (j = 0; j < COUNTS_NUM; j++) {
@@ -156,11 +156,9 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 				break;
 			}
 
-			bytes += snprintf(str + bytes, size - bytes,
+			bytes += scnprintf(str + bytes, size - bytes,
 					  "%12lld", val);
 		}
 	}
 	spin_unlock_irqrestore(&latency_lock, flags);
-
-	return bytes;
 }
diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
index df9a36942d64..1d4baad7e852 100644
--- a/drivers/iommu/intel/perf.h
+++ b/drivers/iommu/intel/perf.h
@@ -40,7 +40,7 @@ void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
 bool dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type);
 void dmar_latency_update(struct intel_iommu *iommu, enum latency_type type,
 			 u64 latency);
-int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
+void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
 #else
 static inline int
 dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
@@ -64,9 +64,8 @@ dmar_latency_update(struct intel_iommu *iommu, enum latency_type type, u64 laten
 {
 }
 
-static inline int
+static inline void
 dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 {
-	return 0;
 }
 #endif /* CONFIG_DMAR_PERF */
-- 
2.50.1

