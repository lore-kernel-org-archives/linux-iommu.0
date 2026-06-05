Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C827416CE5
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676416; cv=none; b=rlGaGzYA6kIru3ARYogSfXXHBazSeK3jJRphF5ykx21ZEwCuaCYUeMQYMaiLq39c5ErGUyFUDfO9XHpIjf6Q8JnnzXRwzIkAwZk2CXZkvYfiS+9j6rz0Nj/PRknYtid3LtwXBNG7qYfgx6S0KJqexYoPVLFDe2TgizbMfCmnPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676416; c=relaxed/simple;
	bh=6nR3Juh9NDxntaUq247tAwVpN47pOLeSUP+bEF88yFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=easy4gt5iFs3CFO702pyj9DQcQk5n51+uDqpqatWMkT6EppuEadcLSLGgEvX1RLqn/9zQCq9UCokycP7IbGGhjiaN+4oXaGPUW6WJfs+Qyb3WVFznwf1jfW1X/k2tJKihLBLWzXPxujNVP+uudVtaE+0E6DngVJvCgfpFegRJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7ciTj+f; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7ciTj+f"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf22c18ad3so145755ad.0
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780676414; x=1781281214; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLyfkCJtSXXJACwZ2rxgqL5LKRr/9vEGg7rw7W2SG6k=;
        b=E7ciTj+fHse7VpjxzSO54VWHm8YDZBqL0IW2xFreLjl7bwDI2TfxzXpDbRH0WdMaAG
         ICQ1R6ZsuuB8jOVMAiK+RJrZLLSBNApgAjamM4/VXWF5m0unwyP7wpC8BkqO7SQyXNVv
         pBJh5M8RQUwJl/sTDUCvKP9cv4ozUFNFH7zP3lgap1+VNEpDY1Z3/LPy9WI8jDe32TNt
         pSgSgx7U9a/qj/SSoA0zeCaMVrXRJTqyWoeR7oMIW+FyVWEPvakveMt1vDwgF0XsOFuq
         VlZ0J6NVWx/WQWrTX2Ueo41GlRn/0avxlcSnscluJlVYIJnIt0WAMx4q9WbBxU41Ajnu
         niCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676414; x=1781281214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLyfkCJtSXXJACwZ2rxgqL5LKRr/9vEGg7rw7W2SG6k=;
        b=P4/8PZS/oaIwNKAiIhYG93iVeaRonfnh2BM1JdRWPBbF1M/BohBC2Lrr26MXVg4gS2
         gPgkOw6mFIeCz9GvlM0aeyZJ+YXmlSJ9T0eDuRKi2lqcWFGe72wQAI+CNq3RtOwoc8IX
         Z/dK9C5pkctv3e8X0Ybmrlu+j8bXpR0kBBbuRy5whn3ws2FCRAOMFvtvkO69WvIszezt
         V9RAN5JBMuf6ElMfDGmVhXMZkLKaLOkuiyvJUufOLC8FPAB/FnlM0tVdR6UkEpkWC/Gy
         UPKHzm/lXb0p7VOkpI0vir8rTIVpBMuwBePHbabZC7Y9mhbyjOLCt4RqidlSqBg5ocek
         wFhw==
X-Gm-Message-State: AOJu0Yx4J2sxVBzYrQIFnSshhcRQYiEdu1aiywCe3/9pgZjOBA8PPnp+
	Q+AlWa0nBwx1/5gPMA8jEejOtjYLTt8b/3Gr1kUJgJ9BKd9zKkcsOIyvZIoZqrr4bA==
X-Gm-Gg: Acq92OHAHbe6+9RuBPeRYfZeVUMfOFl+q9wgbULx5/HsNAdRr34jdeye3FGVylbA9ri
	Q/+ww5Q2WfPOA9qqT/LeYcIHz0U8XYES3N1QlB+s75MZmu2y3U5odJLK5mhqQlJ+I/nndymTWEa
	YtHzZQ3BUsroFABeKViw5KDfpU2Q9jDbsRLYOnSccVGq414jkPz7UAlL2JQ3/yzQ6mKOeEAIi9K
	K8V24YA5oqDuTXiSfMbyDtcEE1FA9ZLf266ANQwMlZ8RAR+AhtQBGjPdGypQ4fR8mLDGgl82WFG
	z42R9MpmHtWDbvxGhWVwfIYhXQrJmMJ/pqJPH2ODneiYZnh7cAPVpOOFj6oo6p1yhkufpZ9Ej+W
	ksAyaV2BBaPjksXmumY5wy5BTm9Mjhcmfbn0EvE9xOWHVeZOpH3kxBwXj4HL25fcvJGkZpp+6Pi
	kVngkRpsfbH+PGKaKxh+IJNcL3YDNPZG+K9PC5xNLevJ4+mHFjyme5fo4WNATVBD7CgGrraWEkc
	i/WPYNJUplg8YmMHWlFA0eFFZ4piUIONBjO8cVx
X-Received: by 2002:a17:903:fa5:b0:2c1:ee6e:4e4d with SMTP id d9443c01a7336-2c1ee6e520bmr1529335ad.30.1780676414213;
        Fri, 05 Jun 2026 09:20:14 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827f1sm8989696a91.3.2026.06.05.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:20:13 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:20:09 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 4/4] iommu/vt-d: Fail probe on ATS configuration
 failure
Message-ID: <aiL3Mztpm7UjEqvz@google.com>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-5-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-5-praan@google.com>

On Thu, Jun 04, 2026 at 06:21:16PM +0000, Pranjal Shrivastava wrote:
>Update the Intel VT-d driver to handle ATS configuration and enablement
>more strictly. Specifically, update the device probe to fail if
>pci_prepare_ats() returns an error. This ensures that any ATS-capable
>master reaching the attach phase is guaranteed to have a valid config.
>
>Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
>fails. Since earlier checks in the probe phase preclude config-related
>failures, any failure during hardware enablement is considered a kernel
>bug.
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/intel/iommu.c | 15 ++++++++++++---
> 1 file changed, 12 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>index 849d06dfe1ae..f39451323553 100644
>--- a/drivers/iommu/intel/iommu.c
>+++ b/drivers/iommu/intel/iommu.c
>@@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
> 	if (!pci_ats_page_aligned(pdev))
> 		return;
>
>-	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
>-		info->ats_enabled = 1;
>+	/*
>+	 * pci_enable_ats() should not fail here because earlier checks
>+	 * have already verified support and configuration.
>+	 */
>+	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
>+		return;
>+
>+	info->ats_enabled = 1;
> }
>
> static void iommu_disable_pci_ats(struct device_domain_info *info)
>@@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>
> 	dev_iommu_priv_set(dev, info);
> 	if (pdev && pci_ats_supported(pdev)) {
>-		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
>+		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
>+		if (ret)
>+			goto free;
>+
> 		ret = device_rbtree_insert(iommu, info);
> 		if (ret)
> 			goto free;
>-- 
>2.54.0.1032.g2f8565e1d1-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
