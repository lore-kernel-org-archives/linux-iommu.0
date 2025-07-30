Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5A21C165;
	Wed, 30 Jul 2025 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908664; cv=none; b=LD261FTdJD1NecxnUvfSDvwuHddR/Ytd8bdo5sOz0rQ1GTy5NqLbYBbjuuFIKsPq05AHNYhOmH0B1rIYRdbitZqWXHPqCptnH4R5c+E6DQMStdxNHwB1D5ffnBp/0D3ARkthP6lvhuVRFAeaPEvW/nCZTJ8CuNdbPdCJS2MSwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908664; c=relaxed/simple;
	bh=t3N7WtR4RfBRmftjkE7xfrmPPh5HlmkVCRgdTnGFxNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SG7eOR+FQDUq0JVk/zbvzxDaqmCLp2SXIC+bZ43Ce9TpKa2UvDQheAicXHSJw5n6ktv46ijRqiQyGqP6QX/waoKzMy4OEQtx+N0KNLDtQfbdSew48ixASDi6wJ6a/uRPO+8/bH3IveNS0RICzh21mg8wvpuieEg+/E2QPQ/y2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqUOjEpZ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqUOjEpZ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab5953f5dcso2593151cf.0;
        Wed, 30 Jul 2025 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753908661; x=1754513461; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxsQTv+1d89X+/7XUvxxHrkY1JbEEOii8Iv+aCI0JR0=;
        b=SqUOjEpZmdbuvOixIbRGCzt71IkMdiUAaDJU5x7D1KmHM0jO2LnQ5sqXvtkIg1qnAB
         kgVpkPooBCo9rgi+tvn/ys/QJyIv6HfY0WWvvUeBjBkBJP+jEqzELUTmvTa/dO6wCKhv
         0Z+SSmY8VZUWKgonVp+YSOdUv6bS6eIVEOntDOLUd5Ayg9m8jzhO/hWZ2ME9f+/rTb2X
         7RfJN8zzESH++4soCDQdba7Za9EQOxfasJ2EqszHrne1WYk0BKtiKsO3DoT+ckx2LWWQ
         GSac30OKl20SX1j7ZcL4TAT0UkeGFFCVWvHER8BK45xdF2uPrUfSaJmk2SQ5gs2WLdv3
         N4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908661; x=1754513461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxsQTv+1d89X+/7XUvxxHrkY1JbEEOii8Iv+aCI0JR0=;
        b=Funkvr1il0P0b6hr74EQZswUs7MTs+LV/2/zrVtOEBs/eTrzQYCrV+acHf9zQRfFAs
         EPZsc2lQWH1KwO81yXnlFML6LJ3lTHKeh6Oaqh5e95C5pN4A669j4jO+Hmc3lfQMyiFh
         CKuoCpVbowomdx3qaYanM3rvyMyOcn1YFKK3qifZbqovn2zBj3tqzVocdWAmhWeveZ12
         925c3lSzaJgwKZoBtV3/qm6LWLDnTyT8JMEDzrVod6+PxeueMMQ8BkAayUE6M8lADYF+
         Gt0x6osfxH08F+Tvf52+5Sqpz3/ngreytrvFGvbYy+oOUiCJMK2BsG4Lc+HRq1miRvsG
         lXJA==
X-Forwarded-Encrypted: i=1; AJvYcCW2W+xSz+xHDvQBjyxljjjoPcIgL/c5lnH9WNiM7QGmkiXfJNgus7/36XPX2M+9Xiuzp31y5xe8k3He+lEekqGQNmEoUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb2P8XcjA8+4wzlRPau9LJwAHvWjfBWIwbB7aLwy6nKBaXbBWs
	b6aLXaTSAlpGPNQGg+nI2XwmPlzh9NQcIkWDo/HXVDrNhYi3yeQQrD+s
X-Gm-Gg: ASbGncvyWl74jQeysFDoPwZbZ8gKuDQa30avYHY0oFh3DsmKFim7opTVMqA3phbswrB
	Vm9IW4+H9CJDVwf+OMQlQBrDT0z9gIiy6U5vmPYeMDOK9Hy7rT1+QXHaNqrFRTTi1zTkow3ko6Y
	ycxM0Q45XB8fldvhTMBBPjh7m8leEvyxAJFVM6mTTOrAh0b5P6dpjVRIc/1G9/O6HK6Z7gpwlIZ
	lXuPQCPbtVdJGIKOFK/E6yfZKHD3SmKpM1lmJlYl2NFgmVSIYgalN0OxN0i04RuY1CYstOBOCJK
	pdrmyNZ0tRCE3478yuTFLWT0FHo5Iz/KIU0zy3CNFtSvJZBGwh+4JNN30DQRRjvrnaj1qKF/jpZ
	WaWlGy9gjdHCDXuTZeeCMjFh0ZRpFNGWF
X-Google-Smtp-Source: AGHT+IF4SY6nqUnAOs7SYh4/F2wVLWmnhhH7H+aOriIH4llzUs34xcg/l57609kc1KE/JMjE9h1v4w==
X-Received: by 2002:ac8:5887:0:b0:4ab:95a7:cfa5 with SMTP id d75a77b69052e-4aedbc7a2ecmr84409361cf.56.1753908661426;
        Wed, 30 Jul 2025 13:51:01 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeee2570asm758721cf.63.2025.07.30.13.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:51:01 -0700 (PDT)
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
Subject: [PATCH v3] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Wed, 30 Jul 2025 16:50:46 -0400
Message-ID: <20250730205046.29719-1-ImanDevel@gmail.com>
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
overflow is also completely out of reach here due to the small and
fixed buffer size. The error check in latency_show_one() is therefore
unnecessary. Remove it and make dmar_latency_snapshot() return void.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
Changes in v3:
- Restored return type of dmar_latency_enable() back to 'int'. It was
  mistakenly changed to 'void' in the previous version.

Changes in v2:
- The return type of dmar_latency_snapshot() was changed based on the
  discussion here:
  https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/

 drivers/iommu/intel/debugfs.c |  8 ++------
 drivers/iommu/intel/perf.c    | 10 ++++------
 drivers/iommu/intel/perf.h    |  5 ++---
 3 files changed, 8 insertions(+), 15 deletions(-)

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

