Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F290328B4B
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351916; cv=none; b=aZY3V4osf23fss0vAMxjhIsNhdItejn1lq0Gsc7LpelQsLFza/xRDazMUPUvTZ6PItlvYHb7y5K7iIoIUHU8b/ATOdi9haLxv+xxNxNvFkcOSKQyxlUSXp9uMzx9uQKbjlgBeGK1P3z9Gz8gpleUrrhGFCyZDlRAO/fhFKGZNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351916; c=relaxed/simple;
	bh=OQLvM6Ce6wnd1Xx17T1IJBpk7DXaPyZwKJjVdrxPlD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X4dw+pYRHHEZMlLSAWj0A3QPD2hgNVpWUn+5VDG+fEikTey++7RWHKdMpTSxn0M/4IBYAMmVgYe11IJzAHqKceZ4HGMIBwpxb3/h3BdkWn0zM0ahAL8o+wZ/5qBySMMHA9vlVMPy+J4cCEKfX9Ys5at6N8pv/4n6KXw+vHTeVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5ArYqnE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5ArYqnE"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd5b20aaa6so62616095ad.2
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779351914; x=1779956714; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4fIVdPCzP6UmKqFELGnatwYqCNocE/DOSWTE+QKxm8=;
        b=M5ArYqnEHeQGLjvOFChduChRCzIHae13AMf8wNNoA71LyegQS9YZ6k5mOO4RNJvOpa
         OOc7DxkeET490EHFb+zZ8T973bkSGQ5E2MzxQrVWPhoPEDy/WjeYDVD8UF56uggxrXiC
         E7h1VqnfBrpDdCjV0FDfKCe6Qy12itNhYQXscGuVqFGI7aVfksrhsIeqSo2/Sujmynvt
         9D6eeU0cXM68l4GYpJavj4vFBhjBPdCjPq/KNreeqS/67fPeJuSHU/1py+F70PAeHULm
         edteH1o1cWCxEqTNps1k8xMorzW3G130oNbySICkmO2+tEhwai8ekg+L2Uj4/WNvRCqz
         wFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779351914; x=1779956714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4fIVdPCzP6UmKqFELGnatwYqCNocE/DOSWTE+QKxm8=;
        b=P25DrH+JsWJTuZICELwI8QQqUg8gRglNLiK5s/1E5g4uHWJp6qkskcQnN+S6FBn+tJ
         m2vZWLbBBflNyWJB+Nr8ld5pv/x9SxQg8jaUxMJ4Z019QlVyk8tcowkyeZusbOVNmaAh
         h75N8UwSAPfb2Eyk3sBPiQFnnKsgveHLC59qCVygSohCfEP6SVqGLv1L/94hNkZbqBgS
         xUqxK5YUMaOQQGQm0mXHej7Jm72IWV5fVLP6HW4XuqIm74TTp/0q298Z2du0ucLa9ufa
         PdNGH2cA/CK0SmItAVrTZZ8g1fr/MscVhJ3qA5e2ZQQUHTRn0j12F51Y0qRsJuRaACa3
         2j/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9nt4Jgj86hwifzXInNZ/WfC7NZNzHymcmBEpheFc5ASbezzL9IGn6TpylDSOitUfaCtwo0Ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyxM7IsLq1iJsMCCwCJRSz3Os3O99YFfDZAaTPU19jSxaGukDs
	f9w9/SQv8ZVS2RhzIm0vArowJzHRmhqTEP/j6AxxmqSk/sFIznFauBkFWJ1HcF4K0qTQra9H0o9
	mDy+5INPurMNG/beVYBKPBEybhw==
X-Received: from plcm20.prod.google.com ([2002:a17:902:f214:b0:2bd:99a8:49c9])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32c4:b0:2ba:359a:9b8e with SMTP id d9443c01a7336-2bea3082845mr19952145ad.10.1779351914185;
 Thu, 21 May 2026 01:25:14 -0700 (PDT)
Date: Thu, 21 May 2026 08:25:12 +0000
In-Reply-To: <fc024071-2f82-412e-aea2-459d171b89f9@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <fc024071-2f82-412e-aea2-459d171b89f9@linux.intel.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521082512.1156320-1-joonwonkang@google.com>
Subject: Re: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: baolu.lu@linux.intel.com
Cc: Alexander.Grest@microsoft.com, alexander.shishkin@linux.intel.com, 
	amhetre@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	easwar.hariharan@linux.microsoft.com, hpa@zytor.com, iommu@lists.linux.dev, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, joonwonkang@google.com, 
	joro@8bytes.org, jpb@kernel.org, kas@kernel.org, kees@kernel.org, 
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nicolinc@nvidia.com, 
	peterz@infradead.org, praan@google.com, robin.murphy@arm.com, 
	ryasuoka@redhat.com, smostafa@google.com, sohil.mehta@intel.com, 
	tglx@kernel.org, will@kernel.org, x86@kernel.org, xin@zytor.com
Content-Type: text/plain; charset="UTF-8"

Hi Baolu, thanks for your review.

> On 5/20/26 23:07, Joonwon Kang wrote:
> > For SVA, the IOMMU core always allocates PASID from the global PASID
> > space. The use of this global PASID space comes from the limitation of
> > the ENQCMD instruction in Intel CPUs that it fetches its PASID operand
> > from IA32_PASID, which is per-process; when a process wants to
> > communicate with multiple devices with the ENQCMD instruction, it cannot
> > change its PASID for each device without the kernel's intervention. Also
> > note that ARM introduced a similar instruction, which is ST64BV0.
> > 
> > Due to this nature, SVA with ARM SMMU v3 has been found not working in
> > our environment when other modules/devices compete for PASID. The
> > environment looks as follows:
> > 
> > - The device is not a PCIe device.
> > - The device is to use SVA.
> > - The supported SSID/PASID space is very small for the device; only 1 to
> >    3 SSIDs are supported.
> > 
> > With this setup, when other modules have allocated all the PASIDs that
> > our device is expected to use from the global PASID space via APIs like
> > iommu_alloc_global_pasid() or iommu_sva_bind_device(), SVA binding to
> > our device fails due to the lack of available PASIDs.
> > 
> > This commit resolves the issue by allowing device driver to maintain its
> > own PASID space and assign a PASID from that for the process-device bond
> > via a new API called `iommu_sva_bind_device_pasid(dev, mm, pasid)`. Doing
> > that, however, will disallow the process to execute the ENQCMD-like
> > instructions at EL0. It is because the process cannot change its PASID in
> > IA32_PASID(or ACCDATA_EL1 on ARM) for each device without the kernel's
> > intervention. For this reason, calling `iommu_sva_bind_device()` and then
> > `iommu_sva_bind_device_pasid()` for the same process will not be allowed
> > and vice versa.
> > 
> > Currently, there is a limitation that a process simultaneously doing SVA
> > with multiple devices with different PASIDs is not supported. So, calling
> > `iommu_sva_bind_device_pasid()` multiple times for the same process with
> > different devices will not be allowed for now while that for
> > `iommu_sva_bind_device()` will be.
> > 
> > Another limitation is that a process cannot do `iommu_sva_bind_device()`
> > if it has ever done `iommu_sva_bind_device_pasid()` even though it has
> > been unbound after use.
> > 
> > Suggested-by: Jason Gunthorpe<jgg@ziepe.ca>
> > Suggested-by: Kevin Tian<kevin.tian@intel.com>
> > Signed-off-by: Joonwon Kang<joonwonkang@google.com>
> > ---
> > v2: Reuse iommu_mm->pasid after SVA bound by iommu_sva_bind_device_pasid()
> >      is unbound.
> > v1: Initial version.
> > 
> >   arch/x86/kernel/traps.c   |   9 +--
> >   drivers/iommu/iommu-sva.c | 151 +++++++++++++++++++++++++++++---------
> >   include/linux/iommu.h     |  14 +++-
> >   3 files changed, 134 insertions(+), 40 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 0ca3912ecb7f..0131c8e5fb10 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -857,13 +857,12 @@ static bool try_fixup_enqcmd_gp(void)
> >   		return false;
> >   
> >   	/*
> > -	 * If the mm has not been allocated a
> > -	 * PASID, the #GP can not be fixed up.
> > +	 * If the mm has not been allocated a PASID or ENQCMD has been
> > +	 * disallowed, the #GP can not be fixed up.
> >   	 */
> > -	if (!mm_valid_pasid(current->mm))
> > -		return false;
> > -
> >   	pasid = mm_get_enqcmd_pasid(current->mm);
> > +	if (pasid == IOMMU_PASID_INVALID)
> > +		return false;
> >   
> >   	/*
> >   	 * Did this thread already have its PASID activated?
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index bc7c7232a43e..a83333651ad0 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -10,6 +10,9 @@
> >   
> >   #include "iommu-priv.h"
> >   
> > +/* Whether pasid is to be allocated from the global PASID space */
> > +#define IOMMU_PASID_GLOBAL_ANY IOMMU_NO_PASID
> > +
> >   static DEFINE_MUTEX(iommu_sva_lock);
> >   static bool iommu_sva_present;
> >   static LIST_HEAD(iommu_sva_mms);
> > @@ -17,10 +20,11 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> >   						   struct mm_struct *mm);
> >   
> >   /* Allocate a PASID for the mm within range (inclusive) */
> > -static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct device *dev)
> > +static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm,
> > +						 struct device *dev,
> > +						 ioasid_t pasid)
> >   {
> >   	struct iommu_mm_data *iommu_mm;
> > -	ioasid_t pasid;
> >   
> >   	lockdep_assert_held(&iommu_sva_lock);
> >   
> > @@ -30,8 +34,27 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
> >   	iommu_mm = mm->iommu_mm;
> >   	/* Is a PASID already associated with this mm? */
> >   	if (iommu_mm) {
> > +		if ((pasid == IOMMU_PASID_GLOBAL_ANY && !iommu_mm->pasid_global) ||
> > +		    (pasid != IOMMU_PASID_GLOBAL_ANY && iommu_mm->pasid_global))
> > +			return ERR_PTR(-EBUSY);
> > +
> > +		if (!iommu_mm->pasid_global) {
> > +			if (list_empty(&iommu_mm->sva_domains))
> > +				iommu_mm->pasid = pasid;
> > +
> > +			if (pasid != iommu_mm->pasid) {
> > +				/*
> > +				 * Currently, a process simultaneously doing
> > +				 * SVA with multiple devices with different
> > +				 * PASIDs is not supported.
> > +				 */
> 
> I am a bit confused by the change in this helper and the comments above.
> 
> Currently, when an mm is bound to a device, it uses a PASID allocated
> from the global pool. That implies that all devices access the
> application's address space with the same PASID. Now we want to extend
> this by allowing the device driver to manage the PASID for SVA, which
> should mean different devices might use different PASIDs to access the
> application's address space. But this does not seem to match the logic
> in this helper.
> 
> Perhaps I overlooked something?
> 

I think your understanding is correct. In the long run, the limitations in the
comment and also in the commit message should be removed. I left the work to a
later patch as I am focusing on removing the main blocker first, which is that
a process is blocked by another irrelevant process for doing SVA as described
in the commit message. Currently, SVA for a process with different PASIDs will
only be allowed one after another, not simultaneously, and the current users of
`iommu_sva_bind_device()` should not be affected by this patch.

So, this patch should be enough to fix our current main problem. Can we leave
it to a later patch? or do you think we should remove the limitations now
although there is no requirement yet?

Thanks,
Joonwon Kang

> > +				return ERR_PTR(-ENOSPC);
> > +			}
> > +		}
> > +
> >   		if (iommu_mm->pasid >= dev->iommu->max_pasids)
> >   			return ERR_PTR(-EOVERFLOW);
> > +
> >   		return iommu_mm;
> >   	}
