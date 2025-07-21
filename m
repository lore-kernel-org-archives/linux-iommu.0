Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672915199A;
	Mon, 21 Jul 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117262; cv=none; b=IupwJVBGkUqXgf0WVgEd0x8AsYxo6xyq1vqhmZi2jG0s49AGZSwkl44qIo75HIZSxSQrt76QV+DGbossV5L1blsezFTVZH5Vqk/KwubU7xXRuujl040jt/hnx1yHvp8nNM3iDvYP0nKB+MdjnNErgyXS/ickA2+orsOGBumcCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117262; c=relaxed/simple;
	bh=h1oejTOcfn/FE2b+ejcQflWVFtGGLIORTNGbuq1sNOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4lHz/sOz3fcWIA4HPtJpVMn86iltU5WhHkgzhW6o17Gy3mglq8vqhc2cQ9lyih8WJIZXakRCSORQcrFAYHxxklrE0RslN2Wqa4GdNolpudKLkCpcUtj5wXJK4TFXjIr531h7LeHEAg/BAqEQ29qa0HPgU9GO88xT+i07cE6xhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUEzYCpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUEzYCpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D047CC4CEED;
	Mon, 21 Jul 2025 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753117261;
	bh=h1oejTOcfn/FE2b+ejcQflWVFtGGLIORTNGbuq1sNOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUEzYCpk6R0hOoLdylSHY9tzBvWrPk7MG4kTCcEuyTLuXsy5JbkpMw7I64vt8uJAt
	 QFQZigkgYTI0hFOk/H+Gx18kPZn7qsOtQ6MQdTygt+QDY1v9zGHnyPEBNO9ibWpWki
	 OOZsYOy1kjXnH5n/Jwo7PQyxmnJn/XmMyUVJtU9LBTgI1iwvPbysL7sztT8Iq+hh4o
	 0FpRNDxxuEzG6xEYzOIE0LejGHj/u7T/Rr5Tm3CE7zz5hs6yiehrTQj0QcIQ3E3A5w
	 e4nVjMb8VUM+BvOhw7L3iLfnrb0gYSyA+2WZrKaU2Q6t3CDWmG54JwayRUH1Q5faWg
	 yGE4xjbIXAVMQ==
Date: Mon, 21 Jul 2025 18:00:55 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <aH5yR9CkYSJ4PaZV@willie-the-truck>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
 <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
 <aHozv0NG1OBlAH6c@willie-the-truck>
 <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>
 <aHpQXy-bnwW56rCn@willie-the-truck>
 <20250718141401.GD2206214@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718141401.GD2206214@ziepe.ca>

On Fri, Jul 18, 2025 at 11:14:01AM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 18, 2025 at 02:47:11PM +0100, Will Deacon wrote:
> 
> > Just because the existing drivers are a mess doesn't mean we should
> > proliferate it!
> 
> If you want to insist on something here it should be for this driver
> to use the new generic page table code I've written.
> 
> Otherwise I don't see the point in trying to improve this in some
> lesser way.
> 
> If this had come in a years time I would probably insist on that, but
> right now it isn't merged yet and it will still be a little bit before
> people have time to review it.
> 
> Perhaps a compromise where Benjamin comes with an iommupt format
> header that works for this and we can progress this series and be
> ready to swap it out down the road?

I went back and applied the verisilicon patches locally so that I could
look at them side-by-side with the rockchip driver. Even then, setting
aside the generic page-table code (which I agree is premature to start
insisting on for new drivers), the callbacks for .default_domain_ops()
are very clearly doing the same thing:

.attach_dev:
	The two big differences are that (1) the VSI driver has two
	locks instead of one (and it makes me wonder about the RK
	locking in the IRQ handler and suspend/resume) and (2) the VSI
	hardware has a TLB flush register whereas the RK driver does
	a disable/enable cycle.

.map_pages:
	Basically the same but note that the RK driver _already_ has a
	hook in 'rk_ops' for decoding the DTE

.unmap_pages:
	The big difference here is that the RK driver has TLB
	invalidation whereas I don't think the VSI one does. Yes, it
	implements .flush_iotlb_all, but that's not used any more (and
	we should probably try to remove it again).

.iova_to_phys:
	Same comments as .map_pages.

.free:
	The only difference is that the VSI driver has to free its
	single-entry top-level (the "PTA").

and so moving these somewhere where they can be shared just seems like
the obvious, straightforward thing to do.

Will
