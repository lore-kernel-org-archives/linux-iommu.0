Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286934;
	b=GXqTKbOtjpl0gPjedz/XuakfcqLM2w0KXrAxesKy5XVnEfNWJpJxXpc2Tv0CQx/wHRBv
	 S1hjk0bhMYZNKkwzuZcSP0hodyxPolaH6hCNu4KMkz/2Pnp1VcZ7DFaB9cbQ1OAAPp2qg
	 Rpa+0ZgH/WUm42OASq3DX55bpiJG26sTbtD5T+R6liKvgkf5n28wTBPVXlZmTS+GOV1nn
	 KMSRNLh1tndoleKf+BM1ffCSeU13pSIpsBQ9D6tCafP7kn4ZGEpmqd7w/57A+nvrcFvJi
	 rPP0sLVsonerjIu3AX1C3Ux8PFggQ+fdm4GUVHGkf675pVbJ7P2YxWe4IVlLODXe8nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=;
	b=t4FIPlsl6td6EcIybUuKyVc9/lnUO1lEIb6CbtFQ8R+swPWciQh6zI/yMsY5V4Uv1X9S
	 9zIten01iR+EwahBYGsmzws7YrQ5E0/RkaX//Ebyewxd9aJjW2Ih3tIRVldZr8/CdhIpU
	 lynHq86u8n16PDOSPYr20VBY7rW37pRgzALCamxwgt0+2SVNfG0ipOxel/MTJPErYHASa
	 xSJG717VDdJjNrPjv8ZBj4o/OvJjaNj52P0bzgTOGkSzSRBHAFoTLmBl4E1ZIM3ytiz3O
	 9fQtzVAILTApzc/vHLw9lUVEM24QDMShJMlivPhUZensZHHmtA0FpwuRsYbkv0oIaKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dciq7laR;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9C606A33D
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2B9C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dciq7laR
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c41dae9db9dso159245166b.2
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286932; x=1794891732; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=;
        b=dciq7laRMeltP0SJ71vRtmDwg1GiIMAyUcItg3Eh5MwGaJCkiZVT3ry6WgT/ELcvnF
         CokcUFh3tL1Cowkx013LsTgnlCFtPthKPsiGYZKEAo9dYWYALEyrr5gmouB3ggmCWzFl
         qdlxM99FGu8Cc3sJDSRkwGuj1z2gZ586yXz+IXfgRO5hS/Qkn0R8RiaHgEMhhzFNArq9
         WW8r6o9UryCU36T2XSpKFUGkomFhmpHn85m46yClQNHZN+XBQ545ThHgiPgyvO9R78Am
         QaDgnhRZW/GCgRCE/lj07i/wcptF3mnC7aTnK2OzyJVJKrokrIG6UD6XhiuRz94KGiXd
         euDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286932; x=1794891732;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=;
        b=XaZgZP4Wj45XDDGo+/o2EsYukXViHlT7cHBtSBiJA23k8+/WfYkYqbnoiFe5vQPMux
         ENW9Plt6EyfS1StWets4L3Bzp9+K/u8rwzWgOqMbSBvlt8Q+UGOe+BfGkLH05LdzAoAj
         Y/H+b0zAQFnkE2nhr0nfLXsv6dH3GidYGcYz3uSN6EG7gcBGOUJn435WpwbTQsDgDwBf
         CjDVMBguuAVoWYEhDBj1SGbYJ24CiGfxDrjyvKAd8s/foTE5FycXsJe5MdXpdtB61hEY
         eLT5DXu+xb9YFfwdBFIAhflQ1xN6sqE/WYN1FqmsM8tHu/EILTZQx6OhopAxexiqxm2v
         hjpQ==
X-Forwarded-Encrypted: i=1; AL+hErEj1sryNoaBUZ60h/bqzstWqF1P7R5lkc7gZMKrEw0jMZxFHm9PyNqpv0RrwhFKHWV7g2mH7A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+T1Y901VK5G+sFzTML9/moioUkERJEFvJU2e454/DEG0/TkB+O
	CLrzv5pZjePxGhCqpzYVrK8oT4z3LBakR633sLaZLAMAax3zTd8Dat4CfP+6I0ufpGIdodUyklC
	b5aEbrvDoPIQNYftHQQ==
X-Received: from ejbwr20.prod.google.com ([2002:a17:907:7014:b0:c3f:b33c:8124])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f0d:b0:c2e:4a61:d436 with SMTP id a640c23a62f3a-c50495d6ee1mr114117566b.36.1794286931810;
 Mon, 09 Nov 2026 21:02:11 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:49 +0000
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
Message-ID: <20261110050202.529473-7-tarunsahu@google.com>
Subject: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
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

The kexec metadata subtree currently uses a monolithic u32 version field
to identify the metadata structure layout. Any change to the structure,
even an optional additive field, requires incrementing the version and
breaks compatibility between adjacent kernels.

Replace the u32 version field in struct kho_kexec_metadata with
struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
under new feature indices without breaking compatibility across kexec.
Also make the 3-byte padding hole between previous_release and kexec_count
explicit as reserved[3].

During deserialization, validate the blob size against the header size
and reject unknown required features. A legacy v1 metadata blob is
ignored with a warning.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_metadata.h | 17 +++++++-----
 kernel/liveupdate/kexec_handover.c     | 38 ++++++++++++++------------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
index e9e3f7e38a7c..316b3e5ad01b 100644
--- a/include/linux/kho/abi/kexec_metadata.h
+++ b/include/linux/kho/abi/kexec_metadata.h
@@ -18,28 +18,31 @@
 #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
 #define _LINUX_KHO_ABI_KEXEC_METADATA_H
 
+#include <linux/build_bug.h>
+#include <linux/kho/abi/feature.h>
 #include <linux/types.h>
 #include <linux/utsname.h>
 
-#define KHO_KEXEC_METADATA_VERSION 1
-
 /**
  * struct kho_kexec_metadata - Kexec metadata passed between kernels
- * @version: ABI version of this struct (must be first field)
  * @previous_release: Kernel version string that initiated the kexec
+ * @reserved: Reserved for structure alignment; must be zero
  * @kexec_count: Number of kexec boots since last cold boot
  *
- * This structure is preserved across kexec and allows the new kernel to
+ * This structure is preserved across kexec and allows the target kernel to
  * identify which kernel it was booted from and how many kexec reboots
- * have occurred.
+ * have occurred. Preceded by &struct kho_ser_hdr.
  *
  * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
  */
 struct kho_kexec_metadata {
-	u32 version;
 	char previous_release[__NEW_UTS_LEN + 1];
+	u8 reserved[3];
 	u32 kexec_count;
-} __packed;
+} __aligned(8);
+
+/* Register kho_kexec_metadata with KHO serialization accessors */
+DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
 
 #define KHO_METADATA_NODE_NAME "kexec-metadata"
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4b1d173d48ff..641a3b4c88fb 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1762,6 +1762,7 @@ static __init int kho_out_fdt_setup(void)
 
 static void __init kho_in_kexec_metadata(void)
 {
+	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);
 	struct kho_kexec_metadata *metadata;
 	phys_addr_t metadata_phys;
 	size_t blob_size;
@@ -1773,27 +1774,28 @@ static void __init kho_in_kexec_metadata(void)
 		/* This is fine, previous kernel didn't export metadata */
 		return;
 
-	/* Check that, at least, "version" is present */
-	if (blob_size < sizeof(u32)) {
+	if (blob_size < sizeof(*fhdr)) {
 		pr_warn("kexec-metadata blob too small (%zu bytes)\n",
 			blob_size);
 		return;
 	}
 
-	metadata = phys_to_virt(metadata_phys);
-
-	if (metadata->version != KHO_KEXEC_METADATA_VERSION) {
-		pr_warn("kexec-metadata version %u not supported (expected %u)\n",
-			metadata->version, KHO_KEXEC_METADATA_VERSION);
+	fhdr = phys_to_virt(metadata_phys);
+	if (fhdr->size != blob_size) {
+		pr_warn("kexec-metadata size invalid (%u != %zu), ignoring metadata\n",
+			fhdr->size, blob_size);
 		return;
 	}
 
-	if (blob_size < sizeof(*metadata)) {
-		pr_warn("kexec-metadata blob too small for v%u (%zu < %zu)\n",
-			metadata->version, blob_size, sizeof(*metadata));
+	err = kho_ser_validate(fhdr, kho_kexec_metadata);
+	if (err) {
+		pr_warn("kexec-metadata feature validation failed: %pe\n",
+			ERR_PTR(err));
 		return;
 	}
 
+	metadata = kho_ser_payload(fhdr, kho_kexec_metadata);
+
 	/*
 	 * Copy data to the kernel structure that will persist during
 	 * kernel lifetime.
@@ -1813,23 +1815,25 @@ static void __init kho_in_kexec_metadata(void)
  */
 static __init int kho_out_kexec_metadata(void)
 {
+	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);
 	struct kho_kexec_metadata *metadata;
 	int err;
 
-	metadata = kho_alloc_preserve(sizeof(*metadata));
-	if (IS_ERR(metadata))
-		return PTR_ERR(metadata);
+	fhdr = kho_alloc_preserve(kho_ser_size(kho_kexec_metadata));
+	if (IS_ERR(fhdr))
+		return PTR_ERR(fhdr);
+	kho_ser_init(fhdr, kho_kexec_metadata);
 
-	metadata->version = KHO_KEXEC_METADATA_VERSION;
+	metadata = kho_ser_payload(fhdr, kho_kexec_metadata);
 	strscpy(metadata->previous_release, init_uts_ns.name.release,
 		sizeof(metadata->previous_release));
+	memset(metadata->reserved, 0, sizeof(metadata->reserved));
 	/* kho_in.kexec_count is set to 0 on cold boot */
 	metadata->kexec_count = kho_in.kexec_count + 1;
 
-	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata,
-			      sizeof(*metadata));
+	err = kho_add_subtree(KHO_METADATA_NODE_NAME, fhdr, fhdr->size);
 	if (err)
-		kho_unpreserve_free(metadata);
+		kho_unpreserve_free(fhdr);
 
 	return err;
 }
-- 
2.56.0.506.g506a7eabc5-goog

