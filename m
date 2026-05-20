Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076FC30EF80
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245805; cv=none; b=p/li5y5YkisZOnEeuecWX1X//7MMl/Ix2tQvlJ51zbAlGQrP6mvbdEU30xpVizA0b0kyxFv8wEBGgf3Rt7HqvfeaZpy8Nzb+T6eEj4mQraa4jj6lnE530aiIqs9JB29oLTmShR0wPKqOtFCBe31yhYwiX79zugdxmYRUytAFdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245805; c=relaxed/simple;
	bh=b+TAf802zTQe0LwKT6NV5chc5pEdGH9Sj7qbZupGGDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3ZSqMOj5si6jD0BZzGkg8PDSnR9oxif0UxX3I7TkSC2e3oSYQe3DH6q+bQUhp4emuuODU1fBxOTO1RTRXKrkQ7WpjjhuvgYFGGzqCzkEhEjsZ41epgKlNEFlZhDCSxhKS4GRsa5/ODGDQ7ZysZ2bnhCV7XuTt84Lm1bY5Sbk5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CWw5FevI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CWw5FevI"
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DB3A20B7167;
	Tue, 19 May 2026 19:56:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DB3A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779245795;
	bh=Nc2FunzcMe07qY7dqOemLnx02QLv/9oB10BIJVZk1Ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CWw5FevIMoQdIjh1dgKpOc3UHWq56qUtVvGtypIw5Aip/p57va7Y2iQTtnsEThdPq
	 wVfNTeQdBgBx1uD/foUhdMz+2ByWrr+MYHnmNGGWJ+dPI/SUu8wRmCmxj8Yj+sYvM3
	 6z5mIVLXyoCpbuzcH4RuBj+G7I4OJuQFixOq/IU0=
Date: Tue, 19 May 2026 19:56:39 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 skhawaja@google.com, pasha.tatashin@soleen.com, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 7/9] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260519195639.0000261d@linux.microsoft.com>
In-Reply-To: <20260519234005.GO3602937@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
	<20260519234005.GO3602937@nvidia.com>
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

On Tue, 19 May 2026 20:40:05 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 11, 2026 at 11:41:12AM -0700, Jacob Pan wrote:
> > @@ -110,6 +113,13 @@ long vfio_df_ioctl_bind_iommufd(struct
> > vfio_device_file *df, if (df->group)
> >  		return -EINVAL;
> >  
> > +	/*
> > +	 * CAP_SYS_RAWIO is already checked at cdev open, recheck
> > here
> > +	 * in case the fd was passed to a less privileged process.
> > +	 */
> > +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
> > +		return -EPERM;  
> 
> I don't think we should do this, an open only check is sufficient. It
> is entirely reasonable to design a userspace to drop SYS_RAWIO after
> it opens the FD to minimize retained privileges.
right, will remove. VFIO group also only checks at open not during
SET_CONTAINER.

