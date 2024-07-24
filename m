Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87662595
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838019; cv=none; b=m9+mnD2dmcMuzo6Z+o3bVHUWWi/HCvaqoLnCvKmZS2h4BPpmmWknktX3d/hALS3C3iO3f0f9cPAPcrK5xiKGgLHQUBg1ptLwu5sHgvOiv0ZqJTE8mTDDeUebV9pe6fW1/QuB1bP/Ng92ZW2o3o6T/pWae2kwXm05XYLrCQD0bQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838019; c=relaxed/simple;
	bh=JXmAywMAZrx4shNYDjV3SQ2rLj23PhdbU8dZwkLvoVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTEMYIlpQPBX8AmGXtZHzxW307DivB2SletqZnytMe6GpUVqqUnJO3UojFej/y19vnDzMWDcci1g1DQ++3hHemjGpSiOzh1Yk4UB18mjIxr1Zl4rMapM7hADppB9zwqRNUg95/cSfE5ssyvYMa8KkOzsNLYQlkoJH90RW0EuqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcQPU0cS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcQPU0cS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721838018; x=1753374018;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JXmAywMAZrx4shNYDjV3SQ2rLj23PhdbU8dZwkLvoVA=;
  b=jcQPU0cSkndinF6oeH7frQVXQFN0MoM7i8mK/tKVtrobXtYzuhQYLLyl
   sHGgDsdGnL15ABvEGdHlVTyjy7w3F0Rst9CXrJ0x75l1QvN/1rl3vA+7M
   r0i5uvgTKCdBvdEtEPr9zS5NDWeRcSveXZVmCST34llauO6ko5K044zzt
   YT4swhVl7vIrkYcGPhQtOlX8y9GJUufRqY7MX15PDZgengtF6TDtjYe+L
   7t15cgZjGTcxgaF5xiq0zGYo+E4uGSjaYE7ig7wLyH+HarDPdroa5b8Xa
   gkoHTGzHaHf29wtnLys83jCHRBS9bKrAQNVaLfSRCwzCYKrraZ4XTEae0
   Q==;
X-CSE-ConnectionGUID: 2nV+2kBsQ/aBVrYrqaiXOw==
X-CSE-MsgGUID: lRlnHEp3Q2eRNEqdEFmlKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19406580"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19406580"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 09:20:17 -0700
X-CSE-ConnectionGUID: mYTLLEG9SwWQKBEa+shXow==
X-CSE-MsgGUID: Ki7RrNP2Qzm7ymdtu5ALew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="57771913"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 09:20:18 -0700
Date: Wed, 24 Jul 2024 09:25:40 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Message-ID: <20240724092540.6ef4d28a@jacob-builder>
In-Reply-To: <BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
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


On Wed, 24 Jul 2024 07:40:25 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, July 20, 2024 2:17 AM
> > 
> > From: Sanjay K Kumar <sanjay.k.kumar@intel.com>
> > 
> > If qi_submit_sync() is invoked with 0 invalidation descriptors (for
> > instance, for DMA draining purposes), we can run into a bug where a
> > submitting thread fails to detect the completion of invalidation_wait.
> > Subsequently, this led to a soft lockup.
> > 
> > Suppose thread T1 invokes qi_submit_sync() with non-zero descriptors,
> > while
> > concurrently, thread T2 calls qi_submit_sync() with zero descriptors.
> > Both threads then enter a while loop, waiting for their respective
> > descriptors to complete. T1 detects its completion (i.e., T1's
> > invalidation_wait status changes to QI_DONE by HW) and proceeds to call
> > reclaim_free_desc() to reclaim all descriptors, potentially including
> > adjacent ones of other threads that are also marked as QI_DONE.
> > 
> > During this time, while T2 is waiting to acquire the qi->q_lock, the
> > IOMMU hardware may complete the invalidation for T2, setting its status
> > to QI_DONE. However, if T1's execution of reclaim_free_desc() frees T2's
> > invalidation_wait descriptor and changes its status to QI_FREE, T2 will
> > not observe the QI_DONE status for its invalidation_wait and will
> > indefinitely remain stuck.
> > 
> > This soft lockup does not occur when only non-zero descriptors are
> > submitted.In such cases, invalidation descriptors are interspersed among
> > wait descriptors with the status QI_IN_USE, acting as barriers. These
> > barriers prevent the reclaim code from mistakenly freeing descriptors
> > belonging to other submitters.
> > 
> > Considered the following example timeline:
> > 	T1			T2
> > ========================================
> > 	ID1
> > 	WD1
> > 	while(WD1!=QI_DONE)
> > 	unlock
> > 				lock
> > 	WD1=QI_DONE*		WD2
> > 				while(WD2!=QI_DONE)
> > 				unlock
> > 	lock
> > 	WD1==QI_DONE?
> > 	ID1=QI_DONE		WD2=DONE*
> > 	reclaim()
> > 	ID1=FREE
> > 	WD1=FREE
> > 	WD2=FREE
> > 	unlock
> > 				soft lockup! T2 never sees QI_DONE in
> > WD2
> > 
> > Where:
> > ID = invalidation descriptor
> > WD = wait descriptor
> > * Written by hardware
> > 
> > The root of the problem is that the descriptor status QI_DONE flag is
> > used for two conflicting purposes:
> > 1. signal a descriptor is ready for reclaim (to be freed)
> > 2. signal by the hardware that a wait descriptor is complete
> > 
> > The solution (in this patch) is state separation by introducing a new
> > flag for the descriptors called QI_TO_BE_FREED.
> > 
> > Once a thread's invalidation descriptors are complete, their status
> > would be set to QI_TO_BE_FREED. The reclaim_free_desc() function would
> > then only
> > free descriptors marked as QI_TO_BE_FREED instead of those marked as
> > QI_DONE. This change ensures that T2 (from the previous example) will
> > correctly observe the completion of its invalidation_wait (marked as
> > QI_DONE).
> > 
> > Currently, there is no impact by this bug on the existing users because
> > no callers are submitting invalidations with 0 descriptors.  
> 
> bug fix is for existing users. Please revise the subject line and this msg
> to make it clear that it's for preparation of a new usage.
The bug is in the qi_submit_sync function itself since it permits callers
to give 0 as count. It is a bug regardless of users.

I put "potential" in the subject line to indicate, perhaps it is too vague.
How about just stating what it is fixing:
"Fix potential lockup if qi_submit_sync called with 0 count"

Also change this paragraph to:
"Currently, there is no impact by this bug on the existing users because
 no callers are submitting invalidations with 0 descriptors. This fix will
 enable future users (such as DMA drain) calling qi_submit_sync() with 0
 count."

> > 
> > Signed-off-by: Sanjay K Kumar <sanjay.k.kumar@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/dmar.c  | 13 +++++++++----
> >  drivers/iommu/intel/iommu.h |  3 ++-
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> > index 304e84949ca7..00e0f5f801c5 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -1204,8 +1204,7 @@ static void free_iommu(struct intel_iommu
> > *iommu)
> >   */
> >  static inline void reclaim_free_desc(struct q_inval *qi)
> >  {
> > -	while (qi->desc_status[qi->free_tail] == QI_DONE ||
> > -	       qi->desc_status[qi->free_tail] == QI_ABORT) {
> > +	while (qi->desc_status[qi->free_tail] == QI_TO_BE_FREED) {
> >  		qi->desc_status[qi->free_tail] = QI_FREE;
> >  		qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
> >  		qi->free_cnt++;
> > @@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu *iommu,
> > struct qi_desc *desc,
> >  		raw_spin_lock(&qi->q_lock);
> >  	}
> > 
> > -	for (i = 0; i < count; i++)
> > -		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
> > +	/*
> > +	 * The reclaim code can free descriptors from multiple
> > submissions
> > +	 * starting from the tail of the queue. When count == 0, the
> > +	 * status of the standalone wait descriptor at the tail of the
> > queue
> > +	 * must be set to QI_TO_BE_FREED to allow the reclaim code to
> > proceed.
> > +	 */
> > +	for (i = 0; i <= count; i++)
> > +		qi->desc_status[(index + i) % QI_LENGTH] =
> > QI_TO_BE_FREED;  
> 
> We don't really need a new flag. Just set them to QI_FREE and then
> reclaim QI_FREE slots until hitting qi->head in reclaim_free_desc().
We do need to have a separate state for descriptors pending to be freed.
Otherwise, reclaim code will advance pass the intended range.

> > 
> >  	reclaim_free_desc(qi);
> >  	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> > diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> > index eaf015b4353b..1ab39f9145f2 100644
> > --- a/drivers/iommu/intel/iommu.h
> > +++ b/drivers/iommu/intel/iommu.h
> > @@ -382,7 +382,8 @@ enum {
> >  	QI_FREE,
> >  	QI_IN_USE,
> >  	QI_DONE,
> > -	QI_ABORT
> > +	QI_ABORT,
> > +	QI_TO_BE_FREED
> >  };
> > 
> >  #define QI_CC_TYPE		0x1
> > --
> > 2.25.1
> >   
> 


Thanks,

Jacob
