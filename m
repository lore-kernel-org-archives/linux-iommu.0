Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE939364927;
	Mon, 23 Mar 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297253; cv=none; b=QiALbkXp2B6NcPv3yNfMKPD0OF/UTMJMByurI2t09/6B2DsIi3g0ouHkWuP3tGcMh7D2gib+2jOtLeYkxd1EJ7qg57+seQgMfV0PTRoKG/q7J6XTYMEGwK/dVLAhTZ5flbMRslL+ty1FrIKY5n59dypFRzH6wElHwdDDQtdW3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297253; c=relaxed/simple;
	bh=4V0rUPFg+PlacrcySkEqbCBvm3s6ZnPbzsKpYhUGN+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gyIGUFYvke6+6ynlXMm5pPjZh8b6cZfLU6loRlKSJI8i8G1CbbfbzQRvFBwYy7L+T2BI/HkKmNA7vwusid8OtKwZZnNUleeilqPl124w2whGBhh2uJIFUt9osyAzvbXj5eXXxKN9IYOi9A7htir3KnDSSvDToqIQssYmQmVzoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGkDccqF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGkDccqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37F7C4CEF7;
	Mon, 23 Mar 2026 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774297253;
	bh=4V0rUPFg+PlacrcySkEqbCBvm3s6ZnPbzsKpYhUGN+0=;
	h=From:To:Cc:Subject:Date:From;
	b=aGkDccqFuU8pvU9q1E6EE6iIjTLieHOtln5HvKivaiefGHxQ8oJBVzrbic5OQF6cT
	 hOIJjN1YOjU/Ukb1EqOy2HmtVWhH2XmNpfmAyQHDa5RrljhbKW2z9JXfFitMRhlciU
	 iHEmEGVbdmXZ69ZCa15n5OnO4XjJHfRy0ZKdrHZXm4LligB9uKUDzvUop16T44h55I
	 9cv1otrAn0AH1DCRwVEhx7Ys695z7104LiHj3/Cgtd5YmIlInHWe+nujlBgeyx22mL
	 ijrblMx3bB6E1oGTVRLPqanG6YLGgTTPTZNLEZDgXa3NJuW0A2i/rtIzxvpNNxyKJR
	 7GCIiHSGLe9vQ==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: ensure mappings are created and released with matching attributes
Date: Mon, 23 Mar 2026 22:20:37 +0200
Message-ID: <20260323-dma-attrs-debug-v1-1-6275228ca300@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260323-dma-attrs-debug-85e282d6f3bb
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
The DMA API expects that callers use the same attributes when mapping=0D
and unmapping. Add tracking to verify this and catch mismatches.=0D
=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 kernel/dma/debug.c | 62 +++++++++++++++++++++++++++++++++++++-------------=
----=0D
 1 file changed, 43 insertions(+), 19 deletions(-)=0D
=0D
---=0D
Marek,=0D
=0D
This patch is based on f5ebf241c407 ("mm/hmm: Indicate that HMM requires DM=
A coherency"),=0D
just to minimize merge conflicts, but it is definitely for -next. If the=0D
patch is ok and that f5ebf241c407 commit won't be backmerged to -next, I ca=
n resend=0D
it in next cycle. This debug aid helped me to see this case:=0D
https://lore.kernel.org/all/20260323-umem-dma-attrs-v1-1-d6890f2e6a1e@nvidi=
a.com/=0D
=0D
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c=0D
index 0677918f06a80..6e5e69b8bc4d8 100644=0D
--- a/kernel/dma/debug.c=0D
+++ b/kernel/dma/debug.c=0D
@@ -63,7 +63,7 @@ enum map_err_types {=0D
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg=0D
  * @paddr: physical start address of the mapping=0D
  * @map_err_type: track whether dma_mapping_error() was checked=0D
- * @is_cache_clean: driver promises not to write to buffer while mapped=0D
+ * @attrs: dma attributes=0D
  * @stack_len: number of backtrace entries in @stack_entries=0D
  * @stack_entries: stack of backtrace history=0D
  */=0D
@@ -78,7 +78,7 @@ struct dma_debug_entry {=0D
 	int		 sg_mapped_ents;=0D
 	phys_addr_t	 paddr;=0D
 	enum map_err_types map_err_type;=0D
-	bool		 is_cache_clean;=0D
+	unsigned long    attrs;=0D
 #ifdef CONFIG_STACKTRACE=0D
 	unsigned int	stack_len;=0D
 	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];=0D
@@ -478,6 +478,9 @@ static int active_cacheline_insert(struct dma_debug_ent=
ry *entry,=0D
 				   bool *overlap_cache_clean)=0D
 {=0D
 	phys_addr_t cln =3D to_cacheline_number(entry);=0D
+	bool is_cache_clean =3D entry->attrs &=0D
+			      (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |=0D
+			       DMA_ATTR_REQUIRE_COHERENT);=0D
 	unsigned long flags;=0D
 	int rc;=0D
 =0D
@@ -495,12 +498,15 @@ static int active_cacheline_insert(struct dma_debug_e=
ntry *entry,=0D
 	if (rc =3D=3D -EEXIST) {=0D
 		struct dma_debug_entry *existing;=0D
 =0D
-		active_cacheline_inc_overlap(cln, entry->is_cache_clean);=0D
+		active_cacheline_inc_overlap(cln, is_cache_clean);=0D
 		existing =3D radix_tree_lookup(&dma_active_cacheline, cln);=0D
 		/* A lookup failure here after we got -EEXIST is unexpected. */=0D
 		WARN_ON(!existing);=0D
 		if (existing)=0D
-			*overlap_cache_clean =3D existing->is_cache_clean;=0D
+			*overlap_cache_clean =3D=0D
+				existing->attrs &=0D
+				(DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |=0D
+				 DMA_ATTR_REQUIRE_COHERENT);=0D
 	}=0D
 	spin_unlock_irqrestore(&radix_lock, flags);=0D
 =0D
@@ -544,12 +550,13 @@ void debug_dma_dump_mappings(struct device *dev)=0D
 			if (!dev || dev =3D=3D entry->dev) {=0D
 				cln =3D to_cacheline_number(entry);=0D
 				dev_info(entry->dev,=0D
-					 "%s idx %d P=3D%pa D=3D%llx L=3D%llx cln=3D%pa %s %s\n",=0D
+					 "%s idx %d P=3D%pa D=3D%llx L=3D%llx cln=3D%pa %s %s attrs=3D0x%lx\n=
",=0D
 					 type2name[entry->type], idx,=0D
 					 &entry->paddr, entry->dev_addr,=0D
 					 entry->size, &cln,=0D
 					 dir2name[entry->direction],=0D
-					 maperr2str[entry->map_err_type]);=0D
+					 maperr2str[entry->map_err_type],=0D
+					 entry->attrs);=0D
 			}=0D
 		}=0D
 		spin_unlock_irqrestore(&bucket->lock, flags);=0D
@@ -575,14 +582,15 @@ static int dump_show(struct seq_file *seq, void *v)=0D
 		list_for_each_entry(entry, &bucket->list, list) {=0D
 			cln =3D to_cacheline_number(entry);=0D
 			seq_printf(seq,=0D
-				   "%s %s %s idx %d P=3D%pa D=3D%llx L=3D%llx cln=3D%pa %s %s\n",=0D
+				   "%s %s %s idx %d P=3D%pa D=3D%llx L=3D%llx cln=3D%pa %s %s attrs=3D=
0x%lx\n",=0D
 				   dev_driver_string(entry->dev),=0D
 				   dev_name(entry->dev),=0D
 				   type2name[entry->type], idx,=0D
 				   &entry->paddr, entry->dev_addr,=0D
 				   entry->size, &cln,=0D
 				   dir2name[entry->direction],=0D
-				   maperr2str[entry->map_err_type]);=0D
+				   maperr2str[entry->map_err_type],=0D
+				   entry->attrs);=0D
 		}=0D
 		spin_unlock_irqrestore(&bucket->lock, flags);=0D
 	}=0D
@@ -594,16 +602,14 @@ DEFINE_SHOW_ATTRIBUTE(dump);=0D
  * Wrapper function for adding an entry to the hash.=0D
  * This function takes care of locking itself.=0D
  */=0D
-static void add_dma_entry(struct dma_debug_entry *entry, unsigned long att=
rs)=0D
+static void add_dma_entry(struct dma_debug_entry *entry)=0D
 {=0D
+	unsigned long attrs =3D entry->attrs;=0D
 	bool overlap_cache_clean;=0D
 	struct hash_bucket *bucket;=0D
 	unsigned long flags;=0D
 	int rc;=0D
 =0D
-	entry->is_cache_clean =3D attrs & (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |=
=0D
-					 DMA_ATTR_REQUIRE_COHERENT);=0D
-=0D
 	bucket =3D get_hash_bucket(entry, &flags);=0D
 	hash_bucket_add(bucket, entry);=0D
 	put_hash_bucket(bucket, flags);=0D
@@ -612,9 +618,10 @@ static void add_dma_entry(struct dma_debug_entry *entr=
y, unsigned long attrs)=0D
 	if (rc =3D=3D -ENOMEM) {=0D
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");=0D
 		global_disable =3D true;=0D
-	} else if (rc =3D=3D -EEXIST &&=0D
-		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&=0D
-		   !(entry->is_cache_clean && overlap_cache_clean) &&=0D
+	} else if (rc =3D=3D -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&=0D
+		   !(attrs & (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |=0D
+			      DMA_ATTR_REQUIRE_COHERENT) &&=0D
+		     overlap_cache_clean) &&=0D
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&=0D
 		     is_swiotlb_active(entry->dev))) {=0D
 		err_printk(entry->dev, entry,=0D
@@ -1066,6 +1073,19 @@ static void check_unmap(struct dma_debug_entry *ref)=
=0D
 			   type2name[entry->type]);=0D
 	}=0D
 =0D
+	/*=0D
+	 * This may be no bug in reality - but DMA API is still expects=0D
+	 * that entry is unmapped with same attributes as it was mapped.=0D
+	 */=0D
+	if (ref->attrs !=3D entry->attrs) {=0D
+		err_printk(ref->dev, entry,=0D
+			   "device driver frees "=0D
+			   "DMA memory with different attributes "=0D
+			   "[device address=3D0x%016llx] [size=3D%llu bytes] "=0D
+			   "[mapped with 0x%lx] [unmapped with 0x%lx]\n",=0D
+			   ref->dev_addr, ref->size, entry->attrs, ref->attrs);=0D
+	}=0D
+=0D
 	hash_bucket_del(entry);=0D
 	put_hash_bucket(bucket, flags);=0D
 =0D
@@ -1249,6 +1269,7 @@ void debug_dma_map_phys(struct device *dev, phys_addr=
_t phys, size_t size,=0D
 	entry->size      =3D size;=0D
 	entry->direction =3D direction;=0D
 	entry->map_err_type =3D MAP_ERR_NOT_CHECKED;=0D
+	entry->attrs     =3D attrs;=0D
 =0D
 	if (!(attrs & DMA_ATTR_MMIO)) {=0D
 		check_for_stack(dev, phys);=0D
@@ -1257,7 +1278,7 @@ void debug_dma_map_phys(struct device *dev, phys_addr=
_t phys, size_t size,=0D
 			check_for_illegal_area(dev, phys_to_virt(phys), size);=0D
 	}=0D
 =0D
-	add_dma_entry(entry, attrs);=0D
+	add_dma_entry(entry);=0D
 }=0D
 =0D
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)=0D
@@ -1344,10 +1365,11 @@ void debug_dma_map_sg(struct device *dev, struct sc=
atterlist *sg,=0D
 		entry->direction      =3D direction;=0D
 		entry->sg_call_ents   =3D nents;=0D
 		entry->sg_mapped_ents =3D mapped_ents;=0D
+		entry->attrs          =3D attrs;=0D
 =0D
 		check_sg_segment(dev, s);=0D
 =0D
-		add_dma_entry(entry, attrs);=0D
+		add_dma_entry(entry);=0D
 	}=0D
 }=0D
 =0D
@@ -1439,8 +1461,9 @@ void debug_dma_alloc_coherent(struct device *dev, siz=
e_t size,=0D
 	entry->size      =3D size;=0D
 	entry->dev_addr  =3D dma_addr;=0D
 	entry->direction =3D DMA_BIDIRECTIONAL;=0D
+	entry->attrs     =3D attrs;=0D
 =0D
-	add_dma_entry(entry, attrs);=0D
+	add_dma_entry(entry);=0D
 }=0D
 =0D
 void debug_dma_free_coherent(struct device *dev, size_t size,=0D
@@ -1584,8 +1607,9 @@ void debug_dma_alloc_pages(struct device *dev, struct=
 page *page,=0D
 	entry->size      =3D size;=0D
 	entry->dev_addr  =3D dma_addr;=0D
 	entry->direction =3D direction;=0D
+	entry->attrs     =3D attrs;=0D
 =0D
-	add_dma_entry(entry, attrs);=0D
+	add_dma_entry(entry);=0D
 }=0D
 =0D
 void debug_dma_free_pages(struct device *dev, struct page *page,=0D
=0D
---=0D
base-commit: f5ebf241c407dbf629fcf515015e139fcea2c2f0=0D
change-id: 20260323-dma-attrs-debug-85e282d6f3bb=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D
