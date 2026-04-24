Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5943659F6
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021076; cv=none; b=annPhMvwyH54yKWrlnIUbsZOA4I+ALRxiba5jC2bfieciNxrn573VNJb1S17Hqnj4RjGqWVvnioN1iGdSsoFOEP0imA2bT2Z0y59Sk62u14IqnyYYdw56G0+jy66Y54ffl3wSm7uuGYm+8zzMtnL+v3v6fXahKdICSOacPE8aiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021076; c=relaxed/simple;
	bh=im9BpNo3HM0WXa7B46VITPQSYzn/y4+H/7Tp17gibD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rFoqunJu07ZaBMCP1boJ0XbLLqAhGhuxVHPFKOuS0Uc8lMmJ4X3nAcGjIRUlJJ1bnqG1yJ2LztHcO8Mi8qHnlc9irnv+p6A55cXc2ZjR3mpng8yvEh4yAQwB6PcxUBvgsMnXazUAZ3dTjEwgftf/qVQguYZBt7Z3s+7zfPU0XEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxR1LsjQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxR1LsjQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3614272b00cso9452015a91.3
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777021075; x=1777625875; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwFNTETipk2+0oOmAmumV4DtfgdBkUEEsoK+rKkQKqg=;
        b=QxR1LsjQOosAg25P5iwQA2xo10l+sL6XthNA8HYeR17VKYu+JNM3vadOkO3nW+A5Mn
         To12g6BG8/0jJ1xppjwyccWp5O75gT8Pwv2o9azagNuOYm60P+92k5yhUBnyUme4PftF
         o6pVtVdAM331bVmJmHqaTNrraFb9ZA3z/R5mVwcCYCdbHoUcksqf1Wu4xUdLMFd7g0GO
         IX4ioAS0GNzVseKrZGgVN/TVVsAtozwtvDGrwpS0GSGAvRN33UeeqwoxNxttNdppDtl6
         t6lRiwHttSmnPp9U5Z0/lXtT/1nI4Gs4CdFEvg8s9/Lg+57UBvuiYns5/sPnuA/tWw/a
         ua+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021075; x=1777625875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwFNTETipk2+0oOmAmumV4DtfgdBkUEEsoK+rKkQKqg=;
        b=q8LAuuhWAEsUH6qad00IWNW0WWXIGGPIE+FkQc6mnCWAgUd2X0z3nJaSHTT74z+YYr
         VvGvM5q8BxHz7Q+F37M2B/IETIN2MjCYc9CV8RWa1P9wlETJqh+0occg3AJm3sGpvfI2
         Voek7F7rhl162Px9XmwwjKkZYzkz2g9yEev+h6ETw/7z7qNork22xJcc/SwZ6PCVr42c
         4cxMm07am6FzccWO6zMVl0yYXGt/8od9gXRQPUydIgn6Ncu542v5fBURAaS2xjd1S5Pr
         n7ntgD8e67Vp4VZzhvuvbLICpuxndR4g4Wvd3KTC2BEoR5Cz6IQ1324Nx3PIVXWGw7Uw
         O34g==
X-Forwarded-Encrypted: i=1; AFNElJ8/ADxiJmU73JKwsmSyinz0dgydxPnOe66+A3omZDe+9U7ku1WnLPDOiQGinSB3ZoKMmotvPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6pFvKxlYIq9zNaQbHSy/BowMRnPllYyTBZHnrq5wKM54kzkdA
	rFZ8m9lrgm9QLaLRJ6+JJ1L95skuNhwdXpdjecxfbGyuwJyaW1T+nUYyXHWT5X/SOTVbrD0GBV6
	y7EkfwPj/ySFpXO2FyqVmbMQPvQ==
X-Received: from pfbfm15.prod.google.com ([2002:a05:6a00:2f8f:b0:82a:6ac2:2386])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734c:b0:39b:c4cd:d854 with SMTP id adf61e73a8af0-3a08d8a876emr35407723637.30.1777021074747;
 Fri, 24 Apr 2026 01:57:54 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:57:53 +0000
In-Reply-To: <20260424085011.3502295-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260424085011.3502295-1-joonwonkang@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424085753.3505585-1-joonwonkang@google.com>
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: joonwonkang@google.com
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com, 
	baolu.lu@linux.intel.com, iommu@lists.linux.dev, jgg@ziepe.ca, 
	joro@8bytes.org, kees@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, praan@google.com, 
	robin.murphy@arm.com, smostafa@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

> For SVA, the IOMMU core always allocates PASID from the global PASID
> space. The use of this global PASID space comes from the limitation of
> the ENQCMD instruction in Intel CPUs that it fetches its PASID operand
> from IA32_PASID, which is per-task.
> 
> Due to this nature, SVA with ARM SMMU v3 has been found not working in
> our environment when other modules/devices compete for PASID. The
> environment looks as follows:
> 
> - The device is not a PCIe device.
> - The device is to use SVA.
> - The supported SSID/PASID space is very small for the device; only 1 to
>   3 SSIDs are supported.
> - There is a custom way of transmitting the SSID from the kernel to the
>   device.
> 
> With this setup, when other modules have allocated all the PASIDs that
> our device is expected to use from the global PASID space via APIs like
> iommu_alloc_global_pasid() or iommu_sva_bind_device(), SVA binding to
> our device fails due to the lack of available PASIDs.
> 
> Since SSID/PASID is supported per-SID in ARM SMMU v3, this commit
> leverages the fact and lifts the use of the global PASID space if
> possible. What it does includes:
> 
> - Introduce a new IOMMU capability IOMMU_CAP_PER_DEV_PASID_SPACE, which
>   represents whether the IOMMU supports an independent PASID space per-
>   device, not shared across devices. ARM SMMU v3 is the case.
> - Open a new API iommu_attach_device_pasid_any() to allocate any
>   available PASID and attach an IOMMU domain to it.
> - Opt out the use of the global PASID space for SVA if the IOMMU has
>   that capability, and use the new API to allocate a PASID in that case.
> 
> Signed-off-by: Joonwon Kang <joonwonkang@google.com>

Please disregard this RFC as I have sent a new one with more recipients.

Thanks,
Joonwon Kang
