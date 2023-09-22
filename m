Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092153F4B1
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 14:59:19 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-41215efeb1aso14183911cf.1
        for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695394759; x=1695999559; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XFv7wzgSRzNlMpAIAXPdx/9Ru1HG5ToVHBwYeRkmP8=;
        b=eA/EiV2+aYxlRmmP+Xu4fDp/xXSNYrBvI8MdS2EAoE4fdMqlBRyBuhNWeqMAAkgx8U
         inOV9Qkhsh5uwNKoBRlyN76DDBoliDnV3k3IB91LqQstfU1WdBS4hqiWMfnFp4S9Ffk9
         5Ygu5vY03VdXING1nYRUMCHrEO/C+pXdENj7TEBHcWukFq/S2L56TBQ46mJrV0mzJvaD
         RUZ8a0ygTkh7/EeUIUYojNdL3YemSCzm3r0w/kmoB2kkQYKj9PlVBOcogiclgwWr4MfP
         2RZVAlsC3deRx8qh4pRBGP5wC+1RgacY97Q2TTEVIcIIy8m4/fDVJi8KMpqayla0vqRU
         vyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394759; x=1695999559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XFv7wzgSRzNlMpAIAXPdx/9Ru1HG5ToVHBwYeRkmP8=;
        b=kpY9C3hpoGcR/v8//6AXm8ujMRrIGpvQz6v9PBzBaW6R6ra09XC8yuDwmLGk1bNQhr
         n1FEIPjUExI7zHCngLxDbaCAf2IYyf0S70VcZTJ9A77/LbiSJfybIFEqoT6oORx5dQe3
         d5zLrKlfT8yrHOLSr3/58AUe5AsUttKHevirer4aRCA33stMUjUv8dzdo6A8ywUi4DEj
         u9dT82c7IlIUxtXMqMuyk2823JuRwMkkrah5Y5jaTBhYHdtah7tEa+XsLCONchctxLua
         dhaxAMAIC6wYshPCtphPom2tNuR8PwV4YwcSRb6xAt1I1Zwe7w2q4cGx2wY40KYoQHod
         x0jA==
X-Gm-Message-State: AOJu0YwvfHMz/kgtg4USvObVLjcBdhjbLf5kJHdFZ3TNX4zgyIxitZ15
	O73P7AivOCFnFQLBop7WmuE+eQ==
X-Google-Smtp-Source: AGHT+IFepS22bGXECBY+vUBb2rhMrd9rmdSAqafKVqKT+SSCdNN/lwEK0LNLwifMHk5me/tHvErfGQ==
X-Received: by 2002:ac8:5d0c:0:b0:403:72fa:630b with SMTP id f12-20020ac85d0c000000b0040372fa630bmr10093264qtx.58.1695394758807;
        Fri, 22 Sep 2023 07:59:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id t16-20020ac85310000000b00405553305casm1501734qtn.86.2023.09.22.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:59:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjhcj-000Ygf-KE;
	Fri, 22 Sep 2023 11:59:17 -0300
Date: Fri, 22 Sep 2023 11:59:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Hector Martin <marcan@marcan.st>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH REGRESSION v2] iommu/apple-dart: Handle DMA_FQ domains in
 attach_dev()
Message-ID: <20230922145917.GG13795@ziepe.ca>
References: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>

On Fri, Sep 22, 2023 at 11:55:23PM +0900, Hector Martin wrote:
> Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> introduced in iommu_dma_init_domain() to fall back if not supported, but
> this check runs too late: by that point, devices have been attached to
> the IOMMU, and apple-dart's attach_dev() callback does not expect
> IOMMU_DOMAIN_DMA_FQ domains.
> 
> Change the logic so the IOMMU_DOMAIN_DMA codepath is the default,
> instead of explicitly enumerating all types.
> 
> Fixes an apple-dart regression in v6.5.
> 
> Cc: regressions@lists.linux.dev
> Cc: stable@vger.kernel.org
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Changes in v2:
> - Fixed the issue in apple-dart instead of the iommu core, per Robin's
>   suggestion.
> - Link to v1: https://lore.kernel.org/r/20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

It is weird looking, but I have a followup series that will clean it -
this should go to -rc

Thanks,
Jason
