Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E10218AC4;
	Thu, 27 Mar 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087536; cv=none; b=KF9g72azD09fcF6y4f3zT9M2JnBDCMdQMqVM9YHhqyemUAfn0xFSiwSx5eiL5UvkztcH8JPjNv04C2REcB33j93kG6z0Q2PI4WNHEjKbT24COhL4VrQZFA+gXsr2yCoOWXvwjR0JPamDoQmKupviKRZJ4xDx0DP07KboBcLlYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087536; c=relaxed/simple;
	bh=8kP4cx+BAhHRdHdqdxgbqhlAg1DO5wKLzIFHVmMZrAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQrjpZVaGiRWuUZ9aKNY5nL53L3IZ0fm7gkPOUsRZ1sZgbYxp2pZR5c8XBDAw3tKnQ0I+/C0aGmGLhkHaL9186FJTGnCvw1f2fL+JgORapnibo6lzxy1iXwkFuH4V8zyLpuAwo8uWv58rb0HkY8KwflxMpuiSchY3UYuGI/YCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH/PWu7y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH/PWu7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFB6C4CEE4;
	Thu, 27 Mar 2025 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743087536;
	bh=8kP4cx+BAhHRdHdqdxgbqhlAg1DO5wKLzIFHVmMZrAI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mH/PWu7yUQt02nUJMHXCp0NghWfBt7VeYwatmm4u3KDQdt0OiRQbbgSI6Ie/puBl9
	 lN+mMdGUGkzUvXXOOXDMruMO+lViGmKuSz07KKrK3PzUMmMt5aSowtXrDdsVl2MyFY
	 VvNXisvo7Lt/jn4OdjYRt3hxGmespkzbJNaLT9DCkBt8B/EVDzXZuRT9g76XAvqOkg
	 wFYsTP9nSvSm67GBQkAj/xC5r+uWrh+0D7hVzjn8r3LNee5raeBIkEhqVUUh3cOAm7
	 dsZyVHfV79Kika+uSCeezTRgrecLVpFRVaphW26gMGb0e9Hup34YBhbbP75TaNOS4r
	 GRfzCAVYHgnsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7826CE0843; Thu, 27 Mar 2025 07:58:55 -0700 (PDT)
Date: Thu, 27 Mar 2025 07:58:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] iommu: Convert unreachable() to BUG()
Message-ID: <7ffc46e5-60ff-4bef-8fdc-9ab0c67ebd6b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>

On Wed, Mar 26, 2025 at 10:28:46PM -0700, Josh Poimboeuf wrote:
> Bare unreachable() should be avoided as it generates undefined behavior,
> e.g. falling through to the next function.  Use BUG() instead so the
> error is defined.
> 
> Fixes the following warnings:
> 
>   drivers/iommu/dma-iommu.o: warning: objtool: iommu_dma_sw_msi+0x92: can't find jump dest instruction at .text+0x54d5
>   vmlinux.o: warning: objtool: iommu_dma_get_msi_page() falls through to next function __iommu_dma_unmap()
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/314f8809-cd59-479b-97d7-49356bf1c8d1@infradead.org
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Closes: https://lore.kernel.org/5dd1f35e-8ece-43b7-ad6d-86d02d2718f6@paulmck-laptop
> Fixes: 6aa63a4ec947 ("iommu: Sort out domain user data")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thank you for the quick response!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  drivers/iommu/dma-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7b2734de2ba9..6054d0ab8023 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1753,7 +1753,7 @@ static size_t cookie_msi_granule(const struct iommu_domain *domain)
>  	case IOMMU_COOKIE_DMA_MSI:
>  		return PAGE_SIZE;
>  	default:
> -		unreachable();
> +		BUG();
>  	};
>  }
>  
> @@ -1765,7 +1765,7 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
>  	case IOMMU_COOKIE_DMA_MSI:
>  		return &domain->msi_cookie->msi_page_list;
>  	default:
> -		unreachable();
> +		BUG();
>  	};
>  }
>  
> -- 
> 2.48.1
> 
