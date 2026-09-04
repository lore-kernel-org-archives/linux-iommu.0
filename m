Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B94A4400;
	Fri,  4 Sep 2026 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532136; cv=none; b=IbSNjeStPEKg/L2sC6KEaLISBRz55EOb5CKV+XRlHe+UXR/U7LkiCan3DHlhf6+WiQaPof58F2pi458vpbR9r0nXTWTi9gHhF3MKvFOvRWn2MAKKITjKD4HxovSWo7XTXLZk7aZnvxVzlKZIAM59+sCkLpZKOq4PF+11/NySw+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532136; c=relaxed/simple;
	bh=wSQemCFCiqVU69NXdbPd4wypfK+p45deY/8qdwGvdFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1E55vjPcRhw+HqS/KvvKFRVKtrj7y5krrE1RAnjcR83lzyoMBheiYjWkWH7nCjJETdhZWl/MdLvGk73hHEso8IVlzRVb3bXZkSNDyRsKWu4Kh42wGqwGd4pXAMxEfMMJU8qMkS8xiptuU52e5F7IDtlaZpCFdyJHJvLvrmaA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiP03wY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiP03wY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92881F00A3D;
	Fri,  4 Sep 2026 14:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532134;
	bh=NLEFODUwUBfJQO7Bd/vsMIMorLr0ppUQg6Fq2awBDR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BiP03wY816dLqcLK7qIDl62DSUpC6/Yq0LCyQCe3+5ZyP8YJ/KlSjAY2yHMb1SsXq
	 vRo2J7qLwdKVBQ+VghaTdMzlv1Qz8S7VwhjpHYh3peD7PbmiZSNYL+Z7Gg1gQpomA4
	 H9A6ZroaF3mys6b/hdwN3oE6wFKneqP/p6KKLK1CiTgSU5nNAwqh3lNUmpF+zl/0bS
	 Jw/XXcOybL66CFEZ23RqhI4BWltW2XNwmiROcbm6IzPxNKSJ+y0gj+Lrjrr5pyFKhQ
	 i7n2UhAiq261mNzIHvjSqug78P4qvu2oBTe3BKYtEgUCCkDsqAvjy0XyQlLAhllvDE
	 q4jma5enKTIQQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id A3505198003A;
	Fri,  4 Sep 2026 10:28:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 10:28:52 -0400
X-ME-Sender: <xms:odWaapNSEQ-G-0TcsARK7cXK7oNOiTgZlzm3-mB8hD9Gb5wDP1YtZg>
    <xme:odWaarPbEPM1vS6MwXLSegErlLyh-2lQY0ubYV3yXqP8wy4tkji5YA7IGhcdiHeRH
    bUxcpGwwwvF8sFr9vvadDHg2RrCuZwd26Th7r8_pst65Sb0aZphWXzM>
X-ME-Received: <xmr:odWaakfy9KQsmKfHX0ttenZA80rYp5ru4g_BJmKN5PzONa19y4VwGcSyUoI>
X-ME-Proxy-Cause: dmFkZTEbzP5C75qSSNyFWsCoMZ0dLuj2B5LNrXHLD6OHdyNy1GWXodF7g9M/ipkYbP+JZS
    haFZodY1i86dLB35wwWDVpkFALS48B8BKG1UTVK/po8O0WYyhoHs7d5m5K6dbyth0u6uxB
    t3JsHT5Tw/i2nhALa5IzwHvm8q+WaNTAfriWw/2g0uiyoa/PbzbaSgkSKl1YBykK9wpb7Y
    Vd3LJbBVSm7+e6N/RRMw2FZxIm3joVNZFTtNO8i3QRb6+KzRdZf+2QOIsX7dGZR9KmWJOn
    xkLK3veBz5e1aX87MRy6sousg0QNYEANoIBMuHojt2lGjwXyFdy1UqlgxCfb5YAPc03zmD
    f7o7Q0a3uTUYqApeTvV3IYGNpMcsWv8n3VBCzB2R9ZctBP4qDAOBp467NyOjlUUXaikvVn
    fqRv02Ec+wx0d3ZlkmXbnVUyKdlahhH0m/pY1XMiQp/MzQc36PmfxSzSag5Rb08+bNBzzy
    Ype+H7n7HEpX6lIsWxtKyZzPMBntXd5HjczJS01SOhLla7+pLTySWjAsi7V5Wb0ieFxqIF
    JgZajoTQjrri9dbmWa90hYRpwsFgVALh7jtfzDLrvqP+PUcinztMku2QVnFUYXw9g5Ypjn
    xASbTUjB8GVIdc6VhI1V2OGXWUQ+HkZQMMkscIFYLENEAvHm6yVyBlnBVI6g
X-ME-Proxy: <xmx:odWaagcrXNVnL9sxSWXRGLzRgZCWOrtmWr1YLRQBB6_TF5MCrzqCrQ>
    <xmx:odWaakdIn2AUoc5ByfKy2rLkut9R9_uBqR2tsphmjuaJIWL8V4shtw>
    <xmx:odWaahmvdJCPXbECUv958ulsQzuLGc7OlAUyuqpp2vBgmbc-3XYufQ>
    <xmx:odWaau4JvJxEI6CMm3Xkt--lMY4lU7Ok2B4lHIsA3kENGLqaYTJMoA>
    <xmx:odWaahtWz6vOpN4OOsjTeSzLgx_6p065ojXS1hRxIU1Q-wciKAIOsx6I>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 10:28:48 -0400 (EDT)
Date: Fri, 4 Sep 2026 15:28:47 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, 
	Usama Arif <usama.arif@linux.dev>, kernel-team@meta.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Add a cmdq_entries module
 parameter
Message-ID: <aprVfyn0BFoL1rx8@thinkstation>
References: <20260902121724.3494954-1-kas@kernel.org>
 <20260902121724.3494954-2-kas@kernel.org>
 <aphbV1FSoop1YGOQ@nvidia.com>
 <aplvJIuarj_ZrAx9@thinkstation>
 <apmNw4hMrkYqyD3j@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apmNw4hMrkYqyD3j@nvidia.com>

On Thu, Sep 03, 2026 at 08:09:55AM -0700, Nicolin Chen wrote:
> On Thu, Sep 03, 2026 at 03:15:27PM +0100, Kiryl Shutsemau wrote:
> > On Wed, Sep 02, 2026 at 10:22:31AM -0700, Nicolin Chen wrote:
> > > On Wed, Sep 02, 2026 at 01:17:23PM +0100, Kiryl Shutsemau (Meta) wrote:
> > > > +/**
> > > > + * arm_smmu_queue_max_n_shift() - pick the log2 depth of a queue
> > > > + * @hw_shift: log2 depth the hardware allows, capped for natural alignment
> > > > + * @ent_sz_shift: log2 of the queue entry size in bytes
> > > > + * @want: number of entries asked for, or zero to use @hw_shift
> > > > + *
> > > > + * @want is rounded down to a power of two. It never sizes a queue below one
> > > > + * page, because coherent DMA is page granular: a shallower queue occupies the
> > > > + * same memory as one that fills the page, and arm_smmu_init_one_queue() stops
> > > > + * shrinking at a page too.
> > > 
> > > Well, since we want the cmdq depth, why not name the parameter
> > > "max_cmdq_depth"? Then, no rounding and more straightforward.
> > 
> > The max_ prefix is better, thanks. cmdq_entries does not say it is a
> > ceiling.
> > 
> > On the units, the page floor has to stay whatever we call the parameter.
> > 
> > Ask for 8 entries and max_n_shift comes out as 3, which the
> > CMDQ_BATCH_ENTRIES check in arm_smmu_device_hw_probe() rejects with
> > -ENXIO. The floor gives you 256 entries on a 4K kernel instead of a failed
> > probe.
> > 
> > So log2 removes the rounding but not the flooring, and the number asked for
> > still is not always the number you get. I would rather keep entries than
> > make people convert.
> > 
> > The rounding is not silent, either: arm_smmu_init_one_queue() already
> > prints "allocated %u entries for cmdq", so the effective depth lands in
> > dmesg whichever unit the parameter takes.
> > 
> > On the name itself, "depth" reads to me as a number of entries rather than
> > its log2, so max_cmdq_depth=8 meaning 256 seems more surprising than the
> > rounding it replaces.
> 
> Well, maybe "cmdq_max_n_shift" is a better one over "depth".
> 
> Given CMDQ_BATCH_ENTRIES is used, I think cmdq_max_entries works.

cmdq_max_entries it is. Renamed for the next version.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
