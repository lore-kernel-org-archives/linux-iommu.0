Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5733991;
	Mon, 14 Jul 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490831; cv=none; b=PIzES6XGoxkjvrEVm5t47psDojqp0WyizwPnJ0qpuQ0wP77hoP1rNLq3Ne0xE59T3NzaYNvB6favuMNeYiraMujLgoMemwnk1EQPU7K5yiScKB9peSIFJahuxf8REx9s2C+fID0K/Udzb/1j+UncOIumd381HOGZNx4dgfoPH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490831; c=relaxed/simple;
	bh=xBgxSX5W7eh2nrFArSvAk+eWv8Afh7jkm+q2VKe1ppQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/4IcY8dX9kguR6oGj8YZTumHwQMCTlUdZ191tMKfBD9vN3YFk4v1F6hEgZAxQ1KVu/mdo/LVkPDQ7+vcnhJ5tLfDszNQc8ah0HSloPQwAhZ2nl/hodoGYSu0s30qrVGV7VQyY6yGLmhJt2UGMgpJIc7MNeAWQaS09NqxbisuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6o//h02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6o//h02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FA2C4CEED;
	Mon, 14 Jul 2025 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752490830;
	bh=xBgxSX5W7eh2nrFArSvAk+eWv8Afh7jkm+q2VKe1ppQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6o//h02FZweK95SYUlj1VcRa555Lqtzy+m0eefsyMOKxpERpf1zPg5oyAjn2v8nc
	 btj5QGQsSHUpKTgNismCjpU3nrecMxtZwh+FTb4+MRbdeXFMMLN9rgin+dFuf3B0jY
	 0+uMkAa/gU11plwe/vFcatrhalha48uD6RsxM2gyIn1UeqeS/FpDCIO0MxCfrUOkNt
	 O5jjTqf1S9D98iC8UeQLm47jyoZffvLaHpDBgvncl1f6hds5VnfwsEHggporKbfnNd
	 +01Yj/WzE+eEfP0ovXf3QsvdDu+q+5nscQ1tEpcoDAeDhB82nXPJ6t7iWcWWsavkLc
	 aAg0q4U5knCdw==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] [PULL REQUEST] Intel IOMMU updates for v6.17
Date: Mon, 14 Jul 2025 12:00:20 +0100
Message-Id: <175248828553.1440119.11730625265073885463.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 14 Jul 2025 12:50:17 +0800, Lu Baolu wrote:
> The following changes have been queued for v6.17-rc1. They are about new
> features and code refactoring, including:
> 
>  - Reorganize Intel VT-d to be ready for iommupt
>  - Optimize iotlb_sync_map for non-caching/non-RWBF modes
>  - Fix missed PASID in dev TLB invalidation in cache_tag_flush_all()
>  - Miscellaneous cleanups
> 
> [...]

Applied to iommu (intel/vt-d), thanks!

[01/11] iommu/vt-d: Remove the CONFIG_X86 wrapping from iommu init hook
        https://git.kernel.org/iommu/c/bd26cd9d815a
[02/11] iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes
        https://git.kernel.org/iommu/c/12724ce3fe1a
[03/11] iommu/vt-d: Lift the __pa to domain_setup_first_level/intel_svm_set_dev_pasid()
        https://git.kernel.org/iommu/c/cd0d0e4e48d8
[04/11] iommu/vt-d: Fold domain_exit() into intel_iommu_domain_free()
        https://git.kernel.org/iommu/c/00939bebe51c
[05/11] iommu/vt-d: Do not wipe out the page table NID when devices detach
        https://git.kernel.org/iommu/c/5c3687d5789c
[06/11] iommu/vt-d: Split intel_iommu_domain_alloc_paging_flags()
        https://git.kernel.org/iommu/c/b9434ba97c44
[07/11] iommu/vt-d: Create unique domain ops for each stage
        https://git.kernel.org/iommu/c/b33125296b50
[08/11] iommu/vt-d: Split intel_iommu_enforce_cache_coherency()
        https://git.kernel.org/iommu/c/0fa6f0893466
[09/11] iommu/vt-d: Split paging_domain_compatible()
        https://git.kernel.org/iommu/c/85cfaacc9937
[10/11] iommu/vt-d: Fix missing PASID in dev TLB flush with cache_tag_flush_all
        https://git.kernel.org/iommu/c/3141153816bf
[11/11] iommu/vt-d: Deduplicate cache_tag_flush_all by reusing flush_range
        https://git.kernel.org/iommu/c/e934464e098e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
