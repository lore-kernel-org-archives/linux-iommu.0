Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021824;
	b=QrQe8NLTC8ZhvfBG6gDkzojtNOpi7ivOCjKMURy/lROFwHwbvZEFmjTaVqe0mBDag7pu
	 0dbKVrX9qDQwxTOrF7yfEXnoSlKGZRpdJaURM6r6zbc8vszW6w3rhMd1vwQiCwgcnq05k
	 p1OjBBJe15lauUL4Z/5/UucvV/X3DJHb7wTnrCDAvIKOBCipgBdO3bH/fMjRCLVU+Boka
	 f+/DqU1YuSi9nCbipD7XmPFLIGX1O7ZXBcKSolwLaoNevg83261Jgv7rvdxlKPZEmM7PJ
	 g/4MsyvUYAfzx8/+Hf1JUnkw4qBozJNstDTLy5uomJ/Oy8DM/9uIKtMtWm4WT2+B7yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=u8dEoOvFyttOe/BrdbS9Lckh8vPBq/eJHO5XvvUziD0=;
	b=Ph4/5+kV8LoeyrqC7YrUnEUgZUJIQnnepALbjHsbucnpy5yMprwAbchaEV64UUXgwOeo
	 Bm2gTPwtHp5CY5Y6AOpqt9qeVnptQR4ifnaTVCn2tCqSmkw4Am6+1wGwN1EUmpIwlKOy8
	 iMtKrByxM9KH2RvWan5qJ85Ryj8qS6yvkx6uhDClJ4mTh7nFjpeLbSKFS2nRxf4Z5xniV
	 TMt0mB6+eyzWDGXomm+FEjM9oKzK9BRJlnjn0xuN+uH7Ic4KDfRhRZRqCPnF5Pfl/dwol
	 /i04iBo982QM0qIR+BLdMqDJoSZpZXs9s2o1pwwz+xTSU9xdBObnK0Z3fQQmauT/TXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=snu.ac.kr;
	spf=pass smtp.mailfrom=snu.ac.kr;
	dkim=pass header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=BptW7VFY;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45E606A322
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 13:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD45E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=BptW7VFY
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so5140659c88.0
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1793021820; x=1793626620; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u8dEoOvFyttOe/BrdbS9Lckh8vPBq/eJHO5XvvUziD0=;
        b=BptW7VFY79NrtgIxET1q3yNdt+BNxRYMqb9rjdptuh+p2ZUv8V8qmItZGWB6Xjf3bK
         Z9qk5wiYJ3I5LN77hcS+IZFfCDQ4YCIV0ypXSMxPxzOnUvfeMxbeB1h7n1TybP2C1KX2
         wLBCtdoZ627auoLBVtLfWOxd7yPfEjiAf0YBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021820; x=1793626620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8dEoOvFyttOe/BrdbS9Lckh8vPBq/eJHO5XvvUziD0=;
        b=UG2heBCIKNhIJEoLGt2MJut0N3KRuLrNsXrmSu6nmIFZOBPzm6q4D4l5fw4QaVxftN
         3QOaTWwiK2K2fXr261ZHb98MCxUich2VNKQgjcLM1MmvCCZNkxM4dUhY9Gb2ajE82bS7
         GBGHYS4jvtHyJXwVpzvw2hGQrw7SNmj2WwqEbE85gBaqxR40UnfMrmtBX4P2ZU0PU6D9
         wimk1yYMYSEj4g2yZmHEB6ve7btpxMKE9FSI/xBPTuxtpTUCO52/Qkl8/xex96CArsIA
         K46NI7I9UUMmsyo19xWJMymMR7TuDxpAthd0Rnks/Dw1p7ObPYp0ZB2Qk4h8KhxmrfPz
         rAqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrII1ZHlVy5cmmdmBFSqoqz2Ne7u4I8dcr/3Y4mi6+i3/X2U93MVLI7MEXFi0L8KoSCOK9Jw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJnCjOVJmHQ0MlvkEv28hoO1fvc5gWlMJiqrQwyYUJKcuQBZKK1
	PD9tiyJKAKJtoKvsrE1vPfjHLIe2z092qeYU37y2vcFLPXIFFZ62Gbb7qsDRzLf1VVOEmEJNP4u
	NKFaUF16lxQ==
X-Gm-Gg: AYBFou1KHa+syletPL2HvPNggIpX2toxjxLyjO7FrkogRci5XTTo/VaVG62w2drPuZK
	+9O79RCgnU+9DIE94Tu9yQYP1zx8hA3ZEnsVUQBjglO7WcC3C3xsClnVYvWSowniOOMJojYKGkq
	go2V0szSBtx+mMzG+ISOmA7ll/ZImplWMp7TPtIbdKDZepDq149EekJB7K2n8AO5YFGxnv2JCVA
	dpxSM38vzcZFeaJ7gbQkuIxDjDXawbvluGcTvKJpiLTPW7Aky6cgGYxrzl75S+Hf93zxUAcqxFE
	7W16IxZHm2kzHfqYG8TuAnd2AppvkoT8Gc5/nAo7Czk57hFpUsTTQki52aqkoxc8vUUZq15Y8Ag
	vrBsL8oCHxvK5Ns3Udhh4WTDndtoxVUXs0bioy7B7s5KalInaN92PpIY/+lKLsphASm5XyswEKk
	HE8UpOhkgXNol56k+KZkPdHV/1X5YwD//9W5AhLE6zgZLSDzioMao9kx48UJS62HZNJHIFLWsXO
	Xjrv6WEblhFJk13wiCMPdn4joKoKXaUwxwIkWQiXIQXNw3Jmw==
X-Received: by 2002:a05:7022:150c:b0:191:ac4:55a7 with SMTP id a92af1059eb24-19934a96e58mr10119771c88.23.1793021819831;
        Mon, 26 Oct 2026 06:36:59 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm22432520c88.8.2026.10.26.06.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:36:59 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Date: Mon, 26 Oct 2026 13:36:43 +0000
Subject: [PATCH 1/2] iommu/io-pgtable-arm: align next walk address to large
 page size
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
Message-Id: <20261026-iommu-arm-fix-missing-dirty-pages-v1-1-115b6b1cc0f5@snu.ac.kr>
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

Align down walk_data->addr before the increment by page size to prevent
the missing dirty pages on IOMMU_HWPT_GET_DIRTY_BITMAP ioctl.

As Commit e21952d72b47 ("iommufd/iova_bitmap: Ensure that iova_bitmap_set()
handles the full IOVA") mentioned, the requested iova range can begin in
the middle of the large page (e.g., 2MB page block). So incrementing walk
address by large page size (e.g., 2M) could bypass next dirty'd small pages.

Fixes: 4fe88fd8b4ae ("iommu/io-pgtable-arm: Add read_and_clear_dirty() support")
Cc: stable@vger.kernel.org
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/iommu/io-pgtable-arm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 476c0e25631a..01c3f9cd5d9c 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -821,7 +821,7 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return ret;
 
 	if (iopte_leaf(pte, lvl, iop->fmt)) {
-		walk_data->addr += size;
+		walk_data->addr = ALIGN_DOWN(walk_data->addr, size) + size;
 		return 0;
 	}
 
@@ -868,7 +868,9 @@ static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
 		return 0;
 
 	if (iopte_writeable_dirty(*ptep)) {
-		iommu_dirty_bitmap_record(dirty, walk_data->addr, size);
+		u64 iova = ALIGN_DOWN(walk_data->addr, size);
+
+		iommu_dirty_bitmap_record(dirty, iova, size);
 		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
 			iopte_set_writeable_clean(ptep);
 	}

-- 
2.43.0

