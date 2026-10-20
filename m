Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489285;
	b=sVZW0ahUP4Y7NAo/T3xCJa/dBRkxrAZt27/dDFBNXpcrZPNPU2J75N0av6u8tUNS5lyE
	 RCD8Axpx6LySB5fBznAJ94r2SnUR13Xd2oe2/Zl094f24P5Wud+DS7ensnml0/BtrTTOv
	 sinVzur86Hx3Sr6YKQVUGwDQGgcW4CtfGmH1rkS7E1cI7+q8uwThrKsIAWJYECeYDaEAg
	 hkQKeic29Ue9qWkgWkExCWJN2mFpVXT3kxJDpckLIpqwLnJn5iJ0eXBEEscA0gblI38Rd
	 SdlMc127J2iV8CP7OXL/fDPXyafrkevZB9a3Qd49RsAspVH5TSIRsKiB2n9wh1HGV7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489285;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Sy7Dz8kDPuI6hXGm4YE8UuMimPAELhzLRPTNDzmDeE8=;
	b=pK71dq3xXgkxnDlsAC7SOk41h030x2D1WeFMhWxiwiW4o+PnIQYxeXVuCv1LRUeKVGFE
	 dep4kZ8yp5yLbAdisvnFG4z0HP4zCwcofn1JEp13Wfx2RIYosXy4HaWYFzai0vE3ALucb
	 TvGTAz1Ct8shGisOwoZis24ZHllAvXKHJSnGkhLTOKg8ALlTz0YGr7PDzeDwR24SnvVWg
	 6gIFiE7l7MiK3EK3li0gOpvnLo+rIXHuVFY8u0gzS7CneDFXxiuxZ8c9mSe1cG9RgTDKG
	 DXOdaZROYyjaDYhkwY90fMoDjHWj2IZoEV3Ii779EjEcScldtJNDt4jHxef0aT8Mt+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VTNdg0Xz;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654260A2623
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 09:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8654260A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VTNdg0Xz
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792489281; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Sy7Dz8kDPuI6hXGm4YE8UuMimPAELhzLRPTNDzmDeE8=;
	b=VTNdg0Xz+wh2qGNlOkPonDFhUFYpHr8GS9FB30M9QaROdK6xQBhPPVgQn6kRFmD/SJfVHw0W/KbOdOcEECe6eCKmV2MZqEh8PS7nCcudTenPaKr22YLMaNsPAqx7rd2xzmGNtstnns+ZBfgd8gwPlYwaAq3fCO+nZbrapxkadkw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDCspS7_1792489276;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDCspS7_1792489276 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 17:41:19 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com,
	tanchi25@mails.ucas.ac.cn,
	gong.shuai@sanechips.com.cn
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH v5 02/10] iommupt: Add RISC-V dirty tracking PTE ops
Date: Tue, 20 Oct 2026 17:40:58 +0800
Message-Id: <20261020094106.92722-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
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

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Implement the three dirty-tracking hooks required by the generic page
table framework for the RISC-V format:

  pt_entry_is_write_dirty():
    Check the D bit (bit 7) in the PTE.

  pt_entry_make_write_clean():
    Clear the D bit across the full contiguous range.

  pt_entry_make_write_dirty():
    Atomically set D via try_cmpxchg64() on a single PTE.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/generic_pt/fmt/riscv.h | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index d4445e463fa9..2f4838eb44af 100644
--- a/drivers/iommu/generic_pt/fmt/riscv.h
+++ b/drivers/iommu/generic_pt/fmt/riscv.h
@@ -223,6 +223,55 @@ static inline void riscvpt_attr_from_entry(const struct pt_state *pts,
 }
 #define pt_attr_from_entry riscvpt_attr_from_entry
 
+/*
+ * Dirty tracking: RISC-V PTEs use D (bit 7) as the hardware dirty bit.
+ * When Svnapot 64K is active a leaf entry spans 16 consecutive PTEs; we
+ * must check / clear all of them so that no dirty indication is lost.
+ */
+static inline bool riscvpt_entry_is_write_dirty(const struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = riscvpt_entry_num_contig_lg2(pts);
+	const pt_riscv_entry_t *tablep =
+		pt_cur_table(pts, pt_riscv_entry_t) +
+		log2_set_mod(pts->index, 0, num_contig_lg2);
+	const pt_riscv_entry_t *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		if (READ_ONCE(*tablep) & RISCVPT_D)
+			return true;
+	return false;
+}
+#define pt_entry_is_write_dirty riscvpt_entry_is_write_dirty
+
+static inline void riscvpt_entry_make_write_clean(struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = riscvpt_entry_num_contig_lg2(pts);
+	pt_riscv_entry_t *tablep =
+		pt_cur_table(pts, pt_riscv_entry_t) +
+		log2_set_mod(pts->index, 0, num_contig_lg2);
+	pt_riscv_entry_t *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		WRITE_ONCE(*tablep, READ_ONCE(*tablep) & ~(pt_riscv_entry_t)RISCVPT_D);
+}
+#define pt_entry_make_write_clean riscvpt_entry_make_write_clean
+
+static inline bool riscvpt_entry_make_write_dirty(struct pt_state *pts)
+{
+	pt_riscv_entry_t *tablep =
+		pt_cur_table(pts, pt_riscv_entry_t) + pts->index;
+	pt_riscv_entry_t new = pts->entry | RISCVPT_D;
+
+	return try_cmpxchg64(tablep, &pts->entry, new);
+}
+#define pt_entry_make_write_dirty riscvpt_entry_make_write_dirty
+
+static inline bool riscvpt_dirty_supported(struct pt_common *common)
+{
+	return pt_feature(common, PT_FEAT_RISCV_S2);
+}
+#define pt_dirty_supported riscvpt_dirty_supported
+
 /* --- iommu */
 #include <linux/generic_pt/iommu.h>
 #include <linux/iommu.h>
-- 
2.50.1

