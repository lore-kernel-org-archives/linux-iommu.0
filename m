Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323020E702;
	Mon,  2 Mar 2026 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412737; cv=none; b=ohx5Y80k+TuAfBzCAgi7Lt3oSv9IjdpoKDiC6vdks1JMMieROQASB+Dvu7vJcgfkBKsVpXgKQlADanbWzDOCjppPKjAsD9BvG698j9NxMudzy6upCDp6as2ECH6/9tIc8vdHT9iNxtuQW7dG0XYG36DMcEi1hSdW2CG7jEjPQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412737; c=relaxed/simple;
	bh=bC2vR9ifrjZc6eBj+IWF1AgtnBUsKzzG3Lc2wWC2N5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N47ocVl64ogxNQnDpOeZAYVI/r9h62gR34SMptYyAydLXvOcHw89aUXhoPC6oDeVU13CuRCF2pbLrC5+H2iu206Kjad5/n/WlvLIAQskZG1JeGrRwCM8LwlScuuOpAOFWzMLoztzBedmp39Iowjj3PpQT53465o00wwtNdtjwlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byvklFmX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byvklFmX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=czYfRHe2VQYfMvy2Qre6JJeW6OQg299AeQ3LrrXs7Ew=; b=byvklFmXKfsJjZc64x1sK5TimJ
	zn5RSuHfQK0Nkd7R+CERu69v9+OwpjYDXuEoTH0gI2kgi86M54KbXKTCQMp0ncSyFf6qIeglnlHFq
	7dAHTuY1ZH2+M7lkes1Y9nGJLyeLoUZNqB3cnMUCt5s4wG1ZEgU9+G6yQBVMDgtZGuyJ6rgYMuPzH
	70IKi6Z4ESq5X/VflWalzzWiGMvGHD3ntV9oWMeXB7icChRxdoMGQSIZdmWvvuBIf2hsT+fFhxEGq
	3Ekwpj6N/GgHea6t/F74T8WzrTTRZjpgNxjAquWlIj7vyBUroWG2iLve1B4Y5WjIn6+9+PLPnipwj
	0re6NdzA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwrWB-0000000C282-0yEF;
	Mon, 02 Mar 2026 00:52:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/io-pgtable: fix all kernel-doc warnings in io-pgtable.h
Date: Sun,  1 Mar 2026 16:52:14 -0800
Message-ID: <20260302005214.3469521-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid kernel-doc warnings in io-pgtable.h:
- use the correct struct member names or kernel-doc format
- add a missing struct member description
- add a missing function return comment section

Warning: include/linux/io-pgtable.h:187 struct member 'coherent_walk' not
 described in 'io_pgtable_cfg'
Warning: include/linux/io-pgtable.h:187 struct member 'arm_lpae_s1_cfg' not
 described in 'io_pgtable_cfg'
Warning: include/linux/io-pgtable.h:187 struct member 'arm_lpae_s2_cfg' not
 described in 'io_pgtable_cfg'
Warning: include/linux/io-pgtable.h:187 struct member 'arm_v7s_cfg' not
 described in 'io_pgtable_cfg'
Warning: include/linux/io-pgtable.h:187 struct member 'arm_mali_lpae_cfg'
 not described in 'io_pgtable_cfg'
Warning: include/linux/io-pgtable.h:187 struct member 'apple_dart_cfg' not
 described in 'io_pgtable_cfg'
Warning: include/linux/io-pgtable.h:187 struct member 'amd' not described
 in 'io_pgtable_cfg'
Warning: include/linux/io-pgtable.h:223 struct member
 'read_and_clear_dirty' not described in 'io_pgtable_ops'
Warning: include/linux/io-pgtable.h:237 No description found for return
 value of 'alloc_io_pgtable_ops'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev

 include/linux/io-pgtable.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- linux-next-20260227.orig/include/linux/io-pgtable.h
+++ linux-next-20260227/include/linux/io-pgtable.h
@@ -53,7 +53,7 @@ struct iommu_flush_ops {
  *                 tables.
  * @ias:           Input address (iova) size, in bits.
  * @oas:           Output address (paddr) size, in bits.
- * @coherent_walk  A flag to indicate whether or not page table walks made
+ * @coherent_walk: A flag to indicate whether or not page table walks made
  *                 by the IOMMU are coherent with the CPU caches.
  * @tlb:           TLB management callbacks for this set of tables.
  * @iommu_dev:     The device representing the DMA configuration for the
@@ -136,6 +136,7 @@ struct io_pgtable_cfg {
 	void (*free)(void *cookie, void *pages, size_t size);
 
 	/* Low-level data specific to the table format */
+	/* private: */
 	union {
 		struct {
 			u64	ttbr;
@@ -203,6 +204,9 @@ struct arm_lpae_io_pgtable_walk_data {
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
  * @pgtable_walk: (optional) Perform a page table walk for a given iova.
+ * @read_and_clear_dirty: Record dirty info per IOVA. If an IOVA is dirty,
+ *			  clear its dirty state from the PTE unless the
+ *			  IOMMU_DIRTY_NO_CLEAR flag is passed in.
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -231,7 +235,9 @@ struct io_pgtable_ops {
  *          the configuration actually provided by the allocator (e.g. the
  *          pgsize_bitmap may be restricted).
  * @cookie: An opaque token provided by the IOMMU driver and passed back to
- *          the callback routines in cfg->tlb.
+ *          the callback routines.
+ *
+ * Returns: Pointer to the &struct io_pgtable_ops for this set of page tables.
  */
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
 					    struct io_pgtable_cfg *cfg,
