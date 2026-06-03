Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5A37DEA3
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509067; cv=none; b=VOcoUvSVO7++1cZAm7nwyz9lscRsSU3/j5UjVU1NBuRaJuieb3MYDm4iV0AEqfGcmaplNpWvdBxc4/Gph0zBuPz3OQwL4mqRkpmOrSFXUnyLZzfb/mkQj7B99kmRgbuHlxAknV419gGvWxLfigb51LJUyYtSLskWzYqQWm75MSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509067; c=relaxed/simple;
	bh=xnNd8jNaL65qUCp7dfoJUIway2OVTMbEizx2pZD/EJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhexTt8vfMmLt1lboR1bZG4QTw4ewxKNeC6GBU3b7DVVTtOdg0XhZQ5loVkpQbEtu3blLALuzYT/Bq1f3DGMqkp3ay3qD5lnhDFvfQeIGiv2GKVvyqQaKjX4ONQ0zfl5DHB7m7qMNimo5S1Iu3zTPmJY1R10UNQyTHhbjFVCPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d/m2zhq1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d/m2zhq1"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A2E720B7168;
	Wed,  3 Jun 2026 10:50:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A2E720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780509051;
	bh=Su0/EasfABbJj/VbRuK9tdLN1l074fTMUdjGtPxO3IY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/m2zhq1WAkyzEN0KX1UGXb9ovTRHFWMDn5oHgD/Uw/zuahWM5Yv6TklFNHpxei/j
	 aBMz1ZLrENYCkLg34wRxaoigRDG0MvvEXBuD3yAHuQ8scgGD3RKoE7tqci9IHHWCt4
	 pVTVEIhXVhZWFbG433DqoDCj9sUzbqM74Z6i+cqc=
Date: Wed, 3 Jun 2026 10:51:04 -0700
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
Subject: Re: [PATCH v7 6/6] Documentation: Update VFIO NOIOMMU mode
Message-ID: <20260603105104.00001a22@linux.microsoft.com>
In-Reply-To: <DM6PR11MB3690D6F330CCEB909CEAAD6B8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
	<20260603054438.2450130-7-jacob.pan@linux.microsoft.com>
	<DM6PR11MB3690D6F330CCEB909CEAAD6B8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
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

On Wed, 3 Jun 2026 06:42:09 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, June 3, 2026 1:45 PM
> > +
> > +* IOMMUFD UAPI is available for VFIO device cdev to pin and map
> > user memory with
> > +  the ability to retrieve physical addresses for DMA command
> > submission.  
> 
> and no need of mlock.
> 
> > +
> > +A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to
> > retrieve the physical
> > +address for a given IOVA. Although there is no physical DMA
> > remapping hardware,
> > +IOMMU_IOAS_MAP_FIXED_IOVA is still used to establish IOVA-to-PA
> > mappings in the
> > +software page table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
> > +tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides
> > an example of
> > +using this ioctl in no-IOMMU mode.
> > +  
> 
> the test case doesn't exist yet.
> 
will remove for now.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

