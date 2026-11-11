Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423575;
	b=CUZzaETzSbrGBhw+QG923jJo1e8rwJH8t1x+LqDw5yeR3ugiQUknfOPO3LfFWIZAJkpf
	 Ji0aAri7GztVKlUuiC6aUrtfFHtfWUYfZ7/flYluh+TCA6qn7ywyaZDidq2QF/DUB8jMX
	 euDqzH8MaJfTolTjQSBOg8hYuGwPIAMS8bjAYlmbzYyzwjNBg01/qARZid7l1PVK0Sion
	 l/PmZRyT55PxP+c1sbyzQ3VSAFO4lNIB4WZjtOEzFhGO0WeJsUaq6RnzukPt8lbbQXN63
	 m7OWBJ7AYMHWEBYxNqxjSVd57uj2r6ZRpbD1n5XG0w4fq+0sZSjtyfrHBxQsVj+tx8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bNaWmjzZL0cMs+uJYhUIAi6U7mf0NFDrLgrotrfyBqc=;
	b=SP1tVWLaaVI7d6S5zxaU+Qmr7EXqBAK3qEHjlOi2SNUZtQDrEEDvXEjCX12ha4kO8BPb
	 lKT/FbWrBD8tYcdgKWvMUhM54kY5okXd6jVBVFL+98kSKEnyFwIzyfOypyhyTygrjL4fz
	 g8Px0egcD7PAVYeVauJcNRNKOMP89hb4EM/oaxH61Fozd3XqmLgxncZcALpyCM6jqjpLR
	 kndXWj0GttY+/mWr5yDl8W9tbLqH+hyB0sHiAHdn1655Nsb26LzsRoKTI7ZARrkzkgRBA
	 ukEed+BycP5NGov87KttQUlVcnm0ljsOc4Xo1LtSAslh2sMq50c8JNbKI8cZG4Xk/Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=et63g1tc;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AD606A336
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 18:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A1AD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=et63g1tc
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so30719635e9.0
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423574; x=1795028374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNaWmjzZL0cMs+uJYhUIAi6U7mf0NFDrLgrotrfyBqc=;
        b=et63g1tcGTBPDxhqXlT1zGoLvJ1UwvztC2hpMmGxIz60pf5k1vVp7OWY4UCR0+kO1+
         ufin6jv4U5GSuDfw0eh0LCqM/7ym2sXP1Jw4NfAxHElfz6kW1J04Fi1en51T2ZRqXD+m
         kO+JHinZZ0j8MxYXkWjFEScuvOTD4U0eyIVolvaXiqPCkkHFMd0+ewuEdrRJbOCdHOES
         e6d3iEjwpWzd0i+DIV178a2HZs3MnCoWt0ToRvryAIam15PksWTbuFHQ9PfL35M57wE0
         j7ddBs0KIvlxuwdQPKsb8tTvAePme8ui/+lZm5k8awXTrAwvIbrD4D0F3ODg8PgYjM9q
         gV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423574; x=1795028374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNaWmjzZL0cMs+uJYhUIAi6U7mf0NFDrLgrotrfyBqc=;
        b=uIWikDAOb1pC0w5/ySKK1qFS4n3BLznko+h+qLcYgm/XbBaiuUbTPILwfF8a11lH2Q
         e7KqwvVaLXsIWQagXdfGSvjQOnknG590j0Jv4dxj5dyl8Pii8Rq+/1Vsz868knRKOYxf
         WUCDNhsh6hjaZDq+ke5Cj8Q2o3WgG9To4A1MjIt6yqHWTjqg9opPG5sbLpiC1KjN85YN
         pVIW2Qs8VGT3m3eD8msAOujL2uyOrdBJcQ19M+4LsasmVmwqZfisy24n8379pMpKFNxM
         q3gidhqpFrzT2LlY7xZuFHtuQAGKVg9o1munTriAh+LTqxNeZ5EeBN4xPSxofoYEYWev
         fZNQ==
X-Forwarded-Encrypted: i=1; AL+hErGrcHx1F2gfXFQZ8ZUbAk/jw1xp262kvRc/4oa0tPSbxT3unjpwy+BiYz7gd6SyzoNBgCU6eA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/UCbygCk5iQsQmLcg++siYKqGRK1s2gtw0S6Xk/E/h8rFsCckU
	Q71YZ8qe9g8Md4l6l9+7xSUeK36+iJMPLF++gKlMN07QpCA8/JfOHwC1
X-Gm-Gg: AYBFou0pG/52jO7wzum1LAM6wJ7LGwcgT910KT8SUHGtb5abqliLo6ZKiI9aj1kzUuy
	rsG+I0/PB6KHeTAMdSChQxaicylk1zGZIc0zK3uU+szgZkQV5AXTOvG+Lpx2oj9KVPChfWBtSw0
	Uky+DkhvCIKVYLZ0nb9rAyoM3KdblEHHlNVNVxX3bqgVLzDIv0lhe/cx9efHN78S1FOaF2hnPCh
	OpStEfslCyer/p2Z0nSNitbpfyMqY7c6/lWJDCb7tgVpOib0braVmMbbEGT09V85P+HATlmHK5t
	QAS5oA7MaXWoAx0T4u0g0eDYF/NXM4kVNHMmByTmiodIjrcKrCwhkwyl2AswsBWVEtkAHNzMgmH
	MzKwyIaI+xQ1+3Uuj1XucvVwI2YFfNnbDh4fIKrbjZrAqpDlULOv3rAhnJ9f+6wCx80u1KJyI4F
	uLrg1i66SzmmWsQjLg/XBJyjOBlDtPvHH6gqsw5C1Ew8G4shiravFS8MOaO+cM1gdShytWviRGk
	qXgajf4R1kNP+KdW/DTvgc7PLBw/D0JTqEG4GiW5OjoIhKpWKcokbX5g4WT+YfYc3hYeE4SaGb6
	rzCeM+S3tGjsUMg6+vGcE1HFTvZ0CLemIwaczPgSFdU04OVpoQlIdLMGFykJgi5yJ8baynEnPhd
	0gyVsa1DSR+5PZfV/xx6HOTV8g6lj9g/J/Tz9a/p+bvAWjVwNZTcHif8oRZlTXvg4KA==
X-Received: by 2002:a05:600c:81c5:b0:4a4:3a2d:15da with SMTP id 5b1f17b1804b1-4ba093753a6mr56638565e9.15.1794423573896;
        Wed, 11 Nov 2026 10:59:33 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e265a0csm9161435e9.9.2026.11.11.10.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 10:59:33 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	nh-open-source@amazon.com
Subject: [PATCH 2/3] iommufd: Use iommu_unmap_sparse() to unpin domain pages
Date: Wed, 11 Nov 2026 18:59:30 +0000
Message-ID: <20261111185931.94882-3-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111185931.94882-1-griffoul@gmail.com>
References: <20261111185931.94882-1-griffoul@gmail.com>
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

iommufd keeps no copy of the PFNs it pinned for an area, so
iopt_area_unpin_domain() reads each one back from the domain with
iommu_iova_to_phys(), one CPU page at a time, and then unmaps the range
in a second walk. With 4 KiB pages, a 1 GiB IOPTE costs 262144 lookups
before the unmap starts.

Call iommu_unmap_sparse() instead, and add the PFNs of each IOPTE it
removes to the pfn_batch, so one walk both unmaps the range and
collects the PFNs. The last IOPTE removed can hold pages beyond the
ones this pass unpins. The loop already handles that case: it keeps
those pages in the batch and carries them over to the next pass.

Domains that do not use iommupt keep the per-page read-back, and so do
areas whose IOVA or memory starts or ends inside a CPU page. Such areas
exist only when the smallest page size of every domain in the IOAS is
smaller than PAGE_SIZE.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/iommu/iommufd/pages.c | 98 +++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2f6153108add7..c2a04a8845cc8 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -468,6 +468,79 @@ static void batch_from_domain_continue(struct pfn_batch *batch,
 	batch->array_size = array_size;
 }
 
+struct batch_unmap {
+	struct pfn_batch *batch;
+	unsigned long first_iova;
+	unsigned long last_iova;
+};
+
+static bool batch_record_unmapped(void *priv, unsigned long iova,
+				  phys_addr_t paddr, size_t size)
+{
+	struct batch_unmap *unmap = priv;
+	unsigned long first, end;
+
+	/* Stop after the entry that holds the last page to unpin */
+	if (iova > unmap->last_iova)
+		return false;
+
+	/*
+	 * Count each CPU page once, from the entry that holds its first byte.
+	 * Pages before first_iova belong to an access and stay pinned.
+	 */
+	first = max(ALIGN(iova, PAGE_SIZE), unmap->first_iova);
+	end = ALIGN(iova + size, PAGE_SIZE);
+	if (first >= end)
+		return true;
+	return batch_add_pfn_num(unmap->batch, PHYS_PFN(paddr + (first - iova)),
+				 (end - first) >> PAGE_SHIFT, BATCH_CPU_MEMORY);
+}
+
+/* True if the area starts and ends on CPU pages, in both IOVA and memory */
+static bool iopt_area_pages_aligned(struct iopt_area *area)
+{
+	return !area->page_offset &&
+	       PAGE_ALIGNED(iopt_area_iova(area) |
+			    (iopt_area_last_iova(area) + 1));
+}
+
+/*
+ * Unmap from unmapped_index and collect the PFNs from start_index on into the
+ * batch in one walk. The walk ends after the entry that holds last_index, which
+ * can reach past last_index, or before an entry the batch has no room for.
+ * Returns the number of indexes unmapped, 0 if the caller has to read the PFNs
+ * back with batch_from_domain() instead.
+ */
+static unsigned long batch_unmap_from_domain(struct pfn_batch *batch,
+					     struct iommu_domain *domain,
+					     struct iopt_area *area,
+					     unsigned long unmapped_index,
+					     unsigned long start_index,
+					     unsigned long last_index,
+					     unsigned long real_last_index)
+{
+	unsigned long start = max(start_index, unmapped_index);
+	struct batch_unmap unmap = {
+		.batch = batch,
+		.first_iova = iopt_area_index_to_iova(area, start),
+		.last_iova = iopt_area_index_to_iova_last(area, last_index),
+	};
+	unsigned long iova = iopt_area_index_to_iova(area, unmapped_index);
+	unsigned long last =
+		iopt_area_index_to_iova_last(area, real_last_index);
+	size_t unmapped;
+
+	if (!iopt_area_pages_aligned(area))
+		return 0;
+
+	/* The range runs to the area end, batch_record_unmapped() stops it */
+	unmapped = iommu_unmap_sparse(domain, iova, last - iova + 1,
+				      batch_record_unmapped, &unmap);
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(unmapped % PAGE_SIZE);
+	return unmapped >> PAGE_SHIFT;
+}
+
 /*
  * This is part of the VFIO compatibility support for VFIO_TYPE1_IOMMU. That
  * mode permits splitting a mapped area up, and then one of the splits is
@@ -1689,19 +1762,33 @@ iopt_area_unpin_domain(struct pfn_batch *batch, struct iopt_area *area,
 {
 	while (start_index <= last_index) {
 		unsigned long batch_last_index;
+		bool read_ahead = true;
 
 		if (*unmapped_end_index <= last_index) {
 			unsigned long start =
 				max(start_index, *unmapped_end_index);
+			unsigned long unmapped, batch_end;
 
 			if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
 			    batch->total_pfns)
 				WARN_ON(*unmapped_end_index -
 						batch->total_pfns !=
 					start_index);
-			batch_from_domain(batch, domain, area, start,
-					  last_index);
-			batch_last_index = start_index + batch->total_pfns - 1;
+			unmapped = batch_unmap_from_domain(batch, domain, area,
+							   *unmapped_end_index,
+							   start_index,
+							   last_index,
+							   real_last_index);
+			if (unmapped) {
+				/* The walk ended on an entry boundary */
+				*unmapped_end_index += unmapped;
+				read_ahead = false;
+			} else {
+				batch_from_domain(batch, domain, area, start,
+						  last_index);
+			}
+			batch_end = start_index + batch->total_pfns - 1;
+			batch_last_index = min(batch_end, last_index);
 		} else {
 			batch_last_index = last_index;
 		}
@@ -1716,9 +1803,10 @@ iopt_area_unpin_domain(struct pfn_batch *batch, struct iopt_area *area,
 		 * middle of the domains we need to keep reading pfns until we
 		 * find a cut point to do the unmap. The pfns we read are
 		 * carried over and either skipped or integrated into the next
-		 * batch.
+		 * batch. batch_unmap_from_domain() already ends on an entry
+		 * boundary and needs no read-ahead.
 		 */
-		if (batch_last_index == last_index &&
+		if (read_ahead && batch_last_index == last_index &&
 		    last_index != real_last_index)
 			batch_from_domain_continue(batch, domain, area,
 						   last_index + 1,
-- 
2.47.3

