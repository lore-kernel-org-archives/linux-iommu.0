Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD395392
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 13:32:23 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7225259f52so3436740276.0
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692624742; x=1693229542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/Vss2A1efjRvXSySTy+gAaIkGlDZNRtj2oVT4I23f4=;
        b=jd53R/wZgUSkcnVIMXfLgwWelTk/IjStMyBFudpritboLU2ylLhZw88SIrsjAHSoNt
         frKO17zOIJ06hvUJb1TdVKoJI8EJC4cDjSo0pcNxzLOoFwD2t8bQOLlT+jwqMQ6X9lRM
         gXnT1zAkHUW1QpGuCLd17zElnTOCopDIr9EbdzyTgPHwrPMNF5kWEdv58NkZ/2ls39lv
         LBso+Y6Uy1jNNKwB1r3jXGcCxY75CNMrIYtY7TvgO6tVJfEIlvyUTkhMz3ReQGAUtdY2
         plB2DYlhXm6IDTBTmDtKtafd8kW7AkPwJElzxVsubE6d9zKUxYC2oF2+sGvV3MGSELzn
         nTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624742; x=1693229542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/Vss2A1efjRvXSySTy+gAaIkGlDZNRtj2oVT4I23f4=;
        b=Upn20T4bWPE9OBB6l7qPNAnjynSZ022ZIhxw6hk58Flg22aeLtImJhAmxT/QQWLGw1
         9NwEYA+38R5RDEyIVIRqTclTTNTLhUoSYdhLTCYB6hg/wwSS2R8ePbqEU3Jt9/e0YvyX
         6lyZHdtB8JCf48mSHF7Zv5WbM0NDx7r2ZGdZWnY2ZIHP+qFIjp2aMCiPrxocwiFLBx6/
         tX4t6E/rCYk0lR+4pZ69RBwEKp2zcGVC0D11dmJaGQfwVgHNXaZNolwPMlUyCEqR9KW5
         nog/elnjVoah/yhtMPBZXvXMDDkv6uODCz3AcdSjYQnHk/0wP5QbAK7ZzYhe+ps4+1Rj
         BWFA==
X-Gm-Message-State: AOJu0Yw/1H1z7z3a38ofAbIrp/z/WpVafFbnCX/hMUVUaufGY5VM21Mt
	Dpr0jqFQuREaSlathGLX2lWRnw==
X-Google-Smtp-Source: AGHT+IGeTS7crVxYAUkJ2LPq7t/tZqkgdgZUzufPXzOCSLyVY0HCWHpMhbsOVwQ8jgZj3NEPUn2F6Q==
X-Received: by 2002:a25:8204:0:b0:c62:2320:2598 with SMTP id q4-20020a258204000000b00c6223202598mr6450277ybk.62.1692624742589;
        Mon, 21 Aug 2023 06:32:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id f8-20020ac80148000000b003fde3d63d22sm34319qtg.69.2023.08.21.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 06:32:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qY513-00Di4V-Id;
	Mon, 21 Aug 2023 10:32:21 -0300
Date: Mon, 21 Aug 2023 10:32:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 12/14] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Message-ID: <ZONnZcMLDOTkT8SG@ziepe.ca>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821104227.706997-13-vasant.hegde@amd.com>

On Mon, Aug 21, 2023 at 10:42:25AM +0000, Vasant Hegde wrote:
> Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
> ATS, PRI, and PASID capabilities. But these capabilities can be enabled
> independently (except PRI requires ATS support). Hence, replace
> the iommu_v2 variable with a flags variable, which keep track of the device
> capabilities.
> 
> From commit 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability
> with all VFs"), device PRI/PASID is shared between PF and any associated
> VFs. Hence use pci_pri_supported() and pci_pasid_features() instead of
> pci_find_ext_capability() to check device PRI/PASID support.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  3 +-
>  drivers/iommu/amd/iommu.c           | 46 ++++++++++++++++++-----------
>  2 files changed, 30 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
