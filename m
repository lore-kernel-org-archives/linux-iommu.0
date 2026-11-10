Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286948;
	b=zy4G3sSo+bDAOPQ8rfh9O/ciLTCBJr+9TigECe8rGO31XvyKH6r2be7yhcIEMA2S5eNC
	 lY5Dbdy1fkPjtJHvv0C2oTUUWovXJzNEWj11QwOdq4SCW2eXXHtJVnbSm7WQXUNpnNx7b
	 24Ecs/UKTUef5kUvbOBew4nMcf9ng7wUetqNdiqse5NiXQMwuafzhOqeelWe/VQOgBAUo
	 YwiO0LmGiIdtF5qb6HMHBTXy0sESZ3KxA+VE3D/5eyBPwu5LSjSkSNFSApRmVl6Qsd81G
	 RuLPQnY5/PvXL+OC2D2qiYRgUFeRNkv79ht/jGCl+ttEMfcOppCtk827EmkT+FYA5Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=;
	b=JKZ/eVLkQA1nR5VRA8QDkmE3mcPqVcEA/iuItZR+g16QydkNZxZYBCry8IRxgwZSNyIP
	 jZYr6pjLE45+iAwjBy+weL0IvAEFFJGZFr7Ar4zQCK3WyPi15SjvxCeU4jM+sBY3gbh8u
	 IK1kUsZdL9CYCzT99jgldVC42f5IRrCIxIo0kbBfKrdYUTwca3346LC/xRNWFxeix2vnb
	 e/WeBsrmN3o+BtfbxlkUzVzAf3wZLEq5rsWuPEql65tPTnscqTQXUUDtWgLycFXiRPAbx
	 1oUk8lRdhKD8U78jDoE7v4lQZGPzNLh1mpDibwYOKwfk4A3Zh93eDyLPwqRnGXDhOag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bbTpyLWe;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65530606E4BB
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65530606E4BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bbTpyLWe
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b586d1266dso1491842a12.2
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 21:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286946; x=1794891746; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=;
        b=bbTpyLWe4ncO6SilnTNzZSfZp7cY3S5wDIwfnScgk44nw6V3NkofH3ah8jmmB+oNNt
         TIhmGZBGSCxtaU2ThGuZrP2zanyCRT7gSE05Wejk8qK45fX4fBHLfIdFFojplV9SxevV
         S3ZkL7/OBrN2l/4MNGn14p6oYez4X7LXkoNEWJdicPG7yE31NZVmDVLe4TqFeyJF9ahx
         vrjJXzm2LeSuydeXPN0CZaVS3B2fWpE3vfmddZ9NWs/YDrWwlNiom756xK1wfZvMhtAL
         +x3LP+stvCG+EeW85xZyP9jfY38a10fs4+h6Hhypzxcxo8PCE/zMPMHdBG+RqlIJGX6l
         cZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286946; x=1794891746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=;
        b=WqDZUN/Y58Vzf3ABhhcwz7U4AgfSaeLTMCKHRX0tBBIi5qlOaOuQJebtAX++oLV2M0
         LP6xO6yhSg267CtSgbyiUMu/Kqt363FZlNtZnWnEHTewbmGAdIDtGEGr9W0AqXWl6eO8
         huwmY1msUe+hp6YBQMq7pJl6aRva16/uW6MF4/WiIZGwvj2UZXxp6gs7FTmg7uzeTeWM
         QoCKfABz99JndgumW1pedH7ZtjcBk7sPHXEsAgInygO7BQP/4SYslQ7/rIAgyk2+up2a
         N3bBnJ2IxHVRxYtzywKCslozMUXug4rXSLb4gXbSEF5b11zCeBxP4Pratr8Zl5CRK8eN
         NywA==
X-Forwarded-Encrypted: i=1; AL+hErHn6/kfm4B4IYZ9K8QYqRLmWI9E3L51jT9RJX8VWrugGYVoFviqqEoRZV3sCBljRb9PQQcWbQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+vDQ/cI6C6Udl5ppaCemzVPjtMb/YiLLG77qIxI5bSljJIY/PW
	dXASbgSKtMJIPf6AAOYRqbH2Xc8BdogFI9CjAX8M7dOTDrW4jdnTfPa2s9DDXWtKNj7tq3tml97
	P/SEDJslfzNBz2UAG8A==
X-Received: from edqu26.prod.google.com ([2002:aa7:d89a:0:b0:6b7:37e3:4968])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2422:b0:6b7:dc8:c824 with SMTP id 4fb4d7f45d1cf-6b756b08c35mr1192059a12.42.1794286944980;
 Mon, 09 Nov 2026 21:02:24 -0800 (PST)
Date: Tue, 10 Nov 2026 05:02:01 +0000
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
Message-ID: <20261110050202.529473-19-tarunsahu@google.com>
Subject: [PATCH v4 18/19] mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
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

Precede each serialized folio entry in the preserved memfd folio array
with struct kho_ser_hdr via DECLARE_KHO_SER so future per-folio memfd
features can append fields to struct memfd_luo_folio_ser without breaking
compatibility between adjacent kernels.

Allocate the preserved folio array using kho_ser_size(memfd_luo_folio_ser)
per entry and initialize each entry feature header in
memfd_luo_preserve_folios(). On the incoming path in
memfd_luo_discard_folios() and memfd_luo_retrieve_folios(), validate each
entry feature header with kho_ser_validate() and advance between entries
using fhdr->size so entries written with a different feature layout are
traversed accurately.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/memfd.h |  6 ++--
 mm/memfd_luo.c                | 66 +++++++++++++++++++++++++----------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 27f8880ee593..1aad47ce7322 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -51,6 +51,8 @@
  * @pfn:       The page frame number of the folio.
  * @flags:     Flags to describe the state of the folio.
  * @index:     The page offset (pgoff_t) of the folio within the original file.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct memfd_luo_folio_ser {
 	u64 pfn:52;
@@ -58,9 +60,7 @@ struct memfd_luo_folio_ser {
 	u64 index;
 };
 
-static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct memfd_luo_folio_ser) == 8);
+DECLARE_KHO_SER(memfd_luo_folio_ser, 16, 0, 0);
 
 /*
  * The set of seals this version supports preserving. If support for any new
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 94510f73a606..c00daa8a508e 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -86,10 +86,10 @@
 
 static int memfd_luo_preserve_folios(struct file *file,
 				     struct memfd_luo_ser *ser,
-				     struct memfd_luo_folio_ser **out_folios_ser)
+				     DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, **out_folios_ser))
 {
 	struct inode *inode = file_inode(file);
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	unsigned int max_folios;
 	long i, size, nr_pinned;
 	struct folio **folios;
@@ -138,14 +138,16 @@ static int memfd_luo_preserve_folios(struct file *file,
 	}
 	nr_folios = nr_pinned;
 
-	folios_ser = vcalloc(nr_folios, sizeof(*folios_ser));
+	folios_ser = vcalloc(nr_folios, kho_ser_size(memfd_luo_folio_ser));
 	if (!folios_ser) {
 		err = -ENOMEM;
 		goto err_unpin;
 	}
 
 	for (i = 0; i < nr_folios; i++) {
-		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) =
+			(void *)folios_ser + i * kho_ser_size(memfd_luo_folio_ser);
+		struct memfd_luo_folio_ser *pfolio;
 		struct folio *folio = folios[i];
 
 		err = kho_preserve_folio(folio);
@@ -195,6 +197,8 @@ static int memfd_luo_preserve_folios(struct file *file,
 
 		folio_unlock(folio);
 
+		kho_ser_init(fhdr, memfd_luo_folio_ser);
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		pfolio->pfn = folio_pfn(folio);
 		pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
 		pfolio->index = folio->index;
@@ -228,7 +232,7 @@ static int memfd_luo_preserve_folios(struct file *file,
 }
 
 static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr),
-					struct memfd_luo_folio_ser *folios_ser,
+					const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 					u64 nr_folios)
 {
 	long i;
@@ -239,7 +243,10 @@ static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios
 	kho_unpreserve_vmalloc(folios_fhdr);
 
 	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) =
+			(const void *)folios_ser + i * kho_ser_size(memfd_luo_folio_ser);
+		const struct memfd_luo_folio_ser *pfolio =
+			kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		struct folio *folio;
 
 		if (!pfolio->pfn)
@@ -277,7 +284,7 @@ memfd_luo_ser_init(DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr))
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	int err = 0, seals;
@@ -384,16 +391,23 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 }
 
-static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_ser,
+static void memfd_luo_discard_folios(const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 				     u64 nr_folios)
 {
+	const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) = folios_ser;
 	u64 i;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+	for (i = 0; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		struct folio *folio;
 		phys_addr_t phys;
 
+		if (kho_ser_validate(fhdr, memfd_luo_folio_ser)) {
+			pr_warn("invalid folio feature header, folios not discarded\n");
+			return;
+		}
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -411,7 +425,7 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
@@ -447,9 +461,10 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 }
 
 static int memfd_luo_retrieve_folios(struct file *file,
-				     struct memfd_luo_folio_ser *folios_ser,
+				     const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 				     u64 nr_folios)
 {
+	const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) = folios_ser;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
@@ -457,12 +472,20 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	int err = -EIO;
 	long i;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+	for (i = 0; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		phys_addr_t phys;
 		u64 index;
 		int flags;
 
+		err = kho_ser_validate(fhdr, memfd_luo_folio_ser);
+		if (err) {
+			pr_err("memfd_luo_folio_ser feature validation failed: %pe\n",
+			       ERR_PTR(err));
+			goto put_folios;
+		}
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -472,7 +495,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 			pr_err("Unable to restore folio at physical address: %llx\n",
 			       phys);
 			err = -EIO;
-			goto put_folios;
+			goto next_put_folios;
 		}
 		index = pfolio->index;
 		flags = pfolio->flags;
@@ -524,15 +547,22 @@ static int memfd_luo_retrieve_folios(struct file *file,
 unlock_folio:
 	folio_unlock(folio);
 	folio_put(folio);
+next_put_folios:
+	i++;
+	fhdr = (const void *)fhdr + fhdr->size;
 put_folios:
 	/*
 	 * Note: don't free the folios already added to the file. They will be
 	 * freed when the file is freed. Free the ones not added yet here.
 	 */
-	for (long j = i + 1; j < nr_folios; j++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
+	for (; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		phys_addr_t phys;
 
+		if (kho_ser_validate(fhdr, memfd_luo_folio_ser))
+			break;
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -549,7 +579,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	struct file *file;
-- 
2.56.0.506.g506a7eabc5-goog

