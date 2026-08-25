Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988104052B5;
	Tue, 25 Aug 2026 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688546; cv=none; b=PwqH4VvpqKKKvSutgR6WcVPAddhS9ap/KcMXubIzDImM8l1pCngk0TiVGwFAqshuqgCY9o59IdWPIveLjThOLvH41tCxBZYLS9RgvmkVnJTvmYWgurPPy+8A3sYTNW1t9bMdlYh/e6+F7OIGgcGawhu5b/45cXfQ0pZITgc2wqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688546; c=relaxed/simple;
	bh=8YcmW6N+f4IDOVGu4ZV3bkM8onbaVQg/h/d8RPgiIwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8E+1tnYYSJuGFjIphRVJ41GqMzFItjKZ3blEQvsRngMIBB61Sey8oCtvuhe3GY+wOn1lu3V5Y0xBtbocP6QmIFlkpQ9WCtUp1o5IOGUSYEJTnLStgzGV6s9Q9axWuKjsWoqsfS7rzTwbTKk1zTRPgmkKd/kxLHqcJG4OH2SC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnehS4Kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnehS4Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DB1F000E9;
	Tue, 25 Aug 2026 20:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787688538;
	bh=+UVWWCrS7Z9braqaBJu/SYOmHoIkAvTjDiiMr9VZ9LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DnehS4KdP5yK86rMhajEVzIQvBNNdbmBiJg3g6QnHVqw+eqdnA/sY545wKraWnXQ/
	 IF3fqIU9TDgTooGgn7Zxui/IAr1cgLsf3sh1CnAwyl+sxMtqq9V4hPvwIW+VPKSx4y
	 dEgpQ5DELdeZHcuOZWyE9N7xcZ4yGrhDpHJpCNCAJcfcH7pcIbMVHWiPBYo0MInUyW
	 6JQ+GjGqxXgeH+sWC2j0h1qwZ3/bNowqs9SaFMeLPZ0sYRYhQUH+yNwSssMjh22rDn
	 SGM0EdFarsrTBdYf4C4hCEMH7QTvIgQsWdADbvwHHSsF2mkURwfCFhW6R2/CTvi4Fj
	 v1JAZ3AC0nT9A==
Date: Tue, 25 Aug 2026 16:08:56 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, praan@google.com, kevin.tian@intel.com, 
	smostafa@google.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3-kdump: Implement
 is_attach_deferred()
Message-ID: <20260825-jovial-uncovered-dogfish-430879@meerkat>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <eb795edf2598c6df57122cd5951393ac1a860bcd.1784663184.git.nicolinc@nvidia.com>
 <178735412602.18212.5709943748630447883.b4-review@b4>
 <aonng6MDJ/s/MRuE@nvidia.com>
 <20260822200226.GO244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260822200226.GO244917@nvidia.com>

On Sat, Aug 22, 2026 at 05:02:26PM -0300, Jason Gunthorpe wrote:
> > 
> > This is for !CONFIG_CRASH_DUMP case. I think we need it.
> 
> Hmm, I am testing b4 review.. I had written
> 
> #define arm_smmu_kdump_is_attach_deferred NULL
> 
> ?
> 
> And I now realize b4 review drops lines starting with a #

I don't think that's intended -- I think the goal was to only drop leading
lines starting with # until the first non-# line is reached (i.e. the header).
I'll mark it as a bug.

-K
