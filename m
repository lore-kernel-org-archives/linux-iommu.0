Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240D2259C
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865439; cv=none; b=j2ndwgGmLCNn1kWPxkD+dKdI4E7axCOHQ4UFq78+7cp5deSPAbIaPgc/WYIqDwmt7jnYBZ7ZK0FDruI+fcddDtGKA2ZDZFRbrLzrAf0GxrusjlGN0lJ7M4411YHND2OroELQ2+0kDkKhanakx48tyTi7Q0megLsuBFDVtL+ZwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865439; c=relaxed/simple;
	bh=eYA6a16+74wOAPB9WNQ6BT8QceJRLR/EhWYKReIP/mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOY6dwCUjOfsR2jMs7EAc2+aj+YhjIIy/2JqVoihajSUv1CRFnSKSF09Jl/DYLTdjdSVgx8lsF32z5RGTWyZTtndc8aWi6r4JgYGvg6/PhZwWQskLVd/5QWAGRsJluuPemcDcaT+6T0EojW3hJ81JWG+eZ07m7HIU4TUwjPaWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC5DD1F02;
	Thu, 13 Mar 2025 04:30:47 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7436E3F673;
	Thu, 13 Mar 2025 04:30:33 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:30:30 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
	james.morse@arm.com, broonie@kernel.org, anshuman.khandual@arm.com,
	oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
	david@redhat.com, jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 0/3] Initial BBML2 support for contpte_convert()
Message-ID: <20250313113030.GA24356@mazurka.cambridge.arm.com>
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <e8749c86-fe93-4123-aa2e-5677e7a2c695@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8749c86-fe93-4123-aa2e-5677e7a2c695@arm.com>

On Thu, Mar 13, 2025 at 11:22:07AM +0000, Suzuki K Poulose wrote:
> Hi Miko,
> 
> On 13/03/2025 10:41, Mikołaj Lenczewski wrote:
> > Hi All,
> >  
> Nothing about the patch functionality, but :
> 
> Minor nit: Generally it is a good idea to add "What changed" from the
> previous posting.  That gives the reviewers an idea of what to look for
> in the new version. Something like:
> 
> Changes since V2:
>   {Adding a link to the posting is an added bonus, as we can look up the 
> discussions easily}
>   - blah blah
>   - ..
> 
> 
> Cheers
> Suzuki

Ah, yes. My apologies. Will make sure to include such a changelog with
links to previous versions in future. I do not know why I did not
include it here, other than it not crossing my mind...

-- 
Kind regards,
Mikołaj Lenczewski
