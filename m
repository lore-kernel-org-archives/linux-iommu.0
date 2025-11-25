Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517CA273805;
	Tue, 25 Nov 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091145; cv=none; b=goocY8FR2vihC953R0gymStvsZn+ajyjnyVT2KZq0uZF9j4kxm1aCf2Hya5X5oAKWxSMgJ0JLw+QNUY1FSRR9ZXYUIXWp4nuDjqXu3Qd9e5mq1M+jWACZOjXOmrQF/kNNf6WkcbXhdKYf/v6v4qmCrDc+hzgg/M82+QcNCcf6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091145; c=relaxed/simple;
	bh=0ZYzgXsj2OG75kqlvsUKd1vrvcP2vzTVYONiwY5d7Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwlDNkMFcWCllbzMpyEKPSYRrNa6fAk2WXnkKfx94pTVuAXRTHxa50VazkANxyDVXQwFA1yoPZP2X2bsEq2DQaL7hIyGkiKnUNXtve57i9UjUi/DoUPiL4shmjI1GGCvfZ8XiG7bC9mP77m3O/IOGpZjPNjWTdAm6AfIOy3UBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC9r6lIQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC9r6lIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F45C4CEF1;
	Tue, 25 Nov 2025 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764091142;
	bh=0ZYzgXsj2OG75kqlvsUKd1vrvcP2vzTVYONiwY5d7Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MC9r6lIQrvafr40HmhTKJdLlLUPWHaq6nhqA7Bkrv1dvt5tBO/vZbaZVL7xSsKUdn
	 mR6nxRuIszXfbgnsXTiyXftf/3Xrt9oqdxpWYTQq1YE/p623MYo3qoUb/zqw8E72GY
	 yV1sdptEGx14NRkNmoFZLbjLH56Fz6sldeqNlZTYDuBnDAit6k2h7D5FaouCjv9mt+
	 eEeg7DQ7bbMmMOCekrac4bTcDLA2BR+ACVJyl/tkr6sWz6XUL2DdvRfReaapFBDC6+
	 Vz0FTiUUTFt2+Wy1LTbxEV862sIdhdTi5tC/3s/8sDyiy7gL6Gz0RJDLHsMNDAN1J0
	 GQUoNEHooW/mA==
Date: Tue, 25 Nov 2025 17:18:57 +0000
From: Will Deacon <will@kernel.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and
 efficiency
Message-ID: <aSXlAT00HVCGBaNY@willie-the-truck>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
 <20251114171718.42215-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114171718.42215-3-jacob.pan@linux.microsoft.com>

On Fri, Nov 14, 2025 at 09:17:18AM -0800, Jacob Pan wrote:
> @@ -521,9 +527,14 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
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
> +	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);		\

nit: you can use atomic_fetch_andnot_release(INT_MIN)

That aside, doesn't this introduce a new fairness issue in that a steady
stream of shared lockers will starve somebody trying to take the lock
in exclusive state?

Will
