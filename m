Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF732693C
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716633; cv=none; b=RTk1myHvr9WPvHfJ9cyknzSRfs6tbZ3t9UOq0vpfBiEZX0/6YqDuDFcuZgkGXFBgF6juIjU1HAPfc1VWvG7x0w7ogixRpHC5bMQgW12yAcLO1kkuCNTDQdjObDJXgQhWK2YHwK8fcLTPWVD9RWvTQ6XC1XNKJJ1HmwXtiTjPnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716633; c=relaxed/simple;
	bh=6yCwLBcKiXoZq9j08KyuRZPpkWux1GUluhqH1QHBI78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k6XODVYJNn0dN7G1C4DmtU0QkXEsozCMiC1Ek0mVqPMNTFNHdI4n+PMaV2+86IVgsh9SUCBo8Q1ZgLhrI9JBpCsEf3jG4/TTpOjXQV4bhT2s0/R11RJUXNp5DEeOE+7FwYO7+0RzMVDwT+4BWLuBAkA5FQNmDyBxl+NgFBgHssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWqJqSuS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWqJqSuS"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so8719453b3a.2
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716632; x=1765321432; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoHQCBGzPSDpvQ5DzInIR79EwOUsOY1qK0FqcY4HIv4=;
        b=AWqJqSuS0Xx+xbXELZVlEyNDRAPca7EwO9ibkLB4/kCSxA4Mu+kJJk0vwZiH82eAOa
         U6wo2hDn2honBEbUfgtZ7LQJNzxF3yis5sRlKxt5CmlY5Erc+Lc6wtfoG0ikmZw6KPmr
         aMd6acyXUMe75lU5l3+pq7g5/XFh8mNmuXqB7uYOBV3Mh3bKNK0FrlFwvApnPHvW54cM
         XWTWknUjIM/XSVoxA7UlE9EzGU+JuUUpBmNFR5Vf5jVMv84A8ZBBo+H4pMGUbAlMWj1w
         ETo5LQdP1Yue8ywcwCHHwK70d1psn8Y4gtF3+7N6kD7AAdqs2enC88rFycUlNGmfeS8W
         WBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716632; x=1765321432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoHQCBGzPSDpvQ5DzInIR79EwOUsOY1qK0FqcY4HIv4=;
        b=cUYTSq6MfxttHfPjOK6mSwt2L4aniQabOLknsCJMDGn5j2uSKALQA2u9JDmsjcr9xD
         x91r+eUE0HDkTny6Ep8RFj06XiOrAWv6RXjC0oAJLjyE/NrKybe+kILQrDGA2dKfnkMj
         c/iVwFvIMQAM1rYFF07fjy/+qInu+aqPtRtAx1Q9gn30dDmnNXUHWsqumpaijBBiC+Ps
         hHzSvEfmvF1xfWJkQSM49XcYAvHoqBL5DZHdskw2Rbm3NOQG+1FkHhuH2OiOO0QUKe20
         J9dzH634A6bGMV3dClBtPJ3ds9GpmaW0Ri02zoy9uqNzev1/eb65toDiTVgp5PG1troq
         qjLA==
X-Forwarded-Encrypted: i=1; AJvYcCVDwdUtDA2duSIuCBzRVTDW0Y1XaGs1l0hfc688+DgM1mjEfzTLSwWF1YUmfU5f9cLMn5BzlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDOiYQ++kSxbeRpxQedYiegwLbgh4dPrcMxklKWcYop8o9NFgt
	Riiti1LRuoiD5jK8E8RoAozGuzVofOtyntghQk7AvNx3AmNgzrMPsmg3pCxAQ1MdLxg+r+YArNZ
	os9HhFirADm7jXg==
X-Google-Smtp-Source: AGHT+IGW+6rA03ZuLTRwo4SjZcwu7oAYjLwvoTqMmWo+/draSw9w3sgyh7vdayFCGmUTbGpk/CiiUpJej64Q3w==
X-Received: from pfkq12.prod.google.com ([2002:a05:6a00:84c:b0:7b6:ab18:1c72])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a09:b0:7b9:a3c8:8c3a with SMTP id d2e1a72fcca58-7e00983092fmr192890b3a.7.1764716631726;
 Tue, 02 Dec 2025 15:03:51 -0800 (PST)
Date: Tue,  2 Dec 2025 23:03:01 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-32-skhawaja@google.com>
Subject: [RFC PATCH v2 31/32] iommu: Allow replacing restored domain
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Allow replacing the restore domain with a new domain after liveupdate as
the restored domain is going to be replaced and not used for anything.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ad47597baa04..b3cda7d044ee 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2290,9 +2290,12 @@ static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
+	bool allow_replace = false;
 	struct device *dev;
 
-	if (group->domain && group->domain != group->default_domain &&
+	allow_replace = group->domain && iommu_domain_restored_state(group->domain);
+	if (!allow_replace && group->domain &&
+	    group->domain != group->default_domain &&
 	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
-- 
2.52.0.158.g65b55ccf14-goog

