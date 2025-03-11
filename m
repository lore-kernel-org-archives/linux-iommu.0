Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A575263C9E
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719506; cv=none; b=t/qmawIiD5ZMVbUNpSRHbm+ooVC8+PhVsvJdhxDqHVJJcdez5SW2RwjGJiwI8B/Yzn3dWTeNgv9NeajyWJCCKRGqChveRDpuPfOIWZNw4yaOkkJrVbGoGx0WU9muQ46HPRB5mpt2MXQVHw63vz+uqmG0BM4hABrAEfsWcWX6tEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719506; c=relaxed/simple;
	bh=DOeKM7axRAF2gOn81ZgeXdciwlVg2xMLr0pqXwD18I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Frz/2NF4tWSvMi35OC97pe1BXLuoE2OTAHvvKdWFP7AzlMWDb/tdt/Wlt1UdaxXcZ12qJdjhZKQQVQ84EVsRu/GGukHVtSO+jM691N9GI0AO5Mvm4p7PiALxmsV2Un4Ehtv/xbPbmJL9r185Rt5ry8N/XDWVIVwA8KMsyZLp9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWm3K2q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWm3K2q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99673C4CEE9;
	Tue, 11 Mar 2025 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741719505;
	bh=DOeKM7axRAF2gOn81ZgeXdciwlVg2xMLr0pqXwD18I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWm3K2q9xfSbKFcWj7Z3kEFiPmvX08B7JmzTK+eXFZF/7hPvGXxnN28QPbUt9PG7s
	 ZE1h5MJdFV1KzlFaM/HtKTNtWzpmDnKtxPL41wEAPX9t1FuvV1tCnluisn9I4YBmR9
	 0WlhG5pdRvvX+MlPZ+eYW4LhgxCIWfciUzSygbch1WdpMRAiQC3sC//7QQ5rMCJwWQ
	 faC4ODIl0npJVT3V0OWs3pT3IoKXtY1nsOrrFb7dwFnm7qrlXz1/FXj0jgqK48CEX0
	 4NQUDt71ib+EHavWMWFk/8RSKDIFT73HQTmanx/jRKGjXYzvmuBeqvr7q0LND3yKoM
	 6ZUGe+SW5S5rw==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu: Set rpm auto_suspend once during probe
Date: Tue, 11 Mar 2025 18:58:14 +0000
Message-Id: <174169939662.2778071.15739701856467094472.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250123195636.4182099-1-praan@google.com>
References: <20250123195636.4182099-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 23 Jan 2025 19:56:36 +0000, Pranjal Shrivastava wrote:
> The current code calls `arm_smmu_rpm_use_autosuspend` during device
> attach, which seems unusual as it sets the autosuspend delay & the
> `use_autosuspend` flag for the smmu device. These parameters can be
> simply set "once" during the smmu probe and in order to avoid bouncing
> rpm states, we can simply "mark_last_busy" during a client dev attach as
> discussed in [1].
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu: Set rpm auto_suspend once during probe
      https://git.kernel.org/iommu/c/0a679336dc17

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
