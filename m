Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CE123645D
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858269; cv=none; b=DfV+pfvaY7kvQ3f6PP97R+g3YVv0H+/jNIPkA3bfSMqAQeXc216jXjphCrBOB87FtCoo5/NIeyzo/VnzIo/GpTb4tXXm4Uo4zj5NoE6np3ZUqStpukQTWxydJxxOPaj5Ec/L41zWSA+1dKpRwNSmgb4/DyDHA+GqMXXifQ0lWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858269; c=relaxed/simple;
	bh=DL/I39VWp/7CJui/ohWSCpeXrcyY2rJch5NlzLdxeFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/jYQKKnJ3y17l/ovymGJiHNnAz2smpVJk32KdVtlACXrkv2nO2L53j+AUgPwL2Vq2OdCBbaC+phPX9Mp7oXi2Optf1j4khmPe8pdywVvTyrEKElsHang2mSvSnYMHBuLnR+h1WMILX5w0ldGY+b4StFt70bgqvadj7VMpZJFio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PbqpJzvb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbqpJzvb"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64d2c50f0d6so8422554a12.3
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 09:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766858266; x=1767463066; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+W6sOlw2zXBDnyDOozxSeUj9x3Kz+fCohpTNuGuaoo=;
        b=PbqpJzvbdv4sxkk/R8B0NJt7xzo3oPDwY+7DqzmmgzfP+NMIC7vYpFXWD5C9E3nYGf
         RZKFj89I2Vb9Xi2GYuae167SOFe9Na3fLoA1XDLQ7ICr8NaqfJyZz3qPRiqp+6BShUBs
         J5/GGSKkUIj/w2gVi0QHGLGS2BWasX/Y1WKWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858266; x=1767463066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+W6sOlw2zXBDnyDOozxSeUj9x3Kz+fCohpTNuGuaoo=;
        b=PQ6hYji0iEG3wo6GAtRjy94mFFzhnG5klr0kyBn+rsaKVa8qhOjjU0zvP6COxnsZpB
         bX24VC36MMafrTIW0i8smTAkJ85nWiG5GrxaUODQoZe+6Vwynwgs+3+69Myagey2PEIX
         LfM2XBzY/+a1wNKldWJZXzzj5/1XjcEjmPfaXNc7SvOyTB8djRQK0kL07bzpVHTyk/0q
         LKHbVh889kRDYmODWC6D0Q3fPhvxd3gbBj+r2Gj460rGCyEUzo28KsaZDKScFDIMq7k4
         OxfCvg5VGrzLrHriNL72fkIaFUvq1rMw77hkO+iwEAbqxL6JEnPCPWsB3lOOjmJITOk/
         ICbw==
X-Forwarded-Encrypted: i=1; AJvYcCVhzAuJYJ2WP/wHVSvO+KgYwsUXNZBOkZX1tMU85O53TPSlNfnk+k7xRUMK7+c6R100UOyTpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ9C56ETaiHAvEcbWhIDrHRYZmNB1hWH/Ov2UNGkKBY7Zxwz+N
	ywSq+nnHoj0QC2xCTko6cOKm/17XZOULcz4xDNqVuc6vF3EmCGkzW0P/SNDX4JLLcBBxqEprCLV
	Y4EI=
X-Gm-Gg: AY/fxX4YJI2uYTgF4Om2q+nSKqLjtNOH+Yke0sYeDg55fEM6NvU+l/uGLWqWstxZR+s
	U0mWNpVGogu86PYW0Ec6PnFtypqh8GJPkS60spnGIdUouU7VTeZ5K9Mn958pww2axYeiknM4req
	BFj8SzFTk3WF8zbWV9RWt7Ub7nJ5SyKWs/HSiRMxhJ9RGGtvZu7FObthWceNBx7acrOJ7bf2CTL
	K6FGDgiomsPxNjlAcRUkWDaRP0Oyhw6KjZs7htDh09fWvcwnhU94clQF5YxUSV6T74BpFP9R33J
	pNS1w3S0gtitQQXbv5SJZsViRowy8sWydKYPLbygDPZ8yG9q8of0NgcTJ6L8P3wNiZqdl6dURYV
	wkYTsIdJYvsKBHEb2WhYK2VKX7tSK2MWB1tRlriCQv7h9DnUoSWsnGb0Rv/AK1+OsAzKVgKDZ2r
	0lCTQhP+tig15bTTntSCUR8R6bojp32cP4/S465274
X-Google-Smtp-Source: AGHT+IG62TJLHHJFuWaGi70eIXKakEOO9GuSS8nGGYDZzcL4RhbAQj/mok61syj4bdN2OwKnDOwMYw==
X-Received: by 2002:a17:907:7f20:b0:b76:69d6:f9fe with SMTP id a640c23a62f3a-b80371f1939mr2821226866b.60.1766858265989;
        Sat, 27 Dec 2025 09:57:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:3d12:d2ea:4ee0:347a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de1421sm2793889166b.41.2025.12.27.09.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:57:45 -0800 (PST)
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
Subject: [PATCH v2 5/5] iommu/vt-d: Use WRITE_ONCE for setting root table entries
Date: Sat, 27 Dec 2025 18:57:28 +0100
Message-ID: <20251227175728.4358-6-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251227175728.4358-1-dmaluka@chromium.org>
References: <20251227175728.4358-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like context table entries (addressed in the previous patches), root
table entries may also be set up at runtime, when DMA translation is
already enabled (e.g. due to a device hotplug). So to stay on the safe
side, use WRITE_ONCE when setting a root table entry, to prevent the
compiler from doing store tearing which could result in setting the
present bit earlier than the context table address bits.

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 134302fbcd92..fe4d0d210a5f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -374,7 +374,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 
 		__iommu_flush_cache(iommu, (void *)context, CONTEXT_SIZE);
 		phy_addr = virt_to_phys((void *)context);
-		*entry = phy_addr | 1;
+		WRITE_ONCE(*entry, phy_addr | 1);
 		__iommu_flush_cache(iommu, entry, sizeof(*entry));
 	}
 	return &context[devfn];
-- 
2.47.3

