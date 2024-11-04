Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A903214;
	Mon,  4 Nov 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709035; cv=none; b=TKWkXEE4qrYvQObm1Nwy7gO2djztvazM97CZVymnAr0tHvAEJEpw1B1m+nuiWAkY9aBEgXzvDZUw4I0S0rfpz2ie9tGutM6t5b5+DeG60A+njVZWDe/+hbzVCG5MxyoOsMGPeLF7k3ZI3tNDrvRvD0o41Jj/qDPM6dWQeXCcr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709035; c=relaxed/simple;
	bh=eXqRUGtrr2u2I5863H2MZn/pO3+hewmyqncVcvXNheY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exiAkkqhzQ1/vd4ZTNEp/JkZ7egup0wo249AlB2rsU46hxsi95s6fHPVXw8PAmFjul2OHVd8lDx+/6zQx1ztbF3QiMFN6JwrM9yeBRIQERW7ae6LiZf4gJ4N2XKXtoqm8/eaNkOw1Zb824pK3G7l5eWzU2EotfkYuh6fzdEWex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQAgvipi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQAgvipi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6231FC4CECE;
	Mon,  4 Nov 2024 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730709034;
	bh=eXqRUGtrr2u2I5863H2MZn/pO3+hewmyqncVcvXNheY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQAgvipizo2Gattng9GJqRBJOn2+Dyq7/rxpJramkhcWG3qBYkavT7OHiUeNSV2PG
	 j+HKoUy7WgbDak1/6sWlhdQJMRlaFsHZsCRez09I2jyRFmPRi2Qn6Ve2maHtGm61gs
	 vtxBWNbSfv2FKqJT1/cNJ0hVCYf+FRYpagwXE4v4sriawgvEsJbWYvrLaJ2EsivV9q
	 qaBcBR9XYWlcDOUgj1IEFOkEiEyLm940Z7+ljiv/jhzfHpTm1oiNmNqHWohCi+cE4a
	 v1hvFhmjFmNjBG8yOa3NrHhEYINbCRINZTVxjDYPy7/2zJGGkk4X1gtBOXYUeRJbwx
	 ZF1h3c+fzFqCw==
Date: Mon, 4 Nov 2024 09:30:17 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 1/1] iommu/vt-d: Drain PRQs when domain removed
 from RID
Message-ID: <emkjq4n4mzqegosmidht25qsveuoqxx6bg3r6npikwovomk5gw@ofbvlyrqkxqh>
References: <20241101045543.70086-1-baolu.lu@linux.intel.com>
 <76d4ab22-c3b9-47d8-9bb8-0430be05fee0@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d4ab22-c3b9-47d8-9bb8-0430be05fee0@linux.intel.com>

On Sat, Nov 02, 2024 at 11:16:31AM +0800, Baolu Lu wrote:
> On 2024/11/1 12:55, Lu Baolu wrote:
> > As this iommu driver now supports page faults for requests without
> > PASID, page requests should be drained when a domain is removed from
> > the RID2PASID entry.
> > 
> > This results in the intel_iommu_drain_pasid_prq() call being moved to
> > intel_pasid_tear_down_entry(). This indicates that when a translation
> > is removed from any PASID entry and the PRI has been enabled on the
> > device, page requests are drained in the domain detachment path.
> > 
> > The intel_iommu_drain_pasid_prq() helper has been modified to support
> > sending device TLB invalidation requests for both PASID and non-PASID
> > cases.
> > 
> > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c |  1 -
> >   drivers/iommu/intel/pasid.c |  1 +
> >   drivers/iommu/intel/prq.c   | 26 +++++++++-----------------
> >   3 files changed, 10 insertions(+), 18 deletions(-)
> 
> Queued for v6.13.
Does this mean that "iommu: Enable user space IOPFs in non-PASID and
non-svm cases" is also queued for 6.13?

Best

> 
> --
> baolu

-- 

Joel Granados
