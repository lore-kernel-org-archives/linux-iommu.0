Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021823;
	b=u14DFbDVL+H6vjH5lS95fAq15iWV27uRaUK5i/soZlZtbfsB9R9/fyWcQGR2CrQQ3KGD
	 suid8HK8db9z1MjG9HLug0Ltc1EjCLpDjgxI682rWqkNtMB7qN4EwUVaAsYBrIeEFCRkm
	 rgYnSbP+dOa8NsR46EIOshwMJAsV7cNy8zAAw+VoFEHo6dzlxHst7lHljASHedOdBdhHU
	 qGsUJJsW2cZTpuE6OtT/tr52odhjH4e8v/nPqhpfmnqgPDTQnQvyt6GZPRyTfTd0hKeJq
	 FOI1RQreFmJyp4S8JQmKFM+JhBDkWFLw33Ki0rbG8QJbUgrPlTkVMdT6iuiUa+wDKTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=5tMMGpxtoQZxq0cbe4boMn3nqRQBhfDysNVoo7AMAY8=;
	b=i9CqwUCjtCrGGbTU49PSwkq3DTE3HpZKKuv+8g/TF4iiUDDXtOaCx4XMACCYqwdR4jhA
	 EHB1OhSmMiO8BPqt+sIt3dcGwybDieg8itZ0yUahAP4bdsHsT6c6RlcxMn+is10sYOzKS
	 wwQod/7RytlEINSWPJx6+vxY5l49dYCojzH/RLVpVI72kbcZi1521vScWm4Sq7HAgRnLb
	 OvpUttLOEtUb6VexC1WnRcTWpgypV7wOSzQL4PLq8HQBwfLa+dyyuihxbmwe2N9NUS47h
	 dhafZBYfpNmwleBMQNDlQmLvmyskZ0eXeQl6143H/nwNPdjy016sinENf/2fadRD+YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=snu.ac.kr;
	spf=pass smtp.mailfrom=snu.ac.kr;
	dkim=pass header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=BK2+3AIs;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77549606A326
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 13:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77549606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=BK2+3AIs
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-170135e43c7so3001113c88.0
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1793021817; x=1793626617; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5tMMGpxtoQZxq0cbe4boMn3nqRQBhfDysNVoo7AMAY8=;
        b=BK2+3AIsA7LOUcxD9hAR6IVWuXu6G23vCG8RYtpcMq2lvkgTCKnjgUFU0sGYWa6gBW
         //iVo3KY+ghprp23/AYIO7WXDyKfNIF/mUELmquOuKmKRwjRAXAj5enyxnO3q1yXsDYm
         UQGGty9YLw2JC+PExdAPy1XmavxaMYcP9P3Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021817; x=1793626617;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5tMMGpxtoQZxq0cbe4boMn3nqRQBhfDysNVoo7AMAY8=;
        b=05UV2L4tfH8yBRD4oSLcSK7ofcrTgyg287XUE4nfIECjEY2pNXZ27V+gUQ4S73LFQz
         CSb/6DFbZCiS0QzdOr74n5/KEesgYFjb/FMZ72ebhK7l32J6fRq9L65G+NHXij2kRf03
         2nejv5HYmz+96OKhZgJxkBUTem5fM2cH8dcvsnCLwbVzPcglMDTqF65hN5aCfY4qfzzk
         qENqPriGrRn0gYtcoRGGY6WHBDvo7o+gyw9gll002IuyhkFxciVFNou2YQ0Fm8Wx3+lM
         5w1E9FzojCJH7MFq95HivdnL9WALOYksjarCeX7hKnMmSbBtPgH/1VXilXsPB0diFZus
         0xnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrdbYTA5YN02aw0hIrxLuQJscrj5YEz8u1euDGhqQXouwcyomwhu999s9wGiY1jsgRXSSo3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLPRDKpSBwZX2EfdaI/PrjlCtXlBqIJfom+SDUMFKN8dG+xYdKc
	Za4IOJ8bLP/m4QCj77dYsQtUbx//Sbq7cjSaO0Vy+upwkdZzb2vbLlqsgmh9Vi1mc7M=
X-Gm-Gg: AYBFou2mjnXXgqRp+qm27ljjRbS9VkxXqD3890M+lEACjegNahxfG9QY6LCEDb6sd5Z
	j1r68Hjr0W6IT59Ebq6T+9a9KmSYiC1nH13UY/6SkolGF2z7NqYNY1Gg9AVLFc3BMeAoTN42yJC
	9wN892AkouaBm/Uni4WmP0VVYJIbA4s2BiULSRszGVzwU3Uihmi88Oz+Lfa0JpZAirfDdK8Nq9f
	1ogWLHTqb258KK8S5Jvff+BD/YA0Bro0yrl/sf6aK7/oNbGzXRJF1upy/uJ8XXiyRimfjUbfViI
	6Hni1jlYHgK1xiRgc6sHw1z1XLDyI9juASqXaE6Kn+sSMd9wSc3xAuPQhY04RjCcTZvOogQxm5a
	J/rkGw8cWTaCDxVEnKSJ+i+GZdUQx3s89aMSNl9lTzv08pp+fAD7aUyd7yXwablx2T1tIQ+7FjV
	+VG5JW7FOlKuzwRkPLfpA9GJGaJyshCEcXLbohGzQGugrveszsm4iTicrNRKtNl9Uw0FtYOkDIb
	wIdDZN34h16uOkyHPyAoiZWfDiSjFrOJfdjCsJKeHL7xcR/yg==
X-Received: by 2002:a05:7022:48:b0:16d:1e24:5cc3 with SMTP id a92af1059eb24-199375eb24amr13097855c88.19.1793021816370;
        Mon, 26 Oct 2026 06:36:56 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm22432520c88.8.2026.10.26.06.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:36:55 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Subject: [PATCH 0/2] iommu/io-pgtable-arm: fix missed dirty pages in
 read_and_clear_dirty()
Date: Mon, 26 Oct 2026 13:36:42 +0000
Message-Id: <20261026-iommu-arm-fix-missing-dirty-pages-v1-0-115b6b1cc0f5@snu.ac.kr>
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
X-B4-Tracking: v=1; b=H4sIAGpX32oC/x2NQQ6CQBAEv0Lm7CQsCqhfMR4WGdY+7EJm0GgIf
 3fioQ6VVLo3MlGI0bXaSOUNw1xcwqGixzOWJIzRnZq66YLDmHN+cdTMEz6cYYaSeISuX15iEuN
 j355iP4TzEC7kO4uKp/+P233ff+UKJCBzAAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Fix missed dirty pages report in read_and_clear_dirty(), which is
caused by 1) unaligned iova walk address, and 2) missing iotlb invalidation.

First, align down the iova walk address with page size, noticing that
small dirty pages following large page block (e.g., 2M) because requested
iova start address can be in the middle of the page block.

Second, use io_pgtable_tlb_add_page() on visiting dirty ptes instead of
iommu_iotlb_gather_add_range(), which is called in iommu_dirty_bitmap_record()
and does not update gather->pgsize, so that arm_smmu_iotlb_sync() does not
invalidate the cleared pte from the iotlb.

Thanks,
Seongjun

Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
Seongjun Hong (2):
      iommu/io-pgtable-arm: align next walk address to large page size
      iommu/io-pgtable-arm: invalidate iotlb on dirty pte read_and_clear

 drivers/iommu/io-pgtable-arm.c | 15 ++++++++++++---
 include/linux/iommu.h          | 17 -----------------
 2 files changed, 12 insertions(+), 20 deletions(-)
---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261026-iommu-arm-fix-missing-dirty-pages-3754a7b18b19

Best regards,
-- 
Seongjun Hong

