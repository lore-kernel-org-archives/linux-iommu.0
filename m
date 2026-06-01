Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF4349CE1
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351174; cv=none; b=KSJp15iIYIzxdvR+d/a5bihImpcf9kYkvkueVig8ErSfRQ6wpxQEgoPXVgkC5xG9lMm8dgR+dOXawuj7rEfzmGhFn3Vt+6D6cF02ZH69GoKjtNgQYNSiAHaMMWlp+svzCXzp8WP+LrkrYA/nILyFMk0s5hwZVlfGEMg5lTAe9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351174; c=relaxed/simple;
	bh=NVMf8YjI+ySnx/jLUuQLVCpBJfarbVdQZDuVlMCESek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a83/6xh37NqbOJdtTjVw1tNJAMqyVGLst9upbzRAFIbaLY+cKXRqHjz4ycbRpGFZ8x8X8yVrCM21bZOGlUaUEiUNLFVecv7ZGIylCjom5LvChjAntfhR5Khr/UaCSNHEKNJvEMnIw+TMfdYguwsEKvReXCWN3KTWjaln6FORZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1NeZqCw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1NeZqCw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0532a6588so23804595ad.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351173; x=1780955973; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=amPh/xh5W4B/VVjH4i+ndMFiG0NuCzFtjKIw4/O7PU8=;
        b=Z1NeZqCwW8q1iLDClfGrJhrp5DMijihv/QN9FZ/aJxikoWrFnz/8hD0lWwEUSs+0in
         DdOLLISV6rMjcLUr04DUIN2hfVAlSEXA6ooJvczCbR5oVjTQxUSH6Nk8LPBG+qPd/n43
         yNSIVl9MVomta0abVBVOyuO9ul7ao5/RPKLeZSgTDfR+oG+165RK3IpK422E09YSxRfe
         OB6mDmu51dMJFApkL8vRlx2Um19fdpID2eJYR6Dz6imKrM7xmVvELiHehf2DRU3r3dDO
         5VlSlFad2r/aLoyuc3COiPRYNdv9jAvGdJoSESLwng/88j7Y7dmpE89xoC7n18z80tiU
         mccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351173; x=1780955973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amPh/xh5W4B/VVjH4i+ndMFiG0NuCzFtjKIw4/O7PU8=;
        b=QG+TuIMCxe2eqsY3a3KGfZqMos/lAjcTxfqIbnftA8FBtV1T+qc/8ezXLFtMEsKdvZ
         DTLAURLyJ56R7Vc3zNhV/Kmac5C/RtGZEiqUPS6wyLpqUglYaMmM6jLKGRROLuRuPQDa
         MmHDd5a+LIbKzI2JTB3ub4nZlvNe9o7VJ6s7QP13TG5ICARI8PevEwzIxBPaczDmRMRk
         GOqlCF/R69mHpY2lFwcFXhEXuK3Di9Lc1ecAJQU2Vm+umJTHBAGKXYIU48zcO88FFM7Z
         6kCGGRrpiSJowFMXNQVWwMFqeT6Rd/QPLpggpzCeVnlxJfGHiwh/fRTM5VXL0S//PIo5
         989w==
X-Gm-Message-State: AOJu0YxPfd4ZDCcTjDV0T1+ok3whUEsEj2V/FjjaABTVEt8CPh93ycNE
	oJ9BE+iK31AeUJbPpag1oTkGkSFiJuLzymC/8DqWvuKyXvCiJqqsO4NhUvthkNXcg21Uhjl6H0G
	EBJJ4eRuSb1f6MfIvxz8vPKu9bcByRRc48mTXfsXNlDNx2Mdgr5jq3p3JT4tTFCQoO4vJVdTG2p
	+zQyP3vu36TVEbko6ZS9Wgr2qDFFeEvw==
X-Received: from pleb20.prod.google.com ([2002:a17:902:d414:b0:2ba:856e:d046])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1905:b0:2bd:2de3:5181
 with SMTP id d9443c01a7336-2bf367ab2aemr145926765ad.9.1780351172519; Mon, 01
 Jun 2026 14:59:32 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:59:07 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-11-praan@google.com>
Subject: [PATCH v8 10/12] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable PM runtime for SMMUs having a power-domain during smmu probe.
Add a devlink between the clients and SMMU device. The absence of a
power domain effectively disables runtime power management.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 542de3a3173a..24a1bcc8974f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4243,6 +4243,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -5607,6 +5610,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		goto err_free_sysfs;
 	}
 
+	if (dev->pm_domain) {
+		pm_runtime_set_active(dev);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_set_autosuspend_delay(dev, RPM_AUTOSUSPEND_DELAY_MS);
+		pm_runtime_enable(dev);
+	}
+
 	return 0;
 
 err_free_sysfs:
-- 
2.54.0.1013.g208068f2d8-goog

