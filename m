Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A702367CF
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766320522; cv=none; b=e0i0r8T7N9FOecFhS1jEDZROMxKTMMLqUZVlzUNV/pqoLXVBVBuUgQ6ziG/wZmU8GjD/WfwplbqBIrRAknWIZmQw2lZQQvV0d4quGDAIrID2y6H7NL3DrQSPmD2OZQOITmI/jpNNX7/07RlyKPBup2YqPOkhtqg9sMjfqI7Pigc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766320522; c=relaxed/simple;
	bh=imY9m+27lOPX/d2NlS3wpd62JpvY1Xeq/cUzqWIBgG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDObyeBNbjvgDsUFVaDEBrsE97A8M9dX/uzvYALaVGHguLDFbhU1zD7gD/doN9dsUrNQCzobM9ebgp1wFN1Whal4B04hnKKTUw5c8ZDByKzXlAkXnT5Fj89hSqe/PasN90AAiT8apoDGWUIMsCBiQQCJ7qGsp2/S0Jv+2DYfQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gg4uHoUY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gg4uHoUY"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b4f730a02so4946787a12.0
        for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 04:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766320519; x=1766925319; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgMTUrq17GdZ6a6fk/pQ7/28KGon25vKkSeBtxD4m+M=;
        b=gg4uHoUYmuFv9xrkeSEjzQ+r5RwNYfmG6zcMz34mqEtwwOBEWqToyViEj7eA2P/xY1
         WISU/KKREIAH+HPj1ibj0Yl1zifUv0BGDLJx10Z6lwqsVBm5cf6jmjv4QW1ZKvxDjD9y
         ISlpO6ygdPfnrPL7fSFFXlK4lJfDAAQgCfey4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766320519; x=1766925319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgMTUrq17GdZ6a6fk/pQ7/28KGon25vKkSeBtxD4m+M=;
        b=H95yXK6yhrcwTOdnABpaqtW+9q/XIs2mvyGJ2wMGUSOaX3xzuCJ9vmE2GW9pr7xzfP
         Uqa2oriY6fCY9ED+3G9F/DFun3pdLxha91ngugwz+h5HF455cprj64BcpeXHa+VcAokE
         sfNmzgGMK+8RqEtfeydXvd84+fihs+IA2GTYPMw5bP+CLa/VS+T0SjmaI5ckYNld/gl3
         6Ad3rz3VVlOiYquiD3Bdfs2dXPfVyLdPaNn0NXUCrCMH9BjqbTy/zB9bCYLAsl5qRV9S
         cDPOdf7D6pUFP9qDbAOQ/s5qhOrTiDHAhHo2tQCv3UmVo2JKinIZNp4c+RkGS+pX0TVO
         SB4w==
X-Forwarded-Encrypted: i=1; AJvYcCXx5Z2b95mBLxvymrN3cILsIzn+tE9WPDmFqLygU2keaE0OMOmkPIQzvLwGFl2GBNnXhB9Hbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY5u+UVx+6XrE30OJc2o7/tRCGg95+l/KCTWRQ7pU7PSL4UiHo
	jSBJW7I+top4v1nRScwz14HXtiuQAVr+2wTgrn8PtAMmAsTpgmUFAgjaFL8aUoPPfOtO1s3F9p1
	aQHw=
X-Gm-Gg: AY/fxX7xX0B6guTzj/6KqVzEye2KOHoMcaY7XVL/Te4NmDu1B2CmQ3Q1ls073Jw8ECv
	LGi51PPkHBVaKbXy1dVnCajy8bIN+tT/+sKyYPvvQB6FPDu0SWBKeCDWhrgRaH9BDSu1YiUwsdg
	yHD69ouXTVrdsBCkoOJm+6jvMuMkYXtb2LcJ4i7u+LAocMDNKdgcVSOTwHdwMj3JaAXqBLwl76a
	0woPbKk/qGJ5/dUEp7R5xEdDdzZujnacy0cWr6uweevVi30p6yhDuuvufMozYEsWnMTvH/N5TFj
	ncSwdDr31NVZISct708rUdCDG6Hq2TvnzBJc3bSrzTvrX+axpZnTbayFpaao8taTQq2xfXsv3WU
	AwRb3iQGknnotCS49cxA1letlk95UizvE27VixxIoP2fk4KjNzKzC2wOef8J65vlnoZOaNJ+6mm
	5BETqa2d96M9Sw+m07q8I9SEQxRZceeQ==
X-Google-Smtp-Source: AGHT+IH/N+aVMoko0Ljwne1G9ZENkLSuGyOYI3i6mt3tOjPQLbGKcHMrOSVqM6rtfcLFr+1EcXdrUA==
X-Received: by 2002:a17:907:3e0e:b0:b73:2b08:ac70 with SMTP id a640c23a62f3a-b80371ad2eamr767096266b.49.1766320518923;
        Sun, 21 Dec 2025 04:35:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:4cc9:1698:dce5:4976])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm736591666b.57.2025.12.21.04.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 04:35:18 -0800 (PST)
From: Dmytro Maluka <dmaluka@chromium.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2] iommu/vt-d: Flush cache for PASID table before using it
Date: Sun, 21 Dec 2025 13:35:08 +0100
Message-ID: <20251221123508.37495-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing the address of a freshly allocated zero-initialized PASID
table to a PASID directory entry, do that after the CPU cache flush for
this PASID table, not before it, to avoid the time window when this
PASID table may be already used by non-coherent IOMMU hardware while
its contents in RAM is still some random old data, not zero-initialized.

v1 -> v2:
Add Fixes: tag.

Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/intel/pasid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3e2255057079..77b9b147ab50 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -153,6 +153,9 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 		if (!entries)
 			return NULL;
 
+		if (!ecap_coherent(info->iommu->ecap))
+			clflush_cache_range(entries, VTD_PAGE_SIZE);
+
 		/*
 		 * The pasid directory table entry won't be freed after
 		 * allocation. No worry about the race with free and
@@ -165,10 +168,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 			iommu_free_pages(entries);
 			goto retry;
 		}
-		if (!ecap_coherent(info->iommu->ecap)) {
-			clflush_cache_range(entries, VTD_PAGE_SIZE);
+		if (!ecap_coherent(info->iommu->ecap))
 			clflush_cache_range(&dir[dir_index].val, sizeof(*dir));
-		}
 	}
 
 	return &entries[index];
-- 
2.47.3

