Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FB8BEE;
	Tue, 10 Dec 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789864; cv=none; b=W2LhnZWcGW1pvbobKjZSJPX0O0yxZErs5fabQKPpUI2ys7DSrWJ00V4ScJd3hZvj2sJMxa4ekOkCYbrDIV3Mo4NDFr1em5V7f3i4P1LIUng0hxO5LUw32/H40ivKxhoxYvDPYwSoXNPNc2YdCitz7amhdUJmnlige7kruY3TK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789864; c=relaxed/simple;
	bh=Ic7pQ6LFiHXt2WB/ccfFedVbtDdhbJCjtpNtWFW7Hv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxEgrWlcDKofuan3YGd/WAFei1EJP0rR0L1tSPkg4I5jJ2NMI1kmsOWLRHk3msoxgrcoj1gInHL3b0WCswL78vaZVBVHuCsPoLKuKAWMRpRp6wTU5gToT2/Z+qVj/aNy6UsonTHOFmpSRFitQ2ejm4O1l58J4l7HPx0ihudR81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsLnSa+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsLnSa+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B4FC4CEE1;
	Tue, 10 Dec 2024 00:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733789863;
	bh=Ic7pQ6LFiHXt2WB/ccfFedVbtDdhbJCjtpNtWFW7Hv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsLnSa+kTuZstB4a0MCCjDVlb9Aw5v5GLa2QCZNUie4W5WfvA4TBDCS5iaEIooPPK
	 JIR1qOmLAgNI3XSoNqrcxCZuWTRSleD35V8mXgEKXNJXdeTpZuncFRSI6H2W8GVzJE
	 A1RCMrbJsamp3Xa+w2WMYiC/+5RpHKZhmbjuDR2D0XNFlTVzwboaPmu2DQLH+VypEi
	 xCvpkVEfbp0Z+EgQO387qr6Xebv45C9SeetLLFoourQcLqtIRsGPlKyFtjcU54RvGP
	 I856sozAvHe5F5BHRcod4RO7mmj6IHN8jn5nd3FYyCBvZY8LjhmCnVCQA8qZohz3/V
	 CbLqsN+5rsbbg==
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] iommu/tegra241-cmdqv: do not use smp_processor_id in preemptible context
Date: Tue, 10 Dec 2024 00:17:28 +0000
Message-Id: <173378751166.2164111.11293401851587446576.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <Z1L1mja3nXzsJ0Pk@uudg.org>
References: <Z1L1mja3nXzsJ0Pk@uudg.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 06 Dec 2024 10:01:14 -0300, Luis Claudio R. Goncalves wrote:
> During boot some of the calls to tegra241_cmdqv_get_cmdq() will happen
> in preemptible context. As this function calls smp_processor_id(), if
> CONFIG_DEBUG_PREEMPT is enabled, these calls will trigger a series of
> "BUG: using smp_processor_id() in preemptible" backtraces.
> 
> As tegra241_cmdqv_get_cmdq() only calls smp_processor_id() to use the
> CPU number as a factor to balance out traffic on cmdq usage, it is safe
> to use raw_smp_processor_id() here.
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/tegra241-cmdqv: do not use smp_processor_id in preemptible context
      https://git.kernel.org/will/c/1f806218164d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
