Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DE261594
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086471; cv=none; b=jYpnO/8h1iwizG83aLlJdjkjbHgn+zvvyiUFq425QlAvKomz7gke2emhlmiKCLtBQCDV/t4MhIfJE3YrCG4YNZtNV//nMbnUyu8V47Vy6HHxPurk1vICuGsba01dONxnrbnMnzz3A2ir2iE0End/7f+0OziIV5Y9vsI4DpdvwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086471; c=relaxed/simple;
	bh=MuX3jZ3sSbwfMCn0UPvl+BEUskcLBHNXaIPs4MYUTto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rn8ZeGv5Ce+IXEIt8o2Y+N7gTvD0Io8JLxl1bfg2+lzZu0nNn8ph3pZgbp/hntBiHItK3+r92yRjj1nAuI6W9DtqEV6pyRTIa69bTy8FGXRKzZ9XRsblG90C7od44kDRI6jTv/q50t5O2b1cO6/9XiS1FclyGqqahvYFWVEDQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GI/xEnvT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GI/xEnvT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7847cc45409so317514b3a.3
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086469; x=1759691269; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdi2PyKiCCjIQ8wy03XR3Gwap8/Sh7/Zx1Xvfs/uPkQ=;
        b=GI/xEnvTpMIcqqew56Mcc5Nuwt/OQzKU2+uXHfSu3pphKoGWlF+0u/xkdwHoH6EmT6
         ZKIRb4HrgNaUfqq8v4gQd49zkf37CZrUWRQtc5xeOygBGgaY8W+XVHQwlilvsfl6QZ6q
         d0K37Wslmh5LSPmG3ikWODo8MYKivofQLoPf+pgmuGKgodmliEroRSVIvis9B8qQLlj/
         PVfp0U7MQLodkuSdil+muwsWTMYls83yz587kzvPu1/xVbwsljTy3mIfBOS67sjCufW4
         +MjxmfEy9U7rDdkfgqJc41O9+B+LfJ4aVCaINK1Hi6EAA4kFXyuPIvJqcB4JuT3QzV+c
         Z3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086469; x=1759691269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdi2PyKiCCjIQ8wy03XR3Gwap8/Sh7/Zx1Xvfs/uPkQ=;
        b=jy4Nw2xaYgNKfVq66VM+rUHvD1tQQHd6XuAb9l/6BOXKziemnLmvRH++gU03W6D6ld
         NmSoED9LBd/ni65oTtD89kLh0owdRfj7IbLm2AuqomRcnpGRTbu1S0fIBCDrJyoVOUDj
         6oZg0J79yen4ovEyslu+JyVFksnwiiUyfahENR/S6HiXmD27hi6jJRHeBDaxUFi4Blov
         O+U5aHDPt0XlH9nJKTg7ND3nrfpB+6kP+M9Kmd9oQw1AP4RgLVeH7zhZznCrrXK3Ml/2
         4mGUrzY33fHB38iRO3jmt7PgMWHsOe9/LDxAcKNrWcWCu0rDRSdXuE2s9O63Lz7w/Qpd
         hKpA==
X-Forwarded-Encrypted: i=1; AJvYcCU6rtU17tK3jNoQpm+8LEWra3FGsmM7XgAqMd2uMeiMICcKGX1+UOoADA1zpCA9uGKgWt4bfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVIEHgVpAcrE2DEnp9RZOzSEDcJ8VWuk4FWytmRK5sGT3ZlypP
	l36C9N4l18EEajIiJki09UW9AsBZjjtb7Y2lo12GHtnWwzsrC0W5Sv6WtPOH+Ki4ASRi9oiRSNE
	Fqk3lFp7Bf9WUfQ==
X-Google-Smtp-Source: AGHT+IE9CnlJcLdiotMu3CPWOFGa4Qbbs3VcUOyfssl5nXIo/nwxXTHS8424T9CoJW4l01vDjDvbImmW+vK32A==
X-Received: from pfbde1.prod.google.com ([2002:a05:6a00:4681:b0:77e:468d:c50d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:80ec:b0:77e:325b:f614 with SMTP id d2e1a72fcca58-780fce1fe2bmr12364767b3a.12.1759086468856;
 Sun, 28 Sep 2025 12:07:48 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:13 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-6-skhawaja@google.com>
Subject: [RFC PATCH 05/15] iommu: Introduce API to preserve iommu domain
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Add an API that can be called by the iommu users to preserve iommu
domain. Currently it only marks the iommu_domain as preserved.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 include/linux/iommu.h | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bfa7c8653720..2e6e9c3f26ec 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2002,6 +2002,10 @@ static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
 	domain->owner = ops;
 	if (!domain->ops)
 		domain->ops = ops->default_domain_ops;
+
+#ifdef CONFIG_LIVEUPDATE
+	atomic_set(&domain->preserved, 0);
+#endif
 }
 
 static struct iommu_domain *
@@ -2054,6 +2058,22 @@ EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 #ifdef CONFIG_LIVEUPDATE
 DECLARE_RWSEM(liveupdate_state_rwsem);
+
+int iommu_domain_preserve(struct iommu_domain *domain)
+{
+	int ret;
+
+	lockdep_assert_held(&liveupdate_state_rwsem);
+	if (!domain->ops->preserve)
+		return -EOPNOTSUPP;
+
+	ret = domain->ops->preserve(domain);
+	if (!ret)
+		atomic_set(&domain->preserved, 1);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_domain_preserve);
 #endif
 
 void iommu_domain_free(struct iommu_domain *domain)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 40801d8eac61..aafd06134f5c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/atomic.h>
 #include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -248,6 +249,10 @@ struct iommu_domain {
 			struct list_head next;
 		};
 	};
+
+#ifdef CONFIG_LIVEUPDATE
+	atomic_t preserved;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -915,6 +920,11 @@ static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
 {
 	return iommu_paging_domain_alloc_flags(dev, 0);
 }
+
+#ifdef CONFIG_LIVEUPDATE
+int iommu_domain_preserve(struct iommu_domain *domain);
+#endif
+
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
-- 
2.51.0.536.g15c5d4f767-goog

