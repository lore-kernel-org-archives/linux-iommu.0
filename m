Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9561D1302;
	Mon,  7 Oct 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297978; cv=none; b=PbPJ4iT/UIL17R3q6+1WuZyd8jniUIamf/lmagSe0WRg5WJcwRrDplTBuBzIQvuwXN+OAemjFONrynbOa+hWywyDUw+8gBtOBdP/NOJ1WC+geJKG+cLCFX0AAa/XqX8ERMA92eLsbWrXQEbIcG4K0lM4iU8eDALBpBafvCVkOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297978; c=relaxed/simple;
	bh=0LNtMm+7NAynt0K/OYa8Woy9tD2HQZbDYY7j1/mIYfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yym+hrFa/+cVCJ3IsfwFdJM3rNcJfQYJjjA3fWY+3P4xMm69ieovHAKmA0R30AUKk64va40Oct4p8yodh/+PBuK/p3caZgKUzllQBl71oH5LI6srgIL8iwim/jnaj/x7lqXdyEZ2LEqlkCTS4DqwNv1UiD6G/luN45j5BTF8CIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHcVNWXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHcVNWXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E73C4CEC6;
	Mon,  7 Oct 2024 10:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728297977;
	bh=0LNtMm+7NAynt0K/OYa8Woy9tD2HQZbDYY7j1/mIYfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHcVNWXqGMQl36jvAwb7JQz0zh934jJHpIiGhdM35JsrpRijtgu3DsvuKYDQNUm8x
	 6cfKgau1WjZxNDCQFAd5kFt06rUwNV7zc/IaYz0TakqkkyfDXaMMi/z+PqTbaie4FJ
	 dnhZ3mszYbrIeY9OjY1KEZmaxjV5q/kyKSkx2uH9qU+pEJAe9Sdog8AFpQFUQMlnZ9
	 G9a0HrAtx6ijEc8J65M9Uh8+IapMHcVtmyLJ6mbTRYHKKml2JauYZWm9ijYkEE9LHB
	 CeoisXkRnaJEhjgS+gzWTAkBOHD8KFdOWPAcf1nFsIAxmdGLIbRPEGJG2HKcOIE/Av
	 mI3h5cD+Eojfw==
Date: Mon, 7 Oct 2024 12:46:11 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Message-ID: <20241007104611.bipxx4vao4n3hg3m@joelS2.panther.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
 <BN9PR11MB52769D1D1FEA9BAF0E6D19718C622@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c54a15d8-fe60-480c-9156-bd77114c196c@linux.intel.com>
 <Zu1wim6MZz3rkbWY@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu1wim6MZz3rkbWY@ziepe.ca>

On Fri, Sep 20, 2024 at 09:54:34AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 18, 2024 at 07:17:32PM +0800, Baolu Lu wrote:
> > > more than that... for each IOMMU the current code allocates 16 pages
> > > and 1 hwirq. Those are unnecessary burdens in majority deployments
> > > which don't support/require I/O page faults.
> > 
> > Yeah! I only focused on the kernel binary size but ignored these system
> > resources consumed by IOPF. Then, perhaps
> 
> If you care about runtime overhead it should be delt with by
> dynamically allocating the memory and enabling it, not via kconfig
> 
> We can dynmaically add IRQS in some cases now for instance
> 
> Jason

Summary (Please correct if inaccurate):
1. Kevin Tian & Baolu Lu have proposed a kconfig guard
   (INTEL_IOMMU_IOPF) to avoid unnecessary resource allocation (of 16
   pages and 1 hwirq). It can be keep it until it becomes a burden.
2. Jason Gunthorp: runtime overhead should be handled by dynamically
   allocating memory and enabling it. Not via Kconfig.

There was no real consensus reached here. I'll leave IOMMU_IOPF guarded
under INTEL_IOMMU (no changes from V2), two reasons for this IMO:
1. The reasoning being that any system that has the resources for
   INTEL_IOMMU has them for IOMMU_IOPF.
2. If the IOPF resources are a burden, they should be solved by changing
   the way we allocate memory instead of hiding them behind a kconfig.

Quick Note: I am adding my new email to the thread so I get the responses
routed to the correct inbox.

Best

-- 

Joel Granados
