Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE33BF676
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324619; cv=none; b=UDGXhGIxpVeI6uG5Y3+YWDlnnDyP3p6o/pHLyNJSpCVHtFQFk7Jv6OBwgxX0qokqoBjj9bUhQDUjq18OiubBhQeJFGEijYYWz6IjoDEjyoq64Z8UzAYAjOvgne+Ai8KENCc9QoptiGqKlAZr+yY9AX5sqI5k55DJFUgrAlJvF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324619; c=relaxed/simple;
	bh=7e7DAPIm+AHn3qv5bIN9iON9Yk8ymifmGfWJ9sb7sLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d5qWhxuGMdFgTZdEcZBwAjwVd9pfjm6wuU0bFJMKpCwmYRXNtPzwD9PPKHiQ5O9F74ozu+jCUvPbUpyX9VsFzc3aeJWd4k9qtgejqTzPsT1y4wgV3jflhB34PyRI9iSewSlKvFXe/1Eznqsidw4GFFKINwjLKXFPMJj+MCW1LMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mN2B4LbU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mN2B4LbU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2beff6b6e74so53995515ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324617; x=1780929417; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNaUgI3CtCWyHWdRlJq0xZGnOnJtcDe+W2oSC+iqpLQ=;
        b=mN2B4LbUuncC5z//uL5ETYBkCCjI+J+ySdOhRCdmXTD22CR53tgTf4Npl2u2I8T+Z4
         XFx0dBWqA4gy7fsnUFpWM3HXn3fqI/n3vnM20r2adNDGE9VyWlh8e2fapPVDsDOF9tz2
         Z7E3QqmKD6r1RyZ0/EMLAWWUWutZ3wkIsZufbf6+Y06CzjbU3swGfcdeLiR6KLwGrF0/
         KPVyLxIC/cCkYJPvvtHfs853ZEcf2TG6juif5jsyfmYiGvvtvbkCrauDUIWvGT2/owBq
         G6Z5FZv1UCF5EXep/YMtQzao2JiK2TZeid5W+cIzeyWV1ENE58FN1WXbaHHZYgX179b1
         WbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324617; x=1780929417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNaUgI3CtCWyHWdRlJq0xZGnOnJtcDe+W2oSC+iqpLQ=;
        b=opd/RuxBckyk6oynOcGmeYlkJQw+4YTWOnf5ZlD/c4WX5DWcoG5dYuBGdLewOWT/jh
         1kcuIN5y/0vLY1uVzHdbd56pD5AcLYV7QxZZjZOrB/csHZaOZxA9dK1k75kKQEA+zybr
         njjEGXqEwkM1CdvlK+m5ko61LKY490ykYUad5DAUmnzceGNpJs1pIBBrmmvkIwKFZT6X
         OVdXpjWQHivp6H+iDSDZ2gP0Q5iPNrQcsFIXwt5Tz9RSqao6tOxcrlOqaG/gjbDFpGbX
         Ev5EtylXdULRFDxuaQJhpW/msSTFKuoimdD//xzNkPD/fXZ/RP5Qf9KFH4p7Jozb13zg
         /Jgw==
X-Gm-Message-State: AOJu0YzopMUXrRTtcI4arwSqTto9SbQfEeccxiE1lUfQq/nDO1JAf+jE
	rGp/NSjK2BZTkviv8Vwr6HiRM8CiCS6ut/nfIogY8nHrk+WOLgtNDclGusOGCgaS3InwUocn94i
	jrk32YnNZAodcKDbt4ENIwgv6OuLt7E2TIHC5YU2RXVLcjL8cyPvv44vVPN8AbNbGyzkTiBZYnv
	kAuOGHW7hDn0FZuoh8eYs+U+z78wD6zg==
X-Received: from plpm15.prod.google.com ([2002:a17:903:3def:b0:2c0:b1b0:fad5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58d:b0:2bd:5026:ca11
 with SMTP id d9443c01a7336-2bf367936ecmr115140945ad.2.1780324616758; Mon, 01
 Jun 2026 07:36:56 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:44 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-6-praan@google.com>
Subject: [PATCH v7 5/5] iommu/vt-d: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the Intel VT-d driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..22308e4911e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -873,8 +873,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
 	if (!pci_ats_page_aligned(pdev))
 		return;
 
-	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
-		info->ats_enabled = 1;
+	/*
+	 * pci_enable_ats() should not fail here because earlier checks
+	 * have already verified support and configuration.
+	 */
+	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
+		return;
+
+	info->ats_enabled = 1;
 }
 
 static void iommu_disable_pci_ats(struct device_domain_info *info)
@@ -3288,7 +3294,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 	if (pdev && pci_ats_supported(pdev)) {
-		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		if (ret)
+			goto free;
+
 		ret = device_rbtree_insert(iommu, info);
 		if (ret)
 			goto free;
-- 
2.54.0.823.g6e5bcc1fc9-goog

