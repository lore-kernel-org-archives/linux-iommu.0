Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CB1D0E35
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678678; cv=none; b=kCm6Tn7s9HFtLOBoydU3WoQxEGvIwf217jds5+nIuik6BbsT/bSf9lRN5PflwwYLkDS4oysbucHyHG56Lfz+639U5A/QPB2zbpPw/SEefGQy7kQclsEts5bFAdebp1cQqXWdfKNWRjqJPHbdSbnCjN1uJHDIWZ0TxTTDxIU7UW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678678; c=relaxed/simple;
	bh=7ulVmqoW+HsFKtttDI0Q5/Hru9RaefPmE+RaG9lw3gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/BWr4XTUE1wyQU7PW9VxqEiaYOYyC1ULWEtp89V3TSnp5iixPNA/x9kUqLAOhhOIYuRw3B7HBGsJ/C8LvelmzsW0zImdIleDajXrh5181GqxE5r6azYLAVjVwcGtHCzQutKN0RGOg8GVryIv7lOJGwI8A0TC2AWdZecX4GxNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uw2GBLOC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uw2GBLOC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c8ac50b79so35485ad.0
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728678676; x=1729283476; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vj8Tw8kbIaVGPfr1lJjKbc4rDi8Mk8df0ojAgOob2AE=;
        b=uw2GBLOCLZk5YI7hsvxVQ22+kT44aVQUUOoL2bHt1IIIqyNSOeAmOuu2B4st4mb1h7
         vWocd7f9mxTX5AArbsq1u9r22kueJfu9NDRFb3gJyQ7VrBfaco6IGk23c+Vxc0Ij9Oqa
         pxY0AOfWWrlE9Vyff2VBv0FVJBAqNvUISMmQZ43T9E5lDhUamNjxFjZlj+sjZztlAlcv
         N9BArrmej9etjUy2lRz4tkrwWOg/0/r4Id5EwB0de9KM3jzxuM6+2q24a6BmpEq92nx7
         OlUJTlOQQNEpTZ69Qr22RS2u0Kuy5eVkFLEnyJ3w+/GNB3L8w6GgzXPdZbY96r5bYZQs
         RTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728678676; x=1729283476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj8Tw8kbIaVGPfr1lJjKbc4rDi8Mk8df0ojAgOob2AE=;
        b=g5D32I6PawVDCScXnEVa4cyv6VyoTzDfj4h7wVkfritFMbcsqDYvAOMJfJOu2mYvDQ
         0Eo7uPRPepVDIdpDTa1neOBJpXZFoKrblSHfQLfrUAQrucL1XfCi28KKt9hL11HAgZCn
         KeClat9BCsziq4IKelKARTco2+8foeKSkuFxduTVMe1F6r6UkZKZyqVET/pAs2q26GIB
         Cd4XFPh88px9VvScMSuoTaY4ScQ8uXfMV8vghAphl3IdQdUitE1HhKKTVZMtsZwHtv6L
         7Pk2m1dVaH61btIgr6sX7JLX1SCkIEr8n/MulajVIIUsk2z+9TVDOS+lYS0qaMWKyiXV
         1Q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnqboMPYP36zBPd3i3fCzg9FdIwaqniuD1OY/HXZJ/b7AGN+IwmA0QOqP8nksjY8WXAk9Tzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzliveKzK9LHVBNs8qOXxQGctHwoIPDO7kYm+s4diypFEFDvCre
	W15eJvuDioUvemWUPb5wohZ7kCtkS1vBI9LkcfnKueiZv+xYxnvBGe/0EHl2AQ==
X-Google-Smtp-Source: AGHT+IHymUHKT0qd1Q1JPaoTfbEcUjuTH5cgSOLPAx5Ne1R83QH/VvlXW9L50mT9j5u83JVWNaH7IQ==
X-Received: by 2002:a17:903:41c8:b0:20b:bc5e:d736 with SMTP id d9443c01a7336-20cc02b2f9amr34745ad.11.1728678675812;
        Fri, 11 Oct 2024 13:31:15 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f5252sm3019262b3a.48.2024.10.11.13.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 13:31:15 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:31:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <ZwmLCzBuRbPy11cE@google.com>
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

Ack. That makes sense. I'll re-organize the series accordingly.

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

Ahh, I see! My worry was a using `dev` after free but it looks like
`get_device(dev)` increments the reference count, preventing `dev` from
being freed prematurely.

Looking at the core code in drivers/base/core.c to confirm,
I see that the `device_release` invokes `dev->release` which frees the
`dev` struct and it seems that the `device_release` is called only
kobject's refcount reaches 0. Additionally, I see that `device_release`
is registered as the ->release callback in the device_ktype kobject.

So, looks like we should be good? LMK if I missed something above?

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

Ack. Although, I'm curious to know the concern while calling
`arm_smmu_dump_event` within `arm_smmu_handle_evt`, is it because we
might hold the lock for a longer duration due to the super-long prints?

> 		cond_resched();
> 	}
> 
> Thanks,
> Robin.

Thanks,
Pranjal
