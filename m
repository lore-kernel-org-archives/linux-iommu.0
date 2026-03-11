Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B53361DAC
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237205; cv=none; b=Ln4sMCdXdM+MizBBN/rwOac0uJVE3jBhYZCO0wJRYj3LbPV3/TeL42mVrcBaFDnSWw7tEGLXU32pNU4MX35ZxjTfuqnSuIyZ64GTzWUHO/q9qxm552X4BdpSGsskabkV5tjgZa5hP1yawtddcPDZuCBVyE+CdxpZJ7NoIWsCB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237205; c=relaxed/simple;
	bh=972Jjp5pe7EjrLQmwXiQxCdoZv0lrOo/tMe/uMODjkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMjqNJDDNSjtqjpO0ySniAUjkpShgIffOWxuhoz0pEo5iF8lbxmAfZkf8zpAi6KQSY7qScxEW/4c840aVUlx0VRdhysTtAdGXknDvhtt+XAie2CniJY+Zg7x9sx7hytB8NK8E/AubmpPtkPvkZ3MuckfXJ/onW/3nfihQyZoLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJBtgQW+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJBtgQW+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aea4ebb048so85445ad.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773237199; x=1773841999; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8lbYt/7UbIoe72vhjF18Z/QB9rMr9w8eD6xG/b62Kds=;
        b=MJBtgQW+CPGgXm7f9344n+IHPbMFrbr1buv++ZcSSIWKdMilnQC8zjxcS5SnUKHIQ2
         51Jc2zL3Ga+MEpuELp1ssL2rvcH7Z6bJ9YkIobv03iHBnDGo0k6rwIm/9V+HteDiCuXA
         zQcxwOztzmR9/uWJyy/9qq9XAi6ORReqSGk3jWFe1kJYPGZ7qjpYcAy0RzUT29Kwe339
         C/qSc6FW/LHJi0nV+4dmx4NVMtywGLk4iUBderXef53XwkrO7xvKElHnd9q5Mqv8yi/+
         tVwOG2opxoCtFpecxB4D2zD96lgOoiLerGj7sCO57SDKjg7qEMVmutXUYIJQ1ON2/NwK
         mGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237199; x=1773841999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lbYt/7UbIoe72vhjF18Z/QB9rMr9w8eD6xG/b62Kds=;
        b=GGcZZp6TYt0CPJyuwmzY6f6QYKkeUUgx7wr+Mhk05amDd2QLZsoxJRhkQ0evKGEkfP
         dp2ouPuoB8r5ChzGefXzSdMv0heiCgd9jcCZdY+E4xwi23Eujae9VCFbNu45CX6Jgq79
         xgSEeCnFUoJnc+waG0+AO1Hoe/76ynlA+SY6UjjNtGk5gejueVWgbCquLUZi01xzDhLo
         sycb0ab83JxMYe18eIoNe0NTi7QlE9igv3ibhvL0YqlDz8jqFKUhDoW8mdoKpbz3M+bz
         Pw6V8UklffKMg3WUz3vTgvA+37KZab8TkTXT/HzXGViy3lw2vZKHes1qLA8keFXRhZ03
         TaTw==
X-Gm-Message-State: AOJu0YyW0gB4rFPvhWu3kFz3+7axELb5hysGZ1ub3OutWnh+rc4EAwt5
	QsGHNPhxSpx/7KF3xVKkqtDpXq6yai4UR+smqKDVpIlzdOHkKU7gF2EWeNi3uKtEiw==
X-Gm-Gg: ATEYQzz6gNelGCnOu0/+szFBE6xdg5DOO9UhJEJ9QD5JNq2q24lf43QYvdNC2GYwwzV
	oSq6WCf/0SgKpElzcmRIVHM+k6IziFABO256hRmtDuF/xqYSecb7KzyAA3i5BpiL3mgYSCrTmiL
	ii2HfMjNSDA8m7Y96fiT9EJTGUgptUslACTEljCSwez+/lfzMhbQExALGmwYQxCIzSWSaBeVE2g
	qH2N/fEdhL3lbWkfpkAyOMHLkBCzCdiOGglg/wDYPQu5PTRRJ3NCQ3CbDG8oNuDgC3jCA9W9Q2B
	nAvSTpgcIlXTl4s+R/ohrTIvHbbdYv2cEhA/z5BKD+OYSM08VW2ZeNobtlWarDY5DgDOYLbUp99
	wgmmC8NE60wZqcB9b6mfyI0YIiPSAhMi62L0xfzwZPcOLuyM4mn0mMMl2Ym1vmJFYmJgSMERZZj
	F+6RM402w9YFKIFk9kPS86ZdpXgagQB6nDPYuFkOjz/b3AMbQByJRLyGnT0A==
X-Received: by 2002:a17:902:f786:b0:271:9873:80d9 with SMTP id d9443c01a7336-2aeae7ce28fmr2008195ad.7.1773237198789;
        Wed, 11 Mar 2026 06:53:18 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf0e4bcsm2176853a12.6.2026.03.11.06.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:53:17 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:53:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
Message-ID: <abFzyWG-ASb1Nv4J@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
 <aa8jkLD0l2WqMnyG@google.com>
 <CAE2F3rBFRSTC7bFCYTCit1-OKrT3jB-fwYGu_UJbwX+7aE65eA@mail.gmail.com>
 <abBMy5MgrrOlofDF@google.com>
 <CAE2F3rA_uyYGx2PCHMpFPWD6B4_2WxK-ahpoRHioXfuNf5Mpxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rA_uyYGx2PCHMpFPWD6B4_2WxK-ahpoRHioXfuNf5Mpxw@mail.gmail.com>

On Tue, Mar 10, 2026 at 09:43:05PM -0700, Daniel Mentz wrote:
> Hi Pranjal,
> 
> I have thought about this further and would like to propose an
> alternative design.
> 
> A key difference in this design is that no commands are written to the
> command queue, and the producer index is not updated while the SMMU is
> suspended.
> 
> Similar to the existing CMDQ_PROD_OWNED_FLAG, we could define a new
> flag, CMDQ_PROD_STOP_FLAG, stored in cmdq->q.llq.prod.
> 
> In arm_smmu_cmdq_issue_cmdlist():
> Perform "old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);".
> If CMDQ_PROD_STOP_FLAG is set in the variable named old, return from
> arm_smmu_cmdq_issue_cmdlist() immediately.
> 
> In the Suspend handler:
> 
> 1. Clear SMMU_CR0.SMMUEN.
> 2. Set CMDQ_PROD_STOP_FLAG in cmdq->q.llq.prod.
> 3. Wait until CMDQ_PROD_OWNED_FLAG is cleared from cmdq->q.llq.prod.
> 4. Wait until cmdq->owner_prod matches cmdq->q.llq.prod (excluding the
> CMDQ_PROD_STOP_FLAG).
> 5. Wait until cmdq->lock is 0.
> 6. Clear SMMU_CR0.
> 
> In the Resume handler:
> Follow the same logic as your patch, but clear CMDQ_PROD_STOP_FLAG in
> cmdq->q.llq.prod instead of setting nr_cmdq_users to 1.
> 
> One benefit of this proposal is that it avoids adding a new atomic
> variable that multiple CPU threads might compete for. Instead, we
> reuse existing atomic operations, which should reduce the performance
> impact for server use cases where many CPU threads compete for command
> queue access.
> 

I like the idea/direction! Although, there could be a few (solvable)
challenges, for example:

1. Abandoned Command Batch
  In the SMMUv3 driver, cmdq->q.llq.val is the shared global state in 
  RAM. The cmpxchg is the "Point of Commitment." Consider the following
  sequence of events:

   a. Assume STOP_FLAG is already set. Global prod is 10 | STOP_FLAG.
   b. CPU-A calls issue_cmdlist. It reads the global state: 
      llq.val = 10 | STOP_FLAG.
   c. CPU-A calculates its new target: 
   	head.prod = 14 | STOP_FLAG | OWNED_FLAG.
   d. CPU-A executes: old = cmpxchg(&cmdq->q.llq.val, llq.val, head.val)
      The swap succeeds because the global state was exactly llq.val.
      Global prod is now 14. We have just told the entire system that 
      there are 14 commands.
   e. CPU-A now checks the old variable. It sees STOP_FLAG is set and
      returns immediately.

CPU-A has "reserved" the indices 10, 11, 12, and 13 in the global
producer pointer, but it never wrote the commands to those memory slots.
Indices 10–13 now contain garbage/stale data. When the SMMU resumes and
processes up to index 14, it will execute that garbage cmd leading to a 
fault (CERROR_ILL).

2. The OWNED_FLAG Deadlock

   a. The CPU who finds OWNED_FLAG is 0 in the cmpxchg becomes the owner
      Its job is to gather all concurrent work and update the hardware.
   b. Any subsequent CPUs that find OWNED_FLAG is 1 in the cmpxchg. They
      write their commands to RAM and then just wait. They rely on the
      Owner to "kick" the HW for them & to clear the flag for the next 
      batch.

  The Deadlock Scenario:
   a. Suspend Handler: Sets the STOP_FLAG in the global cmdq->q.llq.val.
   b. CPU-A (The Owner): Executes cmpxchg. It moves the global prod from
      10 to 14. Because it was the first in this batch, it does not set
      the OWNED_FLAG.
   c. CPU-B (The Follower): Executes cmpxchg. It moves the global prod
      from 14 to 18. Because it is joining CPU-A's batch, its cmpxchg 
      sets the OWNED_FLAG in the global state.
   d. Now, CPU-A checks the old value, sees STOP_FLAG, and returns.
      CPU-B checks the old value, sees STOP_FLAG, and returns.
   e. The Consequence: The global state cmdq->q.llq.prod now has the 
      OWNED_FLAG set.
   f. Suspend Handler: Calls Wait until CMDQ_PROD_OWNED_FLAG is cleared
   g. Since the Owner (CPU-A) should clear that flag (it does so at the
      very end of the function). The Suspend Handler will spin on this
      flag forever.

This can be solved by checking the flag before setting the OWNED_FLAG.

While the atomic counter (nr_cmdq_users) used in v5 adds an tomic, I
believe that it provides a cleaner "gate" that prevents CPUs from ever
entering the "Commitment" phase once a suspend is imminent (with fixes).

However, I agree that the atomic cntr can cause pref drops on servers.

I'm okay to adopt Daniel's direction (it only impacts 2 patches) & post
a v6. However, given we've been working through this for a year now, I'd
want to make sure we have a solid consensus on the design from everyone.
I felt with v4 that we have consensus on the design but it still seems
to be evolving. I’m ready to post v6 once we settle on the path forward.

Thanks,
Praan
