Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F729420
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KaZcVLGh"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so4884470276.0
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 09:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699291997; x=1699896797; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAv9TZ0vEoMucTVIsjxqL2ImHoFVCZ8DgERpi/2qEaQ=;
        b=KaZcVLGholt1q/XPtVW/sG4up7ZswtpvPMcdRVSOt/nH8g5S8aaiuZ8ebxR8z2HuAR
         LLxmzSTTDoaUg419c4yQm0spGw1NUDy8XIOwId5mOzgLKEAs2YcTXNSZ2ryL8VrZYtWV
         HAshlawGjJeXngQDuI282Fxom4qZ1V4E4CYzsI7gVlxhafXuwR7ing67ptQ9okOiZk4k
         Rfaa9oRAfiGD1Js9cCPgo01Z0/d6JXH2lYzVz34DB2e/v2gi1ci+QfQhSMcY54207cOI
         fBh5NyPGyKzZGdtMwN5jmGwnOZ4eXkw72Cj+CTbED2+4d1WCbNZJ0Dt4EpPSXW8fMnNv
         0dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291997; x=1699896797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAv9TZ0vEoMucTVIsjxqL2ImHoFVCZ8DgERpi/2qEaQ=;
        b=ssPqCaZQxa+ws+eJEJWSy6AcSgC387DXKEwEv/iaxHyheZSeO5YmhlyckDcFaDU4Bu
         WF9gS7v2kAk314T66nFETjuD7H7Be8ZoKRBreRnXx9z/CDIzpTZPf9/czsOLzUMCy1S4
         lp74jM6FvLgOPCn2JE29GMxFTcJqOTMYksIvp75x8nBpKOYBn7M6bM9IjVb2uFdTpFdf
         m7M3LaN3YvR8fi/lsH7kMnTD2InbPmf1ZkzWEIuIquVjJgwp9UcXe8bH6jW2n8bx0X0A
         0wL8JGEWb94TaYNxVi9Fo5lXUHIcm/Gli6QZXUlNVK3WatNKbwqAGP+juLoHpNmITYqN
         FDaw==
X-Gm-Message-State: AOJu0YwgizIZqWpjIV3oxQY2zA5i5AL+47QV7ZK0tzNNjhgwyOcA3l5w
	4FyfHLEM6PiG7kOi1oDErhszRQ==
X-Google-Smtp-Source: AGHT+IHlsNmU+/kiYc6jGKbBOt3/H+M7syyJ+7uB6Nt4EzXnvEgdDfyETKm4dYvRb5CwUO3wvZtDow==
X-Received: by 2002:a25:d107:0:b0:da3:b87b:5b7c with SMTP id i7-20020a25d107000000b00da3b87b5b7cmr16189924ybg.38.1699291997485;
        Mon, 06 Nov 2023 09:33:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id m8-20020ad44488000000b0065d05c8bb5dsm3579938qvt.64.2023.11.06.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:33:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r03TQ-001PAJ-7P;
	Mon, 06 Nov 2023 13:33:16 -0400
Date: Mon, 6 Nov 2023 13:33:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 13/13] iommu/amd: Remove unused GCR3 table parameters
 from struct protection_domain
Message-ID: <20231106173316.GO4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-14-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-14-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:52PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Since they are moved to struct iommu_dev_data, and the driver has been
> ported to use them.
> 
> Also remove V2 page table check in __flush_pasid() as this gets called
> only when we have PASIDs enabled.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 12 ------------
>  drivers/iommu/amd/iommu.c           |  2 +-
>  2 files changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
