Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E913DDAA
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743053958; cv=none; b=vCXkdmk9Svl9QN5+dMIj+eTnvYFHjitQoMUeETXixh3xzgITSTb4TfaqVcShILUSasBy8xvMj38r5kBeo+bGl2GLafgqr8UKrXYA2xkDHxhmlex9aSwCWgxQQBH2n+I1uZipZLZjDbPwr+kaR19ZCC8PCA+t1eet3cbAJEl9WLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743053958; c=relaxed/simple;
	bh=CAunss2v2b6mB2nYeE2eMRRbDuDsBqwc8pyaowwJ2g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HelW+ccbpqEloFXRV6K4O1fl2aI4HTqFooQrGkCA33xCfNz7Dz/CrjsaqyigOgiznSKEO+gjfXJdk9xjRRR4wo+tw2e+Sw8TjI/6qsiDvxiKQZ8Abe+myk0A2WNPCZS1prdIxkxopPsinFwyi8tZMJUfY/a7e46nev6nmbXoUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmX5iyNe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmX5iyNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E07DC4CEDD;
	Thu, 27 Mar 2025 05:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743053955;
	bh=CAunss2v2b6mB2nYeE2eMRRbDuDsBqwc8pyaowwJ2g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmX5iyNeIjc/0bENcWNqOClCK/fiaql9wWyI7m/CfBqTNbLZu2FGbLGKOS/BAibSV
	 wtal52edQ5gygPIuVnrDk0HqUqZe/0BwLm+ALq/2WNxDHcpzDbAMywPyullxwm7Kph
	 b5GGHZYXp9KOwAL8wxcJdSwZm0GOpNJIaQN6cDBGUh18V2NTdJCe6TpP53FhjAxFST
	 WsRW4dz10y/Fe9Jt97u6kLDjx9MfZNfQz8UgA0r2yNj3ymRUczNKo8cuHEFwvYjINO
	 GUHgjpv5SrEeeKI0oCVl2GQ7/lF55QgC5T5x+fVpLTlOkXEKhZlXDDx0h0LKtS91KA
	 FNquLwadWEcuQ==
Date: Wed, 26 Mar 2025 22:39:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>
Subject: Re: Regression on linux-next (next-20250321)
Message-ID: <sgetbac5ljzij2v54nmjuucioe4p6bhhn7kwm3bhn7hgkxi3gv@drfutbov4q4o>
References: <SJ1PR11MB61295789E25C2F5197EFF2F6B9A72@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <Z+Jd4GDIzCP5cBQE@nvidia.com>
 <Z+Ky9XsxHo/cECgr@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z+Ky9XsxHo/cECgr@nvidia.com>

On Tue, Mar 25, 2025 at 10:43:17AM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 25, 2025 at 12:40:16AM -0700, Nicolin Chen wrote:
> > 
> > On Tue, Mar 25, 2025 at 05:39:39AM +0000, Borah, Chaitanya Kumar wrote:
> > > Hello Nicolin,
> > > 
> > > Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> > > 
> > > This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> > > 
> > > Since the version next-20250321 [2], we are seeing the following regression
> > > 
> > > `````````````````````````````````````````````````````````````````````````````````
> > > <4>[    0.226495] Unpatched return thunk in use. This should not happen!
> > > <4>[    0.226502] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:3107 __warn_thunk+0x62/0x70
> > 
> > Hmm....I wonder why x86 can be affected...
> 
> I wonder if this is realted to the objtool warning Steven reported:
> 
> https://lore.kernel.org/linux-next/20250321193600.2bfe03bb@canb.auug.org.au/
> 
> vmlinux.o: warning: objtool: iommu_dma_get_msi_page() falls through to next function __iommu_dma_unmap()
> 
> I have no idea what either error means or how to fix it. AFAICT there
> is nothing special about this patch to trigger this?

Yeah, I'm fairly sure the boot warning is related to that objtool
warning.  I just posted a patch for that:

  https://lore.kernel.org/0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org

But also, we need to fix objtool to handle that warning more gracefully
so it doesn't trigger the boot failure.

-- 
Josh
