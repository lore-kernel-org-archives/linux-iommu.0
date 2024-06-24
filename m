Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102B19EEDA
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251921; cv=none; b=L9B/3VnWAMDwc+kWBhnfHCM/J7lbvyjqYCcQH3f+xTrbD2If7vFIBvJyemGrHP3z+o2zc57VletiimQYvGZPq5AVm3X2pwTncos6K7o6bQYFPL9PxxE6IdJ6RGkv5e1Rbm9NJREIdjowf34oyfjFIHdYg2nBwXsicCUMk4CVl9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251921; c=relaxed/simple;
	bh=Dpx9cTY28z1ZjtSEiWQYIrx5N0+6lgWc6PYdLwGkE1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyLAnBA66mpLsJUe0Qm+G/hAKCGQoD2qBOZ4EhmqWQE2QQBjjmSN/8Q9gkzB8pe+dAibXKIeoWbhMrJmvbe2tcfPbUBz5ehNNufU55XwGRYEk4dw9jaSf4kIOE3oSlZglEWA1mRXpAgs6HocYOyKR5I4pGB9Ar3+L5t5FFR0TxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dowRggHm; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dowRggHm"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4ef748596d7so460330e0c.0
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719251918; x=1719856718; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YNU8knWMPYNyTHBdJSdgkQoEg3G3ja7Wms4FhBvjjDA=;
        b=dowRggHm73qCWUmT4sNFcMbH5AUhjhDcGjmSACHtWBzqDmcNAC8VmPxD4sBz9ZIJWv
         1VxY4jS5DaaqjpfhX9R6156T6GrfniF5KYrWGD4ZxaVWOQTw/2b27D8aULqQY3UOOV2D
         64WqZ7LN60smoSteWL3Vu2JHLf8Ku2tqWD1BZQ2oiCyv8DdDpxVv+I6TxUvVdS+K0Tvv
         iNevEe7YduaOYNq5EeQXpgUgDgl7sdo7n+OF4fRDgsZ8w/bLz6NEMAJiom4kjVbXc6fd
         s56m+lU7pPSnLlpWK6MomgHGYzMvVuP6+NAK8MwpPM4yniNypPBBpN64YDSg8QNYtFDi
         2oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251918; x=1719856718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNU8knWMPYNyTHBdJSdgkQoEg3G3ja7Wms4FhBvjjDA=;
        b=PWT1hDFUvIsmRCF9gTpiRbK9WP0fFz9Am+L5LaiqBg0qgyS6mpM1TNgj2X6fai9fDH
         cfkBo64SikkLuDPBh4kY+HxzvxgyqVUiJUsmUaQolCZXDCWlHiGPoqdyb31Ipv6BRgMS
         2xT3sbhSMMCsQBxxsnosaZV6KF76CjxIeQL8SL/of9DVSwM8hlGbvmRCwhW9DZzxaxrl
         HrctcG5ThHb6gPW77+GcUS6OHz5hIt+gmJovkO1YI0gpCDibEJEpNCL8vkNtMIOXZgtE
         l+nLoK/NfY/7oxl0HS3d+kWhMMtyLwHQApWCQ9Gf3cG79fN5Pvr1MeGXrouq6kSh5i+F
         Spwg==
X-Forwarded-Encrypted: i=1; AJvYcCUyVWRbCRyzRE2lTmTrmbf0ZlAPysIGhDqEZpWt+8j09dqxp0mE1T/4GoCnZ9cPXUR/Y+xN0TrlqjKQB/ghp1T9DDTBuf4=
X-Gm-Message-State: AOJu0YxFhvQ1pzyWrDWxFnFOh/pZFlcTJxhvveLdp1CzkMHQbLWV8uL1
	czAtHZhlrp+m27RV+1U/zj3xuaaVe3q8MNPS0+x6bDTLUv9Nepu7zrAgCVcDX2Q=
X-Google-Smtp-Source: AGHT+IHnxjwk5Cm5dZlOx9nn6fHrrP01/ltJJzH9RVjyIzHnxznz3vpGsR7mP8tFLfdcH8bmSz9Pjw==
X-Received: by 2002:a05:6122:98a:b0:4ed:36f:9b38 with SMTP id 71dfb90a1353d-4ef6d82bd90mr4091612e0c.9.1719251918209;
        Mon, 24 Jun 2024 10:58:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52b16e9basm27595606d6.6.2024.06.24.10.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:58:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sLnxd-006Xh6-9b;
	Mon, 24 Jun 2024 14:58:37 -0300
Date: Mon, 24 Jun 2024 14:58:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Teddy Astie <teddy.astie@vates.tech>,
	Robin Murphy <robin.murphy@arm.com>, xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [RFC PATCH v2] iommu/xen: Add Xen PV-IOMMU driver
Message-ID: <20240624175837.GU791043@ziepe.ca>
References: <24d7ec005e77e4e0127995ba6f4ad16f33737fa5.1718981216.git.teddy.astie@vates.tech>
 <da3ec316-b001-4711-b323-70af3e6bb014@arm.com>
 <a04e169d-b38a-43dc-b783-a8af1e1b0468@vates.tech>
 <20240624163254.GT791043@ziepe.ca>
 <900edf8a-885c-4bf3-84bd-5e7b165a1ed7@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <900edf8a-885c-4bf3-84bd-5e7b165a1ed7@linux.microsoft.com>

On Mon, Jun 24, 2024 at 10:36:13AM -0700, Easwar Hariharan wrote:
> Hi Jason,
> 
> On 6/24/2024 9:32 AM, Jason Gunthorpe wrote:
> > On Mon, Jun 24, 2024 at 02:36:45PM +0000, Teddy Astie wrote:
> >>>> +bool xen_iommu_capable(struct device *dev, enum iommu_cap cap)
> >>>> +{
> >>>> +    switch (cap) {
> >>>> +    case IOMMU_CAP_CACHE_COHERENCY:
> >>>> +        return true;
> >>>
> >>> Will the PV-IOMMU only ever be exposed on hardware where that really is
> >>> always true?
> >>>
> >>
> >> On the hypervisor side, the PV-IOMMU interface always implicitely flush
> >> the IOMMU hardware on map/unmap operation, so at the end of the
> >> hypercall, the cache should be always coherent IMO.
> > 
> > Cache coherency is a property of the underlying IOMMU HW and reflects
> > the ability to prevent generating transactions that would bypass the
> > cache.
> > 
> > On AMD and Intel IOMMU HW this maps to a bit in their PTEs that must
> > always be set to claim this capability.
> > 
> > No ARM SMMU supports it yet.
> > 
> 
> Unrelated to this patch: Both the arm-smmu and arm-smmu-v3 drivers claim
> this capability if the device tree/IORT table have the corresponding flags.

Oh sorry, I misread this, as the ENFORCED version, so it isn't quite
right.

ENFORCED is as above

Just normal CACHE_COHERENCY requires just HW support and any
enablement in the IOMMU.

AMD and Intel are always enabled

ARM requires HW support and possibly some specific iommu programming.

> I read through DEN0049 to determine what are the knock-on effects, or
> equivalently the requirements to set those flags in the IORT, but came
> up empty. Could you help with what I'm missing to resolve the apparent
> contradiction between your statement and the code?

The flags are set if the underlying HW can do the coherency work, and
Linux has the IOMMU (STE/ioptes) set to work with that.

Map/unmap cache flushing during the hypercall is not a substitution,
Linux still needs to know if streaming DMA requires the flushes.

Jason
