Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69371D0DE7
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152410; cv=none; b=G2OIMPH2dkj7kqmcpwE3yto93pW3MN3AJGVO8w+uv1/8uz4CBiuUNcHu3Ebw4SmDiXo0myeck61j5MstLz7HD9PEpqI+yOy3dxcer3l/z8l2bc2WJeD/PXHDOAf0JPTd3BJ3PsiXge5vb6UjcE0IKH0xF2YbvsfwxTWhIK4zWEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152410; c=relaxed/simple;
	bh=+n+Ljc2ekVz2o7feEiQCTUHXbGFsW3wKA7gtB1udWdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8QnMfRb5wK0SZhZljFe8clcxdeXTY4a6fxBGfPW+tMhPg0PxuYNPBnk5SIlyNtItzCpNGhJ80+/tj0/oW381gRDzlEIp3zvgVfp4ZO1GWbCVqiLUqJs/UwTrcQ7aEpP25Otyzx6VC/P6FjvwGZYP2tp36X7RDHpmbJfBgWiTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uz3BvwiE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uz3BvwiE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca03687fdso137465ad.0
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729152408; x=1729757208; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5elGTjDUvI82Jjoz2XxLRSuIWAHhCe11X21BLWcP//c=;
        b=Uz3BvwiE/eRUrZxWevx9DvjUJd40gUFosEiD2NfT+IylBp+0n20J6dlCyOEqXnfoqw
         YpdTAXTH99dEkj8KZsezANlK8q/XoEY279UlsSAUtGhwljbwJ59Sk23JPcxoQzPkeolF
         jVWmSZC0BOodnYFbrRFpIIjG66MrfHEDJBaq3Aj/pN9UAQAlhqTxa9r1VmxFTeB7/1RI
         JOzjK+zy6kLRcAy2cUTjPIMQYmL/Ku+B3w4h5aJX05jiyB8ILIO6XdslvhlM9KXVLuxP
         5yNNd2r2XGjRfW2zbCHzifhCBc3nN6BGgdGcGzkC/AWpfNsBqb6vc4QhsFJz4pOgQeel
         qYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152408; x=1729757208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5elGTjDUvI82Jjoz2XxLRSuIWAHhCe11X21BLWcP//c=;
        b=PrOhK49BqNWfTr/CBCuR5fCn6Um+QL00vY13ykI/BsFoHJjbdgsC+pkPNGDAqtDGsr
         Z4+NiIwdmQ9kSPdgahdGhGPNDLGGkSNU9Nk5IGUVowKPxHXR/IrvyRk/ro/I8nv2PdlR
         /bRkc1Su7ZUOpW6CVFo9t4ubTyv8I8w5ZiFqZ6iHj5LEAKrEQ0wGtEcuNsv3kV0EoPkh
         xsBEshmHbdfxwN7jhtS9IEZNlNVdmnzVk8rDYczofsxpb/pd/pS9zKm8A977e90NPYgW
         FPJ4VZ3zvHCQD9KOup83+Yw9sl3RLiauxGz8c5vbFiTcmiedNBNEJYVMHoNLWTSPQ1E9
         GxPA==
X-Forwarded-Encrypted: i=1; AJvYcCVztiBsV7j+Pt7T4Pyt3MxOzj18aVYP5405q/G1z4iihP+oiA1fWxC5m2DzC3XhCMnbM6R0oQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzePF225z1fpAv/C24gf0kaVbSKFhAibdOfSr+wWlcQpmpiw2Vc
	Fh6vCPMQYxMmEzwQVDKdqPXoFhaeSnjtVGTLd5mj2bQLy76BtM3opul75sK5DA==
X-Google-Smtp-Source: AGHT+IH+dIZUoCEM3cFhMtxRIhkIMMrXvr3KQwEuxVVZe2d2vVEiqjoJ4C8F020Hn5Fm2NVVZi5XOg==
X-Received: by 2002:a17:902:f542:b0:20c:f87f:b7ef with SMTP id d9443c01a7336-20d49640d27mr2105605ad.22.1729152407536;
        Thu, 17 Oct 2024 01:06:47 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e094a416sm1201300a91.50.2024.10.17.01.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:06:47 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:06:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <ZxDFj57n1AxBPESD@google.com>
References: <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
 <Zv8N6yIeNXao_Yqm@google.com>
 <Zv8gW9KjTcktgve1@Asurada-Nvidia>
 <ZwjZ9txpvqd8kUdS@google.com>
 <5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com>
 <ZwkB4OTUChexImZd@google.com>
 <ZwkGzWSUIpuhHozl@google.com>
 <ec9e47cc-f3c2-4142-8395-3bbb8e055261@arm.com>
 <Zw61rP2F0sm_eDiK@google.com>
 <cac41a3d-b5fc-4269-8a87-a70cf33f410b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac41a3d-b5fc-4269-8a87-a70cf33f410b@arm.com>

On Tue, Oct 15, 2024 at 09:03:54PM +0100, Robin Murphy wrote:
> On 2024-10-15 7:34 pm, Pranjal Shrivastava wrote:
> > Just a few things before I respin,
> > On Fri, Oct 11, 2024 at 01:59:36PM +0100, Robin Murphy wrote:
> > > On 2024-10-11 12:06 pm, Pranjal Shrivastava wrote:
> > > > On Fri, Oct 11, 2024 at 10:45:52AM +0000, Pranjal Shrivastava wrote:
> > > > > On Fri, Oct 11, 2024 at 11:21:48AM +0100, Robin Murphy wrote:
> > > > > > On 2024-10-11 8:55 am, Pranjal Shrivastava wrote:
> > > > > > > On Thu, Oct 03, 2024 at 03:53:15PM -0700, Nicolin Chen wrote:
> > > > > > > > On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
> > > > > > > > > > The master and master_name are not that necessary to be in the
> > > > > > > > > > arm_smmu_event. I would keep both of them as local variables in
> > > > > > > > > > arm_smmu_handle_evt and pass master_name in to dump().
> > > > > > > > > 
> > > > > > > > > Hmm, right or maybe ONLY have the master_name in arm_smmu_event?
> > > > > > > > 
> > > > > > > > Just move both out of arm_smmu_event. Keep the master_name as a
> > > > > > > > local variable like the "master". You'd just need to pass it in
> > > > > > > > to the dump(). They both are in that same handle_evt().
> > > > > > > > 
> > > > > > > 
> > > > > > > Ack.
> > > > > > > 
> > > > > > > > > > > Also, shall we rename it to `arm_smmu_read_evt_info` ?
> > > > > > > > > > 
> > > > > > > > > > I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
> > > > > > > > > > light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
> > > > > > > > > > no strong feeling about that.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Ack. How about `read_arm_smmu_event` :)
> > > > > > > > > Unless, we wanna follow the arm_smmu_<func> convention?
> > > > > > > > 
> > > > > > > > I think it'd be nicer if we do.
> > > > > > > > 
> > > > > > > 
> > > > > > > Ack. `arm_smmu_get_evt_from_raw` it is!
> > > > > > 
> > > > > > FWIW that sounds needlessly overcomplicated to me - the "raw" event array
> > > > > > should be a member of arm_smmu_event itself, since it seems silly to have
> > > > > > them separate with one pointing to the other when they have the exact same
> > > > > > scope and lifetime anyway. There still shouldn't need to be more than a
> > > > > > single logical step to process an evtq record into a finished
> > > > > > arm_smmu_event, just that that processing is now going to go a bit further
> > > > > > than simply le64_to_cpu().
> > > > > 
> > > > > Hmm, are you suggesting something like queue_remove_raw(q, event->raw)?
> > > > > OR do you mean we should have our own queue_parse_evt(q, &event) that
> > > > > parses out the raw event into an `arm_smmu_event` record eliminating the
> > > > > need for the `arm_smmu_read_evt_info` altogether?
> > > > > 
> > > > > Because we'd still need to store the raw event anyway since we're still
> > > > > logging the raw event.
> > > > > 
> > > > > I think we can go with the former, i.e. queue_remove_raw(q, event->raw)
> > > > > and then use ``arm_smmu_read_evt_info` to populate other `event` fields
> > > > 
> > > > Based on your comment, I was thinking like the attached sample code.
> > > > LMK if you were referring to something like that?
> > > 
> > > Ah, apologies, it had slipped my mind that queue_read() is already buried
> > > two layers deep in an abstraction shared with the priq... so yeah, rather
> > > than start trying to turn that inside-out, I guess the neatest approach is
> > > to effectively flip this series instead - i.e. start with the minor shift
> > > to:
> > > 
> > > 	struct arm_smmu_event evt;
> > > 
> > > 	while (!queue_remove_raw(q, evt.raw)) {
> > > 		ret = arm_smmu_handle_evt(smmu, &evt);
> > > 		...
> > > 		dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> > > 		//etc.
> > > 
> > > and leave arm_smmu_handle_evt() decoding the event as both it and
> > > arm_smmu_handle_ppr() already do, just now using the new structure instead
> > > of locals. Then we can come in to factor out and enhance the unhandled event
> > > report, and anything else specific to that reporting beyond the actual SMMU
> > > event record, like device names and ratelimiting, can remain private to
> > > arm_smmu_dump_event().
> > 
> > Quick clarification, the ratelimiting here was ONLY for logs or to limit
> > the number of thread / loop executions?
> 
> Yes, the ratelimit is purely for the printks, so once those are factored out
> into a dedicated function it can move with them. The cond_resched() is what
> keeps the loop itself well-behaved if there's a giant flood of events; we
> never want to skip trying to handle any of them.
> 
> > > 
> > > AFAICS the locking concern seems avoidable as well - we don't actually need
> > > the whole arm_smmu_master in either case, just the device, so then end of
> > > arm_smmu_handle_evt() could easily be a little simpler:
> > > 
> > > 	...
> > > 	mutex_lock(&smmu->streams_mutex);
> > > 	master = arm_smmu_find_master(smmu, sid);
> > > 	if (master)
> > > 		event->dev = get_device(master->dev);
> > > 	mutex_unlock(&smmu->streams_mutex);
> > > 
> > > 	if (!event->dev)
> > > 		return -EINVAL;
> > 
> > Thinking about this a little more, I guess there are a few paths that
> > may return before we even get to the `mutex_lock(&smmu->streams_mutex)`
> > For example: if (!event->stall) return -ENOTSUPP; and the default case
> > return from the switch case. Which has the following implications:
> > 
> > 1. We might return from `arm_smmu_handle_evt` before logging the event
> > 2. Even if we move the logging out of `arm_smmu_handle_evt` as presented
> >     by Robin's snippet above, event->dev might still be NULL.
> 
> The point is that it *can* be NULL in general, and the logging must expect
> that. Just move the arm_smmu_find_master() stanza to the top of
> arm_smmu_handle_evt() to grab the device reference before any of the actual
> handling may start wanting to bail out - same as you'll want to do for all
> the other decoding as well - then we know it's either valid (and stable) or
> NULL for the lifetime of the event through all subsequent processing. AFAICS
> calling iommu_report_device_fault() under streams_mutex isn't meaningful in
> itself, right now it just seems to be about protecting the inline
> "master->dev" dereference against "master" going away.

Ahh, alright. Let me refactor that too then.

> 
> We can still have multiple returns as appropriate in the actual handling
> *after* collecting all the arm_smmu_event data, which is a big part of why
> I've suggested keeping the same effective structure as currently - we have
> one function to decode and try to handle the event, and based on the final
> outcome of that function, we may then want to report if it wasn't handled
> (subject to other constraints like ratelimiting). There's absolutely no need
> to tie the control flow in knots attempting to nano-optimise that into a
> tail call - using the returned value in the returned-to scope is natural,
> simple and obvious.
> 

Agreed.

> Thanks,
> Robin.

Thanks,
Pranjal
