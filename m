Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB13C345F;
	Thu,  9 Apr 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739699; cv=none; b=qeHgpV6opLsGUm2ljmMiZ/i6uSJ2CZRIQyDQ53txGSveCx714//wLJ9VGlJpW+v1rqwI+VwmE04kyxWGNanVW3HrP9WL0eJnwwACuxZlmTQOXH4Z5CPILfcTVqjJT98VFY3B26lRevfAMKojadpz+vfBJxIX2X1XeGoQKKGbNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739699; c=relaxed/simple;
	bh=ErkqhB3XTMjrXF4/gzU2lN8NYsLR+G/xAykedOQYTWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNB1dldEmbuNXnOYagHWCtzZT91fyZ9zIt5/ccrxJjkmT6hbQOFlkJ8ZfWziACcaA4mXOl+m5qCTdW8LHsI4k+aFKLbQNAXj+7rukKPZ8SFwHsC8+CkEEZBSb2csXYz9lUDFVKJsqB4N2FpYcq8WMdGjvktrnSOJb1encsoxij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj9lkDOg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj9lkDOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A923C4CEF7;
	Thu,  9 Apr 2026 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775739698;
	bh=ErkqhB3XTMjrXF4/gzU2lN8NYsLR+G/xAykedOQYTWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oj9lkDOggpSM+xgiDGOL6MqaD8/1lWr2YS8pZKVJ1zkE/btZcxKND9Jf8EnMcnl8P
	 UdnB9dxBSUahU1bFvvYEo6UxXzyrQEGbq+6f57whWhaPFI0OON4+ptSzB9c6+mMQig
	 NG0Ljdxnm8MQ7aGq6PuRy3GJjmKpULO1N1bE2pkef6UzYM/vS/qXRRYrO46R05XImu
	 lT/gjPwDKB1KhMcv81FVtkzpWCOrVgS8CRuYqhsQOsTMy8zRzz0C+qX946kf+LC7hW
	 b/KNbLWRQtv9/X8XHDVt2iAng2F8dS3QJKdJaApO7iV9MzLppJ5nqqbfSDNujOIalU
	 IdDcpph9uA6Dw==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux@armlinux.org.uk,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu: Ensure .iotlb_sync is called correctly
Date: Thu,  9 Apr 2026 14:01:18 +0100
Message-ID: <177573643352.3408469.5575202206607092720.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8982e3412563cf91e106d59228dfb6115024c75e.1775659257.git.robin.murphy@arm.com>
References: <8982e3412563cf91e106d59228dfb6115024c75e.1775659257.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Apr 2026 15:40:57 +0100, Robin Murphy wrote:
> Many drivers have no reason to use the iotlb_gather mechanism, but do
> still depend on .iotlb_sync being called to properly complete an unmap.
> Since the core code is now relying on the gather to detect when there
> is legitimately something to sync, it should also take care of encoding
> a successful unmap when the driver does not touch the gather itself.
> 
> 
> [...]

Applied to iommu (fixes), thanks!

[1/1] iommu: Ensure .iotlb_sync is called correctly
      https://git.kernel.org/iommu/c/7e0548525abd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
