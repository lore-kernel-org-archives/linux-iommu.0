Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74F2F7EF9;
	Thu,  6 Aug 2026 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021238; cv=none; b=AnKO2MnW0sJQXaIHr+zAfkgE7SgNrb19Yoa4751G83txSU1TTMwlmC2uOL9sMNjrLxiF2U+lLEtgaTKEdNvFdenX3O3q0MOukq7Vc6/9PfiHB+0vwXahklrv1DwET6TaFffaveBXr7WT1efFNAMWcCbqRu8PsJnzWoBiBfTetds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021238; c=relaxed/simple;
	bh=VnKGLBjKLa1ViHCd9+00d1v2tcASVXRCUxALBKBo9lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVW4xv2U2Jm20jtbRruoWHj9mnMV56s3zFqnXg7gnMfMV22Fu9Fi6ogA75N0HkH0QumFnYqycIpERO03lRRndLrKx9RmTSSUi1rAZrQ1aCbSInWcj35uDVdg8giZiu4vwmjr5VMDioeAkuOJTiV5bJ74nzE4E1zfgrM1SmidlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a86oeqp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a86oeqp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E551F000E9;
	Thu,  6 Aug 2026 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021234;
	bh=mW/OuZ6mDAqPwiWKjJo6a74gpl79w+/96YfJnOrsAnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a86oeqp4RR3VHaJpTt4R9aiSI/uw/jdngWhLSd2xywYg+BiVfBYpQynxbLq654MRU
	 O0eRadyZulK73laweC/FpAtNgiIJQgHJdJFnaHTBjNnrblMOj60N2M91wUg+g7OVJC
	 B4v0KVk4P2V+RwWdSjexPi1bzKlWMRWkXQW82wlZvdWz78EIedX7kjxAroGNoiUiXc
	 8UURMYbrxTSFLK0DK7TKkezyaLdUnMTb3RgxoF0XMEi71Vf5TPw1FXBvR0dTbh/aq6
	 jBlYPIfOnCUn+I37wjoXKkbxkUDieYBRJQdFx3yC3uPNcmDt8xci5B52/40FIT3qM0
	 JoNnwfn81OOKQ==
Date: Thu, 6 Aug 2026 14:00:28 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kiryl Shutsemau <kas@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Pranjal Shrivastava <praan@google.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <anSFbIHnigVt_3bJ@willie-the-truck>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck>
 <20260804141704.GB27883@nvidia.com>
 <anINkO1l9Kz8lTVh@nvidia.com>
 <20260804161918.GG27883@nvidia.com>
 <anIXDd839UC/M2n/@nvidia.com>
 <20260804165905.GH27883@nvidia.com>
 <anIjwUVvfWOb9xa4@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIjwUVvfWOb9xa4@Asurada-Nvidia>

On Tue, Aug 04, 2026 at 10:39:13AM -0700, Nicolin Chen wrote:
> On Tue, Aug 04, 2026 at 01:59:05PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 04, 2026 at 09:45:01AM -0700, Nicolin Chen wrote:
> > > On Tue, Aug 04, 2026 at 01:19:18PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 04, 2026 at 09:04:32AM -0700, Nicolin Chen wrote:
> > > > > On Tue, Aug 04, 2026 at 11:17:04AM -0300, Jason Gunthorpe wrote:
> > > > > > On Tue, Aug 04, 2026 at 03:02:46PM +0100, Will Deacon wrote:
> > > > > > > > Would skipping their allocation when is_kdump_kernel() be acceptable on
> > > > > > > > its own, or would you rather see it done differently?
> > > > > > > 
> > > > > > > With Nicolin's patch, we can just avoid allocating the priq and the evtq
> > > > > > > entirely in the kdump case. We can then add a cmdline option to control
> > > > > > > the maximum size of the cmdq, which is useful regardless of kdump.
> > > > > > 
> > > > > > I would still prefer kdump do this re-sizing automatically, even if we
> > > > > > do add a commandline. It makes it easire to deploy than having to know
> > > > > > secret command lines :\
> > > > > > 
> > > > > > So functionally I still think this patch is fine, though yes it points
> > > > > > out more things in Nicolin's work too.
> > > > > 
> > > > > I will send a v10 of mine, to skip the EVTQ/PRIQ allocations.
> > > > 
> > > > I think Robin's point is to structure the v10 so you introduce a bunch
> > > > of tunables, including something like 0 size to disable a feature.
> > > >
> > > > Then have kdump default those tunables to the right thing
> > > 
> > > But in kdump, EVTQ/PRIQ are disabled, so my series should have
> > > skipped their allocations regardless of the tunables.
> > > 
> > > So, I think the tunables can be done in a separate series. And
> > > its use case might not be confined to kdump?
> > 
> > I think the ask is to do the tunables first and change your series to
> > default the tunables instead of doing direct kdump overrides.
> 
> You mean the driver can override the tunables to 0 in kdump mode,
> right?
> 
> Well, we are skipping a lot of things in kdump mode already; it's
> a very small change to skip EVTQ/PRIQ even without the tunables.
> 
> If Will prefers this merging sequence, I wouldn't mind changing my
> series to overriding the tunables.

I was thinking that the tunable would only apply to the cmdq. We can extend
it later if necessary, but since we're not going to enable the evtq/priq
in kdump mode at all, I don't think we need tunables for those atm.

I probably wouldn't make a size of 0 disable the queue, either. Have a
minimum size of a page or something like that.

Will
