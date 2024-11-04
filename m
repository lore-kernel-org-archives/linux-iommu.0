Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024CB18A937
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709109; cv=none; b=kNq8frn3iNpwphlHtIpWRV+GNEsVYC6V8FrA9/Ci8jTxGJ3KDPds9Cg9RCHXWcvCnt9cpBIuNu5C6ASTpDVvvWbT/n9qmM6ZMMd53XiRHnRqbXgSdmsat9nk3uk25H9j+d9aiEYmUNyM5RRs1SQ33EjEv6BaipPqIW4sYzsEmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709109; c=relaxed/simple;
	bh=D/m8hnTFNVxvo1k4UZ7AwbtotT/Wm+l5LJFPuiOJ7JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL54gxIh1J2CwQBMK7ECbVhuccs+GbjO4jXtF3QKXYlrp4f3v/c/eutr86Lk5GuOO4i/8Iiu/JHN8guJmpecac8WRtd7LFj/uOLcRnIe55L7yMEPBbrYEI6WNFmCvcJB6aznarYjCNzBDL+VxB85L22lOQ8ubkqY7v/jJ13dzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ki7uln0k; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ki7uln0k"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca03687fdso184845ad.0
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 00:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730709107; x=1731313907; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B6k01Yj4j9wtyfjHeDiIuyZOH1kpLVbfOyh54tGzjPI=;
        b=Ki7uln0kDekzZ5I2a2V+/dxpaUXUFm/SDDOttbMh8koHHmzidoD2EVTUggMK3pG3qT
         110z3EPX4VQ7PwURc5GAgV1dZ6cEZUI2krqhCDMV/vME+EX/iLg53IiDO2EK6cK1uFjj
         G6ZkFNimfonxjxG+JLkS7sO2b7tDF9/vIVXaQMVw1e7e1hXJuZUwmpC0WoFYHgEx2xp1
         yAW8dFwjBhfPJzpO8eR13WwNN9rSvywaM/SQO28evZicIPxE6jFKOvhqykAhD/QbeYYt
         1Ufw5kBwToJjxFvOxE11w3iX9yuGCIKcic6tfF04CBiZEVgV4xypcMU+YGX9OoBNP4tM
         L4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709107; x=1731313907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6k01Yj4j9wtyfjHeDiIuyZOH1kpLVbfOyh54tGzjPI=;
        b=SOPUyXj0TuhN2nDb/0UIOPtAeA6ekJSCEaH94pE4AyhpY2fWEJzDvppop2MUydxdoQ
         xoxVoUO/DZ6P+8Re80w2SJNJ2iteXuPDuF/IB2iwtqPi7ibispjZ+tqFi4wLADHIi8tQ
         bX9wH2EhFhmIk6ImTqQzosioNk3YAVZw+6RGY6H4LI0TJtJw7Pij918thi/1pYgRErGs
         AAPtjzlMjkexb2FSYxMEUVceCvA20WGcYai8vxsUusXY6S9GWnY+yNDjGIYScQdtjpE/
         jsHVgEEiAHj/FvDmaSD3qbyKgQlK43Oo3cIKJf9Tln23qAFDsNPP5auUZRkixL+zaLdY
         q8IA==
X-Forwarded-Encrypted: i=1; AJvYcCWGp1dmDNiD2kQWKOTA0o2n3oeAEGt4oaXEdMMaLo9XyNC175GVSXTTqX0CtQ/QSXPniM04Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrI3iMC1tc+HL5R4A3Q2XHSQQDJnwXHgQXrwzflaENlFo9cUIx
	UVQb57Dwd21Z1hisRrpYix6j4DRFQrQCJLbtw2L8UsmCVEy79AaNeS/Vi3c62Q==
X-Gm-Gg: ASbGncs9WHK1fdyrFkgMyY02Ap51+FiSPMkPnnvpH/+HaY8DPAql9d+29jfe92/g6Re
	Z9zDhhutWkXdCNwEyWV/m6TzsGz8drB7K5skgm2rAE+4LGCM2Du6Vt3gxAQex9E16KqddXQkIzS
	9wLfu1Bp2tqTyifRTpqcy3AUf69jDhkAobk8Rp1h1CBSUSKoFOpIqdqpl7nPutyNyhpLucTR+40
	JDdPFV8mww/YDlP6auKJw0Uy4m63hxPSftDLHbc+64L40RfJuUPmytgTRc4a3WyhD+6PFVydwkw
	fIDsmP0A4zI=
X-Google-Smtp-Source: AGHT+IH6WMG/5n6FItf94T80G2/nM2UT3TVUUJnpjJOoRzjV2N/7aO0E/6iwOXG18hM8/O/fyKaRkg==
X-Received: by 2002:a17:902:ce8b:b0:20c:eb70:6a5b with SMTP id d9443c01a7336-2113270d117mr2694505ad.14.1730709106988;
        Mon, 04 Nov 2024 00:31:46 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2c0dsm56049615ad.136.2024.11.04.00.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:31:46 -0800 (PST)
Date: Mon, 4 Nov 2024 08:31:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZyiGa0sC1MfCu17r@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <7c7b905c-ee00-4333-987e-0d0f0e45753f@arm.com>
 <ZyTu6tNO8gaSqKSy@google.com>
 <CAE2F3rCWV76hfU06SCZoA3HW90YBQZVcXaDD0P-beDtTaJhKGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCWV76hfU06SCZoA3HW90YBQZVcXaDD0P-beDtTaJhKGA@mail.gmail.com>

On Sun, Nov 03, 2024 at 09:25:52PM -0800, Daniel Mentz wrote:
> On Fri, Nov 1, 2024 at 8:08 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Fri, Nov 01, 2024 at 02:41:07PM +0000, Robin Murphy wrote:
> > > On 2024-10-18 7:00 pm, Pranjal Shrivastava wrote:
> > > > Introduce `struct arm_smmu_event` to represent event records.
> > > > Parse out relevant fields from raw event records for ease and
> > > > use the new `struct arm_smmu_event` instead.
> > > >
> > > > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > > ---
> > > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 59 ++++++++++++++-------
> > > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 20 +++++++
> > > >   2 files changed, 59 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index 737c5b882355..2f1108e5de51 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -1757,17 +1757,16 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> > > >   }
> > > >   /* IRQ and event handlers */
> > > > -static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> > > > +static int arm_smmu_handle_evt(struct arm_smmu_event *event)
> > > >   {
> > > >     int ret = 0;
> > > >     u32 perm = 0;
> > > >     struct arm_smmu_master *master;
> > > > -   bool ssid_valid = evt[0] & EVTQ_0_SSV;
> > > > -   u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > > >     struct iopf_fault fault_evt = { };
> > > > +   struct arm_smmu_device *smmu = event->smmu;
> > > >     struct iommu_fault *flt = &fault_evt.fault;
> > > > -   switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> > > > +   switch (event->id) {
> > > >     case EVT_ID_TRANSLATION_FAULT:
> > > >     case EVT_ID_ADDR_SIZE_FAULT:
> > > >     case EVT_ID_ACCESS_FAULT:
> > > > @@ -1777,35 +1776,35 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> > > >             return -EOPNOTSUPP;
> > > >     }
> > > > -   if (!(evt[1] & EVTQ_1_STALL))
> > > > +   if (!event->stall)
> > > >             return -EOPNOTSUPP;
> > > > -   if (evt[1] & EVTQ_1_RnW)
> > > > +   if (event->read)
> > > >             perm |= IOMMU_FAULT_PERM_READ;
> > > >     else
> > > >             perm |= IOMMU_FAULT_PERM_WRITE;
> > > > -   if (evt[1] & EVTQ_1_InD)
> > > > +   if (event->instruction)
> > > >             perm |= IOMMU_FAULT_PERM_EXEC;
> > > > -   if (evt[1] & EVTQ_1_PnU)
> > > > +   if (event->privileged)
> > > >             perm |= IOMMU_FAULT_PERM_PRIV;
> > > >     flt->type = IOMMU_FAULT_PAGE_REQ;
> > > >     flt->prm = (struct iommu_fault_page_request) {
> > > >             .flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > > > -           .grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> > > > +           .grpid = event->stag,
> > > >             .perm = perm,
> > > > -           .addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > > > +           .addr = event->iova,
> > > >     };
> > > > -   if (ssid_valid) {
> > > > +   if (event->ssid_valid) {
> > > >             flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > > > -           flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
> > > > +           flt->prm.pasid = event->ssid;
> > > >     }
> > > >     mutex_lock(&smmu->streams_mutex);
> > > > -   master = arm_smmu_find_master(smmu, sid);
> > > > +   master = arm_smmu_find_master(smmu, event->sid);
> > > >     if (!master) {
> > > >             ret = -EINVAL;
> > > >             goto out_unlock;
> > > > @@ -1817,28 +1816,48 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> > > >     return ret;
> > > >   }
> > > > +static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> > > > +                                   struct arm_smmu_event *event)
> > >
> > > One would kind of expect "get event from raw" to take a raw thing and return
> > > an event... personally I'd still just inline this in arm_smmu_handle_evt()
> >
> > Hmm.. I think we can do both of those things.
> >
> > We can kzalloc struct arm_smmu_event and return it, that should also
> > reduce the stack size. However, I'm unsure if that'd slow things down
> > because kzalloc may be a little more expensive than a local variable..
> 
> I don't think stack size is a concern here. Therefore, I would advise
> against kzalloc. Keep it simple by allocating on the stack.
> 

Ack. That's my preference as well, in that case I'll just rename it to
"arm_smmu_decode_event" as suggested by Robin.

> > For the inlining, just to ensure I understand, we're looking to keep the
> > old arm_smmu_handle_evt(smmu, raw_evt) as is and then decode the event
> > within arm_smmu_handle_evt before we start handling it, right?
> >
> > I'm fine with both of the suggestions above, let me know your vote?
> >
> > > itself, but otherwise something like arm_smmu_decode_evt() would seem a more
> > > logical and obvious name at this point.
> > >
> > > > +{
> > > > +   /* Pick out the good stuff */
> 
> I'd remove this comment.
> 

Ack.

> > > > +   event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
> > > > +   event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> > > > +   event->ssid_valid = event->raw[0] & EVTQ_0_SSV;
> > > > +   event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, event->raw[0]) : IOMMU_NO_PASID;
> > > > +   event->privileged = FIELD_GET(EVTQ_1_PnU, event->raw[1]);
> > > > +   event->instruction = FIELD_GET(EVTQ_1_InD, event->raw[1]);
> > > > +   event->s2 = FIELD_GET(EVTQ_1_S2, event->raw[1]);
> > > > +   event->read = FIELD_GET(EVTQ_1_RnW, event->raw[1]);
> > > > +   event->stag = FIELD_GET(EVTQ_1_STAG, event->raw[1]);
> > > > +   event->stall = event->raw[1] & EVTQ_1_STALL;
> > > > +   event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
> > > > +   event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
> > > > +   event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> > > > +   event->smmu = smmu;
> > >
> > > The SMMU pointer isn't part of the raw event record... TBH I'd be inclined
> > > to leave it entirely separate, but if you really do want to hide it in the
> > > arm_smmu_event, at least keep things simple and initialise it outside the
> > > loop - it's not like it's ever going to change between events.
> >
> > Yea.. honestly, just init-ing one member at a different time makes it
> > look a little weird if we allocate `arm_smmu_event` dynamically.
> > If we go ahead with allocating the `arm_smmu_event` using k*alloc, I
> > think it's best to remove the `smmu` member from the struct and pass it
> > around in functions.
> 
> I am in favor of removing the smmu member from struct arm_smmu_event.
> That would be consistent with other structs like arm_smmu_cmdq and
> arm_smmu_queue_poll.
> 

Ack. In that case, let's just remove it. At this point, I don't see any
benefit in hiding it within `arm_smmu_event`. 

> >
> > >
> > > Thanks,
> > > Robin.
> > >
> >
> > Thanks,
> > Praan
> >
> > > > +}
> > > > +
> > > >   static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> > > >   {
> > > >     int i, ret;
> > > > +   struct arm_smmu_event evt;
> > > >     struct arm_smmu_device *smmu = dev;
> > > >     struct arm_smmu_queue *q = &smmu->evtq.q;
> > > >     struct arm_smmu_ll_queue *llq = &q->llq;
> > > >     static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > > >                                   DEFAULT_RATELIMIT_BURST);
> > > > -   u64 evt[EVTQ_ENT_DWORDS];
> > > >     do {
> > > > -           while (!queue_remove_raw(q, evt)) {
> > > > -                   u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > > > +           while (!queue_remove_raw(q, evt.raw)) {
> > > > -                   ret = arm_smmu_handle_evt(smmu, evt);
> > > > +                   arm_smmu_get_event_from_raw(smmu, &evt);
> > > > +                   ret = arm_smmu_handle_evt(&evt);
> > > >                     if (!ret || !__ratelimit(&rs))
> > > >                             continue;
> > > > -                   dev_info(smmu->dev, "event 0x%02x received:\n", id);
> > > > -                   for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > > > +                   dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> > > > +                   for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > > >                             dev_info(smmu->dev, "\t0x%016llx\n",
> > > > -                                    (unsigned long long)evt[i]);
> > > > +                                   (unsigned long long)evt.raw[i]);
> > > >                     cond_resched();
> > > >             }
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > index 1e9952ca989f..8a42d7b701fb 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > @@ -437,6 +437,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> > > >   #define EVTQ_0_ID                 GENMASK_ULL(7, 0)
> > > > +/* Events */
> 
> I'd remove this comment.
> 

Ack.

> > > >   #define EVT_ID_TRANSLATION_FAULT  0x10
> > > >   #define EVT_ID_ADDR_SIZE_FAULT            0x11
> > > >   #define EVT_ID_ACCESS_FAULT               0x12
> > > > @@ -452,6 +453,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> > > >   #define EVTQ_1_RnW                        (1UL << 35)
> > > >   #define EVTQ_1_S2                 (1UL << 39)
> > > >   #define EVTQ_1_CLASS                      GENMASK_ULL(41, 40)
> > > > +#define EVTQ_1_CLASS_TT                    0x1
> 
> Remove this if it's not used anywhere.
> 

We're using it in `arm_smmu_get_event_from_raw` function for TTRnW:

+	if (event->id == EVT_ID_PERMISSION_FAULT)
+		event->ttrnw_valid = (event->class == EVTQ_1_CLASS_TT);

> > > >   #define EVTQ_1_TT_READ                    (1UL << 44)
> > > >   #define EVTQ_2_ADDR                       GENMASK_ULL(63, 0)
> > > >   #define EVTQ_3_IPA                        GENMASK_ULL(51, 12)
> > > > @@ -771,6 +773,24 @@ struct arm_smmu_stream {
> > > >     struct rb_node                  node;
> > > >   };
> > > > +struct arm_smmu_event {
> > > > +   struct arm_smmu_device          *smmu;
> > > > +   u8                              id;
> > > > +   u8                              class;
> > > > +   u16                             stag;
> > > > +   u32                             sid;
> > > > +   u32                             ssid;
> > > > +   u64                             iova;
> > > > +   u64                             ipa;
> > > > +   u64                             raw[EVTQ_ENT_DWORDS];
> > > > +   bool                            stall;
> > > > +   bool                            ssid_valid;
> 
> In arm_smmu_handle_ppr(), the name ssv is used instead of ssid_valid.
> For consistent naming, consider ssv. I don't have a strong opinion on
> this, though.
> 

Hmm. I was referring to `arm_smmu_handle_evt` which used `ssid_valid`,
looks like there's some inconsistency across the file... Regardless, I
don't mind changing it to `ssv`, unless someone has an objection?

> > > > +   bool                            privileged;
> > > > +   bool                            instruction;
> > > > +   bool                            s2;
> > > > +   bool                            read;
> > > > +};
> > > > +
> > > >   /* SMMU private data for each master */
> > > >   struct arm_smmu_master {
> > > >     struct arm_smmu_device          *smmu;
> > >


Thanks,
Praan
