Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C0C6F2F2
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418207; cv=none; b=snhc9s35mkq74f88a3EmLWGnlSm8kIFZTcd9JGRJHftxd7v4P5kBIBqd30yaKO0VqHuoF4up4Bl3U3e1V3YbqHoL2g6JHc9XhqfMCAFfe0GepBcOg0ynon6BCTFjXFm7wT1DWxeQh9ktuUamZ71EPJMLSJbKIWbLTw1PWs1JDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418207; c=relaxed/simple;
	bh=0doznwWaTBKB1Oq1Cn7pPgAAOnrOE+ul24LXxLy2K0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtMPIZrqwQFVqN5iGnJ8/ndr8C5IhwVbAMKROX/6ZPHlzvgepoHosfHaqGaOnIo1Gj1XM/Z+FaiG4YIh1HdHyOIXgkJyvTcoesADV9Ggq9H7fV59yPHhzLj9JQwA2crJwi+ouu7KMsmC8SzEpOpO7t1CpyGDdA0fE2PIrkjhu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RHijLKuC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RHijLKuC"
Received: from localhost (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id E6FF620B7168;
	Fri,  6 Feb 2026 14:50:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6FF620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770418207;
	bh=d4e76b1QrUgVe+CeuBIDfBj7PX3PWaO84rFgyvlBBNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHijLKuCMnShBxLcc9/aL8I1bNMT6VGG4Bf/LQ42CJv2kN1tOkbWnKYfmuvhwZjFl
	 Z2f7xhPtn505VM/do8B/QSDccHbZsabFbqUtuHgwCFBz4fXa9EU/fMT8FxtYV5b9QS
	 1+hvJZT57VyRosxgsHMbR3THgLg5+XW11Ge5h224=
Date: Fri, 6 Feb 2026 14:50:04 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex.williamson@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 skhawaja@google.com, pasha.tatashin@soleen.com, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, David Matlack <dmatlack@google.com>
Subject: Re: [RFC 0/8] iommufd: Enable noiommu mode for cdev
Message-ID: <20260206145004.000010e1@linux.microsoft.com>
In-Reply-To: <20260130193529.GJ2223369@nvidia.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
	<20260130193529.GJ2223369@nvidia.com>
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

On Fri, 30 Jan 2026 15:35:29 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Dec 01, 2025 at 09:30:04AM -0800, Jacob Pan wrote:
> > VFIO's unsafe_noiommu_mode has long provided a way for userspace
> > drivers to operate on platforms lacking a hardware IOMMU. Today,
> > IOMMUFD also supports No-IOMMU mode for group based devices under
> > vfio_compat mode. However, IOMMUFD's native character device (cdev)
> > does not yet implement No-IOMMU mode, which is the purpose of this
> > patch. In summary, we have:  
> 
> I tried to build this without the fake iommu driver and it worked out
> OK:
> 
> https://github.com/jgunthorpe/linux/commits/iommufd_noiommu/
> 
> Needs a little more checking than I might have done, but can you take
> that and try for a submission?
> 
Will look into it.

Thanks

Jacob

