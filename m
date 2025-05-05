Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1F17B425
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457851; cv=none; b=CMgsQVuCejJkvPXqrh5aFyaB7dcEQ1heXFA07zsG0NraABj8M8XwS5zL+iqHOCP4OI/TgfbHLbJqeqwouaAz17rEU+okh1xrSHzxqlqyBXWkY8CcXk6qTlZUsw3prLh/OPhbi54BkV24tDSJ4yV4QrzTmgQMoVmi0zinKFJxriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457851; c=relaxed/simple;
	bh=nLn/Fp+5YieRMoaQcfgLjhQggyC8xwCbSFqbkohCMCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMwSdKkIX4BsUvlQRgCKkUgxqUfaCwO/5ctklXODjX9KJ9RITp0mvy8oovsy3tX8QThUDHmZeTWvkreIcHB4/ZUm7kc9BsznRqYEswk1gAL9kM0Vv1uA2o1YKRKdyojiL/OGoPdkRxxZmLe4UPAYVT4RArX7/zmtgy847hqJnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxBK3PWU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxBK3PWU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22e1eafa891so188315ad.0
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746457849; x=1747062649; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmVz0bwTKe8Fhfvg7FzdiqrtSU3RLmYBZvPMmjJf64M=;
        b=VxBK3PWUrZ3KfK28fZBqDvDV9rNiUWEkYf53+SqDJqS+/kt28JSQ/HYSTuw9Wh1yim
         xG8liiXNaTcPsEI6XRtz9oWsbwr0J8T+ZOLSa5mLX6sukFus3CEfOyDY9tm+fCwphA3V
         +KiUI+DoXBkzHiGZHWDQXXrxfOsdisKgxRzEWYC1KyzTnOOqRZb3zS2PF5vtue+ICG1J
         Ty+8GXnW75dBzbBjQrCLuK0spXwBtG/lOdMgAqS48Y8W6zEoaTlXntMv+o9uRMxxCAo+
         1OKqED29Q7pZPH2IkFigDaRmQDp2Th/wG9Ykh2v5/5KrrX2Kll8Lme8vArr9hD9mGZyj
         1jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746457849; x=1747062649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmVz0bwTKe8Fhfvg7FzdiqrtSU3RLmYBZvPMmjJf64M=;
        b=Vxeez11wpBikn59mgt8/ZM8bu9YkBjcuMjsicIyJB475eFmxaFnpx+lWVfyWXXnW/2
         EkM/S/u5pBkhNEwFQIE3la3A9r+yDc6ZQYdneI9A5SRP52m7D1+WrpTpv/fLeylFP5C8
         3Aio4p6S210nUgEAu9ZWVmmDlzDj6VFh8QkuV9l5RboE9HrjTwGGrFZOD8xtOTILs0P9
         O9/tGbdqbIgsCqDSZyBSfUuIwb7AfDKxKxRj+p6UmHkiW03LscndsDTzwBoGAJik5ou2
         NArjtWZbfCwX01RTjNxlPgNUCQknDHAUhDFoCLn0BexvUNAX4S4Sm0lonCGtcjLShOeS
         DJbg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1KSm7VHwTEgtptLXGpYAw36bwx6EEA/+Os1ERp9OeT7BvP/kwm8Gbx037vilCa3vUYyaaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWXRTjGIgcja2EqfxnOuDuhIS3EEA1tP/IYX65tY0Fz4g+Trzy
	n0xtO9FILoj5BYv7oVZ+ex5qiZ2Uw+KXGOLt2pgYbWrUGtSWGnFdeHjSuDVcdg==
X-Gm-Gg: ASbGnctkAtNVKhC7FrtHMuHnJy1XkNPThrpGzvmNusBMIezs9A6qD7V9NquFDoQNdDB
	9FYHE64dczbmCcejYlhLZjrlWq1tFso+p/Cdqj9KnMDcx2+pvjBFsuIrOLUaxVhlfk4F77Yga8a
	ZnJoRRxsJB3jygcvpNDwaj+Dj0CQleXaBMdSOx72TXqmkAHIIhNlDTuD9SY5FE4fJZhNRvQGZTk
	r18slXiIpvJIU3Fmv7jEQP8mHcaZUQzJGaqC+f/8edulmuQrouZOrVMpZ52HRNHBnimSik/7Zb6
	mkuFt9jkHeKJEpYyBPpZ5GwzXs8q5hYKW4hsCf5XVbkwrj96oqdYtd9Xlz6n6TBgbo8ZynlD
X-Google-Smtp-Source: AGHT+IFCWzmHZwOzrWDHu4fm/pnFV8gjAFoeKvXm92WN+XFptz6FA42eMWdTPQVZ411BNPExIhCseA==
X-Received: by 2002:a17:902:cf02:b0:216:201e:1b63 with SMTP id d9443c01a7336-22e3176bee4mr165015ad.11.1746457849070;
        Mon, 05 May 2025 08:10:49 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e9df5sm56066925ad.82.2025.05.05.08.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:10:48 -0700 (PDT)
Date: Mon, 5 May 2025 15:10:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v2 02/10] iommu/arm-smmu-v3: Add a helper to drain
 all queues
Message-ID: <aBjU8NnohMiRvvnP@google.com>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-3-praan@google.com>
 <CAE2F3rDHGjwh+fcW37VnUG6dOyrKkxEseKMmRdZ7vzCroM6PrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDHGjwh+fcW37VnUG6dOyrKkxEseKMmRdZ7vzCroM6PrQ@mail.gmail.com>

On Sun, May 04, 2025 at 01:28:13PM -0700, Daniel Mentz wrote:
> On Fri, Apr 18, 2025 at 4:34 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +static int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> > +                                          struct arm_smmu_queue *q)
> > +{
> > +       struct arm_smmu_queue_poll qp;
> > +       struct arm_smmu_ll_queue *llq = &q->llq;
> > +       int ret = 0;
> > +
> > +       queue_poll_init(smmu, &qp);
> > +       llq->val = READ_ONCE(q->llq.val);
> > +       do {
> > +               if (queue_empty(llq))
> > +                       break;
> > +
> > +               ret = queue_poll(&qp);
> > +               llq->cons = readl(q->cons_reg);
> 
>  A readl_relaxed() is probably sufficient. 

Ack. I referred to __arm_smmu_cmdq_poll_until_consumed() which uses
readl, but I agree that this can be _relaxed as for the former we had to
handle a case where multiple threads are polling on their own CMD_SYNCs.

> Also, in other places, they
> use WRITE_ONCE to write to llq->cons. Compare with
> 
> WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
> 
> in arm_smmu_cmdq_poll_until_not_full.
> 

Yes, I believe that's to avoid store-tearing and re-ordering when we
have multiple threads potentially polling on the llq.cons

However, I don't think that's going to be the case in the suspend
callback as we'd atmost have the page_response responding to a stall
event and issuing a CMD_RESUME (without a sync) which won't poll.

Although, if we're looking to use this function in other context apart
from suspend, I guess there's not much of a harm in using WRITE_ONCE()..

> > +       } while (!ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> > +{
> > +       int ret;
> > +
> > +       /* cmdq */
> > +       arm_smmu_cmdq_shared_lock(&smmu->cmdq);
> 
> I'm afraid this might not be a correct usage
> arm_smmu_cmdq_shared_lock. I understand that acquiring the shared lock
> means that you want to prevent any other thread from updating
> cmdq->q.llq.cons, which I believe is not what you're looking for here.
> If you want to participate in this locking protocol, I believe you
> need to acquire the exclusive lock.
> 

Ack. 
However, I believe there's no such need to acquire any lock here given
the fact that `arm_smmu_drain_queues` isn't expected to be called from
anywhere else except the suspend callback... What do you think ?

The only case that I can think of that could possibly contend with this
is the evtq_thread handling a stalled transaction with a CMD_RESUME
which could be handled by first draining the evtq.

The callers which plan to use arm_smmu_cmdq_poll_until_empty apart from
this could use the appropriate locking, I can add a comment about that.

> This being said, I believe you need some other mechanism to ensure
> that no new commands are submitted to the command queue. Otherwise,
> the command queue could become non-empty after you return from
> arm_smmu_queue_poll_until_empty.
> 

I think the fact that we're calling this from the suspend callback
itself ensures that there aren't any clients actively issuing commands?

The only exception to this could be the other two queues having events
which require to be responded with either CMD_RESUME or CMD_PRI_RESP.
For example: a stall event that requires us to respond with a CMD_RESUME.

We could drain the other queues before the cmdq in that case.

> >
> > +       ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
> > +       arm_smmu_cmdq_shared_unlock(&smmu->cmdq);
> > +       if (ret)
> > +               return ret;
> 
> This is basically a command queue timeout. Consider printing an error
> message similar to "CMD_SYNC timeout at [...]" in
> arm_smmu_cmdq_issue_cmdlist.
> 

We're already printing that in the arm_smmu_runtime_suspend:
	dev_err(smmu->dev, "Draining queues timed-out.. retry later\n");

Are you suggesting to print it specifically for cmdq with the prod/cons?

> > +
> > +       /* evtq */
> > +       ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->evtq.q);
> 
> I'm not sure if you can use your arm_smmu_queue_poll_until_empty
> function on the event queue. I understand that in the case of the
> event queue where the driver is the consumer, the driver's version of
> llq->cons is always more up-to-date than the SMMU_EVTQ_CONS register.
> In fact, I'm afraid you might move the consumer index backwards with
> "llq->cons = readl(q->cons_reg);", because llq->cons is more current
> than SMMU_EVTQ_CONS.
> 

That's a good catch! Thanks! This also true for priq, I think we can
have a dedicated function for draining the cmdq as above and another one
for draining priq and evtq.

> I'm thinking about the following proposal:
>  * Drain only the command queue. Use a local copy for llq->cons. Don't
> write to cmdq->q.cons_reg

We're not writing to cmdq->q.cons_reg anywhere? And we can't rely on the
llq->cons copy since it's ONLY updated when the last command was issued
with a "sync" which isn't guaranteed to be the case always.

>  * Don't bother draining the other queues

I don't think that would be appropriate, we can't leave a stalled
transaction before suspending and should handle all Paging requests via
PRI. In fact in the v1, Robin mentioned[1] quite the opposite. 

>  * Backup consumer and producer indices *after* disabling the queues
> in SMMU_CR0. This would involve writing to cmdq->q.cons_reg

So... basically handle the pending stalls and paging requests when we
resume later? 

Also, why would we write to the cmdq->q.cons_reg if it's going to be
lost with the power-down? If at all, we'd have to read the prod/cons_reg
values back into the SW copies. Am I missing something here?


Thanks,
Praan

[1]
https://lore.kernel.org/all/20250319004254.2547950-4-praan@google.com/T/#m6f479d70d666252a657fb3ff57ff1764267a892d
