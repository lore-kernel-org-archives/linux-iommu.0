Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C64DC94
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 20:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A64C433C9;
	Tue,  1 Aug 2023 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690922514;
	bh=UmykxjBF+sC4aN4OQ8EfvIYebgfE0K7LxRs85fn43fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeH44eSsG9xcFFrj+wih+yefO4Nd1y2oXU/izkvZNGEVLYMWas4UYdN/krVJ8IDvk
	 2oRZC/YX+ezOMpzKcC5UWEA7B6X5lcsA9lBf8n3NPEfAHNEQo9Ume5RAXLLySBhEGN
	 avE9yqBmEpeYKzGzoFqIZ3Dco0dtnqVtKk8ud5pxmmyDzHk32Tfyz3hUZ5AwIKovqU
	 xND8qoW6cRRFcDU2/d4yXsKlcJhtRu+MSHyAFl54PIYfO/pCVpFmb29eEUo8QgwIZS
	 jR8VkCgdvvCbY2R/xNAJkDUm6+BNfajHsdploQkOYiC8Slm+HffWvtIPRwvbpbXpr/
	 ALP1Xuhl83fMA==
From: Will Deacon <will@kernel.org>
To: Dawei Li <set_pte_at@outlook.com>,
	joro@8bytes.org,
	robin.murphy@arm.com
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Change vmid alloc strategy from bitmap to ida
Date: Tue,  1 Aug 2023 21:41:47 +0100
Message-Id: <169087904450.1290857.11726985177314533259.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 16 Jul 2023 00:16:21 +0800, Dawei Li wrote:
> For current implementation of vmid allocation of arm smmu-v3, a per-smmu
> devide bitmap of 64K bits(8K bytes) is allocated on behalf of possible VMID
> range, which is two pages for some architectures. Besides that, its memory
> consumption is 'static', despite of how many VMIDs are allocated actually.
> 
> That's memory inefficient and lack of scalability.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Change vmid alloc strategy from bitmap to ida
      https://git.kernel.org/will/c/1672730cffaf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
