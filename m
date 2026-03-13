Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E743CCA00;
	Fri, 13 Mar 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421040; cv=none; b=BLNr9Lbx+lzyR/mLFE10s0xG5JJqxV2S67SXrLpBOFRyo3loUEVTmf+Z2mZc1/d7A+uPzbSJopmAFQmIXSrya74KkO0gEC0lGzfHkygZC6t4eVGmDLY3+zW7omn3yfgzxfYbzq6nXtPkdjo5CEQnS1xRhn2k4Yon7Erksg02KN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421040; c=relaxed/simple;
	bh=NlyHnEVF00lgfFMdsYoT0oz0mXXnOI6++6hQTHAsR/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8AA8uIj/0/q0buTofmAd1AwE/85Kxoisc7i5e4tnGGgfwt0Wl1irl/I2nBwranFhu3na3OVRvMhX5ER7lXroTRVWR2jUNgyOdOX+uX+j5nMdSra9ZNQ/yhK0ZUaqdhG3t6yEdQbj4awSN9KlZeuE6d2QahTNEaX2w2UxjnoRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgHocwGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgHocwGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D0EC19421;
	Fri, 13 Mar 2026 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773421040;
	bh=NlyHnEVF00lgfFMdsYoT0oz0mXXnOI6++6hQTHAsR/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DgHocwGihLgUIzfEh74WnXAr8c5JROD/DIFbHV7SzajJAbvK7Qw3yhvhXuLMBO3LM
	 5Wt9miiEhrqJF22unrexhD1HPE7U291LJhYlfNtVDT98P9JvXLplLSjIEvuaR2z6nO
	 HE32GGP4nuIS3UgqnA1h0rhxhD/D/HPDRmThM9m3M4gfdxesm1cvnPWIIcbCxUPpsm
	 TcwWe7fcovYQ+2C6a4DWJUEy3CtcRjSAkXG+A0daLe9hGKPBv9fZk9DyB4ENLSsJhI
	 sAqLPwh94jbEg/3j+YPCXx4ymGC0GLLbgfZUb2yGquVy1yI2JMSNdwmC+Gg7mYBn0u
	 t6zruKkO10jbQ==
Date: Fri, 13 Mar 2026 16:57:14 +0000
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 2/2] [RFC] iommu: io-pgtable-arm-v7s: avoid gcc-16.0.1
 section mismatch
Message-ID: <abRB6g-48ZX6Yl2r@willie-the-truck>
References: <20260203162406.2215716-1-arnd@kernel.org>
 <20260203162406.2215716-2-arnd@kernel.org>
 <abBJj72kLQb0LRJB@willie-the-truck>
 <3eab12fd-31d3-4a41-a0d9-61b0f6c8ada3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eab12fd-31d3-4a41-a0d9-61b0f6c8ada3@app.fastmail.com>

On Tue, Mar 10, 2026 at 08:26:40PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 10, 2026, at 17:40, Will Deacon wrote:
> > On Tue, Feb 03, 2026 at 05:24:00PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> gcc-16 has gained some more advanced inlining techniques that enable
> >> it to inline the dummy_tlb_add_page() and dummy_tlb_flush() function
> >> pointers into a specialized version of __arm_v7s_unmap:
> >> 
> >> WARNING: modpost: vmlinux: section mismatch in reference: __arm_v7s_unmap+0x2cc (section: .text) -> dummy_tlb_add_page (section: .init.text)
> >> 
> >> From what I can tell, the transformation is correct, as this
> >> is only called when __arm_v7s_unmap() is called from
> >> arm_v7s_do_selftests(), which is also __init.
> >> 
> >> I have not come up with a good workaround, so this simply marks
> >> dummy_tlb_add_page() as not __init. Since there are currently only two
> >> files where this happens, that may be an easy way out.
> >> 
> >> If anyone has a better idea for how to deal with that, let me know!
> >
> > Can we mark the dummy_* functions as 'noinline' instead? We shouldn't
> > have to keep the selftest code kicking around in memory after boot.
> 
> I think that would work as well, but I'd have to test it properly,
> as the gcc behavior was already not what I had expected.
> 
> Another option may be to take this a bit further and do the
> same for the arm_v7s selftest that Mostafa did in the lpae
> selftest with 7e06063a43d3 ("iommu/io-pgtable-arm-selftests:
> Use KUnit") and a3c24b6d7cd6 ("iommu/io-pgtable-arm-selftests:
> Modularize the test").
> 
> I think that would be the most logical step, but it's also
> beyond what I can do as a simple build fix.

tbh, I'm happy to take the noinline variant as a quick hack if it works.

Will
