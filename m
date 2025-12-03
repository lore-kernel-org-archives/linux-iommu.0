Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD582C029D
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801377; cv=none; b=SoTGQ318F8NWkCqw7bXXOshuvGXTZKD8ZQnLom1czjs+1vgKiBuIm734Q3bWhmKMg/0gCgIYIzrBbsQQdBplIHmfduM1IJjkA6jW37RSiAg0rD2i/YHLFYBtJz+FaFjbUrAmHrdKgtU9ZF/zbGdf0AHcCB2c6n/YM4yIo+R8H9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801377; c=relaxed/simple;
	bh=edh3wA6ckDSxf3Pj/QAb69DiL8hyut1Yf1XxTQ5Bgl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaoLqh/YM5zSB+7TNGcz5+EQ2LhdhDyrLAAvr1seN+6Cmwxbj9MjCv3ZezLFpsDOO/Bd+XyeukyfBOvL/PgVXYP/gJbtaeH5zUhFdDzOOQsaAp/q2oxNhsIbh4wcMjdNZ0VD0/2J91hCqR11pTt73NfH68NjRHUNiqz4dVkCoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dwi/f3DX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dwi/f3DX"
Received: from localhost (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id B2DC62120E87;
	Wed,  3 Dec 2025 14:36:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2DC62120E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764801371;
	bh=CpMVSlJWsDxXtnskgsUqz1WI+hAF5Xqkrru7P+P7wCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dwi/f3DXdl3uGMS9zIXjF+8WFX5Hah73MlMNBDw2V/mpMU0IXbxHDGwXM3zzm5xeR
	 pA8tviAYwBN8pyMonLFVaYvmqSuuIkLRcjYYOhSp/cSbfXc9gNadU85qx9YtDHsz59
	 tgKoknvvUnX/YKnGc4AF288hjCBh0eecl5exOIrM=
Date: Wed, 3 Dec 2025 14:36:09 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
 <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Zhang
 Yu <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, David Matlack <dmatlack@google.com>, Alex
 Williamson <alex@shazbot.org>
Subject: Re: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
Message-ID: <20251203143609.00006b72@linux.microsoft.com>
In-Reply-To: <20251203131129.GD1109247@nvidia.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
	<20251201173012.18371-3-jacob.pan@linux.microsoft.com>
	<f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
	<20251202160635.0000433e@linux.microsoft.com>
	<20251203131129.GD1109247@nvidia.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Wed, 3 Dec 2025 09:11:29 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Dec 02, 2025 at 04:06:35PM -0800, Jacob Pan wrote:
> > However, as you pointed out there seems to be no standard ordering
> > for iommu device registration across platforms. e.g. VT-d hooks up
> > with x86_init, smmuv3 does that in platform driver probe. This
> > patchset puts dummy driver under early_initcall which is after both
> > but not a guarantee for all platforms. Any suggestions?  
> 
> I think we need to do something more like the sefltest does and
> manually bind a driver to a device so this init time ordering
> shouldn't matter.
I have moved this dummy iommu driver init under iommufd_init(), which
aligns well since it runs after all physical IOMMU drivers have
registered. This dummy driver is intended for iommufd after all. But I
don't see a need to bind to a platform device as the selttest does.
