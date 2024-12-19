Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F71ACECE;
	Thu, 19 Dec 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734637661; cv=none; b=Sz6Z9bmDa61Sp3pEitJhd3S5gNkc9BX57XNSHkCYfRPNdkFz4btbwWOg27pphKcTfoLFbMjsFLHJZnBWXBk9HOeHEk8Hc8Zd4o1YF6xCJ9piwwnlu+N62EYgCuKvJZuTxApzk/MlSQLWsXEnmhju1QH0C/iQdQzft/0vg3QJfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734637661; c=relaxed/simple;
	bh=dkp8ipPFDwPUJsG40zHLmUUIeVPvehlts/Xx6kkeFyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJf5pds68chehRaEkaX7S8JWdzBNW3OGWnVnoR8mRF/vMnCU+a3wscWz+gZorGuiaavlYszZCH2ijjLcWoVlvNO2X/Sr5G6B85aY7Zy4K2jHu69Uft2wPVBr50m66AL6SU9OkFURxHY1/I4RctDjfBfKxnYG1OM9aC58t4dAK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+RbjNAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+RbjNAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C22C4CED6;
	Thu, 19 Dec 2024 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734637661;
	bh=dkp8ipPFDwPUJsG40zHLmUUIeVPvehlts/Xx6kkeFyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+RbjNAv2y635UX58SLCFa7dknjWuDxCP0P9jtGl+RfoHw0+nqdGZBBWIA/RkU7tp
	 09rdOAravATsThubSsycjvc8O9IDCHbQlxb2L5VsvNvN/aWds2bG4bVPXEXv9xrCDJ
	 XwBjOqAd8I/H2rk3D1PL86W+NFomYCnfBx1DvnnOn5o8ZGYlauLtrXpKi4xUaxg8lL
	 63bQQlmIpbpASNjj+SgM9BYE4mt0obyrOgci41xnD4KvDvbV7WqoqEzOKk27pVucLP
	 KAsfpyWi3EkCCzj5TF3+kiMSHREncZHTIhG/kWJFaUaW+k2k8QdBIU+CI7CHdLrYEM
	 QhWvaKABIeTqg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: Fix cfg reading in arm_lpae_concat_mandatory()
Date: Thu, 19 Dec 2024 19:47:13 +0000
Message-Id: <173462288874.3912129.4288094387004225028.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241215200412.561400-1-smostafa@google.com>
References: <20241215200412.561400-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 15 Dec 2024 20:04:11 +0000, Mostafa Saleh wrote:
> I messed up the newly introduced function arm_lpae_concat_mandatory()
> where ias/oas are read from the io_pgtable_cfg copy in arm_lpae_io_pgtable.
> 
> However, this copy is set later in alloc_io_pgtable_ops() after alloc()
> function was called.
> 
> I didn’t catch that with my selftesting as arm_lpae_io_pgtable is
> allocated from kmalloc, which was caching old configs.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/io-pgtable-arm: Fix cfg reading in arm_lpae_concat_mandatory()
      https://git.kernel.org/will/c/b7b8a6305557

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
