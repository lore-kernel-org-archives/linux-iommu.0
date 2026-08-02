Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47FD3B27F8;
	Sun,  2 Aug 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672785; cv=none; b=oLGa6JbstH48pc1nuf/iv5/hmF+qnnf0K04Bm+WhddFHrf4xbRrwgKlqYk7cpxselxgam4IhSnwx9FBx1UkLWasEGSVC6eS4/DJkHS1hf4MBFHgq/30H+BFzRGffb45MQkVP1SZFfz0CQ78tbKodpx5ectCE06peftBExm/BoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672785; c=relaxed/simple;
	bh=SVFXN4IDd5YDXy9WtFOZyNy0Jt5HPiIie86KOe82T0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8OpJwmSATTTulNLINzjvsZkn26cmCH4tZ84idPCEAsPxGNJRwJo+WDg+ZOlP25gbcV2yaMtp8Yl01UvmysuS6PSWDRZ/NMXZTBu+VlpMsOp9PS4ANhpwCyDGuop2ikD1jh2hEYlxp5TSBkfK9PTmOK+quwgq85TIDeh84d5lbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzpNSuYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzpNSuYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62081F000E9;
	Sun,  2 Aug 2026 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785672784;
	bh=QCHf+BICxa7EuaPVaTzlpXTab1HmVNR8CLRR09b05kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WzpNSuYJ7wuarLciqjaZ1phi1fcfjZRNR4oTj/S6dyijpC0cIFrWkUalaju4zpd+x
	 kvfsJqh/7RXuZD045pQFw/GRm6pem2gYv29KshCfSGUxFfMrMp2bBXka8mIXrHg/ib
	 X56oynNj8cVgrJKBPohV/kTZcC1NTgLpe/mbTkqlTCFPfaEYLrXltUz3y5xQZ/J1+7
	 rkf+GyY9kRvPpVaMFw4utzH4kdf96CP/bQCDUH5J8Mt4h/T1osMWqhtKV6G2cix7h0
	 ETwSgXcHMSXFZ2da1BOzDmgNxYLVuZGxV/tIASmZZlkTjXlCJti3ZSxycuvPrC3e6K
	 jXfRJLPtQgWUA==
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org,
	Kevin Tian <kevin.tian@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v5 0/6] iommufd: Iterate the cache invalidation array in the core
Date: Sun,  2 Aug 2026 13:12:27 +0100
Message-ID: <178566589744.1710802.15577357267722332966.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785258826.git.nicolinc@nvidia.com>
References: <cover.1785258826.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 10:33:32 -0700, Nicolin Chen wrote:
> The vIOMMU cache_invalidate() and the nested-HWPT cache_invalidate_user()
> ops are each handed the full user invalidation array and must report, via
> array->entry_num, how many of its entries they handled. That makes every
> driver open-code the same array walk, with real downsides:
> 
>  - each driver carries its own loop and sub-array bookkeeping;
>  - the ARM SMMUv3 driver allocates a buffer sized to the whole array just
>    to iterate over it;
>  - hand-rolling the loop left the ARM SMMUv3 driver with two long-standing
>    bugs:
>     1) on a conversion failure it counts commands that it converted but
>        never issued, so user space skips invalidations that never reached
>        the cmdq;
>     2) it rejects a zero-length array, which the uAPI documents as a valid
>        request that only probes the data type.
> 
> [...]

Applied first patch to iommu (arm/smmu/updates), thanks!

[1/6] iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field
      https://git.kernel.org/iommu/c/773f2b9e3670

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
