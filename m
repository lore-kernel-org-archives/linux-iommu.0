Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376576FBB
	for <iommu@lists.linux.dev>; Tue, 10 Jan 2023 11:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E67C433D2;
	Tue, 10 Jan 2023 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673349054;
	bh=XhcDIdamWlk8EP3uFzZmuFirRRVx4AkOTeNQJtnlEwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGur0OOJqRfo8MpHsMEOzXFbs+nDkkzR7dySApVpVxLf8DO7rMjcPatK6WkVVIZgO
	 B5Q4WM+jYB41tPALdRNFgSppw3JjVbbceoM/RMypOAnrodkwtnVc4GdPbkH8Sjgdi0
	 UGVPfCFRB3pI6MdKJyvg61xmJH4BLE8+Y5dgK0YNp/XsQ8HnYHwJ+hKxPpxjyidVcU
	 /IxtBbdZ2ISR2mF5jHqbI8P+1Wp2J/zoTR5kKs9T3H3ZxwtlK8dlyPYrnyT5VnGM90
	 Obf9WFG50rfcwWARLeSmwKgxZ+9rA0bRt1azFehaIbXJp4/XwyN0hd7ZIjhnbMFB2/
	 m/BV/ha/xE1vw==
Date: Tue, 10 Jan 2023 11:10:50 +0000
From: Will Deacon <will@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even
 betterer
Message-ID: <20230110111049.GA8986@willie-the-truck>
References: <d6dc41952961e5c7b21acac08a8bf1eb0f69e124.1671123115.git.robin.murphy@arm.com>
 <20230110105625.ououvyfj2g6ttkmf@skbuf>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110105625.ououvyfj2g6ttkmf@skbuf>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jan 10, 2023 at 12:56:25PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 15, 2022 at 04:51:55PM +0000, Robin Murphy wrote:
> > Although it's vanishingly unlikely that anyone would integrate an SMMU
> > within a coherent interconnect without also making the pagetable walk
> > interface coherent, the same effect happens if a coherent SMMU fails to
> > advertise CTTW correctly. This turns out to be the case on some popular
> > NXP SoCs, where VFIO started failing the IOMMU_CAP_CACHE_COHERENCY test,
> > even though IOMMU_CACHE *was* previously achieving the desired effect
> > anyway thanks to the underlying integration.
> > 
> > While those SoCs stand to gain some more general benefits from a
> > firmware update to override CTTW correctly in DT/ACPI, it's also easy
> > to work around this in Linux as well, to avoid imposing too much on
> > affected users - since the upstream client devices *are* correctly
> > marked as coherent, we can trivially infer their coherent paths through
> > the SMMU as well.
> > 
> > Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Fixes: df198b37e72c ("iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY better")
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> 
> Could someone please apply this patch?

Sorry, I missed that this was fixing a recent regression. I'll pick it up
today and send it to Joerg.

Will
