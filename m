Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F31DF268;
	Mon, 21 Jul 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108560; cv=none; b=m26H7jVaEGcrs73qLP1fBTERSPKQPEv+ZoCSpjtVVUBtZ+exh06bw7r1GS/T5gWwDGaF3dENk1Rleu/T1pukSHlFhqZtuChGq8m0zF7Y9u5z2umPGEWP563n1dToG+sb5WOoBX9hDZvHas3VdZNTPMCOiPD4xFiDBzc3EpjXrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108560; c=relaxed/simple;
	bh=dR+6XIT6LFnOdsN8pxrdfpEwQ3vQJS/jcc6mHH5oFko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thVGNSJPNZvIko73vLXe33ff11pEPlSlYrU0UpAiTMBbdAsYxbNJToyYWcCpVyHLsCyz0kZX7+oRco2tR3LNp0sCgIW8Z3eol0eZ5Z2HwCeJa8a+MC9J6XI2o492RtMQsu7SZkGjQ982VbddRXBZFZYPOtkS6I9cDZYAT8cOeXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqNJre2h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqNJre2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C019C4CEF6;
	Mon, 21 Jul 2025 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753108560;
	bh=dR+6XIT6LFnOdsN8pxrdfpEwQ3vQJS/jcc6mHH5oFko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqNJre2haC3CW+s2Ecyc3X3hhugTWweTM0X51OLx+zSq3NnXvL0Ahm9KjbQ8/e1JL
	 NRiP/LN62x/0ZQLmkpS1Tng6xt5UViXQVKFCLyvoICDuvY9OL5cJ8RTLbMtuhOx5Ic
	 6O2ikguiqETjR1LWHcufHt5tph13Js0SFNHrbg9gNhcmoahwT20YHhqGiTpUHH65AI
	 2s0MncLdD8a0L1bvnNam5a4dVVW3NBjYy6pOuy9pcHN1co4lV1rO8WPgYgu9nMa3HT
	 0N4s7RV5Kx08ZMQzKxGd3SpQb7rf3rksGaS8Ba8QklC4Kyk7BMjp8ufMhjvDpZTBDO
	 BmixEqB+0kZgg==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Make iotlb_sync_map a static property of dmar_domain
Date: Mon, 21 Jul 2025 15:35:50 +0100
Message-Id: <175310434713.3742315.9773080738020754231.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721051657.1695788-1-baolu.lu@linux.intel.com>
References: <20250721051657.1695788-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 13:16:57 +0800, Lu Baolu wrote:
> Commit 12724ce3fe1a ("iommu/vt-d: Optimize iotlb_sync_map for
> non-caching/non-RWBF modes") dynamically set iotlb_sync_map. This causes
> synchronization issues due to lack of locking on map and attach paths,
> racing iommufd userspace operations.
> 
> Invalidation changes must precede device attachment to ensure all flushes
> complete before hardware walks page tables, preventing coherence issues.
> 
> [...]

Applied to iommu (intel/vt-d), thanks!

[1/1] iommu/vt-d: Make iotlb_sync_map a static property of dmar_domain
      https://git.kernel.org/iommu/c/cee686775f9c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
