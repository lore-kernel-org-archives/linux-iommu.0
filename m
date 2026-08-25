Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006651FF7C8
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683124; cv=none; b=NfdTigxpfrQDQzRN6oZBzBopgpFnbA/K6Wt0zAS5UqemiRzklJJvytxP3YBBTL+RyiuOM8dE2zmApcxxMLwK4dgSEbW4FFXRauRCcnn4TSmmIrRBKb20dLAFznHDz3bx90lhSPk6nXQ2OcaF+ClyJpfl98h33Rw4ukjlG+nV1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683124; c=relaxed/simple;
	bh=GD1npOOyjQvxhGYc6rKPeAvQpElnkJZmgPQ59evE++k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hECtBXgB/9mGbxgvuXa8s6lYTPodVJUFAKL01tvsCwk0IfXJXZJqgHwKIX38DuN9JGrWL0tCV1esJhkXDJ6ohvoX281+9bBoxrogxuOAGd0IsAkUy0FTl0e1PcuitYVsLvbcWFIW8/EsAMV1eRPvxag6e+5OH+AIxZAiekgvPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxWVARro; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxWVARro"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cede6375caso20935ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683122; x=1788287922; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRzZo2BIrzS2/3EuB48709dCjGwV5yrxCu6+EuEuEXg=;
        b=JxWVARroqqIl+igP+6mW4wz8EK+PsFJNr9eKLMiP74nSpWpJMkAInyd5Vo7HITc0uE
         tWn5oWNF4sgbQga0v0ncNNIOgCd6pilb/6nlgB2FxAMExGbVFL1y1in0vOc4/qeU1mbR
         iwJXPtYkYaxF4WeDSYEMzXG16lki9F6cgBk5/eP5nP72hWSJV0WfT/NbfXpVwVvotkhT
         t99+YozeOj+W1t2dJZRoQA8owcMFLvQ+ulZ4iNDDeRTQustM4Ectl8HD8nLeNE4R/rhh
         xRxVr2PjHQr5TOkV5eeIHCJqnIjYk7FXii43tJuKM6Q82RCrZ821+iWR9WqmQ+lsbFdH
         Es6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683122; x=1788287922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRzZo2BIrzS2/3EuB48709dCjGwV5yrxCu6+EuEuEXg=;
        b=CLw8wd1/e5nFkTBQsrvbS9FCobr6m1R/q/jNT89625iocNb3IaMIifR0Z5os5INd6C
         NbK6orYuF+9xreoWeJGkAfgF4D5db76p0NO7nMy6muAdmS9zuFTwWRKPsGTARwuKB/4m
         DEm15rhZpWpCfyoTeUqQmyePWpNIUqMyVNBvcToErriAFJX7rI9LBnoQmgfPTWYiEJS+
         +qSmCEjJmEqEERecO7zqLdOlFvuQpjZILEDZNRHNBAsK4ehcpjpeIeK6tsMttm0HAb/L
         Q9PdRXonRAVOOpObcJvU1osSGuRcuoY3fbh4yPQM9MzmO63BjpAJwtzzSD6R6ZD8NWdX
         4VaA==
X-Gm-Message-State: AFuF++lyYlOfu6kvCrvHDkRsVR5rwMa0uMjNg459dURKZO/IO2am/RFL
	cZpAlTEBetuPwcObeYduznLZ3SDDnBfQu7pLMH464mHQu78kHw+0wrfoY47WKCBfog==
X-Gm-Gg: AR+sD13TGT3rNOw9+fMVkwIhrwN/bDeOPwf3GB9QhKljFx7EnPaiPGQPyzf3orcqO8D
	RJGECqFTqlAs/u3Ve+//mRAhdxnMCdpQ0FmnoLsSbeZKen8+SRrxJl/fRZU0+pVMnZZKfMf6bA3
	CKuO50LaQoApiZZ32GE6O+l4ZC903XofcO103d+uaIZ7jaB+Na1sUBqmCjTxmUjLZA7Um0fwODD
	NnFDerl4Ycc1EZy1BFeHdIwOCu3OhXUfFUThamd7MNBVWj0dGn4+aseeDf+vL7PCv3i1Hq+T9+q
	qpbaLPBIDicXl5o4oWmMeMx11vfGm6VX30XLXPy48Bt0sxsvfZSFHkJ5r3EePr0VC1XS7JjJymG
	ARAvO2+BD3/YIZoPcOwkroUx/kDAV5g8T8Q1pePaNYG7VeYRGHk465jryyEJT56UH+lOXcS2iRW
	JXGHd9uMplIUSl7zlV0vN4bnrG2+0j6LC9UyOhI1/VteBz9QW21r2hMbOt4R1ei2DSrFkSyiqhL
	Dpf/Nl9RbECPdOufq+f9l6vNw==
X-Received: by 2002:a17:903:440c:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2d6e077122amr9153765ad.8.1787683121595;
        Tue, 25 Aug 2026 11:38:41 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3967083e4b0sm26532a91.3.2026.08.25.11.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:38:41 -0700 (PDT)
Date: Tue, 25 Aug 2026 18:38:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <ao3hK8tdOPLvbpfK@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-8-praan@google.com>
 <178767577113.3356902.16348370784507904981.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178767577113.3356902.16348370784507904981.b4-review@b4>

On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > [ ... 52 lines skipped ... ]
> >  		while (!queue_has_space(&llq, n + sync)) {
> >  			local_irq_restore(flags);
> > +
> > +			/* Avoid waiting for space if the SMMU is suspending */
> > +			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
> > +				return 0;
> > +
> >  			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> >  				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> >  			local_irq_save(flags);
> 
>  [Severity: Critical]
>  Can this loop bypass the Q_STOP check if a suspend happens concurrently?
> 
>  If a thread enters the while loop because there's no space, and a concurrent
>  task sets the CMDQ_PROD_STOP_FLAG while space becomes available:
> 
>  1. arm_smmu_cmdq_poll_until_not_full() updates llq.val with the latest global
>     state, which now includes the newly set STOP_FLAG in llq.prod.
>  2. The loop condition !queue_has_space(&llq, n + sync) now evaluates to false,
>     causing the thread to exit the inner loop.
>  3. This bypasses the Q_STOP(READ_ONCE(cmdq->q.llq.prod)) check inside the
>     loop, as well as the Q_STOP(llq.prod) check at the top of the do-while loop.
> 
>  The thread would then successfully cmpxchg the new producer index with the
>  STOP_FLAG set.
> 
> Make sense to me, having arm_smmu_cmdq_poll_until_not_full() reload
> the llq and then not loop again from the top skips the Q_STOP
> flag.
> 

Right. I guess we should check the condition again after exiting the
loop or add the point of commitment to this space loop somehow. I'll
take care of this.

Thanks,
Praan
