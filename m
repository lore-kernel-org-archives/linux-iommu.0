Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D09473
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727845913; cv=none; b=MBSEfZMwzpv4YupkrfpghcwnovPBmI69ELNV/RQXbD429cw1ssmn0HskipsIzv3E2wdUl+/2EbjMgxdH8zi5MnNfWfW4yQFCmtdnDDU0JTrgDvqCueruaDLZnUmTiHgFxESJz4Ocn+9cr8v4OpIbHBYrb+4JiGmqyDLdkn4Iq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727845913; c=relaxed/simple;
	bh=YR9HxfgisLiKRMbE07mw+N5RyCx2JDak6lHmiEAG0w4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSHK528z0/lSmzMVjNA/u0jaVLWSZ3q9oBHJDocUPmsTDZbkiYMNqVEn31Ey9E4BYWTToKLwYraj7qpviDHnFWElcIm5aZSAw0GtBaJoRxaKCXaWATtLXf5NOZA4I64ToaOv2RDB1KU9EP2RHBBEM5f9qivAyWsIr+r30BKV910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DGQQFCJX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DGQQFCJX"
Received: from DESKTOP-0403QTC. (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80A1320CECD7;
	Tue,  1 Oct 2024 22:11:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80A1320CECD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727845911;
	bh=K3qkI73zy4vdB5oi47rmzqH7S+bMLIemcLSWPNQLTF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=DGQQFCJXUIfc4YYY0878ncz/QZ7zxkVoxYL5VSi+OcEJ0WFcOI9qe7szxaxQY9J2d
	 uxizxs11oJrSzDL4ssGTdOs4lZtndZUCS+Y+nl2lQTJxY5JeWkCzlhAlXQClsVUBl/
	 M+xTGcRW3zgvAu8sxGavBoi+Me0s0zzF0o7Cvb0w=
Date: Tue, 1 Oct 2024 22:11:48 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Message-ID: <20241001221148.63ec3108@DESKTOP-0403QTC.>
In-Reply-To: <71b99515-6810-4b43-bae3-bc2fa7eeeda4@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-2-vasant.hegde@amd.com>
	<20240912210207.4ba164c2@DESKTOP-0403QTC.>
	<d092766e-bae2-4dd0-b274-69fbf5c27971@amd.com>
	<20240930105523.51fee7c1@DESKTOP-0403QTC.>
	<71b99515-6810-4b43-bae3-bc2fa7eeeda4@amd.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vasant,

On Tue, 1 Oct 2024 10:01:31 +0530
Vasant Hegde <vasant.hegde@amd.com> wrote:

> Hi Jacob,
> 
> On 9/30/2024 11:25 PM, Jacob Pan wrote:
> > Hi Vasant,
> > 
> > On Thu, 26 Sep 2024 15:47:48 +0530
> > Vasant Hegde <vasant.hegde@amd.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >>
> >> On 9/13/2024 9:32 AM, Jacob Pan wrote:  
> >>> Hi Vasant,
> >>>
> >>> On Wed, 11 Sep 2024 10:19:04 +0000
> >>> Vasant Hegde <vasant.hegde@amd.com> wrote:
> >>>     
> >>>> @@ -1962,27 +1978,7 @@ static struct iommu_domain
> >>>> *__iommu_domain_alloc(const struct iommu_ops *ops, if (!domain)
> >>>>  		return ERR_PTR(-ENOMEM);
> >>>>  
> >>>> -	domain->type = type;
> >>>> -	domain->owner = ops;
> >>>> -	/*
> >>>> -	 * If not already set, assume all sizes by default; the
> >>>> driver
> >>>> -	 * may override this later
> >>>> -	 */
> >>>> -	if (!domain->pgsize_bitmap)
> >>>> -		domain->pgsize_bitmap = ops->pgsize_bitmap;
> >>>> -
> >>>> -	if (!domain->ops)
> >>>> -		domain->ops = ops->default_domain_ops;
> >>>> -
> >>>> -	if (iommu_is_dma_domain(domain)) {
> >>>> -		int rc;
> >>>> -
> >>>> -		rc = iommu_get_dma_cookie(domain);
> >>>> -		if (rc) {
> >>>> -			iommu_domain_free(domain);
> >>>> -			return ERR_PTR(rc);
> >>>> -		}
> >>>> -	}
> >>>> +	iommu_domain_init(domain, type, ops);
> >>>>  	return domain;
> >>>>  }
> >>>>  
> >>>> @@ -2965,6 +2961,14 @@ static int
> >>>> iommu_setup_default_domain(struct iommu_group *group, if
> >>>> (group->default_domain == dom) return 0;
> >>>>  
> >>>> +	if (iommu_is_dma_domain(dom)) {
> >>>> +		ret = iommu_get_dma_cookie(dom);
> >>>> +		if (ret) {
> >>>> +			iommu_domain_free(dom);
> >>>> +			return ret;
> >>>> +		}
> >>>> +	}
> >>>> +    
> >>> nit, if a user changes default domain types via sysfs and the
> >>> current domain is already DMA API type, i.e. DMA to DMA-FQ, I
> >>> think it causes an extra round of iommu_get/put_dma_cookie()
> >>> compared with doing this in allocation time.    
> >>
> >> DMA -> DMA_FQ will just initialize flush queue and exit. It will
> >> not enter iommu_setup_default_domain(). In case of DMA_FQ -> DMA
> >> it will do new domain allocation. Am I missing something here?  
> > You are right. No extra get/put_dma_cookie there.
> > My other concern is that this change made domain alloc/free
> > asymmetrical in terms of get/put_dma_cookie.  
> 
> That's correct. And this should be fine right? These are internal
> functions.
> 

There are no functional issues. I don't have strong opinion other than
maintaining symmetry reduces the likelihood of errors.

