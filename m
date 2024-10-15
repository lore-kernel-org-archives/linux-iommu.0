Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59C1FBF44
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017270; cv=none; b=YGrQd1ls7dmnfDCTl2RLgqT1ZjGxxozo7h4HtZ97Y2BPPSLeJG0UqyLsZRSY5+gbhL9CzOpG7Bg5h1oyHHSlxrcFdrTz390b/RTRO/1FEtxuLX/McleZI/N9ZnCD9kXKXnl7TLdm/GHg3w1+fGsAzwPooMI5Tw4A74fzyx7FOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017270; c=relaxed/simple;
	bh=6pHOetNbCEpKHfUMQxyWOJf/3wxmqm+Uz8p+VV+SsII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaEAgb/waoICSS/R+6t4scAapHsqxDD1lAiCR/0ZLaD/jVRp4Z0x6RCXJ6b72TWd0JI8LmLJ6xSSTIkO3ilxCcMPRFdy95OmXmFOad8Pw3Jnu8N+QAVXN78OhXvDEIa++sRExwyu1JY182o8/EjvyqbHRYg92NX+wgZoFwMO3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7dJEdb7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7dJEdb7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c87b0332cso560875ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729017268; x=1729622068; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f03rXe5Ib3rThGqOQiwJJnXgSTzTs9dfF7CZNkmA+4s=;
        b=p7dJEdb7kttaz3QP/fqNzkhX5kE3UxnP8U6OBY8AEFIupJok8yAlH1dTLPAn7AGnga
         NF1vHJYM+t2YV3zcPvFyVX3KiSTRcdqxhrjM35ZkrXqV62DLbQbVb86p23HMSWfXNf/i
         y0iCaAyCwwG8yVW7S6k12ANm2PMgT1PrMdEQPuPxZy8ut99wExL23DZ/ehSxTkP7de4B
         L9eoj7WxiLDlMrBvxoG1oJzJfJ2G3xx/9wdiRjeKZLthJMJOR1CyHLmHHvb+N0LGBJDX
         o28arIL6DJSSPBezuWyXyKXFQAst6hZQuozMa1aPa79AIECTpaY/0Q83zfDG5mGtHy4p
         GH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017268; x=1729622068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f03rXe5Ib3rThGqOQiwJJnXgSTzTs9dfF7CZNkmA+4s=;
        b=rNiYq+1gOKGJBLo12FbfQ2pRwInm+xJ3vUaWTQ5IlMxXjIW2+S1GRJW9mAXT6QB+sM
         5v+5AtAkh6vDvJg9o0TfY8lYe0d1I/f8fvpZgJxnTK40+tZgvMnVDm9jmW6hEJqkYanO
         rnYztu66DW/W9eXzAv0FAtieX4pSalx1SbatenPVVvnmyovHhRHXlV5zePPmwsmNMJk8
         SiVcRVcd8icUjMhZu1YMcUzpxcCnulhRjYZ1qM09spSdWL4EaboojbjqpNwR0lDWn8Bc
         vOsEQ13qeTH8LjKo/PwLZW8rBuWyQr3OmOnAu5/hw11VqaFjl+mxQeGzgtK3YMo6JwFm
         h+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtAt9VSh0YlSmRUDKJ/0ITmhpGskLtq8Sn0lKBOKQrJlQtEV3R4cctAFcn9nBAhY2aSVlQJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy956H1opC16a7yp0HF8vZwXOiFnMMo2EfJC8NFFIEIcV9IfRPl
	lIF8s4PbFlsGrIKb0pep2qU+GvE9I1qmVEeFuR1Wu91qVA1ICMIkAAiPydPoqg==
X-Google-Smtp-Source: AGHT+IF72lkkUEVxELEKi4N2gsEkUuppYX/bdcMu/n0puSU0DARc4h9h/8Nmvw4lhyDeCal+FfAGsw==
X-Received: by 2002:a17:903:234b:b0:201:fba5:3ed with SMTP id d9443c01a7336-20d2e2e1109mr212395ad.27.1729017268022;
        Tue, 15 Oct 2024 11:34:28 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f7541bsm2171847a91.48.2024.10.15.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:34:27 -0700 (PDT)
Date: Tue, 15 Oct 2024 18:34:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <Zw61rP2F0sm_eDiK@google.com>
References: <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com>
 <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
 <Zv8N6yIeNXao_Yqm@google.com>
 <Zv8gW9KjTcktgve1@Asurada-Nvidia>
 <ZwjZ9txpvqd8kUdS@google.com>
 <5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com>
 <ZwkB4OTUChexImZd@google.com>
 <ZwkGzWSUIpuhHozl@google.com>
 <ec9e47cc-f3c2-4142-8395-3bbb8e055261@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9e47cc-f3c2-4142-8395-3bbb8e055261@arm.com>

Just a few things before I respin,
On Fri, Oct 11, 2024 at 01:59:36PM +0100, Robin Murphy wrote:
> On 2024-10-11 12:06 pm, Pranjal Shrivastava wrote:
> > On Fri, Oct 11, 2024 at 10:45:52AM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Oct 11, 2024 at 11:21:48AM +0100, Robin Murphy wrote:
> > > > On 2024-10-11 8:55 am, Pranjal Shrivastava wrote:
> > > > > On Thu, Oct 03, 2024 at 03:53:15PM -0700, Nicolin Chen wrote:
> > > > > > On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
> > > > > > > > The master and master_name are not that necessary to be in the
> > > > > > > > arm_smmu_event. I would keep both of them as local variables in
> > > > > > > > arm_smmu_handle_evt and pass master_name in to dump().
> > > > > > > 
> > > > > > > Hmm, right or maybe ONLY have the master_name in arm_smmu_event?
> > > > > > 
> > > > > > Just move both out of arm_smmu_event. Keep the master_name as a
> > > > > > local variable like the "master". You'd just need to pass it in
> > > > > > to the dump(). They both are in that same handle_evt().
> > > > > > 
> > > > > 
> > > > > Ack.
> > > > > 
> > > > > > > > > Also, shall we rename it to `arm_smmu_read_evt_info` ?
> > > > > > > > 
> > > > > > > > I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
> > > > > > > > light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
> > > > > > > > no strong feeling about that.
> > > > > > > > 
> > > > > > > 
> > > > > > > Ack. How about `read_arm_smmu_event` :)
> > > > > > > Unless, we wanna follow the arm_smmu_<func> convention?
> > > > > > 
> > > > > > I think it'd be nicer if we do.
> > > > > > 
> > > > > 
> > > > > Ack. `arm_smmu_get_evt_from_raw` it is!
> > > > 
> > > > FWIW that sounds needlessly overcomplicated to me - the "raw" event array
> > > > should be a member of arm_smmu_event itself, since it seems silly to have
> > > > them separate with one pointing to the other when they have the exact same
> > > > scope and lifetime anyway. There still shouldn't need to be more than a
> > > > single logical step to process an evtq record into a finished
> > > > arm_smmu_event, just that that processing is now going to go a bit further
> > > > than simply le64_to_cpu().
> > > 
> > > Hmm, are you suggesting something like queue_remove_raw(q, event->raw)?
> > > OR do you mean we should have our own queue_parse_evt(q, &event) that
> > > parses out the raw event into an `arm_smmu_event` record eliminating the
> > > need for the `arm_smmu_read_evt_info` altogether?
> > > 
> > > Because we'd still need to store the raw event anyway since we're still
> > > logging the raw event.
> > > 
> > > I think we can go with the former, i.e. queue_remove_raw(q, event->raw)
> > > and then use ``arm_smmu_read_evt_info` to populate other `event` fields
> > 
> > Based on your comment, I was thinking like the attached sample code.
> > LMK if you were referring to something like that?
> 
> Ah, apologies, it had slipped my mind that queue_read() is already buried
> two layers deep in an abstraction shared with the priq... so yeah, rather
> than start trying to turn that inside-out, I guess the neatest approach is
> to effectively flip this series instead - i.e. start with the minor shift
> to:
> 
> 	struct arm_smmu_event evt;
> 
> 	while (!queue_remove_raw(q, evt.raw)) {
> 		ret = arm_smmu_handle_evt(smmu, &evt);
> 		...
> 		dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> 		//etc.
> 
> and leave arm_smmu_handle_evt() decoding the event as both it and
> arm_smmu_handle_ppr() already do, just now using the new structure instead
> of locals. Then we can come in to factor out and enhance the unhandled event
> report, and anything else specific to that reporting beyond the actual SMMU
> event record, like device names and ratelimiting, can remain private to
> arm_smmu_dump_event().

Quick clarification, the ratelimiting here was ONLY for logs or to limit
the number of thread / loop executions?

> 
> AFAICS the locking concern seems avoidable as well - we don't actually need
> the whole arm_smmu_master in either case, just the device, so then end of
> arm_smmu_handle_evt() could easily be a little simpler:
> 
> 	...
> 	mutex_lock(&smmu->streams_mutex);
> 	master = arm_smmu_find_master(smmu, sid);
> 	if (master)
> 		event->dev = get_device(master->dev);
> 	mutex_unlock(&smmu->streams_mutex);
> 
> 	if (!event->dev)
> 		return -EINVAL;

Thinking about this a little more, I guess there are a few paths that
may return before we even get to the `mutex_lock(&smmu->streams_mutex)`
For example: if (!event->stall) return -ENOTSUPP; and the default case
return from the switch case. Which has the following implications:

1. We might return from `arm_smmu_handle_evt` before logging the event
2. Even if we move the logging out of `arm_smmu_handle_evt` as presented
   by Robin's snippet above, event->dev might still be NULL.

In order to fix this, there are two ways to go:

1. Add a new "goto" label and instead of returning, jump to that label.
   Yet, we'd have to acquire the mutex again and read the dev ptr, like:
	
	...
	out_unlock:
		mutex_unlock(&smmu->streams_mutex);
	out_dump_evt:
		mutex_lock(&smmu->stream_mutext);
		// Find master and populate event->dev
		mutex_unlock(&smmu->streams_mutex);
		if (ret)
			arm_smmu_dump_event(event);

	return ret;
	...

Personally, I find this to be pretty messy!
Instead, it'd be nice to  simply read the dev ptr within the
`arm_smmu_get_event_from_raw` as:

	/* Pick out the good stuff */
	event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
	event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);

	...
	mutex_lock(&smmu->streams_mutex);
	master = arm_smmu_find_master(smmu, sid);    	
	if (master)
		event->dev = get_device(master->dev);
	mutex_unlock(&smmu->streams_mutex);
	...

And then dump based on the return value as we do now and maybe
put_device(evt->dev) in the `arm_smmu_dump_event` after logging?

> 
> 	return iommu_report_device_fault(event->dev, &fault_evt);
> 
> then arm_smmu_dump_event() is safe to use a construct like:
> 
> 	event->dev ? dev_name(event->dev) : "(unassigned)"
> 
> and finally a cleanup in the evtq loop, which by that point probably
> condenses down to something like:
> 
> 	while (!queue_remove_raw(q, evt.raw)) {
> 		if (arm_smmu_handle_evt(smmu, &evt))
> 			arm_smmu_dump_event(&evt);
> 		put_device(evt.dev);
> 		cond_resched();
> 	}
> 
> Thanks,
> Robin.

Thanks,
Pranjal
