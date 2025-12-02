Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6EE312813
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716626; cv=none; b=WN+MgQpIvMZw3PldNrbFO6MXcTR8cR2FsfGy/T9Vmds898Lii7CLpWi61EBb6+eucbpbw6YKLxDS39MiHIfFuJLunakDI0yg5wiXciyxy+hHaI1dT+bJWFZV5DGVy5uVLbc+ssvMyyQf89Kq3xJbclW7tMZDE2bbRweqMUQzc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716626; c=relaxed/simple;
	bh=MDGvdOZkxnfxNqo+QVpTfOsgcC/U6i4AouRW5T1JH8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eh3m+qjik4B1oTSBx3yPfvvZYv5OY+rgZU18HbLgEHWiJCngjbC4+lqbrj1/JiHyYihAX/wcA4Ty6JDdMoxCLim1s2+2sjNIMvTESs3w0CCNnaI+nQEmqir47xrDweQ875gpAhp5X9RGO2LU28kTB4prONB629T/2VOKg7eWKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrdRedF0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrdRedF0"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7ba9c366057so5078521b3a.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716624; x=1765321424; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozuCVrzv6cmBt2ueV/Q3xo0mXpOPQeQ7zk53yt4ABbg=;
        b=UrdRedF0M23cf2dMfsswn7868Vq084uoIG0LZMORghjlsNOsXAh3adF5r6oIxAVJoK
         oU5xYMtd5VJ/TIQEqFWqJatwPSavYi3CtpBymXsES4DIZoTMJAm+ZC4AWqn/gTt0u5qk
         Gu1pbssXYV1c2JS5qEey7aayYG+CRfPKKL88F/PPbeWzr5g0aVnHkj82jAM5HFWZhZ3x
         2zxXr9ANFDO7aED4aRcx2reHP9v0pP4M751RiXHagcr6++V3SYoMxZloCRdh0aOXe18j
         Zp+bPDPVmNNtrDT0acpoMnrwXL45U9x+dqf69q2u0Ew1JoQfzXnS/m9tKOmbmWRl3zA0
         dR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716624; x=1765321424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozuCVrzv6cmBt2ueV/Q3xo0mXpOPQeQ7zk53yt4ABbg=;
        b=JpC91N4coSJiHEKPEGNirZBLtNDgZGY/rI+JEcHMZ81e6kfcnxmctjVRV1PHU9AYgD
         cZqZgbLz5ms0fUni1FpICAaTXzxUdHGShFCrTtSYkLdYDLOfr5KkzJhoWCLxOK3tYcB/
         mVjnk+DKCgsHKYD1/3rTAMQMj6tkHtKMgsP6kApie0joOB3p4xfv19bJhMkjEOSDHuqF
         CT0YZKhvHVemh/l3inSt2aOzbpFZK+26MSh5TOIS9mCHwgMmHQbUHYgQ+4UdC1Y13h1C
         +qKBMa+M//ceuDGiHg9zgufBMQ/XmZnTzJHvPL5+Gz7JtA4vm0hUClXHZfwvK54hyJUq
         Cxqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQvz37QsYCeYTD77Z56FRcCuKZtGGO9Q0uUuN61wXmujJzfQS0LTrKmB49LZq+gf9E/PZxaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2I0YETcRtZ9atACejLoJwBathtoLpMmJl4XrxLcnKEeAXYQPq
	VXhtnbg8ucl8fDt/S+ZYsYD9niQoaFefYJL6BxQwehTlu3UOp6EYJ0wGLeBkEfH3m8vyUQXXJIC
	ASA2l79VfA8U/hQ==
X-Google-Smtp-Source: AGHT+IFQbI5oOtthRJddSA/bKiZgZROHWHZFgD/z7CW8nR3WGqOKGw3LdKd6oYYJozfaqnDawl6Ddzhao5vVdg==
X-Received: from pfbds6.prod.google.com ([2002:a05:6a00:4ac6:b0:7dd:8bba:638f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cd1:b0:7aa:e5f2:617d with SMTP id d2e1a72fcca58-7e00ee5411amr195303b3a.30.1764716624211;
 Tue, 02 Dec 2025 15:03:44 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:56 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-27-skhawaja@google.com>
Subject: [RFC PATCH v2 26/32] iommu/vt-d: reclaim domain ids of the preserved devices
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

During IOMMU unit state restore, reclaim the domain ids of the preserved
devices so these are not acquired by another device.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/liveupdate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 140887187084..fc1e8545ed0e 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -92,6 +92,15 @@ static void restore_iommu_context(struct intel_iommu *iommu)
 	}
 }
 
+static int __restore_used_domain_ids(struct device_ser *ser, void *arg)
+{
+	int id = ser->domain_iommu_ser.did;
+	struct intel_iommu *iommu = arg;
+
+	ida_alloc_range(&iommu->domain_ida, id, id, GFP_KERNEL);
+	return 0;
+}
+
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_ser *iommu_ser)
 {
@@ -99,6 +108,7 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 	iommu->root_entry = __va(iommu_ser->intel.root_table);
 
 	restore_iommu_context(iommu);
+	iommu_for_each_preserved_device(__restore_used_domain_ids, iommu);
 	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
 		iommu->reg_phys, iommu_ser->intel.root_table);
 }
-- 
2.52.0.158.g65b55ccf14-goog

