Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95683CF02A
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860322; cv=none; b=Hl7Adet9TfKrEtrZHl9WjaElSyd1L+mm2PKS0HcVtosHCS/VFsD2oWiPdoO8n4VwmOhIgWmSXQRWJun0c1JzIx/45So9OepKqbMu2EwmSHAHMFGV+I4pOhbZf1jONYqwMZtvhsFfLmkkTbO47vzxkPFnb0CPDU02WrtN1U1AfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860322; c=relaxed/simple;
	bh=Vogt9C1+/ONaspDuD7hPvlF4i40Y1urMOX/pwlC2Src=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPYivtYE8FCduSlx6MytSmXwIoEIH7ZI3Drz0PDd7gji8ntSF7LdxQZ0Nwbi4jmbJ5GcAYRDe2U0hwMl9BnjyG9R5Sn3k9KkmQn/J7q1e3y/WCoa0CVy14C6cGhNBCJpcMD8macDM1gPcZ/U/oqxhOzXhU0QZZRIxWymvR9OHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpvP5Uat; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpvP5Uat"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso376995ad.0
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776860321; x=1777465121; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+lN1l/yP69hcxd0HbOb08WhvreEQZkA3IEMKn82zDc=;
        b=ZpvP5UatrWmaFsCjSxl+n3iSMmFp9HWXPuEz/AzFLWwGBoHtuN3OT5Qan2J6hx4z5S
         z6eou2qETEvtzJJDses1EKaL2yuFd9DlXjAAFI6B+i9IYIiQYy362sUDKIuwaPlalKis
         5Jnbh1QTOVes+istfwSVX+Z+fxyes/9AUtOJG9lBx2aWl4XSy/5DTKI0tbwSiwsuRHvw
         EY/ka1QpxEnEwsOxcBiYx4j3sm8p3FFfDz06q1OVbkIgmP8RrWUQOBhizs7BwvZVSBAo
         kJyxzWCG/AwcIBpVoGcm+QweJOzfikqzu5Cg5Gu6kbfusS7IFjWFnhbZsPmzYgyUqyN+
         qxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860321; x=1777465121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+lN1l/yP69hcxd0HbOb08WhvreEQZkA3IEMKn82zDc=;
        b=cAQLd094A7Mor1BTEUTrItNMYQ7Uqf0yWSCyY40Ht8S9eu3JtCoV2rUVbdcj6Tz52L
         d43Zv/o7JTtPNYlEdbzhP7SPD+k1FK4PVhQ2FqmnyerN2fT+5GvjzFEehFDqrE5YRaMD
         +WfhUEU++5DHbVcj+PJPBwnrNCNKBrZZ7EocSuje0b9SLCdyA/OoO4jgRYMTcs11em3h
         5W3dDSuQ/m7Gzse+IN6IoY9BwZW1Oj/rXRAMX3cvqhgqww5AtXThTrWtu4LL5fufDp7K
         m+4dcELv1kJoCXcZpOR7rl4lTMNsqISMylGAC2P2kY3kZZACLy9eE6uq4ps/eyoxWW2p
         Wndw==
X-Gm-Message-State: AOJu0YwioAYQByuGVve0HofchQnTQ3v5JhljYGbPh/nlJop1DNmDm5Ws
	fZnFJ05GDHnO+bdElrpJVbniXm7tdxq0f0XwQ4XZhVj0UNhCYq2pVBuM9NeXxb27wNq0KbP74Zx
	MxI5ehQ==
X-Gm-Gg: AeBDietGOM+jJhsCOV4m2TrZ27xEgbV+I8NyN/2b4p3gXpFbMmkVQiIO3NsbcBn3nxm
	DE+ARP7HwlTCKaI4op8ZUsuEgfJgxyS9Z+Q7bLxQwMB36usTru9N2RXgwJ1bf5tENoLcqN6VptU
	T3KJ41HBZmSWHbQfJW6H0szt/UwxoRGLdcexQVtMlSw6cNDZl8qHnn8oXlAUKtSJDTQNtYjBuFj
	tHBDylVKPrgwU8D1GpEVTDfZiXrzet77VsQx3jCSfF+8OgH4qD7gzUMr1u5cE+KQcUrmGGgYT2u
	HpsHaHIG3ov2SNdWQdaO9zzk+v4AWgeQN7i2ng0hDBswByypq2mnQyww0KhqxBnP+x/uYPONyPU
	zifR68bLcaGfIz6BHLY/uBdwqSB0RpR9GcKApPEQbHesnLLaraSBz710u0k8w0veXXn6YIoUWtK
	lOboY14ZkZuAqQxYj5Bi6qusvrAd6weZbMi4WqBQ6HlZFGz2gFuufPc/PocFuIEAVLnqcoRkmkT
	LGkoVc=
X-Received: by 2002:a17:903:2c0e:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b602f29c57mr2279115ad.2.1776860320355;
        Wed, 22 Apr 2026 05:18:40 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9819e5sm17794374b3a.2.2026.04.22.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:18:39 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:18:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 06/10] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <aei8mWFCtuzys_Ln@google.com>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-7-praan@google.com>
 <CAE2F3rBvy101mvfofmR3KibMcZ5gtM66b7c38PLcgkV5p4MQJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rBvy101mvfofmR3KibMcZ5gtM66b7c38PLcgkV5p4MQJA@mail.gmail.com>

On Tue, Apr 21, 2026 at 09:31:33PM -0700, Daniel Mentz wrote:
> On Tue, Apr 14, 2026 at 12:47 PM Pranjal Shrivastava <praan@google.com> wrote:
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -209,7 +209,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
> >  static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
> >  {
> >         u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
> > -       return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
> > +
> > +       return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
> 
> Is there a situation where we need to increment prod and retain the
> STOP flag? What happens if we leave this particular line as is?
> 

The CMDQ_PROD_STOP_FLAG must be preserved in queue_inc_prod_n() to
prevent it from being accidentally cleared during after being set.
This can happen in the following cases:

1. Point of Commitment Races: In arm_smmu_cmdq_issue_cmdlist(), a thread
   could pass the initial Q_STOP check and successfully cmpxchg (commit)
   its indices. If the suspend handler then sets the STOP_FLAG before the
   thread reaches the if (sync) block, the thread will subsequently call
   queue_inc_prod_n() to calculate indices for the sync command. If the
   flag is not sticky here, this call would overwrite the global state
   and inadvertently clear the STOP_FLAG, re-opening the queue for new
   submissions while the SMMU is trying to suspend.

2. GERROR: If a Gerror occurs during the suspend, the handler 
(arm_smmu_cmdq_skip_err) may increment the producer index to bypass a
faulty command. Since this handler could be asynchronous, we must ensure
that the STOP_FLAG is respoected. Preserving the flag ensures that we
don't accidentally clear the flag.


> >  }

Thanks,
Praan
