Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA477EC4
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730697969; cv=none; b=bZ0LCkOAgxQeS59CohTHY1aNQg8lNUcry2N7WPKEbBDls77c32wbyo232tvmSDM24A6Z/JpNPVIuxWW3NcpzRFYe0RJ+V/WKIl32izR9KuPPhbUiYZR1yyAkzMUpzUgFAK0D4QDQLA1z6XnXmVZVeGwrDIoMFf/7BlWouP6b3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730697969; c=relaxed/simple;
	bh=dWNIhD1V1CmcE+M1Nw9MmzfdOp1XLjIHF/Ap4qtWpBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9iDLC96tRdqT1phXnGg4H8BNAXOzS4UXEpYNUgARFDuzx8+lwobHYxIwCMMqq81rE+PewptvFKRZcHUdcWUQuE8QkFhSigD5cmtSkUYVn16ep/lJ0f1R7Iroed4vSlUcuuBg0tvUs4WychXSAUAJa5EFMxl+So5u1dKd+nA6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3XDTRA5f; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3XDTRA5f"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e19d8c41so15097e87.0
        for <iommu@lists.linux.dev>; Sun, 03 Nov 2024 21:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730697966; x=1731302766; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQudhkKhT+r5U2aONsEfuAV/CGXQzq7xmImAP1klNIc=;
        b=3XDTRA5fOFShWHBjdgtvlGyP1/XqNDTVw/pLj/22VHGycQtj/SnCIk+IUb7dpi+0fS
         f11FEX6I7QEDzyyMnHPfNuY/ywB95pmNmA15y10qCvemVBWcLRzLlk/VjxQq3Ra9JSlA
         adfVfIr7WsnL+wFzm0bC7Ihkcs4FsQ3MbVbBx9xqvPbrqMTYnUKysRKktrxF1BSlJQiU
         hFijiSWaAU4+beYELKbrzCfuO5eKlp//o15xNqzXDlj9Qy31v+D6pVz/QOPZBUeDnw7T
         pyojyxrxCyoLo2FnoGh4vTJsnZfFexPhxmGm00+jUbc9RieRSFYME+b2HuewBwDAIeO+
         +tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730697966; x=1731302766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQudhkKhT+r5U2aONsEfuAV/CGXQzq7xmImAP1klNIc=;
        b=IoagPfK0r4QGi+8jwZgQe6KA+RZDpIyk9yr+jORr39sknoMgCyI5ntaUN+3nVvOIFk
         2MyWlY2kkdeyA9SKEBb2I2jLoCKW6DUPvmeVj3dVorStTdtYi8mjcT63llNAk9ZuUvL7
         ybPtUuxTWgMl55kC3uqpZqsJtHoCHmoNEfzbfV3AKfKK4W4qEE3rcCsTqmHDr2gRUDDs
         gXKO5BTsR5gSKIC+o9yR4b7Zfk29DLiO0IDwzq2TCHZmWDfyU9ouJhToRGe5Ory9Bg7c
         TOMSUFz48uPLv2L3PdHfQXoJlj05MQ2HmRRQJocbry790CYJLrU3MBnnaPcWbyTDrcui
         fklw==
X-Forwarded-Encrypted: i=1; AJvYcCWgr6NDH+YZS0YAK746ImOtcpgsnKJ4cUn91pbbdhNccSHUKN61xWeoCFYqsCx+XA+uQW1jwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5PFzR4m23wuqRMVuv7f2CZPxONRy2i8Ahyx8k3SgzQo0Pi+uY
	5UkpMFOe+oSNjYErNpND2FbXa2XhpAV9u+XYykjqtq/5CLkbSWnvdCb46xpZAvNv8ExZUQuXqRp
	bfeoxiHEekRwypkyd/LRmvOx0tZLzVgDZae1l
X-Gm-Gg: ASbGnctmVKur972Kjplhphj2D+2XcKUmJvAheWfdJysM8vNbn4c+vr4U9bXKlYyyRg/
	POPl4+lL3B9/fOEHM8QFhI7Okd5e5wrQ1ciZ190efpPe9tnLCZrBMtpNAa8wj68OzQg==
X-Google-Smtp-Source: AGHT+IEk/rixu9jLm774RUrP8i1bl2kV/Ou9nv5Xa7HLgxcuxJzQLLUg4BJa4ZbFHqRyc0m1DQuyh67Ve1T4JvPJAJ0=
X-Received: by 2002:a05:6512:2019:b0:536:88d0:420d with SMTP id
 2adb3069b0e04-53d6acfb187mr332132e87.6.1730697965520; Sun, 03 Nov 2024
 21:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241018180022.807928-1-praan@google.com> <20241018180022.807928-2-praan@google.com>
 <7c7b905c-ee00-4333-987e-0d0f0e45753f@arm.com> <ZyTu6tNO8gaSqKSy@google.com>
In-Reply-To: <ZyTu6tNO8gaSqKSy@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 3 Nov 2024 21:25:52 -0800
Message-ID: <CAE2F3rCWV76hfU06SCZoA3HW90YBQZVcXaDD0P-beDtTaJhKGA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 8:08=E2=80=AFAM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> On Fri, Nov 01, 2024 at 02:41:07PM +0000, Robin Murphy wrote:
> > On 2024-10-18 7:00 pm, Pranjal Shrivastava wrote:
> > > Introduce `struct arm_smmu_event` to represent event records.
> > > Parse out relevant fields from raw event records for ease and
> > > use the new `struct arm_smmu_event` instead.
> > >
> > > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 59 ++++++++++++++----=
---
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 20 +++++++
> > >   2 files changed, 59 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/io=
mmu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 737c5b882355..2f1108e5de51 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -1757,17 +1757,16 @@ arm_smmu_find_master(struct arm_smmu_device *=
smmu, u32 sid)
> > >   }
> > >   /* IRQ and event handlers */
> > > -static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *ev=
t)
> > > +static int arm_smmu_handle_evt(struct arm_smmu_event *event)
> > >   {
> > >     int ret =3D 0;
> > >     u32 perm =3D 0;
> > >     struct arm_smmu_master *master;
> > > -   bool ssid_valid =3D evt[0] & EVTQ_0_SSV;
> > > -   u32 sid =3D FIELD_GET(EVTQ_0_SID, evt[0]);
> > >     struct iopf_fault fault_evt =3D { };
> > > +   struct arm_smmu_device *smmu =3D event->smmu;
> > >     struct iommu_fault *flt =3D &fault_evt.fault;
> > > -   switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> > > +   switch (event->id) {
> > >     case EVT_ID_TRANSLATION_FAULT:
> > >     case EVT_ID_ADDR_SIZE_FAULT:
> > >     case EVT_ID_ACCESS_FAULT:
> > > @@ -1777,35 +1776,35 @@ static int arm_smmu_handle_evt(struct arm_smm=
u_device *smmu, u64 *evt)
> > >             return -EOPNOTSUPP;
> > >     }
> > > -   if (!(evt[1] & EVTQ_1_STALL))
> > > +   if (!event->stall)
> > >             return -EOPNOTSUPP;
> > > -   if (evt[1] & EVTQ_1_RnW)
> > > +   if (event->read)
> > >             perm |=3D IOMMU_FAULT_PERM_READ;
> > >     else
> > >             perm |=3D IOMMU_FAULT_PERM_WRITE;
> > > -   if (evt[1] & EVTQ_1_InD)
> > > +   if (event->instruction)
> > >             perm |=3D IOMMU_FAULT_PERM_EXEC;
> > > -   if (evt[1] & EVTQ_1_PnU)
> > > +   if (event->privileged)
> > >             perm |=3D IOMMU_FAULT_PERM_PRIV;
> > >     flt->type =3D IOMMU_FAULT_PAGE_REQ;
> > >     flt->prm =3D (struct iommu_fault_page_request) {
> > >             .flags =3D IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > > -           .grpid =3D FIELD_GET(EVTQ_1_STAG, evt[1]),
> > > +           .grpid =3D event->stag,
> > >             .perm =3D perm,
> > > -           .addr =3D FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > > +           .addr =3D event->iova,
> > >     };
> > > -   if (ssid_valid) {
> > > +   if (event->ssid_valid) {
> > >             flt->prm.flags |=3D IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > > -           flt->prm.pasid =3D FIELD_GET(EVTQ_0_SSID, evt[0]);
> > > +           flt->prm.pasid =3D event->ssid;
> > >     }
> > >     mutex_lock(&smmu->streams_mutex);
> > > -   master =3D arm_smmu_find_master(smmu, sid);
> > > +   master =3D arm_smmu_find_master(smmu, event->sid);
> > >     if (!master) {
> > >             ret =3D -EINVAL;
> > >             goto out_unlock;
> > > @@ -1817,28 +1816,48 @@ static int arm_smmu_handle_evt(struct arm_smm=
u_device *smmu, u64 *evt)
> > >     return ret;
> > >   }
> > > +static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu=
,
> > > +                                   struct arm_smmu_event *event)
> >
> > One would kind of expect "get event from raw" to take a raw thing and r=
eturn
> > an event... personally I'd still just inline this in arm_smmu_handle_ev=
t()
>
> Hmm.. I think we can do both of those things.
>
> We can kzalloc struct arm_smmu_event and return it, that should also
> reduce the stack size. However, I'm unsure if that'd slow things down
> because kzalloc may be a little more expensive than a local variable..

I don't think stack size is a concern here. Therefore, I would advise
against kzalloc. Keep it simple by allocating on the stack.

> For the inlining, just to ensure I understand, we're looking to keep the
> old arm_smmu_handle_evt(smmu, raw_evt) as is and then decode the event
> within arm_smmu_handle_evt before we start handling it, right?
>
> I'm fine with both of the suggestions above, let me know your vote?
>
> > itself, but otherwise something like arm_smmu_decode_evt() would seem a=
 more
> > logical and obvious name at this point.
> >
> > > +{
> > > +   /* Pick out the good stuff */

I'd remove this comment.

> > > +   event->id =3D FIELD_GET(EVTQ_0_ID, event->raw[0]);
> > > +   event->sid =3D FIELD_GET(EVTQ_0_SID, event->raw[0]);
> > > +   event->ssid_valid =3D event->raw[0] & EVTQ_0_SSV;
> > > +   event->ssid =3D event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, event-=
>raw[0]) : IOMMU_NO_PASID;
> > > +   event->privileged =3D FIELD_GET(EVTQ_1_PnU, event->raw[1]);
> > > +   event->instruction =3D FIELD_GET(EVTQ_1_InD, event->raw[1]);
> > > +   event->s2 =3D FIELD_GET(EVTQ_1_S2, event->raw[1]);
> > > +   event->read =3D FIELD_GET(EVTQ_1_RnW, event->raw[1]);
> > > +   event->stag =3D FIELD_GET(EVTQ_1_STAG, event->raw[1]);
> > > +   event->stall =3D event->raw[1] & EVTQ_1_STALL;
> > > +   event->class =3D FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
> > > +   event->iova =3D FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
> > > +   event->ipa =3D FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> > > +   event->smmu =3D smmu;
> >
> > The SMMU pointer isn't part of the raw event record... TBH I'd be incli=
ned
> > to leave it entirely separate, but if you really do want to hide it in =
the
> > arm_smmu_event, at least keep things simple and initialise it outside t=
he
> > loop - it's not like it's ever going to change between events.
>
> Yea.. honestly, just init-ing one member at a different time makes it
> look a little weird if we allocate `arm_smmu_event` dynamically.
> If we go ahead with allocating the `arm_smmu_event` using k*alloc, I
> think it's best to remove the `smmu` member from the struct and pass it
> around in functions.

I am in favor of removing the smmu member from struct arm_smmu_event.
That would be consistent with other structs like arm_smmu_cmdq and
arm_smmu_queue_poll.

>
> >
> > Thanks,
> > Robin.
> >
>
> Thanks,
> Praan
>
> > > +}
> > > +
> > >   static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> > >   {
> > >     int i, ret;
> > > +   struct arm_smmu_event evt;
> > >     struct arm_smmu_device *smmu =3D dev;
> > >     struct arm_smmu_queue *q =3D &smmu->evtq.q;
> > >     struct arm_smmu_ll_queue *llq =3D &q->llq;
> > >     static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > >                                   DEFAULT_RATELIMIT_BURST);
> > > -   u64 evt[EVTQ_ENT_DWORDS];
> > >     do {
> > > -           while (!queue_remove_raw(q, evt)) {
> > > -                   u8 id =3D FIELD_GET(EVTQ_0_ID, evt[0]);
> > > +           while (!queue_remove_raw(q, evt.raw)) {
> > > -                   ret =3D arm_smmu_handle_evt(smmu, evt);
> > > +                   arm_smmu_get_event_from_raw(smmu, &evt);
> > > +                   ret =3D arm_smmu_handle_evt(&evt);
> > >                     if (!ret || !__ratelimit(&rs))
> > >                             continue;
> > > -                   dev_info(smmu->dev, "event 0x%02x received:\n", i=
d);
> > > -                   for (i =3D 0; i < ARRAY_SIZE(evt); ++i)
> > > +                   dev_info(smmu->dev, "event 0x%02x received:\n", e=
vt.id);
> > > +                   for (i =3D 0; i < EVTQ_ENT_DWORDS; ++i)
> > >                             dev_info(smmu->dev, "\t0x%016llx\n",
> > > -                                    (unsigned long long)evt[i]);
> > > +                                   (unsigned long long)evt.raw[i]);
> > >                     cond_resched();
> > >             }
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/io=
mmu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > index 1e9952ca989f..8a42d7b701fb 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > @@ -437,6 +437,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(=
unsigned int ssid)
> > >   #define EVTQ_0_ID                 GENMASK_ULL(7, 0)
> > > +/* Events */

I'd remove this comment.

> > >   #define EVT_ID_TRANSLATION_FAULT  0x10
> > >   #define EVT_ID_ADDR_SIZE_FAULT            0x11
> > >   #define EVT_ID_ACCESS_FAULT               0x12
> > > @@ -452,6 +453,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(=
unsigned int ssid)
> > >   #define EVTQ_1_RnW                        (1UL << 35)
> > >   #define EVTQ_1_S2                 (1UL << 39)
> > >   #define EVTQ_1_CLASS                      GENMASK_ULL(41, 40)
> > > +#define EVTQ_1_CLASS_TT                    0x1

Remove this if it's not used anywhere.

> > >   #define EVTQ_1_TT_READ                    (1UL << 44)
> > >   #define EVTQ_2_ADDR                       GENMASK_ULL(63, 0)
> > >   #define EVTQ_3_IPA                        GENMASK_ULL(51, 12)
> > > @@ -771,6 +773,24 @@ struct arm_smmu_stream {
> > >     struct rb_node                  node;
> > >   };
> > > +struct arm_smmu_event {
> > > +   struct arm_smmu_device          *smmu;
> > > +   u8                              id;
> > > +   u8                              class;
> > > +   u16                             stag;
> > > +   u32                             sid;
> > > +   u32                             ssid;
> > > +   u64                             iova;
> > > +   u64                             ipa;
> > > +   u64                             raw[EVTQ_ENT_DWORDS];
> > > +   bool                            stall;
> > > +   bool                            ssid_valid;

In arm_smmu_handle_ppr(), the name ssv is used instead of ssid_valid.
For consistent naming, consider ssv. I don't have a strong opinion on
this, though.

> > > +   bool                            privileged;
> > > +   bool                            instruction;
> > > +   bool                            s2;
> > > +   bool                            read;
> > > +};
> > > +
> > >   /* SMMU private data for each master */
> > >   struct arm_smmu_master {
> > >     struct arm_smmu_device          *smmu;
> >
