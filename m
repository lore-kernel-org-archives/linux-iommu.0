Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F635214801;
	Wed, 30 Jul 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908060; cv=none; b=oU7T9bo3MIc1SeNoKYMbJk2henRERnk3FZNSDONTFCknJuN6cNSyJC6z0LMMM966qxWJNV/ahJHBHhW9PfyusO7H84wBKxY+DnloVtQidE72LyM8BWmbX35rXB1t9NuRfK2H8naCX5b574ALvMDFnfHPxBR8hhbqPu8HGvfaqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908060; c=relaxed/simple;
	bh=CsObEssTfFyAOuxMHOBuH4SwCM9FsgK44eMrRV/+Bag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UbZZNolVo+1V7kWnvOsP4WBgI9t92rlLb8aqJA1gyglNIc+aza2n67aed4jl25At4EpEAGVlJGrkG2RQ/lYnOC2MieQ0xA487/OrXrsNoK7GovqtFRAF4y6fh01kxQYs3tHkRsHWqghPXxhBFxNswiFNUC4oH4kryL0cdE5BGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LybdZvGT; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LybdZvGT"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso2826086d6.3;
        Wed, 30 Jul 2025 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753908058; x=1754512858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XLKL6Xhg/Q0qq3baCuq/rD4471fpLDdQOk3nBX3yRc=;
        b=LybdZvGTTU++5VpXpC4h4u+h9sbCog1SECq5cFVXCJyj/2JBm6sJg+mMhJ08tOsXd+
         rVYB2ewVpLMQNh9Ax1zDuzV+t9oFVirkDX99QrE7yMNGuDErjvKMgC3ROUFiBUQarYdC
         y9dI8aZ9FTuyfHV9k7KFVqvvWHsXxJdXDL2q7qFtqwbfN2q7otuNM/qNklfN0vAJVO2N
         FCY4J+l11LaDnt/IbTlURXy5HhhWnZX+fhOoGcHSnBm3t+64+AMCZ9ZDp0/pwizXFPmv
         Onez5cxbN+H7Swp6mmvRKBwylelgRcT4sNaAF94jvkjCh8R9xzNwXtOzL/ZYfVh/k9Bd
         xFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908058; x=1754512858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XLKL6Xhg/Q0qq3baCuq/rD4471fpLDdQOk3nBX3yRc=;
        b=Sn80ewac8nwfzC297myVC4V1jOg7JUlmouvgoUPXWHDCjNMH1mSrp2DM2hXrKck1FJ
         +E3iVAzMKxcVugKoktEZmXttTPd4lPsf1efxJW3+KmIBORfhVY402t8QBPlrl3PO7Q3U
         G+kz6IpSroWIskBzoachLQrBMk/WoLTh2E8mKarGzaSx9Or7as6AZLAdFnvE8hR4kUyy
         uJlLl8SX1CkduTe/zfCe5dF7ORVvSYThjBRos9IoEy77XIxFLQsLCfkEEpg9Bfr+EfVa
         01rRcpUUWF95GJFNSHbiX/5ytCjgSv3UuBZ9rAiCD+ci1s+4i+WWIQ4PDNbY0+hVJG80
         lo7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVD1efDkfirXOPM/fyenpCigKnA5FWxYwU65o20cd3bzg1TYQIVqFTwT2jiwRcON6Ru3frmp8zxBnPC0KajZc8LdgTPUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2NJsWRIbmkjq9xaN55l+1SM2S/9rW5PLwn0owugXA6xTf0Rrq
	eXLPVYpZOtd0IpyySnxPXpNVdYEldlKb20wvWm/JQZ8jXo5HRAuvyaHf
X-Gm-Gg: ASbGncu5q2CKHFRaF6pTeeiPdviWtoRYYjfjLSxm73XXC/zjZYuxiyonnbHsI0otxQe
	mmX7rSIghRW6B9r/H5LUBvKJ871/p1KvJbzWOCYlOOrQmUkPJjCIgj2an841tAIiJQ7+bwGeYC7
	8fVkB740Y1704nknXofal7hzZNrKxn5ygQIBf3GPvzKB0jev6C/eMoQWlgEe8KC/kNotgWR/6OV
	yyLvgyH4ee++zyIAajy+NwaE+2witteG3TBJ0nrY1eqX5tPY2fSJZ2yQKkcHVJLdM4S213jX/Y7
	YwlJErGUdHlVXp0J4eaaUEpsCC7eg9kpOd8gB8wkCa8wWmB6G9Vsful5q/VKkltXiKReUbg9Swx
	PwfspEpGNIEHY6nzoAFrYy5NIM5irTApP
X-Google-Smtp-Source: AGHT+IHKi+RRvgWVQA9W//b5vs7l10xfB5gOYL+kEfkwHUFEe1OBICZQr8vd/q/KpqPni1qwrTF87g==
X-Received: by 2002:a05:6214:2424:b0:705:c148:26a0 with SMTP id 6a1803df08f44-70767197d07mr74480876d6.31.1753908058186;
        Wed, 30 Jul 2025 13:40:58 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299ff109sm64448176d6.10.2025.07.30.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:40:57 -0700 (PDT)
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
Subject: [PATCH v2] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Wed, 30 Jul 2025 16:40:37 -0400
Message-ID: <20250730204037.28159-1-ImanDevel@gmail.com>
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
Changes in v2:
- The return type of dmar_latency_snapshot() was changed based on the
  discussion here:
  https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/


 drivers/iommu/intel/debugfs.c | 8 ++------
 drivers/iommu/intel/perf.c    | 8 ++++----
 drivers/iommu/intel/perf.h    | 7 +++----
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558d..c4aca0eb5e29 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -653,12 +653,8 @@ static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
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
index adc4de6bbd88..7e726e1ba40b 100644
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
@@ -156,7 +156,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 				break;
 			}
 
-			bytes += snprintf(str + bytes, size - bytes,
+			bytes += scnprintf(str + bytes, size - bytes,
 					  "%12lld", val);
 		}
 	}
diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
index df9a36942d64..dcf2741c2d53 100644
--- a/drivers/iommu/intel/perf.h
+++ b/drivers/iommu/intel/perf.h
@@ -35,12 +35,12 @@ struct latency_statistic {
 };
 
 #ifdef CONFIG_DMAR_PERF
-int dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);
+void dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);
 void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
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

