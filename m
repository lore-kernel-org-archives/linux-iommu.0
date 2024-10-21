Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D3194AD9
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492021; cv=none; b=MLdtA5z48jQq/Bvwv32Z38AGVhjQb4FJZrgN7X6SDCyLwd+7mQz2ynHWr8v/sJnJrRFZc/tH8ZwUbspi/oddBB7FpDUlzlSs4CtMr6fCt8GqzSLDhueVK+P62lRsfR0wf2fwlPjAF8Ry2BXxzeejSHV36/R4vnXDnBExQIu0UHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492021; c=relaxed/simple;
	bh=FR43AIeFviwmc8iMoisQb30dpXSCKs7119cRmM4pA8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGN3Fq6+5RAEnewAnf5RJDxPjLsOHFdOm6Np4zPBROV7V0Ra+d9OVyouvfnzp6bxBLtNMbhx/lDHVREzL69fgPaoESy8/ib+bFIkbSL9yLSU9FKGPge7ZKilGfJDhR33e/ACzlk8xfkZgKbB9S9m85lgXSB2BP9Z9bS8sqxpDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFP/XE+E; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFP/XE+E"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso775795ab.0
        for <iommu@lists.linux.dev>; Sun, 20 Oct 2024 23:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729492019; x=1730096819; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffKJuJJQdGKFxfCUWLM8rK2vIGc20hy14X13vl7UH6g=;
        b=iFP/XE+EiCSZbE/C0NGkGSlpa7zvBVfMwxdIXSjNBytktSH8a6Q+5cEA9gcArE590v
         VK5SbKHT1d+bf/KSYPHkcWyEjrf85jWz7uKVatLF4a0I29YUxOmfAuPchZWgLDkroohm
         gItnDFgIlA/0WREHXeyprZk9hZN9PIHyrOFd2WPwsJEfXvU6EvH9l+lO/flyCe2bwx1h
         Cu9+hIchXnNcpSssi87ucMAwgjaWq8aPzW/mKGLRgZSXUCurDX03P1YawIvqMYCsWkB1
         ayMYxeGmAQFjvKo99eWvY0S8GJkooJWPd9e310/A8hEEd24rgKDl2sm/jsWdJA9ikpZe
         0LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729492019; x=1730096819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffKJuJJQdGKFxfCUWLM8rK2vIGc20hy14X13vl7UH6g=;
        b=fGpgb799lIFCQ5KnSV8XfYKDRqhJtcl0C2FXebiqOst1FmJFmhLszQNRYKaacaV8wp
         3bn2xuAhvnFxVnkm7kQ67koR7wfEv+d932ZTiv4cmMgq6IzHgFIAgXdxBmITN6YDba6Q
         sFb7RgY2gj7BUByzvm3+FS9s4I6Kp5A6OX7Q8H8tzNOEYI3pHAfAATaRPjPgreC9oHSx
         R1s/9UMFS0qUvY8cG9uVuJgOGPiUl7D25W6BZr7uqwejWRWU8sJSBCguX/z6ZfZWZeB4
         NvEBzqC7iyHQE8mAOiMf2Ym0dMFG3lOVO2AY1Yr88uo+/rSiSGeuyXMOlS+ZjdfmbjUt
         mUKg==
X-Forwarded-Encrypted: i=1; AJvYcCV84vfraM4Hn4XikeeJDHPcLRazgHYrleuqx0UfltH7rDny+kkG1snudcxljnt+jnVVt9Gf6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1whb9FQ2/sexFnAmSnKSC+HIdQWiNcljV4/l4RgDao8nW6Nya
	GwFcLY7avO9mgeKB84N3RuMUjBI+Kbx5JnA/vHWNK3pSzdGom07U7WsHamYN/w==
X-Google-Smtp-Source: AGHT+IEz/YALh/ktqf56dJVwqN487Gk0yWHRnh8vypSjga9+oi/KBD93QzIl6y5X7x445ob0TWb/Og==
X-Received: by 2002:a05:6e02:1a46:b0:3a0:91e7:67dc with SMTP id e9e14a558f8ab-3a3f94b9a44mr7434195ab.4.1729492018487;
        Sun, 20 Oct 2024 23:26:58 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1332f5fsm2107192b3a.49.2024.10.20.23.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 23:26:57 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:26:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZxX0KsBBND6v6yqw@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <ZxMUOfH7GoY71FxD@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxMUOfH7GoY71FxD@Asurada-Nvidia>

On Fri, Oct 18, 2024 at 07:06:49PM -0700, Nicolin Chen wrote:
> On Fri, Oct 18, 2024 at 06:00:21PM +0000, Pranjal Shrivastava wrote:
> > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > +{
> > +       struct arm_smmu_device *smmu = evt->smmu;
> > +       char title[100] = {0};
> > +       char mastr[100] = {0};
> > +       char addrs[100] = {0};
> > +       char flags[100] = {0};
> > +       char other[50] = {0};
> > +
> > +       if (!__ratelimit(rs))
> > +               return;
> > +
> > +       snprintf(title, 100, "Unexpected event received: %s\n", event_str[evt->id]);
> > +       snprintf(mastr, 100, "\tmaster: %s sid: 0x%08x.0x%05x\n",
> > +                evt->master_name, evt->sid, evt->ssid);
> 
> Likely I mentioned in the cover-letter, maybe "sid.ssid:"?
> 

+1. I like the idea. Maybe let's update the log in ppr to follow this
as well? Does that sound good?

> > +       switch (evt->id) {
> > +       case EVT_ID_TRANSLATION_FAULT:
> > +       case EVT_ID_ADDR_SIZE_FAULT:
> > +       case EVT_ID_ACCESS_FAULT:
> > +       case EVT_ID_PERMISSION_FAULT:
> > +               snprintf(addrs, 100, "\tiova = %#llx ipa = %#llx\n", evt->iova, evt->ipa);
> > +               snprintf(other, 50, "\tSTAG = %#x Stall = %#x\n", evt->stag, evt->stall);
> > +               snprintf(flags, 100, "\t%s%s%s%s%s%s\n",
> > +                        evt->privileged ? "Priv | " : "Unpriv | ",
> > +                        evt->instruction ? "Inst | " : "Data | ",
> > +                        evt->read ? "Read | " : "Write | ",
> > +                        evt->s2 ? "S2 | " : "S1 | ", event_class_str[evt->class],
> > +                        evt->ttrnw_valid ? (evt->ttrnw ? "| TTD Read" : "| TTD Write") : "");
> 
> Should the last one be "TTD Read |" : "TTD Write|"?
> Otherwise, it would be "S2 || TTD Read" combined.

Umm.. I don't expect the event_class_str[evt->class] to be NULL ever.
Hence the logs would always be in the following format:

Unpriv | Data | Write | S2 | <class_str> | TTD <Read/Write>

> 
> >  static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> >                                         struct arm_smmu_event *event)
> >  {
> > +       struct arm_smmu_master *master;
> > +
> >         /* Pick out the good stuff */
> >         event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
> >         event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> > @@ -1833,12 +1917,24 @@ static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> >         event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
> >         event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
> >         event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> > +       event->ttrnw = FIELD_GET(EVTQ_1_TT_READ, event->raw[1]);
> > +       event->ttrnw_valid = false;
> >         event->smmu = smmu;
> > +       event->dev = NULL;
> > +
> > +       if (event->id == EVT_ID_PERMISSION_FAULT)
> > +               event->ttrnw_valid = (event->class == EVTQ_1_CLASS_TT);
> > +
> > +       mutex_lock(&smmu->streams_mutex);
> > +       master = arm_smmu_find_master(smmu, event->sid);
> > +       if (master)
> > +               event->dev = get_device(master->dev);
> 
> Here, get_device is called upon a valid master...
> 
> >  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >  {
> > -       int i, ret;
> >         struct arm_smmu_event evt;
> >         struct arm_smmu_device *smmu = dev;
> >         struct arm_smmu_queue *q = &smmu->evtq.q;
> > @@ -1850,15 +1946,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >                 while (!queue_remove_raw(q, evt.raw)) {
> > 
> >                         arm_smmu_get_event_from_raw(smmu, &evt);
> > -                       ret = arm_smmu_handle_evt(&evt);
> > -                       if (!ret || !__ratelimit(&rs))
> > -                               continue;
> > -
> > -                       dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> > -                       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > -                               dev_info(smmu->dev, "\t0x%016llx\n",
> > -                                       (unsigned long long)evt.raw[i]);
> > +                       if (arm_smmu_handle_evt(&evt))
> > +                               arm_smmu_dump_event(&evt, &rs);
> > 
> > +                       put_device(evt.dev);
> 
> then, here it puts unconditionally.
> 
> Maybe we do need a memset(0) to the event, then here
> 			if (evet.dev)
> 				put_device(evt.dev);

`put_device` takes care of NULL args as well.

> 
> Thanks
> Nicolin

Thanks!
Pranjal
