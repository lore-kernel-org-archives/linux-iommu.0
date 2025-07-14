Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F423A9BF
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485089; cv=none; b=Pvlh0UtEuJ0wCbURZn3MJvQjPHSDa3HUX9NJmRo0es0Y3tsnDrQ6rgbZT2sQ+iweg5dKBQnbckEGW8in0vdtsA7QyfvKVInowiTiOA0E2sE2JMqnpiO5YnjxNBdtwJV6JR+9Xc5PwJTa1tHeyfXb/U4rd6J4H3MQg9F6gVI4iNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485089; c=relaxed/simple;
	bh=clyWVdShsejKjrsf3+OphE6VFWJT70Y/wmSzOFm9nCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBU7xwPbZ1IO3CnoY44jGuekw15kpWk8fXVM9FhXwlrhBC68fC6Da/yrK7sf5vjwoGu8Kz8eWLuGCHpAYeC+BJxB0PJHhPjkCJxLjIwQt6Mj6kUjQFHum1pN14Dl9cJmMSboFi57wzAmLkjXqfd0H0fSreFc4k3BmEWuWi2/nhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9hrOHYI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9hrOHYI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23dd9ae5aacso276105ad.1
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752485087; x=1753089887; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MWASbs9u4UTR98Pya8dizUj+GwoZ2VpwFFNp77X2Xt4=;
        b=U9hrOHYI/r5ie8hpmK6o9bKvCLzwE3/rciVuQC5DzgCcRX45ZUj4GOh/ZZHtH4nU9D
         8Ik5oAOjkzpKspw+dtWXHMdjr0AOKa2o8X7iy+i6Z6/IIea1ByVggVsg6YRZWEldt+gT
         1iqTqsaLmbgDsYZk2YEkOc6hArBT92ZL8ZqEzrlN7xk4UfHfbGUd4FI2Zcw6z8TmWxOb
         SWq83FFVf+YiYbNBGwuIMe75b7DsYj6RVepC8ElNM/xtxrKiPc+uQErKZ3PQWFSopWn2
         9iSVsDQEpiCtDxn0jWK64jWDW5tBCQSJAJhfMAZb5+PL8i11c2F06wMhEkJe3MJgNdBZ
         r9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752485087; x=1753089887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWASbs9u4UTR98Pya8dizUj+GwoZ2VpwFFNp77X2Xt4=;
        b=T7EBhTkmQ4fRijHVo3gH8Cn5PBnrOfaOnJn37d2KWSeltNpJbN+viu/6T5zBh1acwv
         29Y2WANfoKKjXR5dT9kJfFKnBRVvLetVDQCfYKDuEvf6EhJJZT82M8+sB+2qfKIxsHY0
         GYHQcjBa8pwRMS/tUB3V/oVYkdsPjPGWYmgV0iYk3RfEJJU9h7w6iLqdyxjrK/Fcb4kX
         Lo1G68f6oyPhGNvcly0RWOG7R5dvNWJAXCuKa0ZBuI12PVh76oX0aFOm5y+C0NGJ0Yt3
         G4bdrpJQf8tSlirisLs/OgjbCIimrLhbddgnEJ223yRysv8sp8hUQP2GMVRLvc/MygXk
         d9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJn70F8xuvtJ6FtD9CgibwwG3XgR2IsvGCSiZX2t3tygqKRw/Q1Tn5xT+DS/msKgMYG0EyAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0NPa8DgH/v6uyLQOcTq0YQ6Snn6WpmDAsdzwWC+66AEM38GlZ
	HDD8LzIgCsTwRjmJgkvHXe5/E7rLL67GDAmdl2NbLqDMPG1TX1z4xeR1LjQMWoVwlw==
X-Gm-Gg: ASbGncu9GB6LeR9bcvQVP8nksFEalQcy9vaMSeXyIqeyf1qUF3iliB03TGgYXWw0tvc
	cZLS3cbp/lfPwjV1DWhJbCO7DmnoSIe0UMJsTeHy3HqXp3/O2kaeDWZHgHBUi5juDh0oeatQ/ye
	jkf+NCpWK9syWf+cTW5yEjhfefgGTRLBAJXq+knKh8W3yu0QTXxUGb55Ufbl1n0nMBwVQvqHgty
	vIlVQmMCL8S5207oQruTcnpKARnznTtJ7WYDwKgwv5if9S+acVOW2LhJteY6p2SddILSh2bScli
	fKrjNwXtyuCq7bbP7IhhRxfupfAYiqbxeqitVc0rDlx5boYFyZEVyZ7lfgboA2KPQAnX/DAU12x
	BHIP73hNuWWudRIPnwz+q+XspPB/zldxlJc2LIu+fWLUM37zihPz7GR1Ln3Rtm+Oxop4=
X-Google-Smtp-Source: AGHT+IEeTVunPlzK9ew6lkzPlaJ7AuSlpHQMOD9rmtDfC7ollC2KeeNjYubyCneelTSdzcBuLTizSA==
X-Received: by 2002:a17:903:15c8:b0:234:b2bf:e67f with SMTP id d9443c01a7336-23df7b2e08cmr2774475ad.9.1752485087304;
        Mon, 14 Jul 2025 02:24:47 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43352b5sm89847175ad.165.2025.07.14.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:24:46 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:24:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 2/8] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <aHTM2XBoyvuRHEs6@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-3-praan@google.com>
 <aG05-KFZRivJ5iHY@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG05-KFZRivJ5iHY@google.com>

On Tue, Jul 08, 2025 at 03:32:08PM +0000, Mostafa Saleh wrote:
> On Mon, Jun 16, 2025 at 08:31:43PM +0000, Pranjal Shrivastava wrote:
> > Before we suspend SMMU, we want to ensure that all commands have been
> > flushed by all the queues i.e. the queues are empty. Add a helper
> > function that polls till the queues are dained.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 40 +++++++++++++++++++++
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
> >  2 files changed, 43 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index f19a77708d2c..0df1b17a09cc 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -981,6 +981,46 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
> >  					   cmds->num, true);
> >  }
> >  
> > +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> > +				    struct arm_smmu_queue *q)
> > +{
> > +	struct arm_smmu_queue_poll qp;
> > +	struct arm_smmu_ll_queue *llq = &q->llq;
> > +	int ret = 0;
> > +
> > +	queue_poll_init(smmu, &qp);
> > +	do {
> > +		if (queue_empty(llq))
> > +			break;
> > +
> > +		ret = queue_poll(&qp);
> > +		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
> > +
> > +	} while (!ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> > +{
> > +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	/*
> > +	 * Since this is only called from the suspend callback, we
> > +	 * should be able to acquire the exclusive lock without failing.
> > +	 */
> 
> I don’t understand the comment, can’t the command queue be busy at this
> point form another unmap context?
> 

The expectation would be that if we entered the suspend callback, all
clients are down.. if there's an interrupt I think we're holding the
power lock during the entirety of this callback, thus the client should
sleep or spin at rpm_get() for the dev?

> > +	arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags);
> > +	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
> > +	arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> 
> I wonder if that’s enough, I see that if arm_smmu_cmdq_issue_cmdlist()
> is called with sync=false, it won't touch the exclusive lock, so what
> happens if another driver keeps unmapping, that means that this thread
> can loop forever as prod keeps growing?
> 

I'm not sure how can we enter suspend while a client is awake? I'd
expect the devlinks to ensure that suspend isn't called if a client is
awake. If it wakes up while we are *in* the suspend callback, it will
have to wait for the entire callback to execute, i.e. it will spin/sleep
in the rpm_get() call for the client device.

> Thinking out loud about this, if the aim of draining the command queue
> is not TLB invalidation but ATC, maybe we need higher-level
> synchronization between those 2 and keep the command queue out of this.
> (this also applies for the next patch for tegra)
> 

Hmm.. I guess that would mean issuing all ATC invalidations synchronously
We already hold a PM ref while issuing the ATC inv commands, but I think
we'll have to issue all of those with sync (wait till CMD_SYNC is done)

> Thanks,
> Mostafa
> 
> >  static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
> >  				   struct iommu_page_response *resp)
> >  {
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index dd1ad56ce863..461f1958e574 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -965,6 +965,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
> >  int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
> >  		       struct arm_smmu_cmdq *cmdq);
> >  
> > +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> > +				    struct arm_smmu_queue *q);
> > +
> >  static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
> >  {
> >  	return dev_iommu_fwspec_get(master->dev)->flags &
> > -- 
> > 2.50.0.rc2.692.g299adb8693-goog
> > 
