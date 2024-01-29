Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A5605B1;
	Mon, 29 Jan 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530089; cv=none; b=hFSx1fo1tdnBQz4sBOJL9XV3I9KCoWicZ/gQ7m6wJMez+8ftKlKzAexzSZfI5iruh7C5ZwKNp+Aa0zN02YF3z/9iC6mDx/B8DW4E2T392N4vtLlMJpn0GS9DuEx54aheptlqzNu0Uhw+V3mvxXU8KBsG6YLawA1AdxJdeSpSbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530089; c=relaxed/simple;
	bh=ZSgQnY9x+TGPud1UGSLreEOuvi81q1Su0LFZw4pMw10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYMxkq+3c6b4I8ghhoDtGsE3DR0RV7HmyjfDOyuufvysRKqUBU6ulPS4FVAEOGEBFE2HM19AgIdTJWeg/3jED8qMN2qG7kPynR6eLjNYL0T1zUtPUJKEioWikojwiV+W5CH6CNZlKR7kvTHqYym0VVE2nwXlAYO7SJUcLwMO3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=lVBXrR3H; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="lVBXrR3H"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 54B6E600023E;
	Mon, 29 Jan 2024 12:07:58 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id ztBAk7UiNGkb; Mon, 29 Jan 2024 12:07:56 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 0C93E600140A;
	Mon, 29 Jan 2024 12:07:56 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1706530076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIZnwvHWrs2uKG8rpNN8P8JARGZ80yJYLIetzHJw+Zg=;
	b=lVBXrR3H6iICavTeTmDVrYPMSmc6K45SAGHoMCxz1l6cEswtFHuY63BVMfwAOvL/YPvZ8X
	XVQe2Wnh2N6UpFoj0w4m12VPqdkmyNwkIFyWWXEZImcbD6ijm5kblfh8fdtvthBOcVSLvQ
	xqkeYARM8j5CRY6wmfvVskcKl0YynXc=
Received: from diogo-gram (unknown [IPv6:2001:8a0:7ae3:e700:6be7:1f41:6784:a78])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 63AFD36007E;
	Mon, 29 Jan 2024 12:07:54 +0000 (WET)
Date: Mon, 29 Jan 2024 12:07:43 +0000
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com, 
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de, 
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev, regressions@lists.linux.dev, 
	diogo.ivo@tecnico.ulisboa.pt
Subject: Re: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Message-ID: <h3sokjn23q2xco2aje36ypz6ffcmmcz24qdyjj5madq4xeqbln@sjooz3ale3k6>
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <1754c86c-704e-4c80-93c3-1b75a9a247df@tecnico.ulisboa.pt>
 <20240126195142.GC50608@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126195142.GC50608@ziepe.ca>

On Fri, Jan 26, 2024 at 03:51:42PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 23, 2024 at 06:44:42PM +0000, Diogo Ivo wrote:
> 
> > Yes, this does fix the issue!
> 
> Thanks, just trying to pin down how the fix should be..
> 
> What kind of kernel are you running, 
> 
> Is this 32 bit?
> 
> Is CONFIG_ARM_DMA_USE_IOMMU set?
> 
> Is CONFIG_IOMMU_DMA set?
> 
> I'm guessing yes/yes/no?

It is a 64-bit kernel, CONFIG_ARM_DMA_USE_IOMMU=n and
CONFIG_IOMMU_DMA=y.

Diogo
