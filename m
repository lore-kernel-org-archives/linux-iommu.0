Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250942E613B;
	Wed, 23 Jul 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275181; cv=none; b=h+6WeKvPDJLLRH8tRfNn07H+jjysXlzuBGyP/j+CRD/Xxae/TDe1XlF+Z1hTZAOsjQxnMVTpM7UJ94MLCOmySuQzfWlEa2Fx38mDQ4rHGoIa3YFPz1i1gz6ftNnSynPsDAWtbH2bTOGtqhT/uQyduYfGrF73N9CzmcsaQYrAtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275181; c=relaxed/simple;
	bh=BRav3W1Z7hRZUC1/wwtIAWRC+cy+uVsTJqWQpxOKOcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J03Pwdsvbt5oKk53GzoelMviW7k+pZwXYgSLV0658hu1Yh5++3HUDrVp5zEPqV3IVfmeYRHbwMXwJYBa5dIT2OHMi1npYmbe5aewRIn/GCEK3JBmKwsRobYjyKAntYBUkyVlVRxMqlIU94ADlqTC3ezxp8MKjtYcGgE8bm0Mhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiCihPwP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiCihPwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846F5C4CEE7;
	Wed, 23 Jul 2025 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753275180;
	bh=BRav3W1Z7hRZUC1/wwtIAWRC+cy+uVsTJqWQpxOKOcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiCihPwPYpPd1aSdaO0DugkbhijhVUCMpHOMGL9gqAb+rS8dpTvk8AH2PZy1OiipC
	 Di7nEoVTYlywS02y2NIjmszFHLJAlSYDauIvUi0l2dDzH+L7Ngf4YPw7JR9eXLqiMT
	 bAY4hzCbpVqz+YNt3Bjg+LmoRl7tXdbOwfI1mVov+tpGwI4MysAoikUuugb8RMlFx9
	 Ch+I8VNwbKN84uMaMs6A/qx3vq2V+zMccRE9iluSXCBSlIf7csOcEBA4Z3R5wVPPDA
	 xUvYvHTu+1c6EEvCDYiqtIxCm2L88fe5U3I4PnpWTm7KHPu9cCXVuau34YGIsVh3wD
	 kZM0qxAVUIVkA==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ethan Milon <ethan.milon@eviden.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix UAF on sva unbind with pending IOPFs
Date: Wed, 23 Jul 2025 13:52:52 +0100
Message-Id: <175327211759.77634.8242308703852038544.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723072045.1853328-1-baolu.lu@linux.intel.com>
References: <20250723072045.1853328-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 23 Jul 2025 15:20:45 +0800, Lu Baolu wrote:
> Commit 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach
> path") disables IOPF on device by removing the device from its IOMMU's
> IOPF queue when the last IOPF-capable domain is detached from the device.
> Unfortunately, it did this in a wrong place where there are still pending
> IOPFs. As a result, a use-after-free error is potentially triggered and
> eventually a kernel panic with a kernel trace similar to the following:
> 
> [...]

Applied to iommu (intel/vt-d), thanks!

[1/1] iommu/vt-d: Fix UAF on sva unbind with pending IOPFs
      https://git.kernel.org/iommu/c/f0b9d31c6edd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
