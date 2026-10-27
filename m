Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116027;
	b=a5EqMF5b6eBE+g2Qn/xGo/5WQt2t6ugkxANdAaLLyrgZhVCc5rxgdRpipERIjgjQFH98
	 qHD/ugo6T6RKxabIpi25Pq3q5H8o73yJ7ygz0u0AL0j6UQih6gACEaMPu3EY+66vtnwHb
	 VCMKcjHdo34xoDCZfO8chR9gky9TgQguHfIlOHeIvDFGF0baKaSZ+n+3Yi47Ji6NYuChu
	 Ed6bmGbvmroQB2PIWm7ZptZJSU/F89j5jhShB4UOS7NpaY5x/Zrk47AAKAkZLHT4EWGe/
	 BqH3oSubNxw7sYVkdCDcR9nqmbxqhUE4mLfhkAy75ZSnEo312mXPtGHmVWue43AfU5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XmHIaCziVnimE5Tmq06/pKlKxzGziqQCKkgGCcdE51k=;
	b=TSbyrNY2PvvvZ+YY3zpux31D8ROlVzujnlER1Vi/9FxiQ8RTc0IEkqzpydFZbWMjeDsD
	 P6WMMNyxampU8BJ4FG943x2ElvDlppCXS+JkZsm3n7Jn49oT+MtmQmpVnW0jnVoIuRPOe
	 wQQ9Fh7n25IGXtr4s2bdKgaFirr1Wy7rftwnAr71iItkGafciCCrMXVNLHbIShtq4Hr1S
	 8IDGzSwieBJzJSijYYBxXs8twv29GjHqt2JDD7Rr4emV4reVVbZCmq+XTOwLoHts/BUuQ
	 YJpR3A4VhudAjzfpVB5SkuOSASa9hIEs9NZQb68wjbF8L4UHs4EPfuWHc+et6lkhb+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0PlF5u1;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FF60A2610
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618FF60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0PlF5u1
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e3b22e971so2074355f8f.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116025; x=1793720825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XmHIaCziVnimE5Tmq06/pKlKxzGziqQCKkgGCcdE51k=;
        b=L0PlF5u18hRtq/LcQAA/Jp7Et1b52OODCyHoLxo61LejGpBRUx9yQnfKo5RFrzQbph
         Cl3pebPuDYC/WIqC9T1n1fQIRCQOViOX2xz3MSDK84eYnQdmJ/MtLBOJc7g+mhb0C04D
         ObUi56IwrEGSUDShfpsj5yIq7FV/WiV5sGat9nrs/TyyMMgelIBc/Dis550rfAV15nKp
         zOTJDbFRXaGA3b4/0WYvcld5PgE95ZevpHgi5K5gkLDk/FBUtK/Log0u81x5l4O4Z+Jz
         2B6IRZO1XradJYajA5W1+5y08MqbnwVbBwlCJC2rqF7vOWKxefyJj2/Di1MfNG5xae+G
         FQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116025; x=1793720825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XmHIaCziVnimE5Tmq06/pKlKxzGziqQCKkgGCcdE51k=;
        b=gy0pqpsdvRUvWEvYckU1/j2iHBeUG2xJM1Pedi5OLkgWwajLYEPXLmoi9kU+Mw/HDp
         qD0VtmRDrqHOX0XWqkabl6Ih18ZkqJPdiFOvAA34ttWUyTseQTHThkEMLvzPvRY/L4Zi
         yefgmdgW1wDxBGkmBSDMfCBnqGZoqGEh1tlBN4PR6Rucm5Fh4jmPoR3RTs86byXnrrEX
         8eQQqm7XcAW8+vqm7bUq7q1H3/b0+8cMglS97Y3G653qTYAzdDs8Caa52twiumhaqdiA
         oFvkDTfuOJyB05ujz01eShDS8MY+Ny4OMBw4hNCL9lZC8iE36h0/iFTlL6ZT/xUBOBPF
         niyw==
X-Forwarded-Encrypted: i=1; AKwUvBzJNIfNHqORDhRT9I9KMLPHI8Jlk5bZ2LxokAGDN7IKfS7MBlfctqJ71tWP55cHDHyeKC07PA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJl/m+R32RhwmIudsMpOY6veQpquTeWm9uSh4mJjQRbseqPmrZP
	aJmJyG50QpbIDi+RRKwkREIR5SP0qMv8wBpGXwgMtd79TwY0lCW3Vj7H
X-Gm-Gg: AYBFou0RPatvpmmrJChHA95HkeoeGvQsH+jxm4JpdVi6jql5vIpjchVBU4Rw8gyi9vE
	yxbxqULiJCrQHm9UZFsz8BGEjw/RqYyJgP1oLAmlVEhPfwq0pgGLTO8DxKXo9kXuSs81k4CC45C
	wtUul4UU8/bXlITWk1w8FMgAW0bYYdOzKXOikoFgOwGnwYZDLwi0XmnUjEmCFKi9Cxj39LqOE6p
	hCkgib2aArbJSj5zCj63AIAA2HpCob1kLoZD7YTCLt0GqWx9GGNWdrhrXYnxGoOZAjEAYKiGRA+
	1PfUa2P6AXDftBcRQGYo0WDEzpGmrqchuW2Cc34suExtW0vj1R97DKhRWD8FpyLNyoqS1jIAA02
	jQ1GEDEAQrZooK07J0PXQJqeDkTbUQt2zp1tCtzbXP2RKdPSUQHrOQ45eoE2Eey2lyiD+aJEBfC
	DJzLUL7N1iGzZ+kzaKV6FbSihBQvZ8n9H3q40T0gPX/UU2axjhhTt5MSC8uFwDGOgiAOR2Mps4E
	ieaHK5uqdA47vdSX1iHUXHoDhNBUxkujfs9nOPWDm4Sv90lyX4NZWNYDBw13Q/lKc5+vrFZsYe4
	0trh2/XaxPl9jspeIe9UUd0fjV4vfrnlaHsky34nD/FZLWU4cvEkKiW3N0cky8nUKBLQAskP7zC
	NYROqd0VhGp1omQCpXGR9FqUP79W6uISclFaTWQ==
X-Received: by 2002:a5d:5f48:0:b0:48e:4835:de5f with SMTP id ffacd0b85a97d-48e4835de71mr16505478f8f.47.1793116024472;
        Tue, 27 Oct 2026 08:47:04 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:04 -0700 (PDT)
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
Subject: [RFC PATCH 05/14] KVM: guest_memfd: Export PFN mode files
Date: Tue, 27 Oct 2026 15:46:40 +0000
Message-ID: <20261027154649.91571-6-griffoul@gmail.com>
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

PFN mode files cannot be attached yet, though a provider's frames are
the memory that most needs a device mapping that follows its revokes.

Allow them. A lookup asks the provider with lookup_pfn_range(), which
allocates nothing, then get_pfn() for the block and its attributes. A
revoke updates the exports before the frames are reclaimed. A punch hole
must remove the frames from the exports before the provider gets them
back, while the provider still backs them: lookups report the range as
holes until then, and the exports are updated again afterwards.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 include/linux/guest_memfd.h |  20 ++++---
 virt/kvm/guest_memfd.c      | 111 ++++++++++++++++++++++++++++++------
 2 files changed, 105 insertions(+), 26 deletions(-)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index ba3eebb1ed1a..937693ae9573 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -90,13 +90,13 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * nor fault them.  It attaches to the file, looks up the frame behind each
  * shared page without taking a reference, and guest_memfd calls its update()
  * whenever what a lookup returns for a range may have changed: conversions,
- * punch holes and memory failure.  update() makes the consumer's mappings of
- * the range match what a lookup returns now: a frame, or a hole for a private
- * page or a page without a frame.  It may be called for pages that did not
- * change, and for ranges that do not follow the blocks that lookups report:
- * the consumer may then remap whole blocks, also outside the range, e.g. to
- * merge them into larger mappings.  A consumer that can fault may instead only
- * remove its mappings of the range.
+ * punch holes, memory failure and a provider's kvm_gmem_revoke().  update()
+ * makes the consumer's mappings of the range match what a lookup returns now:
+ * a frame, or a hole for a private page or a page without a frame.  It may be
+ * called for pages that did not change, and for ranges that do not follow the
+ * blocks that lookups report: the consumer may then remap whole blocks, also
+ * outside the range, e.g. to merge them into larger mappings.  A consumer that
+ * can fault may instead only remove its mappings of the range.
  *
  * Until update() returns, the frames it replaces stay valid, so a consumer
  * may switch each mapping to its new target in one step; once it returns,
@@ -111,8 +111,10 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * same time, also for overlapping ranges.  The consumer holds a lock across a
  * lookup and the mapping it installs, which update() also takes.  Lock order:
  *
- *   guest_memfd invalidate lock
- *     consumer lock
+ *   PFN mode provider lock (across kvm_gmem_revoke())
+ *     guest_memfd invalidate lock
+ *       consumer lock
+ *         provider leaf lock (get_pfn(), lookup_pfn_range())
  *
  * A consumer attaches and detaches outside its lock.  KVM may be a module
  * while the consumer is built in: consumers reach these with symbol_get().
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 65a951fa49c2..015f6657c386 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -40,6 +40,12 @@ struct gmem_inode {
 	const struct guest_memfd_provider_operations *provider_ops;
 	/* Subsystems that map the file, see include/linux/guest_memfd.h. */
 	struct list_head exports;
+	/*
+	 * A PFN mode punch hole in progress: lookups find holes in
+	 * [punch_start, punch_end) until the provider has the frames back.
+	 * Written under the invalidate lock, read without it.
+	 */
+	pgoff_t punch_start, punch_end;
 
 	u64 flags;
 	/*
@@ -515,15 +521,32 @@ static int __kvm_gmem_revoke(struct inode *inode, pgoff_t start,
 	kvm_gmem_invalidate_start(inode, start, end, filter);
 
 	if (kvm_gmem_is_pfn_mode(GMEM_I(inode))) {
+		struct gmem_inode *gi = GMEM_I(inode);
+
 		unmap_mapping_range(inode->i_mapping, offset, len, 0);
+		/*
+		 * A punch hole gives the frames back only after the reclaim:
+		 * until then, lookups find holes.  Afterwards, the exports map
+		 * what the provider backs the range with.
+		 */
+		if (put_pfn_range) {
+			WRITE_ONCE(gi->punch_start, start);
+			/* Pairs with the smp_rmb() in kvm_gmem_export_pfn(). */
+			smp_wmb();
+			WRITE_ONCE(gi->punch_end, end);
+		}
+		kvm_gmem_update_exports(inode, start, end);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 		if (pfn)
 			kvm_arch_gmem_reclaim(*pfn, nr_pages);
 		else
-			kvm_gmem_pfn_reclaim(GMEM_I(inode), start, end);
+			kvm_gmem_pfn_reclaim(gi, start, end);
 #endif
-		if (put_pfn_range)
-			gmem_provider_put_pfn_range(GMEM_I(inode), start, nr_pages);
+		if (put_pfn_range) {
+			gmem_provider_put_pfn_range(gi, start, nr_pages);
+			WRITE_ONCE(gi->punch_end, 0);
+			kvm_gmem_update_exports(inode, start, end);
+		}
 	} else {
 		kvm_gmem_truncate(inode, start, end);
 	}
@@ -1258,8 +1281,7 @@ static struct file_operations kvm_gmem_fops = {
  * guest_memfd calls @e->ops->update() from now on, and holds a reference to
  * @file until kvm_gmem_export_detach().  May sleep.
  *
- * Return: 0, -ENODEV if @file is not a guest_memfd file, or -EOPNOTSUPP in
- * PFN mode.
+ * Return: 0, or -ENODEV if @file is not a guest_memfd file.
  */
 int kvm_gmem_export_attach(struct file *file, struct guest_memfd_export *e)
 {
@@ -1267,8 +1289,6 @@ int kvm_gmem_export_attach(struct file *file, struct guest_memfd_export *e)
 
 	if (file->f_op != &kvm_gmem_fops)
 		return -ENODEV;
-	if (kvm_gmem_is_pfn_mode(GMEM_I(inode)))
-		return -EOPNOTSUPP;
 
 	e->file = get_file(file);
 	filemap_invalidate_lock(inode->i_mapping);
@@ -1310,28 +1330,83 @@ static bool kvm_gmem_range_is_shared(struct inode *inode, pgoff_t index,
 	return true;
 }
 
+/*
+ * PFN mode: lookup_pfn_range() first, so that nothing is allocated, then
+ * get_pfn() for the order and attributes.
+ */
+static int kvm_gmem_export_pfn(struct gmem_inode *gi, pgoff_t index,
+			       unsigned long *pfn, int *max_order, u32 *attrs)
+{
+	pgoff_t punch_start, punch_end;
+	int order = *max_order, block;
+	unsigned long raw_pfn;
+	size_t nr_pages;
+	kvm_pfn_t frame;
+	int r;
+
+	/*
+	 * The end first: a new end comes with its start, and an old end of 0
+	 * makes the window empty.
+	 */
+	punch_end = READ_ONCE(gi->punch_end);
+	/* Pairs with the smp_wmb() in __kvm_gmem_revoke(). */
+	smp_rmb();
+	punch_start = READ_ONCE(gi->punch_start);
+	if (index >= punch_start && index < punch_end)
+		return -ENOENT;
+
+	r = gi->provider_ops->lookup_pfn_range(gi->provider, index, &raw_pfn,
+					       &nr_pages);
+	if (r)
+		return r;
+
+	r = gmem_provider_get_pfn(gi, index, &frame, &block, attrs);
+	if (r)
+		return r == -EFAULT ? -ENOENT : r;
+
+	order = min(order, block);
+	if (frame ^ index)
+		order = min_t(int, order, __ffs64(frame ^ index));
+	/* Nor may the block reach into a punch hole. */
+	while (order &&
+	       round_down(index, 1UL << order) < punch_end &&
+	       round_up(index + 1, 1UL << order) > punch_start)
+		order--;
+	*pfn = frame;
+	*max_order = order;
+	return 0;
+}
+
 /* What kvm_gmem_export_lookup_pfn() returns for a page inside the file. */
 static int __kvm_gmem_export_lookup(struct inode *inode, pgoff_t index,
 				    unsigned long *pfn, int *max_order,
 				    u32 *attrs)
 {
+	struct gmem_inode *gi = GMEM_I(inode);
 	struct folio *folio;
+	int r;
 
 	if (!kvm_gmem_range_is_shared(inode, index, 1))
 		return -ENOENT;
 
-	/* A folio that was never zeroed is a hole. */
-	folio = filemap_get_folio(inode->i_mapping, index);
-	if (IS_ERR(folio))
-		return -ENOENT;
-	if (folio_test_hwpoison(folio) || !folio_test_uptodate(folio)) {
+	if (kvm_gmem_is_pfn_mode(gi)) {
+		r = kvm_gmem_export_pfn(gi, index, pfn, max_order, attrs);
+		if (r)
+			return r;
+	} else {
+		/* A folio that was never zeroed is a hole. */
+		folio = filemap_get_folio(inode->i_mapping, index);
+		if (IS_ERR(folio))
+			return -ENOENT;
+		if (folio_test_hwpoison(folio) || !folio_test_uptodate(folio)) {
+			folio_put(folio);
+			return -ENOENT;
+		}
+		*pfn = folio_file_pfn(folio, index);
+		*max_order = 0;
+		*attrs = 0;
 		folio_put(folio);
-		return -ENOENT;
 	}
-	*pfn = folio_file_pfn(folio, index);
-	*max_order = 0;
-	*attrs = 0;
-	folio_put(folio);
 
 	/* Nor may the block hold a private page. */
 	while (*max_order &&
@@ -2042,6 +2117,8 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 	gi->provider_ops = NULL;
 	INIT_LIST_HEAD(&gi->gmem_file_list);
 	INIT_LIST_HEAD(&gi->exports);
+	gi->punch_start = 0;
+	gi->punch_end = 0;
 	return &gi->vfs_inode;
 }
 
-- 
2.47.3

