Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732E347C9
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e6iv7O9B"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-46788b25f95so562146137.0
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704478648; x=1705083448; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNbqXdkqrNcku01HptF/Xwcm+7FJdNuCYZz2ZggFBT4=;
        b=e6iv7O9BykO3wcZl//DCxIDFfLxOImpoVD1cspoQHbaoUDIfK/1fgdlXqguC9xh8zO
         aawxIJb/6EgrIbFMlz7euN964iT1miDCgsfEXp+WPq+Pb7PsWEO3cM5j+zqMJArNqSIE
         tnwg/iqEleVpvY4Rhwq2qVrpRq0ImAGlZtRRNXM0E2/PmcFua53JV2FiUL+g1SPsTlHP
         Ch590snQw8lf82Vd3IHvgLw84HnqH42R1eUPSbtrMEMD/NhsycsRZ8GprsJSMyedSyeD
         zn/DrjDUTmzqP55UOIn7ZuDlci5Y1SmH3fgza3k1HkuhombUMHhfN1q8k0oDmIu1ju/o
         2YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704478648; x=1705083448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNbqXdkqrNcku01HptF/Xwcm+7FJdNuCYZz2ZggFBT4=;
        b=xGHZ5J7WMorsr3M5fE1toXNKNdDXHevgECpWril4uvhTTrd2ZRdcnvvCeVh73WrSjf
         F8UfmH2a/2VJOvW3kANKR06443VOsboVo+AcKyCkMXDdsnhLCMLb+fmmOwGK3plgh2QA
         d254atbVYt7jS8WFTCd+PQn7o1UkDyj2dQOI6GR1YxM2hqntTEhhWPj6sd1hp+bTDUrY
         O38sOV8C9coRIb58EdQqUFYKFcKd2tQKVIHhV9ckrnAltGoCbkVCaKSAJuJ/5oIu/YdV
         cuTQDP5uxdzQRmdJ7WaEFlXYfqiihoiQDGhT76A7xUZ00qqcudrvb0x7w890X3LpS/JJ
         A7/w==
X-Gm-Message-State: AOJu0YwVh4dkp3O6632WReyvpapXdNOb9F9e5Bra/IhqIMHzDLwQxesC
	6IIvGeuFR9t2sChnCchcuB0u7WV9z5SXvw==
X-Google-Smtp-Source: AGHT+IEA91GmRod1MpicGaASZjGnVM+0CYafsmlPJCq4sw2i1MdDf7IyoH0fqQDrtspKSrdiQ83XFA==
X-Received: by 2002:a05:6102:3a0f:b0:467:2ffb:fe3a with SMTP id b15-20020a0561023a0f00b004672ffbfe3amr2322409vsu.17.1704478648158;
        Fri, 05 Jan 2024 10:17:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ew12-20020a05622a514c00b004282dc56470sm930635qtb.15.2024.01.05.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:17:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLol5-001V5I-2O;
	Fri, 05 Jan 2024 14:17:27 -0400
Date: Fri, 5 Jan 2024 14:17:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 02/16] iommu/amd: Enable Guest Translation before
 registering devices
Message-ID: <20240105181727.GJ50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-3-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:10AM +0000, Vasant Hegde wrote:
> IOMMU Guest Translation (GT) feature needs to be enabled before
> invalidating guest translations (CMD_INV_IOMMU_PAGES with GN=1).
> 
> Currently GT feature is enabled after setting up interrupt handler.
> So far it was fine as we were not invalidating guest page table
> before this point.
> 
> Upcoming series will introduce per device GCR3 table and it will
> invalidate guest pages after configuring. Hence move GT feature
> enablement to early_enable_iommu().
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
