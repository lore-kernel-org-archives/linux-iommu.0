Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AEBBA41
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 21:29:12 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E179E261BE3;
	Fri, 13 Jan 2023 22:29:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673645351;
	bh=tzuJaJssUMjZZ7WLqNeP+q104UEKVHyeooMwQQif+MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHPgiBWYU81GJ5qhc+lVhSrETIETFKjlBhBkoCRCPDaUfDtrFXBnJRws7ZU0vdcte
	 EVW68474RhBEjBV/l5J4NQJ+k07UVdL0g0iyUU5Vh/FEUXw3rlbYANAwnIhP2xdr4W
	 IzODCxuPkH8q8GnRuLbZ1rwcP0HvRlUtXGEZQJhuKpQAx0jhx3TEORgqL3YyLO5otX
	 R/kjFSbQkBCuErp402mUDSQG3Jb2BW9y+2Sfp+wb8dGxlzzt+wVunAReuSfJIfklb6
	 XDXUL6q3DHsml+OxtPu1+1dAJWzrEn+WyEM6QY+rU3IlYuBazzuHRkE1ecOxplH1C+
	 VdPJHghUzaabA==
Date: Fri, 13 Jan 2023 22:29:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Sven Peter <sven@svenpeter.dev>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Message-ID: <Y8HNJfz9R1IidJPq@8bytes.org>
References: <20230113185640.8050-1-joro@8bytes.org>
 <Y8GtFcNq2jugBpI3@ziepe.ca>
 <Y8GwHQLKnXyqa3Ty@8bytes.org>
 <Y8G06onFowE3ZIy8@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8G06onFowE3ZIy8@ziepe.ca>

On Fri, Jan 13, 2023 at 03:45:46PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 13, 2023 at 08:25:17PM +0100, Joerg Roedel wrote:
> > In general it is a good idea to at least compile-test every file that is
> > changed in a patch-set before sending it out and not rely on 0-day bot
> > for that.
> 
> Against every arch combination? This is why we have automation bots :(

No, not every combination. But if possible please compile-test each
changed file with a .config that pulls that source file in.  Lots of
drivers can be enabled just with COMPILE_TEST on x86 or be catched with
a generic ARM/ARM64 config which enables all IOMMU drivers.  PAMU is a
bit more difficult as it requires a PPC-32 bit config, but that is the
exception.

A full kernel build is usually also not necessary, often a 'make
drivers/iommu/' with a given config is enough.

That is also how I compile-test the IOMMU tree before I push changes
out. There are per-arch configurations which select all IOMMU drivers on
that arch. Only for X86 I do the full allnoconfig, defconfig,
allmodconfig and allyesconfig cycle (each for 32 and 64 bit).

That certainly does not catch everything, but a lot of compile issues can be
found that way. And for patch-sets only touching, for example, VT-d it
is still enough to only compile-test on x86. A patch-set touching that
much drivers is rather the exception.

Regards,

	Joerg
