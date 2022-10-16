Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BDED8
	for <iommu@lists.linux.dev>; Sun, 16 Oct 2022 13:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713DBC433D6;
	Sun, 16 Oct 2022 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665927016;
	bh=KTzBJ41O2/NP1Xvp37TwTR0e2oXjg8Mhj0R85XRcxf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LxvXkWcim8owV9e8FtwxLjBqyryolV2zepprknggKvzuqEciYeCJy4uUXR5iTRSw5
	 bNE7B4zUurstMJ/44/zHnCmI+PvBSTlmd4+JHC6smhcHJ4pIDlCfcd6qW+CNBqTkkZ
	 tHcvmUJjm/4E4XI/xe71CJyVO9Sj0mQms+vLpoKefTVZJA77WIi19GU/LTYYZlyQe0
	 Y/B6BMMn5hU3J1KCf/ugC3LGLpb85sR+gwBqZ8FkxztyL+doy7W7dLhYe++tPuzvjf
	 3RBcE8AKBNVD/mjglesBSb/y63NDq0+R7dhKDtFobir/yg8vKdzYjPvBQpCmoAppCR
	 xgRNdHfeD+waw==
Date: Sun, 16 Oct 2022 09:30:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Will Deacon <will@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>, joro@8bytes.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, jgg@ziepe.ca,
	tglx@linutronix.de, shameerali.kolothum.thodi@huawei.com,
	christophe.jaillet@wanadoo.fr, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 5.15 10/47] iommu/arm-smmu-v3: Make default
 domain type of HiSilicon PTT device to identity
Message-ID: <Y0wHZxMV2pRVjvyN@sashalap>
References: <20221013002124.1894077-1-sashal@kernel.org>
 <20221013002124.1894077-10-sashal@kernel.org>
 <4ffc662d-5c73-5047-81d5-ad78ca3a7d7e@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4ffc662d-5c73-5047-81d5-ad78ca3a7d7e@huawei.com>

On Thu, Oct 13, 2022 at 08:07:46AM +0100, John Garry wrote:
>On 13/10/2022 01:20, Sasha Levin wrote:
>>From: Yicong Yang<yangyicong@hisilicon.com>
>>
>>[ Upstream commit 24b6c7798a0122012ca848ea0d25e973334266b0 ]
>>
>>The DMA operations of HiSilicon PTT device can only work properly with
>>identical mappings. So add a quirk for the device to force the domain
>>as passthrough.
>>
>>Acked-by: Will Deacon<will@kernel.org>
>>Signed-off-by: Yicong Yang<yangyicong@hisilicon.com>
>>Reviewed-by: John Garry<john.garry@huawei.com>
>>Link:https://lore.kernel.org/r/20220816114414.4092-2-yangyicong@huawei.com
>>Signed-off-by: Mathieu Poirier<mathieu.poirier@linaro.org>
>>Signed-off-by: Sasha Levin<sashal@kernel.org>
>>---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>
>I don't think that this commit should be backported to any stable 
>tree. It's only required for a new driver.

I'll drop it, thanks!
-- 
Thanks,
Sasha
