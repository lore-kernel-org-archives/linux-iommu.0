Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8F182A9
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="j/fJPukF"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3F8271A4B43;
	Mon, 27 Nov 2023 11:08:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701079699;
	bh=a5Q90jhb7WwY91YW7qzuQ3VTxn7Y9EAZQUEWt8Pn0Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/fJPukFYTdSfh9qO7Dw1Plj8ENkBKECGtTOBehE1t4uejf+u9sIURyDIwA03XjEg
	 for+4tYl//BXuZn+dK8EfH37sUYtRc7DhaBPho9tW8/UH2YQqj04lVjtnk8uVyV76X
	 N5itxVEBiVD7Hday8WP/i6pTrmtNoTGfAiydVfIj9bpRltcpD9MrQTreGsgng8MsZT
	 2L04dpW8ndx3C1QpmUMwSgaqXuYiGRyO2iwx1p0qn6J9OkzTweYge1YAiQekWD0Wpy
	 xj/EBMM5+vecwzFyzezxIVXNdJQ7Mz2F3sJDe3yJ04eL7CygWbGR2+gSdakkM1fyAw
	 y4d0MQdSVQfxQ==
Date: Mon, 27 Nov 2023 11:08:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: mohd.syazwan.abdul.halim@intel.com, Kunwu Chan <chentao@kylinos.cn>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] [PULL REQUEST] iommu/vt-d: Fixes for v6.7-rc3
Message-ID: <ZWRqkkHgdj9W_xlT@8bytes.org>
References: <20231122032608.165144-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122032608.165144-1-baolu.lu@linux.intel.com>

On Wed, Nov 22, 2023 at 11:26:01AM +0800, Lu Baolu wrote:
> Abdul Halim, Mohd Syazwan (1):
>   iommu/vt-d: Add MTL to quirk list to skip TE disabling
> 
> Kunwu Chan (1):
>   iommu/vt-d: Set variable intel_dirty_ops to static
> 
> Lu Baolu (5):
>   iommu/vt-d: Support enforce_cache_coherency only for empty domains
>   iommu/vt-d: Omit devTLB invalidation requests when TES=0
>   iommu/vt-d: Disable PCI ATS in legacy passthrough mode
>   iommu/vt-d: Make context clearing consistent with context mapping
>   iommu/vt-d: Fix incorrect cache invalidation for mm notification

Applied for v6.7, thanks.
