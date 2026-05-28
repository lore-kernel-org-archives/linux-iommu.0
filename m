Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2306347C6
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003291; cv=none; b=cGS7dsQi0EjB+20/E3U+5LrdfRRwPkrle3DM/8VYgAioNgnzrueQkXV+QIR8bC+63caW5hCA1lvMSeDY7adnqAoy9uqgi76nSrG6tnqTzAO/Vyi1vOtle2dcdOofCby/qu+1ZQ9hM+K5W4UDZBwnmzL3F/3qs9Y3Zg6ph98Aqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003291; c=relaxed/simple;
	bh=qbDTkrn3RFEa2mNw2sX837jEWg9zlEt+Qtb+Bdpe0FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUv6WSbyWi1CGoyvlxjP4FCOjjGJYDdekbqrPiH2q4W3RktDvdwPMIkEf46/BHSiU6aVLKwBeMi4itLjDBcQT4DXUSFUVCcUuVVtb4fd5Rfab87WYlbgCduwNi9DRx9iQ4Xso93MU+vEqPGnlfsuCYmPaqv7dGLW4rb8xi4Jiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/FAT259; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/FAT259"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba180a022dso1385ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780003289; x=1780608089; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C15T9rUB0bBkSab054WlEa7OUctxw0eLHuncdw99Sw4=;
        b=u/FAT259bguSAnns4onFgxkSIMwxpTaqUwMSE5ZzeKt4U4tjUY7hRV5GIdSZuA6cGt
         e3cHH47YZIi4VNb3a+x6wpLch0e+IMgnKYIDqtb/9kwEXYO92/eM6gOUWjUMbj41oLIg
         Exy96CYkzCjh/nGba4h8ROSVp0yEEzufN+1unEMQfyHV0d4WLXrDJlgNSKJqWK3/Bxic
         p8E9P3PfXdXMwFUUZGiK5NBG0Y9+aJhhhi7S9nFOdniMqXHemWbkU3BgPrHwl1ZTBqN3
         9Is9Tdr9hvc3xZbnHgQjOc8+Wd7cV0DVnB3lNNy8clQUQVGdlOuZcLMtC6tle77Z2/Md
         iZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003289; x=1780608089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C15T9rUB0bBkSab054WlEa7OUctxw0eLHuncdw99Sw4=;
        b=bqwQuGzZhDLNVyxo9mjSNyB947fyZOCICAq28qog5rhMAOoIUaJbxG6ZsIhoaeKdff
         iEg90hrtZlCppIsTqtVQER1F5fHFtp9X0bzib33QCJUvv3KHb12g519by5DNkcRVpEfo
         cyJh4jc7XgGQ5OKRlLhUdnqYT37tt1VekSgOLcyFFuf24iwZ27HHIWvJw69tWeaMif0d
         DFnVeJDJVJZaV2zADHF6pEVO3xLMpigRxmiYv/rpirfqKPr3HzKUI522PqoESm19aySk
         Qlusc2z2Rkh1b3KE9Y4QBhINyCNrU3IYBmqwaOt6Iyh2v7ifWmN03hod411RB1cnKGva
         UcBA==
X-Gm-Message-State: AOJu0YwnLXGQQLTYfj8+D06/CJt1ZBEZn1JDL+pti3Vw7qMdpcVGry2S
	rJqqaMyKvTvDVhIGO0Ufiy5RHdaFKBhiKJfTouggPUWDU795ru3b+0DLwXPouB3zhQ==
X-Gm-Gg: Acq92OGAeRLiNMk4dpxZT+UV8nmM/9Q6U7fuP0svfZo9Uf9/0i3gkwUAWsB/tFD2im4
	cqkK9ogaJx7HdPMSEdGvQSUvQWAeltVPPzwnylX9UuAQuZZWjs4SqJLpUfCPRSgJHTM92JFBeF3
	LtDBfszqtVHwV8qqf/V7TlsLPk2k21E+06oqwCIt36fzV/inufXU6gLU3KH7mDjZc6f1YI/UTej
	IJ6Br9xPrQ1x+8/pwMaWCpSXAF7wcgeLSFSp/uJNFWtCqXrsHyyqSu2HOe0ynjeVy0mMEKS67BL
	GtiVB2xK/9MJ7EPT9h36B41xVgIU1SHSYFJM6q/1Iqru0DYB5LeqSHNwOHCn0+oHFDf5YKG2sCZ
	8pQyH0ciHxqAAEfSsSlkJHfCcJK0PetuP9DCQebVofGACM6AlgLjKhyTulZpDQiqJGHqCSEnWs2
	/YCz8n+Z6g2vm5JKYnrk2UwY2k3D4crkBAfc7WK5yQFu0N49KO63UkYs3ZCC6zq6jeb3TX
X-Received: by 2002:a17:902:db02:b0:2bf:1153:54a0 with SMTP id d9443c01a7336-2bf20d4f08dmr142715ad.23.1780003288783;
        Thu, 28 May 2026 14:21:28 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e7e3d93sm2247895ad.39.2026.05.28.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:21:28 -0700 (PDT)
Date: Thu, 28 May 2026 21:21:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 08/11] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ahix0vUm03lxDwAC@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-9-praan@google.com>
 <ahiaApzK1/nBwr2R@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahiaApzK1/nBwr2R@Asurada-Nvidia>

On Thu, May 28, 2026 at 12:39:46PM -0700, Nicolin Chen wrote:
> On Wed, May 27, 2026 at 10:14:04PM +0000, Pranjal Shrivastava wrote:
> > +/* Runtime PM helpers */
> > +__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> > +{
> > +	int ret;
> > +
> > +	if (pm_runtime_enabled(smmu->dev)) {
> > +		ret = pm_runtime_resume_and_get(smmu->dev);
> > +		if (ret < 0) {
> > +			dev_err(smmu->dev, "failed to resume device: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> 
> Nit: ret is used within the first if.
> 
> Yet, I wouldn't like it to move. So, maybe do an early return:
> 
> 	if (!pm_runtime_enabled(smmu->dev))
> 		return 0;
> 

Ack. I'll add an early return.

> > +__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> > +{
> > +	int ret;
> > +
> > +	if (pm_runtime_enabled(smmu->dev)) {
> > +		ret = pm_runtime_put_autosuspend(smmu->dev);
> > +		if (ret < 0)
> > +			dev_err(smmu->dev, "failed to suspend device: %d\n", ret);
> > +	}
> > +}
> 
> Ditto
> 

Same here.

> > +
> > +static inline u32 arm_smmu_cmdq_owner_prod_idx(struct arm_smmu_cmdq *cmdq)
> > +{
> > +	return atomic_read(&cmdq->owner_prod) & CMDQ_PROD_IDX_MASK;
> > +}
> > +
> >  static void parse_driver_options(struct arm_smmu_device *smmu)
> >  {
> >  	int i = 0;
> > @@ -789,7 +822,8 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >  		/* b. Stop gathering work by clearing the owned flag */
> >  		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
> >  						   &cmdq->q.llq.atomic.prod);
> > -		prod &= ~CMDQ_PROD_OWNED_FLAG;
> > +		/* Strip all metadata flags */
> > +		prod &= CMDQ_PROD_IDX_MASK;
> 
> Should its prior atomic_fetch_andnot_relaxed() call do something
> about the CMDQ_PROD_STOP_FLAG as well?

Umm.. No, the atomic_fetch_andnot_relaxed() call must leave the STOP_FLAG.
This block is the owner-publish phase, which occurs *after* the Point of
Commitment. If a submission successfully reserved its indices before the
gate closed, it shall be allowed to finish.

If the owner thread cleared the STOP_FLAG here in the global memory, it
would prematurely re-open the gate, allowing new racing submissions to 
leak in during the suspend sequence. 

The algorithm works mainly because the RPM callbacks are the only ones
that are allowed to manipulate this flag.

> 
> > +/*
> > + * Lockless pre-check to elide invalidations if SMMU is suspended.
> > + * Races with concurrent suspend are benign: the cmpxchg loop in
> > + * arm_smmu_cmdq_issue_cmdlist() acts as the true commit point.
> > + * If we lose the race, that loop observes Q_STOP == 1 and safely
> > + * drops the command. If we win, the suspend thread waits for us.
> > + */
> > +static inline bool arm_smmu_can_elide(struct arm_smmu_device *smmu)
> > +{
> > +	return !!Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
> > +}
> 
> arm_smmu_cmdq_can_elide()

Nice name! I'll update it.

> 
> Should it handle a secondary_cmdq?

No, I don't think we need to check secondary queues here. The STOP_FLAG
being set on the primary CMDQ during the suspend should suffice to 
indicate the entire SMMU's power state. That's why the function takes in
the smmu ptr and not the cmdq.

Altough, thanks for discussing this, I noticed that while rebasing I
missed the elision check at one place: arm_smmu_write_ste()
I'll take add a check in that too in the next version.

Did you have another scenario / use-case in mind where this might not
work?

Thanks,
Praan
