Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1EF3C30
	for <iommu@lists.linux.dev>; Fri, 26 Jul 2024 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721961396; cv=none; b=e1O8Qf7qJvlMUfSzDdCl59DydjJ6kWzkx4pTD0V+9cPnBEkGeD78nMAAzstF605ehjgP24r4xCixBH2KRbnhnYnKMU21p7lOM+i8KT8paOYoOD4fW77ZQOlUOb+OfPG40kecmiT2iLsVyq2ejo41mmB4Vqz8OsBMovz+me6bQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721961396; c=relaxed/simple;
	bh=9ERXVim16l2umP0ArMPyUU21BKes/Xfhb5RPPX4+4Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7Z+FFHcP/HJVcVMbYyfAEgwO2vQO+nK7yIxpb9IIoh/X5ZYJADDX57XqNmi6aj7mNX+1Dmej3kXmGCmPjSz5Ej0XmVoncV1XJvs8D2YgE7Vx4/5AKx8/edtx3vOLsrn03BEKUjwKfxe54NuWMsEOijienremWAvU6oZ/5goISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zf0PTt6w; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zf0PTt6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721961395; x=1753497395;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ERXVim16l2umP0ArMPyUU21BKes/Xfhb5RPPX4+4Xs=;
  b=Zf0PTt6wn8FQqHnf5FHwVmg89g5Qh+BtT9DhIkhALQGAPU9ep1gAIe9J
   UvLrlvCFaKvm4B8QHDt6rG6pTaCEvQ8DjOMXCjzXix84Qcy1yVo+8aLyF
   qZaUfIMYhK988LKI67dzVgYjciM0BCApTj2b1k0WyPOHoVo+8jAgT8kIr
   khKa4pa8x67YzZcSAGE+IOdTzHzDP2Q+zBAlHZ18HaBFw+kK7qTuHAPuF
   4Gq2eoGl65miTPA31BQnWJkIM2JLzvqQAfRxOMrIs7ezsgEQX2aIVq6eo
   eV5QgUvv+BqT3kbHOKtLwgmT1vYyjrFwpzbAB8fkodeqfIC/2mmRg7h70
   w==;
X-CSE-ConnectionGUID: 3WFwI5HVQ5KW57GK0cUbVg==
X-CSE-MsgGUID: PQUgZQ/SSJWckjPdoktJMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="23539281"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="23539281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 19:36:35 -0700
X-CSE-ConnectionGUID: 6Nm7wplSQxOg0BYz1TwJAg==
X-CSE-MsgGUID: kH954iukQ/aM3a+dvD1JPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="53044580"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 19:36:35 -0700
Date: Thu, 25 Jul 2024 19:41:59 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Message-ID: <20240725194159.41192480@jacob-builder>
In-Reply-To: <BN9PR11MB52766AC7AEFA103E5B1D067B8CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240724092540.6ef4d28a@jacob-builder>
	<BL1PR11MB5271D3D84F93BA16852233F98CAB2@BL1PR11MB5271.namprd11.prod.outlook.com>
	<20240725141111.6889dd62@jacob-builder>
	<BN9PR11MB52766AC7AEFA103E5B1D067B8CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
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


On Fri, 26 Jul 2024 00:18:13 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, July 26, 2024 5:11 AM  
> > > > > > @@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu  
> > > > *iommu,  
> > > > > > struct qi_desc *desc,
> > > > > >  		raw_spin_lock(&qi->q_lock);
> > > > > >  	}
> > > > > >
> > > > > > -	for (i = 0; i < count; i++)
> > > > > > -		qi->desc_status[(index + i) % QI_LENGTH] =
> > > > > > QI_DONE;
> > > > > > +	/*
> > > > > > +	 * The reclaim code can free descriptors from multiple
> > > > > > submissions
> > > > > > +	 * starting from the tail of the queue. When count ==
> > > > > > 0, the
> > > > > > +	 * status of the standalone wait descriptor at the
> > > > > > tail of the queue
> > > > > > +	 * must be set to QI_TO_BE_FREED to allow the reclaim
> > > > > > code to proceed.
> > > > > > +	 */
> > > > > > +	for (i = 0; i <= count; i++)
> > > > > > +		qi->desc_status[(index + i) % QI_LENGTH] =
> > > > > > QI_TO_BE_FREED;  
> > > > >
> > > > > We don't really need a new flag. Just set them to QI_FREE and then
> > > > > reclaim QI_FREE slots until hitting qi->head in
> > > > > reclaim_free_desc().  
> > > > We do need to have a separate state for descriptors pending to be
> > > > freed. Otherwise, reclaim code will advance pass the intended range.
> > > >  
> > >
> > > The commit msg said that QI_DONE is currently used for conflicting
> > > purpose.
> > >
> > > Using QI_FREE keeps it only for signaling that a wait desc is
> > > completed.
> > >
> > > The key is that reclaim() should not change a desc's state before it's
> > > consumed by the owner. Instead we always let the owner to change the
> > > state and reclaim() only does scan and adjust the tracking fields then
> > > such race condition disappears.
> > >
> > > In this example T2's slots are changed to QI_FREE by T2 after it
> > > completes all the checks. Only at this point those slots can be
> > > reclaimed.  
> > 
> > The problem is that without the TO_BE_FREED state, the reclaim code
> > would have no way of knowing which ones are to be reclaimed and which
> > ones are currently free. Therefore, it cannot track free_cnt.
> > 
> > The current reclaim code is not aware of owners nor how many to reclaim.
> > 
> > If I make the following changes and run, free_cnt will keep going up and
> > system cannot boot. Perhaps you meant another way?
> > 
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -1204,8 +1204,7 @@ static void free_iommu(struct intel_iommu
> > *iommu)
> >   */
> >  static inline void reclaim_free_desc(struct q_inval *qi)
> >  {
> > -       while (qi->desc_status[qi->free_tail] == QI_TO_BE_FREED) {
> > -               qi->desc_status[qi->free_tail] = QI_FREE;
> > +       while (qi->desc_status[qi->free_tail] == QI_FREE) {
> >                 qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
> >                 qi->free_cnt++;  
> 
> Here miss a check to prevent reclaiming unused slots:
> 
> 		if (qi->free_tail == qi->free_head)
> 			break;
> 
> In the example flow reclaim_free_desc() in T1 will only reclaim slots
> used by T1 as slots of T2 are either QI_IN_USE or QI_DONE. T2 slots
> will be reclaimed when T2 calls reclaim_free_desc() after setting them
> to QI_FREE, and reclaim will stop at qi->free_head.
> 
> If for some reason T2 completes earlier than T1. reclaim_free_desc()
> in T2 does nothing as the first slot qi->free_tail belongs to T1 still
> IN_USE. T2's slots will then wait until reclaim is triggered by T1 later.
> 
This makes sense. Unlike the original code, we now only allow freeing the
submitter's own descriptors.

> >         }
> > @@ -1466,10 +1465,10 @@ int qi_submit_sync(struct intel_iommu *iommu,
> > struct qi_desc *desc,
> >          * The reclaim code can free descriptors from multiple
> > submissions
> >          * starting from the tail of the queue. When count == 0, the
> >          * status of the standalone wait descriptor at the tail of the
> > queue
> > -        * must be set to QI_TO_BE_FREED to allow the reclaim code to
> > proceed.
> > +        * must be set to QI_FREE to allow the reclaim code to proceed.
> >          */
> >         for (i = 0; i <= count; i++)
> > -               qi->desc_status[(index + i) % QI_LENGTH] =
> > QI_TO_BE_FREED;
> > +               qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;
> > 
> >         reclaim_free_desc(qi);
> >         raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> > diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> > index 1ab39f9145f2..eaf015b4353b 100644
> > --- a/drivers/iommu/intel/iommu.h
> > +++ b/drivers/iommu/intel/iommu.h
> > @@ -382,8 +382,7 @@ enum {
> >         QI_FREE,
> >         QI_IN_USE,
> >         QI_DONE,
> > -       QI_ABORT,
> > -       QI_TO_BE_FREED
> > +       QI_ABORT
> >  };
> > 
> > Thanks,
> > 
> > Jacob  
> 


Thanks,

Jacob
