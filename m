Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6143D7D87
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505784; cv=none; b=Hsjb7ISMB092k1bL26WaCdwcr/PHeK2YlY2282vHKP++h9e4PhDJz0LQj/k/5XaD8xobTQVHtbl8khNWNmKbrZpnlet5m1oB2bkWFPO8hBjMb+t+ZWiCYCpKF1K1r6d7v9Gi1P3uYUgac7fZIFQAmO+CVZpw8v2qewk+bvAv9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505784; c=relaxed/simple;
	bh=D/T+S1u5dXoaEx6uI6fXKUALhijqa9eWR5IFV7Nds/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSZBw967r1RXbj6+J7XN0FPpBplA28z/RiuEhNCOPkD4LCd+aid6edetDRQjzEGWhh1NSryLvRBVAs3b50GKANQYw5SyPKP0s3v/GbAJQgBUhtT2XeJOWmyQsoEkErOKPdXk7qumgz23KtBPBtTqctTwW+VhPXLpJFew3TVwRWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AOwE3E/O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AOwE3E/O"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 30D1320B7168;
	Wed,  3 Jun 2026 09:56:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30D1320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780505767;
	bh=dJOJv7cU/Zcf6xn2D3pgZgbDLjsqPOix/9NIjv/vTME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AOwE3E/Oa9EHKUu/qjvvkn42GQZvNT5RoBBD+x4N9V6N6qFiS2DOFobdUrwvm+3cV
	 ZC5IOUVVCszNNPm3AP44q6Ijf3Gurh6jtX0yCkCwii/73zJjeXjWaNpTe4BNX8bUmL
	 OjLJ6SyqWFVsSxST/R3xaUUo1asfJUwbrVWVItNY=
Date: Wed, 3 Jun 2026 09:56:20 -0700
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
Subject: Re: [PATCH v7 1/6] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <20260603095620.00004a2e@linux.microsoft.com>
In-Reply-To: <DM6PR11MB369077ABB0DBC1633A76E9648C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
	<20260603054438.2450130-2-jacob.pan@linux.microsoft.com>
	<DM6PR11MB369077ABB0DBC1633A76E9648C132@DM6PR11MB3690.namprd11.prod.outlook.com>
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

On Wed, 3 Jun 2026 06:30:57 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, June 3, 2026 1:45 PM
> > 
> > +static const struct iommu_ops *get_iommu_ops(struct iommufd_device
> > *idev)
> > +{
> > +	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->igroup-  
> > >group)  
> > +		return &iommufd_noiommu_ops;
> > +	if (WARN_ON_ONCE(!idev->dev->iommu))
> > +		return NULL;
> > +	return dev_iommu_ops(idev->dev);
> > +}  
> 
> Sashiko gave a valid comment:
> 
> "
> While get_iommu_ops() correctly handles NO-IOMMU devices for
> hw_pagetable allocations, do the vIOMMU and vDevice allocation paths
> also need similar protection against NULL pointer dereferences?
> "
> 
right, will fix in v8.

> with that fixed:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

