Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB53E834F
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225917; cv=none; b=Fb+qkYBwtmb38b9YUibhr1o35PSKIVrAODXXKrtPGjm87SrkPdSsn/5engYZJJvsXyEAcsQ+oZsxkmTDXxt4AkUqBpvJ1UXIdQb8t052JZi0mDmVahe8ob6+zexXvo2nR8sk7DrsZuJOq5xNkRleB0mw8cpLxCvJwIBPNDuWMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225917; c=relaxed/simple;
	bh=CWG4mJsfZkyJHOQ00O90SjmdF/aiATH9FgVAEHfx6zE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8gGpN/lvwVgOAuRKGgYfkr31E6vOIXUD5iA6OulVbz0dmlPYGNXszNrMm6jt+yDBOcrREx77E3NL68OGzbVZ5hirFS3rTWlYMhlrAXywuFuCS6HPTOz6wqkCh1ArEXzV+tvNyXdmV+3vXsQWAYFJxi4YHd6/EdWPMalLwwj9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n+YQLxlZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n+YQLxlZ"
Received: from localhost (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8DA0820B7166;
	Tue, 19 May 2026 14:25:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DA0820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779225909;
	bh=aIW3zMIQjtbCVzrlTe/Q+S8fNDzvaMLXVlMgMR8yFCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n+YQLxlZLfWyFnmt1zyBXzzNdqiDgdZY4fW6NQ19CLpaVmulXxGWkfyBQG8VZUvGC
	 aXaL5vSmuHgc5DtXBBXlXRcjCCgsF3IutuJi3V6Iwwar7XC/0yHw+3cMux7U+52Hm7
	 R5+yMkUw+1kZgRwfvJjiJQHuYkbZrsSokPXUohVw=
Date: Tue, 19 May 2026 14:25:13 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 4/9] iommufd: Allow binding to a noiommu device
Message-ID: <20260519142513.00002e1e@linux.microsoft.com>
In-Reply-To: <c15c4d4d-89a8-4ad9-86e2-e1adb3ff8b54@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
	<9f1aa339-6ee5-4ec2-a3f9-b52961afad37@linux.intel.com>
	<20260513150800.000027e5@linux.microsoft.com>
	<c15c4d4d-89a8-4ad9-86e2-e1adb3ff8b54@linux.intel.com>
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

Hi Baolu,

On Thu, 14 May 2026 14:51:01 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> On 5/14/26 06:08, Jacob Pan wrote:
> >>> +}
> >>> +
> >>>    static void iommufd_group_release(struct kref *kref)
> >>>    {
> >>>    	struct iommufd_group *igroup =
> >>> @@ -30,9 +40,11 @@ static void iommufd_group_release(struct kref
> >>> *kref)
> >>>    	WARN_ON(!xa_empty(&igroup->pasid_attach));
> >>>    
> >>> -	xa_cmpxchg(&igroup->ictx->groups,
> >>> iommu_group_id(igroup->group), igroup,
> >>> -		   NULL, GFP_KERNEL);
> >>> -	iommu_group_put(igroup->group);
> >>> +	if (igroup->group) {
> >>> +		xa_cmpxchg(&igroup->ictx->groups,
> >>> iommu_group_id(igroup->group),
> >>> +			   igroup, NULL, GFP_KERNEL);
> >>> +		iommu_group_put(igroup->group);
> >>> +	}
> >>>    	mutex_destroy(&igroup->lock);
> >>>    	kfree(igroup);
> >>>    }
> >>> @@ -204,32 +216,19 @@ void iommufd_device_destroy(struct
> >>> iommufd_object *obj) struct iommufd_device *idev =
> >>>    		container_of(obj, struct iommufd_device, obj);
> >>>    
> >>> -	iommu_device_release_dma_owner(idev->dev);
> >>> +	if (!idev->igroup)
> >>> +		return;  
> >> I don't quite follow this logic. Is this check being added
> >> specifically for the new noiommu mode? Since the noiommu mode
> >> introduces the convention that "igroup->group == NULL" implies
> >> noiommu, there should be no cases where idev->igroup itself is
> >> NULL. 
> > idev->igroup can be null on error path only, not limited to
> > noiommu. It is the partially initialized idev case.
> > /*
> >   * iommufd_device_destroy() handles partially initialized idev,
> >   * so iommufd_object_abort_and_destroy() is safe to call here.
> >   */
> > 
> > How about add this comment?
> >   /* igroup is NULL when destroy called during bind error cleanup
> > */  
> 
> If it's not limited to noiommu, why not making it in a separated
> patch?
> 
Because the error handling is restructured by this patch to use
iommufd_object_abort_and_destroy() on any failure, which calls
iommufd_device_destroy(). Since idev->igroup is now set inside
iommufd_bind_iommu()/iommufd_bind_noiommu(), a failure before those
succeed (or within them before the assignment) leaves idev->igroup ==
NULL. Hence the new null check applies to both iommu and noiommu but
only needed because of this patch.

Before this patch, iommufd_device_destroy was only reachable after bind
fully succeeded. i.e. no partial init idev.

