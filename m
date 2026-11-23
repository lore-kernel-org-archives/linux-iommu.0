Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441613;
	b=F0thbOAkBH4u0Yj4F5oPyHGlR3TTQWgYuDBKCoXq9slX0Gn9FffNJM4YqitvWxLXdjgY
	 Rr0EqzufpE6ExvYiKLudLq2niYPR7CJeCZPc6KBPkXJcYwyhAXrF3QjB9XqnNm+mnalaL
	 zHGdaeQx/qYqpdsZ4E+LTYLCeMKdEt5nha0K+4sorVZDERuf692xR+OwuYjZoZwJeOB/f
	 yTxE48jqzVmXAGrHosNdbCzzjC1582iGvIiOW5FyyMqTp7buQdH73NFW3BvRMyKgQOeS1
	 GYDub9XCRo+IL9swB+YJRPXptIc2Z12vfuZDxrcHodnY8lAKeiSE9+p+M6GI/XF4Nwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oM3xVs7K0+cGhkDXcxAVD5yhKjuUtv/5wSCqKlsYXus=;
	b=NOMFho3ScQaAPL9P0qQuNXE1SUfLW0dKbKSG5+hO3KJEllLAFjyVbBlpA3jBiCgRfhFN
	 cY4ci+NCwqnPhB5jSZ4O2rhOhEziJVFmTFC9sfBfvDvwo2wuDLfJ+f5jcBU95flny1q0A
	 Qd7xcg57xadKGb9hZEXc22E/PvzmcO5c7UN50MfVNnjL1ZBEfW1q7yU2+Kbsp5p0HajhP
	 qWLY+izXod59Oh1I7wbT77rd+OjUKU1fRgPAXORND2h1vgFJmJGKwYqYDLXDGWOObpCdw
	 UA5VfZ2tcAF5QdhGxsbt2uXxPJiyf73XFgJuR/d6PMUXx7igC7hCmZ3E2CkQV2JoaRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L94Ky05N;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26521606A330
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 13:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26521606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L94Ky05N
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533202fe429so444641cf.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795441612; x=1796046412; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oM3xVs7K0+cGhkDXcxAVD5yhKjuUtv/5wSCqKlsYXus=;
        b=L94Ky05N7i6SqquvD219sexsUwNglv2JFZn/CGi2qTtgR94YxlPCTlWl3pzXn1SyDF
         +2qyrPDLcrIVYT+ta1D6hFPlTGrn1r6+IU58MTUKfG/LhfrSmvGCoMUZtaXxEhURL0xl
         PcDwELb6UkXUnY8eE04U1hMtedZ9970AgaHFN3oFyQ5j7Rcjx5PRw9xCaV/UVXK0ReRl
         Cgi+NP45Hr5/mJGbMzWPVppDWYkr1VCX9dhd/DfI2jmtch+VYqR22nD2ONUBAIQucJh3
         ggrCNfuPo/Qa2JYg/TVY3jr+Lk1zvJYT59OBisBBVw8hJldCCQFvWbUSHmxEtZScmFcy
         PNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441612; x=1796046412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oM3xVs7K0+cGhkDXcxAVD5yhKjuUtv/5wSCqKlsYXus=;
        b=rt0VDMiIHsdOpSxeTdVLMDEXFYP7lNdP6Z4qJ/ELzDYs5HyZNT9bQ97QovRjhtO/go
         XUKGcVVhIQ+yJ85YLCg0BI6+bT/c27r6OOThnnFxaidysKyQrgR7vfW9B0ZAN3Y3WL3W
         seSvDq6u5TpcxfP6v4/Ulid8W1dRoIVOeCF2Xz8sPxTiGySq2cbo5ada/DNBtIhL/PYz
         8QOipiLDa/03xrOK9aIDG0pu89HglyRzAgZZ1yhBLfXlAD5U91UhwMMlj+YtOUgQ7Neo
         wY0zkjsX9gIvWruXy4JBkiW+OExLWABhETz6fEY2HcfmNiE0jEVvPlzfhJGwrLwPMzks
         BTZQ==
X-Gm-Message-State: APuU4Z/DYVnescSEd/u40gt1UtzaVwB4qbuLywqwAZtbaWFRCcGCfpV5
	DElw+aTRDvbQdDSsKgaom2IwZmCUCBIxXr9Qr27deuHKsteIy4mN4TwEyWwhc+EHAQ==
X-Gm-Gg: AZFdTZfO0grhMR5W03LxXbjFi/a+pdoqqjz6Awq/iRp/kRIZ7FG4mudFhH1v2NXCBsX
	BiIJ+0rjEA73U6ooWhH6GiYPZZjVgL6gfQwucgWPum+GJrW/QMv9guSxHISvPX6Po52obRA1t2x
	5FQhMYlck/YuM00k3Eq+LyORY1LTlsVhd9yO7Z4dsnaAPAaeHeLVk8NBvzQfdRcZ5TxX+rs8vNM
	HmvXh/GkOhHzzlk9ISFIsWYgKYg8gBoclOvXHGYHFTfItW87pG1tKFIXl+pmNISdqeoOINXXrQw
	Hc4TIUrOxR/qpfKMsuBin8A7tatHxY5oBnaPj91Gz65jJgEj9IV3bZXb6R4jlnxzXB7PnotZ8Dl
	WjtzwO3pz/uTpXNburTy5P9hAzAL8Wqe8iK1q/7puynQAHpZNKTsGFblzabJGWkPwvjSGJXUHtW
	2NQqQZOHMH5fHO3hn+Z/JRqido/7S76lK/pNA5/nqtO2e2eCb5VtAG9Yx1JNrT85/l/f5mZtPK/
	0o0OdfM/yxHWaylFG5zJc6TDNtU0bHUJLd7Rw540/XDgfbaTqn5fmaFTvmFjmKg/D6kLlNk2yFZ
	eUbAzqAJNUdLIVRS6IQCJafygGvnZr0FLs1I/P3AQH4n3y6H944WvmnBnu69fyVViygd
X-Received: by 2002:a05:622a:5817:b0:536:78de:775f with SMTP id d75a77b69052e-55d8909c85amr32019921cf.15.1795441611495;
        Mon, 23 Nov 2026 05:46:51 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35055486sm8586840b6e.12.2026.11.23.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:46:50 -0800 (PST)
Date: Mon, 23 Nov 2026 13:46:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: John Garry <john.garry@arm.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <awRDwxkrZjouy9b9@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <0fe0d909-a01b-4f4f-9faa-c533b8925f25@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe0d909-a01b-4f4f-9faa-c533b8925f25@arm.com>

On Fri, Oct 23, 2026 at 09:17:26AM +0100, John Garry wrote:

Hi John!

> On 9/29/26 04:45, Pranjal Shrivastava wrote:
> > Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> > queue's producer index to safely gate command submissions during device
> > suspension.
> > 
> > The flag embeds the suspend state directly into the existing global state
> > The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> > which acts as a Point of Commitment, ensuring that no indices are
> > reserved or committed once the SMMU begins suspending.
> > 
> > This prevents a situation of "abandoned batches" where indices are
> > incremented but commands are never written, which would otherwise
> > lead to timeout during the drain poll.
> > 
> > Update queue_inc_prod_n() to preserve this flag during index
> > calculations, ensuring that any in-flight commands that successfully
> > passed the point of commitment can proceed to completion while the
> > flag remains set.
> > 
> > Suggested-by: Daniel Mentz <danielmentz@google.com>
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
> >   2 files changed, 38 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index a123810fac57..7f89e2306942 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
> >   static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
> >   {
> >   	u32 prod = Q_POS(q, q->prod) + n;
> > -	return Q_OVF(q->prod) | Q_POS(q, prod);
> > +
> > +	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
> >   }
> >   static void queue_poll_init(struct arm_smmu_device *smmu,
> > @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >   	do {
> >   		u64 old;
> > +		/*
> > +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> > +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> > +		 * our new indices yet, we can safely bail. Once the indices are
> > +		 * committed, we MUST write valid commands to those slots to
> > +		 * avoid indefinite polling in the drain function.
> > +		 */
> > +		if (Q_STOP(llq.prod)) {
> 
> I know that there has already been other comments on this "stop" flag and
> whether to use it in this way... but, if CONFIG_PM is unset, could Q_STOP()
> ever return true?
> 

No, the flag is only ever set from the suspend path. Since I'm moving
the PM bits under CONFIG_PM in v12 anyway (per Will's comment), I'll
make Q_STOP() evaluate to false at compile time when CONFIG_PM is unset,
i.e. IS_ENABLED(CONFIG_PM) && (p & CMDQ_PROD_STOP_FLAG), so all of these
checks (including the one in queue_inc_prod_n()) just compile away. Does
that sound good?

> And it would be nice to not add extra logic in this loop. It is very timing
> sensitive, and adding extra checks can increase the chance that the cmpxchg
> fails (bad for performance).
> 

That's a fair concern. A couple of things here:

     - The check is on our local llq copy, which we've already loaded, so
       it's a bit test + a (not-taken) branch, with no extra memory access
       before the cmpxchg.

     - Per Will's suggestion, I'm making arm_smmu_cmdq_poll_until_not_full()
       bail out on the STOP flag, which lets me drop the check at the top of
       the loop and the extra READ_ONCE(), leaving a single unlikely() check
       right before the cmpxchg.

It does need to stay in the loop though, since the cmpxchg is the only
point where checking the flag and reserving the slots is atomic.. a
check any earlier (e.g. in arm_smmu_get_cmdq()) could race with the
suspend path setting it.

Thanks,
Praan
