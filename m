Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1425393
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 19:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A024C36AE2;
	Tue, 19 Jul 2022 19:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658260636;
	bh=YhW21QMLwSVKvPPwBDPq0FP9/l/ZC8heG1iNknMTX9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CME/D3RLyVJKigtZx6kw9wcQLFAbZH78IWR8rW7OWDjaOX9EaBfgj4aMA43r5G7wS
	 6Q6/3BDbsxxZBpHLghfGaR6slRxQdnK0eJLdGuutojlAwmlZqLOK1oh3ce6tYQP4OJ
	 a0nHoDuY8LnRvzIDOh1c3IA3RFDU7tGli2Laqv8WNo4L3wV+N+X5lBvTt0i5k3SE9+
	 flKxcBGOwk+v6LyKUJ7+1BuY9PcQC2Vn28ACGDSu4UGw134pKz1Z4FCPrmMKjSuuUc
	 enmWHWDhu97HNoGoOX/v0RpUVUMszkW+QxzRqcbFcvTJ29FTpqTVGkc8DBPrdvTltU
	 8ihND0dZRW7Tg==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	Liang He <windhl@126.com>,
	robdclark@gmail.com
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop
Date: Tue, 19 Jul 2022 20:56:55 +0100
Message-Id: <165825181062.2951540.268101544682654909.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220719124955.1242171-1-windhl@126.com>
References: <20220719124955.1242171-1-windhl@126.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 19 Jul 2022 20:49:55 +0800, Liang He wrote:
> In qcom_iommu_has_secure_context(), we should call of_node_put()
> for the reference 'child' when breaking out of for_each_child_of_node()
> which will automatically increase and decrease the refcount.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop
      https://git.kernel.org/will/c/a91eb6803c1c 

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
