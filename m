Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE5412BE4
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894749; cv=none; b=SR+cvwXLSsuyXJgDi3DnvhWsj01gIkBhTzEBPotZDJJDykJBfvI1QsGe1Ho7jZqjuPKj2dfrqJ+MVeB9BeZuMuylzTS8MTtcJWH1j6sO92CJc3Mi6JEDnL5aSpOw33E+UnGEGS4PieGDDl1UUwcdF8D07THwdt9DRwYHaiJHcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894749; c=relaxed/simple;
	bh=cNVcbuAwiuPvbW7gIOTu7dEHjAhHHDNmMOS8HQkVoFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ieuTApIbPkL6V4WFK2ZCWOMg+qgrayCF31QlJMPNa2iiL8e1YAKD5Db7HXD8TZ1aGOxqQxxvE+6AfBKGG2x/FmBCw3NF881Ah8Hb3UBjiqn8GaZNWXlkQS4p5B7L5AnLTFjakrdZtqLjjVD6WzYYvkQDsUWUnxQTbwyYPN0DuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syoZ/VLV; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syoZ/VLV"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so5001479a12.3
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894748; x=1791499548; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IisvBifMmb2UUMDo1HteD5AGTapgBqr+NugNWMv+c3A=;
        b=syoZ/VLVzKE70fiQsD5ACOhlGow5InZQBTBAOAIt7xDf/IAOGANj7l9+0dszYobT7P
         7RtzK3kjkX4ZjvYWWUlchlYmqK6/u5iVD7tsHlUjQuVcIUJ9rKnqpK9iuP/cKC8zHeJW
         U9FhMkBzNFjJJTYtIkxvqVJblggfExMRJGdGQhXfLrov+OvOT+Rs7FFQyiYjnMYOa8eC
         uiVMnU/wAVTldRhGGrzi3eDRTFmMQczdZdSyg7BToC/ToUy8EX+zr2t5f+4OBzJw4FWs
         XbL+GRWLIg14Hwc85+iDtW1JBteZJ+C9f0S8wJu8hTHUwv4Sr2xH8smOPbKhSXVOzjwY
         OWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894748; x=1791499548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IisvBifMmb2UUMDo1HteD5AGTapgBqr+NugNWMv+c3A=;
        b=vuPhA21VX1MM7A7JFpkTGa6W31rFpDz8vPfj4T4NdnbTwNZAoRQ9s6LDhh3LZf2psL
         lR5F/mPTCdXBjzTMKoOVLNQ7hMRnGe08Dy69xgMPQEEOodHF6aGUBf0IpcghlSxcf7Sb
         sOoqU4WGdz7YQJyGCM7k/+8wQKAMZc5mZTOp/13PRcDSSfSnTnooeXojyj11XFdPTOf1
         aagW99pl1SE2Gi8MMz8ii3A0W4g252IjIVYaelxrh79ml12XmfkJcvPecbrqGJIuwPBD
         XKF/VJUUEZ3HWr9d3PImFp0vUeGrq7jHZSWyCnxhOcGDfTomOHZYcQqJ0nS9MePQ77kU
         XfLw==
X-Forwarded-Encrypted: i=1; AKwUvBwVrByXafzFNxzJAWyqubfY4FV6I8TYO/MOhn33f936Xyh6pwxm4r7ps4CAp+R9uYtljCOi5g==@lists.linux.dev
X-Gm-Message-State: AFuF++kcPjznzEbpm8uH9F5c3404lpi5kJhfAVkGFHJz9bqisjPNJbjy
	c1K9zoshRpwHSG7nnTGoIvq8vTqb0HhcIduXQwn6WhiiskZH8vJw/1Nwp3fs6O+Bk1c/Ue0SON8
	eHQ==
X-Received: from pgbcw4.prod.google.com ([2002:a05:6a02:4284:b0:cc7:91e8:1fab])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a122:b0:3de:6172:e33d
 with SMTP id adf61e73a8af0-3e0bcf2949cmr852824637.20.1790894747533; Thu, 01
 Oct 2026 15:45:47 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:25 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-2-praan@google.com>
Subject: [RFC PATCH 1/7] iommu: Add infrastructure for per-domain IOPT accounting
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, the IOMMU subsystem tracks the total number of pages
allocated for IO page tables globally via nr_iommu_pages, but lacks the
ability to attribute these allocations to specific domains / users.

Add an atomic `nr_pages` counter to struct iommu_domain and introduce an
anon union to store the iommu_domain (aliased with private) in ioptdesc
for the accounting infra. The union ensures that the ioptdesc layout
remains identical to struct page, maintaining the integrity of existing
static_assert checks. Utilizing the `private` field is safe here as IOMMU
page table memory is exclusively owned by the IOMMU subsystem and is not
managed by other core MM subsystems that typically claim this slot.

Co-developed-by: Logan Odell <loganodell@google.com>
Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommu-pages.h | 8 +++++++-
 include/linux/iommu.h       | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index e9e605b5fa3a..edf75c81054f 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -25,7 +25,13 @@ struct ioptdesc {
 		u8 incoherent;
 		pgoff_t __index;
 	};
-	void *_private;
+	/*
+	 * Alias iommu_domain with page->private for IOPT memory accounting.
+	 */
+	union {
+		void *_private;
+		struct iommu_domain *domain;
+	};
 
 	unsigned int __page_type;
 	atomic_t __page_refcount;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..478b64f4084f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -231,6 +231,8 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	int (*iopf_handler)(struct iopf_group *group);
 
+	atomic_long_t nr_pages;
+
 	union { /* cookie */
 		struct iommu_dma_cookie *iova_cookie;
 		struct iommu_dma_msi_cookie *msi_cookie;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

