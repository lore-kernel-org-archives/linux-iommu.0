Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CEA2076B1
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232004; cv=none; b=p53XNZrOodzjId0KBCsF9g6N5RtrxvZVtWc4uaumEng1rhKmC/B7XQOCxMqwqTyKqaK6f2qpDA9vSiONsHWxBlLgHRMHlocYG6IREhNUEvdWkUb/mU5Hk3BSqYjExRnTZHr5A1xCjwiNdBnqSfmOUztLmiLUGKbxCfJ6PxnNP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232004; c=relaxed/simple;
	bh=Ho2bWKFcQVDWN5x2qmrJaAVdw3hSlYAigyjzpR46+Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dhe0y8g/f4DgsOO8TdxJQMUl5fRPvHCmoLT0sp6y48FlUsRSFq3OJiAg7sAMLuzcTBf6+zfih8p1avedHa0LWozBM9lczu3tpNwHekbN8z4t/rWLG2LHlTQmZbBBmEyV4uwO+tag4x/JeyvmMnMaImClzY0iP5j/jYGAxvaA+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLA9P3/j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLA9P3/j"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8ac50b79so5225ad.0
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730232001; x=1730836801; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z0v1raniOg6o7d+jLb7BwqTH+lo2NxBw6tuk8OQTcU=;
        b=DLA9P3/jt6mvBpZQkZfa64dDqrlEWoO6dldjObmhDGsb5zYoKnZIvtRxTeeQ0FyaKR
         ab29iBCTRj1fCjp3nEavhLssy8tn6Ra5P7ZFylnsmdtjEPDEnP0DA7DSwoPTqtviR9xk
         u+3PwEr3Kf7m85qOZBHxrwq0RToAx1NAYgsCAny1Cx6v3ZiVjNrsojMNWaZnq36eXxrv
         ehACGvgxxYjBt/0tcplqC9SZJ5OYg+pkjVTHquhSimN04F2GMKYi7dfCUxt3sORzNcrv
         js+rzbu5DcHljUSoVpMP2AnuShmOP4kgkYlvGXaoIK1SvTs+fz5cmyDSTCccinlhLWjg
         GWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730232001; x=1730836801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z0v1raniOg6o7d+jLb7BwqTH+lo2NxBw6tuk8OQTcU=;
        b=ixI1YzzXi/l+nk9L+/SvtYzL07HRbSEtpJ8ka5k8aTUiYgmsN1ExDpmFWuCH6xoFzq
         Q1r7EGQqv+4MLdgJEQc2Aftknff/zNPE1hEdDwnuLNtPVLk5WVropM+RtaG4iCCHz0ju
         bcbGm6VH2qwzd2lFB/S9wVPKZn4luZE5plE2XmVJ4GwwtzjL4FWsE2NQZDy7qSVKF7lG
         ITlnaKx577Igq/JmhD+1szTPoSKQEmxcpvLnbvGTbfic8slNd5ahWRf1motWxL5XiRWO
         KfOURJUTCjmvn8KTIibZwF5wJXWk2IHHOEtXNGAcfxi38pTSse5qmetwQ1L7kbnYOTDu
         nZIA==
X-Forwarded-Encrypted: i=1; AJvYcCX+HpF4Ck4M90iEDDCBAmcAZCMY01fmhiyQYqfRQjZOzDeq8h0cNXKSz0NpczMhxo9NJLUcaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzjao6Xblx1F5H4Dhcs4wr58GAWi83DnxLYkxOOwxiBt5N/QUWH
	ffXNscxbeY+konTKmHKFavSLYzIvcEDKgreFJzFkIVZ/kLQpaDhveP/ONUdqWA==
X-Gm-Gg: ASbGncsBkic/uy2rU3kmTNg9PuJwL79VL+NasbZP9GBzUNb0ETJ/IhsQz+v1DDvZ0cA
	F3OH9ASYXzYqAp7kS7hesPYKbWQ3Qb5V8ha6LZrJW1ZeYwgLqeqIsJZNnKM7m80yEa5LwoqDta+
	tgHv/AMMf50sSaNDWTwdVDeZRTMx+7GxZhApfksikSYCUGaEOVVFZlZsKrMcfH9Rq243uSsqelK
	stXheJLuzQvPLcLiYSppz7kFWguHHrdUKPlyMNFhLWajf1NPlIgazVZfP297AbYUSPAmh30nJAo
	/5K98HLPIco=
X-Google-Smtp-Source: AGHT+IHRaY979nctbASpRqskGdmgWGlLmurHgg4pnD0CTGeQu+Ov1qHUnI+20LVYHO3FvDeD3nw5gg==
X-Received: by 2002:a17:903:18c:b0:20c:805a:22b with SMTP id d9443c01a7336-210e9d827damr4290075ad.24.1730232001239;
        Tue, 29 Oct 2024 13:00:01 -0700 (PDT)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e55e030sm11967676a91.37.2024.10.29.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:00:00 -0700 (PDT)
Date: Tue, 29 Oct 2024 19:59:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZyE-uSGEQGFDcmc2@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <20241024131511.GH30704@willie-the-truck>
 <ZxpWUp8O6QXEe9xv@google.com>
 <20241029185345.GB5454@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029185345.GB5454@willie-the-truck>

On Tue, Oct 29, 2024 at 06:53:46PM +0000, Will Deacon wrote:
> On Thu, Oct 24, 2024 at 02:14:42PM +0000, Pranjal Shrivastava wrote:
> > On Thu, Oct 24, 2024 at 02:15:12PM +0100, Will Deacon wrote:
> > > On Fri, Oct 18, 2024 at 06:00:21PM +0000, Pranjal Shrivastava wrote:
> > > > Currently, the driver dumps the raw hex for a received event record.
> > > > Improve this by leveraging `struct arm_smmu_event` for event fields
> > > > and log human-readable event records with meaningful information.
> > > > 
> > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > > ---
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
> > > >  2 files changed, 113 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index 2f1108e5de51..4477cf86cb8e 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
> > > >  	{ 0, NULL},
> > > >  };
> > > >  
> > > > +static const char * const event_str[] = {
> > > > +	/* Bad config events */
> > > > +	[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> > > > +	[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> > > > +	[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> > > > +	[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> > > > +	[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> > > > +
> > > > +	/* Bad translation events */
> > > > +	[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> > > > +	[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> > > > +	[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> > > > +	[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> > > > +
> > > > +	/* Bad fetch events */
> > > > +	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> > > > +	[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> > > > +	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT",
> > > > +	[EVT_ID_MAX] = NULL,
> > > > +};
> > > > +
> > > > +static const char * const event_class_str[] = {
> > > > +	[0] = "CD fetch",
> > > > +	[1] = "Stage 1 translation table fetch",
> > > > +	[2] = "Input address caused fault ",
> > > > +	[3] = "Reserved",
> > > > +};
> > > > +
> > > >  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> > > >  				    struct arm_smmu_device *smmu, u32 flags);
> > > >  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> > > > @@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> > > >  	return rb_entry(node, struct arm_smmu_stream, node)->master;
> > > >  }
> > > >  
> > > > +static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
> > > > +{
> > > > +	int i;
> > > > +	struct arm_smmu_device *smmu = event->smmu;
> > > > +
> > > > +	dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> > > > +		event->id, event->master_name);
> > > > +
> > > > +	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > > > +		dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
> > > > +}
> > > > +
> > > > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > > > +{
> > > > +	struct arm_smmu_device *smmu = evt->smmu;
> > > > +	char title[100] = {0};
> > > > +	char mastr[100] = {0};
> > > > +	char addrs[100] = {0};
> > > > +	char flags[100] = {0};
> > > > +	char other[50] = {0};
> > > 
> > > I haven't followed previous versions of this series in detail, but
> > > allocating 450 bytes on the stack for this seems excessive to me.
> > 
> > Hmm, I think we can reduce the title, mastr, addrs string to 50 chars
> > and the `other` can be reduced to 30? Or maybe we can avoid printing the
> > `stag` and `stall` fields altogether which should reduce it by 200 bytes
> > We can save another 20 bytes by reducing the `flags` len to 80 bytes,
> > overall saving us 220 bytes of stack space.
> > 
> > I introduced this in v3 [1] based on suggestions in v2 reviews [2].
> > I can revert to the approach followed in v2 [3] as well.
> > 
> > LMK what's your vote?
> 
> Keeping the strings concise is one thing and we should do that regardless.

Hmm.. the longest string is the one printing all the flags, an example:

[   85.410290]  Unpriv | Data | Write | S2 | Stage 1 translation table fetch | TTD Write

One idea to reduce this is, maybe just print a letter for abbreviate and
trim the event class string? Something like:

[   85.410290]  Un | D | W | S2 | S1 TT fetch | TTDW
[   85.410290]  Prv | I | R | S1 | S1 TT fetch | TTDR
[   85.410290]  Prv | D | R | S1 | Input addr fault

> However, I'm questioning (a) why we need so many arrays rather than just
> e.g. char linebuf[...] and (b) why it needs to be on the stack at all.
> 

a) The arrays were for breaking up the log in multiple parts and print
only the relevant parts for a particular type of event. Earlier we had
something similar to the linebuf (basically not needing the linebuf):

dev_err(smmu->dev, "Fault: %s client %s sid 0x%08x.0x%05x:\n\tiova = %#llx ipa = %#llx\n (%s%s%s%s%s%s)\n",
	evts[event->id], event->master_name, event->sid, event->ssid,
	event->iova, event->ipa,
	event->privileged ? "Priv " : "Unpriv ",
	event->instruction ? "Inst " : "Data ",
	event->read ? "Read " : "Write ",
	event->stage ? "S2 " : "S1 ", class_str[event->class],
	((event->id == EVT_ID_PERMISSION_FAULT) && 
	 eevent->class == EVTQ_1_CLASS_TT)) ?
	 (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ?
	  " TTDRead" : " TTD Write") : "");

Since I had 3 different logs for 3 different categories of events, it
was decided to break up the logs into smaller parts and print only the
relevant ones during the review of the v2 patch[1].

b) Hmm, I was thinking around the re-entrancy of `arm_smmu_dump_event`?
Since all events are queued up and handled later.. I was thinking of a
situation where the 2 instances of the evtq_thread would be running on 2
cores simultaneously handling different events?

I haven't looked into the core interrupt handling but I'm assuming the
following situation:

1. Interrupt Occurs: When the hardware interrupt triggers, the CPU takes
the interrupt and executes the first half of the interrupt handler.

2 Thread is "Woken Up": After Acking the interrupt, he associated irq
thread will "wake up" i.e. the evtq_thread is  marked as "ready" to run.

3. Now, the scheduler sees the thread as "ready" and schedules it on a
free cpu say, on CPU0.

4. Second Interrupt (Before First Finishes): If another interrupt
for an event occurs before the first instance of the evtq_thread
has finished executing, it will again mark the thread as "ready".

5. The scheduler might now see evtq_thread is ready again and 
schedule it on a different CPU (say CPU1). Now you have two
instances of the same thread running concurrently..

I'll take a look into the core interrupt handling code to verify if the
above is even a possibility or some hallucination of mine.

But in case we are sure that the above wouldn't happen, I think we
can consider moving these buffers to global scope. I'd just like to
avoid the race conditions and locking around the log buffers.

> Will

Thanks,
Praan

[1] https://lore.kernel.org/linux-iommu/ZtAW0hVPFD6JbLTL@Asurada-Nvidia/
