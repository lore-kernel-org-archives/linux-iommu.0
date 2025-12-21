Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48CD126BF7
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766276234; cv=none; b=rTWd+9hd56YNOEQKKyqbkM9xRxteprXEpVcxKRgvBQWDhrFpYQ0/3uO0YRA1+YFQAveHB3x6gRU0tyTkvDT3MZtMQP7lrYHkn77zqriuect5OM5AQtbsEOHO4LQkvclbGUGz60qB0mdkNW+VcYOocOe+v9xIslxodLZmnJma5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766276234; c=relaxed/simple;
	bh=zXE7ExR3jFutkunUuO/rZjPsY//fUF8LwQEkLzUTJTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQsUp9+t7wXjoHUZCOLB4EPw83HBLr3vQweXosV7W/mhlDy/uAo/qgy8cqq//JGtl1kR/kMwMb1ailCuml0gW+df9qFUdhMRrm8szRJq7E/sQASWciRSAk2wNAErJJ5Zgt3LU6xSDPxC+QFxPtGM3cG5LB0FvYTmK+SIdr2QyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=evIn68bB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="evIn68bB"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b8e5d1611so2833377a12.3
        for <iommu@lists.linux.dev>; Sat, 20 Dec 2025 16:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766276231; x=1766881031; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ju1r0eD783g5JEzeASvcYbt/dKDQzzQquJmGnwZ1sKc=;
        b=evIn68bBkUj+B6JLkquKg7cR64PgbQXptdrkIHmGvagnppgjJM8MWPlv0ZeYJbWiIx
         QGHy0BBzwbeLuWEjtismWodrANcRtVSZg5H6snWZ9PNkJjyPSQAl5AAXjmINvV2DesJD
         H2Km8dzmkCp9OaukqdV6u2UiuKfVzJ8n6NE5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766276231; x=1766881031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju1r0eD783g5JEzeASvcYbt/dKDQzzQquJmGnwZ1sKc=;
        b=Mx6uMe5LlnsRyoVS96PenJguAGLvrf7DudN+CzQ1SqsmCB679P2WFhY8yApE/Xz0Mz
         L8q0goh28B74eJqzZBVlAe4E7bwFxJRNgBo1hHsN0/7Q3iA2L7RmG6p/T3RYAYv+tanN
         ADfJOjrcXjGSwoOEn/h5oHyg1HeJh11hUWq9OtQIaawTwuP29qomAbFikCJHeuypbrV4
         wK1/VkrbrboKFbbFVIO7p1EVsh0014FEFfc9BsYfHynS3AwLiFun/0dGZjluowfTF0hl
         oBxlN2KVtvEAifIkcKzbVuvB6N71q6UgFjhb4Yr2OQDaygc1zehZqejgLVifaxgldZ4/
         NkRA==
X-Forwarded-Encrypted: i=1; AJvYcCWZZDU3suy3pHndFi4h+fzxa4OsHkl1XSwR9OLpjxOb6qGaLZrNWW4SBDD5ARSALfPIs0gVMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuCweXRnhX9iWqyqPbrQc4jy9wjeGEBMSMvYp5mTSxWrmKzW58
	kiGbpcq/giBEtE7XEC8HuI6UNtIzDvvFP7RtR2Lw6rICyCvRiRpSg7yd4GoypSiOUw==
X-Gm-Gg: AY/fxX6JOGzyH8vi5Ihv3YFkbogdkiTmNyiB9A36pfDzM65U5M+5Cp1h/6wyCXS9HCg
	P30DEwtTQL61WYgfNpdL9yLkUa6tZS8DLkPb6fi5IdWWHSXowwRmiWDy2Vfw/3PlJwktOUGXflS
	I57v7hEbA9XNgBV2FVlCU8PeV3Wlvzft13A0F6ubMK5u17uHROykd/Bil/M70gngv71+RQA2dvk
	CynNQ4nE3UsdZruJdHTmRTeJ2CAQusMsa0IImceBts3QECBmeUfoUnH8HbFgZyeFyLLko89BLHZ
	1FWKlWEkOgMkXq7Zag3u751ZQk7VVrhU7wGXueFJ2EcU+NybHXazbF6pbbWyna2xN+gHM8PzrCS
	2vZdgX5F1Xa2aRsGx9ytTDMHBp3tTguk+BiIau5wj0Mvn93sWRse2MHf7JBHedlN6wgUTL3Q1LB
	+ssYEQAQQerW8xtowELTenqQzprEFdzw==
X-Google-Smtp-Source: AGHT+IGXJqIQJJJwuEv6xZ2w2hVrsRqr1hd+Pfi6a9Atd1O2E5eFY8oFHbAaYTZD1A37I0gAV2SEFQ==
X-Received: by 2002:a17:907:d8c:b0:b72:6143:60c2 with SMTP id a640c23a62f3a-b803722fd2dmr731511866b.51.1766276231024;
        Sat, 20 Dec 2025 16:17:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:4cc9:1698:dce5:4976])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f512e3sm624321866b.67.2025.12.20.16.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 16:17:10 -0800 (PST)
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
Subject: [PATCH] iommu/vt-d: Flush cache for PASID table before using it
Date: Sun, 21 Dec 2025 01:17:01 +0100
Message-ID: <20251221001701.3626-1-dmaluka@chromium.org>
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
2.47.2

