Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C6221287
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080816; cv=none; b=tTdrPIts8dkhXzFisZeJBtu1RbfH5ybNll7gf7mBFhmzKwNNBVrJ2lOXMOLYX5rlWbssrVWmHenWdtPp40K21tq458TH7aQu52uHSkBjvFTDaWajGrIisxywsdHHOI8hVcURGB70e9HMBB5YqWO46Rgofk6pr0bv+q41uo0iSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080816; c=relaxed/simple;
	bh=txOfErDUFYiZR8QxFVt9GIyV76r4ZHg8iY5adfo6AaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRXVGUQvW5zr4Ec0YaVmoxqq7qryLyNe4kgPM2qHTBX/3QB45iDNWMDdS+vOjYqp56Ox3+dSSYHxuTHkSKbXyZtviIva9kagrrs45bVjJq1/Xt5ClZ6iUCZPebQk8OwHziSP36LgT8gwoRjXrE/B7W367hqmFAW8/gTkZTfMtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlHrB5D0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlHrB5D0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237f18108d2so10185ad.0
        for <iommu@lists.linux.dev>; Wed, 09 Jul 2025 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752080814; x=1752685614; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wNQL2qfZFq/pC9E2XsaOz0UaH/2iNhGanc2vyyVvb8k=;
        b=vlHrB5D0YjzXwKNTBONQVtiTZP1NtMoXUXuIAc7bXqufluCyhBnNk33Zg42dwY7Dez
         5xVc6u3VdttH4b256I8AAQZ0UNeV2qc7F0drSanzfrD+JiNehj9sWVywqG+nToelNgHf
         AYRBaPdowjliGL8IA2saZeym3f1iPsVz8cwcL/sFq2Czi+vKAP4XyYR8wcxG/vyucBIq
         pqD2e0zMNhaSUQl/ULl7YV1Qi8SSzFlczb0701JNslEJsqMfbWORYx5s/ckHHXyC865g
         f8zfJoBTQ+MVTZ0ML3R8iSMfew6qnHF16yyC5MDvH2MXcV5cveQkqJN9cP5tVZx3uUda
         3xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752080814; x=1752685614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNQL2qfZFq/pC9E2XsaOz0UaH/2iNhGanc2vyyVvb8k=;
        b=Wtlqv2O8BZzfoEJUxfTmshsPJljfe5brodv0bRWqMi8r4Asli2PIXIWFR37KxhIiw5
         Yl+wegqHP7ZWeMizL78iizd/aicLRedvIiavNUL1uSqgN5jX0KOt3jwhJiyXr05OUC0t
         b/dehlJcTiFoWFBTv5LTv1lRH/IU2DEgXrN7mKGjqBHDmDLx8b6op35wR24rqltb5T2E
         HVsfa9X/EEFwXWlypqcOuSuyYOWFeLZMCrq54GF/+vSJOvWlGa6cY6uSps/7xFVdDTL9
         CWna5Cjiv59/73emiQ3qrbDYcnZBhf0aTxyGa+unK6eMIkweDEnH7oWTiqkJWroNMkqq
         KLZw==
X-Forwarded-Encrypted: i=1; AJvYcCVSVyWQVPKZubsW0KTSs4qjR4aNLXPU8H5OGHxixPdbr0ebQto9FxEb4a/VyTOs1Fgu46fO7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrMxABMEHFFDr/GsiAcpH3Xo/RSTB66FcE+uSES8vXBWDXGLt9
	r3VBbCUfgUBF+r2Yd4b07guep2ZN2NfnrYq+5X5OdLD5zbIi5zP73Iy+vL6PHgpohQ==
X-Gm-Gg: ASbGncsfO7Fi8qPqPFwb1Me2d/+uefUEXUsHTK2PHnddG+Q9V28ttM4hTl19O7vcAPy
	bnBhx1WOeD4oZgN/TAwAsHfljIVKKoVlzJw/8M7eQRcIqLfHk1lJTT5QoQAhLgN/LoOR5jrYobo
	8qCn/UMU/RpfP9faVj/QasveDff4DBN3XIMTbg5FlqmGtXHsYOY8MYvGxBd14Sl/BUrlS1snw3o
	7EHY71WDbfDKfGlntPY1pq7rbUjTuJcB3BsAmDi/SoSxsjfnTVUeA9fUu6nah4WhptiACFpfXLb
	TMIbEWl7TXDy0IyIB99mcennOwyF1aAtj49IJ2PO6WnO1Mey2LD7KQJMR6trR8B+rrqt34aG2t6
	fYzXscH5ddDwvnd/j+8Fv5Zb0p66YuaU=
X-Google-Smtp-Source: AGHT+IFYqxm0okir5DcYIiv9kjCiMptlDQEWMDkrgKJbHiHwbvGeKM8qt2/tzx12KiP/i6eDpeHbYQ==
X-Received: by 2002:a17:902:ce0e:b0:23c:8f12:7c4b with SMTP id d9443c01a7336-23dda3a6da1mr3743945ad.10.1752080812473;
        Wed, 09 Jul 2025 10:06:52 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84592ef4sm152601735ad.191.2025.07.09.10.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:06:52 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:06:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce
 pm_runtime_get_if_not_suspended()
Message-ID: <aG6hpoMx1QwwP195@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-6-praan@google.com>
 <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
 <aG6P6F-MEvL4SfNz@google.com>
 <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>

On Wed, Jul 09, 2025 at 06:35:41PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 9, 2025 at 5:51 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Jul 09, 2025 at 08:44:06AM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jun 16, 2025 at 10:32 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > The existing opportunistic helpers like pm_runtime_get_if_active() and
> > > > pm_runtime_get_if_in_use(), are too strict for certain use cases. They
> > > > fail if the device is in a transient state like RPM_SUSPENDING, which
> > > > can lead to drivers making incorrect assumptions about the dev's state.
> > > >
> > > > These helpers don't suffice for cases where one wishes to elide HW clean
> > > > up like queue flushes or TLB invalidations if the device is powered off.
> > > > It is wasteful to wake up the device in cases where the resume callback
> > > > resets the device well OR if the HW resets in a clean state. Thus, if a
> > >ppy to hear your feedback or any alternative ideas you might have > device is powered off, it is preferred to elide any clean-up HW ops like
> > > > queue flushes / TLB invalidations when the device will resume afresh.
> > > >
> > > > Consider the following sequence of operations:
> > > >
> > > > 1. The device is in `RPM_SUSPENDING` state
> > > > 2. The driver calls pm_runtime_get_if_active/in_use
> > > > 3. Depending on these API, the driver elides a HW clean-up op like:
> > > >
> > > > if (pm_runtime_get_if_in_active(dev))
> > > >         invalidate_tlb(dev);
> > > > else
> > > >         // Skip flush, assuming device will fully suspend
> > > >
> > > > 4. Now, another rpm dev-linked device wakes up, causing the device's
> > > >    state to bounce from RPM_SUSPENDING to RPM_ACTIVE without invoking
> > > >    any rpm callbacks, preventing them from resetting the dev correctly.
> > >
> > > This never happens.
> > >
> > > If the status is RPM_SUSPENDING, the runtime suspend callback will be invoked.
> >
> > Ack, I believe we're talking about the check[1] in rpm_resume here:
> 
> No, I'm talking about the fact that the status is changed to
> RPM_SUSPENDING right before invoking the callback.
> 

Right, but if the callback returns -EAGAIN or something, in
rpm_suspend() we go ahead and set the status to RPM_ACTIVE again
on jumping to the `fail` label[1].

> >         if (dev->power.runtime_status == RPM_RESUMING ||
> >             dev->power.runtime_status == RPM_SUSPENDING) {
> >
> >             [...]
> >             /* Wait for the operation carried out in parallel with us. */
> >             [...]
> >             finish_wait(&dev->power.wait_queue, &wait);
> >             goto repeat;
> >
> > However, my worry is about the following situation:
> >
> >   rpm_suspend                      rpm_resume
> >
> >   rpm_status = RPM_SUSPENDING
> >                                    if (RPM_SUSPENDING)
> >                                    prepare_to wait(...)
> >
> >   // suspend fails
> >   retval = rpm_callback(...);
> 
> You're talking about the callback returning an error and your
> changelog is talking about a different situation.
> 

Apologies, I should've been more clear. What I meant was for a situation
where due to *any* reason (except disabling runtime PM) we bounce back
from RPM_SUSPENDING to RPM_ACTIVE *without* invoking the resume callback

> >   goto fail;
> >   [...]
> > fail:
> >   rpm_status = RPM_ACTIVE;
> >                                    finish_wait(...);
> >                                    goto repeat;
> >                                    repeat:
> >                                    if (rpm_status == RPM_ACTIVE) {
> >                                         retval = 1;
> >                                         goto out;
> >                                    }
> >                                 out:
> >                                    [ ... ] // put_parent if one
> >
> >                                    // we return without resume cb();
> >                                    return retval;
> >
> > Now, if we rely on APIs based on pm_runtime_get_conditional(), which
> > might return 0 if (dev->power.runtime_status != RPM_ACTIVE), we might
> > end up eliding some TLB invalidations in the period where the status was
> > RPM_SUSPENDING till it's back to RPM_ACTIVE due to a failed suspend.
> 
> It actually depends on the reason why the callback returned an error.
> 

I'm not sure if I follow.. as per rpm_suspend[1] I see that upon failing
(which also happens on getting a non-zero retval from the suspend_cb) we
set the runtime status to RPM_ACTIVE.

> > This can cause some severe address-aliasing/ghost hit issues since the
> > TLB still has some stale entries..
> 
> I'm not quite sure what you mean.
> 

I meant if the TLB invalidations were elided (i.e. TLB still had stale
entries) in hope that the IOMMU would be suspended, but due to some
reason the suspend failed and the status gets back to RPM_ACTIVE while
exiting the rpm_suspend call and a client wakes up and performs a DMA
(IOMMU transaction), the TLB entry might hit for an address which was
supposed to be invalidated by now.

> > Instead, we'd like to ensure that the status IS suspended
> 
> But you can't.
> 
> That's the difference between RPM_ACTIVE and RPM_SUSPENDED.  If you
> bump up the runtime PM usage counter while the device is RPM_ACTIVE
> (and while holding its power.spinlock), it will not suspend.  There's
> no way to prevent a suspended device from resuming (other than
> disabling runtime PM for it).
> 

The problem is avoiding bumping up the count while the device is in a
transient state like RPM_SUSPENDING and then bouncing back to the
RPM_ACTIVE state without invoking RPM resume callback, which seems to be
possible as per the rpm_suspend implementation [1].

> > to make a decision to elide the TLBI or not.
> >
> > What are your thoughts on this? I'm open to approaching it differently.
> 
> IMV this is all misguided, sorry.
> 

Ack. But I'd want to understand better here. Are you saying that it
isn't at all possible that RPM_SUSPENDING bounces back to RPM_ACTIVE
without invoking the rpm_resume ever? Because per the following snippet,
it seems likely:

	__update_runtime_status(dev, RPM_SUSPENDING);

	callback = RPM_GET_CALLBACK(dev, runtime_suspend);

	dev_pm_enable_wake_irq_check(dev, true);
	retval = rpm_callback(callback, dev);
	if (retval)
		goto fail;

	[...]

fail:
	dev_pm_disable_wake_irq_check(dev, true);
	__update_runtime_status(dev, RPM_ACTIVE);
	dev->power.deferred_resume = false;
	wake_up_all(&dev->power.wait_queue);
	[...]

Sorry if I'm missing something here, but it does look like we can bounce
back to RPM_ACTIVE without invoking the resume callback, which is a
behaviour we'd like to avoid.

> > Happy to hear your feedback or any alternative ideas you might have
> 
> Disable runtime PM for the device and check its runtime PM status,
> which cannot be transient at that point.  If it is RPM_ACTIVE, you
> need to flush the TLB.
> 

I see... let me see how or if we can safely do that.. we might be in
interrupt context while flushing the TLBs..

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/base/power/runtime.c#L678 
