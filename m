Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559111B85CF
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473730; cv=none; b=LPfx5FZNTgtPv2c4Vl8YomQmdHYlZpnxYJd461iNErc3yXBAMbefqEnP8VfEo3rldfwREW4YO1NfGV+3t5vW9R3OGO0bJFVan4kQRghj/AK27e6tff7ss15c+LY6FjP0cFqTYrSzX4h9p4ork1JhEs39nOjCHg8k74VFVSLYH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473730; c=relaxed/simple;
	bh=DZxYKw2QijbX1zcqLj82dwsdVpOyISWdgjDjXv8KZsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D37WEBRG1CQpmttt4jfTTOV7AlxOS6jxTTK+jYy26ZpRKjB0vSVnTuWM6hllefZ/dPjKD2FOjiYGTyHu/Qr/8WDBzxohFqKurZFSJfPLNEnaNZDmkcmkPxakXChT6hlzeW97+y7zxRy7wAGVT7Ub9jVfEUcjEiSegNbl3SyZIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lcEk894p; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcEk894p"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c8ac50b79so96385ad.0
        for <iommu@lists.linux.dev>; Fri, 01 Nov 2024 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730473721; x=1731078521; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i64w+NNWTqLv8ccdt8cpDy0gdjd7Q/PdlFO0K7miF7U=;
        b=lcEk894p7XfZ6v7g8nLIKkCQjkv8u3POHRER5oZD5IKxUkZozWZ7cwy2FVy+4Wcai8
         LUS9tSTKS5gUTSlNaTNYEXHNYa5TXWcdpPAhm+oejjpeSqczkZh9WordHZD15PE/FrGM
         FMOOrs28dEJua1qEdAAl8StgIe7O+Iu8mqOoThIxYtpRf1IF5eHFKxlhquSOQWtl+yPB
         04jvK4ZiBtwKDJW76pFyIkSKqQE5EQy7rDsQI0Sv+Fko5AJarmgix0kwG3amaTWaOLW0
         nFt69TCL0XAAoVnW/RbpbK6q54OO0kQ7ct/d0QvzjDPK6sRrfKIzJ93S1QslI+LE7bTG
         45MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473721; x=1731078521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i64w+NNWTqLv8ccdt8cpDy0gdjd7Q/PdlFO0K7miF7U=;
        b=KUb9CR8k+ntPBD9ld73FhoOpJWMEnjXrKcWeNxoMypuT2wFADhUIz+2pD8sa0AcNE3
         1SIg7G9hxCCu2pGtbIWkvYcNll+5hYRkoV9FA1zjxOXcEe+ln/WPsW649tYZ0Ic9Khrx
         yL+nM9NJ95cRTHcvXV5wubehB4a4wqeyN66cI/axGj6plZEKUXZRMsmafiZO+Q9VZJUG
         D+OsChmm6i2/sGAiM6aAK+WHg3PvkpRDaXmwCoYo6ATOl1sfgv8wp2eIN8dZAD8AlwiS
         Snkh38uq3nH2JkMNhNG9srcK3og/0Hf79sfjPwIRYV/x9KDGrJIxh/BSF9h3cCnjtJqM
         DmWw==
X-Forwarded-Encrypted: i=1; AJvYcCVGKBuFSYml/hJSmfvjWXLzJmH31RojGMaKIxijh5Kf4JvZBq7z9WcALJ5illTM9s7wsbf62Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBICI5cJllfkn/9rXlxf/oCmM+3XZFsC+q2PG+TG7066XeIQOj
	wkPUVKoYTMbH72u3FqOLmV+GGc8w13dRIN1J8e+lIeGSdc9Ua4zMy1Kd+u2GoA==
X-Gm-Gg: ASbGncs1IMVaLwgsq99pn7XCbz0vo0su5eNqg5yD/3Ff6gWKbbp8BQzm5DVJDgijvBK
	MMo7goH0lx14cwivLNx0YX1BQ2ABXu1L+wq1F8suavhix0/MBIqCCKrR9835JMLYoJx940BUpZQ
	kC0tSuNUBIeZBlDsVV2Fk+aiogcXp5Q9Rwmvlz+XboRtIUTWdsvpN3lzBobmJ3LpdAQvZ28v6DR
	SZsCxB+sULDaBTjtL7XGjpHdu/kUvJWaEr3QRZMo7IN74OCxmfcYjC4wutA/OR30a8B2a/faMAH
	Aa/IZTpNOO4=
X-Google-Smtp-Source: AGHT+IHuktw68BjfitfTHrPBS6734J1LK1xQGDiUkOenmYrj4LOVDwbUVBtWkXr+sJL5ZUXbinhj8w==
X-Received: by 2002:a17:903:1c4:b0:20c:f40e:6ec3 with SMTP id d9443c01a7336-2110442b809mr4820295ad.22.1730473720388;
        Fri, 01 Nov 2024 08:08:40 -0700 (PDT)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ef7d9sm2755733b3a.83.2024.11.01.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:08:39 -0700 (PDT)
Date: Fri, 1 Nov 2024 15:08:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZyTu6tNO8gaSqKSy@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <7c7b905c-ee00-4333-987e-0d0f0e45753f@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7b905c-ee00-4333-987e-0d0f0e45753f@arm.com>

On Fri, Nov 01, 2024 at 02:41:07PM +0000, Robin Murphy wrote:
> On 2024-10-18 7:00 pm, Pranjal Shrivastava wrote:
> > Introduce `struct arm_smmu_event` to represent event records.
> > Parse out relevant fields from raw event records for ease and
> > use the new `struct arm_smmu_event` instead.
> > 
> > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 59 ++++++++++++++-------
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 20 +++++++
> >   2 files changed, 59 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 737c5b882355..2f1108e5de51 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1757,17 +1757,16 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> >   }
> >   /* IRQ and event handlers */
> > -static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> > +static int arm_smmu_handle_evt(struct arm_smmu_event *event)
> >   {
> >   	int ret = 0;
> >   	u32 perm = 0;
> >   	struct arm_smmu_master *master;
> > -	bool ssid_valid = evt[0] & EVTQ_0_SSV;
> > -	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> >   	struct iopf_fault fault_evt = { };
> > +	struct arm_smmu_device *smmu = event->smmu;
> >   	struct iommu_fault *flt = &fault_evt.fault;
> > -	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> > +	switch (event->id) {
> >   	case EVT_ID_TRANSLATION_FAULT:
> >   	case EVT_ID_ADDR_SIZE_FAULT:
> >   	case EVT_ID_ACCESS_FAULT:
> > @@ -1777,35 +1776,35 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >   		return -EOPNOTSUPP;
> >   	}
> > -	if (!(evt[1] & EVTQ_1_STALL))
> > +	if (!event->stall)
> >   		return -EOPNOTSUPP;
> > -	if (evt[1] & EVTQ_1_RnW)
> > +	if (event->read)
> >   		perm |= IOMMU_FAULT_PERM_READ;
> >   	else
> >   		perm |= IOMMU_FAULT_PERM_WRITE;
> > -	if (evt[1] & EVTQ_1_InD)
> > +	if (event->instruction)
> >   		perm |= IOMMU_FAULT_PERM_EXEC;
> > -	if (evt[1] & EVTQ_1_PnU)
> > +	if (event->privileged)
> >   		perm |= IOMMU_FAULT_PERM_PRIV;
> >   	flt->type = IOMMU_FAULT_PAGE_REQ;
> >   	flt->prm = (struct iommu_fault_page_request) {
> >   		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > -		.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> > +		.grpid = event->stag,
> >   		.perm = perm,
> > -		.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > +		.addr = event->iova,
> >   	};
> > -	if (ssid_valid) {
> > +	if (event->ssid_valid) {
> >   		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > -		flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
> > +		flt->prm.pasid = event->ssid;
> >   	}
> >   	mutex_lock(&smmu->streams_mutex);
> > -	master = arm_smmu_find_master(smmu, sid);
> > +	master = arm_smmu_find_master(smmu, event->sid);
> >   	if (!master) {
> >   		ret = -EINVAL;
> >   		goto out_unlock;
> > @@ -1817,28 +1816,48 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >   	return ret;
> >   }
> > +static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> > +					struct arm_smmu_event *event)
> 
> One would kind of expect "get event from raw" to take a raw thing and return
> an event... personally I'd still just inline this in arm_smmu_handle_evt()

Hmm.. I think we can do both of those things.

We can kzalloc struct arm_smmu_event and return it, that should also
reduce the stack size. However, I'm unsure if that'd slow things down
because kzalloc may be a little more expensive than a local variable..

For the inlining, just to ensure I understand, we're looking to keep the
old arm_smmu_handle_evt(smmu, raw_evt) as is and then decode the event
within arm_smmu_handle_evt before we start handling it, right?

I'm fine with both of the suggestions above, let me know your vote?

> itself, but otherwise something like arm_smmu_decode_evt() would seem a more
> logical and obvious name at this point.
> 
> > +{
> > +	/* Pick out the good stuff */
> > +	event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
> > +	event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> > +	event->ssid_valid = event->raw[0] & EVTQ_0_SSV;
> > +	event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, event->raw[0]) : IOMMU_NO_PASID;
> > +	event->privileged = FIELD_GET(EVTQ_1_PnU, event->raw[1]);
> > +	event->instruction = FIELD_GET(EVTQ_1_InD, event->raw[1]);
> > +	event->s2 = FIELD_GET(EVTQ_1_S2, event->raw[1]);
> > +	event->read = FIELD_GET(EVTQ_1_RnW, event->raw[1]);
> > +	event->stag = FIELD_GET(EVTQ_1_STAG, event->raw[1]);
> > +	event->stall = event->raw[1] & EVTQ_1_STALL;
> > +	event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
> > +	event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
> > +	event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> > +	event->smmu = smmu;
> 
> The SMMU pointer isn't part of the raw event record... TBH I'd be inclined
> to leave it entirely separate, but if you really do want to hide it in the
> arm_smmu_event, at least keep things simple and initialise it outside the
> loop - it's not like it's ever going to change between events.

Yea.. honestly, just init-ing one member at a different time makes it
look a little weird if we allocate `arm_smmu_event` dynamically.
If we go ahead with allocating the `arm_smmu_event` using k*alloc, I
think it's best to remove the `smmu` member from the struct and pass it
around in functions.

> 
> Thanks,
> Robin.
> 

Thanks,
Praan

> > +}
> > +
> >   static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >   {
> >   	int i, ret;
> > +	struct arm_smmu_event evt;
> >   	struct arm_smmu_device *smmu = dev;
> >   	struct arm_smmu_queue *q = &smmu->evtq.q;
> >   	struct arm_smmu_ll_queue *llq = &q->llq;
> >   	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> >   				      DEFAULT_RATELIMIT_BURST);
> > -	u64 evt[EVTQ_ENT_DWORDS];
> >   	do {
> > -		while (!queue_remove_raw(q, evt)) {
> > -			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > +		while (!queue_remove_raw(q, evt.raw)) {
> > -			ret = arm_smmu_handle_evt(smmu, evt);
> > +			arm_smmu_get_event_from_raw(smmu, &evt);
> > +			ret = arm_smmu_handle_evt(&evt);
> >   			if (!ret || !__ratelimit(&rs))
> >   				continue;
> > -			dev_info(smmu->dev, "event 0x%02x received:\n", id);
> > -			for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > +			dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> > +			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> >   				dev_info(smmu->dev, "\t0x%016llx\n",
> > -					 (unsigned long long)evt[i]);
> > +					(unsigned long long)evt.raw[i]);
> >   			cond_resched();
> >   		}
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 1e9952ca989f..8a42d7b701fb 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -437,6 +437,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> >   #define EVTQ_0_ID			GENMASK_ULL(7, 0)
> > +/* Events */
> >   #define EVT_ID_TRANSLATION_FAULT	0x10
> >   #define EVT_ID_ADDR_SIZE_FAULT		0x11
> >   #define EVT_ID_ACCESS_FAULT		0x12
> > @@ -452,6 +453,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> >   #define EVTQ_1_RnW			(1UL << 35)
> >   #define EVTQ_1_S2			(1UL << 39)
> >   #define EVTQ_1_CLASS			GENMASK_ULL(41, 40)
> > +#define EVTQ_1_CLASS_TT			0x1
> >   #define EVTQ_1_TT_READ			(1UL << 44)
> >   #define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
> >   #define EVTQ_3_IPA			GENMASK_ULL(51, 12)
> > @@ -771,6 +773,24 @@ struct arm_smmu_stream {
> >   	struct rb_node			node;
> >   };
> > +struct arm_smmu_event {
> > +	struct arm_smmu_device		*smmu;
> > +	u8				id;
> > +	u8				class;
> > +	u16				stag;
> > +	u32				sid;
> > +	u32				ssid;
> > +	u64				iova;
> > +	u64				ipa;
> > +	u64				raw[EVTQ_ENT_DWORDS];
> > +	bool				stall;
> > +	bool				ssid_valid;
> > +	bool				privileged;
> > +	bool				instruction;
> > +	bool				s2;
> > +	bool				read;
> > +};
> > +
> >   /* SMMU private data for each master */
> >   struct arm_smmu_master {
> >   	struct arm_smmu_device		*smmu;
> 
