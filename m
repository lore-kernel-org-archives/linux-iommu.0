Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66E48A2D0;
	Thu,  6 Aug 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036345; cv=none; b=gee/nPNYa83kxpk7powP53Qn7Y+tvcd2EGSxzWCZC9O5WsB70lta3G7DQeHv0fGdKTPrYcOu41eXCATpuE6OyknGJpQ5eOITFdcTA3HvBT8O3VL0JvFdQvn7JzXtk4z778ddIlb3efxoLSmoXk1OKXMVGW5W+rHzDELFpdgby74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036345; c=relaxed/simple;
	bh=QLazBSWJzmxdVM+o91IPuwP7fcMUPK4GBmcTiJxYhcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB/et8qZC4Xbcd7C0iGZb8zfA9vd30fRKxfez0PNGCUbM7rHC87LxyP1YAR438LMT/fJzwHxkNkKoRez8VpfTxfVzn48TQHr8bOjpvCRFzbsEo9FBW5HE3tx4wY0pCwFXGmPiPIYQxWJlSJITR/6f0Feri4ZS4J4vTpLpR9IQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJxprpj/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJxprpj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E4A1F00A3D;
	Thu,  6 Aug 2026 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036343;
	bh=/22LGD1MGbC96K2zWOrMVz7tCsjDUPU9MbskXggav7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aJxprpj/PmeLQcUf+DpkzRl7CnakIvyMWVwJ70+wVwNnKVtFvXGjz9FtIIsqYhKRj
	 2OOcLN+Dxf5yEOIISv5TQstKp20rKTaODyTqJkqNj6cvGudQmR+9xhhp/GhKHGiuuU
	 xWpyYCqfvdnRc0a3kl1pQCUd+JrBvsA9ONkfwP7m/XA55WtNMMZxEEaRLpiR1ck50h
	 rY0hKPyeib0L68BZg6aAvD2PlbZ/Dfn7zjbMcdWWL2PGKq0jq9qw0nX7e4bwVolCL4
	 WGclWlKRboI6O97q8rZ6Dg7dkkRLfrZvAOHMSqogW36MEkwYbZc/gZuyHSYOCgDYXG
	 OqpoYDJhvAjbA==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	akpm@linux-foundation.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	cychu@google.com,
	hhchung@google.com,
	amitamishra@google.com,
	marscheng@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor.lin@realtek.com>
Subject: Re: [PATCH 0/2] lib/sort: Clean up sort_nonatomic() and sort_r_nonatomic()
Date: Thu,  6 Aug 2026 18:11:46 +0100
Message-ID: <178585154950.3657024.3915308246763901818.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730181216.2709088-1-visitorckw@gmail.com>
References: <20260730181216.2709088-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 18:12:14 +0000, Kuan-Wei Chiu wrote:
> Remove the sort_nonatomic() and sort_r_nonatomic() APIs from the kernel
> library.
> 
> Currently, the arm-smmu-v3 driver is the sole in-tree user of
> sort_nonatomic(). Because the array size being sorted is small in
> practice, there is no real risk of triggering a soft lockup. Therefore,
> the periodic cond_resched() calls provided by the _nonatomic variant
> are unnecessary.
> 
> [...]

Applied driver change to iommu (arm/smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Replace sort_nonatomic() with sort()
      https://git.kernel.org/iommu/c/340e3c5165d4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
