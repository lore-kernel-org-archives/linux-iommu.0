Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24F13E881
	for <iommu@lists.linux.dev>; Thu, 25 Jul 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941549; cv=none; b=di5L+pCM5K8qkn2PrBIeALjw54YOcqRawfzpVegKC7ZZM/nFoO101jCawMCtgYmaxoBuMBm5zrklDdqAhY2jx4CkHgCs2jb6YGtie6F8oQyU41tKwfGyJod9mvy5zWDzEjJhWdcrPNdGe7kNsuRbZgj0n5bWbr9APNobckpfECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941549; c=relaxed/simple;
	bh=hd0Q+jdLPbwm8zx67+UgjyJB+DectwEmFT4CQrLKJqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owNV4BP8ETN3YHoeSttIiO/E7ERrvp7t4ZCHhDk427VNzxkHOSQVtNHFZpydGlEiWRPbLh29dyEaOVIxATa4kxoaRhOnXO2A6h9+VpbmyeeUTMs0wSmCOtHr9VWrgSni1N3oC8oZzgHfIvly2C08FvPXOc5yO7TTlEOoqVbWuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asg1cy7j; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asg1cy7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721941548; x=1753477548;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hd0Q+jdLPbwm8zx67+UgjyJB+DectwEmFT4CQrLKJqs=;
  b=asg1cy7jcSaUeAEZnTJ6PfKyTWiVeGk0JfRNMrynADqawc9QcCMqYqoB
   XoNBGYmqSfaPuvFmIy2FbPkAWBOPImnVIkgHuMHo2RtZYhvwM9P0w7RXZ
   u0MWlFGrLuy7xgvHo9MGxIoGOJOwTUNY2HCOpc3ce4fVjjWoakxhbclbv
   QCZuxcPH3uBm4fiRpdME/CpFoO7AgLOCJhef+a8RRIfEgBp5pYtyIaNGa
   bIGMs4R0VzgWsvlMXBxM7I8S8K5uBzN6Yxqoc5+BIbYGMz5Bg+lhTRvuI
   N2OmJQxTa/7PnKFART+kht/SJkP8gzFvjq0YhH/2tSy+/1DrtveZnXyAZ
   A==;
X-CSE-ConnectionGUID: fBUeiS9XQ2SvXmrQIv6qow==
X-CSE-MsgGUID: csfxVtYmSnqdNYrsPF582g==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="12720265"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="12720265"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 14:05:47 -0700
X-CSE-ConnectionGUID: 5bdJfwZFS4mTVub3fhxl2g==
X-CSE-MsgGUID: uOjeZl8BQ8+kZpL+mKWb2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="90528961"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 14:05:47 -0700
Date: Thu, 25 Jul 2024 14:11:11 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Message-ID: <20240725141111.6889dd62@jacob-builder>
In-Reply-To: <BL1PR11MB5271D3D84F93BA16852233F98CAB2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240724092540.6ef4d28a@jacob-builder>
	<BL1PR11MB5271D3D84F93BA16852233F98CAB2@BL1PR11MB5271.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Thu, 25 Jul 2024 00:44:05 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, July 25, 2024 12:26 AM
> > 
> > On Wed, 24 Jul 2024 07:40:25 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >   
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Saturday, July 20, 2024 2:17 AM
> > > >
> > > > Currently, there is no impact by this bug on the existing users
> > > > because no callers are submitting invalidations with 0 descriptors.
> > > >  
> > >
> > > bug fix is for existing users. Please revise the subject line and
> > > this msg to make it clear that it's for preparation of a new usage.  
> > The bug is in the qi_submit_sync function itself since it permits
> > callers to give 0 as count. It is a bug regardless of users.
> > 
> > I put "potential" in the subject line to indicate, perhaps it is too
> > vague. How about just stating what it is fixing:
> > "Fix potential lockup if qi_submit_sync called with 0 count"
> > 
> > Also change this paragraph to:
> > "Currently, there is no impact by this bug on the existing users because
> >  no callers are submitting invalidations with 0 descriptors. This fix
> > will enable future users (such as DMA drain) calling qi_submit_sync()
> > with 0 count."  
> 
> Then please move it to the start.
> 
> > > > @@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu  
> > *iommu,  
> > > > struct qi_desc *desc,
> > > >  		raw_spin_lock(&qi->q_lock);
> > > >  	}
> > > >
> > > > -	for (i = 0; i < count; i++)
> > > > -		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
> > > > +	/*
> > > > +	 * The reclaim code can free descriptors from multiple
> > > > submissions
> > > > +	 * starting from the tail of the queue. When count == 0,
> > > > the
> > > > +	 * status of the standalone wait descriptor at the tail of
> > > > the queue
> > > > +	 * must be set to QI_TO_BE_FREED to allow the reclaim code
> > > > to proceed.
> > > > +	 */
> > > > +	for (i = 0; i <= count; i++)
> > > > +		qi->desc_status[(index + i) % QI_LENGTH] =
> > > > QI_TO_BE_FREED;  
> > >
> > > We don't really need a new flag. Just set them to QI_FREE and then
> > > reclaim QI_FREE slots until hitting qi->head in reclaim_free_desc().  
> > We do need to have a separate state for descriptors pending to be freed.
> > Otherwise, reclaim code will advance pass the intended range.
> >   
> 
> The commit msg said that QI_DONE is currently used for conflicting
> purpose.
> 
> Using QI_FREE keeps it only for signaling that a wait desc is completed.
> 
> The key is that reclaim() should not change a desc's state before it's
> consumed by the owner. Instead we always let the owner to change the
> state and reclaim() only does scan and adjust the tracking fields then
> such race condition disappears.
> 
> In this example T2's slots are changed to QI_FREE by T2 after it completes
> all the checks. Only at this point those slots can be reclaimed.

The problem is that without the TO_BE_FREED state, the reclaim code would
have no way of knowing which ones are to be reclaimed and which ones are
currently free. Therefore, it cannot track free_cnt.

The current reclaim code is not aware of owners nor how many to reclaim.

If I make the following changes and run, free_cnt will keep going up and
system cannot boot. Perhaps you meant another way?

--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1204,8 +1204,7 @@ static void free_iommu(struct intel_iommu *iommu)
  */
 static inline void reclaim_free_desc(struct q_inval *qi)
 {
-       while (qi->desc_status[qi->free_tail] == QI_TO_BE_FREED) {
-               qi->desc_status[qi->free_tail] = QI_FREE;
+       while (qi->desc_status[qi->free_tail] == QI_FREE) {
                qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
                qi->free_cnt++;
        }
@@ -1466,10 +1465,10 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
         * The reclaim code can free descriptors from multiple submissions
         * starting from the tail of the queue. When count == 0, the
         * status of the standalone wait descriptor at the tail of the queue
-        * must be set to QI_TO_BE_FREED to allow the reclaim code to proceed.
+        * must be set to QI_FREE to allow the reclaim code to proceed.
         */
        for (i = 0; i <= count; i++)
-               qi->desc_status[(index + i) % QI_LENGTH] = QI_TO_BE_FREED;
+               qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;

        reclaim_free_desc(qi);
        raw_spin_unlock_irqrestore(&qi->q_lock, flags);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1ab39f9145f2..eaf015b4353b 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -382,8 +382,7 @@ enum {
        QI_FREE,
        QI_IN_USE,
        QI_DONE,
-       QI_ABORT,
-       QI_TO_BE_FREED
+       QI_ABORT
 };

Thanks,

Jacob
