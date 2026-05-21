Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A6383308
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382200; cv=none; b=hwSSoDv8lh3VQHRO6ucHprUsSCkTrGp4OtEC7i4Zo/xOIXirJshsmffXUlmYrexRfDu88ltJULPcOFX3WEYYjJtibq2u6NCHvmoRVcog/PomJId8uluKl2AusDj0nMQkCJ3ElgBB/HmYncJy/ipNgQuAuNYw9P+nks5szivrOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382200; c=relaxed/simple;
	bh=GBm0CR9LTZO1hAHcRfNU7IJ7mrYtpJP7pYumhwbdgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sF6OatIxxS5pe8YJ0C+BgAIPwn/oMUvXF9ctIaWHjmeqkJlTyJV4xhU3vkWl+afs96hf1MBE7mQPCSuz0VNMl64Hy5s9cfUqsxBXgFc03PYd7sukHLDZ9jUKBXd1PfFgYTL6Ncoml1dLOm7+dG54nFgBz5g83XRwNLRfxdzTGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=izsGCiRS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="izsGCiRS"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A3D020B7167;
	Thu, 21 May 2026 09:49:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A3D020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779382191;
	bh=Qi94MGsEITx5l4tJSBoua6PvCiv+tRnSY4HBNVZ5tj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=izsGCiRS+XMF5ghXqtN3cIoXIZs9KYsI7qWPwVY2JT3w0yPFtj6I/eTxzZLY+IzcJ
	 W2pDNriDlXw7USQm9wor1sBpJiihvNhySS87wCik+wXmt4IjR9sKo9GO5WJM6cAxpF
	 sQ4URfzTpBZQDBwixtr3uocf1OCY+iSB6mOuSCnI=
Date: Thu, 21 May 2026 09:49:57 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 7/9] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260521094957.000030f5@linux.microsoft.com>
In-Reply-To: <95235a41-f9b3-4b5b-9a34-489a9ff7eac5@intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
	<20260519214613.167e8d5b@shazbot.org>
	<95235a41-f9b3-4b5b-9a34-489a9ff7eac5@intel.com>
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

Hi Yi,

On Wed, 20 May 2026 15:20:26 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> >>   
> >> -#ifdef CONFIG_VFIO_GROUP_NOIOMMU
> >> +#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) ||
> >> IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)  
> > 
> > Have you considered what happens when these are y/n or n/y?
> > 
> > I think in the former case we can create cdev devices for
> > group-noiommu devices that are not labeled noiommu, skip the
> > CAP_SYS_RAWIO test, but will fail to bind.  In the latter case, I
> > think we fail to setup an iommufd_device and unbind will segfault.
> > 
> > We really don't need to support independently setting GROUP vs CDEV
> > NOIOMMU, the suggestion was to try to get NOIOMMU from depending on
> > VFIO_GROUP.  We can do that other ways though and I think we can do
> > it without the rename in patch 1 that will inevitably result in
> > some lost config options for NOIOMMU on upgrade.
> > 
> > The Kconfig may get messy, perhaps something like:
> > 
> > config VFIO_NOIOMMU
> > 	bool "VFIO No-IOMMU support"
> > 	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
> > 	depends on !VFIO_GROUP || VFIO_CONTAINER ||
> > IOMMUFD_VFIO_CONTAINER depends on !VFIO_DEVICE_CDEV ||
> > !GENERIC_ATOMIC64 select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
> > 
> > Sorry if the previous suggestion sent us astray, but the subtleties
> > of independent support look tricky.  Thanks,  
> 
> this also looks better to me. Less kconfigs. :)

Just to recap our discussions, we agreed with Alex's Kconfig
and the breakdown cases are as follows:

Container = VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER

#  GROUP  Container  CDEV  NOIOMMU  Notes
-  -----  ---------  ----  -------  -----------------------
1    y       y        n     yes     Group noiommu works
2    y       n        n      no     Blocked - no container
3    y       y        y     yes     Both paths work
4    y       n        y      no     Blocked - no container
5    n       -        y     yes     Cdev-only works
6    n       -        n      no     No access path

Note that we sacrifice #4.  The tradeoff: case 4
sacrifices cdev noiommu to avoid the useless group node
problem purely in Kconfig.  The practical impact is small -
if someone wants cdev noiommu without container, they just
set GROUP=n.  This greatly simplifies the code since NULL
group checks are not needed.

OTOH, if we want #4, we can loosen the Kconfig:

	depends on !VFIO_GROUP || VFIO_DEVICE_CDEV || \
		VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER

but that would allow creating useless group nodes without a
container backend.  Enforcing VFIO_GROUP=n purely via Kconfig
is not possible since it would cause a circular dependency
(CONTAINER depends on GROUP).

I will send v6 shortly.

Thanks,
Jacob
