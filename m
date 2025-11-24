Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF72DCF43;
	Mon, 24 Nov 2025 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011935; cv=none; b=R5NtyQs7z8T/vWX2dav4KpU/bFmu4NH28s9HVFgo7E/0bUIzQ7VvAmMZ1Fl+p0qAvVsRDRuNt9YVdlChyvNJSSAPwaQQDVKG955932Rd+tmLJrlIDUYVyaUia6P4C/MkrSxn1gWFIshwq+x96cbmAQO1ZrBhv63BptRK6pu+X6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011935; c=relaxed/simple;
	bh=0SWLtqnL9JapMsCqWqiF0dNUjHQzXBqEndXCdl0ZK74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arMwl/dUdh/ACVKriRKb0Udm69XxIIVrkVXZ0tGyqT9irMr2YV5tiTbuExSOb9TeXvNbOU8Fu5/7XO28dEjO3NyPuAYoArh9TyH0H9MRN+28brl+I7eRz/Wk9d69rgp3+PJmhyxOch3QXA+7WJmvXJnvuH+UmfKymCSeKrKBhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFcWAxR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFcWAxR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E519C4CEFB;
	Mon, 24 Nov 2025 19:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764011935;
	bh=0SWLtqnL9JapMsCqWqiF0dNUjHQzXBqEndXCdl0ZK74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFcWAxR0D4KqPU7UM5btKxayO1W2pBfkK19/oFLILBaqhMwTYruBfJu0E56jbmR82
	 P0hVzzGvDzQUgVCF2CVQLB0EH1i/MuL9wbdAtYpKUQBR2EPOXA3IRYV+miWG4DQKFL
	 UVN2wpAZ7Ll5NMqfWltdsSlAC31TaJFJxBBtYr7/qeErd1hM4atyyjojqqOcSRBeVt
	 KbdhcMe5wABf8gubRZgaNHb+ie5AeGImdnzQNxbwrmD3Wd6JzIE0xPnMI9al9G4tJO
	 n+ChkrwVjU0lDZuzeOVZgutzxyR/duo8QgwflQT6kOGYDdom+FzN9XG4wVSeIUHmCx
	 vtIEHObvqF0SQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Ryan Huang <tzukui@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix error check in arm_smmu_alloc_cd_tables
Date: Mon, 24 Nov 2025 19:18:33 +0000
Message-Id: <176400339226.703452.83509466898335553.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251107190917.2858684-1-tzukui@google.com>
References: <20251107190917.2858684-1-tzukui@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Nov 2025 11:09:17 -0800, Ryan Huang wrote:
> In arm_smmu_alloc_cd_tables(), the error check following the
> dma_alloc_coherent() for cd_table->l2.l1tab incorrectly tests
> cd_table->l2.l2ptrs.
> 
> This means an allocation failure for l1tab goes undetected, causing
> the function to return 0 (success) erroneously.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Fix error check in arm_smmu_alloc_cd_tables
      https://git.kernel.org/iommu/c/5941f0e0c1e0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
