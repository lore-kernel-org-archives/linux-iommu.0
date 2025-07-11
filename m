Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41929279DC3
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229265; cv=none; b=NpXRY4b9uQpQLo8vbjJ5zlPiaZ33tKpTGMfyptT0152CGg0mT3U2PLRNhm+L1VINYXp2gv/uCs2TMgJ5MyFHGwYAAojAJPRW1WaYEP6cXHk71CBlyX3IMzomnbvY7U84RjA4cIxJE2U8oVbXQvF5Xvf2IovjK538bv1KVqetGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229265; c=relaxed/simple;
	bh=owJtDD/FyAPTqCpYFYXYvzqf+Z0Z3Hsk8xVZqIW1dcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCPNqilXUDPR6mr1z5xaplScWwE4Luye6layIAN3vJoTj/Ax7xh6kKWumzFVZLx3bUVIQsce4zuxMZgbqk0VPsbqsUAfVzoXPm6PlhxXPL70ymKhFGC777zHgLa9fMd71hi/Z3ANgTGICTW01CCl9ufS8Va79Jvswo5HgVjCvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cq+wGplc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cq+wGplc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e389599fso162945ad.0
        for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752229262; x=1752834062; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fP/EGZ03r61XETpjEOs6qbzkBgSDdbGbAWkQ7TWR7HU=;
        b=cq+wGplcfqmZ6DistcmkbZUDC8W8pmtU9tyuk5KLQv+ztfmu0y5WDmmq7cVy+e1/Xr
         isUNYb2eyY/t6DvwPU5cij+5LpIx9YK8oYg7nWSQ683sJ6z//bDybhmIXDgExoFAnPHf
         kAZJeISgZGnoIJpY9gtDfPDuWPDiW4KYioEKnoVWhj1sZNuyR48CHeYWNC+Ao91FN2cu
         ZDv4sB/IikxTHobEQyZFehlYw35NWfYyEAs4sPoYXWS0zvwOOG9QqleRg7TYz8OlaLvr
         yl9xWmkwYibHW3fSVw8FKjFaY+3CNZJtG7K4EaOKVcEbbdeKqG9pxGKZdUuRVV5UxKFz
         4Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229262; x=1752834062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fP/EGZ03r61XETpjEOs6qbzkBgSDdbGbAWkQ7TWR7HU=;
        b=Di/S5Pzm6+qCFfQ+1eCTJW7VygzBI2nB78TijWoscdPYNMEiwbveZGfzt590C9Jukk
         qhkQwANRb3Q5dhG8GLBODRLoDjYmvh5EJViTyrQiq73eU6DC+9x7Zt9+xBYiua7ZQOea
         sPVwnTOXY/3dOI93i4A3GTbz/x0HQNSiIprwwNseplz3IFUMtGz3yd47FEwfrVpoJSrR
         otWfkdEyqKhoGLzJwII2XXkHEwdOUBg5Qep1kxD/9T7owc8t9lf3cfMVk8NLDs52hWqp
         EchaNSdMHjNtapU6sgQgCD9pPaiSdFwKiNOqJhVLP/kECJsBL1aJsrFxKL0OqxX7UWR7
         uA6A==
X-Forwarded-Encrypted: i=1; AJvYcCUKjC16aM3QoIEQtr70XeP0M/49wtAYZnZysj+iNbgXsfnagDtMpv4w8wix5QG83xexqjUJ0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmYRXSYQCBbWsPhWZ+VnSiSTP8Qc56ETAdkaGbDWklRZEFuF6D
	CoHciN49kdxb22EK+JFXpRdUaDs/UpSG0dXVAePuLSw16Safz2/NskbcEdEoXCL81A==
X-Gm-Gg: ASbGncvCPBPSDva47BCSrAWoXd0fJDJwDtRSFrGCy7y7HJNc59gn59KxhZWpBlocYWR
	QnBd1VRcKYsFFL9aIttWv6x0q24cEF9BgfmB8lDCSAzp4OixH7d2DPOrLVwfUw3gNhsZmHi7gI9
	S6GZ/G3VJwp/5hTmXhqKQ7+SAR1IA4528XKaHI/WZacwQiII3QRudZLRKMWs1yY+RtmhUJUu7fs
	4yuHnjRqE77wT3/wchSViII7fwP4H8+oRt5q+jcSiU0Ci/JXN9uL5muFOXN2gQKzDRXuLWnp1jF
	r3go+lxRPMboT/TNFtTG3bysweRGq9HpYciSCV3DlKG+V+8QiIv1G+26b65qu36B3kVs5kGFt3w
	ZYFsSIpN2o4X7r/GzmvbYjDCoB10HButvBwUEwmQG7isfMhCkgKfV4BZ9
X-Google-Smtp-Source: AGHT+IFbRDCXoyVYxdX+0qYTc7psf7n57BMUAC3UF7UtBvtIkI/frVvkeGl3mZOOOFLSCgjJUeadeg==
X-Received: by 2002:a17:902:cec1:b0:234:1073:5b85 with SMTP id d9443c01a7336-23def5afa5cmr2078965ad.1.1752229262105;
        Fri, 11 Jul 2025 03:21:02 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4148f6esm43640485ad.0.2025.07.11.03.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:21:01 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:20:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce
 pm_runtime_get_if_not_suspended()
Message-ID: <aHDlhyPmjCT7rz-i@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-6-praan@google.com>
 <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
 <aG6P6F-MEvL4SfNz@google.com>
 <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
 <aG6hpoMx1QwwP195@google.com>
 <CAJZ5v0jyYpu=qA-_QKVoNhzRZRNKe5cFt718fo6pxR6iRkD2bw@mail.gmail.com>
 <aG-BC6B4R1ViEDM1@google.com>
 <CAJZ5v0id-sRxVxupWPKPGikSm5_QeO_WKgYdK2BUbY4m7dbndw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0id-sRxVxupWPKPGikSm5_QeO_WKgYdK2BUbY4m7dbndw@mail.gmail.com>

On Thu, Jul 10, 2025 at 12:29:03PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 10, 2025 at 11:00 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Jul 09, 2025 at 09:37:58PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jul 9, 2025 at 7:06 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > On Wed, Jul 09, 2025 at 06:35:41PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, Jul 9, 2025 at 5:51 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 09, 2025 at 08:44:06AM +0200, Rafael J. Wysocki wrote:
> > > > > > > On Mon, Jun 16, 2025 at 10:32 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > > > >
> > > > > > > > The existing opportunistic helpers like pm_runtime_get_if_active() and
> > > > > > > > pm_runtime_get_if_in_use(), are too strict for certain use cases. They
> > > > > > > > fail if the device is in a transient state like RPM_SUSPENDING, which
> > > > > > > > can lead to drivers making incorrect assumptions about the dev's state.
> > > > > > > >
> > > > > > > > These helpers don't suffice for cases where one wishes to elide HW clean
> > > > > > > > up like queue flushes or TLB invalidations if the device is powered off.
> > > > > > > > It is wasteful to wake up the device in cases where the resume callback
> > > > > > > > resets the device well OR if the HW resets in a clean state. Thus, if a
> > > > > > >ppy to hear your feedback or any alternative ideas you might have > device is powered off, it is preferred to elide any clean-up HW ops like
> > > > > > > > queue flushes / TLB invalidations when the device will resume afresh.
> > > > > > > >
> > > > > > > > Consider the following sequence of operations:
> > > > > > > >
> > > > > > > > 1. The device is in `RPM_SUSPENDING` state
> > > > > > > > 2. The driver calls pm_runtime_get_if_active/in_use
> > > > > > > > 3. Depending on these API, the driver elides a HW clean-up op like:
> > > > > > > >
> > > > > > > > if (pm_runtime_get_if_in_active(dev))
> > > > > > > >         invalidate_tlb(dev);
> > > > > > > > else
> > > > > > > >         // Skip flush, assuming device will fully suspend
> > > > > > > >
> > > > > > > > 4. Now, another rpm dev-linked device wakes up, causing the device's
> > > > > > > >    state to bounce from RPM_SUSPENDING to RPM_ACTIVE without invoking
> > > > > > > >    any rpm callbacks, preventing them from resetting the dev correctly.
> > > > > > >
> > > > > > > This never happens.
> > > > > > >
> > > > > > > If the status is RPM_SUSPENDING, the runtime suspend callback will be invoked.
> > > > > >
> > > > > > Ack, I believe we're talking about the check[1] in rpm_resume here:
> > > > >
> > > > > No, I'm talking about the fact that the status is changed to
> > > > > RPM_SUSPENDING right before invoking the callback.
> > > > >
> > > >
> > > > Right, but if the callback returns -EAGAIN or something, in
> > > > rpm_suspend() we go ahead and set the status to RPM_ACTIVE again
> > > > on jumping to the `fail` label[1].
> > > >
> > > > > >         if (dev->power.runtime_status == RPM_RESUMING ||
> > > > > >             dev->power.runtime_status == RPM_SUSPENDING) {
> > > > > >
> > > > > >             [...]
> > > > > >             /* Wait for the operation carried out in parallel with us. */
> > > > > >             [...]
> > > > > >             finish_wait(&dev->power.wait_queue, &wait);
> > > > > >             goto repeat;
> > > > > >
> > > > > > However, my worry is about the following situation:
> > > > > >
> > > > > >   rpm_suspend                      rpm_resume
> > > > > >
> > > > > >   rpm_status = RPM_SUSPENDING
> > > > > >                                    if (RPM_SUSPENDING)
> > > > > >                                    prepare_to wait(...)
> > > > > >
> > > > > >   // suspend fails
> > > > > >   retval = rpm_callback(...);
> > > > >
> > > > > You're talking about the callback returning an error and your
> > > > > changelog is talking about a different situation.
> > > >
> > > > Apologies, I should've been more clear. What I meant was for a situation
> > > > where due to *any* reason (except disabling runtime PM) we bounce back
> > > > from RPM_SUSPENDING to RPM_ACTIVE *without* invoking the resume callback
> > >
> > > This only can happen if the suspend callback returns an error, but I'm
> > > not sure why and how this matters.
> > >
> > > pm_runtime_get_if_active() does not guarantee anything in the case
> > > when 0 is returned anyway.
> > >
> > > > > >   goto fail;
> > > > > >   [...]
> > > > > > fail:
> > > > > >   rpm_status = RPM_ACTIVE;
> > > > > >                                    finish_wait(...);
> > > > > >                                    goto repeat;
> > > > > >                                    repeat:
> > > > > >                                    if (rpm_status == RPM_ACTIVE) {
> > > > > >                                         retval = 1;
> > > > > >                                         goto out;
> > > > > >                                    }
> > > > > >                                 out:
> > > > > >                                    [ ... ] // put_parent if one
> > > > > >
> > > > > >                                    // we return without resume cb();
> > > > > >                                    return retval;
> > > > > >
> > > > > > Now, if we rely on APIs based on pm_runtime_get_conditional(), which
> > > > > > might return 0 if (dev->power.runtime_status != RPM_ACTIVE), we might
> > > > > > end up eliding some TLB invalidations in the period where the status was
> > > > > > RPM_SUSPENDING till it's back to RPM_ACTIVE due to a failed suspend.
> > > > >
> > > > > It actually depends on the reason why the callback returned an error.
> > > > >
> > > >
> > > > I'm not sure if I follow.. as per rpm_suspend[1] I see that upon failing
> > > > (which also happens on getting a non-zero retval from the suspend_cb) we
> > > > set the runtime status to RPM_ACTIVE.
> > >
> > > Yes, it just goes back to the status from before the failure because
> > > when the error code is -EAGAIN or -EBUSY, the status should be still
> > > RPM_ACTIVE and otherwise runtime_error is set and the device likely
> > > requires some help.
> > >
> > > > > > This can cause some severe address-aliasing/ghost hit issues since the
> > > > > > TLB still has some stale entries..
> > > > >
> > > > > I'm not quite sure what you mean.
> > > > >
> > > >
> > > > I meant if the TLB invalidations were elided (i.e. TLB still had stale
> > > > entries) in hope that the IOMMU would be suspended, but due to some
> > > > reason the suspend failed and the status gets back to RPM_ACTIVE while
> > > > exiting the rpm_suspend call and a client wakes up and performs a DMA
> > > > (IOMMU transaction), the TLB entry might hit for an address which was
> > > > supposed to be invalidated by now.
> > >
> > > So as I said this is just one reason why you cannot rely on runtime PM
> > > to guarantee that the device will remain suspended, or in fact whether
> > > or not it will be suspended at all.
> > >
> > > > > > Instead, we'd like to ensure that the status IS suspended
> > > > >
> > > > > But you can't.
> > > > >
> > > > > That's the difference between RPM_ACTIVE and RPM_SUSPENDED.  If you
> > > > > bump up the runtime PM usage counter while the device is RPM_ACTIVE
> > > > > (and while holding its power.spinlock), it will not suspend.  There's
> > > > > no way to prevent a suspended device from resuming (other than
> > > > > disabling runtime PM for it).
> > > > >
> > > >
> > > > The problem is avoiding bumping up the count while the device is in a
> > > > transient state like RPM_SUSPENDING and then bouncing back to the
> > > > RPM_ACTIVE state without invoking RPM resume callback, which seems to be
> > > > possible as per the rpm_suspend implementation [1].
> > >
> > > I'm not sure what you mean here.
> > >
> > > The usage counter is bumped up by pm_runtime_get_if_active() only if
> > > the device is RPM_ACTIVE in which case it will guarantee that the
> > > runtime PM status will not change.  There is no way to provide a
> > > similar guarantee on the RPM_SUSPENDED side short of disabling runtime
> > > PM.
> > >
> > > > > > to make a decision to elide the TLBI or not.
> > > > > >
> > > > > > What are your thoughts on this? I'm open to approaching it differently.
> > > > >
> > > > > IMV this is all misguided, sorry.
> > > > >
> > > >
> > > > Ack. But I'd want to understand better here. Are you saying that it
> > > > isn't at all possible that RPM_SUSPENDING bounces back to RPM_ACTIVE
> > > > without invoking the rpm_resume ever? Because per the following snippet,
> > > > it seems likely:
> > > >
> > > >         __update_runtime_status(dev, RPM_SUSPENDING);
> > > >
> > > >         callback = RPM_GET_CALLBACK(dev, runtime_suspend);
> > > >
> > > >         dev_pm_enable_wake_irq_check(dev, true);
> > > >         retval = rpm_callback(callback, dev);
> > > >         if (retval)
> > > >                 goto fail;
> > > >
> > > >         [...]
> > > >
> > > > fail:
> > > >         dev_pm_disable_wake_irq_check(dev, true);
> > > >         __update_runtime_status(dev, RPM_ACTIVE);
> > > >         dev->power.deferred_resume = false;
> > > >         wake_up_all(&dev->power.wait_queue);
> > > >         [...]
> > > >
> > > > Sorry if I'm missing something here, but it does look like we can bounce
> > > > back to RPM_ACTIVE without invoking the resume callback, which is a
> > > > behaviour we'd like to avoid.
> > >
> > > So let me repeat: This only happens if the suspend callback returns an
> > > error and in that case it is not clear whether or not the resume
> > > callback needs to be invoked (either it doesn't or the device can be
> > > assumed to be in a state in which invoking that callback will not help
> > > either way).
> > >
> >
> > Alright. My goal here is to ensure that TLB invalidations are elided
> > only when the device (IOMMU) is suspended. For that I believed we
> > could do either of the following:
> >
> > 1. Ensure RPM_SUSPENDING -> RPM_ACTIVE transition *always* invokes the
> > resume callback (this is because the resume cb flushes the entire TLB).
> 
> That would be incorrect at least in some cases.
> 

Right.. those incorrect cases is what we'd like to avoid..

> > 2. Ensure that we are able to reliably *get* a PM ref if the device is
> > NOT suspended, i.e. even if it was in a transient state.
> 
> A transient state means a point of no return, so I don't think this
> can work the way you want.
> 
> > But I guess that maybe the new API (option 2) isn't the right way to go.
> >
> > I'm assuming you mean that if we design the suspend callback in a way
> > that it doesn't return error, we can reliably ensure that the resume
> > callback will be called before transitioning to the RPM_ACTIVE state?
> 
> Yes overall, but note that driver callbacks are usually invoked by bus
> type or PM domain callbacks that can fail.

Ack. Can you confirm that these failures happen *before* invoking the
rpm_suspend callback.. because after rpm_suspend callback is invoked I
guess the rpm_resume will be invoked?

I could potentially have a design where the suspend_callback flushes 
the TLB iff we're about to return an error. But if you say that a 
failure happening before the rpm_suspend can make a transition from a
NON-ACTIVE to ACTIVE state, then I guess we'll need something from the
PM framework..

Looking at the code, I don't see the rpm status changing from ACTIVE
to rpm status != RPM_ACTIVE before the rpm_suspend functions call.
Thus, I suppose, we are *always* RPM_ACTIVE till we enter rpm_suspend
and only bounce back from RPM_SUSPENDING to RPM_ACTIVE (without invoking
resume callback), when the suspend callback returns ERROR. Is that the
right understanding?

Thanks,
Praan
