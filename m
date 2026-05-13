Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667D38CFF6;
	Wed, 13 May 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684076; cv=none; b=jGnLOcYhcgsRWjO7C6tAsVzxvi6MtMpJ6qgGI6//MD5hHf4HyC7y/MngmFJ6Ns41fWzRA6ePnXa4QQKsfaJiyZmajXhSENDaXZHQot2z/7fhdfyrh1LPPL6AopoOd0NykDc3Gci+A7G1HMp4U5FB6duaGc0UY5USAmt9+/1uv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684076; c=relaxed/simple;
	bh=5tb/dZ3Z6XZ9rdTRViFJg2CQhxIhIhB3K1EbtjSZ+/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OxQkraJwf4jPFkTw7+qyHUJjtGTqGeWEYSL7baFPWZP6bZwzTalY6FG47HNaFEPWuSROJV+Kd0Zo+Gj9Nl4aTSdgyEQlZnupj6wITiCfh06ZAnb4wgZBImuAnkku02n9nub5UX0C0XrYnF6+puVSRbq3GliCzgnjIfefBHoBduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvLTF6/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvLTF6/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FC9C19425;
	Wed, 13 May 2026 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684076;
	bh=5tb/dZ3Z6XZ9rdTRViFJg2CQhxIhIhB3K1EbtjSZ+/0=;
	h=From:To:Cc:Subject:Date:From;
	b=OvLTF6/v0D+Is1Oo2vvsUkztjB8o43huMqy8iw+pSIEJ/nvZeP4oZB7YNeLzpX70+
	 F6KHL8ycBfURSnQT1p+fKlIB9OhRQVTn0tCsXa1apa7oDIctXQWRwXvxjqjrRXnGVK
	 vd0ARq2IWqI97wp/22xXUA4xRls5LUhWjIkH09oIc79WCYDerBL44nYC8NvA/NJ6ri
	 F+QGxwMrRLrw+4UqlN3r2QqLBtZCTVNDdmCrzGaBuNlD8cL0XM2IFfnEbrmTW1Rw7d
	 GJhSsAo2QS1ZHFIkt5/EhT5m/ZBORkFb5yljim2NIz9XpXL5HyJ43DPn1XUH7ViMLt
	 BGE9bIg+4eV6w==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kbuild@vger.kernel.org,
	stable@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] iommu, debugobjects: avoid gcc-16.1 section mismatch warnings
Date: Wed, 13 May 2026 16:53:54 +0200
Message-Id: <20260513145425.1579430-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-16 has gained some more advanced inter-procedual optimization
techniques that enable it to inline the dummy_tlb_add_page() and
dummy_tlb_flush() function pointers into a specialized version of
__arm_v7s_unmap:

WARNING: modpost: vmlinux: section mismatch in reference: __arm_v7s_unmap+0x2cc (section: .text) -> dummy_tlb_add_page (section: .init.text)
ERROR: modpost: Section mismatches detected.

From what I can tell, the transformation is correct, as this is only
called when __arm_v7s_unmap() is called from arm_v7s_do_selftests(),
which is also __init. Since __arm_v7s_unmap() however is not __init,
gcc cannot inline the inner function calls directly.

In debug_objects_selftest(), the same thing happens. Both the
caller and the leaf function are __init, but the IPA pulls
it into a non-init one:

WARNING: modpost: vmlinux: section mismatch in reference: lookup_object_or_alloc+0x7c (section: .text.lookup_object_or_alloc) -> is_static_object (section: .init.text)

Marking the affected functions as not "__init" would reliably avoid this
issue but is not a good solution because it removes an otherwise correct
annotation. I tried marking the functions as 'noinline', but that ended
up not covering all the affected configurations.

With some more experimenting, I found that marking these functions as
__attribute__((noipa)) is both logical and reliable.

In order to keep the syntax readable, add a custom macro for this in
include/linux/compiler_attributes.h next to other related macros and
use it to annotate both files.

Link: https://lore.kernel.org/all/abRB6g-48ZX6Yl2r@willie-the-truck/
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: I merged both patches into one, to simplify the dependency
on the new compiler_attributes.h macro.
---
 drivers/iommu/io-pgtable-arm-v7s.c  | 18 ++++++++++++------
 include/linux/compiler_attributes.h | 11 +++++++++++
 lib/debugobjects.c                  |  2 +-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 40e33257d3c2..1dbef8c55007 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -777,21 +777,27 @@ struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
 
 static struct io_pgtable_cfg *cfg_cookie __initdata;
 
-static void __init dummy_tlb_flush_all(void *cookie)
+/*
+ * __noipa prevents gcc from turning indirect iommu_flush_ops calls
+ * into direct calls from a specialized __arm_v7s_unmap() that triggers
+ * a build time section mismatch assertion.
+ */
+static __noipa void __init dummy_tlb_flush_all(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
-				   size_t granule, void *cookie)
+static __noipa void __init dummy_tlb_flush(unsigned long iova, size_t size,
+					   size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
+static __noipa void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+					      unsigned long iova,
+					      size_t granule,
+					      void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index c16d4199bf92..836a50f5917a 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -396,6 +396,17 @@
 # define __disable_sanitizer_instrumentation
 #endif
 
+/*
+ * Optional: not supported by clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-noipa
+ */
+#if __has_attribute(noipa)
+# define __noipa __attribute__((noipa))
+#else
+# define __noipa
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12e2e42e6a31..c93b7ca3e1ab 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1212,7 +1212,7 @@ struct self_test {
 
 static __initconst const struct debug_obj_descr descr_type_test;
 
-static bool __init is_static_object(void *addr)
+static __noipa bool __init is_static_object(void *addr)
 {
 	struct self_test *obj = addr;
 
-- 
2.39.5

