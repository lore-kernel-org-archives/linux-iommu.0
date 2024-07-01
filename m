Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDE16E880
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854801; cv=none; b=T9w6vusSAUZhIgBqG9w4ia8mNpe4cXfLeLG6Al7vON2WHf9PadUUpqvauXBZtdrJkpnhzS0oBZOOwDkRvwYkrJBV6cyn7Lu7G/+xV0yeOKNXtFdw0u6nWTeBXaZ3vCWAoXUNzXIFomz2qDCWBxuDYpbI3QiVCR5LY+SFzTM6Qss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854801; c=relaxed/simple;
	bh=7HLG2jcvr97wpv4VeSCFEYReZhPJWrQ+5N0jJaCOM1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKcSYKSBTEZuwu/sXslRFcz4FpWfBvlJu9zIjQsZuQxN5vx8qEehB/MZF2d85AjR+rYn1lBFnnpu5cZI9CobwKu4m4eVt1Gnga7QKtnQnlxBbWfwV/7AkgWXDe+i1eWmBQdQD00D1rs0Zw5qnvxwXFqabrmmibk6bYwJcWlgEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ftw1JlFf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ftw1JlFf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso18282885ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719854799; x=1720459599; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3jUb8oNxiYmVS34HcxgfmiKvZKs7FXUm58HvTuh/KU=;
        b=ftw1JlFfFfFOWl26AxsXri5MWOwyJOZNVBGqcFTXsL96cXdPmj4ANJokvRNQPWjH0q
         LCwxi6SwuPi6kMlb3FU7+WfxD8Yp2mf5TP+xJH1Kh3oA7pzg9kVBCQ2ASWalwHQiyFpJ
         gbDsBkRX8X2wF0ySaevGda48TOW4uD15vt5h/yD4aWcJRqvxT/mRXF2bPnNE18J7XCCj
         TQ5iKvlSkNQ++sqXHLD5QPNoJNorNO0zn+Pxl91nkgRCmKoE6sHssvh62aefWjh2xqX8
         9Ty5Av6CjZTYdOA6NZP5w/A7OxXWXQLQG7gm8CnrA4MFiASZiWyDbBXH1TdsnbVXfiKU
         bK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854799; x=1720459599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3jUb8oNxiYmVS34HcxgfmiKvZKs7FXUm58HvTuh/KU=;
        b=Pw+X7CcKNpvs2gWloH/iEIcLVXayQvXmYOlH7xFT6lcAHesIYgcx29cLO6kPT84TpR
         IVYGuEY4G3spZwpbVbhu6MJatIdokLESkrV/raJXurSb+PuzlwLm7BEyLLOb4YY35ZZ/
         M/zJxDJBCQpbRjWotVCMMSP67pDN4lW3uO08kQZzzWpsGJMNda+KutBbmXuUJWHir22e
         zphJJNGjtjvlkQ53wHal+z83CdOMPK7N1XqfM5iOecVDCllcQY03CmSbjySTGK3pDZEd
         u4+fY02WmwySkqdYjtywZ9M2qldIsC1MCILsGNfhiqMR6TW4U+MJWumWP7int0bPwRjL
         Tj9A==
X-Forwarded-Encrypted: i=1; AJvYcCVC8AhYIOLqb21mgdXANj5WW1bShExrJAtlfhzQ5rV0tqxgBoWP3DCGGfX55LTjShAJsCHmcPEPfh38CwIGy4gNUcJqkJA=
X-Gm-Message-State: AOJu0YyCRpdQVLg9IPOwabFmmhXeRrr+lBackxcY6ZLtXy8k5nhIRNJ9
	wmjTJdD+jaACHVQt2+iN0KgFjBKKoAy+3aG/y1kXOR8O1c/Zg0Ba4ulh5nsQu9+EDWtHIcnJVBP
	H
X-Google-Smtp-Source: AGHT+IGs6vBQC1++YfmuUdLCmcxkYrnNCan8X4VS2sByOtZisy7HSgkwNJkWaNloBLJwKnCIyRQcMw==
X-Received: by 2002:a17:902:c949:b0:1f9:fbeb:f2bb with SMTP id d9443c01a7336-1fadbcb5458mr47727765ad.35.1719854799087;
        Mon, 01 Jul 2024 10:26:39 -0700 (PDT)
Received: from ziepe.ca (ip-38-145-110-37.syban.ca. [38.145.110.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569051sm67495715ad.215.2024.07.01.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:26:38 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sOKnQ-0003Id-WD;
	Mon, 01 Jul 2024 14:26:33 -0300
Date: Mon, 1 Jul 2024 14:26:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <ZoLmyOzOVYGLKjmn@ziepe.ca>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com>
 <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>

On Mon, Jul 01, 2024 at 04:18:01PM +0530, Vasant Hegde wrote:

> > Then VFIO will just request the V2 domain anyhow and you are right
> > back to the starting problem again.
> 
> Let me see if I can put together here.
> 
> 
> - Basically we want domain_alloc_paging() to explicitly tell domain requirement
> (ex: allocate PASID capable UNMANAGED domain)
>   If we do that then we will fix ordering issue I described earlier.
> - Fix attach device path so that for 'PASID capable UNMANAGED domain' :
>   non-PASID capable device will use AMD V2 page table with GCR3[0]
>   PASID capable device will setup its GCR3 table as well and it should work fine.
> 
> Net we need a enhancement to domain_alloc_paging(). Otherwise I don't see a way
> to reliable implement things.

Yes, some flag at domain allocation time is clearly needed

But you need the whole story, including when will VFIO set the flag,
which requires a uAPI someplace.

> But these two can go independently?

If PASID goes with a default-on uAPI then you loose what you are
asking for as VFIO will always request PASID.

So the overall plan has to be sorted out now..

Jason
