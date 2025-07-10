Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AC7082F
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138013; cv=none; b=la50/lD9RCKQS//grSyzckxc9CSJpktn2kdhrLrmJEyy0uG4MQ5i5M6muPXY7YjRgEExST8YuHGkbh95gjRm1mLXEcQV6S/xqWoauRD0IuqmCCklsd0iKKgrAB9GRCZA9pmdEiybG7NkVM5Yu+1EvuNrL51PJ+ljrQ0HefINL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138013; c=relaxed/simple;
	bh=azE6g194Sp3EwFGULv9GiVZbc6nvv/cTqVreJEbI6XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpUCD5FcJRYZWqWNVXDDdmQFxiVWaLaH3kCHfJUS9Pobhm2KoX+ML+TpP+gfk2bLNHZsqPfF9jaVQUVm2yWB0VFU+3yc18jZCOAOuh4XwbsXMbDUWXhvn4bwGi6GkNVP3O5o4JuhPTXTxcuDH4YAi9G7kMlqBf6tC74aPyz4dqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jymwnTLE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jymwnTLE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e389599fso167325ad.0
        for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752138010; x=1752742810; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CpWQDOV2pRARA3/08/iwqsBk6ia5/MvAHcU+AS8k7fI=;
        b=jymwnTLEkKZLT5mLNN7ERLXA9PjVqGA0mvB2k8/g5BLBL+tkukD+A08it/BWr1yMiw
         Gqq6IjznMOOd7YxVfcLpFanJW03EejC1Fvdm1OFbIBE4TZDqGwe9lPLzb9OPCXtZ9vVl
         HM0PqlOtH4Zki4Kt+neZaMMD9OO4o/47nUxF+4UfF+eRz8CSDpokCjvFau1HAPPMnc5E
         V5MHXZHea2+Z+VEHOLewolGtx8TyeUehYfCkTvvPtGaGfhqrogd3Y5595LpYUqkeVpPp
         KJMgRSG1lG5S+XxTeMXEquWjH07VDl2eZ/AMVpfYfqpUWLSPjzj2AJP4CCB7S3oxON31
         sZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752138010; x=1752742810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpWQDOV2pRARA3/08/iwqsBk6ia5/MvAHcU+AS8k7fI=;
        b=rSf8R1/DRlT9bhdb6mjc9KrCa0N0S+zBTqIMSqXDZJ3pFBuH1iowCzQHRoVwDmuB44
         wckfTq2nkcMteNsmMLJXD7t9LEbd4LiI7mw/UBrg4XDEwR5afAlxx1rGAyjECCwyLhCO
         FRqGbAoCaUzDGDlS9yvKNMqFF1qaYJflpPpgKlXs9bJkeD3jQFA2rSx2iTiH7tmgJOi7
         v1xipoVuVo21sjbxy4mtkMPARVBTOZa3ZClhJEeXb+KJGpHxFydF9unY73qBbiXdNzpO
         mCnljxuAkxvTSx03BdrIHGT6oUVh67gvy+g8WGMLnu99DbFb2wDh5o8zdLapywFt4WKg
         3cSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVARGp/s6JRi4++AJMnJFS00JS1UGJCX1/2RX0NYMpDaAbTJmh2DFjF6TTjYqGL5/TekCrAfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3NEtWbLh72ZKFx4ot6541ZNfKB2+KDO3AwUS/KqpaAPURgbBV
	NhkuOGae/MKjyqkl9vyXNIaTUbrOYtpygBSLoQF4IxxvgPYXCsYNMVcsDWzMSHK5gQ==
X-Gm-Gg: ASbGncunzBx47guMj+NPRCiRuhjCwz60ZFftoUlPb97FrynosIfW/rhk4h4EltVnRkx
	vR/+MMrs2E1RVCaUrd1LcEpelSA1mzJCxDD11CwOBuBBJWpCxrB/U3SWPkOoVmmiY4EHJzca8CL
	GScUCJw7IP6471eehPJ+oWAVPCDlobwY7RbWUjBpdsUvRiEVYIDTQ9w/9phPlWeSBAjq4F+rr7V
	ophLvywWUjg8eQGUvvz52AhDEQN/+sNI/ykkqCDoDRX5K6/l13BStE0ipFUhkM+39oD+BAJSLbV
	6rzhuqazp2Zmgk5Tv9wBs0MXGV8IzCWy+0SPQoIWTT0+TQGzoRrwyz35lAfEgR4F0EoKpRFFme+
	IA8mrqpo+DrkPxYmbYl9m
X-Google-Smtp-Source: AGHT+IGHWQwo4XC6NVFwnlwjWECd6TemwjvyOszV3XjxmGjisy2BVSXmVN32wahUsDIdLlhR8bFsKw==
X-Received: by 2002:a17:903:258e:b0:216:4d90:47af with SMTP id d9443c01a7336-23de4389b80mr1454235ad.29.1752138010104;
        Thu, 10 Jul 2025 02:00:10 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f9c0b2sm1578955b3a.179.2025.07.10.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:00:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 08:59:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce
 pm_runtime_get_if_not_suspended()
Message-ID: <aG-BC6B4R1ViEDM1@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-6-praan@google.com>
 <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
 <aG6P6F-MEvL4SfNz@google.com>
 <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
 <aG6hpoMx1QwwP195@google.com>
 <CAJZ5v0jyYpu=qA-_QKVoNhzRZRNKe5cFt718fo6pxR6iRkD2bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jyYpu=qA-_QKVoNhzRZRNKe5cFt718fo6pxR6iRkD2bw@mail.gmail.com>

On Wed, Jul 09, 2025 at 09:37:58PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 9, 2025 at 7:06 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Jul 09, 2025 at 06:35:41PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jul 9, 2025 at 5:51 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > On Wed, Jul 09, 2025 at 08:44:06AM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Jun 16, 2025 at 10:32 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > >
> > > > > > The existing opportunistic helpers like pm_runtime_get_if_active() and
> > > > > > pm_runtime_get_if_in_use(), are too strict for certain use cases. They
> > > > > > fail if the device is in a transient state like RPM_SUSPENDING, which
> > > > > > can lead to drivers making incorrect assumptions about the dev's state.
> > > > > >
> > > > > > These helpers don't suffice for cases where one wishes to elide HW clean
> > > > > > up like queue flushes or TLB invalidations if the device is powered off.
> > > > > > It is wasteful to wake up the device in cases where the resume callback
> > > > > > resets the device well OR if the HW resets in a clean state. Thus, if a
> > > > >ppy to hear your feedback or any alternative ideas you might have > device is powered off, it is preferred to elide any clean-up HW ops like
> > > > > > queue flushes / TLB invalidations when the device will resume afresh.
> > > > > >
> > > > > > Consider the following sequence of operations:
> > > > > >
> > > > > > 1. The device is in `RPM_SUSPENDING` state
> > > > > > 2. The driver calls pm_runtime_get_if_active/in_use
> > > > > > 3. Depending on these API, the driver elides a HW clean-up op like:
> > > > > >
> > > > > > if (pm_runtime_get_if_in_active(dev))
> > > > > >         invalidate_tlb(dev);
> > > > > > else
> > > > > >         // Skip flush, assuming device will fully suspend
> > > > > >
> > > > > > 4. Now, another rpm dev-linked device wakes up, causing the device's
> > > > > >    state to bounce from RPM_SUSPENDING to RPM_ACTIVE without invoking
> > > > > >    any rpm callbacks, preventing them from resetting the dev correctly.
> > > > >
> > > > > This never happens.
> > > > >
> > > > > If the status is RPM_SUSPENDING, the runtime suspend callback will be invoked.
> > > >
> > > > Ack, I believe we're talking about the check[1] in rpm_resume here:
> > >
> > > No, I'm talking about the fact that the status is changed to
> > > RPM_SUSPENDING right before invoking the callback.
> > >
> >
> > Right, but if the callback returns -EAGAIN or something, in
> > rpm_suspend() we go ahead and set the status to RPM_ACTIVE again
> > on jumping to the `fail` label[1].
> >
> > > >         if (dev->power.runtime_status == RPM_RESUMING ||
> > > >             dev->power.runtime_status == RPM_SUSPENDING) {
> > > >
> > > >             [...]
> > > >             /* Wait for the operation carried out in parallel with us. */
> > > >             [...]
> > > >             finish_wait(&dev->power.wait_queue, &wait);
> > > >             goto repeat;
> > > >
> > > > However, my worry is about the following situation:
> > > >
> > > >   rpm_suspend                      rpm_resume
> > > >
> > > >   rpm_status = RPM_SUSPENDING
> > > >                                    if (RPM_SUSPENDING)
> > > >                                    prepare_to wait(...)
> > > >
> > > >   // suspend fails
> > > >   retval = rpm_callback(...);
> > >
> > > You're talking about the callback returning an error and your
> > > changelog is talking about a different situation.
> >
> > Apologies, I should've been more clear. What I meant was for a situation
> > where due to *any* reason (except disabling runtime PM) we bounce back
> > from RPM_SUSPENDING to RPM_ACTIVE *without* invoking the resume callback
> 
> This only can happen if the suspend callback returns an error, but I'm
> not sure why and how this matters.
> 
> pm_runtime_get_if_active() does not guarantee anything in the case
> when 0 is returned anyway.
> 
> > > >   goto fail;
> > > >   [...]
> > > > fail:
> > > >   rpm_status = RPM_ACTIVE;
> > > >                                    finish_wait(...);
> > > >                                    goto repeat;
> > > >                                    repeat:
> > > >                                    if (rpm_status == RPM_ACTIVE) {
> > > >                                         retval = 1;
> > > >                                         goto out;
> > > >                                    }
> > > >                                 out:
> > > >                                    [ ... ] // put_parent if one
> > > >
> > > >                                    // we return without resume cb();
> > > >                                    return retval;
> > > >
> > > > Now, if we rely on APIs based on pm_runtime_get_conditional(), which
> > > > might return 0 if (dev->power.runtime_status != RPM_ACTIVE), we might
> > > > end up eliding some TLB invalidations in the period where the status was
> > > > RPM_SUSPENDING till it's back to RPM_ACTIVE due to a failed suspend.
> > >
> > > It actually depends on the reason why the callback returned an error.
> > >
> >
> > I'm not sure if I follow.. as per rpm_suspend[1] I see that upon failing
> > (which also happens on getting a non-zero retval from the suspend_cb) we
> > set the runtime status to RPM_ACTIVE.
> 
> Yes, it just goes back to the status from before the failure because
> when the error code is -EAGAIN or -EBUSY, the status should be still
> RPM_ACTIVE and otherwise runtime_error is set and the device likely
> requires some help.
> 
> > > > This can cause some severe address-aliasing/ghost hit issues since the
> > > > TLB still has some stale entries..
> > >
> > > I'm not quite sure what you mean.
> > >
> >
> > I meant if the TLB invalidations were elided (i.e. TLB still had stale
> > entries) in hope that the IOMMU would be suspended, but due to some
> > reason the suspend failed and the status gets back to RPM_ACTIVE while
> > exiting the rpm_suspend call and a client wakes up and performs a DMA
> > (IOMMU transaction), the TLB entry might hit for an address which was
> > supposed to be invalidated by now.
> 
> So as I said this is just one reason why you cannot rely on runtime PM
> to guarantee that the device will remain suspended, or in fact whether
> or not it will be suspended at all.
> 
> > > > Instead, we'd like to ensure that the status IS suspended
> > >
> > > But you can't.
> > >
> > > That's the difference between RPM_ACTIVE and RPM_SUSPENDED.  If you
> > > bump up the runtime PM usage counter while the device is RPM_ACTIVE
> > > (and while holding its power.spinlock), it will not suspend.  There's
> > > no way to prevent a suspended device from resuming (other than
> > > disabling runtime PM for it).
> > >
> >
> > The problem is avoiding bumping up the count while the device is in a
> > transient state like RPM_SUSPENDING and then bouncing back to the
> > RPM_ACTIVE state without invoking RPM resume callback, which seems to be
> > possible as per the rpm_suspend implementation [1].
> 
> I'm not sure what you mean here.
> 
> The usage counter is bumped up by pm_runtime_get_if_active() only if
> the device is RPM_ACTIVE in which case it will guarantee that the
> runtime PM status will not change.  There is no way to provide a
> similar guarantee on the RPM_SUSPENDED side short of disabling runtime
> PM.
> 
> > > > to make a decision to elide the TLBI or not.
> > > >
> > > > What are your thoughts on this? I'm open to approaching it differently.
> > >
> > > IMV this is all misguided, sorry.
> > >
> >
> > Ack. But I'd want to understand better here. Are you saying that it
> > isn't at all possible that RPM_SUSPENDING bounces back to RPM_ACTIVE
> > without invoking the rpm_resume ever? Because per the following snippet,
> > it seems likely:
> >
> >         __update_runtime_status(dev, RPM_SUSPENDING);
> >
> >         callback = RPM_GET_CALLBACK(dev, runtime_suspend);
> >
> >         dev_pm_enable_wake_irq_check(dev, true);
> >         retval = rpm_callback(callback, dev);
> >         if (retval)
> >                 goto fail;
> >
> >         [...]
> >
> > fail:
> >         dev_pm_disable_wake_irq_check(dev, true);
> >         __update_runtime_status(dev, RPM_ACTIVE);
> >         dev->power.deferred_resume = false;
> >         wake_up_all(&dev->power.wait_queue);
> >         [...]
> >
> > Sorry if I'm missing something here, but it does look like we can bounce
> > back to RPM_ACTIVE without invoking the resume callback, which is a
> > behaviour we'd like to avoid.
> 
> So let me repeat: This only happens if the suspend callback returns an
> error and in that case it is not clear whether or not the resume
> callback needs to be invoked (either it doesn't or the device can be
> assumed to be in a state in which invoking that callback will not help
> either way).
> 

Alright. My goal here is to ensure that TLB invalidations are elided
only when the device (IOMMU) is suspended. For that I believed we 
could do either of the following:

1. Ensure RPM_SUSPENDING -> RPM_ACTIVE transition *always* invokes the
resume callback (this is because the resume cb flushes the entire TLB).

2. Ensure that we are able to reliably *get* a PM ref if the device is
NOT suspended, i.e. even if it was in a transient state.

But I guess that maybe the new API (option 2) isn't the right way to go.

I'm assuming you mean that if we design the suspend callback in a way
that it doesn't return error, we can reliably ensure that the resume
callback will be called before transitioning to the RPM_ACTIVE state? 

[...]

Thanks,
Praan
