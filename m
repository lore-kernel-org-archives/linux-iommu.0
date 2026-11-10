Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286939;
	b=Dpw4ZSaX0aDgxqSxbEOUIBrt6e8P19r3eS5Je466k/Gx24K1wrCqSlwNfDskJKuP2gKK
	 X1iqBLSmsP6DR3T2Yo81VC98cDmOrej2eYWccfcXHgYpGQRoEawNhAAs9fke0SAPGLVJF
	 MFk1tHAiK48DnOXYrUb+NAFMbbdyUo/j0Ebhr8J0+CLEw3iYzwk9ZkXZp8S0yByw8Jjwb
	 qZw+e7fZ67DgAOrxlVu9UZEHuAo6UhlBrm99d3NWx3H2ghD0lF/Yl7xg58tMsR8oKRTrm
	 W+ecIXRRqVZg4xJlNQ5w+z/rA/TFs2QdNEckk+dwn2bV8v42O3xd7LJjZPHyRPB19nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bPe/n/7OHPWH7BQXApvZomY3AKt9T7o7Wopgeakkuns=;
	b=LulBvEkns57FaAm77HkSHkrikOjY7OEavgfyRB2+1LTSpNjkmB1aA/x3+4+RhZ6Xijsq
	 wCOuK10rbwFOdZjw5FFQMl+W3dFMIQHq6EoVsKrQBfzaJd5fTEep1efgP1eGnmSbazid/
	 Kgwrzxz0pdrbIIbsJu758qN25KPHbik1O4bNhw3U+B6hPVneHYMQ5WXDZr5C1ndz4g6UX
	 vuCGqm3cxOpDp2ohLGNBSmTeq9yQY1CK9U043/+c1OBRG2no4dCAsthySYL7fkeRH5Y1z
	 kZD5OxC+KEkUZdp/tPecjJIwuVttRfh9HA4rcKawYhDwfeTVEARQI4+ifpBQt6N3mWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CZDiEsGi;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B9606B890
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 004B9606B890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CZDiEsGi
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b6fb975053so1812752a12.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 21:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286937; x=1794891737; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPe/n/7OHPWH7BQXApvZomY3AKt9T7o7Wopgeakkuns=;
        b=CZDiEsGiYi4GM63s02NDNfJes/FDTg6HLiUc83H6LK3VxJXyqRFLiZhf74H82tBRYE
         Y4HrdslwmY+g0AO/QV8AXe92Pk/o+xLyd4vw5d/esYfunTsRM9Xchv1zfD1cwiS4YD2D
         fOMaoi3Hq6yi21ocb/AjsRT4FgHroGsfCD+nd1cIlJEtSN7/koIGOcj8RWkTK0hxM/NN
         ZoK5fye0JYMVlkCMYUi6CePGwKqQur9jDwtictjmOSjGJ/NR+r25YGSDuFsLVIF3fhar
         mCec7U1qTcejh72SQr4Ez48mqDSL53gYyboB4Ons6UgsQnXGoAt6qw9oWOqyupnW++Ol
         5Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286937; x=1794891737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPe/n/7OHPWH7BQXApvZomY3AKt9T7o7Wopgeakkuns=;
        b=Qc0Zq2sIA5FV51UnHRPTElp0PxmYW7WTKzzB0R+J4zeg73DH9E/m5FqNVrh5RJKGzI
         pOdUkq9LhVTWjSLGbBD1oNPTqLsIRfXdDMKCgAvS+gvCyLWq5PZ0hGnHcJvu3/cY3voV
         kBWCL+J2A5AGzuTrjP/1rA9M5zCNzwgyUnMUTBblEEOTJQOgKqRvLnWPVVh7i/qDr0ZX
         BA6kg7Di8liEVw/MJNwRvC2zxWCKN75+csecTQZHGxYSH3ww71KokBv5raXTQV5aS4Wm
         F9RhW11Ur/YJmIsse6gn57OmJew4YN9PZFaFyMNWaXJ0Clo5xjOZaI63mI7p1p6AzMkD
         ZBvw==
X-Forwarded-Encrypted: i=1; AL+hErGnM3Nw0Xz+T/BcxBxYfwAvFDggFNaces5dhuDMIMC0sXLA+eRO2mriFyCuEe3cHB7BVnj8qw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ja2dPZElXoVNYm6LBk1MB86B44Vqf3ERhcyOioyAxnJmP+C9G
	XXQOXjymrP9AAsRqMYvGPlVngcY7sPjnikUVNgNUBlEV7Uw3m48oHBR3S9fHwmeVve5javImciF
	8W0gMOZXG8xB3tkJTTQ==
X-Received: from edcp5.prod.google.com ([2002:a05:6402:43c5:b0:6b5:8717:e943])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3907:b0:6b5:5fca:3d5 with SMTP id 4fb4d7f45d1cf-6b756ad6f48mr1260878a12.19.1794286937148;
 Mon, 09 Nov 2026 21:02:17 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:54 +0000
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
Message-ID: <20261110050202.529473-12-tarunsahu@google.com>
Subject: [PATCH v4 11/19] liveupdate: Add feature header to struct luo_file_set_ser
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

Precede struct luo_file_set_ser with struct kho_ser_hdr via
DECLARE_KHO_SER so future file-set metadata features can append fields
to struct luo_file_set_ser without breaking compatibility between
adjacent kernels.

Reserve space for both the session feature header and the file-set
feature header in each session block-set entry, initialize the file-set
feature header in luo_file_freeze(), and validate incoming required
features in luo_file_deserialize() before accessing payload fields.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h      | 15 ++++++++-------
 kernel/liveupdate/luo_file.c     | 32 ++++++++++++++++++++++----------
 kernel/liveupdate/luo_internal.h |  7 ++++---
 kernel/liveupdate/luo_session.c  | 14 +++++++-------
 4 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 425c52c494f1..bd19211c64e1 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -112,21 +112,21 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  * @count:   The total number of files that were part of this session during
  *           serialization. Used for iteration and validation during
  *           restoration.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_file_set_ser {
 	u64 files;
 	u64 count;
 };
 
-static_assert(sizeof(struct luo_file_set_ser) == 16);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_file_set_ser) == 8);
+DECLARE_KHO_SER(luo_file_set_ser, 16, 0, 0);
 
 /**
  * struct luo_session_ser - Represents the serialized metadata for a LUO session.
- * @name:         The unique name of the session, provided by the userspace at
- *                the time of session creation.
- * @file_set_ser: Serialized pointer to the files belonging to this session.
+ * @name:          The unique name of the session, provided by the userspace at
+ *                 the time of session creation.
+ * @file_set_fhdr: Serialized pointer to the files belonging to this session.
  *
  * This structure is used to package session-specific metadata for transfer
  * between kernels via Kexec Handover. An array of these structures (one per
@@ -137,7 +137,8 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  */
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	DECLARE_KHOSER_PTR(file_set_ser, struct luo_file_set_ser *);
+	DECLARE_KHOSER_PTR(file_set_fhdr,
+			   DECLARE_KHO_SER_HDR(luo_file_set_ser, *));
 };
 
 DECLARE_KHO_SER(luo_session_ser, 72, 0, 0);
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..02d09a80d785 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -440,8 +440,8 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
 
 /**
  * luo_file_freeze - Freezes all preserved files and serializes their metadata.
- * @file_set:     The file_set whose files are to be frozen.
- * @file_set_ser: Where to put the serialized file_set.
+ * @file_set:      The file_set whose files are to be frozen.
+ * @file_set_fhdr: Where to put the serialized file_set.
  *
  * This function is called from the reboot() syscall path, just before the
  * kernel transitions to the new image via kexec. Its purpose is to perform the
@@ -472,12 +472,14 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
  * Return: 0 on success, or a negative errno on failure.
  */
 int luo_file_freeze(struct luo_file_set *file_set,
-		    struct luo_file_set_ser *file_set_ser)
+		    DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr))
 {
+	struct luo_file_set_ser *file_set_ser;
 	struct luo_file *luo_file;
 	struct kho_block_set_it it;
 	int err;
 
+	kho_ser_init(file_set_fhdr, luo_file_set_ser);
 	if (!file_set->count)
 		return 0;
 
@@ -506,6 +508,7 @@ int luo_file_freeze(struct luo_file_set *file_set,
 		file_ser->token = luo_file->token;
 	}
 
+	file_set_ser = kho_ser_payload(file_set_fhdr, luo_file_set_ser);
 	file_set_ser->count = file_set->count;
 	file_set_ser->files = kho_block_set_head_pa(&file_set->block_set);
 
@@ -519,8 +522,8 @@ int luo_file_freeze(struct luo_file_set *file_set,
 
 /**
  * luo_file_unfreeze - Unfreezes all files in a file_set and clear serialization
- * @file_set:     The file_set whose files are to be unfrozen.
- * @file_set_ser: Serialized file_set.
+ * @file_set:      The file_set whose files are to be unfrozen.
+ * @file_set_fhdr: Serialized file_set.
  *
  * This function rolls back the state of all files in a file_set after the
  * freeze phase has begun but must be aborted. It is the counterpart to
@@ -534,13 +537,13 @@ int luo_file_freeze(struct luo_file_set *file_set,
  *          the reboot() syscall, after luo_file_freeze() has been called.
  */
 void luo_file_unfreeze(struct luo_file_set *file_set,
-		       struct luo_file_set_ser *file_set_ser)
+		       DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr))
 {
 	if (!file_set->count)
 		return;
 
 	__luo_file_unfreeze(file_set, NULL);
-	memset(file_set_ser, 0, sizeof(*file_set_ser));
+	memset(file_set_fhdr, 0, kho_ser_size(luo_file_set_ser));
 }
 
 /**
@@ -780,8 +783,8 @@ static int luo_file_deserialize_one(struct luo_file_set *file_set,
 
 /**
  * luo_file_deserialize - Reconstructs the list of preserved files in the new kernel.
- * @file_set:     The incoming file_set to fill with deserialized data.
- * @file_set_ser: Serialized KHO file_set data from the previous kernel.
+ * @file_set:      The incoming file_set to fill with deserialized data.
+ * @file_set_fhdr: Serialized KHO file_set data from the previous kernel.
  *
  * This function is called during the early boot process of the new kernel. It
  * takes the raw, contiguous memory block of 'struct luo_file_ser' entries,
@@ -804,12 +807,21 @@ static int luo_file_deserialize_one(struct luo_file_set *file_set,
  * Context: Called from session deserialization.
  */
 int luo_file_deserialize(struct luo_file_set *file_set,
-			 struct luo_file_set_ser *file_set_ser)
+			 DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr))
 {
+	struct luo_file_set_ser *file_set_ser;
 	struct luo_file_ser *file_ser;
 	struct kho_block_set_it it;
 	int err;
 
+	if (!file_set_fhdr)
+		return -EINVAL;
+
+	err = kho_ser_validate(file_set_fhdr, luo_file_set_ser);
+	if (err)
+		return err;
+
+	file_set_ser = kho_ser_payload(file_set_fhdr, luo_file_set_ser);
 	if (!file_set_ser->files) {
 		WARN_ON(file_set_ser->count);
 		return 0;
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..e22a8cf39d91 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_LUO_INTERNAL_H
 #define _LINUX_LUO_INTERNAL_H
 
+#include <linux/kho/abi/luo.h>
 #include <linux/liveupdate.h>
 #include <linux/uaccess.h>
 #include <linux/kho_block.h>
@@ -104,14 +105,14 @@ int luo_session_deserialize(void);
 int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set,
-		    struct luo_file_set_ser *file_set_ser);
+		    DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr));
 void luo_file_unfreeze(struct luo_file_set *file_set,
-		       struct luo_file_set_ser *file_set_ser);
+		       DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr));
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep);
 int luo_file_finish(struct luo_file_set *file_set);
 int luo_file_deserialize(struct luo_file_set *file_set,
-			 struct luo_file_set_ser *file_set_ser);
+			 DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr));
 void luo_file_set_init(struct luo_file_set *file_set);
 void luo_file_set_destroy(struct luo_file_set *file_set);
 
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 641bd67ce76e..6513fde3ecfe 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -132,7 +132,7 @@ struct luo_session_global {
 };
 
 #define LUO_SESSION_SER_SIZE (kho_ser_size(luo_session_ser) + \
-			      sizeof(struct luo_file_set_ser))
+			      kho_ser_size(luo_file_set_ser))
 
 static struct luo_session_global luo_session_global = {
 	.incoming = {
@@ -227,7 +227,7 @@ static void luo_session_unfreeze_one(struct luo_session *session,
 {
 	guard(mutex)(&session->mutex);
 	luo_file_unfreeze(&session->file_set,
-			  KHOSER_LOAD_PTR(ser->file_set_ser));
+			  KHOSER_LOAD_PTR(ser->file_set_fhdr));
 }
 
 static int luo_session_freeze_one(struct luo_session *session,
@@ -235,7 +235,7 @@ static int luo_session_freeze_one(struct luo_session *session,
 {
 	guard(mutex)(&session->mutex);
 	return luo_file_freeze(&session->file_set,
-			       KHOSER_LOAD_PTR(ser->file_set_ser));
+			       KHOSER_LOAD_PTR(ser->file_set_fhdr));
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
@@ -560,14 +560,14 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
 static struct luo_session_ser *
 luo_session_ser_init(DECLARE_KHO_SER_HDR(luo_session_ser, *fhdr))
 {
-	struct luo_file_set_ser *file_set_ser;
+	DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr);
 	struct luo_session_ser *ser;
 
 	kho_ser_init(fhdr, luo_session_ser);
-	file_set_ser = (void *)fhdr + kho_ser_size(luo_session_ser);
+	file_set_fhdr = (void *)fhdr + kho_ser_size(luo_session_ser);
 
 	ser = kho_ser_payload(fhdr, luo_session_ser);
-	KHOSER_STORE_PTR(ser->file_set_ser, file_set_ser);
+	KHOSER_STORE_PTR(ser->file_set_fhdr, file_set_fhdr);
 
 	return ser;
 }
@@ -601,7 +601,7 @@ static int luo_session_deserialize_one(struct luo_session_header *sh,
 
 	scoped_guard(mutex, &session->mutex) {
 		err = luo_file_deserialize(&session->file_set,
-					   KHOSER_LOAD_PTR(ser->file_set_ser));
+					   KHOSER_LOAD_PTR(ser->file_set_fhdr));
 	}
 	if (err) {
 		pr_warn("Failed to deserialize files for session [%s] %pe\n",
-- 
2.56.0.506.g506a7eabc5-goog

