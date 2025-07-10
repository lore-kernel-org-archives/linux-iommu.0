Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6F1DF75C
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143356; cv=none; b=grkNgtlAqbnrnu6RBqgvHVEDN23GSWD9NB9fGKzDsLSJ7HFLPkJRFULPPUkKr3Pj35ncLMtCrG1dFIBniccrxhgA1ZGhTuAqR2DFToLQTUUBZ1tcR56w9qKs3BTV+q2zk8+vLOxz4+k8s9CZ3rfR2v68INyg/pLZjcOf+DLn13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143356; c=relaxed/simple;
	bh=YZFtQwIRE24Q4uBLShye/9O9mu9TKTRf9uza/iPaf3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fh9xJjbQPoNMY8sffjWiLuRRxvspyZifgh9xFPVJoUwOGQn3VgTRR28FgclODA4xWr60R/z2yBC5EIUI0EC0cRaDK471Ol9SApBHtCkYyfZtXRNDNTR3aV41FNdzPZwQdRGvHWq2cBHDg+lb9I6Ea/nOgOCdSjBYxwrmyYy7cLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR7ISBGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR7ISBGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE82C4CEF7
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752143355;
	bh=YZFtQwIRE24Q4uBLShye/9O9mu9TKTRf9uza/iPaf3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OR7ISBGUHIad/dZn5UlbQv0wLV/ZXNgR6VD1JKhU+psJS11aG8CdJPL/l2v4ztFpi
	 8/R4nVILa4NbOxLD/UJ/R0PnJAD7Mg9Y9KnCKDFNsM/bKmUoRBkaP7hrUJAgxSyh+q
	 getxgBhe+2cbL4BNpTOxSHCW/+tN2SVtMW6GSsJ/Y37KP9k+pzLmr63Trm8RIsrA1d
	 dI18JcoJAdlNLhg8myt2Z4/aHPechghpGkMjiCfWi8+o4tewORmRl1uRtrjPBsYm3g
	 xi0CYeAcrFNgWKXQoSlmKWj64C1ZJfCpsd9gDTFyU34aj4NHXQ46OEv2FqLMkGI1CI
	 wDN1nWRa7APCw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ea080f900cso171225fac.2
        for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 03:29:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0xISMag9WcbCZzzhWL92g2Y5e7plMTcV33Z++mZRbfD32a4nlzvjr6CZDHLqZ0e6ySIKBZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFvU/MYFa+engdV/QeyWas/XFLoPBXWIdUQMfc4MUG+g36DVYP
	cRilZZTt4JV3jcQo13PxTmA8T9PC2Vxb4yTvHHnpHwGeC1+5StTMR7JIbxC15LOKw4yHJdZF1ry
	ItZRnX8quQO67Wq3x4AA5gbAfqU6x5MU=
X-Google-Smtp-Source: AGHT+IHxZtpDMuT1TmBDZpq54pF91M7Rhr07w86CJoiSdBh1OAjrzJkLypy73P7Y6yYreUlIeoYw3M/o6oYHuY2+tEY=
X-Received: by 2002:a05:6870:c394:b0:2e8:7505:638e with SMTP id
 586e51a60fabf-2ff10a2a694mr1488906fac.39.1752143354587; Thu, 10 Jul 2025
 03:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com> <20250616203149.2649118-6-praan@google.com>
 <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
 <aG6P6F-MEvL4SfNz@google.com> <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
 <aG6hpoMx1QwwP195@google.com> <CAJZ5v0jyYpu=qA-_QKVoNhzRZRNKe5cFt718fo6pxR6iRkD2bw@mail.gmail.com>
 <aG-BC6B4R1ViEDM1@google.com>
In-Reply-To: <aG-BC6B4R1ViEDM1@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Jul 2025 12:29:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0id-sRxVxupWPKPGikSm5_QeO_WKgYdK2BUbY4m7dbndw@mail.gmail.com>
X-Gm-Features: Ac12FXw7rqGEgMOublhky-lIDrLbAZLu41qO4bRajq6OoZVwmTh87BrARHnloUk
Message-ID: <CAJZ5v0id-sRxVxupWPKPGikSm5_QeO_WKgYdK2BUbY4m7dbndw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce pm_runtime_get_if_not_suspended()
To: Pranjal Shrivastava <praan@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 11:00=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> On Wed, Jul 09, 2025 at 09:37:58PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 9, 2025 at 7:06=E2=80=AFPM Pranjal Shrivastava <praan@googl=
e.com> wrote:
> > >
> > > On Wed, Jul 09, 2025 at 06:35:41PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jul 9, 2025 at 5:51=E2=80=AFPM Pranjal Shrivastava <praan@g=
oogle.com> wrote:
> > > > >
> > > > > On Wed, Jul 09, 2025 at 08:44:06AM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Mon, Jun 16, 2025 at 10:32=E2=80=AFPM Pranjal Shrivastava <p=
raan@google.com> wrote:
> > > > > > >
> > > > > > > The existing opportunistic helpers like pm_runtime_get_if_act=
ive() and
> > > > > > > pm_runtime_get_if_in_use(), are too strict for certain use ca=
ses. They
> > > > > > > fail if the device is in a transient state like RPM_SUSPENDIN=
G, which
> > > > > > > can lead to drivers making incorrect assumptions about the de=
v's state.
> > > > > > >
> > > > > > > These helpers don't suffice for cases where one wishes to eli=
de HW clean
> > > > > > > up like queue flushes or TLB invalidations if the device is p=
owered off.
> > > > > > > It is wasteful to wake up the device in cases where the resum=
e callback
> > > > > > > resets the device well OR if the HW resets in a clean state. =
Thus, if a
> > > > > >ppy to hear your feedback or any alternative ideas you might hav=
e > device is powered off, it is preferred to elide any clean-up HW ops lik=
e
> > > > > > > queue flushes / TLB invalidations when the device will resume=
 afresh.
> > > > > > >
> > > > > > > Consider the following sequence of operations:
> > > > > > >
> > > > > > > 1. The device is in `RPM_SUSPENDING` state
> > > > > > > 2. The driver calls pm_runtime_get_if_active/in_use
> > > > > > > 3. Depending on these API, the driver elides a HW clean-up op=
 like:
> > > > > > >
> > > > > > > if (pm_runtime_get_if_in_active(dev))
> > > > > > >         invalidate_tlb(dev);
> > > > > > > else
> > > > > > >         // Skip flush, assuming device will fully suspend
> > > > > > >
> > > > > > > 4. Now, another rpm dev-linked device wakes up, causing the d=
evice's
> > > > > > >    state to bounce from RPM_SUSPENDING to RPM_ACTIVE without =
invoking
> > > > > > >    any rpm callbacks, preventing them from resetting the dev =
correctly.
> > > > > >
> > > > > > This never happens.
> > > > > >
> > > > > > If the status is RPM_SUSPENDING, the runtime suspend callback w=
ill be invoked.
> > > > >
> > > > > Ack, I believe we're talking about the check[1] in rpm_resume her=
e:
> > > >
> > > > No, I'm talking about the fact that the status is changed to
> > > > RPM_SUSPENDING right before invoking the callback.
> > > >
> > >
> > > Right, but if the callback returns -EAGAIN or something, in
> > > rpm_suspend() we go ahead and set the status to RPM_ACTIVE again
> > > on jumping to the `fail` label[1].
> > >
> > > > >         if (dev->power.runtime_status =3D=3D RPM_RESUMING ||
> > > > >             dev->power.runtime_status =3D=3D RPM_SUSPENDING) {
> > > > >
> > > > >             [...]
> > > > >             /* Wait for the operation carried out in parallel wit=
h us. */
> > > > >             [...]
> > > > >             finish_wait(&dev->power.wait_queue, &wait);
> > > > >             goto repeat;
> > > > >
> > > > > However, my worry is about the following situation:
> > > > >
> > > > >   rpm_suspend                      rpm_resume
> > > > >
> > > > >   rpm_status =3D RPM_SUSPENDING
> > > > >                                    if (RPM_SUSPENDING)
> > > > >                                    prepare_to wait(...)
> > > > >
> > > > >   // suspend fails
> > > > >   retval =3D rpm_callback(...);
> > > >
> > > > You're talking about the callback returning an error and your
> > > > changelog is talking about a different situation.
> > >
> > > Apologies, I should've been more clear. What I meant was for a situat=
ion
> > > where due to *any* reason (except disabling runtime PM) we bounce bac=
k
> > > from RPM_SUSPENDING to RPM_ACTIVE *without* invoking the resume callb=
ack
> >
> > This only can happen if the suspend callback returns an error, but I'm
> > not sure why and how this matters.
> >
> > pm_runtime_get_if_active() does not guarantee anything in the case
> > when 0 is returned anyway.
> >
> > > > >   goto fail;
> > > > >   [...]
> > > > > fail:
> > > > >   rpm_status =3D RPM_ACTIVE;
> > > > >                                    finish_wait(...);
> > > > >                                    goto repeat;
> > > > >                                    repeat:
> > > > >                                    if (rpm_status =3D=3D RPM_ACTI=
VE) {
> > > > >                                         retval =3D 1;
> > > > >                                         goto out;
> > > > >                                    }
> > > > >                                 out:
> > > > >                                    [ ... ] // put_parent if one
> > > > >
> > > > >                                    // we return without resume cb=
();
> > > > >                                    return retval;
> > > > >
> > > > > Now, if we rely on APIs based on pm_runtime_get_conditional(), wh=
ich
> > > > > might return 0 if (dev->power.runtime_status !=3D RPM_ACTIVE), we=
 might
> > > > > end up eliding some TLB invalidations in the period where the sta=
tus was
> > > > > RPM_SUSPENDING till it's back to RPM_ACTIVE due to a failed suspe=
nd.
> > > >
> > > > It actually depends on the reason why the callback returned an erro=
r.
> > > >
> > >
> > > I'm not sure if I follow.. as per rpm_suspend[1] I see that upon fail=
ing
> > > (which also happens on getting a non-zero retval from the suspend_cb)=
 we
> > > set the runtime status to RPM_ACTIVE.
> >
> > Yes, it just goes back to the status from before the failure because
> > when the error code is -EAGAIN or -EBUSY, the status should be still
> > RPM_ACTIVE and otherwise runtime_error is set and the device likely
> > requires some help.
> >
> > > > > This can cause some severe address-aliasing/ghost hit issues sinc=
e the
> > > > > TLB still has some stale entries..
> > > >
> > > > I'm not quite sure what you mean.
> > > >
> > >
> > > I meant if the TLB invalidations were elided (i.e. TLB still had stal=
e
> > > entries) in hope that the IOMMU would be suspended, but due to some
> > > reason the suspend failed and the status gets back to RPM_ACTIVE whil=
e
> > > exiting the rpm_suspend call and a client wakes up and performs a DMA
> > > (IOMMU transaction), the TLB entry might hit for an address which was
> > > supposed to be invalidated by now.
> >
> > So as I said this is just one reason why you cannot rely on runtime PM
> > to guarantee that the device will remain suspended, or in fact whether
> > or not it will be suspended at all.
> >
> > > > > Instead, we'd like to ensure that the status IS suspended
> > > >
> > > > But you can't.
> > > >
> > > > That's the difference between RPM_ACTIVE and RPM_SUSPENDED.  If you
> > > > bump up the runtime PM usage counter while the device is RPM_ACTIVE
> > > > (and while holding its power.spinlock), it will not suspend.  There=
's
> > > > no way to prevent a suspended device from resuming (other than
> > > > disabling runtime PM for it).
> > > >
> > >
> > > The problem is avoiding bumping up the count while the device is in a
> > > transient state like RPM_SUSPENDING and then bouncing back to the
> > > RPM_ACTIVE state without invoking RPM resume callback, which seems to=
 be
> > > possible as per the rpm_suspend implementation [1].
> >
> > I'm not sure what you mean here.
> >
> > The usage counter is bumped up by pm_runtime_get_if_active() only if
> > the device is RPM_ACTIVE in which case it will guarantee that the
> > runtime PM status will not change.  There is no way to provide a
> > similar guarantee on the RPM_SUSPENDED side short of disabling runtime
> > PM.
> >
> > > > > to make a decision to elide the TLBI or not.
> > > > >
> > > > > What are your thoughts on this? I'm open to approaching it differ=
ently.
> > > >
> > > > IMV this is all misguided, sorry.
> > > >
> > >
> > > Ack. But I'd want to understand better here. Are you saying that it
> > > isn't at all possible that RPM_SUSPENDING bounces back to RPM_ACTIVE
> > > without invoking the rpm_resume ever? Because per the following snipp=
et,
> > > it seems likely:
> > >
> > >         __update_runtime_status(dev, RPM_SUSPENDING);
> > >
> > >         callback =3D RPM_GET_CALLBACK(dev, runtime_suspend);
> > >
> > >         dev_pm_enable_wake_irq_check(dev, true);
> > >         retval =3D rpm_callback(callback, dev);
> > >         if (retval)
> > >                 goto fail;
> > >
> > >         [...]
> > >
> > > fail:
> > >         dev_pm_disable_wake_irq_check(dev, true);
> > >         __update_runtime_status(dev, RPM_ACTIVE);
> > >         dev->power.deferred_resume =3D false;
> > >         wake_up_all(&dev->power.wait_queue);
> > >         [...]
> > >
> > > Sorry if I'm missing something here, but it does look like we can bou=
nce
> > > back to RPM_ACTIVE without invoking the resume callback, which is a
> > > behaviour we'd like to avoid.
> >
> > So let me repeat: This only happens if the suspend callback returns an
> > error and in that case it is not clear whether or not the resume
> > callback needs to be invoked (either it doesn't or the device can be
> > assumed to be in a state in which invoking that callback will not help
> > either way).
> >
>
> Alright. My goal here is to ensure that TLB invalidations are elided
> only when the device (IOMMU) is suspended. For that I believed we
> could do either of the following:
>
> 1. Ensure RPM_SUSPENDING -> RPM_ACTIVE transition *always* invokes the
> resume callback (this is because the resume cb flushes the entire TLB).

That would be incorrect at least in some cases.

> 2. Ensure that we are able to reliably *get* a PM ref if the device is
> NOT suspended, i.e. even if it was in a transient state.

A transient state means a point of no return, so I don't think this
can work the way you want.

> But I guess that maybe the new API (option 2) isn't the right way to go.
>
> I'm assuming you mean that if we design the suspend callback in a way
> that it doesn't return error, we can reliably ensure that the resume
> callback will be called before transitioning to the RPM_ACTIVE state?

Yes overall, but note that driver callbacks are usually invoked by bus
type or PM domain callbacks that can fail.
