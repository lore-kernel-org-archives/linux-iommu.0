Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265823F39D0
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000022; cv=none; b=MSfbc3DzL0driS4nVxwHGqkKyZCY5HDoOFNXk3/kWjeoie/QdjgNKpyVapRF66xIl34XIS664wUaGjf27a65t7jn4FtfwogPOn1xTkmTUa6KxD5kA/zop01WvujA7sivkDZ72iVoEYLI1wLrYc8oCgczWTwd/KJsVJ9uu+qeeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000022; c=relaxed/simple;
	bh=9JS8X2aW3TOl2Pr6+7UYORlorB4zSiNZEsxYdERRWBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgLz+Wn5GPs5BQ6/vfQqr1uNVUPIqWQB1HYrQM7tq9IH32EJXwr2a04PKhkHYao8HrH+NQZp7d/0hDDgs8k6wd1U8y88q0ATWzISessuVAxZh3q19pnIo4r+mcCBLH2S98tFKjPLoV9nKnJMd2tVwOuKKy5qHJ1OL3tJEoWNUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVRb01tt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVRb01tt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf22c18ad3so501765ad.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781000020; x=1781604820; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ecA2GfucrdEO7oCnTDy8y1OegEJt3xWexov+P1SIqLY=;
        b=kVRb01tt39a2AzyQIoa6uC9r/Mw6duroQ2Ezkcp8lI1869UI5q36RDj+gsq1/zOq0F
         591CmcIMttnA98vQHWv8lVIyzvufuM7oyw2xh8fDXsg0Zpyv0qOuRMD5g/ayRMt2bMQz
         pO6lZqdPXocAzlTugyyCTZ3oZaQMuMcnIT0tg4i4euodkDJ4+BqwvZIyH8XnTJ5DY5qd
         W2YM2FzXFaWtdDY1PIiXi54/QITCaqBSRkfW692CaYdFGWIwkTclapDHkjb4pkj+tEqZ
         8C8radDxLbRvgxygeFI7rLnGu+lP/bFg+bT0mM9AtEE+MFGIobKHZOMr9jptqpunmCwb
         ka2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000020; x=1781604820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecA2GfucrdEO7oCnTDy8y1OegEJt3xWexov+P1SIqLY=;
        b=SNjbZmpFbugu7v+xBKTVeI8LYJugqAafcFVdYExePhZWvexMJEBCLMjFyourYOkXuM
         q7XMIbnDoUGeLUJPpDnbt9C0Y3ozD3ANyFkd8V5+96IK7AOdaRJfcwyZaf4HTUjilFlc
         FgnE6x6XpGxlBUHgLd6snEFnTutk5Q8kM9b01PT5GDL3WrWB3nh4C+U8CQAmFgswmUdt
         ZxP5lJBEqnvz9zDemQKa0BLglZv3GPb317Wk5xFVC5H9GPE1Tpa4LbxYFsJILxIBo1CX
         lpvFoKHTXQ8xA163AhAyoDGGbHJ065G6ul8X6Ekua/OQ6M2xYo2HC6f4uuYCzGrAfYok
         P8Dw==
X-Gm-Message-State: AOJu0YxgdUJNb5TuGJcu0j3bTI6KjWkKeoqiDRoL0IoO+IaqhiQ18rIp
	J4wkdeVcF6LLHCRVJs/yQlNLDjpG3rNiR5kaJK2/MhHbJuXA5Wr+qWOL0F7srIwo6A==
X-Gm-Gg: Acq92OH4cSFIPaY2VldCACk5RyWiTomi3c3CR8AAvh//DBj9JV7XQNBGlKoNHfAY940
	EdL615LOBKBFxnaMoWYy14nB2Yqt6TrocPUcJnDhW8/cYko5z/PKCIbUpA98A53RxtVA+1KHAUc
	79reUcJLAELaoUwR0igNJVEn5lufOxZEH5IhcxSVc7RkYqm4SAcdKjcxWagTEBcSpOJ8k4LHARZ
	tBmuLQSa/GVb+xJoXn8uIwQ5j82ZIUlQHE6e2tq//q2uu5fVrJ4x4BvaX7LY7tA+easWhDS1QZP
	467APJXfZMHF/VDT5IEhpzx9cgqbPsNujHR6qyEEAFulNNpjd/jY1Dw6P8Tbbxt9Zt+Pii0mmsk
	tEMaFN7OzjjJAEdFnlh8kYTTCAWfUb2Grq3P1SZuVlKdAG9hK6or5GAW2M1bKYA9eLF4xWiV9DU
	f1o/uVIqAYQZBOnYfQt/sZPzl2PUizzvvF0PbjjrKx7fXzwLmiFN4qMuj34S4yix7Cufw9Q2A=
X-Received: by 2002:a17:903:b50:b0:2c1:ee6e:4e4b with SMTP id d9443c01a7336-2c1ee6e51f3mr7246875ad.28.1781000020037;
        Tue, 09 Jun 2026 03:13:40 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821c5sm19457245b3a.32.2026.06.09.03.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:13:39 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:13:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <aifnTR_GAoZ76Yja@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-10-praan@google.com>
 <CAE2F3rCTHZOiSx5tTVmLmubJ4SUDtXvCX6oLqsdEsPAFTKJZ4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCTHZOiSx5tTVmLmubJ4SUDtXvCX6oLqsdEsPAFTKJZ4A@mail.gmail.com>

On Tue, Jun 02, 2026 at 08:27:22AM -0700, Daniel Mentz wrote:
> On Mon, Jun 1, 2026 at 2:59 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +static inline u32 arm_smmu_cmdq_owner_prod_idx(struct arm_smmu_cmdq *cmdq)
> > +{
> > +       return atomic_read(&cmdq->owner_prod) & CMDQ_PROD_IDX_MASK;
> 
> Is this masking necessary? Can't we just use
> atomic_read(&cmdq->owner_prod) as is? The only place in
> arm_smmu_cmdq_issue_cmdlist() that writes to cmdq->owner_prod already
> applied CMDQ_PROD_IDX_MASK.

Ack. I'll drop the masking.

> 
> > +}
> > +
> 
> > @@ -4839,6 +4876,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >                 return ret;
> >         }
> >
> > +       /* Clear any flags from the previous life */
> > +       atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.owner_prod);
> 
> Same. I believe CMDQ_PROD_STOP_FLAG will never be set in
> smmu->cmdq.owner_prod. Hence, clearing it shouldn't be necessary.

Ack. I'll drop this.

> 
> > +       atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.q.llq.atomic.prod);
> > +
> >         /* Invalidate any cached configuration */
> >         arm_smmu_cmdq_issue_cmd_with_sync(smmu, arm_smmu_make_cmd_cfgi_all());
> >
> > @@ -4898,6 +4939,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)

Thanks,
Praan
