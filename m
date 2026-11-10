Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286945;
	b=zkVhtzPsX1iquA8sJwpTfauXnUDhcl/OCOnUxN34EihSE96bAXCaW5/TsPibWc4gepJy
	 SRQN+/CPIS/BQZoRkPlE26zH+aBZvSAr5K7yozP3DPcjrbTTTVCIgxemSgS9HmVwun4bS
	 XjA9Ws1JZ8Mr7D6AFSMTfkdiVu0DMVc3uySydWzL1IT4IqWrReFkOWhWoLxPibE7ErXOt
	 qQo+igM/rwXX2q2losnV7A1hu1+taJH6oavduOKD+9mdsGw3lGboFtB4qY+YAFJ1kNrpZ
	 ngP5pkWu/3HpS9aMnV1wyM4ZlMkVsr3pkbB+FQ8CCg4poAl7Uj4111ehEwLW7wWMF7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Mz4A0EINz7FXiOtg+LRLaTUicVm3TZtwZy9VYgokgFo=;
	b=FWQex02e0JniDZyF2dCxHtIwFanAdaKQ7fhtqMJJMas/nmYVXI3iHtXDrOBcbWnMQPCs
	 DZY2p4TdikhcQVNZqHywUqEBlYPRnTy7T0Gkf9DgPet1WSha/W26bLkx1p2GXRvZPf67O
	 mQmVLReecaQvUWqYXle+11bvuGm5bnUit7d7MJm2AEc3jFZ0Y//nYsNfqaURfIl5BrR0B
	 o5G07Xz/Y1m5x2MPd+JopZjJ1PZp68+Ly5oJ4c9DaPwQgQ5pWMRFIN7EqnNgLGEbPZ40r
	 f+OMOb08TUuHVnyYVC5tfq5AgnU6wyrdVQVBmKdyL9ulo+gcUrz3rfYKSLGTRRYL/uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SUssqRtz;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE87606D6AD
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE87606D6AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SUssqRtz
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b42827bb4bso1152548a12.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 21:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286943; x=1794891743; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mz4A0EINz7FXiOtg+LRLaTUicVm3TZtwZy9VYgokgFo=;
        b=SUssqRtzsLLal8qsXM4D0yz2fC/DRSWB5A4fkK1a3WL0E8T/bezz69ivCHNCwB2fzZ
         GYTrEf6tFzqzIXWZNXVgo/EaGZDQ4m+qPRczHwRnaoa3YA+lsyYC4uw3dJ3s0yywHVng
         rZRbqoe35ab3LTv11IgcUtyR/fIEOzD2tEUzFyGdTXyH7rURK8xaemiQoevE2aped/rC
         6SXordgp3968TGlgW0fT9M9VdZt4sTwLQqKtzCzkv1MBGPXLRlfGuDYJcyfEXl+1sFtZ
         ffcGBre5Xh7g+iYKYsToGuGfGfFYwMPjjgzqnS9bTgR/z+QwBKenDh4eYrLFeFU00nRE
         WcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286943; x=1794891743;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mz4A0EINz7FXiOtg+LRLaTUicVm3TZtwZy9VYgokgFo=;
        b=cUzI9V+II+CpuFeyYmkd6xuVaFbuoWFUKN90mzP2xlmPgqw21SBjarQB1B25kYfNph
         iRlH30E2i+tbIaNaF7IMq3G7Denw94MBM8ggnePhX599IbboTnAaZGjspQIyqLV7uDqj
         XlivdOWJQxkgYSjYTiDZ9dsktWNcst+6px6O63bk2wgVWVWQf02LQvLAje67hMjXeYi0
         1eSXzChJalr8GYBIaaIZrEjpZ1H85cvoSqCgSXTJAoxJv0xjjPNnOabFhMl5uQ6NnAET
         ULjWHvJBTFZT0Irnfe1xJ5NJz6cVthnNuzAofpxqM3WvizN5z6BCBgTpiEA+dQJTgpSq
         8S1A==
X-Forwarded-Encrypted: i=1; AL+hErE171xNVwbHiwU4UKv1xhfubVfViGL+md0EmyfSVu5IfpnouhT2wuwc6LDXvLAAU6bASIKWEg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+hUKwuICWth25/ujSAToYmXwI0YApN2+qppt7njecwoANw6htw
	QdBaoF3ZYc3VyOaiVUzDQlzCppKD1ynWr5w4dtgqsBZfqX+NMfmsNTfanfDO2KRgBrJIgmv39eK
	nESc+lsZo80B5Tbr2Ug==
X-Received: from edt12.prod.google.com ([2002:a05:6402:454c:b0:6a8:1d4c:399])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ecf:b0:6b5:6522:de39 with SMTP id 4fb4d7f45d1cf-6b756ae247dmr1199083a12.22.1794286943216;
 Mon, 09 Nov 2026 21:02:23 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:59 +0000
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
Message-ID: <20261110050202.529473-17-tarunsahu@google.com>
Subject: [PATCH v4 16/19] PCI: liveupdate: Add feature header to struct pci_dev_ser
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

Precede each serialized PCI device entry in the PCI Live Update KHO block
set with struct kho_ser_hdr via DECLARE_KHO_SER so future per-device PCI
Live Update features can append fields to struct pci_dev_ser without
breaking compatibility between adjacent kernels.

Mark struct pci_dev_ser as 8-byte aligned since its largest member is u32,
initialize the device block sets with kho_ser_size(pci_dev_ser),
initialize each entry feature header in pci_flb_alloc_dev_ser(), and
validate incoming device feature headers in pci_flb_retrieve() before
accessing the struct pci_dev_ser payload.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 drivers/pci/liveupdate.c    | 27 +++++++++++++++++++--------
 include/linux/kho/abi/pci.h |  9 ++++++---
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 0bda94f4a7e4..f4c84bcc0629 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -288,7 +288,7 @@ static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 	ser->devices = 0;
 
 	outgoing->fhdr = fhdr;
-	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
+	kho_block_set_init(&outgoing->block_set, kho_ser_size(pci_dev_ser));
 
 	args->obj = no_free_ptr(outgoing);
 	args->data = virt_to_phys(fhdr);
@@ -318,6 +318,7 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 {
 	DECLARE_KHO_SER_HDR(pci_ser, *fhdr) = phys_to_virt(args->data);
 	struct pci_flb_incoming *incoming;
+	DECLARE_KHO_SER_HDR(pci_dev_ser, *dev_fhdr);
 	struct pci_dev_ser *dev_ser;
 	struct kho_block_set_it it;
 	struct pci_ser *ser;
@@ -338,15 +339,20 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 	incoming->fhdr = fhdr;
 	xa_init(&incoming->xa);
 
-	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
+	kho_block_set_init(&incoming->block_set, kho_ser_size(pci_dev_ser));
 	ret = kho_block_set_restore(&incoming->block_set, ser->devices);
 	if (ret)
 		panic("Failed to restore devices KHO block set (%d)\n", ret);
 
 	kho_block_set_it_init(&it, &incoming->block_set);
-	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
+	while ((dev_fhdr = kho_block_set_it_read_entry(&it))) {
 		unsigned long key;
 
+		ret = kho_ser_validate(dev_fhdr, pci_dev_ser);
+		if (ret)
+			panic("Failed to validate incoming PCI device feature header (%d)\n", ret);
+
+		dev_ser = kho_ser_payload(dev_fhdr, pci_dev_ser);
 		if (!dev_ser->refcount)
 			continue;
 
@@ -456,6 +462,7 @@ static struct pci_flb_outgoing *pci_liveupdate_flb_get_outgoing(void)
 
 static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoing)
 {
+	DECLARE_KHO_SER_HDR(pci_dev_ser, *fhdr);
 	struct pci_dev_ser *dev_ser;
 	struct kho_block_set_it it;
 	u64 count = 0;
@@ -464,9 +471,12 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
 	kho_block_set_it_init(&it, &outgoing->block_set);
 
 	/* Try to find an existing, previously unpreserved, entry. */
-	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
-		if (!dev_ser->refcount)
+	while ((fhdr = kho_block_set_it_read_entry(&it))) {
+		dev_ser = kho_ser_payload(fhdr, pci_dev_ser);
+		if (!dev_ser->refcount) {
+			kho_ser_init(fhdr, pci_dev_ser);
 			return dev_ser;
+		}
 
 		count++;
 	}
@@ -480,11 +490,12 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
 		kho_block_set_it_init(&it, &outgoing->block_set);
 
 	/* This should always succeed since kho_block_set_grow() succeeded. */
-	dev_ser = kho_block_set_it_reserve_entry(&it);
-	if (WARN_ON_ONCE(!dev_ser))
+	fhdr = kho_block_set_it_reserve_entry(&it);
+	if (WARN_ON_ONCE(!fhdr))
 		return ERR_PTR(-ENOSPC);
 
-	return dev_ser;
+	kho_ser_init(fhdr, pci_dev_ser);
+	return kho_ser_payload(fhdr, pci_dev_ser);
 }
 
 static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index f53f6350e53d..77ddf5938822 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -19,7 +19,8 @@
  * File-Lifecycle Bound (FLB) data, identified by the compatible string
  * ``"pci-v2"`` and laid out as described by the structs below.
  *
- * struct pci_ser is preceded by &struct kho_ser_hdr, which records the
+ * Both &struct pci_ser and each &struct pci_dev_ser entry are preceded by
+ * &struct kho_ser_hdr, which records the
  * total size of the serialization and feature flags. See
  * include/linux/kho/abi/feature.h for the feature header layout, feature
  * rules, and validation.
@@ -42,14 +43,16 @@
  *            reference count is equal to the number of preserved devices at or
  *            below it in the PCI hierarchy when the struct pci_dev_ser is in
  *            use, and 0 otherwise.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
 	u16 refcount;
-};
+} __aligned(8);
 
-static_assert(sizeof(struct pci_dev_ser) == 8);
+DECLARE_KHO_SER(pci_dev_ser, 8, 0, 0);
 
 /**
  * struct pci_ser - PCI Subsystem Live Update State
-- 
2.56.0.506.g506a7eabc5-goog

