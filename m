Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26D5B5BB
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400791; cv=none; b=m8Z8/xszwy1NKRWp0UKKktBmPV0ehzws67W2GVOcGOAjzA8tDurOT3H+eVkVk1toYe8vdjuard9vLfC0uVq3WDiOP2lPGkqknJpdz1XldtzeG6ZDxTSJdYWC7Jwm6OM4KxxXBiiQHMlbc1m7QM6eVYFHeSkNI63zjA4/K914B0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400791; c=relaxed/simple;
	bh=sfVyrmgaj5oBn0tCvQYHQZQDZDExeVi6rltukh2TVvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfFbRKk3FJjldKastYJBXnLWZwUl0t/wPF8K0BQsdwlJjOM+StYmjT/E6LwGiJ7w0iAXqjqF7co+20yjIEGD2aVAYo27pr6SUbuXVK2k/jdn+pGW+zrK+8OS353WBsS8X2BemVFin47q71KZgeIzCEmNr+fb2Whxzh+lyzngTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WOV/yvg4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOV/yvg4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4140eed8a4fso7805e9.0
        for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711400788; x=1712005588; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87kSRxw1Ym98c2cZV0HSeTHtXw3IMZt6YXbhTpf4Gn0=;
        b=WOV/yvg4XMN7y/GirBkf4V+lac07B7kk3nFjVjBvrpDiTIZJLxLmoeVdSZLxU3cc38
         Jyql4UptfhxunEe4vc8bV/byIfJoJpXgETFYgn8qqO7Gr4AtMBuZ5EOCJw4rSAehfyy/
         QyUS+3zoN6qsxrV0fJTU+Zb2685eo+QAoc1iNLZzSTJFcfN/2SsS8si9zPn08tJ1LyuY
         MjxNHjC89MwpIRm8EtTaa2uYIX5Fp67HORTrYEJyqIkN5cN1zftkonkLr3pepZcX+I/y
         BlYCZkbklqgnA5xHDyxKK+k4AnG3iLEEtf4OvhmLD8g5nM4awYOlGDOaAuTzdtLj9cnR
         auwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400788; x=1712005588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87kSRxw1Ym98c2cZV0HSeTHtXw3IMZt6YXbhTpf4Gn0=;
        b=qZMvDECMvejpiiDH8TagVuaCoeJcDc3t+LgguJn8t9m8lS3LaFpXgA7pXKaXbcRPs9
         ZZD+nuXhzA0BQm9lN3LHbnwZNdutFaXTvFzr7nkfCn/4ynRYjWXahnXOm/98PBomAttv
         d6ZuTf85TwAhBlKlcE5V1LMwkRat90ZsMxvo5WAo1pMksditd00hevFAMW7ia5yU9A/g
         wHWEMkpLFVBrRWBwoujO10740suAUIEhg5WR1WNYvoGd8GYynFi2OyIEbHaQi9VrbEPA
         EKhj3j8H0nepKjEShwU0ZQsB/bv1SwutcaY6edo/ea4yJi07cVrVoZLGLWoJxOqAJAcd
         LLbg==
X-Gm-Message-State: AOJu0YwhhtZ5tpvN8ZM5b6jUBK5J2sVYtYtgoHZVJvZIeZPkmQ95saCo
	jwZmWSYgEu13RLMzQ51D1zXidZM3O3Kv6x+6FTlk00YmmD5rD1yIXeeekkOrPQ==
X-Google-Smtp-Source: AGHT+IGJhWAECCUdYs4iDPZsz04LuG+syQz1Yw/Xrcg4rgTS20erTsGI+S2EJx10DtBo6OyLMMwq8w==
X-Received: by 2002:a05:600c:1c27:b0:414:fb8:5105 with SMTP id j39-20020a05600c1c2700b004140fb85105mr17168wms.3.1711400788139;
        Mon, 25 Mar 2024 14:06:28 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b004147db8a91asm9518815wmo.40.2024.03.25.14.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:06:27 -0700 (PDT)
Date: Mon, 25 Mar 2024 21:06:23 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v5 00/27] Update SMMUv3 to the modern iommu API (part 2/3)
Message-ID: <ZgHnT8ZoOtzUwYwb@google.com>
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <Zf7bPOtRg9tLSOKT@google.com>
 <20240325143503.GF110546@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325143503.GF110546@nvidia.com>

On Mon, Mar 25, 2024 at 11:35:03AM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 23, 2024 at 01:38:04PM +0000, Mostafa Saleh wrote:
> > Hi Jason,
> > 
> > On Mon, Mar 04, 2024 at 07:43:48PM -0400, Jason Gunthorpe wrote:
> > > Continuing the work of part 1 this focuses on the CD, PASID and SVA
> > > components:
> > > 
> > >  - attach_dev failure does not change the HW configuration.
> > > 
> > >  - Full PASID API support including:
> > >     - S1/SVA domains attached to PASIDs
> > 
> > I am still going through the series, but I see at the end the main SMMUv3
> > driver has set_dev_pasid operation, are there any in-tree drivers that
> > use that? (and how can I test it).
> 
> Not yet, but some will be coming. Currently only Intel driver supports
> it, but Intel HW has other problems making it unusable..
> 
> A big part of the effort here is to enable the platform ecosystem so
> devices and drivers can use it.  Moritz has access to a device that
> can exercise this, though we are still working on it.
> 

Just out of curiosity, are there plans to upstream that driver?
> > >     - IDENTITY/BLOCKED/S1 attached to RID
> > >     - Change of the RID domain while PASIDs are attached
> > > 
> > >  - Streamlined SVA support using the core infrastructure
> > > 
> > >  - Hitless, whenever possible, change between two domains
> > 
> > Can you please clarify what cases are expected to be hitless?
> > From what I see if ASID and TTB0 changes that would break the CD.
> 
> Right. For CD it is only the SVA mm release flow, setting EPD0.
> 

I see, thanks for confirming, I am still going through the series, but
I now wonder if this case is worth the extra complexity, unlike the STE
where the hitless transition was usefull in many cases.

Thanks,
Mostafa.
