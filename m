Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFF42F6FE;
	Thu, 16 Jul 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215045; cv=none; b=bRhf/x6Tps0rRHRxsgLd/Gccoo35Y3xs7YXEfAOaImC+tQdyBC3qiDKWt7w4tIgDpzQOhL+Sv4jqm8GEkb96Gt8ajCMlgFMPGB1cRq4n9VKzvHiZnIH2Q4SyNR6l9yJDXt3qAHrOLarjqkMGC5sBBqzdXLOB5/uZpj5DKv5ObfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215045; c=relaxed/simple;
	bh=LimHJDn02kH6EVDCW5Qwd2F2UYDCgZsSzBepLB8Sdn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GavYhYXuSRvJSkDgfx0MAArR9WHeqayG+Zc6wxZC/G1odrKyf8HXRuRpna0mG1s99FQezcuJM1zlBWP3vQq9yWVOZNzygBczwv1W+hSmp4pigOHLcEEKZ+slAy9qH2QMaOxlPRISv/xPdm9S8wWW1Vp/yHi3kubGfFsCV5+j2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h8BkMDuS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h8BkMDuS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=20bps9/KzJj440NwL3aT0z2O5aOFBhPC7RprH+HfUWc=; b=h8BkMDuSTJQSJ6leJbqpaIPOOz
	pIVVJe0UcWrvnYM+VS7JFcUlp/aBSEc+GeAZr2UxjRfw+fN28yL0EP8lmkmWhn9g8QnJZ+MBhg44n
	+40m031ceC0XzQwsBBngvBgtCAMJ9TLEFRlxgLuviWcDLAVn3zCi9jHmb/pomTGM+fzSCWwcpBMX4
	caTNlLTL12tw/OdVsto8aB6ySb9v379xXBCqA79H4uFEapYC6WqfganPUYW7OwN6FU9R5dHBxXwTK
	KHyQb5gvAwDB9NyDTgtWzir6fZHjI1BYFdYEk4EYVZ+hJTXqibNn48B7ep45Zl1Pfz3niA6p6jHxo
	EUTdT9bQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wkNpl-0000000E9NE-49RN;
	Thu, 16 Jul 2026 15:17:10 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wkNpj-000000012st-0HyT;
	Thu, 16 Jul 2026 16:17:07 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhou Yuhang <zhouyuhang@kylinos.cn>,
	Zi Li <zi.li@linux.dev>,
	Dan Williams <djbw@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	connordw@amazon.co.uk,
	graf@amazon.de,
	fgriffo@amazon.co.uk,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH 02/11] KVM: selftests: sev_init2_tests: Derive SEV availability from KVM
Date: Thu, 16 Jul 2026 10:31:22 +0100
Message-ID: <4710ad35dcfd1a85a24d15fb56dbf233ac05ad49.1784194290.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The test asserted that the X86_FEATURE_SEV CPUID bit exactly matches
whether KVM offers KVM_X86_SEV_VM.  That is not an invariant: when all
SEV ASIDs are assigned to SEV-SNP, KVM does not offer the SEV VM type
even though CPUID reports SEV, so the test aborts on an SNP-only host.

Derive SEV availability from KVM_CAP_VM_TYPES (as already done for SEV-ES
and SNP), assert only the one-way implication that a type offered by KVM
is also reported in CPUID, and TEST_REQUIRE() the SEV VM type so the test
skips cleanly when it is unavailable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../testing/selftests/kvm/x86/sev_init2_tests.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 8db88c355f16..689390c10f7c 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -130,12 +130,18 @@ int main(int argc, char *argv[])
 			    KVM_X86_SEV_VMSA_FEATURES,
 			    &supported_vmsa_features);
 
-	have_sev = kvm_cpu_has(X86_FEATURE_SEV);
-	TEST_ASSERT(have_sev == !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM)),
-		    "sev: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
-		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_VM);
+	/*
+	 * Whether a VM type is available depends on KVM, not just CPUID: e.g.
+	 * when all SEV ASIDs are assigned to SEV-SNP, KVM does not offer the
+	 * SEV VM type even though X86_FEATURE_SEV is set.  Derive availability
+	 * from KVM_CAP_VM_TYPES and only assert the one-way implication that a
+	 * type offered by KVM must also be reported in CPUID.
+	 */
+	have_sev = kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM);
+	TEST_ASSERT(!have_sev || kvm_cpu_has(X86_FEATURE_SEV),
+		    "sev: SEV_VM supported without SEV in CPUID");
 
-	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM));
+	TEST_REQUIRE(have_sev);
 	have_sev_es = kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM);
 
 	TEST_ASSERT(!have_sev_es || kvm_cpu_has(X86_FEATURE_SEV_ES),
-- 
2.54.0

