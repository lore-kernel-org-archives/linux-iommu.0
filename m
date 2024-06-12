Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF61179663
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198392; cv=none; b=ttnsZJ2JGHhu35qq8aHbFeeyzX68s1EWBufpEYmJS5gW/5DOCn2Cq4PiYnV5BYttWXC3ROlYfK5ekYgkRTvS84mwWC5bM21i+HShH/30iobq8VJRXjxEyJfBIkLbT/kgK9snQLJkN0L1gZu67MNc6uNRc78T+SdMQCFSmHrXYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198392; c=relaxed/simple;
	bh=30kMMEM/0RGIoM4AKwXZ6d0eDjEm1u/8hrr3qBtEMls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK4xyM7JdD+GJY8JbdgvvFDtz2fkw8a42f/XdXHKxrg4HEpA5KHkhv+DKQai1MLNGQT2H4ui0W5r3iSe5ad+9nJT04hXctKiNi6W/jIQyOr2jQHw1hrGynuh7kl0lIkpXaOgaqU8nwS1dNUbDOjeYciMWoB8zeZ9yTiD7P79ZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Jc0utkGE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jc0utkGE"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7955841fddaso93003185a.1
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198389; x=1718803189; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIK4gueTNICdj2uOTyUO46d7/vRhcgixUddDleOmgKI=;
        b=Jc0utkGEOWUQlxGxc1xcwviujJw7xXPfiPHy7nvUn1bhh3ip5loYQr+0NqI3V4TLnW
         2I2ugBbDkv0gGqXHYkVb1sSwsWM7d+qWheOaZGU4xl5xf4HCF4Rd315PMgAjfOOTyG2o
         M+oz/I4sETC7MV4/hDpWfXpgcdS7toaPoKvXImclgkiJHYFo8kxCS1ebyxFfyg5pKJVy
         kROrx9uYyX8meS4QJVzx80X8hKNCtosN30hcxA9oK6Tqx21esmRSuli57H8D99roTJ6u
         zqEiG4cYUiFcBds3YUm/J0xnmxAeyP+y7624AWft/n/T1tsgu98kON4m0COR+X088BE7
         kl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198389; x=1718803189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIK4gueTNICdj2uOTyUO46d7/vRhcgixUddDleOmgKI=;
        b=N4omg1HSkXpCd8ckzHOIjyBfjHP5H61xJs1DoOWBVLGpFFV6+EyqS94qyzt2zECLaU
         LJbF8eSTn6f6yGe+j0ZM9BZQOUOJ1VsgYxc+nz16/Ov84OR14UFIK69d1rWpyIE+CQxg
         wecgpnhzioOS/o7d/jpGjsbG2EUjk5m8jJNcs75Y3oXMHdKx1D3rgi/aGxjDcZAiBf7U
         mWjlcALE4Q1n3wMGxUJrMrbN8cfeLC9EBqCGqKEUi6SLKNoj23fS7a4hHEhWUFVXhyH2
         aTcllN3D8ws/ILsMquuK11WPWUaFAF0UNB1TB5UaxhbjOik5/zjEnCvWtk2o6p22Skxp
         TF5A==
X-Forwarded-Encrypted: i=1; AJvYcCUbcwO3QmIma9n4Xuy+O3HqBMT5er2qqQOdCLCcLos+8TG4e0ewd4pbRhxhtANYnVXMMUWpz5rMBnnByYa0vGCJEJjIDnQ=
X-Gm-Message-State: AOJu0YximqxmjqSNNsCdfhTP3gERhymiv1bt0dtHY/zYVyA8rrEPX+Fw
	RwJHp/dx6PA5zcnxnqXeLW5zzlggXvP93uVfxJIMJ+H0s/yEGy7dugzKMzCKMd8=
X-Google-Smtp-Source: AGHT+IHIr3wVyaXMObF0gIHRTDzfj+r/v0k7L3AOz0PBBlBNpukbYjT9PBJBIvgFmfGPvox7DSPLxQ==
X-Received: by 2002:a05:620a:3184:b0:795:4e3d:2a55 with SMTP id af79cd13be357-797c2dd5e40mr960856185a.28.1718198389310;
        Wed, 12 Jun 2024 06:19:49 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955bffcb4esm344068285a.131.2024.06.12.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:19:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNtC-008rr0-Eu;
	Wed, 12 Jun 2024 10:19:46 -0300
Date: Wed, 12 Jun 2024 10:19:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612131946.GT791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 09:38:38AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, June 6, 2024 2:28 PM
> > 
> > On 6/5/24 4:28 PM, Tian, Kevin wrote:
> > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Sent: Monday, May 27, 2024 12:05 PM
> > >>
> > >> +
> > >> +/**
> > >> + * struct iommu_hwpt_page_response - IOMMU page fault response
> > >> + * @size: sizeof(struct iommu_hwpt_page_response)
> > >> + * @flags: Must be set to 0
> > >> + * @dev_id: device ID of target device for the response
> > >> + * @pasid: Process Address Space ID
> > >> + * @grpid: Page Request Group Index
> > >> + * @code: One of response code in enum
> > iommufd_page_response_code.
> > >> + * @cookie: The kernel-managed cookie reported in the fault message.
> > >> + */
> > >> +struct iommu_hwpt_page_response {
> > >> +	__u32 size;
> > >> +	__u32 flags;
> > >> +	__u32 dev_id;
> > >> +	__u32 pasid;
> > >> +	__u32 grpid;
> > >> +	__u32 code;
> > >> +	__u32 cookie;
> > >> +	__u32 reserved;
> > >> +};
> > >
> > > with the response queue per fault object we don't need all fields here,
> > > e.g. dev_id, pasid, etc. Cookie is sufficient.

Wait, why did we make it per object? The fault FD is supposed to be
sharable across HWPTs.

> > I prefer not to mess the definition of user API data and the kernel
> > driver implementation. The kernel driver may change in the future, but
> > the user API will remain stable for a long time.
> 
> sure it remains stable for reasonable reason. Here we defined some
> fields but they are even not used and checked in the kernel. IMHO it
> suggests redundant definition. If there is value to keep them, do we
> need to at least verify them same as the completion record?

They are not here for the kernel, they are here for userspace.

A single HWPT and a single fault queue can be attached to multiple
devices we need to return the dev_id so that userspace can know which
device initiated the PRI. Same with PASID.

The only way we could remove them is if we are sure that no vIOMMU
requires RID or PASID in the virtual fault queue PRI fault message.. I
don't think that is true?

Cookie is not a replacement, cookie is an opaque value for the kernel
to use to match a response to a request.

Jason
