Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E051FCAC
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910816; cv=none; b=h36VdQnzUAuSpPA/AxPnzVouTEaSHwMra5vv//0DfLrLnfhOuHBw5SNZBPsF9ehyPp58VWedJ49iwvvOdpkOwavy6tx9Ai6LGhQOV8QroonKzPwZfBLxr0LLDCStcLK1+BfzVoRnVyJqC9RPPwxxRq4dXiLxgumt2CIMSpswDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910816; c=relaxed/simple;
	bh=s6xm5xGCBjDdmzPSVyNR3aQ8ZEGeMfYGDHFgVN1bRvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keLTUGuuPw6Zg/gfF/7V5mjEvp4ukYongz3Ezei5VXHoZ3lC96TdQsbXlL3lWUmG3fphPPOXO2ScYgZglbYlZxB2ArPcQZjrMDnOSpJBw7LEBOxjSMsp+e1SQRyj70HK+Hg7+XKwA1/MJZ7P/h3t1oW7xY+1zUuXe0d1QL2PqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba+q0Byo; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba+q0Byo"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-81ba09a5d23so56668a34.3
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910814; x=1792515614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bwxVaq2ksRwIQCdDWrzJYHR4z+d7pSrUOkNdZaCLjGQ=;
        b=ba+q0ByoOBlU1HhhwlIkw9AaYRswqkCPs/AoPe4xa7yah8Z43pWk4OFQhdqDpsRC61
         1Y8mb6rG3AXKNiZvSRbANLZFaNDFUBPf0Ekz5GW36XOPRCQ2FPlbIe/U7kJvBiCn+M1X
         OQbZTB7/64TNO98DuFFiomq07tJVjQo8JmVAY8IGUt61vFMaoUYX8JErGa3oSaEBmLeU
         Tlfi4Lc7Tr4W81J6aTna3BWlwgrCR/E8Z6twlmsBCNIFyubGmmAvbtmIJb4CgBlJgX4I
         U/w6LyMTqo2kmRcgjF0h1nDK8eEX/dC4dSgL7h61Rny4o4C4v9Bv1R1+QHt28fFRddZc
         pedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910814; x=1792515614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwxVaq2ksRwIQCdDWrzJYHR4z+d7pSrUOkNdZaCLjGQ=;
        b=RhUg7zICL0tc9vGvsWrJzSBu7thOgk4MRrwvDwXv6Cxek7aneKoOsKOSJJdwtW1S/N
         wd88HPhaI/vtsrxWMildp3AEWv9O+c9o1UprBlZPJSf39/MCMTGt4MzmMfGjwL/UHHiW
         jOtZOEnzk79Rs/rc7LiQNa8lC3TZU5Dl6QW+xhfkELTJGzFw8xw+YUi8P4vWu7Y/BeFx
         cYURvIP4XuN3+7VDfhyzEgZNzZjfSgvXjWAQPEuqn5EjQKdU/xLJEN51tad2HFkc98UC
         apLa9hKepesqWePdsortPNaRxizUHRU7UbppX3bNfSbixx3x9P/JISOgq6c161giP3MS
         RFBA==
X-Forwarded-Encrypted: i=1; AKwUvBzhEnCrVP4FZhgpwxd+6WnghudrvdS/hGNDaiPWjm/Qboyncekv57dCxBA0BpWEzAIHEVSLrA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI366CNs62Q3U8BTicfSnJ8MkU/sFoMpXOU9Wk8GRD4Rmhvn63m
	z8re9REFYBybWTLtko3F2+WS0GL0R6IsuQg/M5vXIMJ6z/p3JxiAdzzt
X-Gm-Gg: AYBFou1EfzRlMol71f9WJ5zrfqB3FvbsF7zJ9iNw7vyqgbNO6cYOnueHp2ROnA8YviQ
	F7Z6ae1RJ1rTNXeRpZrwwZjoh3J837BeyL1F2ZQJnjOM7LPZ4A8g2FNeNpGLaIJy/bkbly5irOX
	Pgjad5Yfty7oKvgsQmQi2o8lRbVBprFiwyepJ1O7f+OUaURMjX5dY3/yczmAC60WkXnOuvSveMP
	5xGREl5BVcAxSFsHchVvsbQj5onQ+Pmn8O8ijlhKBrd5C8SHNsLBD5CTstx7xRuWSls38o4QzNe
	may77SCxo0vJuYReDxuDSwyUHX441mwtppxua7+I7OT6DrtCZPdSbGWBJ8dZnhNIow/p5MrBKKs
	r5Zdu9zdBxGYRCAExIuMBEDk276/bctJ4CeFhFqHtQyF4mJIyqQmMQQqp2Ui3iyA2hoNMi1g37E
	2tX95XE+Mj4KnlbYLmcWF7ajHywCss/9jxgRpYhX6HovGQsRTYkM15Us564uG4gd/IjeT+clHcq
	EGdp5xg6R808dSWzYigXRHELo9EdlXpYyX7iXi1Nr8zArx5fNh5UqU3cUAx2a9lHPU=
X-Received: by 2002:a05:6808:130f:b0:4c1:5614:acab with SMTP id 5614622812f47-50c532f8aa4mr11754186b6e.37.1791910813978;
        Tue, 13 Oct 2026 10:00:13 -0700 (PDT)
Received: from 1u1g-b650-0212.nvidia.com ([72.25.70.131])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe916sm15298147b6e.1.2026.10.13.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:00:13 -0700 (PDT)
From: samarth.colleges@gmail.com
To: Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [PATCH] iommupt: report the whole contiguous group in read_and_clear_dirty
Date: Tue, 13 Oct 2026 09:58:14 -0700
Message-ID: <20261013165814.3092559-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samarth Narang <samarth.colleges@gmail.com>

The record_dirty() function computes the reported dirty length of a contiguous
(multi-item) leaf group as:

	end_index = log2_set_mod_max_t(unsigned int, pts->index, num_contig_lg2);
	end_index = min(end_index, pts->end_index);
	dirty_len = (end_index - index) * log2_to_int(pt_table_item_lg2sz(pts));

Here, log2_set_mod_max_t() sets the low num_contig_lg2 bits of the index to all
ones, i.e. it returns the *inclusive* last index of the contiguous group.
However, pts->end_index is an *exclusive* bound, this can be seen from the
definition of pt_range_to_end_index() which returns of the form "index + 1".
Also, the iterator stops on index >= end_index. Therefore, subtracting an
inclusive end from an exclusive bound will yield one less item than the actual
length of the contiguous group.

For IOMMU dirty tracking used by VFIO/iommufd live migration this silently
drops the last page of a contiguous dirty mapping from the migration
bitmap.

This patch makes end_index exclusive to match pts->end_index and the span cleared by
pt_entry_make_write_clean(). Also, the same length is passed to
iommu_iotlb_gather_add_range() so this fix would correct that as well.

Fixes: 4a00f9434891 ("iommupt: Add read_and_clear_dirty op")
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -248,7 +248,7 @@ static void record_dirty(struct pt_state *pts,
 	if (num_contig_lg2 != ilog2(1)) {
 		unsigned int index = pts->index;
 		unsigned int end_index = log2_set_mod_max_t(
-			unsigned int, pts->index, num_contig_lg2);
+			unsigned int, pts->index, num_contig_lg2) + 1;
 
 		/* Adjust for being contained inside a contiguous page */
 		end_index = min(end_index, pts->end_index);

