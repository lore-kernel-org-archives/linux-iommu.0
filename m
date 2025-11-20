Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7442BE7D6
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763671708; cv=none; b=Ehb5/gmLdX5dp0FUYWzD/EcFJTY6JNZgNf+uQgVB3/cqFdtPPyqw9SI6xdrackaN9EpSEYUH6j0o13Noa9dt7TzAOF6Fvum1idbIHwiphlunxJH/MckSBWC6BYRZoBPIUSpJDiq+183y2q6WjENIIQmaRNDC1IrKMk/lYQYyiB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763671708; c=relaxed/simple;
	bh=UDBD0JsJOXXKb2zaRtooozxfrVJ/4Pek1aeJS4q826A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLB+8mf4SlN26AiX+GQlT8PGL7S7uGLZRJiphui0BBlp338J89dftUfH+DIUcTj1OwS7qqUrfoBPGeLRY+lXvr3EhffE4ot5Ws+EMFkTvCrZ8Jt+kN/HaXEzuqONC/stlKSoVZfsERUevdkXNYh6q2X1C4uqZx/e7iamLzx1OmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUyb2+x3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUyb2+x3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e13bf404so45585ad.0
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763671706; x=1764276506; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzhPEb1UB17UQMdiJJMhr98mv3prufY4k1YN0qCWfLs=;
        b=aUyb2+x3DgwAOQGUrQy03KZiKmeg2eJfOSs5CiDbUxOfQCk9x0DRsWnjE7GEHzF0nD
         r8530SyWMdFr+L2uhcq5ASiVUpu0m4zjbKBFag0k52Za9YihE6yMVrRpgtSnx8Cn2i5c
         ZGkvhtESkyePljuSgCs2xxUrADh7dLpwPehJZv2uqA2P/Zz+ioOpPFVjLpnQsBFuIyOX
         OyEe7YmW3i4tQxfuUd2VD24qwpWwSID2dDMHC6DW+rK/h9fe0oi5nqyRKMzAYPzEUlmH
         YzyfB1bpjbgLvZ4YR4Ij1QmgYIi1KNq/5ag53VPkv1m8iDbsxGLLzV5oPKfB9tqqquxn
         +dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763671706; x=1764276506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzhPEb1UB17UQMdiJJMhr98mv3prufY4k1YN0qCWfLs=;
        b=oYCgV0glAZDdFyZP9opDzpGBxQisIfl7j+P6xi7VQ8x0jJxgUpljbggv80XRy2NQ+1
         jsWu9kXAWOjqM7DTZZhjEGXAmo2PSaGOBFH95sXu+I/3vC/3BjTxubc90HLF86uGVsIY
         dDH5YAmO9UnbAE2SAlIkC8s2gicHbt124Eq13HwYZ7o1Uu3Ajm3NJgRVUVO0ScP4LkKe
         lZKLGzkOJy96qC47IJGUWcN4aixAuASZIiSbXwpihncwe414bcNW7nCQIS18ZvqKxFj7
         zzJq0kWh6Xci6Yie2T6sjAjdwFTrKj9ri9sFy13cHQphWZ29wh7aSX4x7YjZJgUO7zR5
         OdEQ==
X-Gm-Message-State: AOJu0Yx0elz332cx01BzJDlIFDowPS8HFbE/8YqaLzWrvbRaIg4nTMUL
	KHvPKksGSGHNIT9vRlX0ZYVgckUXMB++OpLifuCGmeJRgHfJC9SX6tjgkI9+gqmAbw==
X-Gm-Gg: ASbGnctB1QZAW5KRq7ncrLgo/srnOYTlhdlGmUGUOHrmHrecB/7AD9wpHE/e3Qx59P3
	nMHSKuQtcfAJA8Dg6K/t7FTdTPB01sLOZIlYU21vbZF00d7m6fqflkJCCV7FasKINXRr6gNJ9zb
	tB8m3y81Oip2pSznnmYKCLiMpZ7bi+sue2X134TWLaKdFT1epRo/PRdVgPSULPEhOslB12TCt3G
	N4S/79Ac4C5GrJuEMKex1a1uWxMLzjn76y5lOuoQDq6/NsduvOyxzKEeqc+OTuasCTHM85oJZzR
	3AkweZwKuYpgDZ2hxoVR4rYIrFVkwJtsmZqybvvADfhuu4QOMF6Heb9mMFtD2w5B28MXA3vFqcw
	eXDYiKdEcCGzy1DfJk9o12C85LaNxAZs5g79g0kG7NNXjYBHqGyY8uGf9Ai+sE9a4c8T+Ng9vQW
	5+LmAlJlOhR+o514ZU65nu1x3W8GDYuR5SvPdmVVVIn51Oh7Z8lGArzsl4M3U=
X-Google-Smtp-Source: AGHT+IEVryv0QjJp+uK3JdX6eftrOdgvp3pg2pnmGcZxlMzGmT6UHy63Eqa5yO6NU29AYbHJUDUqvQ==
X-Received: by 2002:a17:902:e5ce:b0:297:f2a0:e564 with SMTP id d9443c01a7336-29b6bd9da38mr19305ad.11.1763671706088;
        Thu, 20 Nov 2025 12:48:26 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm35552315ad.58.2025.11.20.12.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 12:48:25 -0800 (PST)
Date: Thu, 20 Nov 2025 20:48:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 5/8] iommu/arm-smmu-v3: Add a usage counter for cmdq
Message-ID: <aR9-lcvikljj63P6@google.com>
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-6-praan@google.com>
 <ff23e8d8-180a-434e-a198-b00d16884abd@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff23e8d8-180a-434e-a198-b00d16884abd@amd.com>

On Tue, Nov 18, 2025 at 11:35:01AM +0530, Sairaj Kodilkar wrote:
> On 11/18/2025 12:44 AM, Pranjal Shrivastava wrote:
> > Introduce a biased counter to track the number of active cmdq owners as
> > a preparatory step for the runtime PM implementation.
> > 
> > The counter will be used to gate command submission, preventing the
> > submission of new commands while the device is suspended and deferring
> > suspend while the command submissions are in-flight.
> > 
> > The counter is biased to a value of 1 during device reset. A cmdq owner
> > or a thread issuing cmds with sync, increment it before accessing HW
> > registers and decrements it with release semantics afterwards.
> > 
> > A value of 1 represents an idle (but active) state. A suspend operation
> > will set it to from 1 -> 0 representing the suspended state.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 69 +++++++++++++++++----
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
> >   2 files changed, 61 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 1d6c60bee7dd..d6e75d1646d6 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -794,7 +794,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >   	u64 cmd_sync[CMDQ_ENT_DWORDS];
> >   	u32 prod;
> >   	unsigned long flags;
> > -	bool owner;
> > +	bool owner, has_ref = false;
> >   	struct arm_smmu_ll_queue llq, head;
> >   	int ret = 0;
> > @@ -808,8 +808,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >   		while (!queue_has_space(&llq, n + sync)) {
> >   			local_irq_restore(flags);
> > +
> > +			if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
> > +				/* Device is suspended, don't wait for space */
> > +				return 0;
> > +
> >   			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> >   				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> > +
> > +			atomic_dec_return_release(&smmu->nr_cmdq_users);
> >   			local_irq_save(flags);
> >   		}
> > @@ -868,10 +875,35 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >   		arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
> >   		/*
> > -		 * d. Advance the hardware prod pointer
> > +		 * d. Advance the hardware prod pointer (if smmu is still active)
> >   		 * Control dependency ordering from the entries becoming valid.
> >   		 */
> > -		writel_relaxed(prod, cmdq->q.prod_reg);
> > +		if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> > +			writel_relaxed(prod, cmdq->q.prod_reg);
> > +
> > +			if (sync) {
> > +				has_ref = true;
> > +			} else {
> > +				/*
> > +				 * Use release semantics to enforce ordering without a full barrier.
> > +				 * This ensures the prior writel_relaxed() is ordered/visible
> > +				 * before the refcount decrement, avoiding the heavy pipeline
> > +				 * stall of a full wmb().
> > +				 *
> > +				 * We need the atomic_dec_return_release() below and the
> > +				 * atomic_set_release() in step (e) below doesn't suffice.
> > +				 *
> > +				 * Specifically, without release semantics on the decrement,
> > +				 * the CPU is free to reorder the independent atomic_dec_relaxed()
> > +				 * before the writel_relaxed().
> > +				 *
> > +				 * If this happens, the refcount could drop to zero, allowing the PM
> > +				 * suspend path (running on another CPU) to disable the SMMU before
> > +				 * the register write completes, resulting in a bus fault.
> > +				 */
> > +				atomic_dec_return_release(&smmu->nr_cmdq_users);
> > +			}
> > +		}
> >   		/*
> >   		 * e. Tell the next owner we're done
> > @@ -883,14 +915,23 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >   	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
> >   	if (sync) {
> > -		llq.prod = queue_inc_prod_n(&llq, n);
> > -		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> > -		if (ret) {
> > -			dev_err_ratelimited(smmu->dev,
> > -					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
> > -					    llq.prod,
> > -					    readl_relaxed(cmdq->q.prod_reg),
> > -					    readl_relaxed(cmdq->q.cons_reg));
> > +
> > +		/* If we are not the owner, check if we're suspended */
> > +		if (!has_ref) {
> > +			if (atomic_inc_not_zero(&smmu->nr_cmdq_users))
> > +				has_ref = true;
> > +		}
> > +
> > +		if (has_ref) {
> 
> You can merge  above two if condition as follow
> 
> if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> 	has_ref = true;
> 	....
> }
> 

Hmm.. yes, I guess redundantly setting has_ref = true again is fine..

> Thanks
> Sairaj
> 

Thanks,
Praan
