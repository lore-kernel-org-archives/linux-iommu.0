Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53E13E63B3
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505806; cv=none; b=TKht9glYwRgS3wA7QbDdva38t/FcSiVWxFBqxCs7aWBQe6MCR4UjUyNxm5aUvCKa5r27ZX/WYKwB4GtJa1Ah+YBHvadVr3dZIn4MgB1wfOytFtEhzWx8Qo/VDcVHqZPMpU83Dvve9LZ7NDozrjSthGpsC3GQSThlOLET8MxuVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505806; c=relaxed/simple;
	bh=yq0R9mWwUnURtR4jKzq2Jb0O53C+sfBYwr6ayXzvFHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnnY0w+h+ExbyJGWKzpXGP+/N8qiMW8mLrlKdASuwHsYfKjkYzdqkq5xZPmCtX3dg8iXWWDlsyLyoF6cFArdi+rWpFzW8NoKZOBGDEuiVmqqtgAvfZ/uVyBoAyzp8TLEzQAO/grfV+eInRp1ddRiDCnmf2yo7FZvNGEsU/lu610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZtR3DHs6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZtR3DHs6"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B7A120B7168;
	Wed,  3 Jun 2026 09:56:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B7A120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780505791;
	bh=uahL+c7sjaA0KCYxsyoStyzUzQ0Zy96lQIlijGsueks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZtR3DHs6o+CC9SsNsxJCQ/zNOdM5Zl+cCR+ohpCGzsa0iM3xEIQf1CcnqBOw7oo2n
	 o1RtVS38NJ/EnVEiv7+fEFK1r5pauRGBzChkMmPzpSxePcSEeJIbcjmerU33cCZQP0
	 u4mBCiToYBtyyBRDpWiln3HOllzfPHU6slgUI0jI=
Date: Wed, 3 Jun 2026 09:56:43 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v7 3/6] iommufd: Allow binding to a noiommu device
Message-ID: <20260603095643.000066bb@linux.microsoft.com>
In-Reply-To: <DM6PR11MB36907B861662CC3A3FEED2B48C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
	<20260603054438.2450130-4-jacob.pan@linux.microsoft.com>
	<DM6PR11MB36907B861662CC3A3FEED2B48C132@DM6PR11MB3690.namprd11.prod.outlook.com>
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

Hi Kevin,

On Wed, 3 Jun 2026 06:32:59 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, June 3, 2026 1:45 PM
> > 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Allow iommufd to bind devices without an IOMMU (noiommu mode) by
> > creating
> > a dummy IOMMU group for such devices and skipping hwpt operations.  
> 
> s/IOMMU group/igroup/
> 
will do.
> > 
> > This enables noiommu devices to operate through the same iommufd
> > API as IOMMU-
> > capable devices.
> > 
> > Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>  
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

