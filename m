Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116019;
	b=J7hPh+fg14NE7Wd0Bg/sUnK3IcXPq1VGN/z0V/Q27HfZ9T5K4rpfxcUbcoQJtMsUqjWg
	 FojzS40JM4lX13lS+KG8KOGgrsrTcw4TEE9Zzwhy+3UXd8ij/HPaxu1Oa3xhT8MqpJxkN
	 eeueEE4ov8LkAQxxQOg6zMxty1LbSXXutxFy7rJq19BJ7I+/5KnsBR15wLAl7IPc+WdO0
	 k0eeswnBGVuXk8+RuFRkGtOIZAFU0jNtSLN0aRJUe1IgCq6CXcyOmXqVBbzQxSXKIkLN8
	 bRZvWVZQoaChmebcYu8UD4lCwT9pRG/aOSbGfA3yQz0zE9VYyIzTfmRbZRHwweqVWcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2Ywf1kYABPcYkKuVCWE8YXozL9O+0YxMyRYyN2zEgtg=;
	b=5PKig1vIoJL2Foouvd/Iz6qGlU1iPucNmXwcNZZE2YC9tAFoniJm09udkVQqeL4lJSky
	 INNOdDJqccWAWeYQ3KEYMLxdL5NDAUTNdm6qk1JH0SQ1vXyr/Hzu4LhJSFDl662Jd2eqt
	 S6VIALL4cuCpIOOMEcGpH1K4pa5KYyvan1TV++ZwAQONXpurQ8vNNY4iaazt4fcKLnlqw
	 M8ox03quoNLWDa8DE3NR4CA+21uHtnQogwKaJ9M+eMbRMSwgG47nlZDO/wjnoozKjngTQ
	 xCNC4Az4MqbBZYYpyfzS9WmlqmxAGtG2JDxHsfgAo50AvR5TPP6n/iCbPQp2N8XZgMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jJ74rKK8;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4460A5BD1
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB4460A5BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jJ74rKK8
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so12747155e9.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116017; x=1793720817; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Ywf1kYABPcYkKuVCWE8YXozL9O+0YxMyRYyN2zEgtg=;
        b=jJ74rKK8Y83bdhJYOJGcm4Rm8H9jHt8jzymK7oBKUtyedDPVHiUY8iWUjMOXB5B3RC
         7krv6xgFndREupZSqam/4p/1zF4u543E0EQb/HYAlGDFE7awOnYIbs7Z8IojseFCXa2J
         TcTgoWGhtslFGVzBct5GyKIa+gfqtyN1BpOCNMwiaNX/aVuX4c8mn7gXjXbOT79g0UsN
         2JACO1ViB5qGbAfCOCmXDW7HeTQWwDP9RnNVvGIEopWzMI/URJch4doNRQY5mDXVwL7K
         K4QMh/0Hpz0oHmPX+zIaWqV24xrhvrdhFXfhzE84I9wIJIETRVvoeVvI45n6AtUUUtuN
         sEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116017; x=1793720817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Ywf1kYABPcYkKuVCWE8YXozL9O+0YxMyRYyN2zEgtg=;
        b=iIX2T2Pt7kSCKkzaOu034RKtrX4j3LsQujj4NtuNKQDorRAlsT93NiJqsxUpo7AbyQ
         G/Y1i/Seiw5/lQjD4QFVJ7p/HxY6NYKGkTp1ClOVYtUhtqgbQeGSOZOhVejVXvCxwLlG
         Ba6Gyp0tAd7TM8zJtAvWrunKaORlHONCPa95AWVK9QvQL2/jkpVGJrw1ztop5wJiyyz6
         6OFYEj1FQNtPMLCASdqKsU8v5v7JEDRGsPSNw4OMBL/0LLcw5UPTm2nmyS9Lu235V2HD
         Lyx4BXo7y0FxeoFv1iuSMlXkBuxE4ebcs/TcI5MIK07lD9BqZBo7/13tjg5jIcgbwAt1
         5ddw==
X-Forwarded-Encrypted: i=1; AKwUvBynfvv+ikncaQ5/2GI8SkT9OKfSMQeSsdMg2jS+PetyDGTNhVgFTfmnV47LL+yuodBeBSuFFg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL4KaLOpK24qA5t0s4ItHKGUe50G9x//GCN/Z7jb6XpzKrB3GTT
	VhacpyC1Rz5XK3Qf4YQ3rJngisvOX+gZzwCplz3+yIslxLcv+oukwiTs
X-Gm-Gg: AYBFou3kgjb3Tpq6A9yuDEAsfHysQvUwrPJ5W/FGFaBRcQloVbDxrd8IDw4f37ZpKnX
	2CXUVjKY/g/1t+ZcP/qH3QTAVQOv4VPuGo8vgutfnr7pBajicNGo29X0X7L2RLL4co25BuZcq3E
	qhd0uaqPVzy/Udj+ve/0lhG9XUnwhA0EuR5T6PPYPdKOq4Em1xHWZD3f7Ly9/Vp48BJuTbCBEQP
	F5rQUy3tnjnYxrSfVAplmU6kKn3ng2rmJWwza3qIRQBcL4HTJfsNqX0pj5ZLh0AXQgID8PjxBZD
	0Cc4W0Sf1f8/CwCv3U/Pq2UZJNu0YouXiRHcULuaQQgsaITLSZ++wSR00EMBUxXPo19MuMXWC+M
	FCOSvr75+d2jCiiUi9uLuUaS42XBn/RWxZ37nrkuzM74FWzt9GHlBNzXTuU+5u1jKXWsWW3hqnZ
	XvDG4yxkiNG/BdEbOWySpetat/2G/sU+6meQyrTbJ2jGPPYf1hnySaoxA0bKCQ65nLTDF8femvH
	lW6ojXY3BVd2Ozq5HThuDKcFmGgEcReIVuLEKAH3aP0xYMrrglylCtQAD2MpgdvJqYqIGFwvpLV
	YwzB/chruhgQNmCvrQ3/E1ceKXr0Wh7CsvdprJ2+FNvItMXjMaKTd2RadJ7QWUVuWXE26OQj/ag
	sBURdlmPyaItUlqim
X-Received: by 2002:a05:600c:8b41:b0:4a7:7d22:c50c with SMTP id 5b1f17b1804b1-4a77d22c51amr83981995e9.2.1793116017189;
        Tue, 27 Oct 2026 08:46:57 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.46.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:46:56 -0700 (PDT)
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
Subject: [RFC PATCH 02/14] KVM: guest_memfd: Support read-only frames from PFN mode providers
Date: Tue, 27 Oct 2026 15:46:37 +0000
Message-ID: <20261027154649.91571-3-griffoul@gmail.com>
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

A PFN mode provider may lend a frame that the guest must not write,
e.g. one shared by several guests, but guest_memfd maps every frame
writable.

Add an attributes output to get_pfn(), with GUEST_MEMFD_PFN_READONLY as
its first bit. KVM then maps such a frame read only and exits to
userspace on a guest write, and the VMM's mapping raises SIGBUS on a
write. A read-only frame cannot back a private page or be populated.

On arm64, the new exit in gmem_abort() also restores the return after a
failed kvm_gmem_get_pfn() that a kvm/next merge dropped.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/arm64/kvm/mmu.c              |  10 ++-
 arch/arm64/kvm/nested.c           |   9 ++-
 arch/x86/kvm/mmu/mmu.c            |  15 +++-
 arch/x86/kvm/svm/sev.c            |   4 +-
 include/linux/guest_memfd.h       |  24 +++++-
 include/linux/kvm_host.h          |   6 +-
 samples/kvm/mem_provider_sample.c |   2 +-
 virt/kvm/guest_memfd.c            | 128 ++++++++++++++++++++++++++----
 8 files changed, 168 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 745cb86f9e04..cdf6d671158a 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1736,7 +1736,7 @@ static gfn_t get_canonical_gfn(const struct kvm_s2_fault_desc *s2fd,
 static int gmem_abort(const struct kvm_s2_fault_desc *s2fd,
 		      struct kvm_s2_fault_result *result)
 {
-	bool write_fault, exec_fault;
+	bool write_fault, exec_fault, writable;
 	bool perm_fault = kvm_s2_fault_is_perm(s2fd);
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
@@ -1773,17 +1773,19 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd,
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, canonical_gfn, &s2vi.pfn, NULL);
-	if (ret) {
+	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, canonical_gfn, &s2vi.pfn, NULL,
+			       &writable);
+	if (ret || (write_fault && !writable)) {
 		/* If result is non-NULL this is a synthetic fault. */
 		if (!result)
 			kvm_prepare_memory_fault_exit(s2fd->vcpu, gfn_to_gpa(canonical_gfn),
 						      s2vi.vma_pagesize, write_fault, exec_fault,
 						      false);
 		kfree(mapping);
+		return ret ?: -EFAULT;
 	}
 
-	if (!(s2fd->memslot->flags & KVM_MEM_READONLY))
+	if (!(s2fd->memslot->flags & KVM_MEM_READONLY) && writable)
 		prot |= KVM_PGTABLE_PROT_W;
 
 	if (s2fd->nested)
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index f1c414f1c3fa..ec3bcdc230cf 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1615,12 +1615,19 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 			return -EFAULT;
 		}
 	} else {
-		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL);
+		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL,
+				       &writable);
 		if (ret) {
 			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
 					      write_fault, false, false);
 			return ret;
 		}
+		/* The CPU writes the VNCR page: a read-only frame cannot back it. */
+		if (!writable) {
+			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
+					      true, false, false);
+			return -EFAULT;
+		}
 
 		writable = !(memslot->flags & KVM_MEM_READONLY);
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5a2cc6a17a9b..1c50955e80f9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4675,6 +4675,7 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 				    struct kvm_page_fault *fault)
 {
 	int max_order, r;
+	bool writable;
 
 	if (!kvm_slot_has_gmem(fault->slot)) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
@@ -4682,13 +4683,23 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 	}
 
 	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
-			     &max_order);
+			     &max_order, &writable);
 	if (r) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 		return r;
 	}
 
-	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
+	/*
+	 * guest_memfd may report a read-only frame: map it without write
+	 * permission, and exit to userspace on a guest write rather than
+	 * install it.
+	 */
+	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY) &&
+			      writable;
+	if (fault->write && !fault->map_writable) {
+		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
+		return -EFAULT;
+	}
 	fault->max_level = kvm_max_level_for_order(max_order);
 
 	return RET_PF_CONTINUE;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6427db390b1c..4125b4fd30da 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4096,7 +4096,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 * The new VMSA will be private memory guest memory, so retrieve the
 	 * PFN from the gmem backend.
 	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL, NULL))
 		return;
 
 	read_lock(&kvm->mmu_lock);
@@ -5092,7 +5092,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
-	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order);
+	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order, NULL);
 	if (ret) {
 		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for private GPA 0x%llx\n",
 				    gpa);
diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index a38a81693422..9d8764b93af2 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_GUEST_MEMFD_H
 #define _LINUX_GUEST_MEMFD_H
 
+#include <linux/bits.h>
 #include <linux/types.h>
 
 struct file;
@@ -23,9 +24,12 @@ struct mempolicy;
  *           zeroing if necessary. On success, return 0 with the physical frame
  *           number in @pfn and, if @max_order is non-NULL, the largest order
  *           for which the naturally aligned block of 2^order pages that
- *           contains @index is backed by contiguous frames. Returns a
- *           negative error code on failure. The provider must define
- *           @lookup_pfn_range when @get_pfn is defined.
+ *           contains @index is backed by contiguous frames. @attrs, preset
+ *           to 0 by guest_memfd, receives the GUEST_MEMFD_PFN_* attributes
+ *           of the whole block. A provider that changes them must then
+ *           kvm_gmem_revoke() the range. Returns a negative error code on
+ *           failure. The provider must define @lookup_pfn_range when
+ *           @get_pfn is defined.
  * @lookup_pfn_range: Look up the PFN for a given index. Returns 0 on success
  *                    with the physical frame number in @pfn and the number of
  *                    contiguous pages the mapping is valid for in @nr_pages.
@@ -49,12 +53,24 @@ struct guest_memfd_provider_operations {
 				     struct mempolicy *mpol);
 	void (*invalidate_folio)(void *provider, struct folio *folio);
 	int (*get_pfn)(void *provider, pgoff_t index, unsigned long *pfn,
-		       int *max_order);
+		       int *max_order, u32 *attrs);
 	int (*lookup_pfn_range)(void *provider, pgoff_t index,
 				unsigned long *pfn, size_t *nr_pages);
 	void (*put_pfn_range)(void *provider, pgoff_t index, size_t nr_pages);
 };
 
+/*
+ * Attributes of a PFN mode block, reported by get_pfn().  Only the provider
+ * knows them, and every mapping of the block must follow them.
+ *
+ * READONLY: the guest may read the block but not write it, e.g. a page that
+ * the provider lends to several guests.  guest_memfd maps it read only for
+ * the guest and the VMM, and never backs a private page with it.
+ */
+#define GUEST_MEMFD_PFN_READONLY	BIT(0)
+
+#define GUEST_MEMFD_PFN_ATTRS		GUEST_MEMFD_PFN_READONLY
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_pages,
 		    const unsigned long *pfn);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 345f97b110fa..3d0db49ad08b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2628,11 +2628,13 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 }
 
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order,
+		     bool *writable);
 #else
 static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
-				   kvm_pfn_t *pfn, int *max_order)
+				   kvm_pfn_t *pfn, int *max_order,
+				   bool *writable)
 {
 	KVM_BUG_ON(1, kvm);
 	return -EIO;
diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index 5496e0c7864b..f30654a60dd8 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -179,7 +179,7 @@ static void mps_gmem_release(void *provider)
 }
 
 static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
-			    int *max_order)
+			    int *max_order, u32 *attrs)
 {
 	struct file *resource_file = provider;
 	struct mps_info *info = resource_file->private_data;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index be26bd16d420..1554a17906da 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -142,18 +142,25 @@ static struct folio *gmem_provider_alloc_folio(struct gmem_inode *gi,
 }
 
 static int gmem_provider_get_pfn(struct gmem_inode *gi, pgoff_t index,
-				 kvm_pfn_t *pfn, int *max_order)
+				 kvm_pfn_t *pfn, int *max_order, u32 *attrs)
 {
 	unsigned long raw_pfn;
+	u32 __attrs = 0;
 	int r;
 
 	if (max_order)
 		*max_order = 0;
-	r = gi->provider_ops->get_pfn(gi->provider, index, &raw_pfn, max_order);
+	r = gi->provider_ops->get_pfn(gi->provider, index, &raw_pfn, max_order,
+				      &__attrs);
 	if (r)
 		return r;
 
+	if (WARN_ON_ONCE(__attrs & ~GUEST_MEMFD_PFN_ATTRS))
+		return -EIO;
+
 	*pfn = raw_pfn;
+	if (attrs)
+		*attrs = __attrs;
 	return 0;
 }
 
@@ -546,7 +553,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 				break;
 			}
 
-			r = gmem_provider_get_pfn(gi, index, &pfn, &max_order);
+			r = gmem_provider_get_pfn(gi, index, &pfn, &max_order, NULL);
 			if (r)
 				break;
 
@@ -721,13 +728,71 @@ static bool kvm_gmem_supports_mmap(struct inode *inode)
 	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;
 }
 
+/* The protection for a host mapping of a PFN mode frame with @attrs. */
+static pgprot_t kvm_gmem_pfn_prot(struct vm_area_struct *vma, u32 attrs)
+{
+	vm_flags_t flags = vma->vm_flags;
+
+	if (attrs & GUEST_MEMFD_PFN_READONLY)
+		flags &= ~VM_WRITE;
+	return vm_get_page_prot(flags);
+}
+
+/*
+ * Map a PFN mode frame for the host.  Called with the invalidate lock held
+ * shared, so that a frame is never mapped after the revoke that removes it.
+ * A read-only frame is mapped without write permission, and a write to it
+ * raises SIGBUS.
+ */
+static vm_fault_t kvm_gmem_pfn_fault(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct vm_area_struct *vma = vmf->vma;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	kvm_pfn_t pfn;
+	u32 attrs;
+	int r;
+
+	r = gmem_provider_get_pfn(GMEM_I(inode), vmf->pgoff, &pfn, NULL, &attrs);
+	if (r)
+		return vmf_error(r);
+
+	if (write && (attrs & GUEST_MEMFD_PFN_READONLY))
+		return VM_FAULT_SIGBUS;
+
+	return vmf_insert_pfn_prot(vma, vmf->address, pfn,
+				   kvm_gmem_pfn_prot(vma, attrs));
+}
+
+/*
+ * A write to a read-only PTE, e.g. after mprotect(): allow it unless the frame
+ * is read only.  The core upgrades the PTE under its lock only if it did not
+ * change, and a provider that makes the frame read only revokes it first.
+ */
+static vm_fault_t kvm_gmem_pfn_mkwrite(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	vm_fault_t ret = 0;
+	kvm_pfn_t pfn;
+	u32 attrs;
+	int r;
+
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	r = gmem_provider_get_pfn(GMEM_I(inode), vmf->pgoff, &pfn, NULL, &attrs);
+	if (r)
+		ret = vmf_error(r);
+	else if (attrs & GUEST_MEMFD_PFN_READONLY)
+		ret = VM_FAULT_SIGBUS;
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+	return ret;
+}
+
 static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct gmem_inode *gi = GMEM_I(inode);
 	vm_fault_t ret = VM_FAULT_LOCKED;
 	struct folio *folio = NULL;
-	kvm_pfn_t pfn;
 	int r = 0;
 
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
@@ -737,9 +802,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff)) {
 		r = -EACCES;
 	} else if (kvm_gmem_is_pfn_mode(gi)) {
-		r = gmem_provider_get_pfn(gi, vmf->pgoff, &pfn, NULL);
-		if (!r)
-			ret = vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+		ret = kvm_gmem_pfn_fault(vmf);
 	} else {
 		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
 		if (IS_ERR(folio))
@@ -815,6 +878,12 @@ static const struct vm_operations_struct kvm_gmem_vm_ops = {
 #endif
 };
 
+/* PFN mode: a write to a page mapped read only comes back to guest_memfd. */
+static const struct vm_operations_struct kvm_gmem_pfn_vm_ops = {
+	.fault		= kvm_gmem_fault_user_mapping,
+	.pfn_mkwrite	= kvm_gmem_pfn_mkwrite,
+};
+
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct gmem_inode *gi = GMEM_I(file_inode(file));
@@ -827,8 +896,11 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	if (kvm_gmem_is_pfn_mode(gi))
+	if (kvm_gmem_is_pfn_mode(gi)) {
 		vm_flags_set(vma, VM_PFNMAP);
+		vma->vm_ops = &kvm_gmem_pfn_vm_ops;
+		return 0;
+	}
 
 	vma->vm_ops = &kvm_gmem_vm_ops;
 
@@ -1503,7 +1575,7 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 static struct folio *__kvm_gmem_get_pfn(struct file *file,
 					struct kvm_memory_slot *slot,
 					pgoff_t index, kvm_pfn_t *pfn,
-					int *max_order)
+					int *max_order, u32 *attrs)
 {
 	struct file *slot_file = READ_ONCE(slot->gmem.file);
 	struct gmem_inode *gi = GMEM_I(file_inode(file));
@@ -1522,7 +1594,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 	}
 
 	if (kvm_gmem_is_pfn_mode(gi)) {
-		r = gmem_provider_get_pfn(gi, index, pfn, max_order);
+		r = gmem_provider_get_pfn(gi, index, pfn, max_order, attrs);
 		if (r)
 			return ERR_PTR(r);
 		return NULL;
@@ -1588,14 +1660,22 @@ static int kvm_gmem_pfn_map_order(struct inode *inode, pgoff_t index,
 	return order;
 }
 
+/*
+ * @writable, if not NULL, is set to whether the guest may write the page.  It
+ * may be NULL only for private pages, which are always writable.
+ */
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order,
+		     bool *writable)
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
 	struct folio *folio;
 	int r = 0, __order;
+	u32 attrs = 0;
 
 	max_order = max_order ?: &__order;
+	if (writable)
+		*writable = true;
 
 	CLASS(gmem_get_file, file)(slot);
 	if (!file)
@@ -1603,15 +1683,28 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
 
-	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
+	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order, &attrs);
 	if (IS_ERR(folio)) {
 		r = PTR_ERR(folio);
 		goto out;
 	}
 
-	if (kvm_gmem_is_pfn_mode(GMEM_I(file_inode(file))))
+	if (kvm_gmem_is_pfn_mode(GMEM_I(file_inode(file)))) {
+		/*
+		 * A read-only frame is not the guest's alone, so it never
+		 * backs a private page: a private fault on it is a hole.
+		 */
+		if (attrs & GUEST_MEMFD_PFN_READONLY) {
+			if (kvm_gmem_is_private_mem(file_inode(file), index) ||
+			    WARN_ON_ONCE(!writable)) {
+				r = -EFAULT;
+				goto out;
+			}
+			*writable = false;
+		}
 		*max_order = kvm_gmem_pfn_map_order(file_inode(file), index, gfn,
 						    *pfn, *max_order);
+	}
 
 	if (kvm_arch_has_gmem_convert() &&
 	    kvm_gmem_is_private_mem(file_inode(file), index))
@@ -1637,12 +1730,13 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
 	struct folio *folio;
+	u32 attrs = 0;
 	kvm_pfn_t pfn;
 	int ret;
 
 	filemap_invalidate_lock(file->f_mapping);
 
-	folio = __kvm_gmem_get_pfn(file, slot, index, &pfn, NULL);
+	folio = __kvm_gmem_get_pfn(file, slot, index, &pfn, NULL, &attrs);
 	if (IS_ERR(folio)) {
 		ret = PTR_ERR(folio);
 		goto out_unlock;
@@ -1651,6 +1745,12 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (folio)
 		folio_unlock(folio);
 
+	/* Populated pages are private, and are written: not a read-only frame. */
+	if (attrs & GUEST_MEMFD_PFN_READONLY) {
+		ret = -EPERM;
+		goto out_put_folio;
+	}
+
 	if (!kvm_is_private_gfn(kvm, gfn)) {
 		ret = -EINVAL;
 		goto out_put_folio;
-- 
2.47.3

