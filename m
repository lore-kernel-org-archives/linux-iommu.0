Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF61E53F
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZAPaZRvJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b84e328327so707337b6e.2
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701366839; x=1701971639; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m697ifUX9X9ZplebMMGMHLUBOgLEyfUm1TWhOvlFGBE=;
        b=ZAPaZRvJD/4mcl+5yapJ6DqMSM1EBaUSWwzEcW5BrompA+AJj66ZAHHdhSSV9gwYQG
         pBETxTQ1Tb9VhqsF0XcHPChZc2nc4KdOTT59xVGoNpJvRx1jI4vxskgqaXragJBYtx+1
         6ascSxBU4GjinKAGQ96MFgyHhv1AF6aNkpfIFCOntc573FUXxdsK9Fok5iO5xWedotw4
         LrHhyBl5PJv4kNp+/qq7waigNfNzWD8j70QkF85MM38J3O6vn116iyu5OkDMu0eBmAXy
         GP3NB9G+jZo20qPAACFX+xan5VOKM1QD23w+7+k2Q0jOcdftNzofvMn+zmvOu69dKHHb
         C+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366839; x=1701971639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m697ifUX9X9ZplebMMGMHLUBOgLEyfUm1TWhOvlFGBE=;
        b=kSU7hHAH1eYyUETgfHzmy7yVyLIGb2HyV6CbEk291u0DVToNh3QnF+O2VyWQL8pRst
         2cnA9Izl3q8XOWzPAqejWi6BxGGQciZP8CKbt+zdL++IOtMyKjZE8F04Zf4+KQJ+Ivd6
         U578JjVWGjxZuIT6zQ9A4cS1YuT0V+e6MzcKrRsZgHVd2eXawgr7h7jef70q3FxNKArx
         L6UN2Yi+sol/ydmdvHu7Mk0JBgbdouHKLC8Fz6CoJO85205+drm6pgHGB8TMh5sbXMTE
         XQWUHErQanXCwWsxMiDjtfoXA0fn6QsHZ2ocGFhK6OYn7g/jpsoC42VpzDgyp5mGvNUx
         4BMg==
X-Gm-Message-State: AOJu0YxsJgq6qDp5Hu1NWGxJ+nh1grjWsUeSYcHjJAdlj+Z+OoLvvka4
	keG2EtPbV84coOxj6bYS38K0y+Irx6wjTj3wgGY=
X-Google-Smtp-Source: AGHT+IFMPbsJbBI3lrkjpFYiOHwTbmJIP7X15WXFHXZfc/G6uHQ/CdvMqdvhdvdKwiy5zgESNqeISQ==
X-Received: by 2002:a05:6808:238d:b0:3b2:e61f:f0a8 with SMTP id bp13-20020a056808238d00b003b2e61ff0a8mr327099oib.45.1701366839061;
        Thu, 30 Nov 2023 09:53:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id bm5-20020a0568081a8500b003b8695c93d3sm252155oib.32.2023.11.30.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:53:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8lEb-0069oj-Qf;
	Thu, 30 Nov 2023 13:53:57 -0400
Date: Thu, 30 Nov 2023 13:53:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 9/9] iommu/amd/pgtbl_v2: Invalidate updated page
 ranges only
Message-ID: <20231130175357.GG1394392@ziepe.ca>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
 <20231122090215.6191-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122090215.6191-10-vasant.hegde@amd.com>

On Wed, Nov 22, 2023 at 09:02:15AM +0000, Vasant Hegde wrote:
> Enhance __domain_flush_pages() to detect domain page table mode and use
> that info to build invalidation commands. So that we can use
> amd_iommu_domain_flush_pages() to invalidate v2 page table.
> 
> Also pass PASID, gn variable to device_flush_iotlb() so that it can build
> IOTLB invalidation command for both v1 and v2 page table.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/io_pgtable_v2.c | 10 ++--------
>  drivers/iommu/amd/iommu.c         | 28 ++++++++++++++++++++--------
>  2 files changed, 22 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
