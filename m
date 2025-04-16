Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A01E0DD8
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792154; cv=none; b=AY6XNGpEyHiMTvqIoxrMcQSEdTgEXVM12JVevhHmWcTXDDpCCLsg86kShIS39oKHdaydyFjakL5/lB01kg8S/Bc8MSsO+TOdr4ovrTqqFvtLd3s+CD7kC7b74GlEZuALn8yhOznm3urIePH+Q3tpAu0d8fqMzLKZIXJ6ydaTwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792154; c=relaxed/simple;
	bh=sZhbCbvZvlg227EqHg2kRR7nB8SDWjo9NwPIXXOPb74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+D/oRC6HC6zqRg54/Sj5jLOHU2gpK7qvU/foeVwK/raEYbxwIwcCHjsI8fezF8OpvYTMA7S5n65amwDoD/fi4uncCcKtuWyuJPswQYp4ou7uqMNFVBoGxiIu9YRBGQGlthszhTYZ5dTMuaEaGUyIlJoc2WRy3fBisxtV2hLHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBUDOwzC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBUDOwzC"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so202435ad.0
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744792152; x=1745396952; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3v7rvA31hx7lLEZtM5zIPj6OA/kyCZxVfYGStg6bxr8=;
        b=YBUDOwzCznjgPlwLDhkwBHwnLBaUvrh1VKKBqZ/eCBFEoSN7tvXAm2vdponz8gGdlD
         CwE9fFllyPCa0K32CtGYYpkSMamWAzMO6hUj40RNZABWo0TmgRSixNOMhuljwNkUn6Q6
         qWgQqTE8zHX/suq2UZz8+jP9RXA4cHqm0Cd2uVFSsI0BaxBUwq+6Oq1j0a1bF236rcTP
         LIazOxoOGIq/hTMItBxJf9+cvbvouKI+IBtOJRka0QX0SMOnzOUNJjPnt5zCFx9RABV7
         xv73LYHhQ/XPhZJWVvsymjrPVVl6nOqMCStSPvVQRYe7x19KwLbmH5ZaC0YjYFzEiwaG
         k05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744792152; x=1745396952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v7rvA31hx7lLEZtM5zIPj6OA/kyCZxVfYGStg6bxr8=;
        b=l21UQrxTehdXp5GT0YKDJSXJ83m/uQstbyBVUGSMQIsrM2EDfVt1sHxpo/x7YY6xhI
         mJQeWXAmzzpagDGDRPE6Y56MFu5HemqxrglU9DYGskVAVZvVwlvJ5k0TChfEj6sKjhdR
         bDvx+71Y1hH7003ixivcsDtpQfWRjyPRsBR8A8uYwcIBX5zORO4R0+leGGwcOskz25rX
         FgODgfIBz2xMcO4iWSCU8K5jrg/Zi0/FnUyxPQP4Be8RhNBNnX1yBMw2GwRDr2oD2WSL
         zuZOPT5M0AlCKLk2Rek3/bzGJLeetxK3TIF/gSsj0tf2ORkRe2M2aGzOLwk+fhvMsEmK
         DRxw==
X-Forwarded-Encrypted: i=1; AJvYcCUkEMctknqsOn8JEs1pm/TCkL/GYst/5RET8kjLgl+hbdie3HhInGLRj2nIXtsQy4ficv4J1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0LZLwKEiAhwyU99uN4NW3bszzx9SYBjYEGO+Lo6uyy9yNqxRi
	NOw4DZRo1joImIxjUNO0v5bHo38gTWCy94oP0ijJ0FQYmiqx//3kA8R4nRrS9fCVHdD4y4Te+94
	Y6w==
X-Gm-Gg: ASbGncv5nUcxoMXQKBhfFSEwkEQ8VyzTEPhtcjxtlT8fRctkpktCs3rXCcnGDbBqOu5
	xb86EAbyQcrk5rzQHL66uZI2+vatt+V+dGmiaaNdvwAWUhHLogvY9JUjOW6YeleSrvrgT5QVzog
	WPZm3hMnu0s6p8izYxMh4mnxAtN7EHOR5hiKgHrFiqxya/khgEaj6Bvz5yHv0LT7Nc0GqODoeOU
	F6ww2rIMfqcddu8/Lu2LexWnT1NtowCcsy8d3k+FSAXdNc50Fary4I+rK+71M0USoNU9i5Jlit+
	EO7xyrQMZr4UQXkkoBliFhEzWuKnBJyGiyADN1k1bmwNF1vcc11hvf/qHIVVJ+Lifv8yIH1e
X-Google-Smtp-Source: AGHT+IGe2U45ZDNU/UiuKNibMsl+oCtDPzSsIhRtZlslataOMMSYJkIaXepKWOc5AJY9YsKJ8uMTMg==
X-Received: by 2002:a17:903:1ab0:b0:220:ce33:6385 with SMTP id d9443c01a7336-22c354b600fmr919595ad.9.1744792152321;
        Wed, 16 Apr 2025 01:29:12 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308612242fdsm971292a91.31.2025.04.16.01.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:29:11 -0700 (PDT)
Date: Wed, 16 Apr 2025 08:29:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z_9qUP5etMEq47Qf@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z_7DmadjRe3GaaN7@google.com>
 <Z/7aAF1maOPr2Z1J@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/7aAF1maOPr2Z1J@Asurada-Nvidia>

On Tue, Apr 15, 2025 at 03:13:20PM -0700, Nicolin Chen wrote:
> On Tue, Apr 15, 2025 at 08:37:45PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Apr 14, 2025 at 10:57:32AM -0700, Nicolin Chen wrote:
> > > On Wed, Mar 19, 2025 at 12:42:52AM +0000, Pranjal Shrivastava wrote:
> > > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > > > +{
> > > > +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > > > +
> > > > +	/* We might get the vcmdq */
> > > > +	struct arm_smmu_cmdq_ent cmd = {
> > > > +		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
> > > > +			CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> > > > +	};
> > > > +
> > > > +	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
> > > > +	struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
> > > > +
> > > > +	/*
> > > > +	 * Since suspend is invoked when all clients have been
> > > > +	 * we don't expect more commands to be added to the cmdq.
> > > > +	 * Thus, wait for all existing commands to complete.
> > > > +	 */
> > > > +	arm_smmu_cmdq_shared_lock(cmdq);
> > > > +	arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> > > > +	arm_smmu_cmdq_shared_unlock(cmdq);
> > > 
> > > Hmm, I just realized this: with an SMMU having multiple CMDQs
> > > (currently with vCMDQs and potentially with ECMDQs), should we
> > > make sure all cmdqs (not only the cmdq picked in this function
> > > by the arm_smmu_get_cmdq call above) to be empty?
> > > 
> > > On a system with vCMDQs, there are currently one standard SMMU
> > > CMDQ and two vCMDQs, i.e. totally 3 cmdqs that could be picked
> > > in this context. Perhaps SMMU might need a list of cmdqs that
> > > any new allocated cmdq must be added to, so we can iterate all
> > > the cmdqs in the list?
> > > 
> > 
> > Well.. I was thinking to only drain the cmdq if we have ats/pri enabled
> > because the only case where we'd wanna drain the cmdq is when:
> > 
> > 1. There's a pending ATC invalidation
> > 2. There's a pending CMD_RESUME / PRI_RESP
> > 
> > Since for any other invalidations, we'll clear the TLBs & config caches
> > on resume. Does the same hold true for the commands supported by
> > tegra-vcmdq?
> > 
> > Is there a spec I could read about tegra vCMDQ and the commands
> > supported by it?
> 
> I don't have a link on hand. But the concept is very simple.
> 
> Think of vCMDQs as additional CPU cores to CPU0. They will be
> able to execute the same ATC command as the main SMMU CMDQ.
> 
> But by doing arm_smmu_get_cmdq(), it would only get one of the
> CMDQs, which can be a vcmdq (out of several) or the SMMU CMDQ.
> And that specific CMDQ might not have a command pending, while
> one of the other vcmdqs or the SMMU CMDQ is executing commands.
> 

Ack. So, the commands are still the same it's just a diff queue.

> So, the point here is to iterate all the host-managed CMDQs to
> wait for all of their completions of ATC/RESUME/PRI or etc.
> 
> We can do a list of cmdqs, and add each to the list in the
> arm_smmu_init_one_queue(). Alternatively, we could add a new
> impl op to defer to the vcmdq driver for a proper waiting,
> if we do need to handle guest-owned cmdqs as well.
> 

Ack. I'd prefer adding a new impl op for the vcmdq driver to handle it

> Thanks
> Nicolin

Thanks,
Praan
