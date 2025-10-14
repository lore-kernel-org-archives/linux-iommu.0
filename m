Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D359302153
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459063; cv=none; b=NJt5P6Dga2fR2LtfYquXqu4VMCk25w5E7RGopI61l65LLvm/QPEDy1nlkJoPVsU2n5wvHqg6sYf9TYrl3CloaxVzrBUATXb2m9cdr8GuvxAmEjmSbjLMVtN5lS4ycSViaaO1Mpxrs567ZU/sDjKzxvJo+U7INzjhP9E74SJNOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459063; c=relaxed/simple;
	bh=LtEzRYO9NQcP2743giCq2ceguBK9etlZq5C5sGGoq5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvPvpW6uu9FXoXpRF2cd0ftv42MI/75aKH/8B5tJCTDZyOEqFNW7pGGzDCOT1+SElg5ettmNE2NrIPl76OTrCCPfrXbN4mE2cpHp15jXo78avMNn724ygg57budch7USz6zoOv9UyAIwx/SySj5cbAuboiwIhFBAJ6AhGa51glE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net; spf=pass smtp.mailfrom=aashishsharma.net; dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b=AlwWA0Nr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b="AlwWA0Nr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782bfd0a977so4664889b3a.3
        for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aashishsharma.net; s=google; t=1760459061; x=1761063861; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMKlR//4XojOS4N8WfUmrzNmreZndJ+EmT0aEkEBFmo=;
        b=AlwWA0NroqDHgihc5bZxinnkKmsjp+5sdbMcXtVk8ANIx+4PDtvOAe7DF/rp7Yajc3
         YtIB13GqbVVypnLVDFmkhdKXQGM5A4MZyo1rIKdB8vPfafZ7a19RLelJ3DAxq/+CBD7c
         Ua8MM0d4L9xx4G1DB01nwzZ8RTc91Caeg6Xz0rWxwaJI9WoC4Dp+zypC8p4fCI5FlumU
         g0o/nstjM9FYo7W9HFrDZZPosHpIIYoGLB9Rw1YZrQhkWRxox0QCVdXv01a7srk+Fwxh
         jSf/yEDm4kfWPGIpKzIexhWVLd8e9i3QYWlr9jyMNHtEE+CZeZnpcagUo/TSXZqePQo1
         jf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760459061; x=1761063861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMKlR//4XojOS4N8WfUmrzNmreZndJ+EmT0aEkEBFmo=;
        b=l6pt5NBofXn61ij3mcwX4u40Z76A5bXD51rKx5+14i5nadHM7nJgC4bSRR8zel84/g
         Cm7wKH3iLAy0hLUsmrJKJpJLgBPLD+AH0gbjXB00W/1XkgSpc0/IFXhDu5Zwm3nlV79a
         tjbtvpeubOA6nC+N+l7XPLmlWDuMQUa9V7tPlqHim55tJlFfPZ343NPnIPZs3T+DKOFj
         T2paFRWA60hoRMAkaSVxisAF+OWUa0A/5SgoigVbUVG0CSYdVauE6SAL15+oxAVwaF/N
         Hltd2IbbdOOFsRgP8AOfhvPU09X0/MLZ9szKfOBfcJ7ZUMgeMjB0/xFNlYIEU5ZwNOKq
         1aqg==
X-Forwarded-Encrypted: i=1; AJvYcCWnyJcfPVhaGQDu0jpiqwTYRLFjaUoJjJaJ6zPgWyla32vFC66Zsy773bTZW5mamWZb/HgtmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoLx33d0ixoSh5GN8qWZ2yMBMMe8T+yycDbAjsOby1p3R66esR
	aynnckKPC3lioWOjlXQNHU94K9FWy8vbnfAaXlf9FNdFBiv6nTGOzlpl6X6neUdP1Iw=
X-Gm-Gg: ASbGncvRU8rE89aEuK5M6jKMuCdxlfjTbNtp5ZTPj8nnOyNBIa3glq5/1/YrCzBDo+T
	57TfmcflQWVEl3KaT34wk7nmY2BDUb2l2B3DuovSyjm6niSEn1tg8GD3bCt6NJVsGPlIHqDJnKA
	/mChp7H+Uy0u74CWo7jIBRySHco30IM99IeKAOkLz1GKUe1tswFr5XK7znJ9MdMjmivH5eKLeV+
	odhA+ygfr8SeOptYydfEE679OQf8JeEcs2ObcDvLxhAWfLBuFB25fA7lPOc7r7IeQQEQFM7nKIG
	g0WXEZaM11cdski80HpBdBc8ZiiwRxY+6dMaFt5iWVHkXUKO5h7djXx/ij2fJqbFB87SSYUZgQH
	X4rwfbqMIrEQta+bB4KnGEQW+0kbSedACmbQjE11nRCrm3wxxGekpXRYoNKMjGXi5GPUVpFg9Tf
	aIYoWQNSLr+Cz7RX5fuaJhW2UShmBHBBmtjuhBh8z27AZqxPoVdw==
X-Google-Smtp-Source: AGHT+IEjBc/W3YmIEDxLsxWvWRwpU1Kl+Rqt8LvtY6hFaWkAvgkSm2RNpuZl3fYb/NDOwWXt1tuL3Q==
X-Received: by 2002:a05:6a20:12cd:b0:30b:2a99:4424 with SMTP id adf61e73a8af0-32da813018dmr34034402637.17.1760459060534;
        Tue, 14 Oct 2025 09:24:20 -0700 (PDT)
Received: from shraash.sjc.corp.google.com ([2a00:79e0:2ebe:8:f1d9:835a:a3cf:f8b0])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7992b0606f0sm15986721b3a.15.2025.10.14.09.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:24:20 -0700 (PDT)
From: Aashish Sharma <aashish@aashishsharma.net>
To: Vineeth Pillai <vineeth@bitbyteword.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dmytro Maluka <dmaluka@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aashish Sharma <shraash@google.com>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: [PATCH] iommu/vt-d: Remove unused code in dma_pte_free_pagetable
Date: Tue, 14 Oct 2025 09:24:08 -0700
Message-ID: <20251014162408.2217563-1-aashish@aashishsharma.net>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'dma_pte_free_pagetable' is only called by
'switch_to_super_page' and is not intended to free the
whole page table (0..DOMAIN_MAX_PFN(domain->gaw)).

Hence remove the code that checks for this and frees the page
table pointed by 'domain->pgd'.

Signed-off-by: Aashish Sharma (Google) <aashish@aashishsharma.net>
---
 drivers/iommu/intel/iommu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e236c7ec221f..3b3ad7b0c0ce 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -883,12 +883,6 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 	/* We don't need lock here; nobody else touches the iova range */
 	dma_pte_free_level(domain, agaw_to_level(domain->agaw), retain_level,
 			   domain->pgd, 0, start_pfn, last_pfn);
-
-	/* free pgd */
-	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
-		iommu_free_pages(domain->pgd);
-		domain->pgd = NULL;
-	}
 }
 
 /* When a page at a given level is being unlinked from its parent, we don't
-- 
2.51.0.760.g7b8bcc2412-goog

