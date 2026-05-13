Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A08B38B7D2
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710820; cv=none; b=Gvn5ogaRCdO9zcql28eaOoF52oKWQmRtw6IIsEHgDYqxmYmI2jo+2yqjd3D4G7dbLWoMgwBaP6udH9sVdAMx9fOApzw0TQcNx8NEg7Ko/BdYoQJPwJ8AX+FzP4HEy8TqgI0nSwRyBpPOA8IlN8UZ/i+QSI04vXQ1zRypd/VLT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710820; c=relaxed/simple;
	bh=mfSIxDq77IzJE0lxlOwsl1y81tRMYVueDOdWREX/VDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXVyl5XYmCEopy4jN88Zvn31zomX5N73orTorgxjp7zHiKQKvfxwy/paEueYmLhjdE5KwTZ3pgR7CeSvMY7c7I0zJbJsqon5DW03YCYVXsyGovU7oDWQbV8l6DEtuOe+pYQAjLy0G5LbPMgSDfMMPNRjBeL8YMBScqi3GH6vZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KUKSBAUI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KUKSBAUI"
Received: from localhost (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8705B20B7166;
	Wed, 13 May 2026 15:20:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8705B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778710812;
	bh=WFgmxV2UBflbtP0IF9a+JSCUxg5R4WcX9TJbtC/5hbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KUKSBAUID9Jr2Po4pAqljlOC6n1ZIDqQFSAVFjLilbkrXc8Cx6+7NyeOZWrC0bi0O
	 OYyvuQIutwQgS0jSTgW/fiIWXFuYHjhndQXtEQibbZ1ceSjENd8B1eYmDCR7oVp4w4
	 7BEycfCfrfIRqaAn8WNxC4TnWM/tnV6RuVGdQLW0=
Date: Wed, 13 May 2026 15:20:14 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Message-ID: <20260513152014.00006a3f@linux.microsoft.com>
In-Reply-To: <20260513122221.GG7655@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
	<a8db8d35-e7de-4e74-886b-d978e1ecff06@linux.intel.com>
	<20260513122221.GG7655@nvidia.com>
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

On Wed, 13 May 2026 09:22:21 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 13, 2026 at 03:53:43PM +0800, Baolu Lu wrote:
> > >   #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
> > > +/**
> > > + * struct iommu_ioas_noiommu_get_pa -
> > > ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
> > > + * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
> > > + * @flags: Reserved, must be 0 for now
> > > + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> > > + * @__reserved: Must be 0
> > > + * @iova: IOVA to query
> > > + * @out_length: Number of bytes contiguous physical address
> > > starting from phys  
> > 
> > Nit: Instead of making this behavior mandatory, would it be
> > valuable to allocate a bit in @flags to toggle this behavior? For
> > extremely large mappings (e.g., several GBs of contiguous
> > hugepages), the loop to determine the contiguous physical addresses
> > might take a long time. A very long scan could theoretically delay
> > userspace DMA setup.  
> 
> If we are worrying about that then a iova/length pair would be
> appropriate such that out_len doesn't exceed the length. Right now it
> stops at the area boundary IIRC.
> 

 Yes, it stops at area boundary. How about renaming out_length to
 length, then use it as both input (cap on the scan range) and output
 (actual contiguous bytes found)? When length == 0 on input, it could
 mean "no limit" to keep the current behavior as default.
