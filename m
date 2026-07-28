Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16053414DEE
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273001; cv=none; b=GcIId4RI0gbDoZ/QkPzrEy/Bg5IsvF5jp4TCMnqrYyjvd0tCQFdFyqUevHilziq0Gcn5MXt337cKZ16A3le/Svx8DZpzuPkGpZJXlY3UIElW9+vt+l3YzovxTdlrq6diH5U9aSREPP9sCknLdVE1k0e9xCFfML21F/ecZN1igGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273001; c=relaxed/simple;
	bh=t1HKs6WjimTumunA+LXbzwX4KTM/5f4fbTNs1W9tQck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AwGJEwAFnB1c9DHeORD01y5aNIJIbbXURJDx0cPhmkeqdcu4t63UBjpr39UZTZxDlFENQusbZUd4C+T/stIkaQoFGTU0eRIwtjNthegWvKxxz3bvgka1+naQj76E6EFQSpFn4p6NSNoGKJDegyvGZiob2aKqS4J39pZXRZSCdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrDPGKvD; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrDPGKvD"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484f26852dso241490b3a.1
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272999; x=1785877799; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvJ6dCJ/r3ejrKV4VTH37NoCe/nuy0ucT0mO8Cz+CaM=;
        b=WrDPGKvDc950GNrSdYe+d9bnajg4Su2qbMIaRB7K1UNBbjkvmPMWCMK55sm7vxqCED
         5M0zn767q+Wyf3rka74byF0fO2gk0Ev39TUFAfwcDU1G+EFJtEOmkIH79bPLCZssYMvC
         As8iC63p7tZxzYEyuWyPzaaS3V9VBC45yjzBrpU/aIloahNlmjKOqA0ue1d6qVEMsVKk
         2ZshSh5wfUdBGY514uBgL2pDMCpZJFWJGITerHcKoni5LOkqJZDLoMIfcpcOrnpa0Bj1
         2SmgYIqCcYJUZFzFcft4iTGuXdRgy7g+h25ihXz4B7sx/7WZ66E2lNayqaiehiAZ03MW
         TOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272999; x=1785877799;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvJ6dCJ/r3ejrKV4VTH37NoCe/nuy0ucT0mO8Cz+CaM=;
        b=Un66AAUWOxPn4b1CW/RnI4Zr4wg0A4jtfDoyLgjXe64alY6ixcVzZ/uygbw/WwjfvM
         J1igtSili61UJhaECYpzLbMMO/XxWZXB3v1qYC9xKhq1/YdIRVtPKrDz9b7TMN3Ntq0Y
         x9I9yMOoy4+SXp0OLScj8h/fZKP99pegl5M/f1SAd4lzDBx3vEZaoT1otclKLmiwJdb1
         ThEvUiNCsay9PowUoOPqr2tGbq0qaOo55LEf1by63BtBSBKF55O3XASHBkX3u4xsM7nd
         T939KyI54zZl4AtoZ7qSs1NE8M8CmF5MoifG5ALT7HLrLwLB5+ck6oKdraL2glFTH5b4
         TCFA==
X-Gm-Message-State: AOJu0YzRc90IvuuKqFLDagXC4bKS18x255bqtZMH+arUGYr3r7zRZVtk
	GTnVyxgjMFzuUVZnxe6wvJ0rT1hM4735quvUW7Le0viJym72NQE6f/tEQvWIGt9TqJ6OY3dLRau
	Ak25drHUGowpOlh3NeAZl21ZVTtYnI8dC5YRkx+fF9gLNRVZNmcCu97QszKKxaO2TzlM89g4r5J
	mG/Y9bMa9PozCNlqDqih+HEYgUxQSohg==
X-Received: from pgkc24.prod.google.com ([2002:a63:ef58:0:b0:c8f:d0d0:d863])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cc6:b0:847:7a61:e68e
 with SMTP id d2e1a72fcca58-84e9316ba86mr4232449b3a.31.1785272998794; Tue, 28
 Jul 2026 14:09:58 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:26 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-11-praan@google.com>
Subject: [PATCH v9 10/12] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
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
index 5f0e01dc4f6a..1253065b6db4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4431,6 +4431,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	if (ret)
 		goto err_disable_pasid;
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_disable_pasid:
@@ -5821,6 +5824,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (dev->pm_domain) {
+		pm_runtime_set_active(dev);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_set_autosuspend_delay(dev, RPM_AUTOSUSPEND_DELAY_MS);
+		pm_runtime_enable(dev);
+	}
+
 	return 0;
 }
 
-- 
2.55.0.487.gaf234c4eb3-goog

