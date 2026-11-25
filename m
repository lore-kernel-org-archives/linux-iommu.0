Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795609420;
	b=aHTw7rx/F5leptgGFTKUUoDvJsNh/fJnE6aVrmgN9pgmsamMiOXqzJcm311PzdC8xBy/
	 pPk8pdNn7LJRLCXw6PNRAGZ9l4PA460qlok0Arq3bOXzOUINppIrpOYi6gnxOlLYbxJ28
	 nQ1wL4ffCDhIWZLeELd7UhXscYpRih5Sh3Xh70ChLLI1oZUycENJl8mQmdmgmG7rJX4su
	 1EK18KzwpduhOSO6HFpB31dNZJIA8I26SvN0f+RGRtw6s1NDVBVhGSZ7y53EeqjKoy4Qe
	 CwRSc/UNbZQTiMBbSMHwQ3W3wGe1bQLXWaCcDtFVO3peA6Vy7oY+DZzoWfIk0QLbYuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=K6QtcuAnxW6mL0hxcIX9hIze6pUXkwxeFIhvp4wE5fY=;
	b=JlS6tLxDfYbpE11sCZeXtH9amB5IcSk9bTTXH+G1yxXJLw5sVwIPiPPI9N13dT/WKVxS
	 a6Tf2YcbkH0gLVS6hYPgk4/moheyLUxN7CJ8iWu5N93cyhmtl/Y3YO6/4EXwakNMwrs/E
	 rMrc2koIeoRJYf9iul+xO1LRTYXfusUuL8ASH7noc/LaS+PNX6cfgh3fMiYTaKP8HgyiK
	 UT0gDRkPlsQUC7PP9+AJ/GX5TKxzL2y/ru/zQ84XPLFREEo5q4CI/FaLL9nx/xwkR5nkE
	 pnirSo8iWmRP8vKINKerJn2WMvRQ2Oi4IZYz//m3CY/rB/s7huUy0qxcTlUnzyMP7WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gZV0l5GI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A6606A326
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 12:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 953A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gZV0l5GI
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ec20398b05so4824636e0c.1
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 04:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795609418; cv=none;
        d=google.com; s=arc-20260327;
        b=rW4xsM8MDzPYc0yukutmdORfuKj7ZF02lSCb+1tHJ1ybcoxboidcxhpEFHf7VyhDaS
         iihKT4RMp3yWzZ5NPJqYquDn3ZeelBa24ndT9eUfPXB5/ArWax7QZ+dWG5hOb7flOC7x
         IjfI5JXYn6twlXfqhLhL6gVJShiJMU7jypEkbHxKWODPG9UpGo+ej9YGDEMH36Cl9272
         08OL1NNmEUiiv5O1BveoVqwb0+4OsjH+UmwydGVQ033A+1+jLk368cISo/yuQdqsz89G
         n+rRlIvkLCfH7/Y386fjw3DoOpRniYbRqSE9CENn9BqaFSgH+tj680kH25oWM3op0Fpu
         fXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6QtcuAnxW6mL0hxcIX9hIze6pUXkwxeFIhvp4wE5fY=;
        fh=VrT/x7xrobv3KG8OhOsRj3Ws5GnJ2oMFSE6VptNpXa8=;
        b=Pf23Tcdj6oHRHUdTHzYp4GeWSVz+Tkr9jmnQCDQxXqCjw9IHwdSkYkDwyPHeEFYy/G
         ymuchUkQk+HcTs8Pw6aGetpC1enntlryoah1YIcdmPoVy5sQHdb0wcMunkzJ2GEsvoBk
         oObLDFjjSPVP2LdWMxtrbBhQ2yNeEr7oMhoZw7dygMroYFbHppsk1H2jIvi055nD324Z
         6HudesERGp5jUKJPCfS5ErbVkghR2czlrAUNja3P4QxACLUu/MABUTR6w0/0t8RTKPXp
         Kl5y5f9/JGDqWUCRudgin4gm6uUjYz/8ZQUdSylAwl97XU/RWyH8UQMNaGVnoIHAbLCf
         UuKA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609418; x=1796214218; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K6QtcuAnxW6mL0hxcIX9hIze6pUXkwxeFIhvp4wE5fY=;
        b=gZV0l5GIIzloibTEQYLR4bjk3OfLWE3y+FzGV9f78+vUNv4LI/LMYyugI3s0PgiJgB
         v5J/+rI5ZMV5Hvc9a3K+NKapvVjyK1QSP108EnMN9s9+SLixD6+AnfFUVrhGHZhX3YgP
         qBljIeiLidwOXhVp/uKXcRHWTM9I8e9d1HarWzo4T4Pgtvc9+WOAjLapqp6/c6drnpfP
         t6ZlSPONpeuJvcwSujqS0jnIvQ66X9XgTnS3E1Wd4P8tA5k4QUGh88wKGeMIis+7xtkr
         RXQEQRWqiyXdW51x2NcGLYTqCDP+vsK3VCA3/ZpIRy7hCrI0z/ViRbueOyqJ15sdRNQi
         ZHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609418; x=1796214218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6QtcuAnxW6mL0hxcIX9hIze6pUXkwxeFIhvp4wE5fY=;
        b=ctzq6JOE+VeRrCjbd+/ueGrqOv22rJAC75EFAHdWuSkXWT0QKoZGHzQWVf9z4HrHch
         gtjAK1EsAeRchHuEGStlFHKijxm40H0LYy5xDbL2GwvUwbgGCZw3fgKTsJh4vjpTp1bv
         dHNXXsArOXkBiiYBFfAMYoFZdSXqum4G5Fl9UWo0aEPr4A934Qmz4xWeOsl+UFnGvy5v
         1G837ns/fR2SGZhpt/6M3qVT6zH860uQPZrJKEs/ksbqTz4l6M6npHgHefaffOhaGcb4
         6+rNgK/aveRVVFlT5HLvWB6g8Lyt0UCF2qiYynpD6xiSziphtO0em7FkkCLDXz0VsyqX
         90+g==
X-Gm-Message-State: APuU4Z9FkgVRAOJr3Ox0DHQKfAjwUGWqoHMLQddCddKrenrNCwCJd6rv
	lo7khkCOb9AIsv/IO7VJ5nutXcjtClXILg9IIWctQvoTPd0ApJPAzG61hKn0wFcn4GI16O75fl+
	21fD9RGD5tBai19e+O++3J/6rolKGbNA=
X-Gm-Gg: AZFdTZdVulgGJu0BNmDlMryP5dILpXnw+jO09fHt81pkJL/YDAJBmG+X2taHn188mWP
	HtjYnO7JGJ1mlXw0zVnc2swRU/byvKcynzuP4427cuFUGlnh8EkNrm31w3HSQG+SqKQ0+CicACZ
	Nqri7nd/1TMguyj/65Lq9Y1BwaqcIhvRLCu05QYsAXu3OR7Io8P1e1Ss5I9VvCjHlI+2zLq7oxQ
	Ymh/hjyd0YEAysgYjHlMcEudFwy6RFhbfiHPD2NSv/jf1heX9Te4De4nH3TekS7qn5bvx9gIMUk
	2gjC9pFoegaUssdBc3+bfyOtQp35kd9Ik0kl/MxCF37kWhmbW/i0VYHcaPpAJ4CAWztJDndl+oM
	oBF8sC+cUprXRVyxKAY7hnwIds1COFxNGrwKaSYcbnWVI0en/BnSpcQ9apekFgFW0ILriFodalP
	CEGvSPaR2qPHbk
X-Received: by 2002:a05:6123:6:b0:5ee:9000:106b with SMTP id
 71dfb90a1353d-5ee90001d62mr6482175e0c.18.1795609418239; Wed, 25 Nov 2026
 04:23:38 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CANLiQWrVGN00Hn8s3X7nyDZxh3x0wJ1YqTVzYsLUPM3s-Pkp1A@mail.gmail.com>
 <d4f010f9-44b3-4f0e-9f84-f85ad9c82b3e@arm.com>
In-Reply-To: <d4f010f9-44b3-4f0e-9f84-f85ad9c82b3e@arm.com>
From: Anton Sovetov <anton.sovetov@gmail.com>
Date: Wed, 25 Nov 2026 15:23:26 +0300
X-Gm-Features: Aa3M54qJoIcmX1UHgsgyE_ikadkbIyUc8ADaYEFRIZ1DZo-l0sS_ea_Jf3HYzCE
Message-ID: <CANLiQWo5qOUt4CS-nK+nHQk3aZHADb3hy=zfvLKoxi7N_jEmPw@mail.gmail.com>
Subject: Re: [RFC PATCH] iommu/rockchip: program the MMU even when the device
 is not in use
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, heiko@sntech.de, joro@8bytes.org, will@kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin,

Thanks, that's a fair reading. I'll take 2 and 3 as answered: zapping a
disabled MMU is pointless when resume re-enables it with ZAP_CACHE, and an
attach that leaves paging off is fine because the client's next runtime
resume turns it on anyway.

On 1 I'd like to check one thing before I drop it. pm_runtime_get_if_in_use=
()
returns 0 not only when the device is suspended but also while it is still
RPM_ACTIVE with the usage count already at zero, and during the suspending
transition, since pm_runtime_put() defers the suspend to the workqueue. In
that window the MMU is still paging and can latch a fault the handler then
discards, which is how I ended up with dte 0x480000 status 0x2b fault 0xdc8=
0
latched and nothing in dmesg. Would pm_runtime_get_if_active() be acceptabl=
e
there, or is that window too narrow to be worth the change?

Either way I'm now looking at the client driver's RPM accounting as you
suggest, and will report back what I find.

=D0=B2=D1=82, 24 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 20:5=
7, Robin Murphy <robin.murphy@arm.com>:
>
> On 23/11/2026 8:07 pm, Anton Sovetov wrote:
> > Hi,
> >
> > I hit three related problems in drivers/iommu/rockchip-iommu.c on an RK=
3566
> > (Radxa Zero 3W) with the out-of-tree NPU driver. All three have the sam=
e shape:
> > the driver gates work on pm_runtime_get_if_in_use(), which is 0 unless =
somebody
> > already holds a reference, and for a device that keeps its DMA domain f=
or its
> > whole lifetime that is the normal state.
> >
> > 1. rk_iommu_irq(), line 583, gate at 592.
> >
> >     A page fault raised while the device is running, outside a map or u=
nmap
> >     call, finds usage_count 0,
>
> That sounds wrong - if "the device is running" then its RPM state should
> be logically active, which should in turn hold the IOMMU active via the
> device link. And if the client device is still doing DMA and able to
> cause page faults while logically suspended, that would seem like a bug
> in the client driver.
>
> > so the handler returns IRQ_NONE without touching
> >     the registers. The fault stays latched: INT_RAWSTAT bit 0 and INT_S=
TATUS bit
> >     0 remain set, PAGE_FAULT_ACTIVE stays set in STATUS, REPLAY_BUFFER_=
EMPTY
> >     clears, and nothing is printed. The device then sits on a stalled
> >     transaction and dmesg says nothing at all, which is the worst part =
for
> >     anyone trying to debug it.
> >
> >     Observed on the NPU: after a job that never completed, the MMU read=
 back
> >     dte 0x480000 status 0x2b rawstat 0x1 intstatus 0x1 fault 0xdc80, an=
d the
> >     handler had never run. A normal fault report would have printed "Pa=
ge fault
> >     at 0x0000dc80 of type read" plus the page table walk.
> >
> > 2. rk_iommu_zap_iova(), line 680, gate at 694.
> >
> >     The comment says "Only zap TLBs of IOMMUs that are powered on", but=
 the test
> >     is the usage count, not the power state. An unmap that happens whil=
e nothing
> >     else is using the IOMMU skips the shootdown. A device that keeps it=
s domain
> >     but is idle at that moment, which is the usual case when the proces=
s that
> >     owned the buffers has exited, keeps stale entries, and the next own=
er of the
> >     same iova can still be translated to the previous physical page.
> >
> >     I could not prove this one with a bus trace, so I am reporting it a=
s a code
> >     observation and not as a measured failure.
>
> The physical power state shouldn't matter - as long as the IOMMU is
> logically suspended then we should have been through rk_iommu_suspend()
> -> rk_iommu_disable(), after which we're not going to touch it again
> until rk_iommu_resume() -> rk_iommu_enable() which inherently does an
> RK_MMU_CMD_ZAP_CACHE. Thus resuming a suspended IOMMU, invalidating all
> the TLBs in the process, just to issue a command to re-invalidate
> nothing, then disabling it until the client device next resumes it and
> invalidates all the TLBs yet again, clearly seems a bit silly.
>
> > 3. rk_iommu_attach_device(), line 1008, gate at 1040.
> >
> >     Detach plus attach is how a driver resets its IOMMU domain. On atta=
ch, when
> >     the usage count is 0, the function returns 0 without calling
> >     rk_iommu_enable(), so paging stays off, DTE_ADDR stays 0 and INT_MA=
SK stays
> >     0. The caller is told the attach succeeded.
> >
> >     Observed on the NPU: its soft reset does iommu_detach_device() and =
then
> >     iommu_attach_device() on the same domain. After the first reset the=
 MMU read
> >     dte 0x0 status 0x18 intmask 0x0, no translation at all, and every l=
ater DMA
> >     ran on raw iovas. Before the reset it was dte 0x480000 status 0x19
> >     intmask 0x3. Holding the MMU device with pm_runtime_resume_and_get(=
) around
> >     the detach/attach makes the same sequence end with dte 0x480000 sta=
tus 0x19,
> >     which is how I convinced myself the gate, and not the reset itself,=
 was
> >     responsible.
>
> Again, that sounds very much like something is wrong with either the
> device link or how the out-of-tree client driver is managing its own
> RPM. And since the device link support has been upstream and apparently
> working fine with the upstream VOP/RGA/etc. client drivers for over 8
> years now...
>
> Thanks,
> Robin.
>
> > The patch below resumes the device around the attach and the zap. Both =
run in
> > process context, so pm_runtime_get_sync() is fine there. For the interr=
upt
> > handler I only added a log line on the drop path, because I do not want=
 to
> > touch registers from hard irq context while the device may be suspended=
.
> >
> > What it fixes: the MMU now stays programmed across a detach/attach cycl=
e, and a
> > fault that arrives while nothing is mapping gets reported instead of va=
nishing.
> >
> > What it does not fix: the reason I went looking. Our NPU still stops ex=
ecuting
> > jobs in IOMMU mode after a few separate processes, with a healthy MMU a=
nd no
> > page fault at all. That is a different problem and I am not claiming th=
is patch
> > touches it. I am sending these three because each one is a real failure=
 mode on
> > its own.
> >
> > Tested only on rk3566 with the v1 block. I have no rk3588 hardware and =
would
> > rather not guess about the v2 path.
> >
> > Questions:
> >
> > - Is the usage count gate deliberate, in the sense that register access=
 is
> >    unsafe unless someone holds a reference? If so, is the right fix to =
keep the
> >    MMU programmed for as long as the device is attached to a domain, in=
stead of
> >    tying it to the map/unmap window?
> > - For the interrupt path, what is the intended behaviour when a fault a=
rrives
> >    while the IOMMU device is runtime suspended? Ignoring it leaves the =
device
> >    stalled and the status latched, which is what we see today.
> >
> > Signed-off-by: Anton Sovetov <anton.sovetov@gmail.com>
> >
> > ---
> >   drivers/iommu/rockchip-iommu.c | 42 ++++++++++++++++++++++-----------=
-
> >   1 file changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-io=
mmu.c
> > index 07e3517..a3da612 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> > @@ -590,8 +590,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev=
_id)
> >    int i, err;
> >
> >    err =3D pm_runtime_get_if_in_use(iommu->dev);
> > - if (!err || WARN_ON_ONCE(err < 0))
> > + if (!err || WARN_ON_ONCE(err < 0)) {
> > + dev_err(iommu->dev,
> > + "interrupt while the mmu is not in use, ignored\n");
> >    return ret;
> > + }
> >
> >    if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
> >    goto out;
> > @@ -691,17 +694,19 @@ static void rk_iommu_zap_iova(struct
> > rk_iommu_domain *rk_domain,
> >
> >    iommu =3D list_entry(pos, struct rk_iommu, node);
> >
> > - /* Only zap TLBs of IOMMUs that are powered on. */
> > - ret =3D pm_runtime_get_if_in_use(iommu->dev);
> > + /*
> > + * The usage count says nothing about the power state, so an
> > + * unmap that runs while the IOMMU is idle skipped the
> > + * shootdown and left stale translations for the next owner of
> > + * the same iova.
> > + */
> > + ret =3D pm_runtime_get_sync(iommu->dev);
> >    if (WARN_ON_ONCE(ret < 0))
> >    continue;
> > - if (ret) {
> > - WARN_ON(clk_bulk_enable(iommu->num_clocks,
> > - iommu->clocks));
> > - rk_iommu_zap_lines(iommu, iova, size);
> > - clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> > - pm_runtime_put(iommu->dev);
> > - }
> > + WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
> > + rk_iommu_zap_lines(iommu, iova, size);
> > + clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> > + pm_runtime_put(iommu->dev);
> >    }
> >    spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> >   }
> > @@ -1037,13 +1042,22 @@ static int rk_iommu_attach_device(struct
> > iommu_domain *domain,
> >    list_add_tail(&iommu->node, &rk_domain->iommus);
> >    spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> >
> > - ret =3D pm_runtime_get_if_in_use(iommu->dev);
> > - if (!ret || WARN_ON_ONCE(ret < 0))
> > - return 0;
> > + /*
> > + * Detach plus attach is how drivers reset their domain, and the calle=
r
> > + * has no way to notice that the MMU was left unprogrammed. Resume the
> > + * device and program it.
> > + */
> > + ret =3D pm_runtime_get_sync(iommu->dev);
> > + if (ret < 0) {
> > + dev_err(dev, "cannot resume the mmu, ret: %d\n", ret);
> > + return ret;
> > + }
> >
> >    ret =3D rk_iommu_enable(iommu);
> > - if (ret)
> > + if (ret) {
> > + dev_err(dev, "mmu enable failed, ret: %d\n", ret);
> >    WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
> > + }
> >
> >    pm_runtime_put(iommu->dev);
> >
> >
>


--=20
With respect,
Anton Sovetov (co-Founder and CEO of 3d-club LLC")
https://3d-club.ru                        tel:+7 (999) 246-78-36
