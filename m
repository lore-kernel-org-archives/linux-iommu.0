Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13C404BF7;
	Fri, 10 Jul 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681153; cv=none; b=A00fWynjG03tV2YuFY5+jZB0lllLFAHuo4Q+Rnqiz7ljN+UtaRFdNcHFNzUPCreARkuc1W9KHe47wj/clOc9N5pIvTqA88GLM+yOX7vnDC+yZCi/xNU+xKMbxiqSij8Ay5BPEU6OFE4J71V6muj0/1nKhAokThDIaCnzcr9O1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681153; c=relaxed/simple;
	bh=YOZCqdl3/prkqlqpf4NARQ34TCVzB8ENU8IJ8UvVifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQxv+ZjzElsxvp8S7YKebDJ2+2uSRCe4PqiKlh+/W9BxlMj4qg3NCr44mji9EETO8JPtx1vOl9Nz50VBOitMAHs7Pcjr3hlFguyGSvBmqg5GBnYnfDBaCGbRrM/6iWknvqwEkesZLO9IoMkIfqS6Ef0LPP1yPZibuHNy9pEgSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9g6X6+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9g6X6+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E151F000E9;
	Fri, 10 Jul 2026 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783681152;
	bh=5RU9jyjDZ8CdKycZTW5Y3nd2HKxIX/CGf0uN/C8vm+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P9g6X6+0ZpBoxkWrEIPnYP7a0wV0jlT9aNYx2hiN7f48ci5qgfUf/pmMKIB/RhAZz
	 x76HOdthYnWeGnTUFEl+ro1rVO91zyXkMcz8Bfc0tbz+LMO5eP8rqdt8vVzQSXdt9O
	 gVUet8ZrEBnk0eLUYMSZSUla4dpRkJwrRj1GKz7wvdfOHTp4xMb+fehqUEQI+DjDLi
	 PrXR9oSeqIjDPlC7+h+ic+ZLoPayy+GW5B1calYkaNSIfjfPlB1YD2Evuq0yXq/zmk
	 pCfYXxLIT8qQrgO/LgzHVbIlXNxVr53ykeAYX48q75LX3n1TMIwhXYX+ppJo8J/w77
	 QUgWiBsBD1PDQ==
Date: Fri, 10 Jul 2026 11:59:06 +0100
From: Will Deacon <will@kernel.org>
To: Jiaxing Hu <huhuvmb88@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jgg@ziepe.ca
Subject: Re: [PATCH] iommu/rockchip: implement .flush_iotlb_all
Message-ID: <alDQevX58XvdRcWc@willie-the-truck>
References: <20260710060513.863714-1-huhuvmb88@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710060513.863714-1-huhuvmb88@gmail.com>

On Fri, Jul 10, 2026 at 06:05:13PM +1200, Jiaxing Hu wrote:
> rk_iommu invalidates the IOTLB synchronously in .unmap (via
> rk_iommu_zap_iova), so it stays consistent without a deferred .iotlb_sync
> and does not advertise IOMMU_CAP_DEFERRED_FLUSH.
> 
> It never implemented the optional .flush_iotlb_all op, though, and
> iommu_flush_iotlb_all() is a no-op when that op is absent -- so on Rockchip
> a driver that owns an rk_iommu domain and calls it to flush the whole
> domain's TLB (e.g. before reusing a mapping, without unmapping it) gets
> nothing, even though the hardware can do it: rk_iommu already issues
> ZAP_CACHE for range shootdowns.
> 
> Implement it with that same primitive: ZAP_CACHE every bank of every IOMMU
> on the domain, under the runtime-PM + clk guard already used by
> rk_iommu_zap_iova().
> 
> Found while bringing up an out-of-tree RK3576 NPU (accel/rocket) driver
> that flushes before each submit; on Rockchip that flush did nothing.
> 
> Signed-off-by: Jiaxing Hu <huhuvmb88@gmail.com>
> ---

We tried to get rid of iommu_flush_iotlb_all() in 69e5a17511f6
("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
but we had to revert that in a33bf8d8ce7e ("iommu: Restore
iommu_flush_iotlb_all()") because of a user in the MSM driver.

So I think this is the wrong direction. We should try harder to remove
the function rather than add new implementations of it. I'm assuming
you're only adding it for some out-of-tree code that calls it?

Will
