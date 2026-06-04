Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6B3BADB6
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597290; cv=none; b=LGJp0CfEg/fxnPjDsGpqrWEV3rHfkazThq1QRaFUSHsR1a+uEXe6s0IH8YjHP5/K/FaO/IuS2GxC/wbAvgNA/X2TP/QVsngTcpYMzrcApDwhRzVhBxgTX3iYU1ylVKwkHrToFuaHV27riPlMPw6QN3vFcXNLZCHd8kfoBerERL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597290; c=relaxed/simple;
	bh=ZsPtTr9xybmFV3D70USnSwdOFmyW86rzFy9C9TDJ8kI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Znw133PfnYBgKIBuhRrQshNjtkDjx0DOxDGam/ilUHmKCi3emHygGxA9E1qZJOC70PsVC9CmpCR6lSGSQR/HDoOpfWGQp+eDVD26SeMBnpbQ/PHWjN/nGRefu6zjIPwYKnXdqp2cpl++QEp8Toh/LAujC2zGRIiF/cr0z0U+17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRIqfJ+H; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRIqfJ+H"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b7c55406bso788931a91.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597287; x=1781202087; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZnO4GCpu3n+4CrPeKm18ejA4A5n6TmnDYVIYtLJbRE=;
        b=SRIqfJ+HllzQ4f7DEoS3RYxa5zGd9MLC8VIaKDrgovoVBAHWvqfU+z9M5PSeyWU+w/
         k9Cq5CeD5sZ//TgX+YLwpZjkK/w+PtqIXICm2Vr0EVpMnPaFnlc1jOfssBme5b5KEMAN
         OPg9tPcprXbprYeZWDM3QNVRZVXeUBZwE0E869MsBLogWOZDceetvvhZDQ4oN1hCArc+
         ae+vZ/MhnjnQSA7pL2TupYNq3I199TlOJ1j86ZagbZKKHoXskO1mHYlgeXrV97eJqfn6
         ktTRpREEwzjbSGCjYPYqmkPUNlWvbuj76SImRxP3Sq0hnBKlF1JIkTOvJMEaMk7HN8pI
         N0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597287; x=1781202087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZnO4GCpu3n+4CrPeKm18ejA4A5n6TmnDYVIYtLJbRE=;
        b=exNxBZfKQKBwKVgnhfhGtEOccHeHrQeJGNvgKhC/DqqmBOLFeV9HPJ0rl9lh4rcMIf
         qCsPUV1PJZsrQprzLqBCgbHhGqlrmTCYmiHlhTwg6Gwj24yeJEjyVfYvVEZU8dbJpew4
         FOOEqXYG/uz+2kQX3KBOrZ6hZ01cGjmm/uObsMH2iV5kFzVWulq/+74GARFdvMgo5vnO
         6/5zyjyzdlMMv7grtLI084DkUg/0UbW9iRZ/qMj10xqp2FBd3bcwCpIJ9X02dRMho/Um
         pEL4EuyozIW1NfDIHO8FSKyPWz+/mn+pd0y0NzA9h4dpwvtaU513xUlmk1Fb07REl4kd
         uh0Q==
X-Gm-Message-State: AOJu0Yw8vU3EaZYNrt15BgQtz5bFZme+S5qW4C7TqpB5P59CGsm4DIod
	Dwk7hpF+WYBbosrjYTPYu+A5MVpsjGHT/UHLuEFydDnkEtQUNPjLFb/xqPJ8vRZtaIvDKzhMbzv
	RcjNx1qIo2X5qoW60LvPsfv/nCRKim+sf+ZRPy9/DrN8To6lz7cbycNLkmDY5hV7qg4OAtYrGWA
	3wwbJHAgqWICYL6pVC9elwnXu8uBmlmQ==
X-Received: from pjbbv3.prod.google.com ([2002:a17:90a:f183:b0:366:3a03:b66d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2706:b0:36b:ad81:c134
 with SMTP id 98e67ed59e1d1-370ee928d34mr155578a91.10.1780597287064; Thu, 04
 Jun 2026 11:21:27 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:15 +0000
In-Reply-To: <20260604182116.3179005-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260604182116.3179005-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-4-praan@google.com>
Subject: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
WARN_ON(). Since probe-time checks now preclude configuration errors
any failure during hardware enablement is considered a kernel bug.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..0494c68daa19 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2956,7 +2956,12 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
-	if (pci_enable_ats(pdev, stu))
+
+	 /*
+	  * Since pci_prepare_ats() has already verified the HW capability
+	  * and programmed the STE, pci_enable_ats() should not fail here.
+	  */
+	if (WARN_ON(pci_enable_ats(pdev, stu)))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
-- 
2.54.0.1032.g2f8565e1d1-goog

