Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A70343B4B5
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700837; cv=none; b=Zuis9iMQ9xjB2muKZLravDOHkjuIvlJUzZGwcJJhtic4vvvlNAH/zOrNaCBu3K2KfVCEI9+bBRhuOnl1w5y5laYn9/N3F5KPi03dfTSbLaaYGvXu00arSJ5VZQpi4+7XTryzx/2gbgiKm53dUE3EEImr3z5iTruyIG4K+gtQu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700837; c=relaxed/simple;
	bh=ohMFuGDrC0q6qZmQDa8qC3DkIh99TSxE1yS1foR4w+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhpcqUBVzuRdyIknwjZlGuHp8si4NvOZgfVnb1TYgYKqa5aUILgASXb+DPZXD5iWaaKJF/lpt8i7YzNVaRF4YwiWJjRBalU7bX0HjVPY/Wu3PuOd0r6nTMD0yJzz0hjV+6nXILcIJkQPrlqC+5OXNjoi8eZfbFN0waXZTtln7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=soiIDer0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="soiIDer0"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0F6320B7168;
	Fri, 14 Aug 2026 02:46:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0F6320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786700810;
	bh=o7COE43yJKOw6XcS/XjTTE1Doxp2qILSNhwHlZkNPNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soiIDer0HeSdjWChm+aXA+cp0itsuWmLE8vXZMKtdyPv/F4jg3GCR/00WesVF2bvj
	 M8TlQAN1DgpSLLOGVqxw8q21t2d4zgGhfSNXF4wJMZyMNrmSXjWJ1XZqp7AfX6BLYY
	 f/uehGLM2IjWPP8buMWa2BjeNwhC69jinE0IQ+cs=
Date: Fri, 14 Aug 2026 17:47:13 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, 
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com, baolu.lu@linux.intel.com, 
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <b7lwpyr5zh3gqjxiznye35wih6xukj6uj4j2k7bbzxs7bt5ai5@5vs7vwjfrlsc>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813134936.GM662699@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813134936.GM662699@ziepe.ca>

On Thu, Aug 13, 2026 at 10:49:36AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 11, 2026 at 11:50:20PM +0800, Yu Zhang wrote:
> 
> > +static void hv_iommu_release_device(struct device *dev)
> > +{
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	if (pdev->ats_enabled)
> > +		pci_disable_ats(pdev);
> 
> Since attaching blocking does this and you set blocking as your
> release domain, this is redundant.
> 

Indeed, it is redundant. Will remove. Thank you, Jason.

B.R.
Yu

> The new flow looks alot better, removing the detach operation entirely
> makes sense if the HV can support attach on attach
> 
> Jason
> 
