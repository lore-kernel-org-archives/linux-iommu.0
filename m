Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0160F9D4
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807867; cv=none; b=Olrv6V2vl5YV7kvAKOi3yWhxk/1FzxPNQyIj7966gOKtmiOalAuGwie7VkdQFb/6W1tGj7LRqaimCMPVzsm5kq38TJp25R7Z1OA1V94dwqBQ87B6+opIAbEpKHDy4MUcCuxa2qZ0qpHkHRWvTEVXMPV2ETGQyfhSu9KYe5H244k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807867; c=relaxed/simple;
	bh=ZTmS+6pciRWg87tmgTzyQHASaF/mUEBOIG23LnnAXHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3Xi91yeo6ejpWTt1aoUaQmzP1J03wju/ajs0M/KnwBeDK6iTFNNmFzEF7W34AlGJ3rHwc6gNUo/4Svjh8KkfKJ44BBlBMtMqbDCIsTdvETLkWs3yVH3S5pS0vJIgggvWRMKnSVeoP7Coiu8Ep8LTTPO47cBNJ33FEbFwoX0+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DY0P4wHW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DY0P4wHW"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4435f782553so22263971cf.3
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807865; x=1719412665; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxs6Ot1v7OOmYh1fi+h7d0RjfC3rXsdWHEMpoOwqcEg=;
        b=DY0P4wHWNReBvtKk4Zf82Ha6r5j+X/2nrWwjQZ7s0A7BD/loUhZV32uzEom215Cfsn
         yLPZEx2apZ1XTxNS2euJOUxwtY/PrOu6PPUZo5iWwVNrx9+r9kJpewppDektvE4fu7qu
         qm5EwnSiDWbBa0U6JYMWWaZTaxDoNtndPq+wmSXWsGEjsMUTLc7Phj2DXa4rYoxOi5jb
         b4NoBYX7RCbiLgOYMJZEvLkiZP7ivctYSHMhJV04FNswyiKJpzYoHAv6PcUk6oZdQ9rS
         Z+K0NoTPsfDr9KbWSAVKm9/FevgXRK4DsiJS7ir8GGxUtIS5xqie8YT/g8SbH9mBTvlt
         IOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807865; x=1719412665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxs6Ot1v7OOmYh1fi+h7d0RjfC3rXsdWHEMpoOwqcEg=;
        b=QJiuzAusbcBQcI53tDP+0fkftX32u88Vv/xBtXr/G998t6l1wV605dgSLgeYgIpsJX
         aYOy65JyTJe2DUXdw2/cngKDlH6i72onGHmza3oygQ/eA4jXglGQPAHnk+SHs+eQsHUs
         tb75Uqzc6n9q1KqAnDnj8xfdMeYPyzQN6LGl51jqqg6tq7bi2dvM0JAPDGXUxnIqgokQ
         kCUfb0576mnSdDJcvTusO7jZO4Kn0UcIVL8uBrSVdG4fsqntIQy/P4jKncn/j2YAN7zU
         q1aRC+DzoTeWwk3E6xRZL8Ee19ZO/bmSqwt0nuSCY49GRB0NHwt9R+n5rf8rLHAdlDie
         krig==
X-Forwarded-Encrypted: i=1; AJvYcCWdPj8RkRTvitFbbzlHMDPOIC3KqsuC9ndhtFrxomvvp5L1YLi6MV3rJ9mKBMB4zFs2LdoY8ALVdl9YXnNUmznGfB4LXJM=
X-Gm-Message-State: AOJu0YycMygbN7Y4uiSrw2HikIq5GtGtX2TP3aFiKLlhCuDL0SgY9D18
	bO3hwoBtjgc2DF8ophx9/Nbjkaiy73Rhoo+xfIOoWYVK7t7gF4fEkL2TNxwjS9w=
X-Google-Smtp-Source: AGHT+IE1Mf08qWZZKoMXC3XLTPx+dWna8s01o0jSerjkNHzkfpY1WyFHeXhpxUdgnTBTf9fhG5DGtQ==
X-Received: by 2002:a05:622a:1985:b0:441:57b3:2d76 with SMTP id d75a77b69052e-444a79c1e37mr30313091cf.23.1718807864728;
        Wed, 19 Jun 2024 07:37:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc297sm65510081cf.63.2024.06.19.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:37:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwRT-004dJu-Li;
	Wed, 19 Jun 2024 11:37:43 -0300
Date: Wed, 19 Jun 2024 11:37:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] iommu: Refactoring domain allocation interface
Message-ID: <20240619143743.GJ791043@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:34PM +0800, Lu Baolu wrote:
> Lu Baolu (20):
>   iommu: Add iommu_paging_domain_alloc() interface
>   iommufd: Use iommu_paging_domain_alloc()
>   vfio/type1: Use iommu_paging_domain_alloc()
>   drm/msm: Use iommu_paging_domain_alloc()
>   wifi: ath10k: Use iommu_paging_domain_alloc()
>   wifi: ath11k: Use iommu_paging_domain_alloc()
>   RDMA/usnic: Use iommu_paging_domain_alloc()

Joerg, can you pick at least the above patches for this cycle?
Hopefully more will get tags and can go as well.

If you want to try for more tags on the rest I suggest Lu can send
patches to the subsystem trees and hope the maintainers merge them. At
v6.11-rc5 we declare the remainder unmaintained and you take anything
that hasn't been merged so we can finish the iommu core work.

Thanks,
Jason
