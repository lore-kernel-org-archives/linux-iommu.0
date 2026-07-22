Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A39459AD7;
	Wed, 22 Jul 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756435; cv=none; b=VV5rc7EPZ2T6lYE7b07MR7RylMHcWGPjeTU6DgEwjqtZnEoDvH0mgCI7t+lxDhES1G9TzInT9unQ20ZagB9wMV5JhrKF+1+16SKh8xMaxYKbbxZein1tpU0xlayPhSV77GijldvcREXdl+hm2LQiLROjDSdJWaAo6uDP1AIaKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756435; c=relaxed/simple;
	bh=N7iI8rnxXRMK6eyTyS1PfEFDsGgE+WOZVUiA270cwPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sd8/uCsrt+VInDhA/zczdIZbozNrsUy0yQ3a7PrPd/td0LQ5Mt+AGkDwtHwu2DZg16KYbn1qk+qK2TduIZ06nkY/DiSjcD8YcJuHbn1dfZ13KuUxsTIMq6h1O5xaXDduB++aiOnPR+0oylO851nU65gwQ8QtnKikZsnGzjLjN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4D6ypM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4D6ypM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5DB1F00A3F;
	Wed, 22 Jul 2026 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756434;
	bh=EEinb8x1n/52ikO4dgPpIDNXRcccL4tQe99OcpqrHQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4D6ypM3TPGTNABv/hy3lXYHz1JJ9mUQaxzoPi1r8kH5TsAvIb8+y3Z6y2X/eyXM6
	 rJVzRJDuMdBmHLDCSH6R9PKI2Z7+5INC0C1B2P8Ili1m5AjSHWrhRcq071ezmTtJ1j
	 vjpMzq0ge7hRviDfdBr3wNt+oJHnqU6h08geXPitkeEt+hwuzTFc3CgQRPljc7LzAe
	 jHxOxVMA9SHmwFS6Hmz1Vo2ZFoeS33z3sbQdYVUoucbMj/KpFnZdAfD+EUR92zGKRU
	 6ZiDyhXlGUB03EXQoCYEhU8wsjJdqt95ehEovB8WZMhoh6s9HrCi4ECs66UlFkhIJr
	 xyaLH66dJlN+A==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shameer Kolothum <skolothumtho@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	nicolinc@nvidia.com,
	jgg@ziepe.ca,
	joro@8bytes.org,
	robin.murphy@arm.com,
	nathanc@nvidia.com,
	mochs@nvidia.com
Subject: Re: [PATCH v3 0/2] iommu/arm-smmu-v3: Fix Tegra241 CMDQV CMD_SYNC use-after-free
Date: Wed, 22 Jul 2026 22:39:32 +0100
Message-ID: <178472672974.2884042.6708017212584302884.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629094106.251694-1-skolothumtho@nvidia.com>
References: <20260629094106.251694-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 10:41:04 +0100, Shameer Kolothum wrote:
> Changes from v2:
>  https://lore.kernel.org/linux-iommu/20260611084205.686559-1-skolothumtho@nvidia.com/
> 
>  -Addressed feedback and picked up R-by tags(Thanks!).
>  -Use explicit type casts in devm action callbacks(patch #1)
>  -Add Cc: stable to patch #1 as it is a pre requisite for patch #2.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Manage teardown with devm
      https://git.kernel.org/iommu/c/2bd22a0d4050
[2/2] iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown
      https://git.kernel.org/iommu/c/9ff145a25c5c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
