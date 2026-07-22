Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866224457A7;
	Wed, 22 Jul 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756423; cv=none; b=pCdaaZ8CLKq6V6uQFVZqCmPrTmW3JrMtl+u+AEuONeIXuXldYyMC5Nz+TpJR/OlwIqBbDMaRyVh0Y08GTqvwqzZYoBdgPowxXsLtBM0HRWFLbs/EEsyoPC+wgpvT9Ly3GKof/HMkpFqc9k9wZwXoYlKwX2hN/wWpIGS8eLlSXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756423; c=relaxed/simple;
	bh=0ps2TbuGQzLAxzzNGQ2T0kgdpgzyuCGvfkqmTmKwnPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+k/TuAcdmI59TWvjBCLcSgc68TnGv3IpiiKLmRHG+6HLPeAw7UNBSOvh5u5sNA7a0y4Dl89+AqFTlftmgXbu1k/p9YirVpmphkMOexKhcW9l5phO6ZGCI2xHLJKEOkeBNd1Trr6igerIIarZ0m7Ut1KQEcSyHMx/Wo8ULfDGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsxSfqqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsxSfqqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8255F1F000E9;
	Wed, 22 Jul 2026 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756418;
	bh=YLBLkO3ZQoZMlC/tPHSeXWmswMsTjNkljwGg5hBLKVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XsxSfqqIzfaV9Vwa6XccyjNRzIWbQbrUxFe3aoOLJ1Czi09FcZRODEegTP70WW5Lk
	 zo2YDIvUWACJ4HHj+wQ0vW+moD69bWw//uGnxZI1aqNYgAB+xqoJolyGVuLjSCwway
	 dg0P6kEQXhj5XrlbSQTeolyBvd2FtlVlqg3+iKUg5qvjU+P+7YndM1DebMl835TXoF
	 P9YI3IvrW6DubLrBsH21mGUwp8ZKnhL27IbaLgPLHZO7wY9jl/OUvOi5Kmxv4j4AaN
	 78tP3TjlER0nx40Ca5HmB3CjxyLXYR8KBCSUFms+PGYms1WE/jLtqgP9MhUGtkwzp6
	 iJCoDbaxBMlHA==
From: Will Deacon <will@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Alex Williamson <alex@shazbot.org>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iommu/qcom: Misc Fixes
Date: Wed, 22 Jul 2026 22:39:27 +0100
Message-ID: <178472567878.2875601.1864864907076566245.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
References: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 20:16:02 +0530, Mukesh Ojha wrote:
> Series to address fixes in legacy qcom_iommu driver, it is based on top
> of  https://lore.kernel.org/lkml/20260623071245.1985938-1-haoxiang_li2024@163.com/
> 
> Changes in v1: https://lore.kernel.org/lkml/20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com/
>  - Used devm_pm_runtime_enable in 2/6 as per comment.
>  - Dropped 6/8 and 8/8 from the last series.
>  - Added R-b  and fixes tag.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/6] iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
      https://git.kernel.org/iommu/c/1f33b8208a19
[2/6] iommu/qcom: Use devm_pm_runtime_enable() in qcom_iommu_device_probe()
      https://git.kernel.org/iommu/c/bf69e515b180
[3/6] iommu/qcom: Check pm_runtime_resume_and_get() return in probe
      https://git.kernel.org/iommu/c/e910315ae08a
[4/6] iommu/qcom: Fix pgtbl_ops leak in qcom_iommu_init_domain() error path
      https://git.kernel.org/iommu/c/3c748a5554f9
[5/6] iommu/qcom: Publish pgtbl_ops before releasing init_mutex
      https://git.kernel.org/iommu/c/a05b67cd45ad
[6/6] iommu/qcom: Enable clocks before hardware access in qcom_iommu_ctx_probe()
      https://git.kernel.org/iommu/c/cb776a03a534

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
