Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116052;
	b=3yfosFC2wDLAH0womtJrKJ0pba+Bkem5vqDcDLFrJ1c4w/FuaeSYujzY7677B88CVvyH
	 sVcwzEi3M4ZjZy8SlS5NyA5KKoHwb5vICow7TO726WnYPmNEoODQHelo2aQdqggUUmnit
	 O4IkecIQHl/eDNK+6ezhnkTEtnLKRfJl3aKqR41yGI5fpCqjrXQJQe26xu7k+RYE5pERH
	 0Y1CaPfAB668UNB5300Md7pBObP7rhf86P+LCY8rTvHclbnFqaZJm7YLUETQCXynDb4em
	 QshZMC0iXJk1b84pnl8AoneMrOi0DBDfEk7b+ZM19dAyQN+rCzShqIl7ntPab0XqAXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d2ojhVyA7G70YSFxIWDEXLUjmLV19PosvKcY5O6DkLk=;
	b=AgDFxwOv+PlhxLCDHIDvJEXqIPTzO3F8vlUHOjmf7lF8PGbnrFK6PksLpvS70Z0ZXMtV
	 el+u8UeAvuYx6tv1USmBkCDEhZv4HoUbDXCh84H9FyaJDkAzbnTdBzqyZe9QKeHCNkAu+
	 cRXPWg/bCTr5Ds99iQiF0yfGJh/ucIryz3RV+8eaYB60F8faSflxPrGOLZO8Xcy8ZaG+O
	 4D/Retcj49Jm8x7eAX1Fa9ss/zlqzxHNgVnzDp+WMOFE8z4MLyjF83WfD2J7Alx3TTfB9
	 boNfJ1PPBaqc6z/2WFb3oeQxJ7ibT8+1bajPjOewHR0vRNhE/nrmFpn2E66a8xDzMTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XE98cETw;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13DE606FCBB
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C13DE606FCBB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XE98cETw
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so3620866f8f.1
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116045; x=1793720845; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2ojhVyA7G70YSFxIWDEXLUjmLV19PosvKcY5O6DkLk=;
        b=XE98cETwycVPwnL/v/bcd5mzVDtZPmtiEZJRaNSt2jaeskB0egpb5DUeglpzybAmHm
         214b836vOPjlKBFQeDWIHZj9Lio4CSd5bZeslhn76oi/6MQ6+RphFP/hO2dp6L73N0Ub
         ZEqg3QEaGMPsr9xYxix3xSLymwVnoi4kcxvDhEX2sZqS66MNbylqUoLHiKhh4M2QJYs4
         Pzcge3jP8M2kEUJWXBanDnOKMYiTbFDx4eQjO4QXi4JmFq2MA4WBt+TpjokgsK3NVcSS
         c/QupuT0/h+r4CFaeL5RmWN/gmwiTkm0Kc+sw0QulYS+ujXPCnbZMBlr7I3pLQw+EpcW
         fZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116045; x=1793720845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d2ojhVyA7G70YSFxIWDEXLUjmLV19PosvKcY5O6DkLk=;
        b=WL71XHo5s8WYHVveex6lqAwJ1ABx2PewCpqC7vqGVp98GNDaMnZlvJo1dka4JQHrCw
         zcu1NRRgK00voUPSFkiQjKmJkiwQLbLiTyzKHgOdIUn/wcOusmsKJM0gzg22R/8yVrDT
         SPE3SfOPQjOkpDwNHztJIgjDIkUpiRRrx9hdMxYx+jsvXESYI4+lkcQ1otwO6XJw1lVv
         kylLVNe3UMhQ0fvTsU7ecG+VXAasXNMC9RETQADTY3iO7vRNJk3sGdbTvflkoXaJXB8n
         LA1zc8WZ7iCi2IbxLzHhsMOdmGenlgH3y2qeMcQo40Nmcqe5wzaPDNFbVXIlLN7htdVb
         1ffA==
X-Forwarded-Encrypted: i=1; AKwUvBzKCDh2yryWZKv/+u3AsrnF0ziURMrd+uM2kVX4BoyvBill6/ZVkMUNi6TcgnjSuPmiNcEFdA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKXXWPvh2+kdl9mKf3jQtr6fJY7agLJytahC5AmT0OiJgvNeEPx
	adROLELm9HOICz/axfSuBVwvP8Cj+NGjtblPP5UNF5PZbZoMdSzQWCxY
X-Gm-Gg: AYBFou3bu2iDeSvyi5irgDSFNFSmtjjL/WZLD7DePbYIdU+ciOCGdS0lIfCebn2xwia
	T1arkhLoNNkLMNq6UNy1pt7IGpZPz/l7G7hKNx9CRtbxQ/WSSRk81vlMeqxGGyzA93P1yic0Q/Q
	z7/F2wMN0pd5XUQKteQyVL3YM6H29OlKdAnC5wvee20k/8rFmWaaJCsiMyB2Zej/M4sZWfCtvR2
	3FnEvPbWbMq7xbfJV0ASGWOG8NSiMfcyTzdEKLBF8xqEpcLRqhNOcgvnWL1vnHqrd48kPaMcG5t
	Lp7DnR44nH71wV+NuJS9tIb4olNLspbtZrmDrjC+sJ8vhfRRtQqmKvPgVfclmQjjI7B5gJZNHpq
	WteQJKlR19jPnhjbtELkMCGdGgY/hE+7Q1fDyuoR6N1Conmk72QSf3iQ5xEbrNRL80IRvTpdQcD
	kyu7+cirtaCO4SBwazWvYFeYWiKNSnDmC2YFBsgJJQaDdW8lgFvQzsvhuYu9OJx6FxuwYSr2cD0
	z9zkVH2NqpU4Jqg/mLk7pac+8TZ+Q/ZL0bHc8G5+U8DOIJXov3e7JdmrwGM/VASK83Fss89+hsl
	hE6hjJPZ1aQwtxK7E1f/66qP/D822RYljw3tAa+OgDCy6DDAK81XQmyRdXZ88ITUdi2e7XPlWKn
	Xk+JOap0+4Kb4zGzQ3iGCizP2UIEaNI6nXyejYqYXg5KlQIRwVr3cl+7U9s0Dqkml7g==
X-Received: by 2002:adf:f284:0:b0:48e:2980:d396 with SMTP id ffacd0b85a97d-48e3eb8d6a5mr16586892f8f.37.1793116044977;
        Tue, 27 Oct 2026 08:47:24 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:24 -0700 (PDT)
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
Subject: [RFC PATCH 13/14] samples/kvm: Back absent pages on demand in the sample provider
Date: Tue, 27 Oct 2026 15:46:48 +0000
Message-ID: <20261027154649.91571-14-griffoul@gmail.com>
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

The sample provider fails get_pfn() for an absent page and keeps its
frames on a punch hole, so tests cannot exercise a provider that backs
a hole when it is asked for a frame, one that backs more than the page
asked for, or one that frees the frames that a punch hole gives back.

Add MPS_NEW_FILE_FILL: get_pfn() then backs an absent page with the
whole 2 MiB block around it, and put_pfn_range() makes the pages absent
again.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 samples/kvm/mem_provider_sample.c | 29 ++++++++++++++++++++++++-----
 samples/kvm/mem_provider_sample.h |  9 ++++++++-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index 670e36207e59..41e0ce5b6bc6 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -41,6 +41,7 @@ struct mps_info {
 
 	unsigned long *absent;		/* taken away by MPS_SET_PRESENT */
 	unsigned long *readonly;	/* set by MPS_SET_READONLY */
+	bool fill;			/* MPS_NEW_FILE_FILL */
 
 	struct inode *gmem_inode;
 };
@@ -62,8 +63,15 @@ static void mps_gmem_put_pfn_range(void *provider, pgoff_t index,
 				   size_t nr_pages)
 {
 	struct file *resource_file = provider;
+	struct mps_info *info = resource_file->private_data;
+	size_t i;
 
-	mps_zero_range(resource_file->private_data, index, nr_pages);
+	mps_zero_range(info, index, nr_pages);
+	if (!info->fill || index >= info->npages)
+		return;
+	/* Lockless, like get_pfn(): guest_memfd holds its invalidate lock. */
+	for (i = index; i < min_t(size_t, index + nr_pages, info->npages); i++)
+		set_bit(i, info->absent);
 }
 
 /* Byte range [offset, offset + len) of @info as page indices. */
@@ -228,7 +236,9 @@ static bool mps_bits_are(unsigned long *bitmap, unsigned long first,
 /*
  * The frame behind @index, and the largest aligned block around it that is
  * present and has the same attributes: the file's frames are contiguous.
- * Lockless: a change is followed by kvm_gmem_revoke() or kvm_gmem_restore().
+ * Lockless: a change is followed by kvm_gmem_revoke() or kvm_gmem_restore(),
+ * except a fill, which only gives frames to holes; guest_memfd tells its users
+ * about the block.
  */
 static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 			    int *max_order, u32 *attrs)
@@ -241,8 +251,16 @@ static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 	if (index >= info->npages)
 		return -EINVAL;
 
-	if (test_bit(index, info->absent))
-		return -EFAULT;
+	if (test_bit(index, info->absent)) {
+		unsigned long first = ALIGN_DOWN(index, PTRS_PER_PMD);
+		unsigned long i;
+
+		if (!info->fill)
+			return -EFAULT;
+		/* Absent pages are zeroed already. */
+		for (i = first; i < min(first + PTRS_PER_PMD, info->npages); i++)
+			clear_bit(i, info->absent);
+	}
 
 	ro = test_bit(index, info->readonly);
 	*pfn = info->base_pfn + index;
@@ -307,7 +325,7 @@ static long mps_ctl_new_file(void __user *uarg)
 
 	if (copy_from_user(&nf, uarg, sizeof(nf)))
 		return -EFAULT;
-	if (nf.flags || nf.pad)
+	if ((nf.flags & ~MPS_NEW_FILE_FILL) || nf.pad)
 		return -EINVAL;
 	if (!nf.size || !PAGE_ALIGNED(nf.size))
 		return -EINVAL;
@@ -337,6 +355,7 @@ static long mps_ctl_new_file(void __user *uarg)
 	info->cma_pages = pages;
 	info->base_pfn = page_to_pfn(pages);
 	info->npages = npages;
+	info->fill = nf.flags & MPS_NEW_FILE_FILL;
 	mutex_init(&info->lock);
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
diff --git a/samples/kvm/mem_provider_sample.h b/samples/kvm/mem_provider_sample.h
index 57f494dc46fa..45ec9605b593 100644
--- a/samples/kvm/mem_provider_sample.h
+++ b/samples/kvm/mem_provider_sample.h
@@ -19,11 +19,18 @@
  * Returns the provider fd.
  */
 struct mps_new_file {
-	__u32 flags;	/* Reserved, must be 0 */
+	__u32 flags;	/* MPS_NEW_FILE_* */
 	__u32 pad;
 	__u64 size;	/* bytes, page aligned */
 };
 
+/*
+ * get_pfn() backs an absent page, with every page of the 2 MiB block around
+ * it, instead of failing, and put_pfn_range() takes the pages back: a
+ * provider that allocates on demand and frees on a punch hole, for tests.
+ */
+#define MPS_NEW_FILE_FILL	(1U << 0)
+
 #define MPS_NEW_FILE \
 	_IOW(MPS_IOCTL_BASE, 5, struct mps_new_file)
 
-- 
2.47.3

