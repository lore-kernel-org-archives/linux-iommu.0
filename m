Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A233AD91
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780870953; cv=pass; b=WSGybWASMdZEgmYU75L8kByaHi2uaq3iH+Jxb1D9/iqMcX9WcbZHKhPzw54SNZPsSjhCYEWGeEboFEMXB6PRW9JmOhJY1Qdxc3FqnR2Q45rod/yGECBiAw5jhocu4M+e1pTRm5thcLlksbms7SacpGzd4RVX9OJczOkXswmX2Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780870953; c=relaxed/simple;
	bh=/WwoHxkMELDHKRok5iR6V1OtIikVGNE7PjAEqVxfmko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZU1kjQ/AjyuDhiZj3/dwBcyzxmjQC261ukUvw21FjQ7a9gRFR2wuthOj9Yx2O1c0PRt1rYfR0C15BHMB+kLCNgyu6s5Na3ZvKNMl8L1pyW3GgwhjMHmYCHI0I3FRPgZgB7itHemRQCXLDOsX16Gzt1lVmA89ktTpOfyDA5qotY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLfUxtpU; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLfUxtpU"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175d339e8bso1473651cf.0
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 15:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780870951; cv=none;
        d=google.com; s=arc-20240605;
        b=ZjnyROnPVU+33JeplCybyPtmaY6+hYWsUyD1mbqwcVX8lmeGZME4uoV5RiPbOefeha
         4L8FiCEjpdVwZXnmhNkuNteA1UNm2iByvhnqaHReB7gdLAyDC8+46Q+ICB0D83mVuva8
         XODuURWhlLhC14CwYWKBUUPUNWN9yPkV7o5eNAqWGHB0eUuyCDBiH2isvLWRjJM9+vYP
         5m378HrR+4HZE4vUxWOHjCugMrnM8rp35vI5OcQfwvI6wrW2u1Hsn/C99eScECrVLnhX
         JTN+tGySY+nr+6fEY32KwkY+dC2hVfrv+7QEZkj/VPp0GyI8A8L8IGT4/TsmibVkYWJv
         CRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6VcK+e3be8z9q9KQZpd0XHHtxviPUlwxCxiE+Z9huTw=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=dHXHdrkwXaKyJGlx3UEauRb97tgA1Itg7ofa4U6PfpT3ohTFiazeeHCZUnQaIpqQW/
         AA/9icqG7jg5/tGf9B2Oah4g0lSBocOJLlCg7B9pKNTwNwuqqyZKhkmfrAQYCfo1aUv4
         xEnmZOgsa3vYCa9JvG9lohdBaMiM8ew5ti1RFHZacI07ajoAiLD5cxYB7cX07LQzodRG
         zRl1Br4LlxKSMMZVNrxK7dgH/wJPMKtATjxJ6Ccd+3s3XXobsTT4CR//6lSZzowzpwaT
         002Gtb4oU21bKB7G2WWAVypy0M3Kzmg8zcUz3eMKs/fkXDBkyApXkky0ARhgSAm5J+lb
         tsXw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780870951; x=1781475751; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VcK+e3be8z9q9KQZpd0XHHtxviPUlwxCxiE+Z9huTw=;
        b=OLfUxtpUSiPVO0AxYKkS21lSmu4lRFgy9NIUAR8JkkLT8sWYg4ZT19fYCGDiMh0XeZ
         6jfTqyYB5HvRh8i3rHNojaHZD3dhA2qCo1TbQHhV0kG0P1gsZrj0phyIAYQZTzstEn1b
         toTbyq1Q2bzyiOWuPwBTurytHhpzbEngXLIRSzvvUajKthCY8Xb/10nyylJ2HBMWLCuw
         Yx7jMUXWh/6ipRcTjGVBkCCC5C2T2eCNgn4eRswgyPEOHs9B/4piR9lQCgtgDpsSUS1a
         HDpO+aPljJEMH6xOWyVEI4NrUPGDUK0qklYaVDodFZQ35VDEFl2kvdc10NhBKD4AArpq
         RBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780870951; x=1781475751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6VcK+e3be8z9q9KQZpd0XHHtxviPUlwxCxiE+Z9huTw=;
        b=nBi7wdEcKOawT7fzjEZUBLbkj8aQxrMgXka+qIDJpn8oaXbQmcjgx0B8E5mFuWVjlj
         72GcJBHmVmSiqpkcxk80I0wGt8YqSa1sn+lS20VGAH87ujEYYAILtIPWxB/nOJnoydsr
         BbMnS5J03znP5AoUkwhCWuke1noyZ94x2GTgK+DyBkOzgE5L3GNiyzGAz/BKe+nN+oGH
         ZCcIqY8oNCl6oLQXiih6iHzwyIrZd11/b0Qyiu4NtCeJwGyh6/oYuzzhwyIO6GfXUuTr
         tOqUzkRnF19TKXhQPH1hJ0h+x/NriRQEAQGsuvoTdY9DCqQ5e5Enoh73Zt9UpQ8Zq26M
         Nu7Q==
X-Gm-Message-State: AOJu0YzDrf/ha+MKD7kO8pl9hJ47NYZ73I+i6v/7sVyT4Z3v/euD8xZl
	6IqOSqvHSQxpA8BVKaR4pUy/4BprUVaTrgZ7wnF4xjLAac2qfWShQd43/NP0VS5zZ2y54QzyNBs
	6/ZXvSheoltv1F8rD590ZgdMPcDQwcAvKNPsPYG0t
X-Gm-Gg: Acq92OE7YFc4qAytxUSJLrEOCYZUg+G1bP/5Hz5yWtBru+o1PIZKcxg4sxNzt+BQGUA
	ftJe+xmqglMjVrueiLmmK3GpSdQwKyGHrmtSrlVktDv5SYGXBQpd6BBRIZ7UGIPay/Wnn1iizCI
	pxVAnOKjqmnYOYy9IN4qffHgDKGtkQvjJVOz+2Ifqt+RbIIr9f51y2x1BNglCtstrbf1IHWjzeF
	gnxbTI3R2aF5Gl4XDtoR+vC8g3WOGcQVbMg4tH3dkNdaHMa/SJxym6Hq0Mg6bbWq0BL3a4zBv5s
	rGeVSnf7NUYsVTs=
X-Received: by 2002:a05:622a:d0e:b0:516:4f62:85ec with SMTP id
 d75a77b69052e-51798260987mr18898041cf.17.1780870950334; Sun, 07 Jun 2026
 15:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-12-praan@google.com>
 <CAE2F3rCPgnFU=d5At1zrOLhsuVEbsweogOHGz9gDddRx73zRtw@mail.gmail.com> <aiEawEFsnG-LIahW@google.com>
In-Reply-To: <aiEawEFsnG-LIahW@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 7 Jun 2026 15:22:19 -0700
X-Gm-Features: AVVi8CfrDAvJOrT6teliHxFj-F4hMAC83FTj6Fd7wqQr65yO-UPAL5bQ_Rlf0_U
Message-ID: <CAE2F3rAWZ4Ac23D8eyAHfmaVVkHv8pz45+_dpMO1M4D7+RVCoA@mail.gmail.com>
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:27=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Jun 03, 2026 at 01:28:19PM -0700, Daniel Mentz wrote:
> > On Mon, Jun 1, 2026 at 2:59=E2=80=AFPM Pranjal Shrivastava <praan@googl=
e.com> wrote:
> > > @@ -2361,8 +2394,33 @@ static irqreturn_t arm_smmu_handle_gerror(stru=
ct arm_smmu_device *smmu)
> > >  static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
> > >  {
> > >         struct arm_smmu_device *smmu =3D dev;
> > > +       irqreturn_t ret;
> > > +
> > > +       /*
> > > +        * Global Errors are only processed if the SMMU is active.
> > > +        *
> > > +        * If the STOP_FLAG is set (can_elide =3D=3D true), the hardw=
are is
> > > +        * either already disabled or in the process of being disable=
d.
> > > +        * Any errors captured during the quiesce/drain phase will be
> > > +        * handled by the explicit arm_smmu_handle_gerror() call at t=
he
> > > +        * end of arm_smmu_runtime_suspend() callback. On resume, the
> > > +        * STOP_FLAG is cleared before interrupts are re-enabled, ens=
uring
> > > +        * no valid errors are missed.
> > > +        *
> > > +        * A lockless check is favoured here over a dynamic PM core c=
heck
> > > +        * since the runtime_pm_get_if_active would return false duri=
ng
> > > +        * transient states like RPM_RESUMING & ignore level-triggere=
d
> > > +        * interrupts.
> > > +        */
> > > +       if (arm_smmu_cmdq_can_elide(smmu)) {
> > > +               dev_err(smmu->dev,
> > > +                       "Ignoring gerror interrupt because the SMMU i=
s suspended\n");
> > > +               return IRQ_NONE;
> > > +       }
> >
> > Have you considered using arm_smmu_rpm_get() here instead?
> > I can see two issues with the currenlty proposal:
> >  * Returning IRQ_NONE when an interrupt is indeed active and needs to
> > be handled. This might be interpreted as a spurious interrupt
> >  * Nothing is preventing the suspend handler from running while
> > arm_smmu_gerror_handler is in the middle of handling an interrupt
> >
> > I understand that using arm_smmu_rpm_get() also has downsides,
> > including an unnecessary resume operation when the SMMU is already in
> > RPM_SUSPENDING state. However, using arm_smmu_rpm_get() would make it
> > easier to ensure correctness.
> >
>
> I don't think using arm_smmu_rpm_get() here is possible..
>
> GERROR is registered as a hard IRQ handler, so calling rpm_get (which
> can sleep) would be wrong.

You're right. Sorry, I missed that arm_smmu_gerror_handler is
registered as a hard irq handler.

> Regarding the race, the STOP_FLAG is set at the very beginning of the
> suspend sequence. If an IRQ fires after that, we return IRQ_NONE and
> let the explicit arm_smmu_handle_gerror() call at the end of
> runtime_suspend catch and clear it. After CMDQEN, PRIQEN, EVTQEN &
> SMMUEN are all cleared, getting a Gerror should be treated as spurious
>
> That said, I understand your concerns about a real IRQ being interpreted
> as a spurious one, and creating an IRQ storm since the gerror register
> isn't really written. I have 2 ideas here:
>
> 1. We could have a "suspended" flag and check it with can_elide here:
> arm_smmu_cmdq_can_elide() && is_suspended() to correctly return IRQ_NONE
>
> 2. We could explicitly disable Gerror in IRQ_CTRL write after setting
> the CMDQ_STOP_FLAG. Even if there are Gerrors during the CMDQ drain,
> we'll catcup to those at the end of our suspend callback.
>
> I'm more inclined towards 2 as it prevents potential races (execution of
> an IRQ handler with handle_gerror calls at the end of the suspend).
>
> WDYT?

I'm not sure if I have a good suggestion here. Have you considered the
following: Do not call arm_smmu_handle_gerror() from
arm_smmu_runtime_suspend(). Instead, call disable_irq() at the end of
the suspend handler (and enable_irq() at the beginning of the resume
handler)?
