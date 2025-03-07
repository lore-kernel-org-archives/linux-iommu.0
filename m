Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9221C16A;
	Fri,  7 Mar 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370572; cv=none; b=k4BG4tiy3VKMfTOU1ybkgr7i2uBGAx8MPCRBg5nrYsJmfayh0pvx9I4u/lNcsnWkoZLQKeEQzzgDTopNFm6sVBnkuK/cuRTdEgb42iwD0jvPd3cq1KB2uCon9Pk+tI2O2sZO/scRoXRHdd3BRS0htWMxlRpAAlkt79nvzjm8BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370572; c=relaxed/simple;
	bh=N0zVSCCePeRj851h0DkRdaxrX5UdPXvjK9vF34kZwQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa6E3cp0NON5p8s/GG/78OGDNK6ONznlIPBuQpsCWpSSUV3jl05Fad5zpVncZZyMRkGjWd/OKPnF21RKbgplhUZm/yTCD5gCuXr11lIW3/Qnin1DE9ISPOG8zpD9QKKG8cm45XQnKocdErBjJAPK6z7zpFCmiUOWPJdL+O10IjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TtSBlOD6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TtSBlOD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D350FC4CED1;
	Fri,  7 Mar 2025 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741370572;
	bh=N0zVSCCePeRj851h0DkRdaxrX5UdPXvjK9vF34kZwQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtSBlOD6sWUZUu4s5LxFWxfQOoDGytZZ5iYN+MWaINwQRwpmNZQDaoxlEEx/qeHKQ
	 4Velgeq6KXSPgamgmb13NkZg8LTxjPORQKv598BBinKp7QMxcIL/qiBj1b+tZmONyV
	 zQmAWSxsPYH4U86upMp2yHKmVpqIb2iRgk37cbC8=
Date: Fri, 7 Mar 2025 19:02:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <2025030721-synopsis-tubby-3b36@gregkh>
References: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
 <Z8qzP3CR8Quhp87Z@pollux>
 <20250307124809.GL354511@nvidia.com>
 <Z8rxm-BHldKqEwyp@phenom.ffwll.local>
 <20250307143821.GM354511@nvidia.com>
 <Z8stJXrDtA5tZB40@cassiopeiae>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8stJXrDtA5tZB40@cassiopeiae>

On Fri, Mar 07, 2025 at 06:30:13PM +0100, Danilo Krummrich wrote:
> On Fri, Mar 07, 2025 at 10:38:21AM -0400, Jason Gunthorpe wrote:
> Devres puts the pci::Bar in a Revocable and sets up the devres callback. Once
> the devres callback is called the embedded pci::Bar is dropped, which calls
> pci_iounmap() and pci_release_region().
> 
> Subsequently, the access to the pci::Bar for the owner of the Devres<pci::Bar>
> object is revoked, since the pointer to the memory mapping within the pci::Bar
> just became invalid.
> 
> The latter is the only additional step the Rust abstraction does, in order to
> not leave drivers with an invalid pointer. However, this additional safety
> aspect is *not* a change of the driver model itself.

Correct, it's one that the C driver model code wishes it could have :)

Danilo is totally right here.  There's many things "wrong" with the
driver model that we have today when dealing with resources that can
span multiple reference counted devices.  It's always been that way,
heck the original coding style document warned about that very thing way
back in the early 2000's!  The rust code here is a step forward in
making those issues go away, which is a good thing, and should not be
chastised because somehow it doesn't solve _all_ of our problems.

Let's try this out for now.  If it doesn't work out, great, we'll fix it
and update the drivers and move on.  It's not like we haven't been doing
that for the past 30+ years now, nothing different here at all.

thanks,

greg k-h
