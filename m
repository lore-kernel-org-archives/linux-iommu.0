Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335027B3D9;
	Tue, 12 Dec 2023 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlNhbvWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8F4C433C9;
	Tue, 12 Dec 2023 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401694;
	bh=ax1TJ8fcxuZhrG1GseVHnGGDWIWrJDvPmtLFkog0odM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlNhbvWP0Dv5mgbzBG7ZiT/08F9m3fxzXLqsIJwvBHh+I9EfBGC7CZyz0H1dH6ZPt
	 yGUHEwpENHdLF/PI7uaBOGFNzy9L1mq7dJaiPxb3X70KtJkH4F2PDGa1T3dO1fza4c
	 CSZBXnVoInqWfDZ8XO30aei/keTJw4WQG52z/frNW6wIxR3dS9Z1XEz9cp9qZpSllk
	 JiIKSjJDWurE5bIllI9w/QthMu4pvIuNQL05oJtpNTM0kcKwBmfs5FNEn/2JoKvek+
	 gunH2c04ObuoBSXHTZQfvFkaNUtW3G36e6AW49Je/eL6f7cAIUkiV0YJAYscstlYw6
	 f6c3AbTIg+2IQ==
From: Will Deacon <will@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	phone-devel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/qcom: restore IOMMU state if needed
Date: Tue, 12 Dec 2023 17:20:57 +0000
Message-Id: <170238443082.3098533.11843607939616442768.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011-msm8953-iommu-restore-v1-1-48a0c93809a2@z3ntu.xyz>
References: <20231011-msm8953-iommu-restore-v1-1-48a0c93809a2@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Oct 2023 19:57:26 +0200, Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> If the IOMMU has a power domain then some state will be lost in
> qcom_iommu_suspend and TZ will reset device if we don't call
> qcom_scm_restore_sec_cfg before accessing it again.
> 
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/qcom: restore IOMMU state if needed
      https://git.kernel.org/will/c/268dd4edb748

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
