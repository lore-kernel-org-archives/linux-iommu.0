Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7128725A;
	Tue, 21 Jul 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636502; cv=none; b=BTGBnLSkfWXEt3e1tgdNhvdIJeNbLFj7xFFR9USs4t3Wr8rJf0nQ3cw+07fWL1Uaup3zSseVRWfsfd5kr5UOq3rlxEljOTIWR7l5u6YqsPnJHfRgKgEnq4C7bl69/YluN5NDsntatrcxYl3VRYaY5o+xdOQcbv0xceagiB9267Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636502; c=relaxed/simple;
	bh=OlBgQEaiNFP7Ihb8u12X6Tqpu5mB6VRrvPahbnoL6ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egmghK2wjXCWPKhkBqpTxtAk7soZWMZNBcmYcGtO4P4J9u8x0MQNuOdh4Xgq3/Eo/kXWU4XkeZbFdCc0KJB+smW/zAG+iCwvjZMF/7l2Oh9C89BrK9BJprUbNNsSC2aJoKAXB+Rat3wkJE2FG+BjR5xyzLuZKPm5Cgvx2Sv74po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INvoAsVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INvoAsVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14721F00A3A;
	Tue, 21 Jul 2026 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636501;
	bh=7pahCQCJZkWB7Bt6RnXNNi3n/LzIVxTF2meGjyULJeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=INvoAsVx1Qz4m5Co6R4hwejAJd2SGDA3PnJ/7fJX7oerJJMPX4npQnJ5ptAIigMi4
	 fCraErsdfMug87oKHlhU7yKKrgdfKvCKGX1RrtbWJCeuH8pDiwN0hK4NgM7Pk1noiT
	 gFkVt8rQ9xDdU16Hd8Ziv8WGGnYb9PThBpUE/xyABwglgUhUSwHJMJa2NNJ2yxnXBv
	 wianVoeFPLatYRimSW9cRvCzEYXzVHDjpmvJ2xO/i1abL8+H6jZ7/4S+v1FnipL4sE
	 qU5UjF8fUHLBbVIkG87c83AdJ1PPj6WkGz/2r38vhhJ6WQJS3Qxpuiwh6mOyIKZZhD
	 pSmJ9oSH1wdCA==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH] iommu/amd: Wait for completion instead of returning early in iommu_completion_wait()
Date: Tue, 21 Jul 2026 13:21:27 +0100
Message-ID: <178463143320.206840.9481565301808596283.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260716141622.325032-1-guanghuifeng@linux.alibaba.com>
References: <20260716141622.325032-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 16 Jul 2026 22:16:22 +0800, Guanghui Feng wrote:
> need_sync is a per-IOMMU flag shared by all domains and devices behind
> that IOMMU. It is set whenever a command is queued with sync == true and
> cleared when a completion-wait (CWAIT) command is queued. However, a
> cleared need_sync only means that a covering CWAIT has been queued, not
> that all previously queued commands have actually completed in hardware.
> 
> iommu_completion_wait() read need_sync locklessly and returned early
> when it was false. This breaks the "block until all previously queued
> commands have completed" contract in a multi-CPU scenario:
> 
> [...]

Applied to iommu (fixes), thanks!

[1/1] iommu/amd: Wait for completion instead of returning early in iommu_completion_wait()
      https://git.kernel.org/iommu/c/1e75a8255f11

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
