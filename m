Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025B78C6E
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366456; cv=none; b=nxCp9TjWPsYb/L4Edxvrr48zvIQn4zTz85bRXclTmjAZVSiC6JCsCDGbzgr0ujyBtc77LqbNaAjtcG26JFOdG3A8nPArJRfZS2tPdGQXD6A7wU9K2znAyRZGAPUt9H0atdgbo4F2pMJhwjd6CODDGnumZadX/Nr1JsmrWA08mQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366456; c=relaxed/simple;
	bh=OmtWAKQ6saASpj2ARv+RA8pwd2Z/VtPuUOeaHHH/InA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/q08u4fBU3ZgbOPiCldhnGUGST3T2wLkbS8sis/FI5Hh+cMFjWtErhO18MuDzsr2pC1XOezqs9n9nEISTHDKtx2tLi5cU2uxApbs2qednKYK1TcwnM8NNOcArjNgoh3XN4mWy2COGMMXLQbizhRioW7c+4QMmzY07ih8/aqh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hthbdLFj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hthbdLFj"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354f14bd80cso85819f8f.1
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716366453; x=1716971253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIn2hFlLwHZLk8/r/RwHC6tgKkycOicAcOyv0sMfHLA=;
        b=hthbdLFjeSP82nZpfoSZX15jX1WWEvNbV/6pM2cQblfTLo0ysfFFJUkDKBR+rhIelw
         3sj7GbcWcjfsO9HMuwMjK8gSiDpyqMi/7nmvbLHi3Zf49VggIRaU5TEXE8YoaXEpGjnF
         Cbgw9WEm/Zuwe2OlFi/Rc+I3vXPqSzLhsc8rATvIDnNkJ0O1S5xzizedvfAQ8QlcDl+b
         wuJD3qKMZEzH9Zezo7twTb/8xnEnjcp7cXBrp6rNzil5bX2gRz22oMrdvK2k1X+Zfogw
         U0zB/nLcLHmcJ6Bcr65vLUAgbjEQp7rtPILPh8SjMSBjPKMPf/QOrZzqq8QciJhiWA8G
         aR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366453; x=1716971253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIn2hFlLwHZLk8/r/RwHC6tgKkycOicAcOyv0sMfHLA=;
        b=A0NPbfb+ZF+UPfoeLbElnD1dZD/HpMG8upYbjH//6mEs+DrYS0GqpXgl1GqqjGYcVc
         RoWpUqsyeqsqleifaZQv2W8gUwzinyNFzNZhmoU14YyCNDOU0/f4O9rwWYUYC3qv+sbo
         bOyre82eDir6Ov7ZvdaIiEOO0DUWTLhhQIW1Y23/0x+shzuWGYT9rAX9UwSYGm08ZGti
         aCBP1Qv49dPVtc0jxEZ5+ORqMFWIsLhwRnXs/rOL3f85Yz7KxkaqhV6WZrGao2JhV9BL
         WoLieXGGL8nvI6jpzEwX+8ELYDZK+px/tc4ApK+MSwnUbAFUf3DkMvVp0QJ9BBHyjCAo
         7bFQ==
X-Gm-Message-State: AOJu0Yzc3TOswrr/dYwe8B3hA2KiT3y8SCfIXlpOsHtlf/iSj9akye3+
	MTbO+smZpu26opOPoFGOh1sdiTbX03GzDFkh9CZePaQTowqYbEXgFSMnpdWVv8g=
X-Google-Smtp-Source: AGHT+IEAlFXB8gX+a8kBPrsUUXrnREyr2t/5JJo3GMmaa3M1kWcv5IUaodnL7Q584OTuw2KLgCZvpw==
X-Received: by 2002:a05:6000:2810:b0:354:db7f:a6a8 with SMTP id ffacd0b85a97d-354db7fa7camr699059f8f.55.1716366452466;
        Wed, 22 May 2024 01:27:32 -0700 (PDT)
Received: from fedora.iskraemeco.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc0asm33964495f8f.1.2024.05.22.01.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:27:31 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/3] iommu/amd: Use try_cmpxchg64() in v2_alloc_pte()
Date: Wed, 22 May 2024 10:26:47 +0200
Message-ID: <20240522082729.971123-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) != old in
v2_alloc_pte().  cmpxchg returns success in ZF flag, so this change
saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

This is the same improvement as implemented for alloc_pte() in:

  commit 0d10fe759117 ("iommu/amd: Use try_cmpxchg64 in alloc_pte and free_clear_pte")

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/io_pgtable_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 78ac37c5ccc1..664e91c88748 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -158,7 +158,7 @@ static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
 
 			__npte = set_pgtable_attr(page);
 			/* pte could have been changed somewhere. */
-			if (cmpxchg64(pte, __pte, __npte) != __pte)
+			if (!try_cmpxchg64(pte, &__pte, __npte))
 				iommu_free_page(page);
 			else if (IOMMU_PTE_PRESENT(__pte))
 				*updated = true;
-- 
2.45.1

