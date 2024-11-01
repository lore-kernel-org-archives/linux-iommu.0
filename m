Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD31C9DCB
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477202; cv=none; b=C4Yv+GGprO5rjsuoZ+G8EnoFiHO3rz53xnBVYJpARkeVOy6AbfiVmrGKOPmu8DdvedXWqSXL4MnvDgVsUjlfdjksQxqS9FC3812iI98IgSVNgermMLYdUjuXOCXeSKa9lLWTjOU6qQ8KDKHPo4JD6tGUVHuQCZwiL409MnA1MEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477202; c=relaxed/simple;
	bh=aELqG35CW4EgFeYtMHLvYhMjajjDPsPqDMUoxpPZlL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTk+g56XnxDBEI9MwpnwfwpOy34/BP2HsW1Tw7SpnLyVkg/ib8R+D22Q9y2zbk9D0gc7U/e/wF0XkgHO2iC+5PeRxzYqbezr0owHQtW9HYuHWVV+IZPeybPBjX9AfucI69fiPL1UKt9/pbB96R4tMGhIFG8M16/AK6MaIN6HnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSjTPcZa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSjTPcZa"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c87b0332cso127555ad.1
        for <iommu@lists.linux.dev>; Fri, 01 Nov 2024 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730477199; x=1731081999; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upDuMcffZLIWVLpwrhqzCB4aQE+kSBf9ifCnafhR95I=;
        b=sSjTPcZaPZ1LWrkSwmcq9yfaPfsJR07KfZDeD5nD1DckHgDfjsNL2+RB3d6U039YL9
         S5FbF6Cjh5eH+X7w1wip8DbgUuG2TfWCfie1GxFfipHEVP/U8H/AbxFUNMmqai33L90m
         wtoP6EdH/X2ef7X/iw4d4+wHevtUZ8daXKRDpTNI1GXb6IYfQaTPGyDnCBB/4qd7vwtW
         I71pCM3MFYX1Vw3uQSOfLMwynZJeejnFYJLi+4nAvv9lnU9a2m9uPmSSnrXkew8dEZP/
         lmf8xV0Fuy1lugtW8VCJMz2lNujq5s74HxVry+gntRR9+XUX/PTU0XaLW+eBzz6hCEJE
         ZGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730477199; x=1731081999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upDuMcffZLIWVLpwrhqzCB4aQE+kSBf9ifCnafhR95I=;
        b=ZzQsiq5/+plaE3BJforwaOuEfZJuYQQit6Ltxppjl/BZqzcY+m81TG0EnKJpfktaqW
         J2Vhl4ha2DbZEL2LygEFbVjrRGluWkLtJCAhWJtCf8K2L2Uyn/Nz1o8jZYaYvphXRJfk
         +o0AmCgOSfsczcEuHbXsVg9/wuX/B1DQHMAISwXc+DARDCYAPkmx9einjU+1iohLWmFx
         aq8NMHfkUqoH1ddkI10m4ktRH5MRwiQ7wkERJghKdrVTX46Dne9zLczz+NoEmUdFaRBZ
         GueZfjHc+PQQ93t5l5CYk23SPa/mhymVWh2i6Shmfz6aaS7H+pv/xoOMkKrS2ntUj2Az
         4Aqw==
X-Forwarded-Encrypted: i=1; AJvYcCX2aovDN1l2h0IKDDCLw/nsIgmfAezkGwsM5YFKUsSE7ejyRiSyAycanrcfmP7d0DmyXcg2Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvoCBHIfH4zkt/9t33VeG2azJVtg4Od79nn96U70t7UmvvuzQt
	UWMZO+KKAnNI5FwVcRuhUvgzoxdlxZ3lBauyBhzP/FYVWIY6OatvAkY5HZ22nw==
X-Gm-Gg: ASbGncuzj0BbRTpDcuCR2gVvLbZQtqzOFBuLHQbAd0daOIxEWCkFq+bLgIkaugbI1y9
	vpkxZL9yjAm1ZVAQITiacHYjvsui/KPx+n7G2o/xZpGULi8pTlIe+x4LkfSLUz5hE67SqefSJJT
	9Si2IIFYohCbFz/uJ28XtHD167xIOZAnS7J1urezWCopxgaOW48mYy3253WUl9d434o/CrwAo3O
	z+Q62Pdd1NNbfWox9X9+4LO6LeQX3VvjhX0UH5ZvfGXKzNSu+WitC/1hPlGppOZAcl0KOC2ewV5
	ftel9kdftYs=
X-Google-Smtp-Source: AGHT+IFICeu96pQO3RZDWuRwD9HnMlCW0ERMTIeUrWHPCTY0I5Ej9qIYly63jflhJJNcdEVrnygoGQ==
X-Received: by 2002:a17:903:1d1:b0:20c:79f1:fee2 with SMTP id d9443c01a7336-21104285d1fmr5057025ad.10.1730477198894;
        Fri, 01 Nov 2024 09:06:38 -0700 (PDT)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c498esm2877123b3a.97.2024.11.01.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:06:38 -0700 (PDT)
Date: Fri, 1 Nov 2024 16:06:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZyT8hzuV_xnXgpf-@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <08498356-d892-4756-89e1-45b2654faa42@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08498356-d892-4756-89e1-45b2654faa42@arm.com>

On Fri, Nov 01, 2024 at 03:05:24PM +0000, Robin Murphy wrote:
> On 2024-10-18 7:00 pm, Pranjal Shrivastava wrote:
> > Currently, the driver dumps the raw hex for a received event record.
> > Improve this by leveraging `struct arm_smmu_event` for event fields
> > and log human-readable event records with meaningful information.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
> >   2 files changed, 113 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 2f1108e5de51..4477cf86cb8e 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
> >   	{ 0, NULL},
> >   };
> > +static const char * const event_str[] = {
> > +	/* Bad config events */
> > +	[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> > +	[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> > +	[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> > +	[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> > +	[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> > +
> > +	/* Bad translation events */
> > +	[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> > +	[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> > +	[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> > +	[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> > +
> > +	/* Bad fetch events */
> > +	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> > +	[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> > +	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT",
> > +	[EVT_ID_MAX] = NULL,
> 
> "(null)" is not a particularly obvious or helpful description of an
> unknown/imp-def event.

We can either add all the event strings or have a null check before we
print, i.e. if the sting fetched is NULL we can print "UNKNOWN" or
something. I like the latter approach better, LMK what you think?

> 
> > +};
> > +
> > +static const char * const event_class_str[] = {
> > +	[0] = "CD fetch",
> > +	[1] = "Stage 1 translation table fetch",
> > +	[2] = "Input address caused fault ",
> 
> I'm wondering how to parse "caused fault" here, but either way it doesn't
> seem to line up with the other two descriptions.
> 

Hmm, this was added as per the review comments in v2 [1], it was decided
to keep the spec-defined strings for event_class as is, if we have a
strong preference against this, then maybe we can go ahead with the
following spec-defined abbreviations:

static const char * const class_str[] = {
	[0] = "CD",  // or "CD Fetch"
	[1] = "TTD", // or "S1 TT fetch"
	[2] = "IN",
	[3] = "RES",
};

> > +	[3] = "Reserved",
> > +};
> > +
> >   static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> >   				    struct arm_smmu_device *smmu, u32 flags);
> >   static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> > @@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> >   	return rb_entry(node, struct arm_smmu_stream, node)->master;
> >   }
> > +static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
> > +{
> > +	int i;
> > +	struct arm_smmu_device *smmu = event->smmu;
> > +
> > +	dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> 
> I'm mildly wary of automated parsing tools scanning for things like IOMMU
> faults, so I think it would be safest to leave any existing messages exactly
> as they are unless there's a particularly compelling reason to change them.
> And I don't believe that redundantly showing the same thing twice in one
> report is that.

Ack. Will leave this as is.

> 
> Arguably more personal preference, but as before with the v2 driver, I also
> think it seems neater and more logical to show the raw data first in the
> context of the notification, and then have the decode follow as a
> clarification.
> 

Ack. I'll log the raw event first and then the decoded message.
However, in the legacy log, we use dev_err for each dword which *may* be
interrupted by other logs, so should we have some message explaining
that the following is just a decoded version of the above log? 
For example:

[   85.411681] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x13 received: master 0000:00:01.0:
[   85.412045] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000013
[   85.412347] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
[   85.412630] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000ffffc0d0
[   85.412921] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[   85.410290] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x13: F_PERMISSION
[   85.410290]  master: 0000:00:01.0 sid: 0x00000008.0x00000
[   85.410290]  iova = 0xffffc0d0 ipa = 0x0
[   85.410290]  Unpriv | Data | Write | S1 | Input address caused fault
[   85.410290]  STAG = 0x0 Stall = 0x0

Personally, I think the above log looks better..

> > +		event->id, event->master_name);
> > +
> > +	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > +		dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
> > +}
> > +
> > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > +{
> > +	struct arm_smmu_device *smmu = evt->smmu;
> > +	char title[100] = {0};
> > +	char mastr[100] = {0};
> > +	char addrs[100] = {0};
> > +	char flags[100] = {0};
> > +	char other[50] = {0};
> > +
> > +	if (!__ratelimit(rs))
> > +		return;
> > +
> > +	snprintf(title, 100, "Unexpected event received: %s\n",	event_str[evt->id]);
> 
> ...that also makes it easier to avoid redundant waffle like this and look
> less like two separate things have happened.
> 

Ack. Please refer to the log above, I think it improves this as well..

> > +	snprintf(mastr, 100, "\tmaster: %s sid: 0x%08x.0x%05x\n",
> 
> TBH I find that StreamID format even harder to read than the raw event
> record itself :/
> 

Ouch! Nicolin didn't like this too :( 
I was just trying to follow the format used in the arm_smmu_handle_ppr
logs. Let's log the streamID and SSID separately then?
Maybe something like:

[   85.410290]  master: 0000:00:01.0 sid: 0x00000008 ssid: 0x00000

> > +		 evt->master_name, evt->sid, evt->ssid);
> > +
> > +	switch (evt->id) {
> > +	case EVT_ID_TRANSLATION_FAULT:
> > +	case EVT_ID_ADDR_SIZE_FAULT:
> > +	case EVT_ID_ACCESS_FAULT:
> > +	case EVT_ID_PERMISSION_FAULT:
> > +		snprintf(addrs, 100, "\tiova = %#llx ipa = %#llx\n", evt->iova, evt->ipa);
> > +		snprintf(other, 50, "\tSTAG = %#x Stall = %#x\n", evt->stag, evt->stall);
> > +		snprintf(flags, 100, "\t%s%s%s%s%s%s\n",
> > +			 evt->privileged ? "Priv | " : "Unpriv | ",
> > +			 evt->instruction ? "Inst | " : "Data | ",
> > +			 evt->read ? "Read | " : "Write | ",
> > +			 evt->s2 ? "S2 | " : "S1 | ", event_class_str[evt->class],
> > +			 evt->ttrnw_valid ? (evt->ttrnw ? "| TTD Read" : "| TTD Write") : "");
> 
> Why needlessly duplicate all the constant parts which could be in the format
> string itself?
> 

Umm.. I'm not sure I understand? Are you referring to the spaces and
the ' | ' characters?

> > +		break;
> > +
> > +	case EVT_ID_STE_FETCH_FAULT:
> > +	case EVT_ID_CD_FETCH_FAULT:
> > +	case EVT_ID_VMS_FETCH_FAULT:
> > +		snprintf(addrs, 100, "\tFetch address: %#llx\n", evt->ipa);
> > +		break;
> > +	}
> > +
> > +	dev_err(smmu->dev, "%s%s%s%s%s", title, mastr, addrs, flags, other);
> > +	arm_smmu_dump_raw_event(evt);
> > +}
> > +
> >   /* IRQ and event handlers */
> >   static int arm_smmu_handle_evt(struct arm_smmu_event *event)
> >   {
> > @@ -1819,6 +1901,8 @@ static int arm_smmu_handle_evt(struct arm_smmu_event *event)
> >   static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> >   					struct arm_smmu_event *event)
> >   {
> > +	struct arm_smmu_master *master;
> > +
> >   	/* Pick out the good stuff */
> >   	event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
> >   	event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> > @@ -1833,12 +1917,24 @@ static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> >   	event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
> >   	event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
> >   	event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> > +	event->ttrnw = FIELD_GET(EVTQ_1_TT_READ, event->raw[1]);
> > +	event->ttrnw_valid = false;
> >   	event->smmu = smmu;
> > +	event->dev = NULL;
> > +
> > +	if (event->id == EVT_ID_PERMISSION_FAULT)
> > +		event->ttrnw_valid = (event->class == EVTQ_1_CLASS_TT);
> > +
> > +	mutex_lock(&smmu->streams_mutex);
> > +	master = arm_smmu_find_master(smmu, event->sid);
> > +	if (master)
> > +		event->dev = get_device(master->dev);
> > +	mutex_unlock(&smmu->streams_mutex);
> > +	event->master_name = event->dev ? dev_name(event->dev) : "(unassigned sid)";
> 
> As I said before, this shouldn't be here; we've saved the device, so we can
> derive its name at the point where we actually need its name.

Ack, will move this within `arm_smmu_dump_event`

> 
> Thanks,
> Robin.
> 

Thanks,
Praan

[1] https://lore.kernel.org/linux-iommu/ZtZEFKnKasX6433r@Asurada-Nvidia/

> >   }
> >   static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >   {
> > -	int i, ret;
> >   	struct arm_smmu_event evt;
> >   	struct arm_smmu_device *smmu = dev;
> >   	struct arm_smmu_queue *q = &smmu->evtq.q;
> > @@ -1850,15 +1946,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >   		while (!queue_remove_raw(q, evt.raw)) {
> >   			arm_smmu_get_event_from_raw(smmu, &evt);
> > -			ret = arm_smmu_handle_evt(&evt);
> > -			if (!ret || !__ratelimit(&rs))
> > -				continue;
> > -
> > -			dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> > -			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > -				dev_info(smmu->dev, "\t0x%016llx\n",
> > -					(unsigned long long)evt.raw[i]);
> > +			if (arm_smmu_handle_evt(&evt))
> > +				arm_smmu_dump_event(&evt, &rs);
> > +			put_device(evt.dev);
> >   			cond_resched();
> >   		}
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 8a42d7b701fb..820b08f872af 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -438,10 +438,19 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> >   #define EVTQ_0_ID			GENMASK_ULL(7, 0)
> >   /* Events */
> > +#define EVT_ID_BAD_SID_CONFIG		0x02
> > +#define EVT_ID_STE_FETCH_FAULT		0x03
> > +#define EVT_ID_BAD_STE_CONFIG		0x04
> > +#define EVT_ID_STREAM_DISABLED		0x06
> > +#define EVT_ID_BAD_SSID_CONFIG		0x08
> > +#define EVT_ID_CD_FETCH_FAULT		0x09
> > +#define EVT_ID_BAD_CD_CONFIG		0x0a
> >   #define EVT_ID_TRANSLATION_FAULT	0x10
> >   #define EVT_ID_ADDR_SIZE_FAULT		0x11
> >   #define EVT_ID_ACCESS_FAULT		0x12
> >   #define EVT_ID_PERMISSION_FAULT		0x13
> > +#define EVT_ID_VMS_FETCH_FAULT		0x25
> > +#define EVT_ID_MAX			0xff
> >   #define EVTQ_0_SSV			(1UL << 11)
> >   #define EVTQ_0_SSID			GENMASK_ULL(31, 12)
> > @@ -774,7 +783,9 @@ struct arm_smmu_stream {
> >   };
> >   struct arm_smmu_event {
> > +	const char			*master_name;
> >   	struct arm_smmu_device		*smmu;
> > +	struct device			*dev;
> >   	u8				id;
> >   	u8				class;
> >   	u16				stag;
> > @@ -789,6 +800,8 @@ struct arm_smmu_event {
> >   	bool				instruction;
> >   	bool				s2;
> >   	bool				read;
> > +	bool				ttrnw;
> > +	bool				ttrnw_valid;
> >   };
> >   /* SMMU private data for each master */
> 
