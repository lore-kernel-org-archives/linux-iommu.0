Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBB7D06E
	for <iommu@lists.linux.dev>; Mon,  4 Mar 2024 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596020; cv=none; b=YsyuGgjtmUn8cdCQCcxoqq4KtkO5s3DeCnwxsQXtJeiqRAslLd9tHebNKWPnSmk09UMr0EbwD+1bCwHN39eiLGWGlvwY/9AmiJKnOtpsTn6r4463oWh+v6xn9F80v8B54ECZD8yoiPyMiDT3l3m7/pJgOg4VL/QAfv5TcNtYW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596020; c=relaxed/simple;
	bh=BOFjNduxL7qmWjcE0p6IsMG3gekkKAcopxJox1xCLek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVqrgWzfelesr9yF871NZqHXWNOkCbHyUF+iDfAUTrV8jA/JVyd1UsFfI/7lACuLnI1GZWsLXRjeeNsZI5fDJT0kPQuXN+LFq6jm62ijlYEP7jlxuNLORon2fWoh9MWFY5AwIPzADfJeumecGgmFhpbanL8GnE60RzF889LsHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oz/rqiGX; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oz/rqiGX"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1a2f7e1d2so2891903b6e.1
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 15:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709596017; x=1710200817; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HY1G2cD/hTxFB8lFuibAj8FQ81V2QGiEptFcXFmkg0s=;
        b=oz/rqiGXLgw76yiBRLRwsE3HQEKmfhWpY4W2JYRlKsQorULd5Rw3dafFujjBEcnqrb
         ly2MIdEE31zwikDqWcR59XkY25asQcv1WRnRHVkkFPynP1EvZ46op27EaX8oNnWShpj1
         2bRurbxNsj/hvWrhARPKT+puFawPiEq8pmFj81SF6S4BeVDUhCdOED67dMScabsBmg1H
         Ti58RoiYMeqbukXzjF9aqCitBGpCODWYPJVWYLGBBGvYPo2iSgRnRhnespG1tdern0cO
         tDaYYdcZwP9QMVm87mHy6PgL+M0gyMg80JeMzAXSHugZLgi5cG0friq757CdhNWKnlqn
         Wi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709596017; x=1710200817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY1G2cD/hTxFB8lFuibAj8FQ81V2QGiEptFcXFmkg0s=;
        b=gLGpOE6g1bXM4qII8q9NGMl6rIn/fhNdgAZt3/e0pImASdmFEYLHCktujUQLdaPxsJ
         hoqgtRIyb0RwMx1aoXaY4pxe3/zwknFYRjSFdZFoHo56CGWJvBCt8GMCvKTufG4fQ363
         irvKJxv/f4ptto0QzOdK+NAUBleJVq0HA4GTuwPeWmrwE+H4ZlepzpBSfj/C4RZk622n
         0MDe6fsL5etYErT9GteNG3DXhtn7Vs5kIEwrJ1LuColY3+cCaodHf3bX6VSpBF0QpaR1
         tea9e6FojZLmpttgIASAERXJ+pjDvCBWRvgxtmbm23lf/LFQdCHDMw3BWvMy5D23ocFo
         s5MQ==
X-Gm-Message-State: AOJu0YyDtPVYwH4nY9Te+ME0CMjeC4Qj3XecNynDFurmvzt50EvBzMdl
	7rBjs2Czdboea+OsMteuTyVoYxo6XGCVLrxZiJbg436yQ9144srZId/ZdpyYif8=
X-Google-Smtp-Source: AGHT+IGEsEOa3CWRnpJbyYNb3fRl9L+PQ9RsxDPNQ/3ajMhY2xhPN1NbYIHBW8VqhnQu0KhsjnGx7Q==
X-Received: by 2002:a05:6808:190:b0:3c1:bc74:1037 with SMTP id w16-20020a056808019000b003c1bc741037mr205984oic.52.1709596017207;
        Mon, 04 Mar 2024 15:46:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a29c800b007881ff8cebasm2390233qkp.92.2024.03.04.15.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 15:46:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhI1H-00DOgu-OD;
	Mon, 04 Mar 2024 19:46:55 -0400
Date: Mon, 4 Mar 2024 19:46:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 06/15] iommu/amd: Introduce iommu_dev_data.max_pasids
Message-ID: <20240304234655.GA9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-7-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:21AM +0000, Vasant Hegde wrote:
> This variable will track the number of PASIDs supported by the device.
> If IOMMU or device doesn't support PASID then it will be zero.
> 
> This will be used while allocating GCR3 table to decide required number
> of PASID table levels. Also in PASID bind path it will use this variable
> to check whether device supports PASID or not.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/iommu.c           | 12 ++++++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
