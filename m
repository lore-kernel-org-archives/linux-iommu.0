Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4930AAB3
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716621; cv=none; b=QI1+Q19DUHMgk2J7dEgQ1hSN/oX72N28OP8GDaGX60U2fey+o+/l0Hq0IEnvqPSoGzYz8HmE921eg5Pkh0v08nilpBLGUqwTuBDVrVt3sAIjfy01+nBY5D15cBqhbdfNMI9TUWYU3E0/JOfBffbSPlZY74UKzwBZST3lYcGYZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716621; c=relaxed/simple;
	bh=4cnW5iGvgdtIxwmRjvO4oUOd9FdqD+Hg5A+UkjG79FI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ltHuf01b9jshKBbe2hgws34lbEH6iIiF8zARuKxrx72kHEX7Dj98vKuy8/H//KC7m2jVxEZq2M3fd3OebvFks0hOeO4vWUAcLzZ4D6Le+U0dLShJstV4SWAFtOu4XpcSniWYZhxy1yc1DbaPa82gRsNaZH7FKbaVkIie74dFxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bj+SvhEU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bj+SvhEU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295915934bfso73652235ad.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716620; x=1765321420; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6atgyECODfuH/pey6ac2Fk1KY/d0Gl+LFeR6KszcGM=;
        b=bj+SvhEUb2nMWOAbsYsgOdrmMuSWcvWjibzNCtEaV8nOiWvy0FS9zVzFKgXGm9jRwq
         5NEyGNeUl3usFAvayqdJsMrSGrPH5Lm6qEnWcwy6cvKx96YL0c+pd+wWzycakNPaFs/2
         NwIz/ne67aaeVoj85FhRi5L/C4Tkaa2iYLKnmC66FLYkOggFSBhMnAGPWBL+gVE6rI1N
         IiS3tPYdCxycT81IW85eCcCYzvfxxXA9FVecWnqIxEuA1MFuHGrlm0kxE5Edygc/HP6s
         VQ78NzT9YoqSCacwzCksp/oyXZgPDQBL8rbymS0p4fxUMmQYR33McFpqx9SPvF92a7mB
         wJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716620; x=1765321420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6atgyECODfuH/pey6ac2Fk1KY/d0Gl+LFeR6KszcGM=;
        b=q/z3XLjh+fmQG9MLlRq6oGixWDKvoRW3lh/HWhnO64FSZAiRwj4pCghn4cN8/SBfCe
         wf7j6kHc/JrC8iRTeh5LUAgf9VrzhlvGviatkjJKBKpFoDo3mtCVR41MRWGaEmc8A8JP
         R5sKJY25rJRgBxbjXnCKyej3FAIKCDmtkoIE8Drtf5t47gQcbxG80zev0XXBTiDMgH9A
         UVL0OWCq8Xtuztgy3XdTVVrUXzHC4+g0frUbM5TbpxAygQKpE/eUNMSYYjuptYeFhtHT
         DJWl5c4jurLZx2UYe7yHJs/4LOmQVNb9+cBh/IfwH37wuOuQeyxJw8opzn/L9icP7V5x
         Nt5w==
X-Forwarded-Encrypted: i=1; AJvYcCXyxv7JNF/oisPk7waXrd4lYm0+oErDrPA1HLEa71mShZh1e4wBsitp/bcPQ8oV6nENnf8kqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDHqkx1F8x43GOa5rDtyVvITj3E57pmMGtmzzDfzeE5qZ5jaWt
	XdcaGXHDHwVogV6cTBqR4NeQiAHz7nFOaLjqbKMJFD5bCKmbe35HjDztNDTsOK22tcxNgsRDbs1
	5q1CctHfYFNQWQA==
X-Google-Smtp-Source: AGHT+IGxdJGTKjpFRs4VBozxyCOqfLHFZCdARJsI5cF6LF6J0BSmgS5pC8M1FIgAl44COPI/zmBCzgRvSdjQ3A==
X-Received: from plbbf12.prod.google.com ([2002:a17:902:b90c:b0:290:28e2:ce59])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b0c:b0:295:50cd:e759 with SMTP id d9443c01a7336-29d683de6fcmr2373885ad.58.1764716619737;
 Tue, 02 Dec 2025 15:03:39 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:53 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-24-skhawaja@google.com>
Subject: [RFC PATCH v2 23/32] iommu: Add an API get the preserved state of an IOMMU
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

After liveupdate kexec during boot, the state of the preserved IOMMU
needs to be restored. Since the state needs to be restored by the IOMMU
drivers during initialization/registration with the IOMMU core, add an
API that can be used by the IOMMU drivers to fetch the preserved state.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c | 29 +++++++++++++++++++++++++++++
 include/linux/iommu-lu.h   |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 0dfa03673178..e7ecf2e9aa4e 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -175,6 +175,35 @@ int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
 
+struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type)
+{
+	struct iommu_lu_flb_obj *obj;
+	struct iommus_ser *iommus;
+	int ret, i, idx;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
+	if (ret)
+		return NULL;
+
+	iommus = __va(obj->ser->iommus_phys);
+	for (i = 0, idx = 0; i < obj->ser->nr_iommus; ++i, ++idx) {
+		if (idx >= MAX_IOMMU_SERS) {
+			iommus = __va(iommus->objs.next_objs);
+			idx = 0;
+		}
+
+		if (iommus->iommus[idx].obj.deleted)
+			continue;
+
+		if (iommus->iommus[idx].token == token &&
+		    iommus->iommus[idx].type == type)
+			return &iommus->iommus[idx];
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(iommu_get_preserved_data);
+
 static int reserve_obj_ser(struct iommu_objs_ser **objs_ptr, u64 max_objs)
 {
 	struct iommu_objs_ser *next_objs, *objs = *objs_ptr;
diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
index 08a659de8553..ffce7043e997 100644
--- a/include/linux/iommu-lu.h
+++ b/include/linux/iommu-lu.h
@@ -78,6 +78,7 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 }
 #endif
 
+struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type);
 int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 int iommu_domain_unpreserve(struct iommu_domain *domain);
 int iommu_preserve_device(struct iommu_domain *domain, struct device *dev);
-- 
2.52.0.158.g65b55ccf14-goog

