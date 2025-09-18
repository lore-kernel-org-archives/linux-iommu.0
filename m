Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60A2F3632;
	Thu, 18 Sep 2025 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237897; cv=none; b=tYHWrNDZWVXpSBFmoPrxN+zot/X078hIBkigReWbarFun09Ud7hG0zGc2nekwa4PYGYmtubvC41fKXbUgtuaYjK542HfoQBsIoDBkih9ujiOTD0I1UdbqEfn+M9UpnKGEinkWaViEl6wuGCHpp5Qn38d7J8VjI5Fq/+XQkx/q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237897; c=relaxed/simple;
	bh=QjWO+sp7P2+gDbJSVfkTtfrmPWYzC27O/isUi8PmKdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqUEmrC6ZGLnl9lrul/15OgOwOL0BRTjDQogZh2Ky1rLhRY7neD8TDXYa4CMAMlNizdsLy5QdR5+Nk4uBSDsgZRZqvSQxrs7eovXkyyFpXBzBRSZPWbgx/yESIuPPGpRwnlGZfyARzNWfOlCoPWV3WvzWkbbZCBRphUhs6oh9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bItQv63o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bItQv63o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A31C4CEE7;
	Thu, 18 Sep 2025 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758237897;
	bh=QjWO+sp7P2+gDbJSVfkTtfrmPWYzC27O/isUi8PmKdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bItQv63oair35nB+Eb5I0sTnTHtx5/GeJOKOUfjz2CiAO16KMm0FaoG2JV2Ys8Koy
	 wSQt7Ql80FplZ90kr8NONnhANcoy7gG7SjjZKeYTEvArhG1mpc/75bz3JnykVjx5y6
	 LsDQiVcSmbrBPEDeZlEs7MqpjePa5qNYLFbb2f3E5YWuyLAEQYgQrKfCV+NjaLjViz
	 Pz0UMQI/iir9J8ZdF/CmUIjHq1+K1nA3KbUqUtsB6r6wyyx7lLPT6ApyTvidKvZPWZ
	 +HdT4+O7q2qJ9pUkXD1DUEekXfxsNrS518oZ6qM99fBhJa+NZ5Sr83TNyZWEHCKXqc
	 7ORC87j3xGleA==
Date: Thu, 18 Sep 2025 17:24:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	Li Zhe <lizhe.67@bytedance.com>, Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <aMyUxqSEBHeHAPIn@kbusch-mbp>
References: <20250918214425.2677057-1-amastro@fb.com>
 <20250918225739.GS1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918225739.GS1326709@ziepe.ca>

On Thu, Sep 18, 2025 at 07:57:39PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 18, 2025 at 02:44:07PM -0700, Alex Mastro wrote:
> 
> > We anticipate a growing need to provide more granular access to device resources
> > beyond what the kernel currently affords to user space drivers similar to our
> > model.
> 
> I'm having a somewhat hard time wrapping my head around the security
> model that says your trust your related processes not use DMA in a way
> that is hostile their peers, but you don't trust them not to issue
> hostile ioctls..

I read this as more about having the granularity to automatically
release resources associated with a client process when it dies (as
mentioned below) rather than relying on the bootstrapping process to
manage it all. Not really about hostile ioctls, but that an ungraceful
ending of some client workload doesn't even send them.
 
> > - It would be nice if mappings created with the restricted IOMMU fd were
> >   automatically freed when the underlying kernel object was freed (if the client
> >   process were to exit ungracefully without explicitly performing unmap cleanup
> >   after itself).
> 
> Maybe the BPF could trigger an eventfd or something when the FD closes?

I wouldn't have considered a BPF dependency for this. I'll need to think
about that one for a moment.
