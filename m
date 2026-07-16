Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7943370EA
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231457; cv=none; b=BYY6eZRNBBdDh7A9vbnNAnfsvdncIsiR6a31+6r0D+2wuVMErhOx4hSzevqMOZJ1GlnNYtx5M/VgrNB+MFlWh07UC2X2otcYMhXaCtkR+4PkxuPGAFlghIHBiOqUae7AGNhAmnoN58/+B9/3/MjMjB/uOw8M6IXSHOublwmT8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231457; c=relaxed/simple;
	bh=06y8sZb/aVmdw3hkUbIEltKcjw5Xo9uoz7ulecfx6e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQFY1zeoA1Lh0SvR7yokoq/7Oo9jL0FwYo03K47I3uLcCoByuL+mO2tAYqb/KWjgCdRqD55ifci0cf7sxa6EI5DLyp6pUlJblYFFdfZ/npuq+yya8Vvdsfyyu5JrjBTdsiRWpx/NOxgz1nYBZfBN8bg/snJgLGJ+z+0OFmpCr1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vcxPumif; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vcxPumif"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdf36f63dso59255ad.0
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784231454; x=1784836254; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pPEy0FEptLG0+wnEJxoQBykPLINVwp+l5W/GjXL8Dv4=;
        b=vcxPumiffs3nTC57i/rH2G2Zd/D/BfuEultymE4u96wW5r9XbVsMhYvgvYck52m7w+
         eV+0PJ1MhNWs801xtb/XsRiCTf93pw5oq3axffCRmOc+iFwJN5XjHgbtkVF+jmc7W3P7
         GjIrOYZIwyvsVA9c+XzykK5fjmlR26YPeCxdUIbuAUPOOszeL37G9F+mlnSS6XFgi+5j
         0D4YGhWA98Uu+v1gJqwnkgnIahoe0+k3F+lJ5hngs5DTNg2Qnd1RNnj3pbLIo2HJ7OI9
         XwMNh71SH0f7LSgtsD+d/Ri2UIGcb7yDOJwLLP/GrlMoH6ZrMqA3BpQrgw7yPAeNboOV
         f/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784231454; x=1784836254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPEy0FEptLG0+wnEJxoQBykPLINVwp+l5W/GjXL8Dv4=;
        b=JVj4u3kpiHYsQBCfumDNBhpMz4niF1OGUfNPi3E4QCX+nFemwA6/M4fM3MU5zv5hJj
         DATh931+QjBlZadcpS0Kda9rD/Lr1gTit1gm1HEPL8OGvdiBa2J87g+yiNKkMfi7VSAw
         HFv4MKXvYd7V6Y2mjqi7uWBj+ZRkr7L73/hVxlKjSi3cbCaVkqUu4ZB6LQ5R4He5uRe4
         QTjv9944+of2U2WMkbMHrczYt+ysHHBrCK8Xyb6SqF9Xe6ZKXM+/6oDEgrIhICj2sFNd
         knEtTDZRN1OYHRbmJLbEtyme2qct/s3Wo8hjDUaDzxzcTutr55wDKBZEFNBI0dfxMre5
         dQQQ==
X-Forwarded-Encrypted: i=1; AHgh+RplHq/J5hG1pHCsaBSFgG6l2a2oFA3RKbnHaUAq795cMY52UU2AulEZ86B36OsnvWU0KYmvfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfRkEEkBHKkVcScOWiyCoKpBJ/Lo1SkfUK6kX/kEH/MfSqpvwy
	5q5PeXCZjJm7f6naQP64c5EmCX+FPNwzfU+B7Ot37QzB2bQWzZsPrOWvryezOIh2bsiwWphiTmJ
	ZRmU0MQ==
X-Gm-Gg: AfdE7cmu8khs74RvQBngBWltki/pTscq0FtraZolLhVev5hTWUMXv7Dlg6TABKpRjpa
	inTheXqYSXSvAjAELbAYcKor8zGsolPGFKGT7+VCVXAiLtNdO132jyMh/0sygvO0iNs2KwvwX2i
	2NSJq8vWSz+JylGyfSh7Z2+5m6jrv7x4P+DyxsHxIlkD2cyC4GvbgYRyEJBckdfsR66OhHWcov7
	5tg82PVOfsHFxXjL+hYtoNExRrWhAFxm/5F8tOm6amimVAzQpBH4i1vSxHYLLb7zm68n5Pdmw3a
	e8hc/WZB/khP0p12lmBzv9QgLe/l2MR2ISLehPfHbfTDqOBFikE8mOd0V0o1BfG5PqdvTchvutQ
	yfK+oJyIdOGUKv83ewmyFL6R182Oc4MvZiSnOtzNdzky0tegjnWYL7aR4wBBLWx+pdPIwmV81jk
	p+i+gJxgFfddYeQqEHWOcQ+tSoT0l5eFTuvS0wt4ODSzIzC5Cu5JFETrlodtYjIHdU3BQBXBAD
X-Received: by 2002:a17:903:24c:b0:2ca:e0ff:eaa0 with SMTP id d9443c01a7336-2cf2f74087fmr845355ad.2.1784231453825;
        Thu, 16 Jul 2026 12:50:53 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055cd5esm25047755ad.39.2026.07.16.12.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:50:53 -0700 (PDT)
Date: Thu, 16 Jul 2026 19:50:49 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disallow SVA if page walk is not coherent
Message-ID: <alk14o48y7lR05Mg@google.com>
References: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260716053554.1642374-1-baolu.lu@linux.intel.com>

On Thu, Jul 16, 2026 at 01:35:53PM +0800, Lu Baolu wrote:
>Hardware implementations report Scalable-Mode Page-walk Coherency Support
>via the SMPWCS field in the extended capability register. If the hardware
>does not support page-walk coherency, a clflush is required every time
>the page table entries (which are walked by the IOMMU hardware) are
>updated.
>
>In the SVA case, page tables are managed by the CPU mm core, not by the
>IOMMU driver. Because the IOMMU driver has no way of knowing whether the
>CPU page table management code has ensured coherency via clflush, the
>driver must deny SVA if the hardware does not support coherent paging.
>
>Fixes: ff3dc6521f78 ("iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks")
>Cc: stable@vger.kernel.org
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---
> drivers/iommu/intel/svm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>index 0636987f03c8..432e35723ce9 100644
>--- a/drivers/iommu/intel/svm.c
>+++ b/drivers/iommu/intel/svm.c
>@@ -27,7 +27,7 @@
>
> void intel_svm_check(struct intel_iommu *iommu)
> {
>-	if (!pasid_supported(iommu))
>+	if (!pasid_supported(iommu) || !ecap_smpwc(iommu->ecap))
> 		return;
>
> 	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
>-- 
>2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
