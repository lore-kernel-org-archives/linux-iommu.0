Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6110A1E
	for <iommu@lists.linux.dev>; Sat,  4 Oct 2025 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759548643; cv=none; b=dvQoqTRvfA501H+u/hr2gD6WqZxxCLiOip2jPIn+PkKWCkb/gsjZ8Cv5Jh+zRqNxN1wTXuRwtwCFOul+PvrnV79sUXuL6EWXpf6/UicgQC1Qs+NZE6nBDTCkNb9+fb2w0QWtQOAk9JcIzjwBUYxPxytOtE9CGuMtrT0npxItBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759548643; c=relaxed/simple;
	bh=0c9z4SuRFiGBPFcUXAMN7ywy26aeUTsJfjovJPLNtJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ti7HBKzqh+YbvrkrjqN8N+iIT3MZI7gqgyN/UBN6X4T9Rbtiy/ofLZmf0GyfPvnjrdMGT4MBMiQOkiu3ZwYDF0lbEK0ddD4gt+uzqt/nwC2QHV5nztkq/8/uwv9bWPLKllt5aiTs8bPbeeyZcJKEMsQmfXR8FGpYB4ZHMwVchaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNI9nbgA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNI9nbgA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-273a0aeed57so50701955ad.1
        for <iommu@lists.linux.dev>; Fri, 03 Oct 2025 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759548641; x=1760153441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiutd4RVK94JAmVmtepdZy4JLO6Phqgp3QTqvVC7OFc=;
        b=HNI9nbgAcSWkqbfLhmUo6qfV2dLsNdPkc3S2XRjVMX/w1s+U8XQEfzTfGDAPL24SmK
         3U3ElEOmegmImCRs4lXdMownPHZE3pvCHh16e8cARyvqaFSzBsuMCrJTAli5zHDnO/DC
         URlDys4zgod/gY82sDa+RIrOfQYgdtWi75o29D0qmMK0xNiS5/e1fBVtzydXju7KZSN1
         mEu/luMs2hpHt/L9+lC22e65HQJNhja3mmeL4h3uuc6cFSVclmPcuQrQ+cwz2ctbg2J4
         xhcjDJ+rlbSlc816K1MnT4nWAd8RsLuLj5eluM24hWHtXqAoXYGAc4QUIWRzQfNCKsXH
         xLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759548641; x=1760153441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiutd4RVK94JAmVmtepdZy4JLO6Phqgp3QTqvVC7OFc=;
        b=INA+J6f/YA/S3wt6O/aL3HrCxl5zimTDpNbsUxXSa1gUjuBkbJ/zLJLzRwdSP5HvBr
         132MQ+QVePqkD2SAZM46pYSO24vBdLEuiGwaFRb4rMd4LmvEsycPtwdUuFaaNB9LLj5p
         zaE0DpqBNs62r20L3ipTaw4aDTtBZSB+0N2zsgH76P6nRlBzO2ctV621EJcB/Z4LUtZg
         5dXzjM5hC0k++DAWPmj+QrMkpbq8A6TGxCKWtRRY1EZlHRr4i+OQES3Bw3l9colHScgO
         teQmzWYIYZQPH6desSqQh7VlYDQjVBlCu6KiQuiZfr/0eeasRwXL0hX1O1ZDtbDv+nkU
         LW7w==
X-Forwarded-Encrypted: i=1; AJvYcCXRjDXR8GGpQ6zrBt89vPrckvcSM8Ogmwx+zfdvUv0XX8xtNezAC1tIg213x7lGFOJiGPLcKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp+HxNHjngrrgHeE/7097dz+i2tTsO83ZLUh275tEczLvIMtGM
	CadY8Zct5D21UmIVG47/jo3P/zTOK5cOcU/Wb3sU0TTe1Vqezy2X8mhT
X-Gm-Gg: ASbGnctUQBLYc/R3G3W05xp8wQV6MaTZO71m3ewnLhYFIiolW9+0hPEy0beEoobb9tD
	SCZr0hpm+w7YltZwxlOBJD2bKbkf3+VvyXDOtxpHPfdXzDZZUpg1KvYHqFKHo9p+mew+rVPz0Ct
	15CfJueJJGo2uqisFAVWzS4LVYqyFTT+zrZMTvCUoq++tfOlcJxgF3H6UrvkTMe+EQRT0kJKQPB
	2tIGI2dpmDkVReX8ed6r7JbHz5Nwx3AMN/Av2mUS2zP2RP20VfRZ7QQmJ84uWhX4aKoF7BZjgPY
	ij2+hT+BIUTnYo3a6Xn3+rAZ59grqPQ/wnyrowLEoCoDGfSRRyromdGK8lxw6mv+TJ2h2Y7BQnu
	DZOBH4t9y90yLQr/lhQJP+s0JOIt3HqwHDwysXBN0tSN+rtLIHuaLLy+mONDQ8Iah8+Lo22cq
X-Google-Smtp-Source: AGHT+IGnSnK3Jadih+8ztxMGZHFLoCmey9SXzZ5BNJm+bZsYDVSdTmF5KauP0zWMC8R6eaI84W4ugQ==
X-Received: by 2002:a17:903:1b25:b0:271:d1ab:17ce with SMTP id d9443c01a7336-28e8d0e8395mr100457975ad.26.1759548641069;
        Fri, 03 Oct 2025 20:30:41 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:c5aa:36f3:14cd:8995])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-28e8d128041sm65070625ad.37.2025.10.03.20.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 20:30:40 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] iommu/pages: use folio_nr_pages() instead of shift operation
Date: Sat,  4 Oct 2025 00:23:51 -0300
Message-Id: <20251004032351.51150-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_nr_pages() is a faster helper function to get the number of pages when
NR_PAGES_IN_LARGE_FOLIO is enabled.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 drivers/iommu/iommu-pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 238c09e5166b..3cb8fcc39066 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(iommu_alloc_pages_node_sz);
 static void __iommu_free_desc(struct ioptdesc *iopt)
 {
 	struct folio *folio = ioptdesc_folio(iopt);
-	const unsigned long pgcnt = 1UL << folio_order(folio);
+	const unsigned long pgcnt = folio_nr_pages(folio);
 
 	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
 	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
-- 
2.39.5

