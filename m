Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55F1097E
	for <iommu@lists.linux.dev>; Wed,  4 Oct 2023 10:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61011C433C8;
	Wed,  4 Oct 2023 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696414130;
	bh=ziJwjYvWmDrx/OZW30jWykdrY4rTHf3r4/nycmHupnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AA1PigxVcMFjdOwjlC/ZxO4N9pjUxDEi22309Fg2ONAiEFRubviYO9ijs4WFQID+o
	 C8b74s55iQYzUvFimJL0OCSOkb+SI6HLOHjj0OA3tyuvheiciNbFjKQydZXojNViW6
	 0QhQh95Taok7G9ZXVCsUdpzOsswki5TxGJ25zCGvAFhZ03+EkOpNbk3v4zLfMfKzRZ
	 N7+CS3vId1EXUuImzOUtN2e79D4b09vutpnpYjcEUnb/OiYhT4Ly0ivDd5HKzm2W2E
	 5r+LkuQnz9dVy5v+w37S+x8eg19CcopCvKqs/LOcRwnoPVjjN2cwETRyONpbw4MjHr
	 O8zweqAxnmGGQ==
Date: Wed, 4 Oct 2023 06:08:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: stable@vger.kernel.org, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, jgg@nvidia.com, jean-philippe@linaro.org,
	baolu.lu@linux.intel.com, apopple@nvidia.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH][6.5, 6.1, 5.15] iommu/arm-smmu-v3: Fix soft lockup
 triggered by arm_smmu_mm_invalidate_range
Message-ID: <ZR05sWtiMmM0w2sb@sashalap>
References: <20231003233549.33678-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231003233549.33678-1-nicolinc@nvidia.com>

On Tue, Oct 03, 2023 at 04:35:49PM -0700, Nicolin Chen wrote:
>commit d5afb4b47e13161b3f33904d45110f9e6463bad6 upstream.

Queued up, thanks!

We don't need the addition of a stable tag here as the bot suggests,
it's just being silly...

-- 
Thanks,
Sasha
