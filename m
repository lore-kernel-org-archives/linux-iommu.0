Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8F2FE564
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716601; cv=none; b=UUiH5Zhlqm1Cyn0Stl7Emjf1Qk2xLZOxpv7RHIT7hwo+gqsGMpR6WXLSTW6ZCI72cWX/ET4kU+0EbPZ3wJ0HmiAepD11XgV3tg6s+dkdFqnCHcq0JCXTu4kQ51YrVoiq7iEfRlJppVWAN12KuGlj3hSmPLErbc8GAvQgxqi6Oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716601; c=relaxed/simple;
	bh=YSmq0yG78SIhhrn5ApWl7RzW6e0hroL0OkcAy8Atix4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HK6myCuwXl0fCwRrgflGyIgATGtsZ7Ou7lhPdsXGe0Vk1qYC6VvIXRLiDJYHCsla53b2sNPpNBXzo8Xse0psSmeSNA91aI1xtf28stCG/Gukvbi969SUUjMtkSTv5ITF5O5rQMamuRlZViZ3nqni1iAWy6Rqa7K8U5WiZHjmVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fr5tBWH0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fr5tBWH0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-341aec498fdso7064723a91.2
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716599; x=1765321399; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cM+3ehKU/CNzGWgry7jYAitYzQXjOhGOPbAFQSj8uE=;
        b=fr5tBWH0ylwCEkKjE2d+A+kzFfjdnpK4j3FphSUWq3yvAd3MQJodPumpIxwSiONAfE
         nFc1zkO8yBizHg4VlKA67KabgIcvX4AfqWRMvyZoARPeuKLUPatpaFTkQNaD1eJGR5CF
         EXKpAxd2jQ6vbQyuF1K0IKmlmYvMl0heNFSkHWiNnJrnI33ExvKbB6mfStghyuDylwAf
         gtKr3gltsvCN5CkpxFNUGSszUGXo0Wcbo6a17Ia59sZDItMU7YPhK7FLeWZEphwhI+Al
         O34g4VapBCuW582F0x/A5M88SsOY3h9bpgAXsNfr+82ihdb3dWePe+djA36/y9X/atpH
         qNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716599; x=1765321399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cM+3ehKU/CNzGWgry7jYAitYzQXjOhGOPbAFQSj8uE=;
        b=Knry/v/C/yP1Wg6zkFAlpM+b/4x62UPyx4OCoWQnx6VvHkb/KWwFUXtplBhRIIQvYk
         uhaYSOVMrtkWmRD4qpZaWaegUkotbU7SZqraWDp1tdQrkkfH3t7ZkMvNnnIKes2Atu+X
         gyf+gBF5AnExxplMmo+Las5nnpR5RJQIiNk1OaNUf1QS13C3RVE+Jq0vmP5LbbQBzTwt
         xPB11NTOsbtWtdvrliUizLvDcMRoZmzIwMSuK3eMF19ZQ56SNDtStWvvkbZbqZP2HCrj
         OO0aUuHgt1Z3ZiWx5stbVAkA28jy2+/BIpQZtdFOAynJiAWY0/lzdEnQcteborGGuehj
         Ceag==
X-Forwarded-Encrypted: i=1; AJvYcCXVzpkc4LORLklp+lABsHyJAZO8KxNSZGPs8te6F6JzwkR/yUcoVh39+XBGKh4SGatwK6dsZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyip4VpTr/+M0yWCzHnCWPBmyfMHvGwoK0CIgV6Bx0KEnmKfeJU
	NSpn0O6ya2xxcGF4mCFnv1P3iIVVmuHUyK31GYZbMrw3gi4XYR611W08XuarEf10R3sjQ7cDkE8
	B8EWegVoiQYda4w==
X-Google-Smtp-Source: AGHT+IHl3tmM/12z0QbzHN1WFIFlVAimglHtD+5GB+h7fFPICsTwFpyIIaKbzcGgUffmd8rDxP4PSEt5zRrmbQ==
X-Received: from pjyv12.prod.google.com ([2002:a17:90a:e98c:b0:343:6cb7:a68e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a0c:b0:343:7f04:79c1 with SMTP id 98e67ed59e1d1-349125d2e23mr313127a91.9.1764716598614;
 Tue, 02 Dec 2025 15:03:18 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:39 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-10-skhawaja@google.com>
Subject: [RFC PATCH v2 09/32] iommu: Implement IOMMU LU FLB
 preserve/unpreserve callbacks
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

Use KHO preserve memory alloc/free helper functions to allocate memory
for the IOMMU LU FLB. The serialization structs for device, domain and
iommu are allocated.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c | 71 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 93e5691a8c1f..21ce7be9b87e 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -10,15 +10,84 @@
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
 #include <linux/iommu-lu.h>
+#include <linux/iommu.h>
 #include <linux/errno.h>
 
+static void iommu_liveupdate_free_objs(u64 next, bool incoming)
+{
+	struct iommu_objs_ser *objs;
+
+	while (next) {
+		objs = __va(next);
+		next = objs->next_objs;
+
+		if (!incoming)
+			kho_unpreserve_free(objs);
+		else
+			folio_put(virt_to_folio(objs));
+	}
+}
+
 static void iommu_liveupdate_flb_free(struct iommu_lu_flb_obj *obj)
 {
+	if (obj->iommu_domains)
+		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, false);
+
+	if (obj->devices)
+		iommu_liveupdate_free_objs(obj->ser->devices_phys, false);
+
+	if (obj->iommus)
+		iommu_liveupdate_free_objs(obj->ser->iommus_phys, false);
+
+	kho_unpreserve_free(obj->ser);
 }
 
 static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
 {
-	return -EOPNOTSUPP;
+	struct iommu_lu_flb_obj *obj;
+	struct iommu_lu_flb_ser *ser;
+	void *mem;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	mutex_init(&obj->lock);
+	mem = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(mem))
+		goto err_free;
+
+	ser = mem;
+	obj->ser = ser;
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free;
+
+	obj->iommu_domains = mem;
+	ser->iommu_domains_phys = virt_to_phys(obj->iommu_domains);
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free;
+
+	obj->devices = mem;
+	ser->devices_phys = virt_to_phys(obj->devices);
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free;
+
+	obj->iommus = mem;
+	ser->iommus_phys = virt_to_phys(obj->iommus);
+
+	argp->obj = obj;
+	argp->data = virt_to_phys(ser);
+	return 0;
+
+err_free:
+	iommu_liveupdate_flb_free(obj);
+	return PTR_ERR(mem);
 }
 
 static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
-- 
2.52.0.158.g65b55ccf14-goog

