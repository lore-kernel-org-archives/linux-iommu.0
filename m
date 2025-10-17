Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D132AAA1
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699072; cv=none; b=lOZanZ5+LgoGwX42F886VZiowMLZmiDi39vZjqcnCqFU+1HsV9E4D8MJu912LnF4CPc6A3Jn6MId+worYGnBV5767GV6d6tVlLh+46NgKauQZywaZMpWC4E2wgPmz7PxPn+lYFVMpYmPCtt35KR9+ONOrMfl/hkJ05Tqr54LMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699072; c=relaxed/simple;
	bh=CT6Prt+NTbShjQ+f1cmrLR9yqKjs5BUvYa3rp5OHzHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rubwrUfvWCjG1ufv3ULywSsn4WlxDwwP0hIuUpsA8+uVUj8Krw5nDH8dPzh8Ok390p3ouZLdANgCBkkmujKaTazoC4dr/jnWNaarNdoGPxJZEqcOs/f26Fnx8bgXW1uB0cQ95WInlL5gloknAhhN3/BQ2aQWxTwthSVo256NVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=231E+Eap; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="231E+Eap"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471005e2ba9so48745e9.1
        for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760699068; x=1761303868; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0RmTEF1AegUAZ9BdlOfpY9MgQhp1m+IVPxka61nbq4=;
        b=231E+Eapq3g3yRwnJKQD9jfH4rFHrU3F3vOamEfqxgTxFPb2ivA/Qyo4zAbGPuVgUR
         3SbCn4QIIMe035pnbJjUjZqpZI7TpVe4FPv44xi8dvBrqiO/7r5auC+LOFFfApiVvzDa
         h49qxLMChsXMXVQVUSq1YTCf1nIEPr00hLNFk7mlsNH22xmmiF0xHB4/KShn7LbYOWbc
         84sjRZ8PQVPGDvST4t/ynVEJRPIYj7NafF+0eRpL0nnQRJuEuJIVyOes39IluBwderhP
         a0Hk1IrevTsas7b2GvhZHqyjcDxTcf7d9XgXr+osdBg4i3CkTa1QEgIKRExMUE9I2rvE
         4x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760699068; x=1761303868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0RmTEF1AegUAZ9BdlOfpY9MgQhp1m+IVPxka61nbq4=;
        b=axZ/Cz6faT+7Wg2eW21c5WFvuLT/JMlX9mFb189kmZeU53dGcczXFOGr7kwBLW/NOx
         Om/bxQpUXTHW8Vq6t+EG4LlLf5MV69OZnJKEiwUP6oVLNr1SSgOGVEZ1I/DjluS+9+65
         UgezQtZ8GS4EqqJJ3SmJ8PqGDkeBKZoh9XxS/F59UlPX3oTIebavOjmGCSGXl1aoBtJH
         w6YQqGvUdAxc015C5S9fO3E84S4x9vj//z7PyFkSaqb4KV43hRzlkuyuejm/nXN62xZh
         9532DRoqLqMCW/3WjB4rFWSj6sfkjxYUuMg57J5ckWyuv6auH3bCT1htzAlkRkeeGaVl
         hh4A==
X-Forwarded-Encrypted: i=1; AJvYcCVLh/qQqIVbPMFSDnhdZ6hai+MSzU/D3fb4HblXg0ndX/Ca+ucdS+5I0wqhqbTw7QHgf4g+RQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOkumY/nNjME+/7UFZDwuNtW8R4B8VvdhuqCxj6rn5y6UFxS41
	R2brk/n892oMdcTnCd6TuEM8/FFo63yvuUeb2hXAdkfx+6bhXUjPmT/8Uu1luEq8fw==
X-Gm-Gg: ASbGncvAGvyFW0Mra4f64o5fnZQHyOztMrWZIjhX+S0mXVkbeyWWcuaaQJ10tmjlASv
	vsZ1Nbe/aDRXnZPIx/e8rxImyogMWQsy2vIHuIDt4yNW2ap1AJlgMr3RdrarHoG0aLVPaYCKEly
	8NBHCgCNUljXj3sR6H8o39vQt3mI+PzLHnj/z+Lcb0qPAxOMbvJ7Gp32IflXtJfrNvlMq4FHEII
	TdfMDaLSYXQAEtKcXkkeTMBuT7XsjYpJtb1+y0tW5ut+3kLyoxaglxSGL/hSyxYQ9f/A5RtULK1
	hFgYodQkzUc6mVWkMNCOzHlQj5pRxqFWEUoTf+2w3ID6qJPgfDZccHtrPjEO0zrECOvlLttaVg0
	OkvW4yPq9rJgUzpvJRN6YaYCH9+uF4yeO82RXb9tlU3GUXrXFL3yx/dQ6+J/ZcdV740Q1Sm3RJY
	eD/5VJTNrFNWBFsTeT/MKihigSQPZ7zdhHkIuhxpxBVSa1Rekw
X-Google-Smtp-Source: AGHT+IE0OUIwlzr2sGs94SA/iu2w+G64ceoEFGzIwviFyFJA2e+cIf3qdIvn6JFYFL+5RiY4Zfv27w==
X-Received: by 2002:a05:600c:a30b:b0:45f:2949:7aa9 with SMTP id 5b1f17b1804b1-470fd88e8fbmr5639675e9.6.1760699067978;
        Fri, 17 Oct 2025 04:04:27 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm77014225e9.14.2025.10.17.04.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:04:27 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:04:24 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and
 efficiency
Message-ID: <aPIiuLj9c4IJlmIn@google.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <20250924175438.7450-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924175438.7450-3-jacob.pan@linux.microsoft.com>

On Wed, Sep 24, 2025 at 10:54:38AM -0700, Jacob Pan wrote:
> From: Alexander Grest <Alexander.Grest@microsoft.com>
> 
> The SMMU CMDQ lock is highly contentious when there are multiple CPUs
> issuing commands on an architecture with small queue sizes e.g 256
> entries.
> 
> The lock has the following states:
>  - 0:		Unlocked
>  - >0:		Shared lock held with count
>  - INT_MIN+N:	Exclusive lock held, where N is the # of shared waiters
>  - INT_MIN:	Exclusive lock held, no shared waiters
> 
> When multiple CPUs are polling for space in the queue, they attempt to
> grab the exclusive lock to update the cons pointer from the hardware. If
> they fail to get the lock, they will spin until either the cons pointer
> is updated by another CPU.
> 
> The current code allows the possibility of shared lock starvation
> if there is a constant stream of CPUs trying to grab the exclusive lock.
> This leads to severe latency issues and soft lockups.
> 
> To mitigate this, we release the exclusive lock by only clearing the sign
> bit while retaining the shared lock waiter count as a way to avoid
> starving the shared lock waiters.
> 
> Also deleted cmpxchg loop while trying to acquire the shared lock as it
> is not needed. The waiters can see the positive lock count and proceed
> immediately after the exclusive lock is released.
> 
> Exclusive lock is not starved in that submitters will try exclusive lock
> first when new spaces become available.
> 
> In a staged test where 32 CPUs issue SVA invalidations simultaneously on
> a system with a 256 entry queue, the madvise (MADV_DONTNEED) latency
> dropped by 50% with this patch and without soft lockups.
> 
> Signed-off-by: Alexander Grest <Alexander.Grest@microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++++++++++---------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9b63525c13bb..9b7c01b731df 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -481,20 +481,19 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
>   */
>  static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
>  {
> -	int val;
> -
>  	/*
> -	 * We can try to avoid the cmpxchg() loop by simply incrementing the
> -	 * lock counter. When held in exclusive state, the lock counter is set
> -	 * to INT_MIN so these increments won't hurt as the value will remain
> -	 * negative.
> +	 * We can simply increment the lock counter. When held in exclusive
> +	 * state, the lock counter is set to INT_MIN so these increments won't
> +	 * hurt as the value will remain negative. This will also signal the
> +	 * exclusive locker that there are shared waiters. Once the exclusive
> +	 * locker releases the lock, the sign bit will be cleared and our
> +	 * increment will make the lock counter positive, allowing us to
> +	 * proceed.
>  	 */
>  	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
>  		return;
>  
> -	do {
> -		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
> -	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
> +	atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);

I think that should be "VAL > 0", as it is guaranteed that we hold the shared
lock at this point.

Otherwise,
Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

>  }
>  
>  static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
> @@ -521,9 +520,14 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
>  	__ret;								\
>  })
>  
> +/*
> + * Only clear the sign bit when releasing the exclusive lock this will
> + * allow any shared_lock() waiters to proceed without the possibility
> + * of entering the exclusive lock in a tight loop.
> + */
>  #define arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags)		\
>  ({									\
> -	atomic_set_release(&cmdq->lock, 0);				\
> +	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);				\
>  	local_irq_restore(flags);					\
>  })
>  
> -- 
> 2.43.0
> 
