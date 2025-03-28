Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFDA211A2C
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743148062; cv=none; b=BBT40Q4YPMsdbjYVZLpWDsR6TraW7IgPmv0hcokCPfoy5Rfwyre5JxX4wlKDLmUnTNY074GfZVXO5CYKrOPl5C2FZaPmARIHi224ISPACQb3p0yMqpNKlHVMr37vPNAe85JZf0qkAq9JxP41TxRE0i6YV5RXpzzdddpSBUi+utM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743148062; c=relaxed/simple;
	bh=9v0hH5NwmT9oYas02k0owd92IKkhiE6rpdCflKcozYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaL9SVgEZS/GTFc9D08TeGm65Er54urSTHYRhnUOxsXKhKoUXgZuTM83h37DMp/giFjA359F7CGqy3Rqos6JA7OJf1Ozo68x7zZuO4YYVEAC2tUIuwFS6xcPVXJF/SWnKJUbIM12ryGWwF7pgJxqn14DNGuD4OH2nfjzEuJYP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3szTfI1h; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3szTfI1h"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2263428c8baso99465ad.1
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743148060; x=1743752860; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kHKIz7A4BnuOL48o8lHb/rzI48O/1LbIV9cjiZZK/VE=;
        b=3szTfI1h9zC4hlUWOyxHvCjDPS/Dw2RpdZQ7eZkBTIyBSbV+sUAuLpSm2S75Jg0HOH
         46JwJCaBN5DFh2xBWxmP2aUjDec/I+WSaB9sjAq0+M/UNx72oUgk+GvGpq5IZCtQDQe1
         3veOHA3S2xiIGffQ1Ptamt0WxC8/eP1YmKxpZAeU6QPlZQhV4o6iQg+PDHd/YaLGkXBi
         8ksAETPfJUxx5Z8pbpj7mrI/UlO7nmgsftMJrOituCnC4x0hSaSUJjbL8SmmsSEJhb/X
         ak7N9gGWl5pFo5BPFSMm8E3FuaABgdmQk+AcKy/n2RIseJOpouKRNnUow6E1tecc3Okq
         nV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743148060; x=1743752860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHKIz7A4BnuOL48o8lHb/rzI48O/1LbIV9cjiZZK/VE=;
        b=ICrDgHs9DU5ti2XPsScXnJWhePDQG8ixUE0itMVS9jVQbuXIgQpUOiOXdnUfU5w0bt
         VhXYBQgcW7gXVBbEdVJoAhvJv1CB4zYZ/b/ZFSdYpk4CTIdoR8b1Qp19vSzqKxukHYeH
         900lciZjEWNcf3zHholqAZ68kEk9uEz8oCaWPdgdSm+mlBsXoCpsMe87yMjuAsnj5Sko
         g1KYe6mXGJH9roJTqxppLuFp2UANgdivnU9DBpw9HEPfYivOg1m90AQYz4Bv5stauYFX
         jdDpF17EslKfaPWum9bHhHQ5cyTbWQjt436v9c2z7NcH5UXnfED5qUDCZPIFyrW+SwmN
         FNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjTsqBvhAMny8foZ8dUw0ha7nc9TPE+kjtIgxbRYiUxJHSvmOvj1xC/rBpwbflU64PMuJjYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaaPNhJNtd/SDDA/fWW6F97nvcbE9GFMHWJ8nEeZ+krUqfuLv1
	opOoOQT1xwnFw8AlAQ6i406XGQU4a4kqjN6FNNcYvBT3PF983LLDEAzIOxShMQ==
X-Gm-Gg: ASbGncsKbma7Ig9BhtEDPy5Nmy/k0A09KIH5kY5ZH5w6v6WtuLF1RI6lZyHGgrRPl/v
	MJ5Xf1yRHQpg9aTU95vy9VK3RxTHh/ic3Zn1RTQY4vvOYL9/CXJG0TW587/LBs0TrU4zig2cYhA
	jMZIPFh3yiMVoyTRP+TYvZ6RQ93oQCUJE94CW+xpKyUmi2bVjwvRDVAU06WVohhb3w4kfm1T1/Z
	w0sjUBC6Zo1kvPdga3EiM2kFQiw1ALNbjDoIP59irfYcM1GFMVFxeyhmZCIHQrWutksoYgLQFe2
	YZAJ4EbpceHCon5mXVHmJN/2FA3TH9VxH4uWwDPFDEMRTfq9DtcmSMjZP+vAi+eQcveCTo82w1t
	vr1o=
X-Google-Smtp-Source: AGHT+IGzvSTEZagS+BShyK9RiIJ5nlOEtU88cPtrYltpLdylWTq2uiJ8M3xgaAulEE2DD9/yl2Hakw==
X-Received: by 2002:a17:902:d490:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-22920e25925mr2063995ad.20.1743148060008;
        Fri, 28 Mar 2025 00:47:40 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d62c57sm1162989a91.28.2025.03.28.00.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 00:47:39 -0700 (PDT)
Date: Fri, 28 Mar 2025 07:47:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z-ZUExCunYmHjDm3@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <CAE2F3rCdA=45317Z_+J86G2QtLZYZwDT-qPVD7ymmAfToBcwQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCdA=45317Z_+J86G2QtLZYZwDT-qPVD7ymmAfToBcwQA@mail.gmail.com>

On Tue, Mar 25, 2025 at 09:52:37PM -0700, Daniel Mentz wrote:
> On Tue, Mar 18, 2025 at 5:43 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +       /* We might get the vcmdq */
> > +       struct arm_smmu_cmdq_ent cmd = {
> > +               .opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
> > +                       CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> > +       };
> > +
> > +       struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
> > +       struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
> > +
> > +       /*
> > +        * Since suspend is invoked when all clients have been
> > +        * we don't expect more commands to be added to the cmdq.
> > +        * Thus, wait for all existing commands to complete.
> > +        */
> > +       arm_smmu_cmdq_shared_lock(cmdq);
> > +       arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> 
> llq is pointing to cmdq->q.llq which means that
> arm_smmu_cmdq_poll_until_empty will write to cmdq->q.llq.cons which I
> understand is not allowed unless you are holding the exclusive lock or
> are the only thread holding a shared lock.
> 
> How about the following:
> 
> 1. Call arm_smmu_cmdq_exclusive_trylock_irqsave(). If this fails,
> print an error message.
> 2. Call __arm_smmu_cmdq_poll_until_consumed on the current producer index.
> 3. Update cmdq->q.llq.cons
> 4. Call arm_smmu_cmdq_exclusive_unlock_irqrestore()
> 

As mentioned in the other thread, __arm_smmu_cmdq_poll_until_consumed
relies on `queue_consumed` which waits for the prod to cross cons idx.
We could potentially call poll_until_consumed on `prod - 1 but it feels`
hacky..relying on `queue_empty` should be better.

About locking, that is right, but I was assuming since we are in the
suspend callback here, no other client is operating the SMMU. Due to the
devlinks, I don't see a path that could be potentially racy here but if
we *somehow* fail to get the lock, I guess we should stop the suspend
along with logging the error message.

Do you see a case where we might not be the only owner of the cmdq while
suspending?

> 
> > +       arm_smmu_cmdq_shared_unlock(cmdq);
> > +
> > +       /* Disable all queues */
> > +       arm_smmu_device_disable(smmu);
> > +
> > +       /* Abort all transactions to avoid spurious bypass */
> > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > +
> > +       /* Free all MSIs (re-allocated on resume) */
> > +       arm_smmu_free_msis(dev);
> > +
> > +       dev_dbg(dev, "Suspending smmu\n");
> > +       return 0;
> > +}

Thanks,
Praan
