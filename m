Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FE256C8C
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750037; cv=none; b=K1A1Hyk+uLwR5RROn3JsfUXjOqQc0qEEAifgWgUdzEr7yatGckYo/iC96M1J0VHWVXCBQfcCM7zb8f7xx6jrK0C1V0PEzIs2LFCyNF8ShciAh0lTWY0GBvamK3zuzKxO5nzw6fbKb8Y/ZlNmErAxdd0ctLQxErFMZUH2heZrkUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750037; c=relaxed/simple;
	bh=uf7WDE5BynJaNOQErU0eL6EL+tqAgWSDB3KbSjAvmSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijD3eRhsQO6Js69n0TUE4wNYgnwzDJef8vp75oVlZ8hDb5jqix3K21MUqS6k28rxibAWXJVDrg7vzoRDkPbkOAbarvLZdQiVjXw6jm4ZesxSARTQYxWRsufBs1VUu3nlizRT2wJo7X8eBYXK4r35EWLw1vAw+h+PhLAjvKgWSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1+KOtaI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1+KOtaI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240aad70f2so75955ad.0
        for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744750032; x=1745354832; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sULZyjWsLP2sHqOiSlLJ5pSg+rcP01y0FmxRhFtpIc=;
        b=V1+KOtaI7sYFpxzOgTSGbcXxvc5GD2BiwJy480OtkJvJNsX5UZidiCLi7+T15RwE0r
         my12pph6F71QLrGyrRc7scTVByGNn4mE3Ubz/nrCHoVc6IcUWTLhayyYzxwuGPPrxTqL
         psDa/QPJm4h67gFFciLYAsoz70ZPxSdHIapqaCO7PObanhtoyYylBvbD8QLS8UCXhm2i
         RovwbyiiRDgaxUwk5S30VxYtgGFb9r+1ntrbcdrwNxxqZtPss2zk7rOV7KMzb4YAs4eo
         s2PLej4L2Z6ger7isi8+OEsiRufI93JRl04h6DtAX4N6n9cCV8On6EoB7aM7Lv5kyCAt
         ugHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744750032; x=1745354832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sULZyjWsLP2sHqOiSlLJ5pSg+rcP01y0FmxRhFtpIc=;
        b=SaFLpFnTWe2OD/8Dp8SDeWEJJyEvHPDfD9PiRuRTYmZScTBchJJWEakJhSxOwTYeM5
         CV4QiY4cT58kRelKEZ06fSCW9WsMRd9w/ifLzDi/n1c4MWlIVDpyHHSz7xPfq9R8wEwh
         BHIR+GlGpPHxmb91izW86pcoX2wsXw5h4s9Lm/o2k2EnlNTXSpmXRkn5GqVz4XRwJ1Sa
         zOF1hDE8KRBJn3VFCjUonu7vrQx8BofiLhyb+41k5Udg+oZN6+1lmaX4bcJka7mj0g5U
         ZZbl497hXx3wYVws/Yk9xbUkyBNGeGzN9ha2BHe8QmOcFY0PbJH9QuQKxgcVJPc5WjHP
         6/ag==
X-Forwarded-Encrypted: i=1; AJvYcCW6hpYKPcRCcJZpse/Zx1y52NTtvnanE4dIQr/gdBb5TwaTUn9RgGQY9sWLPzpzj33Gxd91mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE0XqR1qe7tqltIyO6A6Q80CFJm+8nRQu5DM06VdvhTWKidVTH
	MpiGPC52FdOCYPdhzkcyml3jdJjmL6LQ8ZVRQ26eCjLXKpx86LNixcxHiXkrnw==
X-Gm-Gg: ASbGncuVNTdGyyyEkq0x173pIj1/qne7sEtY6X210HDz7hOokhPMZHlSeraKHlLXchm
	M+XFyA//xSutyq5xMUWwN8F02O48SII787ui+sm1ebDOnNHVMbi8R7vJOmwH/QRWZlO0vWDYxXH
	t/up1dNkx+lEQGJqM4o9ODTmw/6gEqoV16vJnxvor9cfWX9TuxWvgbzrkQxl8rItCdlfi2gcqs2
	jV6jtyDu81tFMjmgbioxQG4V7NXkoAAfRZaue47Oclrm1OJstKcJvKTx8V4JLHHHf594Q32ZRji
	5TLIkeMnwTGfgZeUV954PIrTxwRQ55lg04lAVfB7/eZvW6R8NMQ1O28QuiyXrXRIQ/idoEjS
X-Google-Smtp-Source: AGHT+IE88d8D30TM7GGG/vcrMlLoJh4JGWtvsOx/tyrei8PlJOp6fj5m+NMYzo9KBJH9K+ApUA43/Q==
X-Received: by 2002:a17:903:1aaf:b0:215:86bf:7e46 with SMTP id d9443c01a7336-22c33adc407mr30475ad.7.1744750031580;
        Tue, 15 Apr 2025 13:47:11 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198d95sm9294269b3a.17.2025.04.15.13.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:47:11 -0700 (PDT)
Date: Tue, 15 Apr 2025 20:47:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z_7Fx-Q8baoyzJe2@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/19e4eyj1k/pqsh@Asurada-Nvidia>

On Mon, Apr 14, 2025 at 02:26:19PM -0700, Nicolin Chen wrote:
> On Mon, Apr 14, 2025 at 10:57:34AM -0700, Nicolin Chen wrote:
> > On Wed, Mar 19, 2025 at 12:42:52AM +0000, Pranjal Shrivastava wrote:
> > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > > +
> > > +	/* We might get the vcmdq */
> > > +	struct arm_smmu_cmdq_ent cmd = {
> > > +		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
> > > +			CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> > > +	};
> > > +
> > > +	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
> > > +	struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
> > > +
> > > +	/*
> > > +	 * Since suspend is invoked when all clients have been
> > > +	 * we don't expect more commands to be added to the cmdq.
> > > +	 * Thus, wait for all existing commands to complete.
> > > +	 */
> > > +	arm_smmu_cmdq_shared_lock(cmdq);
> > > +	arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> > > +	arm_smmu_cmdq_shared_unlock(cmdq);
> > 
> > Hmm, I just realized this: with an SMMU having multiple CMDQs
> > (currently with vCMDQs and potentially with ECMDQs), should we
> > make sure all cmdqs (not only the cmdq picked in this function
> > by the arm_smmu_get_cmdq call above) to be empty?
> > 
> > On a system with vCMDQs, there are currently one standard SMMU
> > CMDQ and two vCMDQs, i.e. totally 3 cmdqs that could be picked
> > in this context. Perhaps SMMU might need a list of cmdqs that
> > any new allocated cmdq must be added to, so we can iterate all
> > the cmdqs in the list?
> 
> Another tricky thing: if a vcmdq is assigned to a guest VM, it
> won't be added to the "list" above. Should we wait for them or
> simply rely on VMM sending a suspend signal to all its VMs?
> 

Hmm... I haven't looked at the vCMDQ series (of the vIOMMU) yet but I'm
assuming that's what we're talking about here?

I'm not sure if sending a signal to the VMM would help if we have some
stalled transactions? I guess we'll need to somehow figure out if
there's some PCI device assigned that's using that vIOMMU/vCMDQ ? 

Maybe we can smartly flush only the PCIe ATC inv and pri resp commands?

> Thanks
> Nicolin

Thanks
Praan
