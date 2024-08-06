Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7944C81
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964737; cv=none; b=p6RNPw4OtOv2zBRJSog0c3/ji63CW4FAetHQP/Ui0dcgHxD7E/5no12XmvQipUiLeUBSUUMJoUpe6P0Im5zVuhBh/YXvBgdiqYrCuiv+ic3aM3xWpz524T/OcuWjT3Hhdgzs9SlF3x3VfUjmiSCImfoPslaNSTWVLpJPEdpVJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964737; c=relaxed/simple;
	bh=IBADP/w6lT+GloFq+zVIBopi0AnD74uQ+eJRhROk9wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR5N2APNiRJj7Ztd7CUoeBrTi4nwB+9kazWuYP8e09gknUqiajC+qqA1ukp+eLWESQxiESHfg+xEA9B2anb2txPD3VafG8tkNH4DWkjRU4n1nqmrJhYufYpxMQxu9e7FGW6gIwHsB5zNoLp7gz2I8Z/F5BJzVT0/VX6ETSxofg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=loDKoMde; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="loDKoMde"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db1d4dab7fso531853b6e.1
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964735; x=1723569535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VoUl8zSxENKiuQEX79i4MjQfIL5VeaQAVPLC67ffTWE=;
        b=loDKoMdeqI5aC4LRUUkGBV6UNhBc0z6C/O0BI3Kj/6BCHHwLPBoA4oRnqu5vU0PZks
         DuCSWok0SxSNGVSiZAAXf91SetgT7cTkDH6s+JNBJXc9FMJtt+kaWRv7XI+y3d5Q4uRA
         aXssL+srYWZBqQTeo5oCWt497OmYFncXRMlSjOKIx4KY4y+Uxd8z7T205Bxyi4eHB0C9
         NoWAmlYi+/01XtqAxC2Jcbd6fZW/CZjaB7zLsTDeMLhyBhNDaqwMzQEXiIMIcf/TNw5F
         02ECXb9tGaScWOi4pHQqUFOrRuVoUa0MP1ddeQFLoPC9oLC+gAAdYO0XNav64sPL8keA
         3xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964735; x=1723569535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoUl8zSxENKiuQEX79i4MjQfIL5VeaQAVPLC67ffTWE=;
        b=IcyG9wng4mAZAaG5bo0EogKQRSgeOGTPAIL7GDLkRuuaEHiXaS55FcDS85ub95HgHA
         FJzSRzVwpNl4E/mdeyGRLrnU42Cd3V4sz8U7UZaNCigLft1v1GN8xVbjPQWgwdLrorca
         PFviwXBTPrveU/YNAqM5bZ/pkEoltWb2vhlM5ZQu9NQovhxhQRV3q/Mc3m++gRC25bL1
         Kh7nGnpKaccUKQMi6r9+jMSwucPaOSEZ6YsBCfNWVgAbQRTdUkwOF28xinvpQ8/9B1nN
         b1rAetRoXXoX2SX0AyLeTk7pJ9ve+WFCYNmXHQ/lyvzqsLDJWAJ1ALAX2YAyKZw2HA2u
         cxwA==
X-Forwarded-Encrypted: i=1; AJvYcCXzbwSaJ5aTHbRao5r72X90IqF1sPgdk5CfsgGr9yR1t8NXC1SudRgBXWpbWY/qKWrCPY3N1N0ozxQKzLQWV9Y7whefzxg=
X-Gm-Message-State: AOJu0YwOhaPsnTOGmOXznBLNetV0GXRE+25ToA/9Tn5u1dNZvTUpJ+m5
	PlmcGUsSjwAaiAaaZxInbvbT6W+2loGLiH4TiPox4bmVP9geSHCA6/XslV1tZV0=
X-Google-Smtp-Source: AGHT+IHztlUJk3Ij/7lCfrlgZF1fI3NBsUaBeFjNzvqSEvtAyOgYO2NOyIsV7Js7a5m4fRUGZL0AaQ==
X-Received: by 2002:a05:6808:2110:b0:3db:42b2:ee28 with SMTP id 5614622812f47-3db5584dbc0mr17609250b6e.51.1722964735222;
        Tue, 06 Aug 2024 10:18:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6eaadfsm39713191cf.51.2024.08.06.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:18:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNpm-00FX5G-A6;
	Tue, 06 Aug 2024 14:18:54 -0300
Date: Tue, 6 Aug 2024 14:18:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iommu/vt-d: Add support for static identity domain
Message-ID: <20240806171854.GO676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-7-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:40AM +0800, Lu Baolu wrote:
> Software determines VT-d hardware support for passthrough translation by
> inspecting the capability register. If passthrough translation is not
> supported, the device is instructed to use DMA domain for its default
> domain.
> 
> Add a global static identity domain with guaranteed attach semantics for
> IOMMUs that support passthrough translation mode.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 102 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static int identity_domain_attach_dev(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	int ret;
> +
> +	device_block_translation(dev);

Though it would be nice if this wasn't hitfull like this, someday..

Jason
