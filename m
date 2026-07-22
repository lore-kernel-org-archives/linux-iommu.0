Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98A43F4C3;
	Wed, 22 Jul 2026 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756400; cv=none; b=WlEEYj+bD2I/23J03ZeYRoxeQ6i/Zjc8Bpu2KyYVQ9snEgHmySC837mlynOfde7zimrMb245fumKlCxP0dp52L+nKMOtvZVxtXeLU1H/h5qbMN/M54HkysCcOwPcAC9/sAqKDtm4sD6FAEk2nDIZBB4dX3WHjvgQt/WXr7NYIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756400; c=relaxed/simple;
	bh=9+xzSvJGToT5d6yYZEBVMvz2tq94dZTg+cEmYvs6cRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=admwK90F8S8KJ6YTdeXNNO8X9StZOhFjyeCeTbXKuphRt0VvEZgDGk2cS0cT3WMaYUBggqfXLwgKAuz/CYV2XWFLwnvoxLNWw7c7xkpHegqEeUEWpS7iaRs9jYKSvMfDsYmmWIxPxnUaQH0bKSD2t7W+QeQnBYoHA9oUb2z54E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2T0ggEP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2T0ggEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB331F000E9;
	Wed, 22 Jul 2026 21:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756398;
	bh=eYJOxwafJl8OVO7ncar+6PV1o72DMzw1345lwAkie64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2T0ggEP+OzKgwGT1ua3fLRCEfsJHCUoE8FKfLu3rnKwkTwl4OJh4SY5bVUZGP20Z
	 ycu63WdemDnA4UHLqyRNyMJ7QDhBuZsNWPVsTb5RReFpLEwdiW5x85yqL858gXVBHD
	 2SbD5Qjb2Br81+olXRINqIV5qrw8U8x52zk9Et1epHCO5GDbboegW6SSAUq4cN4dZO
	 aOf9+DV94dTf6HUPM6m20DbTqXqMDK0XrZoli/ySD1i3Oxxx3SSw2+bEGxNRrHwnu5
	 lHLAqWw9fEreSZyWtuDLA+E679GcXpSQNFCmunk2SrLeiQQ7jYSRrW89JP7tv8pLhj
	 7veJ2m+sxh3DQ==
From: Will Deacon <will@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Esteban Urrutia <esteuwu@proton.me>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add SM8450 MDSS compatible
Date: Wed, 22 Jul 2026 22:39:21 +0100
Message-ID: <178472263086.2852085.5726009348827145429.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711-sm8450-qol-smmu-v2-1-41a6fba41c3e@proton.me>
References: <20260711-sm8450-qol-smmu-v2-1-41a6fba41c3e@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 11 Jul 2026 23:14:01 -0400, Esteban Urrutia wrote:
> Add the compatible for the MDSS client on the Snapdragon 8 Gen 1 so it can
> be properly configured by the IOMMU driver.
> 
> Otherwise, there is an unhandled context fault, because the framebuffer is
> already configured in UEFI.
> 
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Add SM8450 MDSS compatible
      https://git.kernel.org/iommu/c/d149c8b2c014

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
