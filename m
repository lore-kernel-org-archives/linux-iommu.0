Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94F30276C
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716611; cv=none; b=iPxERozw3CuPX15anP3mTM3/bPBNwOQKsgW9sj98MUZLLOzJg8PIEOCjseOprfFOAAF6oHsus2zsXZn7mhq6dj131mj5xOsGfQOUgsBpnQa0YNhGH4UmNqIm7+Nb6Ife03pNc8l0A4N5ZE4zR96lwKoJGWUowSg2Tz85/oJuwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716611; c=relaxed/simple;
	bh=36vW0LRvLHecNEnY2jgru6ZXuQIH1vkcBCSVAaqLS44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kk7QbSzt4wMyi85ywwiScCFRsAHqc7JkJuotnkbej8+BReass8y6bY8YRq50kgUOa3A7GfPpsK0NIcwFXHBh2qWuzMflqb2SaIXX0dPyzceS3/DwF9EpySSFexlZZQiCykLc/bQU8er+jktKb7n8wWl1kPRFLPIQiKeHVzRGB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZkWAl4F; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZkWAl4F"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34740cc80d5so10306015a91.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716608; x=1765321408; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxHt/lxJ9sA8YqfRD+B040fzdPrSl2jrABjOraLTn5k=;
        b=DZkWAl4FCwl7JNRcVFeCrL+yegjud1y0PeIv4vA9wzyMlWZxr0Wmh5WEbEi4aCIFT2
         YNei3KbNFv5QMo9ic8WHUsSwgoZnQhBkuE5sTSjlww7cg6jN6EL7Kkewk8a/WHPk5C9E
         qz6DbuqOH4wXxLCIWY/f9VbQ5sdFajNu1qLroXNuSOCQxFQj2u0tCn3vkHMbV7Wpqb+N
         dvHKOnDb0Ca3b1rirLGy6iguYB08RSe83TBmnfx8rIsUHXnBojHlNA8zdUYy2fH+ReT+
         AVpqkHZnoQkt+rdHoUWN/h4xATpzHlhauvvL3hQPFweJup5WmkDg+BK03v8kz8WqAiym
         GSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716608; x=1765321408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxHt/lxJ9sA8YqfRD+B040fzdPrSl2jrABjOraLTn5k=;
        b=wt9eBTSwTvVjd6R2vGFO/Ufpm/8E5m/fsu2mfJoiRx6Zf5vI7g5eFJ5hQ9+voed1C7
         pwuvBEcoJabsvphbQjkgQyDTbr8qM8oGMv01Hv4ds/WW+/OrOwcpv7TwYujo1n2jGKCL
         xUeHJswlm5u8QlMAt1xiC8Rn0aRkfty/r12+FWCaQzaEJR/k89ACSN8tzRGfqFiOEwOF
         MHOUPAK5ZyLZFSTtuVkhoWTir8AwX8QvSZkV939rSbHYZMTKwpP/JtbqGTlYBrmlSGh0
         b5bOQ7BePpiAlEuBdEpJOFcjMiLlMPHJx1WEpFmOozTdqjSqxmVY0GH8KA3BE79z8c0s
         TfYg==
X-Forwarded-Encrypted: i=1; AJvYcCV1UDSpDe8MCPdRNSXakYofbVypf4drQgsSE7iEZ0ivsz+hoQvG5M+vUDEu9CFVKgqcJvll2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKd/o1KcqsY1a27ZgVxEPk5fc9kp1tihgpQL+3CcoC45gu18zj
	L8isfc04qFFAjXwzO9F99Dul4pb57ufmccZDvYKO75VyXLTSMYtu/VDz/qjg1Q9/QOZWVw4DXX3
	1Un0BeNv2dPeEPQ==
X-Google-Smtp-Source: AGHT+IFcpULNKUZmXeSYQ1ZNC6yjpROI8wM7AOpJPAV8G6bvsn/dYyjO97uR+VZPu8akMJdZRvDRGw/LVoOSqw==
X-Received: from pjvh10.prod.google.com ([2002:a17:90a:db8a:b0:340:b55d:7a07])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e07:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-349125ac8aamr320566a91.4.1764716607835;
 Tue, 02 Dec 2025 15:03:27 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:45 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-16-skhawaja@google.com>
Subject: [RFC PATCH v2 15/32] iommu: Add API to keep track of iommu domain attachments
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

Keep track of iommu domain attachments by incrementing and decremeting a
counter when a device is attached and detached to a domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c | 18 ++++++++++++++++++
 include/linux/iommu.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2ca990dfbb88..a70898d11959 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2041,6 +2041,7 @@ static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
 {
 	domain->type = type;
 	domain->owner = ops;
+	atomic_set(&domain->attach_count, 0);
 	if (!domain->ops)
 		domain->ops = ops->default_domain_ops;
 }
@@ -2093,8 +2094,20 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
+bool iommu_domain_has_attachments(struct iommu_domain *domain)
+{
+	return atomic_read(&domain->attach_count) != 0;
+}
+EXPORT_SYMBOL_GPL(iommu_domain_has_attachments);
+
 void iommu_domain_free(struct iommu_domain *domain)
 {
+	if (WARN_ON_ONCE(iommu_domain_has_attachments(domain))) {
+		pr_err("Attempt to free an iommu_domain that has attachments: %d\n",
+		       atomic_read(&domain->attach_count));
+		return;
+	}
+
 	switch (domain->cookie_type) {
 	case IOMMU_COOKIE_DMA_IOVA:
 		iommu_put_dma_cookie(domain);
@@ -2140,6 +2153,11 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	ret = domain->ops->attach_dev(domain, dev, old);
 	if (ret)
 		return ret;
+
+	atomic_inc(&domain->attach_count);
+	if (old)
+		atomic_dec(&old->attach_count);
+
 	dev->iommu->attach_deferred = 0;
 	trace_attach_device_to_domain(dev);
 	return 0;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 17e1f3c29958..387cbe20c83b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/atomic.h>
 #include <linux/kho/abi/iommu.h>
 #include <uapi/linux/iommufd.h>
 
@@ -250,6 +251,7 @@ struct iommu_domain {
 		};
 	};
 
+	atomic_t attach_count;
 #ifdef CONFIG_LIVEUPDATE
 	struct iommu_domain_ser *preserved_state;
 #endif
@@ -917,6 +919,7 @@ static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
 {
 	return iommu_paging_domain_alloc_flags(dev, 0);
 }
+extern bool iommu_domain_has_attachments(struct iommu_domain *domain);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
-- 
2.52.0.158.g65b55ccf14-goog

