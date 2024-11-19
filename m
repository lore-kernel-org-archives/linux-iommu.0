Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561A12CDAE
	for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006993; cv=none; b=Ry+924PzG1xppBRBqJLH9tsgcNPN0OrmWiiVO62Svmpah3Byk9UZm9CSIDMFNeXxg590mJkcN0cefMNorKXfdOWfIIKO8n5az7gd0yn1QvvnFQckDCB17gTqfBJWMmthr6jaNF/48VhDVKDDSyOyPuaNJsNnZBRJ/ocNWhiKcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006993; c=relaxed/simple;
	bh=kliWiH/XjFe5HKBf2/Q5ywHZgX0r5UHfq5zk+goUIN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7fvisbJv8Iyg8yHX7GH84a/opw0dZhADf7JvGeiO9RUnjhbqq/UCmcrLZW/L1sL156WRDZLRw6+WhfcwnzdjccTzI8AXll2oJaznL2YIqKclJ72b1Yu4tRl/mxuhe0Sad4Eg6yWsLJOKsA7Ix4oId87on00DHQZBoWX+Xvwpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDWJDUSJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDWJDUSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DFC4CECF;
	Tue, 19 Nov 2024 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732006992;
	bh=kliWiH/XjFe5HKBf2/Q5ywHZgX0r5UHfq5zk+goUIN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDWJDUSJGzLZqhF5N5+LMBIY+6wGSDmfZh98sAvfPJ4Xjp6KLPmsrcHRsuEjf//aQ
	 g3p0Cv8saq09PuViiVz80NnD1S0KrWvYCqy+FgpAWspE4N8f0fGwuWZaAvenijXR7u
	 TiOLERl36t2qC3nkMQ4b82xdhIIT622qu36AK7ijkrWxWFmpfR7jBL8F8fejZwok6Q
	 NAkkuis29WVslQXjNsAKs5DyJFLp7lzpRBl5KK90BnuHV77kgedTOuEysmw1S/QHR4
	 xw+qcu9PiT9xKDeJKYOKGN0nPOzRjCcBtDNxai5rin48r10FVsFVzDUM5NdOc4UE8b
	 q9ICRNmBAFFXg==
Date: Tue, 19 Nov 2024 09:03:08 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <20241119090307.GA28466@willie-the-truck>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>
 <ZzdJAFc_8h6LfVL7@google.com>
 <Zze+VFpGNaXepFWC@Asurada-Nvidia>
 <20241118162442.GD35230@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118162442.GD35230@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 18, 2024 at 12:24:42PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 15, 2024 at 01:34:12PM -0800, Nicolin Chen wrote:
> > On Fri, Nov 15, 2024 at 01:13:36PM +0000, Pranjal Shrivastava wrote:
> > > On Tue, Nov 12, 2024 at 03:30:58PM -0800, Nicolin Chen wrote:
> > > > On Tue, Nov 12, 2024 at 08:30:16AM +0000, Pranjal Shrivastava wrote:
> > > > > +struct arm_smmu_event {
> > > > > +       u8                              stall           : 1,
> > > > > +                                       ssv             : 1,
> > > > > +                                       privileged      : 1,
> > > > > +                                       instruction     : 1,
> > > > > +                                       s2              : 1,
> > > > > +                                       read            : 1;
> > > > 
> > > > Feels odd to do so...should all of them be:
> > > > 	u8			name : 1;
> > > > ?
> > > 
> > > Hmmm, do you mean something like the following?
> > 
> > Never mind. I see amd_iommu_types.h does something just like that.
> 
> I certainly expect to see the u8 repeated and not use , for members of
> a structure. Also don't add excessive horizonal alignment.. C code is
> not excel. :)

I think the comma syntax is fine (there's precedence for it and it works),
but agreed on removing some of the tabs.

Will
