Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468F6192D82
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719040; cv=none; b=ou3Novw979Yim4zWYVW6poXpYQq5mD1DCvGEJF5Q9ifEcEK/H6LnkcyN61AVlSlRNV4gLsuCuZvRzwGU7CGNjDCV3roPl78snWc665Ix9qPRW/rqCFxB15+vqll89p4sOlpaweLpwBrtz6qu5EObrfmDm95r6L9bbEdeW79tu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719040; c=relaxed/simple;
	bh=xWXkXQnuWphloLaGomBOYWLyW+/j0tbfGmqrKlnLQXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuWRiy8J9sgpK9U/8U+Xh64R3lu+k4bgoD0KSl7YOwRxx3LpyQo/hACYqdQ9eB98qCbQ6LbkeF7Vo511G8z597euZB/yqU20SzNT8rBC9QKdXybMT6F9V3L3TTDBCe4EJ8veBGKOIRvg3UsIhg2tRVmUhVRhlUyaEEZqQtaJDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sSj+8b09; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sSj+8b09"
Received: from DESKTOP-0403QTC. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C1E820C8C7F;
	Mon, 30 Sep 2024 10:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C1E820C8C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727719038;
	bh=3MM83mM8AqyCmi+3oDGHy9D4rFKVr+75avLjurLRZLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=sSj+8b09a35cb7AVwo8XuKBawgBWMGNcyRQBGnhPrFtQZ0Zpo1+xHW1IEz8++p8AL
	 ac2WVsB+xOAOsXIPY216msUg1U5iptV+oCD/1yKi03uBUdgLFiZZDMGzIgJ5HKdZNv
	 1z+P+5KILCnwgpL+LuNLetKLnavKbU+6sHTj0R5U=
Date: Mon, 30 Sep 2024 10:57:17 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 5/8] iommu/amd: Pass page table type as param to
 pdom_setup_pgtable()
Message-ID: <20240930105717.754dbf34@DESKTOP-0403QTC.>
In-Reply-To: <3b2c5409-b9de-4769-8276-fd7c85009fa5@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-6-vasant.hegde@amd.com>
	<20240913143945.4499e7e0@DESKTOP-0403QTC.>
	<3b2c5409-b9de-4769-8276-fd7c85009fa5@amd.com>
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

On Thu, 26 Sep 2024 15:55:14 +0530
Vasant Hegde <vasant.hegde@amd.com> wrote:

> Jacob,
> 
> 
> On 9/14/2024 3:09 AM, Jacob Pan wrote:
> > Hi Vasant,
> > 
> > On Wed, 11 Sep 2024 10:19:08 +0000
> > Vasant Hegde <vasant.hegde@amd.com> wrote:
> >   
> >> --- a/drivers/iommu/amd/iommu.c
> >> +++ b/drivers/iommu/amd/iommu.c
> >> @@ -2285,28 +2285,13 @@ struct protection_domain
> >> *protection_domain_alloc(unsigned int type, int nid) }
> >>  
> >>  static int pdom_setup_pgtable(struct protection_domain *domain,
> >> -			      unsigned int type)
> >> +			      unsigned int type, int pgtable)
> >>  {
> >>  	struct io_pgtable_ops *pgtbl_ops;
> >> -	int pgtable;
> >>  
> >> -	switch (type) {
> >>  	/* No need to allocate io pgtable ops in passthrough mode
> >> */
> >> -	case IOMMU_DOMAIN_IDENTITY:
> >> +	if (!(type & __IOMMU_DOMAIN_PAGING))
> >>  		return 0;  
> > Now that you pass in the pgtable format explicitly, I think you can
> > delete 'type' parameter and move this check to
> > do_iommu_domain_alloc(). As you mentioned in [4/8],
> > pdom_setup_pgtable() is factored out for setting up page table
> > only.  
> 
> I could have added check in do_iommu_domain_alloc(). As just kept it
> as is because eventually we can just remove this check. (Once I fix
> SVA domain and after having global static identity domain).
> 
sounds reasonable me.

Thanks,

Jacob


