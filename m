Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA63161BE;
	Tue,  2 Jun 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433986; cv=none; b=n1CwITfcxrSBm+6f6xKNkmqxeYQid53UuQBAkws/AHeiQxgUXNiuVy7iGcbTtsvuYlQ33TeQN+4/Aii42Fq51adDnSfO9HsbRG3IGFRPiPJgk6NVCstvelNXR8VOIOIIjHUl3GwF511hIXHXh89++Hty9e6UTBjdulwYrOcfBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433986; c=relaxed/simple;
	bh=V0PO53v0YYqAtrGqdNIX8doNhLVUZnuyu7IymeQsiIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRxf4cF6UO/uz0dPsg0sXFWT16skQj+XkiJvvIiy5L44pqSBAYUDa/x+b2uaOBiMP9W1NrZXjgxpFrNrRrkdef/tlHfNmYpeDm3OFp1aS44+5S6eOSprQ6LRfw42WFng85cIcJ2SXA50Z7IEActNxPWHv0VWH0e6wjDrCoqYtvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acgcWDch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acgcWDch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD1F1F00898;
	Tue,  2 Jun 2026 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780433984;
	bh=skOs4tsc6sXpiuWDaL8QUnUwJQBbvqvvO4BpIjWXX0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=acgcWDchyxTz4KJwz+pLvRVBcM9FKZeKwGBsxUztZ0IrE6QEiXDoqCmpsx2ctNZz/
	 JuZ8c3+MifLDO2GrZUhF37qIXBWlPIeSXhrFDu8S/HRAc+UG9Z9+IBmlzt6luopuHD
	 5nFQuEaeyKdhPOqXVec3Yyyc7N3iz17T5hQSipK1cD2d/aid0Fz50W/LxVwNPVGixl
	 zNNuSe9QrlIUyfmjEFo89fjNn3nRAGpYumAsEnbkaw4U7J8rUreARt+gs/PTNVVj5h
	 ALZdvDYw2arTQOSj2EwHhlA8ElAkCjDy+OPbuouJbERvnyZ6276/hP8XxIHQU6IKqp
	 kNl/UIotlbZjw==
Date: Tue, 2 Jun 2026 21:59:39 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
Message-ID: <ah9EO-djR3Tf9ohf@willie-the-truck>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-3-amhetre@nvidia.com>
 <ah85c4u011WNJQgE@willie-the-truck>
 <ah89vg26255v4lqF@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah89vg26255v4lqF@Asurada-Nvidia>

On Tue, Jun 02, 2026 at 01:31:58PM -0700, Nicolin Chen wrote:
> On Tue, Jun 02, 2026 at 09:13:39PM +0100, Will Deacon wrote:
> > On Mon, Jun 01, 2026 at 10:48:44AM +0000, Ashish Mhetre wrote:
> > > Tegra264 SMMU is affected by erratum where a TLB entry can survive an
> > > invalidation that races with concurrent traffic targeting the same
> > > entry. The hardware-recommended software workaround is to issue every
> > > CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue
> > > is guaranteed to evict the entry. ATC_INV is not affected and must not
> > > be doubled.
> > > 
> > > The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
> > > cannot be detected from hardware ID. Tegra264 boots from device tree
> > > only and has no ACPI/IORT support, so detection is through device
> > > tree only.
> > 
> > That seems odd to me -- whether the hardware has the erratum is
> > completely unrelated to whether it probes using DT or ACPI, so I find it
> > really weird to have the workaround enabled when booting with DT and not
> > when booting with ACPI. We should have consistent behaviour between the
> > two.
> 
> That's a good point. Yet, for ACPI to detect the erratum, we would
> need a new IORT model or flag, right? That would need to go through
> the entire ACPI protocol to update SMMU's IORT spec and the header
> accordingly, which we don't have a use case to do so or to test it.
> 
> What would you like us to do here for the consistency?

Gah, I now realise I've mixed up Tegra264 and Tegra241 because
tegra_cmdqv_dt_probe() is only called if the compatible string matches
"nvidia,tegra264-smmu" yet all the cmdqv stuff talks only about
Tegra241. So I was surprised that the ACPI probing code for Tegra241
wasn't enabling the workaround.

But if you're saying that:

1. Tegra264 never uses ACPI
2. Tegra241 doesn't have the invalidation erratum

Then I'm less worried (even though it's a shame that we can't detect
the erratum from the hardware itself).

Will
