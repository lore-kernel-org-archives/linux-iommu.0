Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531B20B217
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736515054; cv=none; b=irIiHZuIPr0n+F/qrSmd6pY/D1ArcwLrztrsOyeHzpfhiaCJ5rSGPGwJbzHobTVCWBrwODTW5rMQHwSc2KkEjqLYxhbvFvw5Zp9psZVTwDeDYiuG9k/yu2+2TRuPK4u3CEE//YJ6QZ3E6IiCaf4eIKvZTKrwneSh8GIUmPcUYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736515054; c=relaxed/simple;
	bh=HnKCkv+F/eBhYiGxstel9I/HuqfmisPkkYY5fxoXMKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js6rd9QIC7hc5huAX7/Akqd27UVZcbMkpIcc+slWEa+YVDbEpUIw8CQ5EUn7HivU3gTAd6AFouK9NsGvVl+q3Ue2yQqv2bK25odZZpCFhslznVXQ3p++uwvs32QB0Ez2QuB8ycB+ITC5sp5A+BEy96ejTOL4GyHQR8OMkB5K/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLv/D79B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLv/D79B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA6DC4CED6;
	Fri, 10 Jan 2025 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736515052;
	bh=HnKCkv+F/eBhYiGxstel9I/HuqfmisPkkYY5fxoXMKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLv/D79BlUYvzrYw9iciTayUl6OYS/mXte6Pr55CPF5BDth2Xj0xWx++mVYiVO+pr
	 aJGIZKi4SetYD/2sK6VyyCc/vT6NI5CQhhmuoCmyTq851Z+t/ssRV+IoGkfiWqv+1N
	 4BrXBtFT0PUpwzSbJDkzzVCPpyyL1q6CWTBeA14cjEox6hATrP6VmfuFiZnXcf9oNQ
	 OqQtOnnzY2ZxsYD4UsjB9w55XpXFfKFNOrMsau+M70AKNTxE9VYaTC1nvIx9Q4+Yeb
	 YbvWCydYrtsca8JeSUIkZLbJaMf6VigFPc2Sx7a8Tu6hwiiHCB0zs6oeGFz4WEujic
	 sMLoOLBV0UhPQ==
Date: Fri, 10 Jan 2025 13:17:26 +0000
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
Message-ID: <20250110131725.GA11522@willie-the-truck>
References: <20250107165100.1093357-1-praan@google.com>
 <CGME20250110111804eucas1p2a5fa56e1a9fabbba5dacd4486517c9fe@eucas1p2.samsung.com>
 <d07e82a4-2880-4ae3-961b-471bfa7ac6c4@samsung.com>
 <20250110125342.GA11431@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110125342.GA11431@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 10, 2025 at 12:53:43PM +0000, Will Deacon wrote:
> On Fri, Jan 10, 2025 at 12:18:02PM +0100, Marek Szyprowski wrote:
> > On 07.01.2025 17:51, Pranjal Shrivastava wrote:
> > > Adopt the `str_read_write` helper in event logging as highlighted [1].
> > >
> > > [1] https://lore.kernel.org/all/20250107130053.GC6991@willie-the-truck/
> > >
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > 
> > This change landed in today's linux-next as commit f2c77f6e41e6 
> > ("iommu/arm-smmu-v3: Use str_read_write helper w/ logs"). It fails to 
> > build here with arm64/defconfig on my setup. It looks that it misses to 
> > add the following include:
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 0e4cbb2c64d7..a0e395da8a88 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -26,6 +26,7 @@
> >   #include <linux/pci.h>
> >   #include <linux/pci-ats.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/string_choices.h>
> >   #include <kunit/visibility.h>
> >   #include <uapi/linux/iommufd.h>
> 
> Hmm, I build and test my branches before I push them so this is a bit
> surprising. I just confirmed that it's building with arm64/defconfig
> for me, so lemme dig into this some more...

Aha, there seems to be a transitive include of string_choices.h via
linux/acpi.h. So while I still think the arm64 defconfig should build,
if I go in and disable CONFIG_ACPI then I see the failure.

So for my test builds:
allnoconfig:	Builds as there isn't an SMMU driver
defconfig:	Builds because CONFIG_ACPI=y
allmodconfig:	Same as above

I'll add the missing #include.

Will
