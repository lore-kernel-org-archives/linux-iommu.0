Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116030;
	b=KtxrwOoUQEvOkHF56FP65j4swOYbvIt0EHHNSmdootqUf2oofcjHpJ7/R8QRKqdnn2Es
	 YUSXiQeXdAm+BG6ZkhTzqL8VliyuuV0F3CWD40Y1EqO8xngwivPdn5F+UOIphdrOd56mb
	 xNVbSpzewljmK8BTkBRibjo8XmtMF2mJm/K2CZkO+WmZOrdd8y0Q9VhgRtozR1s3Tbi3e
	 NfN/pTRDPPVR1FdPAE5isma0N3LZv1/gvW3cjq3YTN8EMw6L3cK/pj3s6krGVJm/nU5n1
	 ntSbc95RC/a1bQu4x29rd5DCij5x+E/ZT/w0bxOYFN6vI3Q92uiBRQ3iyrCQlt5BnbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c+t2RCt7p+zsicFUGs0SiXsBnjjHZ+TU2eQo8OoRVfQ=;
	b=lopcbzMSxu3mTNrhsZapHe00lfWva8LP3qNJLMPdemr4AL3BiT7PxNYKDepgBrrHYRie
	 XeGudEYPURxTbEZKeMF2JG57yCkypz21ELueJB679ORJThgTPEixKr6wuPqwW02kaXIwC
	 TSvvvAOVeRjB6s0EgqcVaUZ4yeWSr/19GYWhlCeb2AF53wFwQqkx2GTbiGwW4wk1IOzM7
	 5GNMM72FnYwxYaLLrSbFIpV9ULaaRO+joHg6V2dqfYqCWfWk2pgjidh3SRPXgUT5j++ys
	 ThV7EYupSGBuhTZzf1vmj8gl/RAjqBCSyyvBk6mTP/WYFdhSqYDUdirFN3oRI0zMn7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9KQG1j7;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AF606AB4A
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D96AF606AB4A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9KQG1j7
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b001cd92bso2419294f8f.2
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116022; x=1793720822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+t2RCt7p+zsicFUGs0SiXsBnjjHZ+TU2eQo8OoRVfQ=;
        b=D9KQG1j7mv8+iCpb9G+fEzsJ4jT6gjrEvE8ZsgoJHq19GmO/TRSjHmUfzmmlkJDh8z
         wxWQXlPq5S2p206xwr4gjlx1L23uDbflonLkvcI2uAWXyyIJef7g8PNld9gL18k3cwJS
         QsP0AdjuDNisUz1hn5DAG0MECRFGxKSLqWoOO5dUkFe3HboT9KENhKrAq1qk2x2a+aeD
         2hRinS/q2VX7nvoalToEKMNL19k+tA1FrTZP2n5GaGlQEFUEUvuPQy/LQOQ2IlrF9OOB
         G7FUhmWgOUxostXO1Hn3UaDv7OxKgLnUG3SGv8c5k3ShIv63Sm/qguYWaUokfcI4kf5o
         q4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116022; x=1793720822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+t2RCt7p+zsicFUGs0SiXsBnjjHZ+TU2eQo8OoRVfQ=;
        b=TEgbs+GGdZNQPSdM+K4g5XQr9iIzE6p3qNUlzIrPJwE7DKD3bHM3VRqeXwzYHUktRk
         dt9E+TOCxttbuhG9ekURiUMKTWa7qQcIPbEwhQ0c9CnI/QkuiEGpNdIPzgm6g7uSYznV
         R0o8BLXfisalnHJEoHqt5IWh4L5O3KKR2Yx3b84NKfNpRwTef3E4NmRqkf7Ej0ryUNB9
         S7rjtp1s9eq2HMAH4bwNVPbg5uB3A2d805KlOtj3RgseNRsld3XrPSCMiouDqfcXG6eH
         mB12PQZeQ6tkSyyHEEy1WE2jhRV3hK2Gb5Olp6UcJDAg1FJtPBSw9h0dyLFFJ4NHV2tg
         C0rg==
X-Forwarded-Encrypted: i=1; AKwUvBw2ZBSBV63rRxQ2qMT07kCcfNGyc8ZSPTQAKp1ia1+wnthZhA8/sIJVYJPSgPXOBjVR21I5lQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIR8yNbweBzlkAFYC/n8Zoo8y70yTPG4+ezw1H3vtJ6kmakTKc7
	mPeZmyVF9/AEHB250KeOGWfWFiM3LAOUYSReREJvOSJgcgC0y/8N9uwD
X-Gm-Gg: AYBFou3P+tU7iIGnD/zmC9Ztj0s6Qt3p6qml/P74r4WuDNZXTw8oo1qGLH+aHGB6RaS
	s5zZI/2OhqVozBVhjk+LdgVaHX/9CiSEI9sHE9NDeF7QjU6Hf2o+6Xmd7zgO7/W5odDmy9SEfiE
	ivO11vsgnauvGKgVcg1QIf7eN86eUTygRE6AmHKbmQ4FvHiybIfRcjUwaRCbfe+oUZsEd++ebJ8
	4WF0S1gtMh3l/QUy4B6Zea+q2+0vq82iJ1BIlyMV1XIGJHQe9BBNyH2eYcrHBW7DruDWj9Nq8Yg
	5DkskM7ajk1qz3kNhkLPk6zp/Ow8zQAEAgZ2xJUaNhNUEuJldjkuWe+G36J0nJnnwZyIMJgPBdU
	iBxBUL8o8mC73Zs2kT6m8GMoivnWnrpLnNepJMPOtAm5TEDcA+H6YCITkg+NhARZHQAZURnw++L
	/fX4wpNA++IS1n/8pEP8Q6+lVEJ1FmNdF3Xzvo56NYkzDY2KSbcb2TjtQY+SP6h8dN+Z0d3iPaw
	kIdaN68J1u055CAbElJp4YBNupRu96mhfo5OKcB44jecxungTKtl84hRMu41WH/hj30nOWWsoze
	8M4KMEzXoAJGSqSXK3WHkGCGbuvXtr6qu21bg+wT+xxwxd9zYyHlbGuuYkK3UUjWCsH2U3svka+
	B/Sp5hwV4iUMZx9xH1VcEI3EfZ3APkt0ReCNHDw==
X-Received: by 2002:a05:6000:469c:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48e3eb9161fmr12046915f8f.36.1793116022012;
        Tue, 27 Oct 2026 08:47:02 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.46.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:01 -0700 (PDT)
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
Subject: [RFC PATCH 04/14] KVM: guest_memfd: Keep truncated folios until the exports are updated
Date: Tue, 27 Oct 2026 15:46:39 +0000
Message-ID: <20261027154649.91571-5-griffoul@gmail.com>
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

A punch hole frees the folios it truncates at once, but an export may
still map them, since it holds no reference: a device would then write
into freed memory.

Truncate a folio mode range batch by batch, holding a reference on each
folio until the exports are updated, so that a folio goes back to the
allocator only once no device maps it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 include/linux/guest_memfd.h | 28 ++++++++++++++--------------
 virt/kvm/guest_memfd.c      | 30 ++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index fdf7f8404d6c..ba3eebb1ed1a 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -89,14 +89,14 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * A subsystem that maps guest_memfd pages, such as iommufd, can neither pin
  * nor fault them.  It attaches to the file, looks up the frame behind each
  * shared page without taking a reference, and guest_memfd calls its update()
- * whenever what a lookup returns for a range may have changed: conversions and
- * memory failure.  update() makes the consumer's mappings of the range match
- * what a lookup returns now: a frame, or a hole for a private page or a page
- * without a frame.  It may be called for pages that did not change, and for
- * ranges that do not follow the blocks that lookups report: the consumer may
- * then remap whole blocks, also outside the range, e.g. to merge them into
- * larger mappings.  A consumer that can fault may instead only remove its
- * mappings of the range.
+ * whenever what a lookup returns for a range may have changed: conversions,
+ * punch holes and memory failure.  update() makes the consumer's mappings of
+ * the range match what a lookup returns now: a frame, or a hole for a private
+ * page or a page without a frame.  It may be called for pages that did not
+ * change, and for ranges that do not follow the blocks that lookups report:
+ * the consumer may then remap whole blocks, also outside the range, e.g. to
+ * merge them into larger mappings.  A consumer that can fault may instead only
+ * remove its mappings of the range.
  *
  * Until update() returns, the frames it replaces stay valid, so a consumer
  * may switch each mapping to its new target in one step; once it returns,
@@ -104,12 +104,12 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * that needs memory to apply one, e.g. to split a large mapping, reserves it
  * beforehand.
  *
- * guest_memfd calls update() with its invalidate lock held, exclusive when
- * pages convert and shared on memory failure, possibly with a folio of the
- * file locked; so update() may only call kvm_gmem_export_lookup_pfn().  Under
- * the shared lock, updates may run at the same time, also for overlapping
- * ranges.  The consumer holds a lock across a lookup and the mapping it
- * installs, which update() also takes.  Lock order:
+ * guest_memfd calls update() with its invalidate lock held, exclusive when it
+ * takes frames away or pages convert and shared on memory failure, possibly
+ * with a folio of the file locked; so update() may only call
+ * kvm_gmem_export_lookup_pfn().  Under the shared lock, updates may run at the
+ * same time, also for overlapping ranges.  The consumer holds a lock across a
+ * lookup and the mapping it installs, which update() also takes.  Lock order:
  *
  *   guest_memfd invalidate lock
  *     consumer lock
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 81031483a1f1..65a951fa49c2 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -424,7 +424,7 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 
 /*
  * What a lookup returns for [start, end) may have changed: exclusive lock when
- * pages converted, shared on memory failure.
+ * frames were taken away or pages converted, at least shared on memory failure.
  */
 static void kvm_gmem_update_exports(struct inode *inode, pgoff_t start,
 				    pgoff_t end)
@@ -437,6 +437,32 @@ static void kvm_gmem_update_exports(struct inode *inode, pgoff_t start,
 		e->ops->update(e, start, end - start);
 }
 
+/*
+ * Truncate [start, end) of a folio mode file.  The exports map the folios
+ * without references, so hold the folios until the exports are updated.
+ */
+static void kvm_gmem_truncate(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+	struct folio_batch fbatch;
+	pgoff_t next = start;
+	unsigned int i;
+
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
+		pgoff_t first = max(fbatch.folios[0]->index, start);
+		pgoff_t last = min(next, end);
+
+		truncate_inode_pages_range(inode->i_mapping,
+					   (loff_t)first << PAGE_SHIFT,
+					   ((loff_t)last << PAGE_SHIFT) - 1);
+		kvm_gmem_update_exports(inode, first, last);
+		for (i = 0; i < folio_batch_count(&fbatch); i++)
+			folio_put(fbatch.folios[i]);
+		folio_batch_reinit(&fbatch);
+		cond_resched();
+	}
+}
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 static void kvm_gmem_pfn_reclaim(struct gmem_inode *gi, pgoff_t start, pgoff_t end)
 {
@@ -499,7 +525,7 @@ static int __kvm_gmem_revoke(struct inode *inode, pgoff_t start,
 		if (put_pfn_range)
 			gmem_provider_put_pfn_range(GMEM_I(inode), start, nr_pages);
 	} else {
-		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+		kvm_gmem_truncate(inode, start, end);
 	}
 
 	kvm_gmem_invalidate_end(inode, start, end);
-- 
2.47.3

