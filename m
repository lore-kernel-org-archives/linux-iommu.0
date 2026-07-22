Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405374582DB;
	Wed, 22 Jul 2026 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756429; cv=none; b=mF+UMNskJDcSYTAsK4xvQ1NxijMfIffullO3kiitY8qeKAHHFtUMM95cuByg3zExsF290ZGx10NKvC7SUY524TvI9aEJzahhDoshNxLbaHrlo/o48ED574uez7nocqCs1IHcIooJ95RfK2ckoej/Zn0SuQMsX7rBQudfrmIiioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756429; c=relaxed/simple;
	bh=cAK1m0jRx2oGVZbqTr746Kz0YuF5w8cW39RxHYxq7DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkPJSwW7uiQ900CkM6I8AnYLx9SsZU5C5stDwb4A4Fe7MulpPS+ejXIHs4JSylVBtCTle8TyUuYaxondNmhJs/1ceajcKpY0YiCNx3F7nXlwJGWf8ea65REZDbsJ8CjgfYOMLPvCiTQgf1I7uBk8TmYdiUiBs0MQUrwiivZ7rtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lioNtIfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lioNtIfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F071F000E9;
	Wed, 22 Jul 2026 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756428;
	bh=fcPjP1500/6eSY0DtnbEdodYBbhS6k80C9bYmrehPN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lioNtIfDo5fWV4Om7SNXEaKHNkEkxqMGFM8iDj2f1HcKZs31pHwF19zT048wauxL9
	 Bt7x77wl2KDm8s6KAykydg/JdRl6oTxwTDgksupKKlbtL2hGQ+rxEypiSfqeoYP9jW
	 AqBmfMTG4v6Oof8+thx/gwn7H2ZvYMr7Z97z8zgEdom2sFdQzhLOyHfDk6bTFZRMTM
	 yup00lxBdfG7Tdt1xFV0VXNvFxZlavA31S4MqcBW20LQG1sTG5qhTvAovkINfrLzH9
	 3Kt1x/m72jUazCt2IjQwHNNTjK0x/2OkUzle/I1Pb5NKUCCBE4c738AOHtZARJR7Lz
	 fsjxPXN3D4TbA==
From: Will Deacon <will@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/msm: limit the per-master Machine ID list
Date: Wed, 22 Jul 2026 22:39:30 +0100
Message-ID: <178472600067.2879317.10684251320770300003.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722041619.17735-1-pengpeng@iscas.ac.cn>
References: <20260722041619.17735-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 12:16:19 +0800, Pengpeng Hou wrote:
> The OF translation path appends each unique stream ID from an IOMMU
> specifier to the fixed mids array in the per-master object. It currently
> has no capacity check before storing at mids[num_mids] and incrementing
> num_mids.
> 
> Return -ENOSPC when the array is full rather than writing the next ID
> beyond it.
> 
> [...]

Applied to iommu (qualcomm/msm), thanks!

[1/1] iommu/msm: limit the per-master Machine ID list
      https://git.kernel.org/iommu/c/e283e646ee89

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
