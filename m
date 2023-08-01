Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466174DC94
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 20:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B228CC433C8;
	Tue,  1 Aug 2023 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690922512;
	bh=Ru+b3oEZPQazdmXzDRhzAlXaDh13Ys1hi6gQ2UgJgEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrVAmGhpykx3UOI+aLOwipKXGDy/7xPxNoU0w1zrSKS5oYRg70zlHxY1m+2Pr9vm9
	 HnlWgITb8lpMSeu4Aye8R+4CznA3cJR9f3DR7p1be9HX5uj6xXTmWxKtD8Km+VzRx5
	 W3CTDr7IMFTHCSen7s1sdoBSWg5aMS4iz2D4dZFbpVeTJLWdjRaS51EHtunjyVeP/C
	 Aonb7SmvFBx+V0JL3ySA5ohs4l/1vuNRK/mRSPLy82dY6HAK9i1B/hK9iV6K/T7RHR
	 4eenXoeJJWDjOrWgK4HxBoca0gDyOWiB3st14eYU74iEfvCU7pCqf/M0le22xCWtbl
	 ghYa+TlhDiWpA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Yangtao Li <frank.li@vivo.com>,
	Rob Clark <robdclark@gmail.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] iommu/arm-smmu: do some cleanup
Date: Tue,  1 Aug 2023 21:41:46 +0100
Message-Id: <169089727545.1325205.14020331794830361964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230705130416.46710-1-frank.li@vivo.com>
References: <20230705130416.46710-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 5 Jul 2023 21:04:11 +0800, Yangtao Li wrote:
> Convert to use devm_platform_ioremap_resource() and fix return value
> when platform_get_irq fails.
> 
> 

Applied Arm SMMU patch to will (for-joerg/arm-smmu/updates), thanks!

[1/6] iommu/arm-smmu: Clean up resource handling during Qualcomm context probe 
      https://git.kernel.org/will/c/0a8c264d51ad

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
