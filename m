Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7CA1C6F47;
	Mon,  7 Oct 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297798; cv=none; b=B058KEPMAoTC0NKsk+pEOzrvs7kGoAfJt5vnNp434Cu56v+6r1PoCKAoGWLHHPaoB07YTJ1L0ypkVr3tbCTqEo1Q8Hv9QCpNvdAVkHr4rrdSMJ9Oym7pTOGnOIJ6u5559j1KldpAfkk8OQvlAqqxtbJfLCRneqXCteS5BiEl4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297798; c=relaxed/simple;
	bh=E2yj5HQS5sRTpPyRQQ9fSQQRE2CU7FuRE6H+lHbWjEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP2fTonaWLquME0/eXeJ2qhKRSnW8ftBIdtt34Ir5uygpQWNjLV8UbT2bBx3tv1+/93UUMtbb4u3QCCz7uhcotm/Ju9JJLd95zlxdHC/2FHr3+jnUkUEYZdSsY/j8TJM2cA9tPcqGqXF3E7vBPIDHiL9VZKhnPx5IcIpAqNkuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6Cna1AT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6Cna1AT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2309FC4CEC6;
	Mon,  7 Oct 2024 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728297797;
	bh=E2yj5HQS5sRTpPyRQQ9fSQQRE2CU7FuRE6H+lHbWjEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6Cna1ATkkLOb8xLvWAvSXuwwBZIoIt6zaTFThiCTneR5oRyE5txLdVpzl+gVz9Sa
	 0Cdh9NLrHVIN9HqOaYqzi08gaU/ag4cDJhTik4xbEGbnvxlWHey5XZOPyX4ahKoYyK
	 1UOXtz74Jk/LQ65FebiD+CT2QIUGjDGEmlEIf9giSjxE79sOr1Nl7LpeKcUyDrSf7x
	 05OXnd7QOz9R7n/KQnac0l1ZJzbOZUlt6uvFWqbkK/Vwty1QGD9JL3bqPH7CuEhvAg
	 NvYI9crYVUNHf1oL7u96RDuhLU5VBbaw6VRWZo/11T0gqSeIF6torX4jaIbG0MIaNB
	 tW+D6JCq1PNKA==
Date: Mon, 7 Oct 2024 12:42:53 +0200
From: Joel Granados <joel.granados@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Message-ID: <20241007104253.u6zuiplkdwsln4cn@joelS2.panther.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <CGME20240914004847eucas1p23af12d7ea9f70f0de6a9a900072bdad8@eucas1p2.samsung.com>
 <BL1PR11MB5271994848066586A098327F8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20240916085054.gpan37ds7ea45pgh@joelS2.panther.com>
 <BN9PR11MB52761B4848ACE15A7A2384458C6C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761B4848ACE15A7A2384458C6C2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Sep 20, 2024 at 06:57:04AM +0000, Tian, Kevin wrote:
> > From: Joel Granados <j.granados@samsung.com>
> > Sent: Monday, September 16, 2024 4:51 PM
> > 
> > On Sat, Sep 14, 2024 at 12:48:31AM +0000, Tian, Kevin wrote:
> > > > From: Joel Granados via B4 Relay
> > > > <devnull+j.granados.samsung.com@kernel.org>
> > > >
> > > > This series makes use of iommufd_hwpt_replace_device to execute
> > > > non-pasid/non-svm user space IOPFs. Our main motivation is to enable
> > > > user-space driver driven device verification without SVM/PASID.
> > >
> > > can you elaborate why IOPFs are necessary to help verify such usage?
> > 
> > In retrospect "enable" might not be the best word to use here. We are not
> > "enabling" user-space driver driven device verification as it is already
> > enabled; you could already poke a device from user space. But the whole
> > poke
> > space was not available, you could not test IOPF without having an
> > SVM/PASID
> > capable IOMMU. Therefore a better wording would be "Our main motivation
> > is to
> > expand or facilitate user-space driver driven device verification by enabling
> > IOPF without SMV/PASID".
> > 
> 
> hmm did you actually see a IOMMU which supports IOPF only but
> not SVM/PASID? 
> 
> this series alone has its merit, e.g. postcopy migration might want
> such notification. But not sure it helps solve a real problem in your side...

I understand that you want more information about what problem(s) are
solved by this patch set from my point of view. right?

One of the main motivations is to enable IOPF in use cases where PASID
is *not* an option, like NVMe devices. Therefore one of the examples for
enabling user-space driver driver device verification are NVMe without
PASID.

Quick Note: I am adding my new email to the thread so I get the
responses routed to the correct inbox.


-- 

Joel Granados
