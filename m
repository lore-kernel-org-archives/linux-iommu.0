Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C7384243
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306305; cv=none; b=Rw/bDwQq1EKiDiRJlmzi6nOLr7lucjfBO6ACR045u05Q30nN7lC98mUU66YYaSZ0W5iwnHgPsDYhUxrzBWXEUxCVVGd45VdIB6lLOso7fX5qQns9blLuqUCUr8I5Y+dAZQxw7dA9F5kpkV1vwxJmUi7MMOJG4jufgx157tm+NFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306305; c=relaxed/simple;
	bh=n093tGEHdKu7RivosdGFLQNgV7PDaxyyumq3zMhF9FI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+onybjjqvkkUu8iwUcMF1CW+dK3KtSBRGWenkajY07r3vYqHbMwzMAVouGJ2FnrnhJag17fRDNdLg/C4Pt0TtCtSSbOIAtGLvr4k2n5CheLJF28UPu6RS9Ce0VB/Y2DjV57AtoWR1Bhew8tpup7r6D6qwT36tYICV/W6/WpAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VJW9mGrC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VJW9mGrC"
Received: from localhost (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id B212920B710C;
	Mon, 23 Mar 2026 15:51:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B212920B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774306302;
	bh=i6LXDwdSFJn3N/0qymXmMD8adKd/i4WdfCATPpo+dXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJW9mGrCYuhCrqJHJ8r9IyZpZqUMU/6RrUTK8agd4/k6lxsvJU0ZwCGYxO+kIit+P
	 Mr5SQ/V/iOUap2Ti4DQehqlfdIvgkR9Z7iklwpczvzQgVXYnvN7EjNewW/ZCc3dYSn
	 HhV21umXlRAMDFWaeauj6HIj3/IXeicSwDyaYvIE=
Date: Mon, 23 Mar 2026 15:51:40 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 02/11] iommufd: Move igroup allocation to a function
Message-ID: <20260323155140.000039fe@linux.microsoft.com>
In-Reply-To: <ab-5PYF8PGew-Uv_@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
	<20260312155637.376854-3-jacob.pan@linux.microsoft.com>
	<ab-5PYF8PGew-Uv_@google.com>
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

Hi Mostafa,

On Sun, 22 Mar 2026 09:41:17 +0000
Mostafa Saleh <smostafa@google.com> wrote:

> On Thu, Mar 12, 2026 at 08:56:28AM -0700, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > So it can be reused in the next patch which allows binding to
> > noiommu device.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/iommu/iommufd/device.c | 48
> > +++++++++++++++++++++------------- 1 file changed, 30
> > insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/device.c
> > b/drivers/iommu/iommufd/device.c index 344d620cdecc..54d73016468f
> > 100644 --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -30,8 +30,9 @@ static void iommufd_group_release(struct kref
> > *kref) 
> >  	WARN_ON(!xa_empty(&igroup->pasid_attach));
> >  
> > -	xa_cmpxchg(&igroup->ictx->groups,
> > iommu_group_id(igroup->group), igroup,
> > -		   NULL, GFP_KERNEL);
> > +	if (igroup->group)
> > +		xa_cmpxchg(&igroup->ictx->groups,
> > iommu_group_id(igroup->group),
> > +			   igroup, NULL, GFP_KERNEL);  
> 
> Is that a separate fix or perhaps belongs to the next patch making
> it possible to have NULL groups.
Yes, I agree. NULL groups are not possible here. Should be merged with
the next patch.
