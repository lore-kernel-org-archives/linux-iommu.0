Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116032;
	b=ORPQAQoA6AqpHwhZBRI6I23OmeDLW1d9wDSp98Moc4h7jqE+PryQLurd/QGUk40O8Ouf
	 Jc240AAZtVqhE8hiUf0pxonUM8nVNcY/cnrPIoQTz0jm/ypn2oMBPoq5IxHy4mPK3sYjs
	 CB+nm0vudgB/wI0pemHDXYpEOhyKSEuDa8E+fTemzSBoj2WDs9D/gR7qCGR/F/O+ZFpXs
	 3ovWGf11GyamjD6HmmBSKQR+Z6Kw6AvY0JoKak2nY6sFtn0UX3LdJUtC2/FdiS58dMI0m
	 XJF5EVdwItmze1ukuiF0T6EiaEQgQsdSQ67mk8/5v6n5UrOltvsxJTiMleb/CGlMrlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d/rRV11tp+2yuBy0nAi8FWDuCnsXGLzbLZWeXfMh4bw=;
	b=h4WwZI/d6I/ZDNsWWdaX4ENQHS62O9jy/wEyoC/LCjowD1ycoVs+R8APnH7s+5hk4xIm
	 mRgB6omHTPJ6g4VUy0LTrITlHzBaMzR9EnrJBsEAgVAmVIdFUJIqbwU8h9+g56PGvkXj5
	 YsDn6JkeJeDQ5Me5Kqd3hUg0kAz+cEQAI28E2iYg+D6qEq/JRAcf8P8YNRRjnX067zO46
	 nSxuRm2+hZRh2sRyqtIT+81Zs8U4y2XuE4I1UizfTFd9NqqvMjvFnmyQMynZSOCTsMt6W
	 9RPgbLL1TZ9EAbsUpMAWWxy+NOS7HZX+p8fboABIM2I3lv5WBy0J4iqk135g+I7C4tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xqnc8jMg;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA152606C818
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA152606C818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xqnc8jMg
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so2584914f8f.3
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116030; x=1793720830; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/rRV11tp+2yuBy0nAi8FWDuCnsXGLzbLZWeXfMh4bw=;
        b=Xqnc8jMgJv4fEASw2U3AHwbkRTieVZWMVsxwcszkNgNifGXxEdjkwGQEIHNyYEA/7B
         mxhN7qzulcQvod5RlzMtqKwXgYkHLy56RYHmrCgMx34MdVt3DNeTD1gqqTvFfrAqM/pQ
         R6aW554gHqMn56kffOZQVia14HlvIJTQ9uDT3oDUun5zmm0FrKAs+fRSpy1hKJdzEBYZ
         RxFukKkh9VmTHsrw6pVnJ5STkVukwl9eJyMrDKKyyYJv41wLZ73gB5Tbb3olb/I9DCRB
         Cv26c66NxFXcCRhx4CYkWDQUr/ydVQDUBYG7gX5ihMvXfSR6EqvmqI2moTqlN0d57slt
         pY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116030; x=1793720830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d/rRV11tp+2yuBy0nAi8FWDuCnsXGLzbLZWeXfMh4bw=;
        b=qwLBzZP3Hny9XZyddw9lqsjvICDsj4hfv6HsUV6jsEFeJ3uVVBeBvDGPS5BehbOzHJ
         6tBaSsk+vBfrmRmRxiM2ofE29XpNm6lAiMWWLqWpzo1lPwHzTEq9OLIni8M+jH4PhzVZ
         BeVQGTDLnJYjArBv+iNE8djHu+2Eic2HTcrrwmeurV5554MeK7HlN5txEdJS5UK1VFlu
         +/QD2EJa+sc9Zqx7OOl/GzIygasfLzXODg/5B/hyWP1T+rbaTAjIqwg1owDMo8p/3u+d
         QK7jJ1bx3zcLX+liqpuPEBRpg8Ddd+Z+az3uca3ZeMtcucIPFYf+ZZHCnALIWQ8k+Y41
         Au+g==
X-Forwarded-Encrypted: i=1; AKwUvBxOi23ZGZTMDuO3O0KHPsKRbSUKp6LPc8R+AUL7YmFDchOrsKG6VPKgJtRmn0vEjAPmhzhuSw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJRgp862wG3oK4qrnNm72xqkB2R5US2UQxriz/sLX75fkZMq/C/
	tT1wZB2ArXQsU3UB5Ni17rny+ID9E4GMsG9VT2X1eugW+MT4Wx8Ncs6M
X-Gm-Gg: AYBFou0Siro4Vn3Yw11pY5mtRddr5tvvutuf5VxZRFmgsID3u3fw6vJwNGDb4VBNAMf
	7JnJPJ1mVevkG2jOM6R8fhlIiVG2F+cAMBb594dC+aWLmEsOZsvwls7xAUO+Zpp/PM1hj8OnC5B
	ij5l0fnwHN5pj7ROjnphI9Gkh7egYVzZGU6cXdHgWMyiIJ5l93m1LtqXLV9teDfG/jSnjfSrDGo
	UjD4VyFKHQFFl5z2xbFSUW//9g1sRR/jY7AlkWjww5F4EYBJMDWe+2d+3haixoRc2I6GG2r2EOy
	Jdb/kzofAT2kQRCKpB8c6CTahcWQcXK2ydDzIJIa8BfnnrzUexsQ4haRTv9tmYI9uo8fZ40pzWX
	ftiSDicr16+YJsNS7rJOKmqIz/MmQfYFkh3GlN1wal2dWtiGAjOdUn4iAiIkuo5MeBI9H6OEQj5
	l1r85R+Y6RVw8TJM6T8G4gSOGZMi/1Qb/GwkWcHMLI4CA6OiH/uZVoEaaK6Dmup9Z3qI9Kxp6Dr
	FfxnjspK9ASCkmENqtLrfixwnMLVmiSBA4GPy6bTAhT2wokgdG5MU+4ZdjjE6iKUfSSSE6PGdbA
	kG+55lbfe/Rry+rFwsgtcdJtkrpLYNvkMThxGpzBCRq3mKjE1WfU5RyA0poH7oq9HYeEmSDQu7k
	35iZx8hZQ0/DIyIiT
X-Received: by 2002:a05:6000:188b:b0:486:f9ea:796f with SMTP id ffacd0b85a97d-48e3eb9ed13mr20773527f8f.41.1793116029637;
        Tue, 27 Oct 2026 08:47:09 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:09 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: [RFC PATCH 07/14] KVM: guest_memfd: Update exports when pages are allocated
Date: Tue, 27 Oct 2026 15:46:42 +0000
Message-ID: <20261027154649.91571-8-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027154649.91571-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

An export maps only the pages that have memory when it looks them up,
and a device cannot fault in the others, so guest_memfd must call
update() when a page gets memory.

Lookups treat a folio that was never zeroed as a hole. Zero folios in
one helper, under the invalidate lock, from the host fault, KVM's
get_pfn() and fallocate(), which did not zero at all, and update the
exports for each folio zeroed. Mark zeroed folios dirty: lookups hold no
reference, and memory-failure handling evicts clean folios that nothing
references.

In PFN mode, update the block that get_pfn() reports when it fills a
hole, since the provider may back all of it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 include/linux/guest_memfd.h | 26 ++++++------
 virt/kvm/guest_memfd.c      | 85 +++++++++++++++++++++++++++++++------
 2 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index 937693ae9573..f8e89723dd68 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -90,13 +90,14 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * nor fault them.  It attaches to the file, looks up the frame behind each
  * shared page without taking a reference, and guest_memfd calls its update()
  * whenever what a lookup returns for a range may have changed: conversions,
- * punch holes, memory failure and a provider's kvm_gmem_revoke().  update()
- * makes the consumer's mappings of the range match what a lookup returns now:
- * a frame, or a hole for a private page or a page without a frame.  It may be
- * called for pages that did not change, and for ranges that do not follow the
- * blocks that lookups report: the consumer may then remap whole blocks, also
- * outside the range, e.g. to merge them into larger mappings.  A consumer that
- * can fault may instead only remove its mappings of the range.
+ * punch holes, memory failure, a provider's kvm_gmem_revoke(), fallocate() and
+ * pages getting their first frame.  update() makes the consumer's mappings of
+ * the range match what a lookup returns now: a frame, or a hole for a private
+ * page or a page without a frame.  It may be called for pages that did not
+ * change, and for ranges that do not follow the blocks that lookups report:
+ * the consumer may then remap whole blocks, also outside the range, e.g. to
+ * merge them into larger mappings.  A consumer that can fault may instead only
+ * remove its mappings of the range.
  *
  * Until update() returns, the frames it replaces stay valid, so a consumer
  * may switch each mapping to its new target in one step; once it returns,
@@ -105,11 +106,12 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * beforehand.
  *
  * guest_memfd calls update() with its invalidate lock held, exclusive when it
- * takes frames away or pages convert and shared on memory failure, possibly
- * with a folio of the file locked; so update() may only call
- * kvm_gmem_export_lookup_pfn().  Under the shared lock, updates may run at the
- * same time, also for overlapping ranges.  The consumer holds a lock across a
- * lookup and the mapping it installs, which update() also takes.  Lock order:
+ * takes frames away or pages convert, and shared when pages only gain frames
+ * and on memory failure, possibly with a folio of the file locked; so update()
+ * may only call kvm_gmem_export_lookup_pfn().  Under the shared lock, updates
+ * may run at the same time, also for overlapping ranges.  The consumer holds a
+ * lock across a lookup and the mapping it installs, which update() also takes.
+ * Lock order:
  *
  *   PFN mode provider lock (across kvm_gmem_revoke())
  *     guest_memfd invalidate lock
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1c5826c5384e..42bb5f263e23 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -286,7 +286,8 @@ static bool kvm_gmem_range_has_attributes(struct inode *inode,
  * There is no backing storage for the memory, so the folio will remain
  * up-to-date until it's removed.
  *
- * Ignore accessed, referenced, and dirty flags.  The memory is
+ * Ignore accessed and referenced flags; the dirty flag only keeps a zeroed
+ * folio in the page cache, see kvm_gmem_folio_zero().  The memory is
  * unevictable and there is no storage to write back to.
  */
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
@@ -430,7 +431,8 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 
 /*
  * What a lookup returns for [start, end) may have changed: exclusive lock when
- * frames were taken away or pages converted, at least shared on memory failure.
+ * frames were taken away or pages converted, at least shared when pages only
+ * gained frames and on memory failure.
  */
 static void kvm_gmem_update_exports(struct inode *inode, pgoff_t start,
 				    pgoff_t end)
@@ -590,6 +592,64 @@ int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_pages,
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_revoke);
 
+/*
+ * Zero a folio on its first use.  Lookups find it from then on, with no
+ * reference held, so mark it dirty: memory-failure handling drops clean
+ * folios that nothing references from the page cache (mapping_evict_folio()).
+ * Called with the folio locked.  Returns true if the folio was zeroed.
+ */
+static bool kvm_gmem_folio_zero(struct folio *folio)
+{
+	if (folio_test_uptodate(folio))
+		return false;
+
+	folio_zero_range(folio, 0, folio_size(folio));
+	folio_mark_uptodate(folio);
+	folio_mark_dirty(folio);
+	return true;
+}
+
+/* Zero a folio on its first use, and tell the exports.  Under the lock. */
+static void kvm_gmem_folio_clear(struct inode *inode, struct folio *folio)
+{
+	if (kvm_gmem_folio_zero(folio))
+		kvm_gmem_update_exports(inode, folio->index, folio_next_index(folio));
+}
+
+/*
+ * get_pfn() in PFN mode, which may back a hole: then tell the exports about
+ * the whole block that get_pfn() reports, as the provider may have backed all
+ * of it.  Called with the invalidate lock held.
+ */
+static int kvm_gmem_pfn_get(struct inode *inode, pgoff_t index,
+			    kvm_pfn_t *pfn, int *max_order, u32 *attrs)
+{
+	pgoff_t npages = i_size_read(inode) >> PAGE_SHIFT;
+	struct gmem_inode *gi = GMEM_I(inode);
+	bool hole = false;
+	unsigned long raw;
+	pgoff_t first;
+	int order, r;
+	size_t nr;
+
+	if (!list_empty(&gi->exports))
+		hole = gi->provider_ops->lookup_pfn_range(gi->provider, index,
+							  &raw, &nr) == -ENOENT;
+
+	r = gmem_provider_get_pfn(gi, index, pfn, &order, attrs);
+	if (r)
+		return r;
+
+	if (hole) {
+		first = round_down(index, 1UL << order);
+		kvm_gmem_update_exports(inode, first,
+					min(first + (1UL << order), npages));
+	}
+	if (max_order)
+		*max_order = order;
+	return 0;
+}
+
 static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -619,7 +679,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 				break;
 			}
 
-			r = gmem_provider_get_pfn(gi, index, &pfn, &max_order, NULL);
+			r = kvm_gmem_pfn_get(inode, index, &pfn, &max_order, NULL);
 			if (r)
 				break;
 
@@ -647,6 +707,8 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 
 		index = folio_next_index(folio);
 
+		/* Zeroed now, so that a device can map it before first use. */
+		kvm_gmem_folio_clear(inode, folio);
 		folio_unlock(folio);
 		folio_put(folio);
 
@@ -819,7 +881,7 @@ static vm_fault_t kvm_gmem_pfn_fault(struct vm_fault *vmf)
 	u32 attrs;
 	int r;
 
-	r = gmem_provider_get_pfn(GMEM_I(inode), vmf->pgoff, &pfn, NULL, &attrs);
+	r = kvm_gmem_pfn_get(inode, vmf->pgoff, &pfn, NULL, &attrs);
 	if (r)
 		return vmf_error(r);
 
@@ -873,6 +935,8 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
 		if (IS_ERR(folio))
 			r = PTR_ERR(folio);
+		else if (!folio_test_large(folio))
+			kvm_gmem_folio_clear(inode, folio);
 	}
 	filemap_invalidate_unlock_shared(inode->i_mapping);
 
@@ -891,11 +955,6 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 		goto out_folio;
 	}
 
-	if (!folio_test_uptodate(folio)) {
-		clear_highpage(folio_page(folio, 0));
-		folio_mark_uptodate(folio);
-	}
-
 	vmf->page = folio_file_page(folio, vmf->pgoff);
 
 out_folio:
@@ -1887,7 +1946,8 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 	}
 
 	if (kvm_gmem_is_pfn_mode(gi)) {
-		r = gmem_provider_get_pfn(gi, index, pfn, max_order, attrs);
+		r = kvm_gmem_pfn_get(file_inode(file), index, pfn, max_order,
+				     attrs);
 		if (r)
 			return ERR_PTR(r);
 		return NULL;
@@ -1903,10 +1963,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 		return ERR_PTR(-EHWPOISON);
 	}
 
-	if (!folio_test_uptodate(folio)) {
-		clear_highpage(folio_page(folio, 0));
-		folio_mark_uptodate(folio);
-	}
+	kvm_gmem_folio_clear(file_inode(file), folio);
 
 	*pfn = folio_file_pfn(folio, index);
 	if (max_order)
-- 
2.47.3

