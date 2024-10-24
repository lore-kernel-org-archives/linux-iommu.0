Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88D1F80BA
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787141; cv=none; b=LXEQdE8doGg2JaTQHBsAjr6XdnsUvIeiN6F2wRyOt0Hj1VeyU+DhYCIeKxP9Wh2io2iB/Zul9EVF6a5eIg01nMx1ZnFh3VM1gwjVpxa+Re0BWlBxdyCXNPvZbszlvZ1l+8jbBX9w3p40dhO24xIkyOkOPkmv4/AMXQW87ezqK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787141; c=relaxed/simple;
	bh=NReTaU/WrjVg9zxFq1KyTmKHkdtnfCKu2lqDSGFGRO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pg+VJFpIkeq//tphPLztTfrw/D2RmRV5Eyi4puOw0UOsvxyD2qyhCNqXyBoZSfjQOH2JcR/1DIPZ424h8UW/xGdLetahEo2RRWz1kxBJORNOtftb5Lvtzdm5oLdWCtTKQcHUq0uhYiBFNASzNPntDUx4dvABQaBYZDMhkqdye4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L95IECBN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L95IECBN"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-431673032e6so8137555e9.0
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787137; x=1730391937; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guhxqgoLzafkK+NdizG3et2iwgEsPQIVl8nGkP9yeqs=;
        b=L95IECBNKukUgSFksJhc2Z8iyBiaioUiErIItbMbMa1PB2iw3eFojkPXtO556ympx3
         OxJ+1niXVZtxp/6v3wZcF5dSxh97LDNP8nOuxCQ+iDkptd8VDAkdUNSdGZY8lPKYXGyB
         gLuobOAuJAQKaKUb2h4R6D1NOKgcUvKXsjZx0BHdiasWZHJIc6UIeIG8QHg6/fXahaYg
         eQ6aAAjdoNCPg9KkW0dsj46nRm0CC7W8fO846f4wUrPRoFWqAPwTaqfz3rXo8yPsYXGc
         x62Cbp83N77dWQ1iXmpZdeX+46qLAuXw1DhpfQxTJ1IuGl5fzB86njUwHrdb6ggTTBJg
         3Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787137; x=1730391937;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=guhxqgoLzafkK+NdizG3et2iwgEsPQIVl8nGkP9yeqs=;
        b=areNehoZR5oNglxmfawgZUPAbsy0rEJ5Qsr8IdQV9SGqo2yilHIgs0G91ZW39nIITZ
         zH3vYitVE7wU3naN5Enu4uf3Nx45fFVlp6aWqeaz0Hay0VkM0JVyXoieFZE1LO2QBaqu
         LxWJY0NrV3axwnLzXRuXRCF0ekKos3OrK4BYzMzF7/j0imaa6r/0KRMRl4Ok49jL90wI
         1czgZTnTU4laTDjXo6L8Muo80mdUjQOxzYIvqSsNuPR1yLWjl+xosdueqtHNE5HlY8gq
         xMcIKcykEOGgqKZKRdK6waUaXcZnlrwOBrwi+EKw1U2Yw9bC5Q8jDpdNDTLs5rlN4d8y
         KTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSIYtjHHVgUCsCFAiel9lpyOdixvltcwY7CSYPjbs9JO3/hz620eSJJaVNDUdiE+cynVXzQA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9nkOc7VJZJsW2AynpNDYDMoia2sZCDNSeAcUfo2IdicdE5EhV
	ja7o4a8pc7jzXEce94xDzvVySuFDPE0g9apXlnfER9R6981+6ANMu4ye0Cjtfv9oqZ6rTGIuUrC
	J02D8E6AsEg==
X-Google-Smtp-Source: AGHT+IErwzIVqMN+PjdLzUqLsxxxqsZOGGGMsnJi1kecA66UnaTLfYW8QeE2ETnjOUdJ0m1UCN25TK06TL0pAg==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a7b:cb52:0:b0:430:5759:867e with SMTP id
 5b1f17b1804b1-4318c76eba5mr266065e9.7.1729787137481; Thu, 24 Oct 2024
 09:25:37 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:25:15 +0000
In-Reply-To: <20241024162516.2005652-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241024162516.2005652-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024162516.2005652-2-smostafa@google.com>
Subject: [PATCH 1/2] iommu/io-pgtable-arm: Fix stage-2 map/umap for
 concatenated tables
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When calculating the max number of entries in a table, Where
RM_LPAE_LVL_IDX() understands the concatenated pgds and can return
an index spanning more than one concatenated table (for ex for 4K
page size > 512).
But then, max_entries is calculated as follows:
max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;

This leads to a negative index in the page table, where for:
- map: do nothing (no OOB) as fortunately all comparisons are signed,
  but it would return a negative mapped value.

- unmap: it would leak any child tables as it skips the loop over
  =E2=80=9C__arm_lpae_free_pgtable=E2=80=9D

This bug only happens when map/unmap is requested with a page size
equals to the first level of the concatenated table (for 40 bits input
and 4K granule would be 1GB) and can be triggered from userspace with
VFIO, by choosing a VM IPA in a concatenated table > 0 and using
huge pages to mmap with the first level size.

For example, I was able to reproduce it with the following command
with mainline linux and mainline kvmtool:

./lkvm run --irqchip gicv3 -k {$KERNEL} -p "earlycon" -d {$ROOTFS}  --force=
-pci -c \
`nproc` --debug -m 4096@525312 --vfio-pci 0000:00:03.0  --hugetlbfs  /hugep=
ages

Where huge pages with 1GB would be used and using IPA in the second table
(512GB for 40 bits SMMU and 4K granule).

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.=
c
index 0e67f1721a3d..3ecbc024e440 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -199,6 +199,17 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 	return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK << 4);
 }
=20
+/*
+ * Using an index returned from ARM_LPAE_PGD_IDX(), which can point to
+ * concatenated PGD concatenated, get the max entries of a that table.
+ */
+static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *=
data)
+{
+	int ptes_per_table =3D ARM_LPAE_PTES_PER_TABLE(data);
+
+	return ptes_per_table - (i & (ptes_per_table - 1));
+}
+
 static bool selftest_running =3D false;
=20
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
@@ -390,7 +401,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *d=
ata, unsigned long iova,
=20
 	/* If we can install a leaf entry at this level, then do so */
 	if (size =3D=3D block_size) {
-		max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
+		max_entries =3D arm_lpae_max_entries(map_idx_start, data);
 		num_entries =3D min_t(int, pgcount, max_entries);
 		ret =3D arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, pte=
p);
 		if (!ret)
@@ -592,7 +603,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_=
io_pgtable *data,
=20
 	if (size =3D=3D split_sz) {
 		unmap_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
-		max_entries =3D ptes_per_table - unmap_idx_start;
+		max_entries =3D arm_lpae_max_entries(unmap_idx_start, data);
 		num_entries =3D min_t(int, pgcount, max_entries);
 	}
=20
@@ -650,7 +661,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtab=
le *data,
=20
 	/* If the size matches this level, we're in the right place */
 	if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data)) {
-		max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
+		max_entries =3D arm_lpae_max_entries(unmap_idx_start, data);
 		num_entries =3D min_t(int, pgcount, max_entries);
=20
 		/* Find and handle non-leaf entries */
--=20
2.47.0.105.g07ac214952-goog

