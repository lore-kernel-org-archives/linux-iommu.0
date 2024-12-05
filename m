Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA9221461
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423020; cv=none; b=sTP+w6CAiPw7IAJfONUXLAckI8LXIwgfEvGhyFZEeHuz5QQKks273pe09sKIFuVl+UizkbA+7LNRX1uDED9AF8LJ2N8qZrcdxCql68tL3FbOJDRavTUPzaJlzpbd5HYqZUHAuhfut/6lZK+iRUfiPSkEwCdohUDDhnnYxzGCcuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423020; c=relaxed/simple;
	bh=xuya9fxjvP43PI88ezPFzmzDY60KEv4zg8ju2hBwIIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZOygFNca5GihfgFSvjWKvTMAsxTIatyzHUIYd3fHigey/RoP98DKqqZOx1R2HKqWfbEK82xviatisPEyMZ5vM5I+Oz6O/VOa43s7xhGmBdag8iWfEzv4jgZK5pHP6Xv+RKEX9M4FD7eXgT5JnmnB12WBQQ5oQhBFqsoO7gkXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3866C4CEDC;
	Thu,  5 Dec 2024 18:23:38 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org,
	jean-philippe@linaro.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org
Subject: Re: (subset) [PATCH 1/2] iommu/arm-smmu-v3: Document SVA interaction with new pagetable features
Date: Thu,  5 Dec 2024 18:23:36 +0000
Message-Id: <173342292875.1735998.11342538299837592943.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Dec 2024 13:48:09 +0000, Robin Murphy wrote:
> Process pagetables may now be using new permission-indirection-based
> features which an SMMU may not understand when given such a table for
> SVA. Although SMMUv3.4 does add its own S1PIE feature, realistically
> we're still going to have to cope with feature mismatches between CPUs
> and SMMUs, so let's start simple and essentially just document the
> expectations for what falls out as-is. Although it seems unlikely for
> SVA applications to also depend on memory-hardening features, or
> vice-versa, the relative lifecycles make it tricky to enforce mutual
> exclusivity. Thankfully our PIE index allocation makes it relatively
> benign for an SMMU to keep interpreting them as direct permissions, the
> only real implication is that an SVA application cannot harden itself
> against its own devices with these features. Thus, inform the user about
> that just in case they have other expectations.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[2/2] arm64: cpufeature: Add GCS to cpucap_is_possible()
      https://git.kernel.org/arm64/c/f00b53f1614f

-- 
Catalin

