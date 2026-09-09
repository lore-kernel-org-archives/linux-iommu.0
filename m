Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189B47606E
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947415; cv=none; b=r+QLMCnY0EGj8JSjB6w532BQl2cjRbSGK5L/kL3AP2ehg7Uv/fV766//d9k69zFxF8p4nNO2d+AlBHcZ/EY8RTImHlCGZDCAyFlCsPRtmag9LfirGP4/HVbcm3CU37os36D30WgQZUwJx2WhhP8k7LQ4fbMZPrAVjiidgXyJIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947415; c=relaxed/simple;
	bh=Bdj89/YHSWK3lxPOAMI4l1gCZBmpY8uTs8dJ4ZWnD7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buxkax59wq5BvdDPJL/xm2JeVLTZW61eKfOfWwhw8QxCiGzACjBoEZBhhHE0HpQwow3nDgElSATfVMMICJbvIHLFtQbqf1cwsDIyh2qECmVfdsWcOBZCTGJEGGOExcTJKUnCibTr+1mnVmYW6V9cxskxPBrYT/eVygevU+sQy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrHYJjAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrHYJjAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B0C1F00A3A;
	Wed,  9 Sep 2026 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788947413;
	bh=ApnG4gbQkWPzhtygCDB/k1nzV4DoinDV+hXxwsOMNyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WrHYJjAlk8lzvKRzLrZHSWJSIjAxbsCur2fRPSHmLqa56woiuepdifabrqQsLdFvj
	 +kSwWoZwfD7VYciPEW9J7q+UEWIPUrMYMBry/Lqxt3RGwN+9B6wXU6F7e2HIpbBL2h
	 iaqbna7Jf14qJeFWvNBbL5kSkbC/UrJII3ArPcl6avlfvwRrHZDFtFpk7n2b1q82Bv
	 Gvxs56ZEM84knNwDuYeymu1k02PF/8/njWW00cFiHtDWKWsKSAJ7n+1n7/7VkVSlbQ
	 FfAhbhWU7cukLucHLDcDu01NJVhVaOiGgpa8AWK/UqDRwqxE9veIUMHOelbOfJMqJn
	 Zg2U5zAnFaANQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 53081198004A;
	Wed,  9 Sep 2026 05:50:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 05:50:10 -0400
X-ME-Sender: <xms:ziuhajsMi9FPGjZrOGtzg7_eNL7EDsLpK4VnBkuvRCGwHRDJvT165Q>
    <xme:ziuhautvhjFpNOcfjnB8gnUSyf46AyreVfFAg2npHbYn0-7DEsUztQr6isGztNbuA
    294-hrti1w5-BWe8fCCA2qFbI09CGAu1-oZO9xZwD73vILpd54SjWLM>
X-ME-Received: <xmr:ziuhalt1s9J_INx7rg8QxEyZtlB4eQkqEwWZASGhjagvpPw4J5a6-T6YvOI>
X-ME-Proxy-Cause: dmFkZTFem7G3Ne1q6IC+vXmmQWHwDejS0VSp4tATdSPU4b0RTONhBMg4e3iWlREif2K+1O
    ebkHT2ZM86YIfVSA82RZXKKwiJ5j1/gPpqk1wVlj+hQQIEgXDd+gdU6dO4kCbxe5T4Vid7
    rjZhezuKsu8K1qhI3Q+j6B+G9qqMyuidQ+g80FjdeWDAlTsr2UcfzSTkrm7CGo34bLSAnb
    UNjz2PQ7/3rcFs32nDzNLG7teJoa+MyNk4tYSRgSHLoxe7OYfP20OMz6aruz3qUSdmJOGs
    aqhvdN/haL+CQENusNsZIPjdXOJxOwAsGMGWCSYZ9O0FVkbiyUMpWcl7I4+jlCYDd0Q6em
    +REN0PnxueCUm7yFWbmUTv0iQ/5MwlpqWkGfdls4KNjET2VJpRQHqVymaWWVBdaVd6mQmt
    lFaVI6uru/nAWLxIDLhfH9wPqeheNCXopCumDrxVKVLcXvdr8GrulsGVezh3jCBxFZzX6o
    RJbhfY/RbVDPoc1GvgONzAYT1FCNyYghdiZ+I/E3nPDOm6oJ/gl7tDbrvn8CWo2IGzbNYb
    iMqYb2NhvqvmaIyScjPXJgGXt67F3CgR3YBgGa0Nn1U+Pvn9I/qFBsVreNtN6kxAljSRao
    biepisuOQZuasTKARP3Mq6zFw2ZRvup/dMatBIxI812XLV6L91zZyX7aiCcQ
X-ME-Proxy: <xmx:ziuhap3Y-ylLYOPb-XbB9NXwkwz5JMJ7K494ehfgNdsSCqeDVs6zwQ>
    <xmx:ziuhaiJPRSjTeSFhR5W7wHUYNcrZuDlwUsHgqccaR9I6EAMeLgk9Yw>
    <xmx:ziuhaj-FXk3QALZLLBjQGV_ZQjlpD48SyOWLieKVXVZpF4km7o4mdA>
    <xmx:ziuhahhBslrFpnxCJf2CYirlBJ9YW3qLufRZ1f_qpMbL4pPL6D0ZCQ>
    <xmx:ziuhaixx5jQJebuSqQCzevDGobzoPUgXRkMlyNFTvfmAPBGH_yVilwsF>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:50:06 -0400 (EDT)
Date: Wed, 9 Sep 2026 10:50:05 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, 
	Usama Arif <usama.arif@linux.dev>, kernel-team@meta.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iommu/arm-smmu-v3: Add a cmdq_max_entries module
 parameter
Message-ID: <aqErsLREudADNSGS@thinkstation>
References: <20260907095835.1233352-1-kas@kernel.org>
 <20260907095835.1233352-2-kas@kernel.org>
 <ap8zCvk8zUPZAJpH@nvidia.com>
 <ap_Rktiv5hms9IvH@thinkstation>
 <aqCEhG6NA3Ho5noV@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqCEhG6NA3Ho5noV@nvidia.com>

On Tue, Sep 08, 2026 at 02:56:20PM -0700, Nicolin Chen wrote:
> On Tue, Sep 08, 2026 at 10:19:44AM +0100, Kiryl Shutsemau wrote:
> > On Mon, Sep 07, 2026 at 02:56:26PM -0700, Nicolin Chen wrote:
> > > On Mon, Sep 07, 2026 at 10:58:34AM +0100, Kiryl Shutsemau (Meta) wrote:
> > > 
> > > I still think that cmdq_max_n_shift can slightly tidy things here.
> > > 
> > > > +static u32 arm_smmu_queue_max_n_shift(u32 ceiling, u32 ent_sz_shift,
> > > > +				      u32 entries)
> > > 
> > > Here, all three inputs would have been "shifts", instead of two
> > > "shifts" and one "number of entries".
> > > 
> > > > +{
> > > > +	u32 floor = PAGE_SHIFT - ent_sz_shift;
> > > > +
> > > > +	if (!entries)
> > > > +		return ceiling;
> > > > +
> > > > +	return min(ceiling, max(ilog2(entries), floor));
> > > 
> > > And I see Sashiko keeps complaining against the ilog2 here:
> > 
> > It does build: GCC 15 and clang 21, at -O2 and -Os, without a warning.
> > 
> > But the reason is not obvious.
> > 
> > ilog2() on a runtime u32 returns int, and minmax.h only accepts an int
> > against a u32 when __is_nonneg() can prove it non-negative at compile
> > time.
> > 
> > __ilog2_u32() is fls(n) - 1, so that proof only exists because the
> > if (entries) guard lets the compiler see entries != 0 through the inlined
> > fls().
> > 
> > But this is fragile. If a compiler does not get there, or a later change
> > that moves the guard, it turns it into a BUILD_BUG_ON.
> > 
> > Rather than a max_t() cast, we can give the shift its type first:
> > 
> > 	if (entries) {
> > 		new_ceiling = ilog2(entries);
> > 		new_ceiling = max(new_ceiling, floor);
> > 	} else if (is_kdump_kernel()) {
> > 
> > Two u32s, nothing left for the compiler to prove, same result.
> > 
> > If it looks good, I can re-spin v6 with the change.
> 
> It looks probably okay.. though I still don't get why you aren't
> picking the straightforward "max_n_shift" over "max_entries".
> 
> max_n_shift is used by both HW and SW, and it does not have such
> converting problem or need min/max, making the code cleaner :-/

Okay, fair enough. max_n_shift it is. Will post v6.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
