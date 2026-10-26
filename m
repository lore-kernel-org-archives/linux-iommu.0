Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021826;
	b=uK4u9ifo5E5fqA6RCO8NM6XIRaGuoDAGklYjeKUhtYdmkfIUYCWtn3RQkMs1ITf332Kz
	 IM5l4bum1v1toT9QnNJlQ+gVDZnKCqvCC9ZAKE29pn53IDYbR0B9ABxr/+uKIoBt8yPhh
	 2MopN9zXyJ9XFelNhpUhglM3moVQ7/YSYL0DW2ULlkRcDhfQXq3tAPW4wdyxjnTAQpWjv
	 vRk0oNxPuOHS09fZLkIUzImGyUwktWvlGq63VYuVP/juijtWdAMTZBaUKmGaKZpkLbWiV
	 lbbMv+xmgcLsRiD2zinMVfpknfEenD3obY1o0UrMzhotP1xGmPQeTJQ61CJFk43yQoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/4ed/RMVrv6O/H4HMl4G3Xz4VIpFThxQX+sYINSnX4Q=;
	b=q8ppaqcI42nlOtji/sWhwalWQYPRYj62b2EAj2lBhl8shCfF+1HPKDpYZUNj5uOrlBPA
	 v6rkQH+wqh0C/qWJ2bN8Y24btvz+K7MRKUpa5OVtm+qyMz9dWQMvGjlzzukF5qD9wraXp
	 k33TyH4EmTMHtGSYkSNBhI1SLzglZmu/OXGkjaOsChbvXkvFDJc2qNfkk1clojebPMrvf
	 H9PqOiAD1jG/QJ4qxug0YbUkOaLyDMBieIk3ETV83j/Dc9H07DQw/2VMSTrcIBi4pf1DF
	 8vdfZ+BKWzY9a48EiqXQNtD9OiBi+bfCI7cN9YBYE9VZyfak6w8hhZHMfzH0vhpxnDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=snu.ac.kr;
	spf=pass smtp.mailfrom=snu.ac.kr;
	dkim=pass header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=f4xxcfbF;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26949606A32E
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 13:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26949606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=f4xxcfbF
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15943c9c005so3834579c88.1
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1793021823; x=1793626623; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4ed/RMVrv6O/H4HMl4G3Xz4VIpFThxQX+sYINSnX4Q=;
        b=f4xxcfbFzfcZEgXm89R5iph54LNzFRix9IqgovcZ4+RI3OSsMHd7GUa3xFRcHh7zUn
         b4HXcehwMxOJ6vf4rny0RoGMSTWs06IW0Y60pCemP1bT0E5ywmLclx5yL9mouHx+wa8g
         35TsVBuFCJF31SQJArILHc14EV760xdhpqOVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021823; x=1793626623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4ed/RMVrv6O/H4HMl4G3Xz4VIpFThxQX+sYINSnX4Q=;
        b=lqX1Da0jIVhtm/nTia5hLgsNB1DKUpNeFWpbExlBNQ9bxv6zO0eAQUBL0GdXzEYqBW
         DW7+KwRzBNAr5q2ttyZKHoSp1zUQOYg6gdAstZOFM27UGv2mCumgS2JX/XOWkPFHIhb2
         ahX4ofCrSXeB4pTue4PhplGFE6221fH3yoj4kLtV9j04QkzwLM95kyCVMYmCtSfSQQ3t
         fz/ojHwldf+HHu+/llxKoo6UHTURt6Kjm1qCcv2KljBew28fQelsiRs+VmaiHG57Nwbc
         wrlYIgY8cN/gJejVbm8Z3lwWyKh2+qlX4KWgZMZWunuPQxkLD2hT+AL8sU4IvIB0Yma3
         fLwA==
X-Forwarded-Encrypted: i=1; AKwUvBziYQI+TzrY44QESSUBz77YhIGnK1Ig9ftYD6zpvyW1cC1hStro1lJ4iVBuC9MDANr5HwygJA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJbnT72Q/UAd/h0Sb3+wFDkK4iLtCxBqugV+mxvGr4AviilOqzl
	CfnxuZOcAABwljlQIrDIrfmEMl4i1rRAgLrf3GuWdFjk3xymv7yZ6aLyA3Cs2klV1NItGp3pej8
	boPpApoQScg==
X-Gm-Gg: AYBFou3MpXDxMR5KqfKKrNDrtUieCFE/H2aug5Msx8irs4Y4CaXHywHbW9V/jGLSyhM
	Q/o3dAZh+5bfkFjHO+4x3spLB7rfOv9AFrD6gmCiDLoxUOGGEpqSTZC+TOHc3eEeXMe9G46lrfJ
	z/RWLHQ/gdsjANdhePRrZrW+lW07aeUdYhnW5xMsPNYpJ1+b3Iz7cnvKk7RoAU7kSN09caAdTdX
	5fGOKsQiCqJRqmxORA4N6PiHqaG7AFsTUMRpEXfQ6lktnmRvByaqkMHiexRCB5MYYPROqmx4HlW
	Rans9I+4nJYHVALFvu7NdpxQypVrsp/rdUC7Yu9AbI5zD/nYCNOLmaeYYiVH0Ad+pBV9rXgO3rY
	HrOQw/kPZrMtW/77eMRYzpEVcEc4lfUrBPdFmeZaH+hqNEaBv0u5EtDqh/7P3NYeadteKFI19JI
	1NtkK8jEfGNWXegNuUBBOWUWku5dUq0rIpfMLLlcxqmQgkhpXgdLf2TVVT3uZQhMoWKWxMoQYia
	UqbPBwWc5iqlZNY75YoWBht6xVAOZsPQW529RHqeWBZskAsLa4pS60kOMl/Tc+Ghwhrmc0=
X-Received: by 2002:a05:701b:2085:10b0:190:d0d9:3110 with SMTP id a92af1059eb24-199406385f5mr9674399c88.45.1793021823146;
        Mon, 26 Oct 2026 06:37:03 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm22432520c88.8.2026.10.26.06.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:37:02 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Date: Mon, 26 Oct 2026 13:36:44 +0000
Subject: [PATCH 2/2] iommu/io-pgtable-arm: invalidate iotlb on dirty pte
 read_and_clear
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-iommu-arm-fix-missing-dirty-pages-v1-2-115b6b1cc0f5@snu.ac.kr>
References: <20261026-iommu-arm-fix-missing-dirty-pages-v1-0-115b6b1cc0f5@snu.ac.kr>
In-Reply-To: <20261026-iommu-arm-fix-missing-dirty-pages-v1-0-115b6b1cc0f5@snu.ac.kr>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Use io_pgtable_tlb_add_page() instead of iommu_iotlb_gather_add_range()
to prevent the undesirable case where iotlb invalidation cannot be executed
because gather->pgsize is not updated before arm_smmu_iotlb_sync().

io_pgtable_tlb_add_page() leads to iommu_iotlb_gather_add_page(), which
updates gather->pgsize. It prevents missing iotlb invalidation because
arm_smmu_iotlb_sync() invalidates iotlb only when gather->pgsize is not
zero.

Update gather iova range only when IOMMU_DIRTY_NO_CLEAR flag is not set,
as record_dirty() does.

Since iommu_dirty_bitmap_record() becomes stale, discard it.

Fixes: 4fe88fd8b4ae ("iommu/io-pgtable-arm: Add read_and_clear_dirty() support")
Cc: stable@vger.kernel.org
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/iommu/io-pgtable-arm.c | 11 +++++++++--
 include/linux/iommu.h          | 17 -----------------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 01c3f9cd5d9c..6513dac26e79 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -870,9 +870,16 @@ static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
 	if (iopte_writeable_dirty(*ptep)) {
 		u64 iova = ALIGN_DOWN(walk_data->addr, size);
 
-		iommu_dirty_bitmap_record(dirty, iova, size);
-		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
+		if (dirty->bitmap)
+			iova_bitmap_set(dirty->bitmap, iova, size);
+
+		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR)) {
 			iopte_set_writeable_clean(ptep);
+			if (dirty->gather)
+				io_pgtable_tlb_add_page(walk_data->iop,
+							dirty->gather, iova,
+							size);
+		}
 	}
 
 	return 0;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a36..df57ead2cc3c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1106,17 +1106,6 @@ static inline void iommu_dirty_bitmap_init(struct iommu_dirty_bitmap *dirty,
 	dirty->gather = gather;
 }
 
-static inline void iommu_dirty_bitmap_record(struct iommu_dirty_bitmap *dirty,
-					     unsigned long iova,
-					     unsigned long length)
-{
-	if (dirty->bitmap)
-		iova_bitmap_set(dirty->bitmap, iova, length);
-
-	if (dirty->gather)
-		iommu_iotlb_gather_add_range(dirty->gather, iova, length);
-}
-
 /* PCI device grouping function */
 extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
@@ -1449,12 +1438,6 @@ static inline void iommu_dirty_bitmap_init(struct iommu_dirty_bitmap *dirty,
 {
 }
 
-static inline void iommu_dirty_bitmap_record(struct iommu_dirty_bitmap *dirty,
-					     unsigned long iova,
-					     unsigned long length)
-{
-}
-
 static inline void iommu_device_unregister(struct iommu_device *iommu)
 {
 }

-- 
2.43.0

