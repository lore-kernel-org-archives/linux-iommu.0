Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811202FC037
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716624; cv=none; b=YU8dGv+q5d6ULzQDWPE1JTHmQs/j3kIEEH6k5oAd68nZaW/rvk3ulPBjf2Al9MUungrl8L5fJirUB4VeVXH16/Y79aqnN0YelH1Zep517Eg0onn8swkLD5eL7T1YlRGBNcWdfHvec0fZ9OMgUM0IGpBe8hpMvZI1E/YbAFrUG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716624; c=relaxed/simple;
	bh=l6FB8BOFQGdBKeD2DQc1ZM9wSnaceow2usRLYrMCWWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uQL9h5TSnqQa00u4ptHCbq9flU2JIYamdnmKF2+8FWWVjx8icqS7Q1Hwvi90HMFGfl4emTAOuRC6ta4UUzvdJ9pdJFT+wx5npfrk8SnVTJEd50w6vnHjnq+X7jauGACOV9tnAmuQADq3OdRVOvgvYGVhy8s/ySdqZFbTWLweEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqJqtfyy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqJqtfyy"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7ae3e3e0d06so4390898b3a.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716623; x=1765321423; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPEjNOez0fL5I+Zr7fias5PbR6Pw1WeqxOD3IbrOXLU=;
        b=SqJqtfyy8hr/obgKHIoenjfDGVzZ+BpRrS49t54JK47f9WcyLkLsPdLRBuEXA65e/s
         dwtb6niQExVzAkUjmAQE9quNYz4szJSG6xZR67hWlUH8jUAXz2QXTe9HPW5ktRI5CzIo
         P2ym13MVRF0jam+2VFKGrSegQhx1FAw/+p9F52Ii2SJBgP3UYpQM5o0n/hXTv3TF8Bp9
         1XAWELD+bwID9nyC7dfRyGFsUiFIODxJcYMGu4o3zxvky9fdnfwKb9rUJciUPOnv5Eh8
         1URTvXf2P1AK9zDXqSwUtrzYHSUSP4CDpyeVF6n1c9f+ivumoFeAiS2Q7HGGI7/E0/sr
         oHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716623; x=1765321423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPEjNOez0fL5I+Zr7fias5PbR6Pw1WeqxOD3IbrOXLU=;
        b=CHPn+ejK3XqFPpkQnS84tq5zlyphknU4vGfFOTQM5WVk5JcBWWLQVNzhx++i81VRFJ
         E0P5WtGqIaH/bJEyUJ8Poo6cxjng6ff78v73k+gxOCRHK2K9kRkpKYt2DepPZszZXzB6
         +2CopgzXZHH8zWRJjlEZU0FftigsSfXVGjwejrXng6OuMRqwJGMwGM7Oym6xoe4gYa3P
         iBZuhXAXhaMrRTG6KpZnhu+1LWZtO4xIrSQQUCyn53+x17KyDPHwFPIS/tRa3bqd3tNs
         0+dDQNa5LXOQxWGrms3X0mxIErRxFX2Hvx+lRp8Y9EaHQlxSY96tJdiOWQEjRyFN6nW3
         Iptg==
X-Forwarded-Encrypted: i=1; AJvYcCWPFCth99mVmdFAwtzFOhl0W7hgMF71OoEpVJOya8ZK8qhphC6EFLxtD7wY8xLdIov0mZdYww==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH2qK0Dr2QjcNxfAZt6CAsE2COIakAX9ut2CqLHxpU3efcIffR
	B0Wl6rTq0MrbdeXQiwU64sX+DMVPuHW9+LaWcagHy/qPIB+w9+Bw69qpwbQ8Bzp50F0H1WPe6DS
	lF2cUWvK5fpDI1w==
X-Google-Smtp-Source: AGHT+IG8TUiO5xGtIQxkKYqtztDo1ilNyy6FvW4+Ir/EDflQtNxbeNuGgHrYLt33IHdx0TE0Cs2pn3JB+VdJeA==
X-Received: from pgee23.prod.google.com ([2002:a63:1e17:0:b0:be5:9a9b:6b5d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:328b:b0:342:1f0:9af3 with SMTP id adf61e73a8af0-363f5e267c8mr507984637.29.1764716622743;
 Tue, 02 Dec 2025 15:03:42 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:55 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-26-skhawaja@google.com>
Subject: [RFC PATCH v2 25/32] iommu: Add helper APIs to fetch preserved device state
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

Add two APIs to fetch state of the preserved devices. An API to iterate
through state of all preserved devices and another API to fetch the
state of a single preserved device. Note that these APIs only fetch the
preserved state from the previous kernel.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c | 68 ++++++++++++++++++++++++++++++++++++++
 include/linux/iommu-lu.h   |  2 ++
 2 files changed, 70 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index e7ecf2e9aa4e..1ca97612c501 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -175,6 +175,74 @@ int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
 
+int iommu_for_each_preserved_device(int (*fn)(struct device_ser *ser, void *arg), void *arg)
+{
+	struct iommu_lu_flb_obj *obj;
+	struct devices_ser *devices;
+	int ret, i, idx;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
+	if (ret)
+		return -ENOENT;
+
+	devices = __va(obj->ser->devices_phys);
+	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
+		if (idx >= MAX_DEVICE_SERS) {
+			devices = __va(devices->objs.next_objs);
+			idx = 0;
+		}
+
+		if (devices->devices[idx].obj.deleted)
+			continue;
+
+		ret = fn(&devices->devices[idx], arg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(iommu_for_each_preserved_device);
+
+static inline bool device_ser_match(struct device_ser *match,
+				    struct pci_dev *pdev)
+{
+	return match->devid == pci_dev_id(pdev) && match->pci_domain == pci_domain_nr(pdev->bus);
+}
+
+struct device_ser *iommu_get_device_preserved_data(struct device *dev)
+{
+	struct iommu_lu_flb_obj *obj;
+	struct devices_ser *devices;
+	int ret, i, idx;
+
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
+	if (ret)
+		return NULL;
+
+	devices = __va(obj->ser->devices_phys);
+	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
+		if (idx >= MAX_DEVICE_SERS) {
+			devices = __va(devices->objs.next_objs);
+			idx = 0;
+		}
+
+		if (devices->devices[idx].obj.deleted)
+			continue;
+
+		if (device_ser_match(&devices->devices[idx], to_pci_dev(dev))) {
+			devices->devices[idx].obj.incoming = true;
+			return &devices->devices[idx];
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(iommu_get_device_preserved_data);
+
 struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type)
 {
 	struct iommu_lu_flb_obj *obj;
diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
index ffce7043e997..d0226ec19b2f 100644
--- a/include/linux/iommu-lu.h
+++ b/include/linux/iommu-lu.h
@@ -78,6 +78,8 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 }
 #endif
 
+int iommu_for_each_preserved_device(int (*fn)(struct device_ser *ser, void *arg), void *arg);
+struct device_ser *iommu_get_device_preserved_data(struct device *dev);
 struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type);
 int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 int iommu_domain_unpreserve(struct iommu_domain *domain);
-- 
2.52.0.158.g65b55ccf14-goog

