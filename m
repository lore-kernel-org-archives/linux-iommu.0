Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9033009D4
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716608; cv=none; b=gN00E3tsz8HpDH099MKM6Ox3hPisgT2aVTcXcB8HmjbpaxhjUgdryk7Ud4j32m32GTzpng4uknrSoD9588p7SpmUgIP8L2FI6WXe4Xz1gMW+7QoWmzjhp7pANgfmkIBGpSB09y9nb50Xe78s63151cJ9JSbWAoQkQ0zsa9gDUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716608; c=relaxed/simple;
	bh=+wJGUPW+DGR0+eE6ainbStfGk+YSOiY3wmspBdRDkGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UlaefLw34KuOeucVlwcUQMQAIv7Cs3nxZ5BEUlgB9LATN85cBAchWGTl5jJJo4CHzE1D2zwB2Uk23BvBNzT2kEtERr2uzdPUYTBs/bC5M8GYlz+N8FQ9riIt+mQT6Tgxyt7kWp67O0OZrasf/jDsJpB2LF253SrlqttWl9qZ3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQtFuBAi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQtFuBAi"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b96038aa68so262554b3a.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716605; x=1765321405; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwNkBuTOYxcz9fcP4mex7+raXbrBc4r0h1CS3B8eZyw=;
        b=yQtFuBAiT3L4n7YmozhtdqylGSBN3pCUaPEXAbwAs/Xrwt2NtfHKq4C1jXupGSk8Xf
         bK4mmF+yPtHljMErA8q8NIfkgCIWSP23X9rtWJGs6M2biSCmwzU9jqzlnKw2YrNTVBz+
         AVmwp+dWiSuAk3r79FcyzVyKF2CLI++Q9xrZogeP0DYsSJ0nR9dXiq/dcGhvW+jXuDNM
         y15k173lJScYJ8VV4Grxfso5n6Af2aPBXZ2bMT+FbQaaui8nkQR5p8agPx9I5LhCrGLd
         ho0FgMOov+rA/naxXwkePcUME8WpohEISVWyw03LgKuE70kUxMpt3Bhw4m9PROfLd3V3
         kzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716605; x=1765321405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwNkBuTOYxcz9fcP4mex7+raXbrBc4r0h1CS3B8eZyw=;
        b=XmwSLk96+lO3RQHgVUF2WhnP0OeIfXb2I6bvTxZLlI+LxltdhJ/IbHBhW10QLQSTt4
         h7muAC3NwCP64MVKiB+d7wz3XU34lwxsf5kV+DzIn1Er5GpZdDogQBR2HhwAC+W1p4pf
         9qOAsTM0M/eujlFUTp/4lD7tID3xD1lO/F9VsICOuYiinZrSVmm8B1dUSjsIsZ3gGLbG
         UORWHYKz0LCjoVfBKNM5iENCHWKjulvc43QygJ8LSTUM3Uyq17TZ4CGx60dGa6ork2jw
         ydFXNavpU9NkdAZnwXqKGkEYufh9AOS8XHMY0RAo8jqTKmr9aWbJ2G690T1a2OBWfo0u
         DHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqbeUyEWyLbN3LvheAMHimukMhBkXUo8ZjHoar4yHKeuGNi/aJsr3UlOu1wnHYY6L3iZymEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCGGHBflRqUU7XyECEXkl5sIFKDsiI6XTIaXZ3sduXJ/FR9agG
	vfRXCl7GXs3rOv8xuDO9mMTQme1BMYMYQDUGMPWr1vKw0jvTrBbonaUdpUOERyFKo0XSJ/pahkT
	nxPwVbT1QCjOvLA==
X-Google-Smtp-Source: AGHT+IEral7Kt58UysjsBZjUzARRPkNEdR/sgcAZVZv8DXV6nL3lw2H7AE/s2MPYUc46xQvCS+YJsoRQcXAieA==
X-Received: from pfld4.prod.google.com ([2002:a05:6a00:1984:b0:7dd:8bba:6393])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1a8d:b0:7b0:1d84:8634 with SMTP id d2e1a72fcca58-7dff408dc23mr318972b3a.15.1764716604926;
 Tue, 02 Dec 2025 15:03:24 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:43 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-14-skhawaja@google.com>
Subject: [RFC PATCH v2 13/32] iommu: Add APIs to preserve/unpreserve iommu domains
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

These APIs will be used by iommufd LU handler to preserve and unpreserve
a domain for live update.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c | 82 ++++++++++++++++++++++++++++++++++++++
 include/linux/iommu-lu.h   |  2 +
 include/linux/iommu.h      |  4 ++
 3 files changed, 88 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 21ce7be9b87e..25a943e5e1e3 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -127,3 +127,85 @@ int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 	return liveupdate_unregister_flb(handler, &iommu_flb);
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
+
+static int reserve_obj_ser(struct iommu_objs_ser **objs_ptr, u64 max_objs)
+{
+	struct iommu_objs_ser *next_objs, *objs = *objs_ptr;
+	int idx;
+
+	if (objs->nr_objs == max_objs) {
+		next_objs = kho_alloc_preserve(PAGE_SIZE);
+		if (!next_objs)
+			return -ENOMEM;
+
+		objs->next_objs = virt_to_phys(next_objs);
+		objs = next_objs;
+		*objs_ptr = objs;
+		objs->nr_objs = 0;
+	}
+
+	idx = objs->nr_objs++;
+	return idx;
+}
+
+int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_lu_flb_obj *flb_obj;
+	int idx, ret;
+
+	if (!domain->ops->preserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&flb_obj->lock);
+	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->iommu_domains,
+			      MAX_IOMMU_DOMAIN_SERS);
+	if (idx < 0)
+		return idx;
+
+	domain_ser = &flb_obj->iommu_domains->iommu_domains[idx];
+	idx = flb_obj->ser->nr_domains++;
+	domain_ser->obj.idx = idx;
+	domain_ser->obj.ref_count = 1;
+
+	ret = domain->ops->preserve(domain, domain_ser);
+	if (ret) {
+		domain_ser->obj.deleted = true;
+		return ret;
+	}
+
+	domain->preserved_state = domain_ser;
+	*ser = domain_ser;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_domain_preserve);
+
+int iommu_domain_unpreserve(struct iommu_domain *domain)
+{
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_lu_flb_obj *flb_obj;
+	int ret;
+
+	if (!domain->ops->unpreserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&flb_obj->lock);
+	domain_ser = domain->preserved_state;
+	if (domain_ser->attach_count)
+		ret = -EBUSY;
+
+	domain->ops->unpreserve(domain, domain_ser);
+	domain_ser->obj.deleted = true;
+	domain->preserved_state = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
index 59095d2f1bb2..2c8e5ac746ad 100644
--- a/include/linux/iommu-lu.h
+++ b/include/linux/iommu-lu.h
@@ -11,6 +11,8 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
+int iommu_domain_unpreserve(struct iommu_domain *domain);
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f681d4d27d6e..17e1f3c29958 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -249,6 +249,10 @@ struct iommu_domain {
 			struct list_head next;
 		};
 	};
+
+#ifdef CONFIG_LIVEUPDATE
+	struct iommu_domain_ser *preserved_state;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
-- 
2.52.0.158.g65b55ccf14-goog

