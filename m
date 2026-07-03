Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B73D9DBF
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086374; cv=none; b=i2hLrzS1/VhYKFg7ofHqmXCvYljccNvbrdBkf+16jhBzVsEiX6b/X8dj6ma/jzBSK+1scAIYlJufM7PuR8zPca363dnGQH/KOpa8hNJX/jmcd2HAxRieDzf9lGUXgfWBSKUf6I7Zcs9G5fUBJnpKGXVufNvxG23gL9Ax2wVnu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086374; c=relaxed/simple;
	bh=PNYyEgoZtTQZAIb05vcE56UQchi78kODzvtdyqQGPd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjL5FyzPGOyqILFMHjxiMEUxI5ETwcjXkAEYMohruq7wkBvDepJJrOMzskiU1BcyzUWQVSjFFKAebs1T3p2rRr4ssZxtNeOtVR0Rtkt3RbAmSJQD+4xDDN/N5ZwkcDI7KsFFFc5MxgFByoLvfEleGUr3lYl4Gu6X8unoQs2LzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4JBjTtT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4JBjTtT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9b1db4964so286415ad.0
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783086372; x=1783691172; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dEobmR+dTUalRHOtzAB6SzqkNWJ+47R827DKeMKcmBQ=;
        b=a4JBjTtTAr43xkyaZsjo3mbVIHXsVzaJC63Zx2CZGXje4nyTtbc6Vag4vaeeoLd532
         +12fOEwT7991QRK68CDeDAJICgAXeqfvoAt4KX4QUaUbi5kvcG+jArLUwed+1GYy1pih
         PzFuxIenZ6iT8bjG0jRDc1nmYvGWYIwFgrQ8lV9F1m99bfIuULtZOq8oFAHwpREOHI6x
         I7dTBfSWQPrq8I38YJcHQugJwgb1miYDuHxNFTihsY8w7IuMtBM+9a3zyjuqyX7auRYG
         e1VT8pPgmXHwXK7OYshh/Ff7NvUARzMnRQ10zTGbsviqmuay5d55K/dRUUODJnWQQ6mH
         SEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086372; x=1783691172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEobmR+dTUalRHOtzAB6SzqkNWJ+47R827DKeMKcmBQ=;
        b=HEraDFOFwTEyxndn/yq+L6vN7+HVhy611rSRk1PPqSgrbLCKnj3Xv/Vq0t3PUQ+jik
         FGDWGgqSdCMByvgDoSqYihLyzDHuveO4cIWxzZzN9pbUhaGnx/LGR2JrfRI8hlihdeDV
         nBvRzHC7um/QAQsx5WspsionH8iAhZBIK14D6TqqajcRIfyr9ZQM3P6fRXEnkd/euur/
         zixHyGzNpkqjPtViFVNoeqTiqmb1k+JxuRjyrlbHX6SOEV4zLu3mK8yyZJ5J+ZbxJOhR
         x9SeE6KGxjJmFOr1Jfw6KcEiZ9yGCnBgvytY3DDSjw1JIWprVyNXMSeYLH0ae32c6PqJ
         LL1Q==
X-Gm-Message-State: AOJu0YxVoDAZyBERbDBlwWGvvDpA9mjM2mdbHmxCjmCqv7SkXjdZhjSB
	D/IwyvnOTL9CV6gsDnxVw5+6FdeoqdLn2JpHJ1TK33Kos9HOeuiToIdn3eosdDWnu+RO1T0eqbv
	UMza1Ww==
X-Gm-Gg: AfdE7clhsbR4OC/XqyujoPG9euhxFNOcHs+/f+e9PSKeZf9LOf5V6H+lp1Pj0qLuAZe
	rkgc/vIAYVBhZnqKLmiqxMFpF3rNfwUHfrCHwvA0S1VWegXZEvJNbgw8uSdNEfLKV7B68uYmHwG
	jUUTyoTDy7/3FXnq/tCJP4qgSQGt7+KSkRuvpv0/i2bRr/sIr/8GWsVXmuTpjqAMUQSn/U8NJL7
	e65c6dU0tFyemErVgES1pwihzf7szmQSplE+KF6NQ09py9ehU5aPSayek3K7K9b2/GLI+43JhtA
	fCegsMgGw1/9XtkZB3n9oNYQtZx4DNiYzb3Zi5DdhJCHw7TIf9ynS102tXfTI+dHOkFvVlg2z3Z
	a5H6bL2IxmJMG78Py+ZqPnAsmM1IQiDDX+eMVurb94avJCM9IxsZhLk9UoT9GcFCTs8yzCNg8Mq
	9x95FHu/9ZKCGWmJkHBYoE2OsYprVH5YOjxuOEV6wuF9heJq8=
X-Received: by 2002:a17:902:fc86:b0:2ca:d873:3b41 with SMTP id d9443c01a7336-2cad87347damr1931895ad.19.1783086371317;
        Fri, 03 Jul 2026 06:46:11 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7894b20sm9826605ad.78.2026.07.03.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:46:10 -0700 (PDT)
Date: Fri, 3 Jul 2026 13:46:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v9 0/4] iommu: Standardize ATS robustness and state
 tracking
Message-ID: <ake9HIb60em50WaC@google.com>
References: <20260615235037.259909-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615235037.259909-1-praan@google.com>

On Mon, Jun 15, 2026 at 11:50:33PM +0000, Pranjal Shrivastava wrote:
> The primary motivation for this series is an ATS state mismatch observed
> under heavy load (via iova_stress). A failure in pci_enable_ats() leaves
> IOMMU drivers like arm-smmu-v3 with inconsistent state leading to PCI core
> warnings during device detach.
> 
> While David's recent work [1] addressed a discovery race for specific
> quirked devices by moving them to the HEADER phase, gaps remained
> regarding how Virtual Functions (VFs) inherit state from their Physical
> Functions (PFs). Specifically, pci_ats_supported() did not account for
> PF-level quirked status, and pci_prepare_ats() lacked STU validation for
> VFs.
> 
> Based on discussion with Jason and Baolu in v3/v5, it was decided that the
> IOMMU drivers should explicitly check pci_ats_supported() before calling
> pci_prepare_ats(). To enforce this, pci_prepare_ats() now noisily checks
> for support via WARN_ON(). Furthermore, the device probe should fail if
> pci_prepare_ats() fails. Since these early gates preclude software
> configuration errors, any remaining failure during pci_enable_ats() is
> treated as a kernel bug.
> 
> Following the discussion with the community, the driver-specific series
> have been posted separately:
> 
>  - Intel IOMMU fixes reported by Sashiko [2]
>  - Refactors for AMD IOMMU [3]
> 
> [1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/
> [2] https://lore.kernel.org/all/20260531170254.60493-1-praan@google.com/
> [3] https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/
> 
> [v9]
>  - Collected R-b tags from Bjorn, Jason, Nicolin & Sami
>  - Folded in the dev_err into the WARN for arm-smmu-v3
> 

[...]

> Pranjal Shrivastava (4):
>   PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
>   PCI/ATS: Validate STU for VFs in pci_prepare_ats()
>   iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
>   iommu/vt-d: Fail probe on ATS configuration failure
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  9 +++++++--
>  drivers/iommu/intel/iommu.c                 | 15 ++++++++++++---
>  drivers/pci/ats.c                           | 13 ++++++++++---
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 6666bde33b83cb4fc9b1f7ba6a3471479f76ce72

Hi Joerg / Will, 

Gentle ping on this, please LMK if anything else needs to be done for
this seris?

Thanks,
Praan
