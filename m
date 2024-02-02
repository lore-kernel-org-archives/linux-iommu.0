Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E234215E5CA
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902109; cv=none; b=GPsUHX9em7RzAmEbjfrlJL7BEpD0VXFI2pa/qbjpdwhvSeNHd82HuG5ItcKLfKgvl2jaX4j0btK24qfTQ5wH5SZ8kv62WdPD8Rg/QxOJ3wYOMvIdZVBGivZbQfAYlRL50uL3mWdyJMyMd8indnhbIEH+2ZgI+8Sdtf0pqQrvCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902109; c=relaxed/simple;
	bh=gc2XYLfIyCsHCOJHXIq7dBy4uHsQ0CvidMyB8n+URYo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QYfEwxYPx1Y5fyI4V5w8k2mnig0t6sit0RSQ2WEd7/pquK+LXIKjwzDX42hvxDj0czjaXykq3fpuNcbIJLQhI/ZpEJckCS2oojNxJBrVT1BftWA/3dpZ+chahu4dK7NDTguUjm9fAgOK+LQFxTtuFPBCBqD/AzrJ/VQREOypUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=O/+REBQo reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="O/+REBQo"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783def87c8cso149868285a.0
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706902103; x=1707506903; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRMVoXUIDhsqk2wauqeaSYS0KJTLFWCGjlI236Qz/TI=;
        b=O/+REBQo3GMlhEdsWMWS9wK9QBqP4Dn327zdgJrgUVH6ZomoLT+4kSrzO8w7brym/H
         hCOkxP3vXTCLT1sGHxRjynKiMWw8HQ5RgN+LHkhj8mlkepFrIQHmZiItl50T0qNTX13q
         1sxfPxBtMm0jxPsIwV53yHW/I03jrFeuRmGOEjBpwEp38aQvT0+PqfgTHOAhVMH1rbLB
         Narzt9FOBstMyOX+mORUPRAlbmYVacfIBcpglVaOyGnYne52BfoHo/HYH09rPO2daL4n
         XxUDR40QISOmHBnDSRZIkN0hm1olAg6xrVftcLMa4KgvjsSeGn1+rvS+Ewhs/knrwSaV
         eWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706902103; x=1707506903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRMVoXUIDhsqk2wauqeaSYS0KJTLFWCGjlI236Qz/TI=;
        b=sZmvBmU8CGIRvkdrv0IGpGAjgjZlM/yBlaTWbEUnARL4YUJOT1VyL9fHLrK4RBdgcB
         KANsWLn6s6inWcrZd0Ux/sxba8Qj06wtQ2ArlHIREmP8gzjBHD4lmXVKxxtsGej5vtYr
         yujJfyUN7TnVvPU1PAKJn8n0Xv5PZTleWLdx1/0V2gd4FeqI0xFUhafK5HxWxym+plCL
         lAKbFOVxjsjfocXZ46S69a8AUEp8avqqvGRkh8Td76AdcVTu6ZF45li9ywHQcCVfohEQ
         SCxTQTFFkVx/pZrLk3UIRad366OgYnCKPw0g73asabPH0PbVSYMq1NmwjugO4IquInYA
         sskQ==
X-Gm-Message-State: AOJu0YxLhWo3d6aeFKH1YRWQeQ3A/JSaekrWioDZtB6yc0zWAt6BtSoG
	WzMFGKQVKehrT0BRS7P4P+gkmsXdontSj1o1Qrc573ij4+PFFijEJOBIcXQXq2E=
X-Google-Smtp-Source: AGHT+IE2j+F9W4BLBuGDUanXeAR8Q/iu6EVu8yI5R6ISNqSNldAm4ZHYxxJTdJtaLcdM+zS8CiYtWg==
X-Received: by 2002:a05:620a:3885:b0:783:9a16:307f with SMTP id qp5-20020a05620a388500b007839a16307fmr6694812qkn.18.1706902102702;
        Fri, 02 Feb 2024 11:28:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUs3qHpOZ2c1uil71kD5W+kCecGQrkbnV/5pNfTp0xVi4h70AJfW4s6lXExDKn+ZZvmTqY5ubjqxI4VzYMk/i0p6bUaKx7KP84/W4cV/5ND5LFV421tdfdVbtHZxKYHoxSEikm3zZBNStesA/22yIK4C6ldTfg8cuPtBgE6U9bI0Y2s854k+somdy0gB6JrbGuBSgfoRUg0ko43jhZbebMVmLMiT/IfJ2BsBYF2RoEMioBoXqGDXh1K0tExwURHX1A5O57CndtgqpSBDh/IuPaU/fG2tfFqCoxMkYB2n5spwg==
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a022500b007831f8c5aeasm902250qkm.55.2024.02.02.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:28:22 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	yosryahmed@google.com
Subject: [PATCH v2] iommu/iova: use named kmem_cache for iova magazines
Date: Fri,  2 Feb 2024 19:28:20 +0000
Message-ID: <20240202192820.536408-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The magazine buffers can take gigabytes of kmem memory, dominating all
other allocations. For observability purpose create named slab cache so
the iova magazine memory overhead can be clearly observed.

With this change:

> slabtop -o | head
 Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
 Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
 Active / Total Caches (% used)     : 135 / 211 (64.0%)
 Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
 Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K

OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
 91636  88343 96%    0.03K    739     124      2956K kmalloc-32
 75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache

On this machine it is now clear that magazine use 242M of kmem memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/iova.c | 70 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

Changelog:
v2: - Use iova_cache_get/iova_cache_put to allocate/free
      "iova_magazine_cache" as suggested by Robin Murphy
    - Minor fix in the commit log.

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d30e453d0fb4..88255f9443b5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -237,6 +237,35 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	return -ENOMEM;
 }
 
+/*
+ * Magazine caches for IOVA ranges.  For an introduction to magazines,
+ * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
+ * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
+ * For simplicity, we use a static magazine size and don't implement the
+ * dynamic size tuning described in the paper.
+ */
+
+/*
+ * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
+ * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
+ * will be wasted. Since only full magazines are inserted into the depot,
+ * we don't need to waste PFN capacity on a separate list head either.
+ */
+#define IOVA_MAG_SIZE 127
+
+#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
+
+struct iova_magazine {
+	union {
+		unsigned long size;
+		struct iova_magazine *next;
+	};
+	unsigned long pfns[IOVA_MAG_SIZE];
+};
+
+static_assert(!(sizeof(struct iova_magazine) & (sizeof(struct iova_magazine) - 1)));
+
+static struct kmem_cache *iova_magazine_cache;
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
@@ -275,6 +304,16 @@ int iova_cache_get(void)
 			pr_err("Couldn't create iova cache\n");
 			return -ENOMEM;
 		}
+
+		iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
+							sizeof(struct iova_magazine),
+							0, SLAB_HWCACHE_ALIGN, NULL);
+		if (!iova_magazine_cache) {
+			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
+			mutex_unlock(&iova_cache_mutex);
+			pr_err("Couldn't create iova magazine cache\n");
+			return -ENOMEM;
+		}
 	}
 
 	iova_cache_users++;
@@ -295,6 +334,7 @@ void iova_cache_put(void)
 	if (!iova_cache_users) {
 		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
 		kmem_cache_destroy(iova_cache);
+		kmem_cache_destroy(iova_magazine_cache);
 	}
 	mutex_unlock(&iova_cache_mutex);
 }
@@ -612,32 +652,6 @@ reserve_iova(struct iova_domain *iovad,
 }
 EXPORT_SYMBOL_GPL(reserve_iova);
 
-/*
- * Magazine caches for IOVA ranges.  For an introduction to magazines,
- * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
- * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
- * For simplicity, we use a static magazine size and don't implement the
- * dynamic size tuning described in the paper.
- */
-
-/*
- * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
- * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
- * will be wasted. Since only full magazines are inserted into the depot,
- * we don't need to waste PFN capacity on a separate list head either.
- */
-#define IOVA_MAG_SIZE 127
-
-#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
-
-struct iova_magazine {
-	union {
-		unsigned long size;
-		struct iova_magazine *next;
-	};
-	unsigned long pfns[IOVA_MAG_SIZE];
-};
-static_assert(!(sizeof(struct iova_magazine) & (sizeof(struct iova_magazine) - 1)));
 
 struct iova_cpu_rcache {
 	spinlock_t lock;
@@ -658,7 +672,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
 	struct iova_magazine *mag;
 
-	mag = kmalloc(sizeof(*mag), flags);
+	mag = kmem_cache_alloc(iova_magazine_cache, flags);
 	if (mag)
 		mag->size = 0;
 
@@ -667,7 +681,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 
 static void iova_magazine_free(struct iova_magazine *mag)
 {
-	kfree(mag);
+	kmem_cache_free(iova_magazine_cache, mag);
 }
 
 static void
-- 
2.43.0.594.gd9cf4e227d-goog

