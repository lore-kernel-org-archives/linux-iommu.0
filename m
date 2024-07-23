Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B915748F;
	Tue, 23 Jul 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752393; cv=none; b=h8eE/cD5IXyUTFZzrheHf2sh0lnq+LiEB1aM92b+Hb+nFx/PthpDSX67HJ82qlwgXNpww6ghJmEki4B2aRTSPLZttrQdudn0vVbHnkz0RMNuu0qNOaKeKBvUcA+bdnFXmFbM5ilQyIem+IzbyojV5xk9lpOmtRQlNswy6PI5XbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752393; c=relaxed/simple;
	bh=h2amE+cISJ5VM5DpX9zxzkBkmuG5qBqHMGjFwxa6q+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU/JmJnmkfcLxK2zoPtdTLemFD6gLcEOhxEgcFfXewMDUmwLqR5Me3SlhW3DVGMNgq953XS4VkNxDEqOQqfmgKPC0HJxk/Ejzn+l8PO1d6AP2LTgb3iE3i9vhXPm8wOj9rE7K8tNZAn3Qwz2jIdA2AnWYeh/T6zZQv/LojsGYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu8bvCtS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu8bvCtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314CEC4AF0A;
	Tue, 23 Jul 2024 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752393;
	bh=h2amE+cISJ5VM5DpX9zxzkBkmuG5qBqHMGjFwxa6q+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mu8bvCtSCYFr7gTHmffIgc8SzPEQ+WIEe5Jqx96h6UzaXG5ySz3ol96VPRXgFdc2m
	 gGsciqJj2qqVEXY0b7DQGYZwQ9WZ0XE2gMVO5p4UlZ1u2wjy1A1bLMCCitqHj5fqtH
	 nthwrw0y3I0EkblHii1MvnZ2Y2uNRnj/vEgWJEGD24Qz4YhEY4O7QuiE/nX2sPbk8j
	 4DtrmHYk72NiT7qpQDceNlhw47XmcXbfRmaVMR3E36+I1TjbnHcxuYJZmdVwfPcowd
	 5rmYl4GT//FqK0PtptFByBy1F+nGIv/dqU4RH1+ivTo/6BQf+ikmoSOWJDmAXQv41u
	 /x255xkaCZB5g==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en
Date: Tue, 23 Jul 2024 17:33:06 +0100
Message-Id: <172175096929.2359500.17694398675089174396.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240716125522.3690358-1-artem.chernyshev@red-soft.ru>
References: <20240716125522.3690358-1-artem.chernyshev@red-soft.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 16 Jul 2024 15:55:14 +0300, Artem Chernyshev wrote:
> In sprd_iommu_cleanup() before calling function sprd_iommu_hw_en()
> dom->sdev is equal to NULL, which leads to null dereference.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied to iommu (next), thanks!

[1/1] iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en
      https://git.kernel.org/iommu/c/630482ee0653

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
