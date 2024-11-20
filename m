Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679717BB2E
	for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096573; cv=none; b=fQJSyeufDUMR9c5C2upKtb+fmOSXObiSA8NElFxS2wpZyZg3oFD8kC1mGcU/0Li58GF60KEeuesTH6aYHAPBv+35zv37Ur1wgaUXFxZb0lD8p9MEvsInLc/oJKnrtjzB7LR7p7sVmXeODmcyKq5irLBgpltN0dPiGKimXl6REdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096573; c=relaxed/simple;
	bh=qz+scinseyG45iIVEu+XoWas+bToYNfEcBqwbFeC5Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSmRoqc01P1Tmryd4zVcI0ZC1Wk6E519Tn5vcOEjzAso9YlOWJZQaTEF+IpHlX3pDc8+1FcV/CqgrXhUpyGGjKKc8OkHNC4DUq1zdTEsQQLe+L3q0e0kAv3PGespfusbdvVVDXXKGwnwphUunovYT/6N9enBxeUMLEV6hCoYWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX0T1zlV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX0T1zlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149D7C4CECD;
	Wed, 20 Nov 2024 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732096573;
	bh=qz+scinseyG45iIVEu+XoWas+bToYNfEcBqwbFeC5Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rX0T1zlV5R8taULdAwvZPLC1h3GC14cYEe+Id49x9v/3Jo8BD83vuFXMxU4Vly0+S
	 d99HGWJ0x73mCpJPBe7gRuG1Kf+zNMKu5gL5j4kJGSXnvAfvyt3Xtabw4l4FYJHCgo
	 maoShoh8fF2l9A3+Oq7jv3L8KrSCP25RugvxJvknQHedhucop87K3IswgdmEBC7+Lf
	 M96VO0xjpeGB8auQ0VnCu7vPlc9NEgWUdlWXsudAgVisedkdF/+aSzogFh0CF0oWX2
	 6Rrvmk48xIcq+xxst+VrneBR6wrqa1LYyMP2kPUvjBOYxKz0oJSCKWiBUicMvRvBBC
	 5DJtYPcg7E2UQ==
Date: Wed, 20 Nov 2024 09:56:08 +0000
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <20241120095607.GA29295@willie-the-truck>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>
 <ZzdJAFc_8h6LfVL7@google.com>
 <Zze+VFpGNaXepFWC@Asurada-Nvidia>
 <20241118162442.GD35230@nvidia.com>
 <20241119090307.GA28466@willie-the-truck>
 <ZzxaE6yTt1QpFJz6@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzxaE6yTt1QpFJz6@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 19, 2024 at 09:27:47AM +0000, Pranjal Shrivastava wrote:
> On Tue, Nov 19, 2024 at 09:03:08AM +0000, Will Deacon wrote:
> > On Mon, Nov 18, 2024 at 12:24:42PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Nov 15, 2024 at 01:34:12PM -0800, Nicolin Chen wrote:
> > > > On Fri, Nov 15, 2024 at 01:13:36PM +0000, Pranjal Shrivastava wrote:
> > > > > On Tue, Nov 12, 2024 at 03:30:58PM -0800, Nicolin Chen wrote:
> > > > > > On Tue, Nov 12, 2024 at 08:30:16AM +0000, Pranjal Shrivastava wrote:
> > > > > > > +struct arm_smmu_event {
> > > > > > > +       u8                              stall           : 1,
> > > > > > > +                                       ssv             : 1,
> > > > > > > +                                       privileged      : 1,
> > > > > > > +                                       instruction     : 1,
> > > > > > > +                                       s2              : 1,
> > > > > > > +                                       read            : 1;
> > > > > > 
> > > > > > Feels odd to do so...should all of them be:
> > > > > > 	u8			name : 1;
> > > > > > ?
> > > > > 
> > > > > Hmmm, do you mean something like the following?
> > > > 
> > > > Never mind. I see amd_iommu_types.h does something just like that.
> > > 
> > > I certainly expect to see the u8 repeated and not use , for members of
> > > a structure. Also don't add excessive horizonal alignment.. C code is
> > > not excel. :)
> > 
> > I think the comma syntax is fine (there's precedence for it and it works),
> > but agreed on removing some of the tabs.
> 
> Ohh alright. I'm assuming both of you are referring to the tabs before
> the colon ':' ? 
> 
> As in, is the following fine?
> 
> struct arm_smmu_event {
>        u8		stall : 1,
> 			ssv : 1,
> 			privileged : 1,
> 			instruction : 1,
> 			s2 : 1,
> 			read : 1;
> 	.....

I was actually thinking of the whitespace between the 'u8' and the field
names. But this is silly nit-picking. Please just follow something like
the use of bitfields in 'struct perf_event_attr', as that's a readable
example of recent-ish in-tree code.

Ta,

Will
