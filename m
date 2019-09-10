Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F07C5AE59
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 15:45:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3712089F
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 15:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUDx1Vss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3712089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CC1D3D83;
	Tue, 10 Sep 2019 15:45:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 44A6ED7E
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 15:45:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D2C0281A
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 15:45:39 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id y91so17555642ede.9
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ab44L4UsH9lWBk/ePs+t6LQUuKmRHFW0SwCWgf68+rc=;
	b=FUDx1VssMY5+grYTJ9mTO+OtexdcbSTMSsn3//VPNV0zPdSp95pA3zNOdpx4boIzLL
	+8wfwTnUnSWaD0DyKayLxvtLd1DNtf9KpsXdscr1lunnkyj9RgO10ZaIY4qDgscT06xv
	gsu7UNxm0Xryuv9rrw5a4GpIEVPRKWhPVPWKzBpbTQx6lkHw+mIFYb+srXGudTMQJCt5
	gonRN5rE57R/vyk+7sS8MiPSdeYzF3ZPo7wNMrmBj3lVkr6zixiEP6LKYNeZGu9gq5mv
	nhhDZVq5ROoxeNpfmQu0BO+jdHGVOWyuw0NkkZqryUCoeygfaKH+6X5QUf5q5jC92gdh
	i8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ab44L4UsH9lWBk/ePs+t6LQUuKmRHFW0SwCWgf68+rc=;
	b=bHKbQw5MbSu8p6jVdhsEfFc6kV5n07BK4IZx7d4gHnsWsfogpau9EPUIESPkmaS2wC
	zlKBkvySb1YslJVG6kfERHk+bjr6DUAHs1CK4m2gs9FzVXd++XkkcldAeg77LgaUUNCe
	kNFv8e2mkzucDqh+aD9EgGiC2KsCO3EbXDTlgGc7FiXSxrlOizMbQAc/RR82DiuqraqB
	c+dTUeN7EVvFf8Qep8IcW8ijfkFoLSmy1V5zUXK9e5p7yk0M4oRwlO+fRr2zUs9FsZEq
	bTs/Nx+KIIZ/Q9/o8zYIKs5YYOgrXmI+NfIX4NVZJH5ghwTqBxmcvijTNL9Cn45cxwn2
	3g5Q==
X-Gm-Message-State: APjAAAUuVe5RU+8rKr/IZNgy+fptoFi9v3oauAxbPSWcRlLmT/aoyFrI
	BXnMgfoxPkYIgFY2CdUaCtLxjBpx8z/GO7VyPEI=
X-Google-Smtp-Source: APXvYqzoKSvtwc7h3YF+c3ClC8RRDwvQEOuO9vmMklmmZ6/J8nMaSUMmvks3o2VNkPh4WYQkviIc241SjZs7jn1Ep9c=
X-Received: by 2002:a17:906:2451:: with SMTP id
	a17mr16927007ejb.164.1568130338310; 
	Tue, 10 Sep 2019 08:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190907175013.24246-1-robdclark@gmail.com>
	<418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
In-Reply-To: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 10 Sep 2019 08:45:27 -0700
Message-ID: <CAF6AEGtd7kr2MckVy99ERQs4gmxjY6DteNdTLknBgpAZRpDgrA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: fix "hang" when games exit
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Sep 10, 2019 at 8:01 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 07/09/2019 18:50, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > When games, browser, or anything using a lot of GPU buffers exits, there
> > can be many hundreds or thousands of buffers to unmap and free.  If the
> > GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
> > for each buffer, resulting 5-10 seconds worth of reprogramming the
> > context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
> > To the user it would appear that the system is locked up.
> >
> > A simple solution is to use pm_runtime_put_autosuspend() instead, so we
> > don't immediately suspend the SMMU device.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > Note: I've tied the autosuspend enable/delay to the consumer device,
> > based on the reasoning that if the consumer device benefits from using
> > an autosuspend delay, then it's corresponding SMMU probably does too.
> > Maybe that is overkill and we should just unconditionally enable
> > autosuspend.
>
> I'm not sure there's really any reason to expect that a supplier's usage
> model when doing things for itself bears any relation to that of its
> consumer(s), so I'd certainly lean towards the "unconditional" argument
> myself.

Sounds good, I'll respin w/ unconditional autosuspend

> Of course ideally we'd skip resuming altogether in the map/unmap paths
> (since resume implies a full TLB reset anyway), but IIRC that approach
> started to get messy in the context of the initial RPM patchset. I'm
> planning to fiddle around a bit more to clean up the implementation of
> the new iommu_flush_ops stuff, so I've made a note to myself to revisit
> RPM to see if there's a sufficiently clean way to do better. In the
> meantime, though, I don't have any real objection to using some
> reasonable autosuspend delay on the principle that if we've been woken
> up to map/unmap one page, there's a high likelihood that more will
> follow in short order (and in the configuration slow-paths it won't have
> much impact either way).

It does sort of remind me about something I was chatting with Jordan
the other day.. about how we could possibly skip the TLB inv for
unmaps from non-current pagetables once we have per-context
pagetables.

The challenge is, since the GPU's command parser is the one switching
pagetables, we don't have any race-free way to know which pagetables
are current.  But we do know which contexts have work queued up for
the GPU, so we can know either that a given context definitely isn't
current, or that it might be current.  And in the "definitely not
current" case we could skip TLB inv.

BR,
-R

>
> Robin.
>
> >   drivers/iommu/arm-smmu.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index c2733b447d9c..73a0dd53c8a3 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -289,7 +289,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> >   static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> >   {
> >       if (pm_runtime_enabled(smmu->dev))
> > -             pm_runtime_put(smmu->dev);
> > +             pm_runtime_put_autosuspend(smmu->dev);
> >   }
> >
> >   static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> > @@ -1445,6 +1445,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >       /* Looks ok, so add the device to the domain */
> >       ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
> >
> > +#ifdef CONFIG_PM
> > +     /* TODO maybe device_link_add() should do this for us? */
> > +     if (dev->power.use_autosuspend) {
> > +             pm_runtime_set_autosuspend_delay(smmu->dev,
> > +                     dev->power.autosuspend_delay);
> > +             pm_runtime_use_autosuspend(smmu->dev);
> > +     }
> > +#endif
> > +
> >   rpm_put:
> >       arm_smmu_rpm_put(smmu);
> >       return ret;
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
