Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DD21CC43
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078954; cv=none; b=RMsyp87VAslMllcTH8x9cO5Egk8yvsTDWoem67XVhY5tePlql7sb9a9LCrlKezsrih//EM7piTymdh/OI56OUaFMMYDJFhtlLaTIVg8TkA/BxQR8s0LZ0PRLAuElfo/RfaXeSZZV0hFBrqCkvfiI7asIiQTc5upwei/r6B2txr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078954; c=relaxed/simple;
	bh=D6S7FxxYzbYrwZw17NYk+jIdqCqA1axBq+YKjK2ZNuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOjCzossnsNCK8jzLPWiA2DqGF/dq7so5fqYfHj8J3pytKnutNOyp1bKxveaz+e8ePON+Da17VAvgXEetjPgw0j5S9mSSHHbJ2K7SHqJQ3wqSgnwJLv3vvKzelXz1H8Q37Rkmoo+p5HEhAUL+vS9puvL0aHo3NJo1wtYwyxm4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI+leXs/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI+leXs/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED81C4CEF9
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752078953;
	bh=D6S7FxxYzbYrwZw17NYk+jIdqCqA1axBq+YKjK2ZNuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OI+leXs/1x9wLgZNyYyDiMqf66YK1bKbPpCchQLidjdr2tK4byiT95O3VIcYMEzvb
	 GX9q4qZ2J2qRbIQ77gC4FNwUHMPlQC6U0ssx2pNtk8rNIdw90ZAFiRIRYmJVbFSADs
	 n8qFBBfnVjn3fkdNvm6k6/HqMf07LjwJI9T9gWpe3C60ymvY2Q5uwUtppDEuZojjIP
	 Lf2JGNln6q0pH2UASEexncnWA83dUuWsSuilWZOazZnfdlvMRJN8e2gZSotl+9GUI6
	 myTQl/SSZxLpn3NAff/aJ9+wzPJnuq5OAmwqgOGIjRP1GHYPIJ5ZL/pTk4jCRzOywx
	 8wDPauyqzUP/g==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60be827f2b7so610601eaf.0
        for <iommu@lists.linux.dev>; Wed, 09 Jul 2025 09:35:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0hPQUZ4TCJ2tvcRXLvvgLyOj+S3aQAod6n98Ml6PYpmDKZaCP80+zBtwOzVUzpA7BLgMuSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2vwSKKa4r68ppUywF5Qa+PVcKDGnuVFEicNcc9+6TYlX/iC0S
	qYlWWyQJf69Nwxf06fh342VjJLbUwEl20B1aqn3kRNWIQD1FsItn0LqarzbhFJM+DzTsBq0gXdP
	ARn042k73OS3sk0bElH9RvKC2sRnBEpM=
X-Google-Smtp-Source: AGHT+IHSmggXc8Xq5cBVmYUENrE+YZ+KzyGCyKgC7sf3ZJW0ZHlvN0CN3DQ1N/vCPbco+LARqt+kc/zFBQr6FRtZoRM=
X-Received: by 2002:a05:6871:727:b0:2d9:8f98:b0cd with SMTP id
 586e51a60fabf-2ff0c77d0ecmr114589fac.10.1752078952897; Wed, 09 Jul 2025
 09:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com> <20250616203149.2649118-6-praan@google.com>
 <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com> <aG6P6F-MEvL4SfNz@google.com>
In-Reply-To: <aG6P6F-MEvL4SfNz@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 18:35:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
X-Gm-Features: Ac12FXw6V8GTQr_hVS-SK1sa8By0efXKEUxEpZZ9G4sCddOLoOMAjO0DqLgxP9g
Message-ID: <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce pm_runtime_get_if_not_suspended()
To: Pranjal Shrivastava <praan@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:51=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> On Wed, Jul 09, 2025 at 08:44:06AM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 16, 2025 at 10:32=E2=80=AFPM Pranjal Shrivastava <praan@goo=
gle.com> wrote:
> > >
> > > The existing opportunistic helpers like pm_runtime_get_if_active() an=
d
> > > pm_runtime_get_if_in_use(), are too strict for certain use cases. The=
y
> > > fail if the device is in a transient state like RPM_SUSPENDING, which
> > > can lead to drivers making incorrect assumptions about the dev's stat=
e.
> > >
> > > These helpers don't suffice for cases where one wishes to elide HW cl=
ean
> > > up like queue flushes or TLB invalidations if the device is powered o=
ff.
> > > It is wasteful to wake up the device in cases where the resume callba=
ck
> > > resets the device well OR if the HW resets in a clean state. Thus, if=
 a
> >ppy to hear your feedback or any alternative ideas you might have > devi=
ce is powered off, it is preferred to elide any clean-up HW ops like
> > > queue flushes / TLB invalidations when the device will resume afresh.
> > >
> > > Consider the following sequence of operations:
> > >
> > > 1. The device is in `RPM_SUSPENDING` state
> > > 2. The driver calls pm_runtime_get_if_active/in_use
> > > 3. Depending on these API, the driver elides a HW clean-up op like:
> > >
> > > if (pm_runtime_get_if_in_active(dev))
> > >         invalidate_tlb(dev);
> > > else
> > >         // Skip flush, assuming device will fully suspend
> > >
> > > 4. Now, another rpm dev-linked device wakes up, causing the device's
> > >    state to bounce from RPM_SUSPENDING to RPM_ACTIVE without invoking
> > >    any rpm callbacks, preventing them from resetting the dev correctl=
y.
> >
> > This never happens.
> >
> > If the status is RPM_SUSPENDING, the runtime suspend callback will be i=
nvoked.
>
> Ack, I believe we're talking about the check[1] in rpm_resume here:

No, I'm talking about the fact that the status is changed to
RPM_SUSPENDING right before invoking the callback.

>         if (dev->power.runtime_status =3D=3D RPM_RESUMING ||
>             dev->power.runtime_status =3D=3D RPM_SUSPENDING) {
>
>             [...]
>             /* Wait for the operation carried out in parallel with us. */
>             [...]
>             finish_wait(&dev->power.wait_queue, &wait);
>             goto repeat;
>
> However, my worry is about the following situation:
>
>   rpm_suspend                      rpm_resume
>
>   rpm_status =3D RPM_SUSPENDING
>                                    if (RPM_SUSPENDING)
>                                    prepare_to wait(...)
>
>   // suspend fails
>   retval =3D rpm_callback(...);

You're talking about the callback returning an error and your
changelog is talking about a different situation.

>   goto fail;
>   [...]
> fail:
>   rpm_status =3D RPM_ACTIVE;
>                                    finish_wait(...);
>                                    goto repeat;
>                                    repeat:
>                                    if (rpm_status =3D=3D RPM_ACTIVE) {
>                                         retval =3D 1;
>                                         goto out;
>                                    }
>                                 out:
>                                    [ ... ] // put_parent if one
>
>                                    // we return without resume cb();
>                                    return retval;
>
> Now, if we rely on APIs based on pm_runtime_get_conditional(), which
> might return 0 if (dev->power.runtime_status !=3D RPM_ACTIVE), we might
> end up eliding some TLB invalidations in the period where the status was
> RPM_SUSPENDING till it's back to RPM_ACTIVE due to a failed suspend.

It actually depends on the reason why the callback returned an error.

> This can cause some severe address-aliasing/ghost hit issues since the
> TLB still has some stale entries..

I'm not quite sure what you mean.

> Instead, we'd like to ensure that the status IS suspended

But you can't.

That's the difference between RPM_ACTIVE and RPM_SUSPENDED.  If you
bump up the runtime PM usage counter while the device is RPM_ACTIVE
(and while holding its power.spinlock), it will not suspend.  There's
no way to prevent a suspended device from resuming (other than
disabling runtime PM for it).

> to make a decision to elide the TLBI or not.
>
> What are your thoughts on this? I'm open to approaching it differently.

IMV this is all misguided, sorry.

> Happy to hear your feedback or any alternative ideas you might have

Disable runtime PM for the device and check its runtime PM status,
which cannot be transient at that point.  If it is RPM_ACTIVE, you
need to flush the TLB.

> [1] https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/base/power/=
runtime.c#L808
