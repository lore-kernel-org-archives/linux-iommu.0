Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98E3C1961;
	Tue,  3 Feb 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135865; cv=none; b=rkOVbmNwCZEbtk2IkaYpmu7IfRUJjGXpB1Hc39aaabh9TMWSBNGiZDU3MU8U0un1xz/jQgKVaJaVWS4I3BzoOaa0Oo/VTEfBe+7may28yy8VAkqlD6f+WQ612PTdP+6S4WLXxIG2MLAAd/r0nhvPVzJz5YNoWKIdpmR4E0HXlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135865; c=relaxed/simple;
	bh=8NKPdRGnNXMEdz6SK51aPIBdadbt+NTxQ5tH5rjBnLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lO3qu7JCLE66+XEVxVvRX00DGpJvR7iMVdfyf54n7wmiscbywo7VwmuG2V0HP0FYQemguOMu87cMpEXnjva7SF0ECGkM8b0WN/myipmb2BKQa9oZFhchHDpvax7xFhV63UCcYF7sSDXesVaDfuj9mkfU9ijo+Qwiv5BvzAqXcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaUjymV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaUjymV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67218C16AAE;
	Tue,  3 Feb 2026 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135865;
	bh=8NKPdRGnNXMEdz6SK51aPIBdadbt+NTxQ5tH5rjBnLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaUjymV4lKdPf0XW+6SntLKjqRu0SDylDV87yaAezrkqan0kKNSBHX779dFlqpeQH
	 FYhIfLq5kq5KszvVkPnx0PHf3l15PcMZIVUgs0J6Yq+4d+hAtwCy0yj00Mw4kuIf3c
	 kNVfliAXcz4lqQSy32MHVXv7mwLZWtGN6hVn6imLl9F6pUW+ExsN3UrvXI/Bn6UtWK
	 DSHsp6w8Z9Xsh6QPHfipea6LeSd4dZh7u3TVVsZeyljiBZhTf3H8xZUPYfCfb2nbQN
	 2FfoIUVILOtvCm9ceEcjJgtGjp8HPYY2hFXlmeSA+X5SHOE8cbIZtle9RYq7ivoNqd
	 PtWit4mC/NaAQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] [RFC] iommu: io-pgtable-arm-v7s: avoid gcc-16.0.1 section mismatch
Date: Tue,  3 Feb 2026 17:24:00 +0100
Message-Id: <20260203162406.2215716-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260203162406.2215716-1-arnd@kernel.org>
References: <20260203162406.2215716-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-16 has gained some more advanced inlining techniques that enable
it to inline the dummy_tlb_add_page() and dummy_tlb_flush() function
pointers into a specialized version of __arm_v7s_unmap:

WARNING: modpost: vmlinux: section mismatch in reference: __arm_v7s_unmap+0x2cc (section: .text) -> dummy_tlb_add_page (section: .init.text)

From what I can tell, the transformation is correct, as this
is only called when __arm_v7s_unmap() is called from
arm_v7s_do_selftests(), which is also __init.

I have not come up with a good workaround, so this simply marks
dummy_tlb_add_page() as not __init. Since there are currently only two
files where this happens, that may be an easy way out.

If anyone has a better idea for how to deal with that, let me know!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 523355e91a2c..705885924afb 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -775,23 +775,23 @@ struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
-static struct io_pgtable_cfg *cfg_cookie __initdata;
+static struct io_pgtable_cfg *cfg_cookie;
 
 static void __init dummy_tlb_flush_all(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
+static void dummy_tlb_flush(unsigned long iova, size_t size,
 				   size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
+static void dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+			       unsigned long iova, size_t granule,
+			       void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
-- 
2.39.5

