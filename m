Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286928;
	b=OA0bkSzHXpTMg5ilXzl9AKEHZpUGAZb9/+Jv4hDlCt2N6dS9rd3QR/PV0nSPoRRmdl9F
	 jiqS20GyhrNlLZxu1Dx8sWTKg9JPNFCoV+WBjqmgGG9ouSKtyI+35vxccx5AoELhQiTHa
	 CLyFeZ5l7EqeOydnxcWqad7LlcpQW6tAQGViOsx5rIrEIWHnNqI5BwoBEfKStNHkeKUiO
	 KElTV3Xk4I23YbprGGvykaJ1sJNzA77DQnTF8hVS2B2iyoSMqUNAA29BgrSYi9szsuV0C
	 Goe5SrLEcQa66MpooHDfzNUj6n4QwVIMQpIUMkNJZ90pJ7SlUtnWwe0kccgD1xPNYiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3vxLVeArTOU555NjIGXbAokcuidpkXwhlCffjRLrr3o=;
	b=LzTn05hFfgdnczlmuTHWXw0V2KqtBT2OngmWxEj9Km4pR9dM3ZiRt2YZszsAb3ezVhic
	 XZ1MJu4/so0THvDAfzXsK1jz6CH+IP0RNgyL+LHJV68onHda6Ozf5qyUoPX8dLfFa03+S
	 jtt9oyLToJY7qPtIEKDn+CodBU3ZfDfJhRm2ZtnO1IiPY+U4Hk/BlKCRbdWeWZckeMf6z
	 v2Biw1bbpMWMq4Nvs5b7M4TrzWaI8mf+4e/tCMxqiwMuuHgL5x//kTZlfm9QSMBTX3Boy
	 DXyanVQC9V1flOGetJ7qgmlmaFrDVp/pd77Hkca2Qi8VtPGRcOAD6p9eSw36sGtZq7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MoXcM4VK;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD5606A33C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EFD5606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MoXcM4VK
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c40aa03ded8so181915466b.2
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 21:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286927; x=1794891727; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vxLVeArTOU555NjIGXbAokcuidpkXwhlCffjRLrr3o=;
        b=MoXcM4VK9mloTme1URuAYjL+XwAQ8ZkXravrWZXuOmCcdF2aPHjUNMeKN7f5RLlFfl
         KcvuE/zHmIEJpNu95a4kcf6TX7QpKieWoPtVClipoZxYvyYvD5azWBkGIFav54uD4KWY
         tXJiDEW6GPh/7jzVtc8E+fawMAFpFGvXzmEWUkwtk5Ijr/iSuHuAwGOQff0+MjA7JBW8
         0rmzGtFWQa114LBIVkVBsZEwJnSMfvemIr84KqZfrK9W1JPhpsZbBiswQR6qE1hKOf0s
         JOLqkJxlPkZc7PNx++2Vt7Y/HqXDmE0CweOYzcIOPHDGYmLxYVqOMfJYm78EQ2sJLoqq
         xyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286927; x=1794891727;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vxLVeArTOU555NjIGXbAokcuidpkXwhlCffjRLrr3o=;
        b=Xc/cRruW225X2TknZX8UlqgXynyoNFmW8rqu6kxcjaLjMfGSa9PHEpgRecySn0foqJ
         7iRWJmXjvzvdsRU/+IVUJDosACw95D81l3wThrElG2Owc8HdBys9qJol9NUeMoEiXBUr
         CbAYa5nGSPks2vw7KUWqGkUArJtV+QB3yliv4+f2EP4uT/izkb9U98vw7pZt8fViFxmK
         yuTBq3t9lHLouA32WRcqlPVDQqnnZKlvla5ZZUmcZ6XqRnsuCWNvOegA/FLI8PT2DCcb
         +2zPvZ1X6sVCNVtwqQpxsrwQ3Aa1OzRTONfbEyi/dyCjzbk4fJ4PTVvu97BdLFxA3cSm
         h10A==
X-Forwarded-Encrypted: i=1; AL+hErGTLey6WYOS5ta34d6fYYKXo0WZlDkmnolM/gQvN5lx9SiVCUVAArJamVc0DdlODCYRVcdvyQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/LXQaMQguDwNoCu1tkGMkBSPIJW6WT6rAljHOrB/+0wPKRq2G3
	dK0T551yvGFoh5IbtWpA9ODdAfj0nVY153nrTln1BNXIH/DGsBQvVySJbil4wTF6Fd07vItfNJQ
	LXqvjuwrHJ09dY/ptPw==
X-Received: from ejcuu11-n1.prod.google.com ([2002:a17:907:c60b:10b0:c3f:fb8f:67f3])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9694:b0:c31:fb29:a137 with SMTP id a640c23a62f3a-c5049525569mr113201966b.21.1794286926296;
 Mon, 09 Nov 2026 21:02:06 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:44 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-2-tarunsahu@google.com>
Subject: [PATCH v4 01/19] liveupdate, kho: Remove __packed from KHO, LUO and
 memfd ABI structures
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

All structures in include/linux/kho/abi/block.h (struct
kho_block_header_ser), include/linux/kho/abi/luo.h (struct luo_ser,
struct luo_file_ser, struct luo_file_set_ser, struct luo_session_ser,
struct luo_flb_header_ser, struct luo_flb_ser) and
include/linux/kho/abi/memfd.h (struct memfd_luo_folio_ser, struct
memfd_luo_ser) have naturally aligned fields on 64-bit architectures,
with no padding holes between fields or tail padding. Assert both the
structure size and 8-byte alignment under CONFIG_64BIT at compile time.
Any future unaligned field addition should come with reserved field to
keep the structure aligned.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/block.h | 10 +++++++--
 include/linux/kho/abi/luo.h   | 38 +++++++++++++++++++++++++++++------
 include/linux/kho/abi/memfd.h | 16 ++++++++++++---
 3 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
index d06d64b963be..36bdbaf9b3b8 100644
--- a/include/linux/kho/abi/block.h
+++ b/include/linux/kho/abi/block.h
@@ -12,7 +12,7 @@
  * pre-update kernel to a post-update kernel.
  *
  * This interface is a contract. Any modification to the structure fields,
- * compatible strings, or the layout of the `__packed` serialization
+ * compatible strings, or the layout of the serialization
  * structures defined here constitutes a breaking change. Such changes require
  * incrementing the version number in the `KHO_FDT_COMPATIBLE` string to
  * prevent a new kernel from misinterpreting data from an old kernel.
@@ -26,6 +26,8 @@
 #define _LINUX_KHO_ABI_BLOCK_H
 
 #include <asm/page.h>
+#include <linux/build_bug.h>
+#include <linux/kconfig.h>
 #include <linux/types.h>
 
 /**
@@ -49,6 +51,10 @@
 struct kho_block_header_ser {
 	u64 next;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct kho_block_header_ser) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct kho_block_header_ser) == 8);
 
 #endif /* _LINUX_KHO_ABI_BLOCK_H */
diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 288076de6d4a..721949374fa1 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -58,6 +58,8 @@
 #define _LINUX_KHO_ABI_LUO_H
 
 #include <linux/align.h>
+#include <linux/build_bug.h>
+#include <linux/kconfig.h>
 #include <linux/kho/abi/block.h>
 #include <uapi/linux/liveupdate.h>
 
@@ -82,7 +84,11 @@ struct luo_ser {
 	u64 liveupdate_num;
 	u64 sessions_pa;
 	u64 flbs_pa;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_ser) == 32);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_ser) == 8);
 
 #define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
 
@@ -98,7 +104,11 @@ struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
 	u64 data;
 	u64 token;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_file_ser) == 64);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_file_ser) == 8);
 
 /**
  * struct luo_file_set_ser - Represents the serialized metadata for file set
@@ -113,7 +123,11 @@ struct luo_file_ser {
 struct luo_file_set_ser {
 	u64 files;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_file_set_ser) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_file_set_ser) == 8);
 
 /**
  * struct luo_session_ser - Represents the serialized metadata for a LUO session.
@@ -131,7 +145,11 @@ struct luo_file_set_ser {
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
 	struct luo_file_set_ser file_set_ser;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_session_ser) == 80);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_session_ser) == 8);
 
 /* The max size is set so it can be reliably used during in serialization */
 #define LIVEUPDATE_FLB_COMPAT_LENGTH	48
@@ -152,7 +170,11 @@ struct luo_session_ser {
 struct luo_flb_header_ser {
 	u64 pgcnt;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_flb_header_ser) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_flb_header_ser) == 8);
 
 /**
  * struct luo_flb_ser - Represents the serialized state of a single FLB object.
@@ -175,7 +197,11 @@ struct luo_flb_ser {
 	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
 	u64 data;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_flb_ser) == 64);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_flb_ser) == 8);
 
 /* Kernel Live Update Test ABI */
 #ifdef CONFIG_LIVEUPDATE_TEST
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 08b10fea2afc..376a724a1d8c 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -11,6 +11,8 @@
 #ifndef _LINUX_KHO_ABI_MEMFD_H
 #define _LINUX_KHO_ABI_MEMFD_H
 
+#include <linux/build_bug.h>
+#include <linux/kconfig.h>
 #include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
 
@@ -20,7 +22,7 @@
  * memfd uses the ABI defined below for preserving its state across a kexec
  * reboot using the LUO.
  *
- * The state is serialized into a packed structure `struct memfd_luo_ser`
+ * The state is serialized into `struct memfd_luo_ser`
  * which is handed over to the next kernel via the KHO mechanism.
  *
  * This interface is a contract. Any modification to the structure layout
@@ -54,7 +56,11 @@ struct memfd_luo_folio_ser {
 	u64 pfn:52;
 	u64 flags:12;
 	u64 index;
-} __packed;
+};
+
+static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct memfd_luo_folio_ser) == 8);
 
 /*
  * The set of seals this version supports preserving. If support for any new
@@ -85,7 +91,11 @@ struct memfd_luo_ser {
 	u32 flags;
 	u64 nr_folios;
 	struct kho_vmalloc folios;
-} __packed;
+};
+
+static_assert(sizeof(struct memfd_luo_ser) == 48);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct memfd_luo_ser) == 8);
 
 /* The compatibility string for memfd file handler */
 #define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
-- 
2.56.0.506.g506a7eabc5-goog

