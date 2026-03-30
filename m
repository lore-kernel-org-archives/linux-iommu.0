Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9E327C18
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882308; cv=none; b=pf/ruKzUGmCnebhTVKFdLRkVvR49yYX0aXlQsXWQy3rkq0u4NW/hP2vL0vVcSU6tTf8FG+BZYSIcFUQ69ej+AzClncHdoRGRLvLHqVa/BihwRP8rZN+ix+M59AoDdeN7s0/VAiKsUEnKHcgwjtNChMhRI9CmvnjDW9rxhcAV6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882308; c=relaxed/simple;
	bh=AACj5Q1Te+cllukPGpODl/FrzLJ7iqJVyQNdhpktZMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JP78jtiu04Gl6msVQBzRYR7frTJm/rIDqYVbywaw2wxt1e4t13bASksC8MgG1WGEnqbQlUw3ZHfFoCTJb6OfSUvSe74X3zUEx/LX7xU6OSPpcd4oBAnEET2N2REEdBIjeVNskVmf8LWMdLn7PHrT15DFGdumF36Fdl5SUQnv5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGAudXdz; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGAudXdz"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-662f12c2747so5705196a12.3
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774882306; x=1775487106; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU7Mp0JnalK0jHaAyT2ZTi+XzZ8j8BilljX0NIW7h+I=;
        b=MGAudXdzqeudBR3REAOO3cEA7Db4383VJJtk7zz+ifbLZJRC/r1lD+Cbl1uyE7+amT
         i5UDztKcL6AXIH09hZ73QxwlvBBJgcCxv9vMcTN33TuyoUvip2NhmbSylJ+HN0IMdz03
         WGBD2A2XH5sB9eHSVFsdN0oVMZOMBm9Wa6xbzm1dDAS12t7EtkKC1oIlM801/4TcztfP
         IiT2kmueJUaJ8OAULPmk5EMG8onYYRXpIF5PXBlk3a6Uem86cu3LZMqpmJWjcygY1B2O
         5azk/TJeh5dC5VtRpC1AJpC/fyuplpPHAZo+Ej17tnNEgrWnbq0f8jHXieT4c7c5Cb/n
         Clfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882306; x=1775487106;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mU7Mp0JnalK0jHaAyT2ZTi+XzZ8j8BilljX0NIW7h+I=;
        b=amx734yAyVONr7otjbh6Mw+MY+t2V72SisC2+hji0z+Bxn9ZFH55PMdi5x2vwrTot8
         Q9x1egq2diNIeg03WSq9nG7zFfghoKhT5I/FvRvDEWxfjZZf7OKxr1OBFEll4ABqUamo
         wYoc3y9t5hIrNvUxgERJaf01/xZyHwp62sOUa3w4Ud+Vk1nAryutUZtM0kNnstBaDn+S
         L726IydfaKx45v56YGS6dnk8iScbgKe1SYA7aU48vSUHOU7umdKwCpN/BboKvR7WStyd
         YYAcPpv/Af6r9x0JGq6WhGx85LMk+nrqJa1KGJhiNabAHpdCBxtHOl2kIItsDqZBf5iz
         Akzg==
X-Gm-Message-State: AOJu0YyI4vTVLnV/GsctC4rdO8bxf6Cm/ver6RwmB+GTFKX0dqvy8OHw
	Q+od0EbA4F5y0/Rk0stk2TAuEZCSVTEcZfNFcQUKEvKdkY7H4+h/KjpZxtkJGRa8SiwNxkCrHtu
	SB8DE5BdPobZKzUKK41be4Fbd5dSRW51bKT/WtzhFxRkB+KPckg5n3OMoF4CS/uRW6RvtdnD+3U
	Af3yYagLIRpGU6XIRuHXGmVXf4uX1WBq8MrbV5DmFkNgsp6Q==
X-Received: from edeb19.prod.google.com ([2002:a05:6402:2793:b0:66b:62f:dced])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a0d5:b0:66b:aa56:ee5c with SMTP id 4fb4d7f45d1cf-66baa56f065mr3617472a12.28.1774882305564;
 Mon, 30 Mar 2026 07:51:45 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:50:42 +0000
In-Reply-To: <20260330145043.1586623-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330145043.1586623-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260330145043.1586623-5-smostafa@google.com>
Subject: [RFC PATCH v2 4/5] dma-mapping: Refactor memory encryption usage
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

At the moment dma-direct deals with memory encryption in 2 cases
- Pre-decrypted restricted dma-pools
- Arch code through force_dma_unencrypted()

In the first case, the memory is owned by the pool and the decryption
is not managed by the dma-direct.

However, it should be aware of it to use the appropriate phys_to_dma*
and page table prot.

For the second case, it=E2=80=99s the job of the dma-direct to manage the
decryption of the allocated memory.

As there have been bugs in this code due to wrong or missing
checks and there are more use cases coming for memory decryption,
we need more robust checks in the code to abstract the core logic,
so introduce some local helpers:
- dma_external_decryption(): For pages decrypted but managed externally
- dma_owns_decryption(): For pages need to be decrypted and managed
  by dma-direct
- is_dma_decrypted(): To check if memory is decrypted

Note that this patch is not a no-op as there are some subtle changes
which are actually theoretical bug fixes in dma_direct_mmap() and
dma_direct_alloc() where the wrong prot might be used for remap.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a4260689bcc8..1078e1b38a34 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -23,10 +23,27 @@
  */
 u64 zone_dma_limit __ro_after_init =3D DMA_BIT_MASK(24);
=20
+/* Memory is decrypted and managed externally. */
+static inline bool dma_external_decryption(struct device *dev)
+{
+	return is_swiotlb_for_alloc(dev);
+}
+
+/* Memory needs to be decrypted by the dma-direct layer. */
+static inline bool dma_owns_decryption(struct device *dev)
+{
+	return force_dma_unencrypted(dev) && !dma_external_decryption(dev);
+}
+
+static inline bool is_dma_decrypted(struct device *dev)
+{
+	return force_dma_unencrypted(dev) || dma_external_decryption(dev);
+}
+
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
 {
-	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
+	if (is_dma_decrypted(dev))
 		return phys_to_dma_unencrypted(dev, phys);
 	return phys_to_dma(dev, phys);
 }
@@ -79,7 +96,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys=
, size_t size)
=20
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
+	if (!dma_owns_decryption(dev))
 		return 0;
 	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
 }
@@ -88,7 +105,7 @@ static int dma_set_encrypted(struct device *dev, void *v=
addr, size_t size)
 {
 	int ret;
=20
-	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
+	if (!dma_owns_decryption(dev))
 		return 0;
 	ret =3D set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
@@ -203,7 +220,7 @@ static void *dma_direct_alloc_no_mapping(struct device =
*dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	bool allow_highmem =3D !force_dma_unencrypted(dev);
+	bool allow_highmem =3D !dma_owns_decryption(dev);
 	bool remap =3D false, set_uncached =3D false;
 	struct page *page;
 	void *ret;
@@ -213,7 +230,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		gfp |=3D __GFP_NOWARN;
=20
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	    !is_dma_decrypted(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
=20
 	if (!dev_is_dma_coherent(dev)) {
@@ -247,7 +264,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || dma_owns_decryption(dev)) &&
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
=20
@@ -272,7 +289,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot =3D dma_pgprot(dev, PAGE_KERNEL, attrs);
=20
-		if (force_dma_unencrypted(dev))
+		if (is_dma_decrypted(dev))
 			prot =3D pgprot_decrypted(prot);
=20
 		/* remove any dirty cache lines on the kernel alias */
@@ -314,7 +331,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	unsigned int page_order =3D get_order(size);
=20
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	    !is_dma_decrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -362,7 +379,7 @@ struct page *dma_direct_alloc_pages(struct device *dev,=
 size_t size,
 	struct page *page;
 	void *ret;
=20
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if (dma_owns_decryption(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
=20
 	page =3D __dma_direct_alloc_pages(dev, size, gfp, false);
@@ -530,7 +547,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_=
struct *vma,
 	int ret =3D -ENXIO;
=20
 	vma->vm_page_prot =3D dma_pgprot(dev, vma->vm_page_prot, attrs);
-	if (force_dma_unencrypted(dev))
+	if (is_dma_decrypted(dev))
 		vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
=20
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
--=20
2.53.0.1185.g05d4b7b318-goog

