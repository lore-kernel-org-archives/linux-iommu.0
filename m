Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031E380
	for <iommu@lists.linux.dev>; Sun, 23 Oct 2022 14:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4061DC433D6;
	Sun, 23 Oct 2022 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1666535812;
	bh=VHsCq3KJhfBXSa7NUYUeMeEK9sRiriWcBkcMV40tuF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a896ovhiG/FxmSu0fUzsV6CY0BrsT8dlwDHluHliQHIUJ8ujOXesmdEZUx0zI/DFS
	 YyDIn+00UNjOptdtwAASs0xc1yTfdcPuD6Pm/u0u7nW+e8reQsal0vgbKU1n6TCaoV
	 CL9phJ5a86B97feq0A3GfN1U6OD/vLeednRaveno=
Date: Sun, 23 Oct 2022 16:36:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Lin <chen45464546@163.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	treding@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Chen Lin <chen.lin5@zte.com.cn>
Subject: Re: [PATCH] iommu/arm-smmu: Warn once when the perfetcher errata
 patch fails to allpy
Message-ID: <Y1VRgf1wsng07cMT@kroah.com>
References: <20221022024559.4913-1-chen45464546@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022024559.4913-1-chen45464546@163.com>

On Sat, Oct 22, 2022 at 10:45:59AM +0800, Chen Lin wrote:
> From: Chen Lin <chen.lin5@zte.com.cn>
> 
> Default reset value of secure banked register SMMU_sACR.cache_lock is 1.
> If it is not been set to 0 by secure software(eg: atf), the non-secure 
> linux cannot clear ARM_MMU500_ACTLR_CPRE bit. In this situation,
> the prefetcher errata is not applied successfully, warn once.
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 3 +++
>  1 file changed, 3 insertions(+)

As has been stated many times before, please fix your email systems and
stop using personal accounts, if you wish for us to think that you
really are developing from a zte.com.cn account.

thanks,

greg k-h
