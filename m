Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116044;
	b=Ha3QDwsa6mWqDdteCr/wkIMNygeIlWY3xdZBZfaHHv6w6IFGLO30Y0EOvv1fa+hEfBoN
	 WN48haol+hZLD2+9XM8JVJBOWCqG5tepB12DKBaPzZjOOrw+F4EmA3sLx6FQdBAmedxtj
	 DmvGuGe77U8bjd9S0A5PGHR4LUuZ/V5wnfRYlv/ir/oFBsi2YIf9Di8vcsox7JKYXue8h
	 XLKbY2XHad7BFbW0TognOsxryPQwvaggQxmt5jKoQMvlGBFfc2ClOng2L0L4SP9PuQcza
	 2yDlIQJOqYCWO/bWyFGOnLlJCQ1/oxCu6dL1MV3EjQTuxY4m76GO526j4CGzijlnShQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0HiXSaw8ZLiMKT3XuSDklH+uJG7cgDM9jgjpZ0euyso=;
	b=seiLsgRa3FAoxJV6lZu82Pahbi+KrnJ7WKiUxXLOmVKPJKyLRjMGULzHAEnEXw3oG8WJ
	 TTlpay8qY1sDpq5BjT9r90CnKQl8zz6ZLyGia67t5OZ93pDwPyArfJlKBK5vXziOJDTqO
	 1Z7EthEbJTLSxXL56fff12BrCLZj1jAMyrNel5cv/udLsgZRLWrYengEm6svFh84B5ZD/
	 NEBD8Nv+tkgtHi3ioL3ZFb8kDShdq0eTKMm/guxiwvbJulsBwr0Pw8186f78CTtEHCvIy
	 GoOzHn8SIximw5mb9Rys9Stvy1odiN0PSYY2o+J9J/6qjojElQvU6fIfZh9vJFLdBSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUothfud;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394D60A263A
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6394D60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUothfud
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48bbb06e746so2303984f8f.3
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116043; x=1793720843; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HiXSaw8ZLiMKT3XuSDklH+uJG7cgDM9jgjpZ0euyso=;
        b=gUothfudCGhPtXkZgVUkclDYYtAQIsSFw9Ydj9udt/HZWRKVh/CmxGWU6XnZAyNs42
         6kYgXH9toW6ivTDssCCIRFTi57rCGTbUs1ZZz2CYRIv8yLpxL/vhbWhLcqsa2oY9Xjmb
         xw4chgZRpKy5Uj333lWsQiS6QUOinHjRboMmJvn4bu7cro8BpBoMIdhdK47tTBitL0o8
         Fd13/mx20aMqpfMI41dSs4mVYUJY9dd9ePg6KTQ9l1v3LInYgt8hmekE9sNtb1sDPZso
         qpbgvOw5yVO9gFKlvJ8bXa082maP/sckLC2kEHLH5VCHMVMr+JB6HgrpA9tRlq4KOzoJ
         XrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116043; x=1793720843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HiXSaw8ZLiMKT3XuSDklH+uJG7cgDM9jgjpZ0euyso=;
        b=muUDwUzQ80V/g4eZCEm/AW7OzRR+Y0Yi2DhnT08apAmFQ5uF482Btjtt0+wCwtVMQ8
         oC8yM+rYcxc4rLay7AE9kMsLBuZSNJPbUJDeiU8CmkrLRo4frUgPJ2EiW2oIhpZ/7MyV
         MbyLesGQJfHAM4n+U1/rhGFxkK8Swb3Sw4ic4Wpxb1EAsExdEhRNTLK3STNxO2F99Tks
         6dCIssyI/x4X1SqSW4CdlvehheS60agCue4h9+AXjreMDzntNV9VjmI5jeRgxe5RIc0I
         zdu9vvu50HEzeVp8ScEkS/G3do2+5Ir3T9iujD27uPu0+Jvh1F+rPvu6bWS7qMvxpbRI
         P0Nw==
X-Forwarded-Encrypted: i=1; AKwUvBwTlOtCYx0Fa+J/I1Z0FT8M+hu3LROOa5q7Y46lvWtskSVXxSHgv0m/5yB0hvyh8EVDUdXFCg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJC07bRhzBpXlKowwXLGNo9ljpnfNeOVLieSBGuJpO3BAM/sgeE
	xi/fjDFkvzmmxW8OThVu9LZgrrfkmnz1hEN2VsNC3U+4ttSyDmBqzwdR
X-Gm-Gg: AYBFou0xN1O7MK10zTdWfAU/4E6bgV70arvnaOiaXKhTKQNf0NlopayfP/HvLQM99FX
	m15cB9wQLLFAZ/Yda2/DNZQ9++BxHX9PMD+W1mA3y1UOF96rHHOG6DT3SzgZXW1/9TQlufGEOo4
	54Y5G0p4CBZC0UZ8bS++/15stUiB8JZTnEeanW7Gc6UngbnzP3xajlmdpnERYe+3UerJszSVgo0
	nOKnSH7ryQ4fEL8+Ra3pyQdw59DR9NofTG+iRoEDWxkxXNxAnD4KrIDq8vQM9bgFCns+fq9uRGj
	+XiX/YcP2NYKLA9WXHjRGNETUgKMm8A9uJn9guU2if/4cy/RQgv0u/sLxGu9iCFHS2hBLn9lTPz
	tEbsIqodH3hcIJq78cWL+WhAcBryjP1/LliDcnysvS1elvWkWmoDszk5+RSkC/IIJ9KvJsg8Nt8
	qwdMlXLWLFLX17bIKCaI8CPEu30EelwJhlJbei64QfWHUELS/2BSqqdSB9MJq9e1bHM1BkH/fG8
	wk1JxkDGVJ6pagT68WyA+ylz8sPAVvyAn0NJihNO0Tsd/gPEuIdfAe3+NlcXGoXYTgrg10dIsYT
	rlxJlX3l7hHKMWZXbuP4a2AF9xSSeqNvlvBdyokrzmPOJQclYj6fdGUpwNlUzx1rMh+htrkIlcR
	2ssZfWHZrgTqPQ10P
X-Received: by 2002:adf:e00e:0:10b0:487:40d:af29 with SMTP id ffacd0b85a97d-48e3eb975c0mr15293194f8f.36.1793116042581;
        Tue, 27 Oct 2026 08:47:22 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:22 -0700 (PDT)
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
Subject: [RFC PATCH 12/14] samples/kvm: Add read-only pages and large blocks to the sample provider
Date: Tue, 27 Oct 2026 15:46:47 +0000
Message-ID: <20261027154649.91571-13-griffoul@gmail.com>
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

The sample provider reports every page as writable and of order 0, and
does nothing when a page comes back, so tests cannot exercise read-only
frames, large mappings, or a device mapping that follows a page made
present again.

Add MPS_SET_READONLY, report the largest aligned block of pages in the
same state, and call kvm_gmem_restore() when pages become present or
writable again; making pages read only revokes them.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 samples/kvm/mem_provider_sample.c | 89 +++++++++++++++++++++++++++----
 samples/kvm/mem_provider_sample.h |  9 ++++
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index f30654a60dd8..670e36207e59 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -6,7 +6,8 @@
  *
  * The control device /dev/mem_provider_sample creates provider files.
  * Each file allocates its own contiguous memory from alloc_contig_pages().
- * Pages can be dynamically marked present or absent.
+ * Pages can be dynamically marked present or absent, and read only (for
+ * tests).
  * See mem_provider_sample.h.
  *
  * Confidential VMs are not supported.
@@ -39,6 +40,7 @@ struct mps_info {
 	struct page *cma_pages;		/* from alloc_contig_pages() */
 
 	unsigned long *absent;		/* taken away by MPS_SET_PRESENT */
+	unsigned long *readonly;	/* set by MPS_SET_READONLY */
 
 	struct inode *gmem_inode;
 };
@@ -83,6 +85,9 @@ static void mps_set_present(struct mps_info *info, unsigned long start,
 	mutex_lock(&info->lock);
 	if (present) {
 		bitmap_clear(info->absent, start, end - start);
+		/* Tell the users of guest_memfd that cannot fault. */
+		if (info->gmem_inode)
+			kvm_gmem_restore(info->gmem_inode, start, end - start);
 	} else {
 		bitmap_set(info->absent, start, end - start);
 		if (info->gmem_inode) {
@@ -95,6 +100,31 @@ static void mps_set_present(struct mps_info *info, unsigned long start,
 	mutex_unlock(&info->lock);
 }
 
+/*
+ * Change what get_pfn() reports for [start, end).  Making it read only takes
+ * write access away, so revoke it: the users of the guest_memfd map it again
+ * read only.  Making it writable takes nothing away, so only tell the users
+ * that cannot fault.  The pages keep their contents.
+ */
+static void mps_set_readonly(struct mps_info *info, unsigned long start,
+			     unsigned long end, bool value)
+{
+	unsigned long pfn = info->base_pfn + start;
+
+	mutex_lock(&info->lock);
+	if (value) {
+		bitmap_set(info->readonly, start, end - start);
+		if (info->gmem_inode)
+			kvm_gmem_revoke(info->gmem_inode, start, end - start,
+					&pfn);
+	} else {
+		bitmap_clear(info->readonly, start, end - start);
+		if (info->gmem_inode)
+			kvm_gmem_restore(info->gmem_inode, start, end - start);
+	}
+	mutex_unlock(&info->lock);
+}
+
 static long mps_get_stats(struct mps_info *info, void __user *uarg)
 {
 	struct mps_stats st = {};
@@ -114,11 +144,13 @@ static int mps_file_release(struct inode *inode, struct file *file)
 	if (info->cma_pages)
 		free_contig_range(info->base_pfn, info->npages);
 	bitmap_free(info->absent);
+	bitmap_free(info->readonly);
 	kfree(info);
 	return 0;
 }
 
-static long mps_file_set_present(struct mps_info *info, void __user *uarg)
+static long mps_file_set_range(struct mps_info *info, void __user *uarg,
+			       unsigned int cmd)
 {
 	struct mps_set_present sp;
 	unsigned long start, end;
@@ -129,9 +161,13 @@ static long mps_file_set_present(struct mps_info *info, void __user *uarg)
 	if (sp.value > 1 || sp.pad)
 		return -EINVAL;
 	ret = mps_range(info, sp.offset, sp.len, &start, &end);
-	if (!ret)
+	if (ret)
+		return ret;
+	if (cmd == MPS_SET_PRESENT)
 		mps_set_present(info, start, end, sp.value);
-	return ret;
+	else
+		mps_set_readonly(info, start, end, sp.value);
+	return 0;
 }
 
 static long mps_file_ioctl(struct file *file, unsigned int cmd,
@@ -144,7 +180,8 @@ static long mps_file_ioctl(struct file *file, unsigned int cmd,
 	case MPS_GET_STATS:
 		return mps_get_stats(info, uarg);
 	case MPS_SET_PRESENT:
-		return mps_file_set_present(info, uarg);
+	case MPS_SET_READONLY:
+		return mps_file_set_range(info, uarg, cmd);
 	default:
 		return -ENOTTY;
 	}
@@ -178,11 +215,28 @@ static void mps_gmem_release(void *provider)
 	fput(resource_file);
 }
 
+/* Is every bit of @bitmap in [first, first + n) equal to @value? */
+static bool mps_bits_are(unsigned long *bitmap, unsigned long first,
+			 unsigned long n, bool value)
+{
+	unsigned long end = first + n;
+
+	return (value ? find_next_zero_bit(bitmap, end, first) :
+			find_next_bit(bitmap, end, first)) >= end;
+}
+
+/*
+ * The frame behind @index, and the largest aligned block around it that is
+ * present and has the same attributes: the file's frames are contiguous.
+ * Lockless: a change is followed by kvm_gmem_revoke() or kvm_gmem_restore().
+ */
 static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 			    int *max_order, u32 *attrs)
 {
 	struct file *resource_file = provider;
 	struct mps_info *info = resource_file->private_data;
+	bool ro;
+	int order;
 
 	if (index >= info->npages)
 		return -EINVAL;
@@ -190,10 +244,22 @@ static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 	if (test_bit(index, info->absent))
 		return -EFAULT;
 
+	ro = test_bit(index, info->readonly);
 	*pfn = info->base_pfn + index;
-	if (max_order)
-		*max_order = 0;
-
+	*attrs = ro ? GUEST_MEMFD_PFN_READONLY : 0;
+
+	if (!max_order)
+		return 0;
+	for (order = PUD_ORDER; order; order--) {
+		unsigned long first = ALIGN_DOWN(index, 1UL << order);
+		unsigned long n = 1UL << order;
+
+		if (first + n <= info->npages &&
+		    mps_bits_are(info->absent, first, n, false) &&
+		    mps_bits_are(info->readonly, first, n, ro))
+			break;
+	}
+	*max_order = order;
 	return 0;
 }
 
@@ -255,9 +321,10 @@ static long mps_ctl_new_file(void __user *uarg)
 		return -ENOMEM;
 
 	info->absent = bitmap_zalloc(npages, GFP_KERNEL);
-	if (!info->absent) {
+	info->readonly = bitmap_zalloc(npages, GFP_KERNEL);
+	if (!info->absent || !info->readonly) {
 		ret = -ENOMEM;
-		goto err_free_info;
+		goto err_free_absent;
 	}
 
 	pages = alloc_contig_pages(npages, GFP_KERNEL | __GFP_ZERO,
@@ -293,7 +360,7 @@ static long mps_ctl_new_file(void __user *uarg)
 	free_contig_range(page_to_pfn(pages), npages);
 err_free_absent:
 	bitmap_free(info->absent);
-err_free_info:
+	bitmap_free(info->readonly);
 	kfree(info);
 	return ret;
 }
diff --git a/samples/kvm/mem_provider_sample.h b/samples/kvm/mem_provider_sample.h
index b9f10286cb30..57f494dc46fa 100644
--- a/samples/kvm/mem_provider_sample.h
+++ b/samples/kvm/mem_provider_sample.h
@@ -51,4 +51,13 @@ struct mps_set_present {
 #define MPS_SET_PRESENT \
 	_IOW(MPS_IOCTL_BASE, 12, struct mps_set_present)
 
+/*
+ * ioctl on a provider fd, with the same argument as MPS_SET_PRESENT: report
+ * [@offset, @offset + @len) as read only (GUEST_MEMFD_PFN_READONLY, @value 1)
+ * or writable again (@value 0).  Every mapping follows.  For tests: the
+ * sample does not really share the pages.
+ */
+#define MPS_SET_READONLY \
+	_IOW(MPS_IOCTL_BASE, 13, struct mps_set_present)
+
 #endif /* _SAMPLES_KVM_MEM_PROVIDER_SAMPLE_H */
-- 
2.47.3

