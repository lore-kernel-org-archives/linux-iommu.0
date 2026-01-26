Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21A33D6C7;
	Mon, 26 Jan 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437200; cv=none; b=BMolD8Q4QqYopWjJAP5QH2RFFmu+9Gi2NG77vB8X6DlTZNpdpJP1vZHuXjuScwWPUk01Uuwm0talAaY+xvtVOiPv5BXWJs4Cy3wBDFU7aL6x8hkFm/8UfKazCsYy7zFyNgNA+ZkhGWxpVBNNKELd+aie97f/9qiky6IZj7MVdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437200; c=relaxed/simple;
	bh=sPPiRmdOL/e6rzDCQ5LRGip0p4xN8/1HChx4Wbldl60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIunoqOBWCsAdTFWzTrJjAR0mmeGUVS/95CJIyfZJoi/0TUvWR7zUVBJVLwIkdwhBofnNXGmk0u4vrj1hnwIhDAReDTmmqt99HTXx4FW6VbI33vENEXgHAP42aR1UL9Yvz3fkcduK3LHdU4VwG7a1ND9Sl2m0LKbKnT0wUQEMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeCOVN70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeCOVN70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDAEC116C6;
	Mon, 26 Jan 2026 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769437200;
	bh=sPPiRmdOL/e6rzDCQ5LRGip0p4xN8/1HChx4Wbldl60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeCOVN70c303x0+vLQ+UEAqyzsoXtSvhj1NpJh12KJmgCLtinAJvksgPLSGqwRwix
	 uAaUU8Zv588m5/e9iNbhw1H0UPM5Hj0Yu3arWqR81DpL+X9UnJbA468hr8GjAUgdSy
	 DIxf/m+LugRJDQKNf1BpHJyLxd/W8VD/KLAYe0hmhOHtW3O/UMlXIK2LZgbbSFKS0b
	 cAXvZ6RyA1b/1nqY33e5o/5UG5q2qnJx0z18rlESpg8FvDwI5BKwu2oua8til4tedZ
	 kMfRnM+0MPgERjW3gvPuh2whEyo4OpcBGZkEl7qTYf5FnsKGsNQ8+P0MEKPK0/l2qf
	 L+M7HhIXKV2sQ==
Date: Mon, 26 Jan 2026 14:19:53 +0000
From: Will Deacon <will@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v11 3/7] iommu: Add verisilicon IOMMU driver
Message-ID: <aXd4CXE0fqWiKJXl@willie-the-truck>
References: <aWZui-rn5RDPwpEO@willie-the-truck>
 <68a49f8b-178c-4fa2-b4a9-315ad602271d@collabora.com>
 <aWeTQ50DOtntcniN@willie-the-truck>
 <db0950f1-b357-47c2-9829-e33262ab456d@collabora.com>
 <aW4kb5EbxbrhTOxK@willie-the-truck>
 <b8f43fe8-3e07-4d98-a50d-817c31370710@collabora.com>
 <aXDL2JH_4RCDmAJv@willie-the-truck>
 <4b33b50f-f0c3-4db8-b394-dd2d4d6e3a55@collabora.com>
 <aXOsdlGMVzhHOrUr@willie-the-truck>
 <8fd2c508-cbe9-4050-ba02-85b22fcff10d@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fd2c508-cbe9-4050-ba02-85b22fcff10d@collabora.com>

On Mon, Jan 26, 2026 at 10:03:19AM +0100, Benjamin Gaignard wrote:
> 
> Le 23/01/2026 à 18:14, Will Deacon a écrit :
> > On Wed, Jan 21, 2026 at 02:50:18PM +0100, Benjamin Gaignard wrote:
> > > Le 21/01/2026 à 13:51, Will Deacon a écrit :
> > > > On Mon, Jan 19, 2026 at 03:03:44PM +0100, Benjamin Gaignard wrote:
> > > > > > > > > > > +static const struct iommu_ops vsi_iommu_ops = {
> > > > > > > > > > > +	.identity_domain = &vsi_identity_domain,
> > > > > > > > > > > +	.release_domain = &vsi_identity_domain,
> > > > > > > > > > > +	.domain_alloc_paging = vsi_iommu_domain_alloc_paging,
> > > > > > > > > > > +	.of_xlate = vsi_iommu_of_xlate,
> > > > > > > > > > > +	.probe_device = vsi_iommu_probe_device,
> > > > > > > > > > > +	.release_device = vsi_iommu_release_device,
> > > > > > > > > > > +	.device_group = generic_single_device_group,
> > > > > > > > > > > +	.owner = THIS_MODULE,
> > > > > > > > > > > +	.default_domain_ops = &(const struct iommu_domain_ops) {
> > > > > > > > > > > +		.attach_dev		= vsi_iommu_attach_device,
> > > > > > > > > > > +		.map_pages		= vsi_iommu_map,
> > > > > > > > > > > +		.unmap_pages		= vsi_iommu_unmap,
> > > > > > > > > > > +		.flush_iotlb_all	= vsi_iommu_flush_tlb_all,
> > > > > > > > > > This has no callers and so your unmap routine appears to be broken.
> > > > > > > > > It is a leftover of previous attempt to allow video decoder to clean/flush
> > > > > > > > > the iommu by using a function from the API.
> > > > > > > > > Now it is using vsi_iommu_restore_ctx().
> > > > > > > > > I while remove it in version 12.
> > > > > > > > Don't you still need some invalidation on the unmap path?
> > > > > > > In vsi_iommu_unmap_iova() page is invalided by calling vsi_mk_pte_invalid().
> > > > > > But that just writes an invalid descriptor and doesn't appear to invalidate
> > > > > > the TLB at all.
> > > > > > 
> > > > > > > That clear BIT(0) so the hardware knows the page is invalid.
> > > > > > > Do I have miss something here ?
> > > > > > Yes, the TLB structure needs to be invalidated so that the page-table
> > > > > > walker sees the new value that you have written in memory.
> > > > > > 
> > > > > > The rockchip driver gets this correct...
> > > > > Rockchip hardware have a ZAP_ONE_LINE register which didn't exist on Verisilicon
> > > > > hardware.
> > > > Presumably you have some sort of Verisilicon datasheet or downstream driver
> > > > from which you can infer the TLB invalidation runes?
> > > I have only this downstream driver:
> > > https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/iommu/rockchip-iommu-av1d.c
> > > No datasheet...
> > > 
> > > > > I have tried to use VSI_MMU_BIT_FLUSH on VSI driver after unmapping iova
> > > > > but it doesn't work.
> > > > What do you mean by "doesn't work"? If it works without doing any
> > > > invalidation at all, then it's very peculiar that adding the invalidation
> > > > would introduce issues.
> > > I mean VSI_MMU_BIT_FLUSH register can't be used to invalid the TLB.
> > > I think the hardware iterates over the pages tables in memory and
> > > check the valid/invalid bit.
> > I bet it doesn't: that would be horrible for performance.
> > 
> > The hardware clearly has TLB invalidation support, as the downstream driver
> > that you linked above implements av1_iommu_flush_tlb_all() to poke it.
> > If the hardware has a TLB, then unmapping a page-table means you need to:
> > 
> > 1. Clear the valid bit from the descriptor in memory
> > 2. Have some sort of memory barrier
> > 3. Invalidate the TLB
> > 4. Wait for the invalidation to complete
> 
> That exactly what I had tried to do by calling vsi_iommu_flush_tlb_all() (minux the lock)
> after calling vsi_iommu_unmap_iova() in vsi_iommu_unmap() but that doesn't work
> and even make the system crash sometimes.

Then it sounds like you have some debugging to do...

I don't think we should elide the TLB invalidation just because you
couldn't get it to work.

Will
