Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C18442C;
	Wed,  3 Jul 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023229; cv=none; b=Wu+cnN7HlbQSf+JHF/xElWB2IsNcOXT3Csx/Nshu5N45oQkwVE8/rN2GYmAV7mT+yYIXlJkzBCS8lSpUgvfjM/k/z7I6fOsiNLdHwcrXvaOsQ2YKNEDpzt1ZkgGaYck9H8X5u3/E3e0wrsGBzy7mm5MI+mHBnpITjJZelkf7VT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023229; c=relaxed/simple;
	bh=CP0YPCf3KiiDCDFmDjQwYPh5LIGF7oMy05isbiaBdvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4hecpgvVmWyTGw9e9hAlXbzq5cwZM45KlSc+aaWlsWxh3UvQSi2VtzgLWg2doLH+xMYsnfjey51mbpKZ6JHmnsBJHfTSuhwB2Y9v/zsmqg4YyQ0CI/cLSVPkbepIhenUNj7qvf+jvEHhDqo43ARzuTIEnJ61m4AV57pQC+ncv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsIpIff1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsIpIff1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85110C2BD10;
	Wed,  3 Jul 2024 16:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720023229;
	bh=CP0YPCf3KiiDCDFmDjQwYPh5LIGF7oMy05isbiaBdvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsIpIff1ACJ8p1LzszqupWfvZaJyDhY34HeSOhNtDdu9T2qizwTRdMmm3kl34gKq6
	 8NcDd/+CbLaR7/hAysCTBBD2TXXuOgY/+5gPlkYM4xcY8Uc3IGZdQbSfwHHSCoEnGV
	 GCS/Nbjicnh1s5INkPX8Iz/zc5auxcx8qjVfeCJKXNjSfO7xc4oyp5HYBlePnx4IXk
	 f0i05er1aF6x2a6N0jHfU19thskg4IqmfmE9GK+aXp0xp1bGLKR52DEdS/MNNTCSfV
	 h01r4SA7Zee5b5qH11RpIetEHQwSJOh3T4LmF0/qe0EmJWwI0AO44D8tq2EYnUb3HK
	 AuCQH1HtTA+DQ==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for v6.11
Date: Wed,  3 Jul 2024 17:13:36 +0100
Message-Id: <172002116723.1869749.5235762901047952982.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240702130839.108139-1-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 21:08:32 +0800, Lu Baolu wrote:
> The following changes have been queued for v6.11-rc1. They are all about
> small refactoring, including:
> 
>  - Use READ_ONCE to read volatile descriptor status
>  - Remove support for handling Execute-Requested requests
>  - Downgrade warning for pre-enabled interrupt remapping
>  - Remove calling iommu_domain_alloc()
>  - Refactor the PRI enable/disable flows
>  - Cleanups
> 
> [...]

Applied to iommu (intel/vt-d), thanks!

[1/7] iommu/vt-d: Handle volatile descriptor status read
      https://git.kernel.org/iommu/c/b5e86a95541c
[2/7] iommu/vt-d: Remove comment for def_domain_type
      https://git.kernel.org/iommu/c/5fbf97371dc0
[3/7] iommu/vt-d: Remove control over Execute-Requested requests
      https://git.kernel.org/iommu/c/e995fcde6070
[4/7] iommu/vt-d: Downgrade warning for pre-enabled IR
      https://git.kernel.org/iommu/c/804f98e224e4
[5/7] iommu/vt-d: Add helper to allocate paging domain
      https://git.kernel.org/iommu/c/2b989ab9bc89
[6/7] iommu/vt-d: Add helper to flush caches for context change
      https://git.kernel.org/iommu/c/f90584f4beb8
[7/7] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
      https://git.kernel.org/iommu/c/3753311c9190

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
