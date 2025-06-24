Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931822405EB;
	Tue, 24 Jun 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761194; cv=none; b=ZWCy2yZYASFc1zWA1DGRcjzrA6gy7X1OdVyYkMxDFRiUMfUehBzWerYyJ+9VmzCDylj5RUZz7Gs+BBXxwwuiI4pAeih9EgsSNgIXuSt4eiqdwvoHoyqP1KTXgi3AEDyQE7L23zajB2Fzy1emZm2H3nV9TJFvHkoCXeIqwdSAfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761194; c=relaxed/simple;
	bh=RhqjeQ8FXpmxCGe3NIkI0seZZwUMhIJLoSAjcosHxak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8jK3Y3lB0Bj7A4bHq5NgBO0FOKIQnSAhc4db7618fwfsais9aanOqLrNrIsKjkCHCXbroa7tWPZ2QFQSZQnza0qcWv+JQEwRaH7d/t5uwMfqELheM9s7upjHhaYvwqKcYY5SOe8mn+TJu1CjR3+rMA0Dj3snJEGS/qxi/jG02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8lWLtgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8lWLtgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3F4C4CEE3;
	Tue, 24 Jun 2025 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750761194;
	bh=RhqjeQ8FXpmxCGe3NIkI0seZZwUMhIJLoSAjcosHxak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=j8lWLtgEIEQO/hlBTdMPSqurs+kKU1ml1JrNZte9lhdvx2Q2xLqmyNHPxHq1GoMIy
	 TfwAmyso0EQYYH28iXOH2QpePZbmO1Ce2Q7tXguIFR6iJ8LO227+zCYeWz0PX7e4CQ
	 FaQbl88vfOZz/k+hs4g7yB7cUSLx7V3z3tVFZKdPad8ol440ZPTuP2p8W9V533WuD0
	 /XOdSuBA/1k8wXMVH28+9RvyVp4SFFN9OFNakjYkNoUKv0wIgGOf0lbuPmVFm2dx4p
	 GbZgukha+LAFyqWCPPGXlHgEspN0sZBAUG3CjXfIr7Rn1HZRrWrBkIZk9Tj3SMZ/82
	 q/kW83d0itMiA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
In-Reply-To: <20250618150018.GS1376515@ziepe.ca>
References: <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca> <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250616164941.GA1373692@ziepe.ca> <yq5azfe6ssev.fsf@kernel.org>
 <20250617183452.GG1376515@ziepe.ca> <yq5awm99sjmr.fsf@kernel.org>
 <20250618133527.GQ1376515@ziepe.ca> <yq5att4drtj7.fsf@kernel.org>
 <20250618150018.GS1376515@ziepe.ca>
Date: Tue, 24 Jun 2025 16:03:07 +0530
Message-ID: <yq5a8qlh5t0c.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jun 18, 2025 at 08:22:44PM +0530, Aneesh Kumar K.V wrote:
>> > The full sequence I would expect a sane userspace to do is:
>> >
>> > open(vfio_cdev)
>> > ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
>> > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
>> > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
>> > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC)
>> > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_DEALLOC)
>> > close(vfio_cdev);
>> >
>> 
>> And if the user does
>> 
>> open(vfio_cdev)
>> ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
>> ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
>> ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
>> close(vfio_cdev);   -> this should call vdevice_destroy because idevice is getting destroyed here (we will put XA_ZERO_ENTRY here).
>
> Yes, we have to destroy the vdevice internally here
>
>> ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC) -> No error, we convert the XA_ZERO_ENTRY to NULL here?
>
> This should probably fail since the user has done something wrong and
> it would be the only way to realize it. The failure could clean up the
> tombstone, or it could just leak I don't have a strong feeling.
>
> If you leak then using XA_ZERO_ENTRY is easy, if you want to clean up
> then you'd have to have a global static 'tombstone object' that sits
> in the xarray.

I have a related question w.r.t iommufd_fops_release(). How is that safe
against a parallel iommufd_destroy()?

in iommufd_fops_release ()
xa_for_each(&ictx->objects, index, obj) {

                            ---> A parallel iommufd_destroy() can free the obj here ?

	if (!refcount_dec_if_one(&obj->users))
		continue;

}

-aneesh
