Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321051119D
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859193; cv=none; b=PC63a3nVSPyTHas2IzCNk4laZrg5a6uJKThp9PjnedbwJrX2tKm/3gfRwGxmzc9xNlIWVKJ60fcSM1ITvKrC0VdSoMksr2BnKJMkuEuGbXstDtiU1RbARrYg9yfAsHqWjU+3pR2A1j7KpzjbHvlLNGILY0imKmpbW8XBNMo9DiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859193; c=relaxed/simple;
	bh=EDE+d1HWNwaR3EzlZqUple1wfVpx2XGDlw7Sen94418=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K38btjIwmEqvm/1+CZu+Eu1WjL9mFgfNJOhDcc2MacgkisOX/gGlv63+KMtjiumiKTZL4SKjyPmOkzWG3amWskWRTwAJEg/VwLI7Ct3s6n01LyXUNbHuYiMzQeuH///+ysdnmc9MUi+8svXllkdh8/cpH6TCJd61xsVZHE6vj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjjfCKr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjjfCKr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8481F00A3A;
	Tue,  8 Sep 2026 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859192;
	bh=CianPnw9N8UEhhHcBMcHJ6evQxqMFmnummmTuv+mVuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fjjfCKr7d0EwMJbwoptdjEOWPGGL3ORBnxyOBHnPxp3HGX7ENnWnlfR8HZv2N7aNA
	 I8WTfZLu8olqvOMvHkImFimZgIgRQcfk19MmVWpU2SVFvy6UExjD4y7YQ7Xiel3ZHo
	 ybf9VyOBjA14uFeBJigQmpQnv+l1ilWkEdaXfwTzvYBEZxB+PkACryif5wGnG/Rje8
	 aQvW+5i+pf7/8xHT3OW3WnFc2b6O7/IqRLwA29jPi4TO/I9hG3Mh/PY9msil3FrgsS
	 0RLGJMO8BMDtAkma1Q+GE8jd/CvUvaT699zdEpxEJIE+8Sv2wdSLCrTGnNWFBmhlxq
	 ylrylgBvtiPpw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4AC1D198004A;
	Tue,  8 Sep 2026 05:19:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 08 Sep 2026 05:19:49 -0400
X-ME-Sender: <xms:MdOfai9Q_3IqAyvs-g_ObgC6qMshX6-zm2mvVMRxmaaAlfg9RvFhwA>
    <xme:MdOfah__D2UpzR46XUfimK9JVNoMRkR9tJXK953FlKhzz7deSCpOO7wrXqCjwc0xX
    jf5wIJ39K7EAdTmECnUmKIT28IbNDffiInUZKjOzKmtTbOCDRptkgU>
X-ME-Received: <xmr:MdOfakMP-rdzh_oX5WFeA46rm9K0yqatcr_R0krIc24VT4u0aAhizWuntCE>
X-ME-Proxy-Cause: dmFkZTFiAXmtBayfz5G9aXyEargjHBozBK8gKU5sB51WYdK0X/Q+hfwGVozywaREAJK34/
    QHGUiEPoaTC9mywDMCsyXg28jnGhf0iirWESM0EfNrd8/WmpPqVPLmo6Rw8kVuvTWPpUx9
    0o/C4b94Rr94gLy9aFMnFzdZ8KNwDH9wCKIjyRgmu35cNzcY5yYFB93LtkqwtbrfAzRX8h
    la89oeZT/ONuGoeC2gXpJ1isSNpq1pxbRIw7fOCpoKFW2+qS0KkSqTpTQoR6xYch1rR84V
    giXfBvfWpaLQ4mHx+6UB/mJTcjiIl6olxKDZy5LUCJvGyUOdM/d+oZ4biBeiGPwAV1Qpfo
    7Ih4vUV36FmCi6rqhHHsfmBd1xVmtA6B2zBxO7asqejZE7KCdfnjCIe6TN+LCOWipu1Q47
    K5BchGr35ZqnZbZ9gK3xZuuKuPn3HFDVJ7kResqdQhroX8QY/nkqwD7UODWp3jl3wgzncl
    SSuAetbpS5H8EKWQhyPLTmTnHxxoHccr8Ps0gnvTv76X5ogde2tYi9w96DDMwT0B9V9M6L
    oSjwqy3kREez81Mjh+AN7RN3b43CoHGDbWldO7NkpL0VU/XgE3/rIO+WAZVsB2HvjWDG50
    8H0m9H7hdQmzePKHZE8o70tHXyyq2e98QAk1SgKtUQnKzsja1HiK60dV2VVg
X-ME-Proxy: <xmx:MdOfalPq48biYqJp6XL4XGA-Z_7wbq8Jh_XLeY1rrnwCA8kVCgoe4Q>
    <xmx:MdOfaqMDWm9U8X8iUq7XFuqMbsPqH1oECWzGsDgdeEJ5hj8bc_DpLw>
    <xmx:MdOfakUdGxtDaym9TbXD2IgXJqfXoMbaWa7f7LyualfiYNlZ_j8Ing>
    <xmx:MdOfaqp6JOXdUIRmM-ziM8eitAbJHuUNlzX_fvAQ3xpWrAtDNTMChQ>
    <xmx:MdOfaic-4EprC7jtnqgD9LrOjkByJia5YgB109mJm3kGN8Rt-elVFbRr>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 05:19:45 -0400 (EDT)
Date: Tue, 8 Sep 2026 10:19:44 +0100
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
Message-ID: <ap_Rktiv5hms9IvH@thinkstation>
References: <20260907095835.1233352-1-kas@kernel.org>
 <20260907095835.1233352-2-kas@kernel.org>
 <ap8zCvk8zUPZAJpH@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap8zCvk8zUPZAJpH@nvidia.com>

On Mon, Sep 07, 2026 at 02:56:26PM -0700, Nicolin Chen wrote:
> On Mon, Sep 07, 2026 at 10:58:34AM +0100, Kiryl Shutsemau (Meta) wrote:
> 
> I still think that cmdq_max_n_shift can slightly tidy things here.
> 
> > +static u32 arm_smmu_queue_max_n_shift(u32 ceiling, u32 ent_sz_shift,
> > +				      u32 entries)
> 
> Here, all three inputs would have been "shifts", instead of two
> "shifts" and one "number of entries".
> 
> > +{
> > +	u32 floor = PAGE_SHIFT - ent_sz_shift;
> > +
> > +	if (!entries)
> > +		return ceiling;
> > +
> > +	return min(ceiling, max(ilog2(entries), floor));
> 
> And I see Sashiko keeps complaining against the ilog2 here:

It does build: GCC 15 and clang 21, at -O2 and -Os, without a warning.

But the reason is not obvious.

ilog2() on a runtime u32 returns int, and minmax.h only accepts an int
against a u32 when __is_nonneg() can prove it non-negative at compile
time.

__ilog2_u32() is fls(n) - 1, so that proof only exists because the
if (entries) guard lets the compiler see entries != 0 through the inlined
fls().

But this is fragile. If a compiler does not get there, or a later change
that moves the guard, it turns it into a BUILD_BUG_ON.

Rather than a max_t() cast, we can give the shift its type first:

	if (entries) {
		new_ceiling = ilog2(entries);
		new_ceiling = max(new_ceiling, floor);
	} else if (is_kdump_kernel()) {

Two u32s, nothing left for the compiler to prove, same result.

If it looks good, I can re-spin v6 with the change.

Thanks for the review and the test!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
